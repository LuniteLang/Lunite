use crate::ast::{
    Block, EnumDecl, EnumVariant, Expression, ExternFunctionDecl, FunctionDecl, ImplDecl, Item,
    NativeFunctionDecl, Program, Statement, StructDecl, StructLayout, Type, Visibility, WhenArm,
    WhenPattern,
};
use crate::lexer::Lexer;
use crate::token::{Token, TokenKind};
use crate::CompileError;

#[derive(PartialEq, PartialOrd, Debug)]
enum Precedence {
    Lowest,
    Assign,
    PipePipe,
    AndAnd,
    Equals,
    BitOr,
    BitXor,
    BitAnd,
    LessGreater,
    Shift,
    Sum,
    Product,
    Prefix,
    Call,
    Index,
    Try,
    MemberAccess,
}

fn precedence_of(kind: &TokenKind) -> Precedence {
    match kind {
        TokenKind::PipePipe => Precedence::PipePipe,
        TokenKind::AndAnd => Precedence::AndAnd,
        TokenKind::EqualEqual | TokenKind::BangEqual => Precedence::Equals,
        TokenKind::Less | TokenKind::Greater | TokenKind::LessEqual | TokenKind::GreaterEqual => {
            Precedence::LessGreater
        }
        TokenKind::Plus | TokenKind::Minus => Precedence::Sum,
        TokenKind::Star | TokenKind::Slash | TokenKind::Percent => Precedence::Product,
        TokenKind::LessLess | TokenKind::GreaterGreater => Precedence::Shift,
        TokenKind::Ampersand => Precedence::BitAnd,
        TokenKind::Caret => Precedence::BitXor,
        TokenKind::Pipe => Precedence::BitOr,
        TokenKind::LParen => Precedence::Call,
        TokenKind::LBracket => Precedence::Index,
        TokenKind::Question => Precedence::Try,
        TokenKind::Dot => Precedence::MemberAccess,
        TokenKind::As => Precedence::Prefix,
        _ => Precedence::Lowest,
    }
}


pub struct Parser<'a> {
    lexer: Lexer<'a>,
    current_token: Token,
    peek_token: Token,
}

impl<'a> Parser<'a> {
    pub fn new(mut lexer: Lexer<'a>) -> Self {
        let current_token = lexer.next_token();
        let peek_token = lexer.next_token();
        Self {
            lexer,
            current_token,
            peek_token,
        }
    }

    fn next_token(&mut self) {
        self.current_token = self.peek_token.clone();
        self.peek_token = self.lexer.next_token();
    }

    fn cur_is(&self, kind: &TokenKind) -> bool {
        &self.current_token.kind == kind
    }
    fn peek_is(&self, kind: &TokenKind) -> bool {
        &self.peek_token.kind == kind
    }

    fn cur_error(&self, msg: &str) -> CompileError {
        CompileError {
            message: msg.to_string(),
            line: self.current_token.line,
            column: self.current_token.column,
        }
    }

    fn expect_identifier_string(&self) -> Result<String, CompileError> {
        if let TokenKind::Identifier(s) = &self.current_token.kind {
            Ok(s.clone())
        } else {
            let msg = format!(
                "Expected identifier, got {:?} at line {}, col {}",
                self.current_token.kind, self.current_token.line, self.current_token.column
            );
            Err(CompileError {
                message: msg,
                line: self.current_token.line,
                column: self.current_token.column,
            })
        }
    }

    fn skip_newlines(&mut self) {
        while self.cur_is(&TokenKind::Newline) || self.cur_is(&TokenKind::Semicolon) {
            self.next_token();
        }
    }

    pub fn parse_program(&mut self) -> Result<Program, CompileError> {
        let mut items = Vec::new();
        while !self.cur_is(&TokenKind::EOF) {
            self.skip_newlines();
            if self.cur_is(&TokenKind::EOF) {
                break;
            }
            items.push(self.parse_item()?);
            self.skip_newlines();
        }
        Ok(Program { items })
    }

    fn parse_item(&mut self) -> Result<Item, CompileError> {
        let mut visibility = Visibility::Private;
        if self.cur_is(&TokenKind::Pub) {
            visibility = Visibility::Public;
            self.next_token();
        }
        let is_pure = if self.cur_is(&TokenKind::Pure) {
            self.next_token();
            true
        } else {
            false
        };
        let mut layout = StructLayout::Aos;
        if self.cur_is(&TokenKind::Layout) {
            self.next_token();
            if !self.cur_is(&TokenKind::LParen) {
                return Err(self.cur_error("Expected '(' after layout"));
            }
            self.next_token();
            if self.cur_is(&TokenKind::Soa) {
                layout = StructLayout::Soa;
            } else {
                return Err(self.cur_error("Expected 'soa'"));
            }
            self.next_token();
            if !self.cur_is(&TokenKind::RParen) {
                return Err(self.cur_error("Expected ')'"));
            }
            self.next_token();
        }
        
        self.skip_newlines();

        match self.current_token.kind {
            TokenKind::Import => self.parse_import_statement(),
            TokenKind::Extern => Ok(Item::ExternFunction(self.parse_extern_function_decl()?)),
            TokenKind::Native => Ok(Item::NativeFunction(
                self.parse_native_function_decl(visibility)?,
            )),
            TokenKind::Fn => Ok(Item::Function(
                self.parse_function_decl(visibility, is_pure)?,
            )),
            TokenKind::Struct => Ok(Item::Struct(self.parse_struct_decl(visibility, layout)?)),
            TokenKind::Enum => Ok(Item::Enum(self.parse_enum_decl(visibility)?)),
            TokenKind::Impl => self.parse_impl_item(),
            _ => Err(self.cur_error(&format!(
                "Expected declaration, got {:?}",
                self.current_token.kind
            ))),
        }
    }

    fn parse_extern_function_decl(&mut self) -> Result<ExternFunctionDecl, CompileError> {
        self.next_token(); // extern
        if !self.cur_is(&TokenKind::Fn) {
            return Err(self.cur_error("Expected 'fn' after 'extern'"));
        }
        self.next_token(); // fn
        let name = self.expect_identifier_string()?;
        self.next_token();
        let generic_params = if self.cur_is(&TokenKind::Less) {
            let gp = self.parse_generic_params()?;
            self.next_token();
            gp
        } else {
            vec![]
        };
        if !self.cur_is(&TokenKind::LParen) {
            return Err(self.cur_error("Expected '('"));
        }
        let params = self.parse_function_params()?;
        let return_type = if self.cur_is(&TokenKind::Arrow) {
            self.next_token();
            let t = self.parse_type()?;
            self.next_token();
            t
        } else {
            Type::Void
        };
        Ok(ExternFunctionDecl {
            name,
            generic_params,
            params,
            return_type,
        })
    }

    fn parse_enum_decl(&mut self, visibility: Visibility) -> Result<EnumDecl, CompileError> {
        self.next_token(); // enum
        let name = self.expect_identifier_string()?;
        self.next_token();
        let generic_params = if self.cur_is(&TokenKind::Less) {
            let gp = self.parse_generic_params()?;
            self.next_token();
            gp
        } else {
            vec![]
        };

        self.skip_newlines();
        if !self.cur_is(&TokenKind::LBrace) {
            return Err(self.cur_error("Expected '{' after enum name"));
        }
        self.next_token(); // {

        let mut variants = Vec::new();
        while !self.cur_is(&TokenKind::RBrace) && !self.cur_is(&TokenKind::EOF) {
            self.skip_newlines();
            if self.cur_is(&TokenKind::RBrace) {
                break;
            }

            let v_name = self.expect_identifier_string()?;
            self.next_token();

            let mut v_type = None;
            if self.cur_is(&TokenKind::LParen) {
                self.next_token(); // (
                v_type = Some(self.parse_type()?);
                self.next_token(); // consume type
                if !self.cur_is(&TokenKind::RParen) {
                    return Err(self.cur_error("Expected ')' after variant type"));
                }
                self.next_token(); // )
            }

            variants.push(EnumVariant {
                name: v_name,
                typ: v_type,
            });

            if self.cur_is(&TokenKind::Comma) {
                self.next_token();
            }
            self.skip_newlines();
        }

        if !self.cur_is(&TokenKind::RBrace) {
            return Err(self.cur_error("Expected '}'"));
        }
        self.next_token(); // }

        Ok(EnumDecl {
            name,
            generic_params,
            variants,
            visibility,
        })
    }

    fn parse_native_function_decl(
        &mut self,
        visibility: Visibility,
    ) -> Result<NativeFunctionDecl, CompileError> {
        self.next_token(); // native
        if !self.cur_is(&TokenKind::Fn) {
            return Err(self.cur_error("Expected 'fn' after 'native'"));
        }
        self.next_token(); // fn
        let name = self.expect_identifier_string()?;
        self.next_token();
        let generic_params = if self.cur_is(&TokenKind::Less) {
            let gp = self.parse_generic_params()?;
            self.next_token();
            gp
        } else {
            vec![]
        };
        if !self.cur_is(&TokenKind::LParen) {
            return Err(self.cur_error("Expected '('"));
        }
        let params = self.parse_function_params()?;
        let return_type = if self.cur_is(&TokenKind::Arrow) {
            self.next_token();
            let t = self.parse_type()?;
            self.next_token();
            t
        } else {
            Type::Void
        };
        Ok(NativeFunctionDecl {
            name,
            generic_params,
            params,
            return_type,
            visibility,
        })
    }

    fn parse_import_statement(&mut self) -> Result<Item, CompileError> {
        self.next_token(); // import
        let path = if let TokenKind::String(s) = self.current_token.kind.clone() {
            s
        } else {
            return Err(self.cur_error("Expected string for path"));
        };
        self.next_token(); // consume string
        let mut alias = None;
        if self.cur_is(&TokenKind::As) {
            self.next_token();
            alias = Some(self.expect_identifier_string()?);
            self.next_token();
        }
        Ok(Item::Import { path, alias })
    }

    fn parse_struct_decl(
        &mut self,
        visibility: Visibility,
        layout: StructLayout,
    ) -> Result<StructDecl, CompileError> {
        self.next_token(); // struct
        let name = self.expect_identifier_string()?;
        self.next_token();
        let generic_params = if self.cur_is(&TokenKind::Less) {
            let gp = self.parse_generic_params()?;
            self.next_token();
            gp
        } else {
            vec![]
        };
        self.skip_newlines();
        if !self.cur_is(&TokenKind::LBrace) {
            return Err(self.cur_error("Expected '{'"));
        }
        self.next_token();
        let mut fields = Vec::new();
        while !self.cur_is(&TokenKind::RBrace) && !self.cur_is(&TokenKind::EOF) {
            self.skip_newlines();
            if self.cur_is(&TokenKind::RBrace) {
                break;
            }
            let mut vis = Visibility::Private;
            if self.cur_is(&TokenKind::Pub) {
                vis = Visibility::Public;
                self.next_token();
            }
            let fname = self.expect_identifier_string()?;
            self.next_token();
            if !self.cur_is(&TokenKind::Colon) {
                return Err(self.cur_error("Expected ':' after field name"));
            }
            self.next_token(); // consume :
            let typ = self.parse_type()?;
            self.next_token();
            fields.push((fname, typ, vis));
            if self.cur_is(&TokenKind::Comma) {
                self.next_token();
            }
            self.skip_newlines();
        }
        if self.cur_is(&TokenKind::RBrace) {
            self.next_token();
        }
        Ok(StructDecl {
            name,
            generic_params,
            fields,
            visibility,
            layout,
        })
    }

    fn parse_impl_item(&mut self) -> Result<Item, CompileError> {
        self.next_token(); // impl
        let generic_params = if self.cur_is(&TokenKind::Less) {
            let gp = self.parse_generic_params()?;
            self.next_token();
            gp
        } else {
            vec![]
        };
        let struct_name = self.expect_identifier_string()?;
        self.next_token();
        if self.cur_is(&TokenKind::Less) {
            let _ = self.parse_type_arguments()?;
            self.next_token();
        }
        self.skip_newlines();
        if !self.cur_is(&TokenKind::LBrace) {
            return Err(self.cur_error("Expected '{'"));
        }
        self.next_token();
        let mut methods = Vec::new();
        while !self.cur_is(&TokenKind::RBrace) && !self.cur_is(&TokenKind::EOF) {
            self.skip_newlines();
            if self.cur_is(&TokenKind::RBrace) {
                break;
            }
            let mut vis = Visibility::Private;
            if self.cur_is(&TokenKind::Pub) {
                vis = Visibility::Public;
                self.next_token();
            }
            let is_p = if self.cur_is(&TokenKind::Pure) {
                self.next_token();
                true
            } else {
                false
            };
            if !self.cur_is(&TokenKind::Fn) {
                return Err(self.cur_error("Expected fn"));
            }
            methods.push(self.parse_function_decl(vis, is_p)?);
            self.skip_newlines();
        }
        if self.cur_is(&TokenKind::RBrace) {
            self.next_token();
        }
        Ok(Item::Impl(ImplDecl {
            struct_name,
            generic_params,
            methods,
        }))
    }

    fn parse_function_decl(
        &mut self,
        visibility: Visibility,
        is_pure: bool,
    ) -> Result<FunctionDecl, CompileError> {
        self.next_token(); // fn
        let name = self.expect_identifier_string()?;
        self.next_token();
        let generic_params = if self.cur_is(&TokenKind::Less) {
            let gp = self.parse_generic_params()?;
            self.next_token();
            gp
        } else {
            vec![]
        };
        if !self.cur_is(&TokenKind::LParen) {
            return Err(self.cur_error("Expected '('"));
        }
        let params = self.parse_function_params()?;
        let return_type = if self.cur_is(&TokenKind::Arrow) {
            self.next_token();
            let t = self.parse_type()?;
            self.next_token();
            t
        } else {
            Type::Void
        };
        let mut contract = None;
        if self.cur_is(&TokenKind::Req) {
            self.next_token();
            contract = Some(self.parse_expression(Precedence::Lowest)?);
            self.next_token();
        }
        self.skip_newlines();
        let body = if self.cur_is(&TokenKind::FatArrow) {
            self.next_token();
            let e = self.parse_expression(Precedence::Lowest)?;
            self.next_token();
            Block {
                statements: vec![Statement::Return(Some(e))],
            }
        } else {
            self.parse_block()?
        };
        Ok(FunctionDecl {
            name,
            generic_params,
            params,
            return_type,
            body,
            visibility,
            is_pure,
            contract,
        })
    }

    fn parse_function_params(&mut self) -> Result<Vec<(String, Type, bool)>, CompileError> {
        self.next_token(); // (
        let mut params = Vec::new();
        while !self.cur_is(&TokenKind::RParen) {
            let is_m = if self.cur_is(&TokenKind::Mut) {
                self.next_token();
                true
            } else {
                false
            };
            let name = self.expect_identifier_string()?;
            self.next_token();
            if !self.cur_is(&TokenKind::Colon) {
                return Err(self.cur_error("Expected ':' after parameter name"));
            }
            self.next_token(); // consume :
            let typ = self.parse_type()?;
            self.next_token();
            params.push((name, typ, is_m));
            if self.cur_is(&TokenKind::Comma) {
                self.next_token();
            }
        }
        self.next_token(); // )
        Ok(params)
    }

    fn parse_block(&mut self) -> Result<Block, CompileError> {
        if !self.cur_is(&TokenKind::LBrace) {
            return Err(self.cur_error("Expected '{'"));
        }
        self.next_token(); // {
        let mut stmts = Vec::new();
        while !self.cur_is(&TokenKind::RBrace) && !self.cur_is(&TokenKind::EOF) {
            self.skip_newlines();
            if self.cur_is(&TokenKind::RBrace) {
                break;
            }
            stmts.push(self.parse_statement()?);
            self.skip_newlines();
        }
        if !self.cur_is(&TokenKind::RBrace) {
            return Err(self.cur_error("Expected '}'"));
        }
        self.next_token(); // }
        Ok(Block { statements: stmts })
    }

    fn parse_statement(&mut self) -> Result<Statement, CompileError> {
        if self.cur_is(&TokenKind::Let) {
            return self.parse_let_statement();
        }
        if self.cur_is(&TokenKind::Return) {
            return self.parse_return_statement();
        }
        if self.cur_is(&TokenKind::If) {
            return self.parse_if_statement();
        }
        if self.cur_is(&TokenKind::While) {
            return self.parse_while_statement();
        }
        if self.cur_is(&TokenKind::Try) {
            return self.parse_try_catch_statement();
        }
        if self.cur_is(&TokenKind::Throw) {
            return self.parse_throw_statement();
        }
        if self.cur_is(&TokenKind::When) {
            return self.parse_when_statement();
        }
        if self.cur_is(&TokenKind::Region) {
            return self.parse_region_statement();
        }
        if self.cur_is(&TokenKind::Spawn) {
            return self.parse_spawn_statement();
        }
        self.parse_expression_statement()
    }

    fn parse_spawn_statement(&mut self) -> Result<Statement, CompileError> {
        self.next_token(); // spawn
        let expr = self.parse_expression(Precedence::Lowest)?;
        self.next_token(); // consume last token
        if self.cur_is(&TokenKind::Semicolon) {
            self.next_token();
        }
        Ok(Statement::Spawn(expr))
    }

    fn parse_region_statement(&mut self) -> Result<Statement, CompileError> {
        self.next_token(); // region
        let body = self.parse_block()?;
        Ok(Statement::Region { body })
    }

    fn parse_when_statement(&mut self) -> Result<Statement, CompileError> {
        self.next_token(); // when

        // Subject with mandatory parentheses
        if !self.cur_is(&TokenKind::LParen) {
            return Err(self.cur_error("Expected '(' after when"));
        }
        self.next_token(); // (
        let subject = self.parse_expression(Precedence::Lowest)?;
        self.next_token(); // consume last token of expression
        if !self.cur_is(&TokenKind::RParen) {
            return Err(self.cur_error("Expected ')' after when subject"));
        }
        self.next_token(); // )

        self.skip_newlines();
        if !self.cur_is(&TokenKind::LBrace) {
            return Err(self.cur_error("Expected '{' after when subject"));
        }
        self.next_token(); // {

        let mut arms = Vec::new();
        while !self.cur_is(&TokenKind::RBrace) && !self.cur_is(&TokenKind::EOF) {
            self.skip_newlines();
            if self.cur_is(&TokenKind::RBrace) {
                break;
            }

            let pattern = self.parse_when_pattern()?;
            self.next_token();
            if !self.cur_is(&TokenKind::FatArrow) {
                return Err(self.cur_error("Expected '=>' after pattern"));
            }
            self.next_token(); // =>

            let body = if self.cur_is(&TokenKind::LBrace) {
                self.parse_block()?
            } else {
                let expr = self.parse_expression(Precedence::Lowest)?;
                self.next_token();
                Block {
                    statements: vec![Statement::Expr(expr)],
                }
            };

            arms.push(WhenArm { pattern, body });
            if self.cur_is(&TokenKind::Comma) {
                self.next_token();
            }
            self.skip_newlines();
        }

        if !self.cur_is(&TokenKind::RBrace) {
            return Err(self.cur_error("Expected '}'"));
        }
        self.next_token(); // }

        Ok(Statement::When { subject, arms })
    }

    fn parse_when_pattern(&mut self) -> Result<WhenPattern, CompileError> {
        if self.cur_is(&TokenKind::Else) {
            return Ok(WhenPattern::Else);
        }

        let mut current_name = String::new();
        if let TokenKind::Identifier(name) = &self.current_token.kind {
            current_name = name.clone();

            if self.peek_is(&TokenKind::Dot) || self.peek_is(&TokenKind::ColonColon) {
                if self.peek_is(&TokenKind::Dot) {
                    self.next_token(); // name
                    self.next_token(); // .
                    let member = self.expect_identifier_string()?;
                    current_name.push('.');
                    current_name.push_str(&member);
                }

                if self.peek_is(&TokenKind::ColonColon) {
                    let enum_name = current_name;
                    self.next_token(); // last part of name
                    self.next_token(); // ::
                    let variant_name = self.expect_identifier_string()?;

                    let mut binding = None;
                    if self.peek_is(&TokenKind::LParen) {
                        self.next_token(); // variant
                        self.next_token(); // (
                        binding = Some(self.expect_identifier_string()?);
                        self.next_token(); // binding
                        if !self.cur_is(&TokenKind::RParen) {
                            return Err(self.cur_error("Expected ')'"));
                        }
                    }
                    return Ok(WhenPattern::EnumVariant {
                        enum_name,
                        variant_name,
                        binding,
                    });
                }
            }
        }

        let expr = self.parse_expression(Precedence::Lowest)?;
        Ok(WhenPattern::Literal(expr))
    }

    fn parse_let_statement(&mut self) -> Result<Statement, CompileError> {
        self.next_token(); // let
        let is_m = if self.cur_is(&TokenKind::Mut) {
            self.next_token();
            true
        } else {
            false
        };
        let name = self.expect_identifier_string()?;
        self.next_token();
        let type_name = if self.cur_is(&TokenKind::Colon) {
            self.next_token();
            let t = self.parse_type()?;
            self.next_token();
            Some(t)
        } else {
            None
        };
        let mut val = None;
        if self.cur_is(&TokenKind::Equal) {
            self.next_token();
            val = Some(self.parse_expression(Precedence::Lowest)?);
            self.next_token();
        }
        Ok(Statement::Let {
            name,
            is_mutable: is_m,
            type_name,
            value: val,
        })
    }

    fn parse_if_statement(&mut self) -> Result<Statement, CompileError> {
        self.next_token(); // if
        let c = self.parse_expression(Precedence::Lowest)?;
        self.next_token();
        let t = self.parse_block()?;
        let mut e = None;
        self.skip_newlines();
        if self.cur_is(&TokenKind::Else) {
            self.next_token();
            if self.cur_is(&TokenKind::If) {
                e = Some(Block {
                    statements: vec![self.parse_if_statement()?],
                });
            } else {
                e = Some(self.parse_block()?);
            }
        }
        Ok(Statement::If {
            condition: c,
            then_branch: t,
            else_branch: e,
        })
    }

    fn parse_while_statement(&mut self) -> Result<Statement, CompileError> {
        self.next_token(); // while
        let c = self.parse_expression(Precedence::Lowest)?;
        self.next_token(); // move past condition
        let b = self.parse_block()?;
        Ok(Statement::While {
            condition: c,
            body: b,
        })
    }

    fn parse_try_catch_statement(&mut self) -> Result<Statement, CompileError> {
        self.next_token(); // try
        let t = self.parse_block()?;
        self.skip_newlines();
        if !self.cur_is(&TokenKind::Catch) {
            return Err(self.cur_error("Expected catch"));
        }
        self.next_token(); // catch
        let v = self.expect_identifier_string()?;
        self.next_token();
        let c = self.parse_block()?;
        Ok(Statement::TryCatch {
            try_block: t,
            catch_variable: v,
            catch_block: c,
        })
    }

    fn parse_throw_statement(&mut self) -> Result<Statement, CompileError> {
        self.next_token(); // throw
        let v = self.parse_expression(Precedence::Lowest)?;
        self.next_token();
        Ok(Statement::Throw { value: v })
    }

    fn parse_return_statement(&mut self) -> Result<Statement, CompileError> {
        self.next_token(); // return
        if self.cur_is(&TokenKind::Newline) || self.cur_is(&TokenKind::RBrace) {
            return Ok(Statement::Return(None));
        }
        let v = self.parse_expression(Precedence::Lowest)?;
        self.next_token();
        Ok(Statement::Return(Some(v)))
    }

    fn parse_expression_statement(&mut self) -> Result<Statement, CompileError> {
        let l = self.parse_expression(Precedence::Lowest)?;
        if self.peek_is(&TokenKind::Equal) {
            self.next_token();
            self.next_token();
            let r = self.parse_expression(Precedence::Lowest)?;
            self.next_token();
            Ok(Statement::Assign {
                lvalue: l,
                value: r,
            })
        } else {
            self.next_token();
            Ok(Statement::Expr(l))
        }
    }

    fn parse_type(&mut self) -> Result<Type, CompileError> {
        match self.current_token.kind.clone() {
            TokenKind::Int => Ok(Type::Int),
            TokenKind::Float => Ok(Type::Float),
            TokenKind::Bool => Ok(Type::Bool),
            TokenKind::StringType => Ok(Type::String),
            TokenKind::Void => Ok(Type::Void),
            TokenKind::Star => {
                self.next_token();
                Ok(Type::Pointer(Box::new(self.parse_type()?)))
            }
            TokenKind::LBracket => {
                self.next_token(); // [
                let inner = self.parse_type()?;
                self.next_token(); // consume inner
                if !self.cur_is(&TokenKind::Comma) {
                    return Err(self.cur_error("Expected ','"));
                }
                self.next_token(); // ,
                let size = if let TokenKind::IntLiteral(n) = self.current_token.kind {
                    n as u32
                } else {
                    return Err(self.cur_error("Expected size"));
                };
                self.next_token(); // size
                if !self.cur_is(&TokenKind::RBracket) {
                    return Err(self.cur_error("Expected ']'"));
                }
                Ok(Type::Array(Box::new(inner), size))
            }
            TokenKind::Identifier(mut n) => {
                // Check for Result and Option special types
                if n == "Result" && self.peek_is(&TokenKind::Less) {
                    self.next_token(); // move to <
                    self.next_token(); // move past <
                    let ok_type = self.parse_type()?;
                    self.next_token();
                    if !self.cur_is(&TokenKind::Comma) {
                        return Err(self.cur_error("Expected ',' in Result type"));
                    }
                    self.next_token(); // move past comma
                    let err_type = self.parse_type()?;
                    self.next_token();
                    if !self.cur_is(&TokenKind::Greater) {
                        return Err(self.cur_error("Expected '>' after Result types"));
                    }
                    return Ok(Type::Result(Box::new(ok_type), Box::new(err_type)));
                } else if n == "Option" && self.peek_is(&TokenKind::Less) {
                    self.next_token(); // move to <
                    self.next_token(); // move past <
                    let inner_type = self.parse_type()?;
                    self.next_token();
                    if !self.cur_is(&TokenKind::Greater) {
                        return Err(self.cur_error("Expected '>' after Option type"));
                    }
                    return Ok(Type::Option(Box::new(inner_type)));
                }

                while self.peek_is(&TokenKind::Dot) {
                    self.next_token();
                    self.next_token();
                    if let TokenKind::Identifier(suffix) = &self.current_token.kind {
                        n.push('.');
                        n.push_str(suffix);
                    } else {
                        return Err(self.cur_error("Expected identifier after dot"));
                    }
                }
                if self.peek_is(&TokenKind::Less) {
                    self.next_token(); // move to <
                    let args = self.parse_type_arguments()?;
                    if !self.cur_is(&TokenKind::Greater) {
                        return Err(self.cur_error("Expected '>' after generic type arguments"));
                    }
                    self.next_token(); // consume >
                    Ok(Type::Custom(n, args))
                } else {
                    Ok(Type::Custom(n, vec![]))
                }
            }
            _ => Err(self.cur_error("Expected type")),
        }
    }

    fn parse_generic_params(&mut self) -> Result<Vec<String>, CompileError> {
        self.next_token(); // <
        let mut params = Vec::new();
        params.push(self.expect_identifier_string()?);
        self.next_token();
        while self.cur_is(&TokenKind::Comma) {
            self.next_token();
            params.push(self.expect_identifier_string()?);
            self.next_token();
        }
        Ok(params)
    }

    fn parse_type_arguments(&mut self) -> Result<Vec<Type>, CompileError> {
        self.next_token(); // <
        let mut args = Vec::new();
        args.push(self.parse_type()?);
        self.next_token();
        while self.cur_is(&TokenKind::Comma) {
            self.next_token();
            args.push(self.parse_type()?);
            self.next_token();
        }
        Ok(args)
    }

    fn parse_expression(&mut self, prec: Precedence) -> Result<Expression, CompileError> {
        let mut left = self.parse_prefix()?;
        while !self.peek_is(&TokenKind::Newline)
            && !self.peek_is(&TokenKind::Semicolon)
            && !self.peek_is(&TokenKind::EOF)
            && prec < precedence_of(&self.peek_token.kind)
        {
            self.next_token();
            left = self.parse_infix(left)?;
        }
        Ok(left)
    }

    fn parse_prefix(&mut self) -> Result<Expression, CompileError> {
        match &self.current_token.kind {
            TokenKind::IntLiteral(n) => Ok(Expression::Int(*n)),
            TokenKind::FloatLiteral(n) => Ok(Expression::Float(*n)),
            TokenKind::String(s) => Ok(Expression::String(s.clone())),
            TokenKind::True => Ok(Expression::Boolean(true)),
            TokenKind::False => Ok(Expression::Boolean(false)),
            TokenKind::Null => Ok(Expression::Null),
            TokenKind::Identifier(_) => self.parse_identifier(),
            TokenKind::Minus | TokenKind::Bang => {
                let op = self.current_token.kind.clone();
                self.next_token();
                Ok(Expression::Unary {
                    operator: op,
                    right: Box::new(self.parse_expression(Precedence::Prefix)?),
                })
            }
            TokenKind::LParen => {
                self.next_token(); // (
                let e = self.parse_expression(Precedence::Lowest)?;
                self.next_token(); // move to )
                if !self.cur_is(&TokenKind::RParen) {
                    return Err(self.cur_error("Expected ')'"));
                }
                Ok(e)
            }
            TokenKind::LBracket => {
                self.next_token(); // [
                if self.cur_is(&TokenKind::RBracket) {
                    self.next_token();
                    return Ok(Expression::ArrayLiteral { elements: vec![] });
                }
                let first = self.parse_expression(Precedence::Lowest)?;
                self.next_token();
                if self.cur_is(&TokenKind::Semicolon) {
                    self.next_token();
                    let size_expr = self.parse_expression(Precedence::Lowest)?;
                    if !self.cur_is(&TokenKind::RBracket) {
                        self.next_token();
                    }
                    self.next_token(); // consume ]
                    let size = if let Expression::Int(n) = size_expr {
                        n as usize
                    } else {
                        return Err(self.cur_error("Size must be int"));
                    };
                    Ok(Expression::ArrayRepeat {
                        value: Box::new(first),
                        size,
                    })
                } else {
                    let mut elements = vec![first];
                    while self.cur_is(&TokenKind::Comma) {
                        self.next_token();
                        elements.push(self.parse_expression(Precedence::Lowest)?);
                        self.next_token();
                    }
                    if !self.cur_is(&TokenKind::RBracket) {
                        return Err(self.cur_error("Expected ']'"));
                    }
                    self.next_token();
                    Ok(Expression::ArrayLiteral { elements })
                }
            }
            TokenKind::Comptime => {
                self.next_token();
                let body = self.parse_block()?;
                Ok(Expression::Comptime { body })
            }
            TokenKind::Sizeof => {
                self.next_token();
                if !self.cur_is(&TokenKind::LParen) {
                    return Err(self.cur_error("Expected '('"));
                }
                self.next_token();
                let typ = self.parse_type()?;
                self.next_token();
                if !self.cur_is(&TokenKind::RParen) {
                    return Err(self.cur_error("Expected ')'"));
                }
                Ok(Expression::Sizeof(typ))
            }
            _ => Err(self.cur_error(&format!("No prefix for {:?}", self.current_token.kind))),
        }
    }

    fn parse_identifier(&mut self) -> Result<Expression, CompileError> {
        let n = self.expect_identifier_string()?;
        let mut expr = Expression::Identifier(n.clone());
        let mut current_path = n.clone();

        if self.peek_is(&TokenKind::Less) {
            self.next_token();
            match self.parse_type_arguments() {
                Ok(args) => {
                    if self.cur_is(&TokenKind::Greater) {
                        self.next_token(); // consume >
                        expr = Expression::GenericSpecialization {
                            expression: Box::new(expr),
                            type_args: args,
                        };
                    } else {
                        return Err(self.cur_error("Expected '>'"));
                    }
                }
                Err(e) => return Err(e),
            }
        }

        loop {
            // Handle turbofish syntax ::<T> by ignoring :: if < follows
            if self.peek_is(&TokenKind::ColonColon) && self.lexer.peek() == Some('<') {
                self.next_token(); // consume ::
                // Next iteration will handle < via peek_is(&TokenKind::Less)
                continue;
            }

            if self.peek_is(&TokenKind::Dot) {
                self.next_token();
                self.next_token();
                let f = self.expect_identifier_string()?;
                expr = Expression::MemberAccess {
                    object: Box::new(expr),
                    field: f.clone(),
                };
                current_path.push('.');
                current_path.push_str(&f);
                if self.peek_is(&TokenKind::Less) {
                    self.next_token();
                    match self.parse_type_arguments() {
                        Ok(args) => {
                            if self.cur_is(&TokenKind::Greater) {
                                expr = Expression::GenericSpecialization {
                                    expression: Box::new(expr),
                                    type_args: args,
                                };
                            } else {
                                return Err(self.cur_error("Expected '>'"));
                            }
                        }
                        Err(e) => return Err(e),
                    }
                }
                continue;
            }
            if self.peek_is(&TokenKind::ColonColon) {
                let enum_name = current_path.clone();
                self.next_token();
                self.next_token();
                let variant = self.expect_identifier_string()?;
                let mut value = None;
                if self.peek_is(&TokenKind::LParen) {
                    self.next_token(); // consume variant
                    self.next_token(); // (
                    value = Some(Box::new(self.parse_expression(Precedence::Lowest)?));
                    self.next_token();
                    if !self.cur_is(&TokenKind::RParen) {
                        return Err(self.cur_error("Expected ')'"));
                    }
                }
                let (_, type_args) = match expr {
                    Expression::GenericSpecialization { type_args, .. } => ((), type_args),
                    _ => ((), vec![]),
                };
                expr = Expression::EnumInit {
                    enum_name,
                    variant_name: variant,
                    value,
                    type_args,
                };
                break; // EnumInit is a terminal for identifier chain
            }
            if self.peek_is(&TokenKind::LBrace) {
                expr = self.parse_struct_init_with_generics(expr)?;
                continue;
            }
            break;
        }
        Ok(expr)
    }

    fn parse_struct_init_with_generics(
        &mut self,
        expr: Expression,
    ) -> Result<Expression, CompileError> {
        let (name, type_args) = match expr {
            Expression::Identifier(n) => (n, vec![]),
            Expression::GenericSpecialization {
                expression,
                type_args,
            } => {
                if let Expression::Identifier(n) = *expression {
                    (n, type_args)
                } else if let Expression::MemberAccess { .. } = *expression {
                    (self.expr_to_string(&*expression)?, type_args)
                } else {
                    return Err(self.cur_error("Invalid struct init"));
                }
            }
            Expression::MemberAccess { .. } => (self.expr_to_string(&expr)?, vec![]),
            _ => return Err(self.cur_error("Invalid struct init")),
        };
        if !self.cur_is(&TokenKind::LBrace) {
            self.next_token();
        }
        self.next_token(); // {
        let mut fields = Vec::new();
        while !self.cur_is(&TokenKind::RBrace) {
            self.skip_newlines();
            if self.cur_is(&TokenKind::RBrace) {
                break;
            }
            let fnm = self.expect_identifier_string()?;
            eprintln!("[PARSER] Found field: {}", fnm);
            self.next_token();
            if !self.cur_is(&TokenKind::Colon) {
                return Err(self.cur_error("Expected ':'"));
            }
            self.next_token();
            let fval = self.parse_expression(Precedence::Lowest)?;
            self.next_token();
            fields.push((fnm, fval));
            if self.cur_is(&TokenKind::Comma) {
                self.next_token();
            }
            self.skip_newlines();
        }
        if !self.cur_is(&TokenKind::RBrace) {
            return Err(self.cur_error("Expected '}'"));
        }
        Ok(Expression::StructInit {
            name,
            fields,
            type_args,
        })
    }

    fn expr_to_string(&self, expr: &Expression) -> Result<String, CompileError> {
        match expr {
            Expression::Identifier(n) => Ok(n.clone()),
            Expression::MemberAccess { object, field } => {
                let base = self.expr_to_string(object)?;
                Ok(format!("{}.{}", base, field))
            }
            _ => Err(self.cur_error("Invalid name")),
        }
    }

    fn parse_infix(&mut self, left: Expression) -> Result<Expression, CompileError> {
        let op = self.current_token.kind.clone();
        let pr = precedence_of(&op);
        match op {
            TokenKind::Plus
            | TokenKind::Minus
            | TokenKind::Star
            | TokenKind::Slash
            | TokenKind::Percent
            | TokenKind::EqualEqual
            | TokenKind::BangEqual
            | TokenKind::Less
            | TokenKind::Greater
            | TokenKind::LessEqual
            | TokenKind::GreaterEqual
            | TokenKind::LessLess
            | TokenKind::GreaterGreater
            | TokenKind::Ampersand
            | TokenKind::AndAnd
            | TokenKind::Pipe
            | TokenKind::PipePipe
            | TokenKind::Caret => {
                self.next_token();
                Ok(Expression::Binary {
                    left: Box::new(left),
                    operator: op,
                    right: Box::new(self.parse_expression(pr)?),
                })
            }
            TokenKind::LParen => {
                let mut args = Vec::new();
                if !self.peek_is(&TokenKind::RParen) {
                    self.next_token();
                    args.push(self.parse_expression(Precedence::Lowest)?);
                    self.next_token();
                    while self.cur_is(&TokenKind::Comma) {
                        self.next_token();
                        args.push(self.parse_expression(Precedence::Lowest)?);
                        self.next_token();
                    }
                } else {
                    self.next_token();
                }
                if !self.cur_is(&TokenKind::RParen) {
                    return Err(self.cur_error("Expected )"));
                }
                let (func_expr, t_args) = match left {
                    Expression::GenericSpecialization {
                        expression,
                        type_args,
                    } => (*expression, type_args),
                    _ => (left, vec![]),
                };
                Ok(Expression::Call {
                    function: Box::new(func_expr),
                    args,
                    type_args: t_args,
                })
            }
            TokenKind::Dot => {
                self.next_token();
                let f = self.expect_identifier_string()?;
                Ok(Expression::MemberAccess {
                    object: Box::new(left),
                    field: f,
                })
            }
            TokenKind::LBracket => {
                self.next_token();
                let index = self.parse_expression(Precedence::Lowest)?;
                self.next_token();
                if !self.cur_is(&TokenKind::RBracket) {
                    return Err(self.cur_error("Expected ']'"));
                }
                Ok(Expression::Index {
                    left: Box::new(left),
                    index: Box::new(index),
                })
            }
            TokenKind::As => {
                self.next_token();
                Ok(Expression::Cast {
                    expression: Box::new(left),
                    target_type: self.parse_type()?,
                })
            }
            TokenKind::Question => Ok(Expression::Try {
                expression: Box::new(left),
            }),
            _ => Err(self.cur_error("No infix")),
        }
    }
}
