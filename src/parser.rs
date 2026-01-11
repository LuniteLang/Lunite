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
        TokenKind::TokAs => Precedence::Prefix,
        _ => Precedence::Lowest,
    }
}

#[derive(Clone)]
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
            if self.cur_is(&TokenKind::EOF) {
                break;
            }
            self.next_token(); // move past the item
            self.skip_newlines();
        }
        Ok(Program { items })
    }

    fn parse_item(&mut self) -> Result<Item, CompileError> {
        let mut visibility = Visibility::Private;
        if self.cur_is(&TokenKind::TokPub) {
            visibility = Visibility::Public;
            self.next_token();
        }
        let is_pure = if self.cur_is(&TokenKind::TokPure) {
            self.next_token();
            true
        } else {
            false
        };
        
        self.skip_newlines();

        match self.current_token.kind {
            TokenKind::TokImport => self.parse_import_statement(),
            TokenKind::TokExtern => Ok(Item::ExternFunction(self.parse_extern_function_decl()?)),
            TokenKind::TokNative => Ok(Item::NativeFunction(
                self.parse_native_function_decl(visibility)?,
            )),
            TokenKind::TokFn => Ok(Item::Function(
                self.parse_function_decl(visibility, is_pure)?,
            )),
            TokenKind::TokStruct => Ok(Item::Struct(self.parse_struct_decl(visibility)?)),
            TokenKind::TokEnum => Ok(Item::Enum(self.parse_enum_decl(visibility)?)),
            TokenKind::TokImpl => self.parse_impl_item(),
            _ => Err(self.cur_error(&format!(
                "Expected declaration, got {:?}",
                self.current_token.kind
            ))),
        }
    }

    fn parse_extern_function_decl(&mut self) -> Result<ExternFunctionDecl, CompileError> {
        self.next_token(); // extern
        if !self.cur_is(&TokenKind::TokFn) {
            return Err(self.cur_error("Expected 'fn' after 'extern'"));
        }
        self.next_token(); // fn
        let name = self.expect_identifier_string()?;
        self.next_token();
        let generic_params = if self.cur_is(&TokenKind::Less) {
            let gp = self.parse_generic_params()?;
            self.next_token(); // move to '>'
            if !self.cur_is(&TokenKind::Greater) { return Err(self.cur_error("Expected '>'")); }
            self.next_token(); // move past '>'
            gp
        } else {
            vec![]
        };
        if !self.cur_is(&TokenKind::LParen) {
            return Err(self.cur_error("Expected '('"));
        }
        let params = self.parse_function_params()?;
        self.next_token(); // move past ')'
        let return_type = if self.cur_is(&TokenKind::Arrow) {
            self.next_token();
            let t = self.parse_type()?;
            self.next_token(); // move past type
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
            self.next_token(); // move to '>'
            if !self.cur_is(&TokenKind::Greater) { return Err(self.cur_error("Expected '>'")); }
            self.next_token(); // move past '>'
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
                self.next_token(); // move past type
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
        if !self.cur_is(&TokenKind::TokFn) {
            return Err(self.cur_error("Expected 'fn' after 'native'"));
        }
        self.next_token(); // fn
        let name = self.expect_identifier_string()?;
        self.next_token();
        let generic_params = if self.cur_is(&TokenKind::Less) {
            let gp = self.parse_generic_params()?;
            self.next_token(); // move to '>'
            if !self.cur_is(&TokenKind::Greater) { return Err(self.cur_error("Expected '>'")); }
            self.next_token(); // move past '>'
            gp
        } else {
            vec![]
        };
        if !self.cur_is(&TokenKind::LParen) {
            return Err(self.cur_error("Expected '('"));
        }
        let params = self.parse_function_params()?;
        self.next_token(); // move past ')'
        let return_type = if self.cur_is(&TokenKind::Arrow) {
            self.next_token();
            let t = self.parse_type()?;
            self.next_token(); // move past type
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
        let path = if let TokenKind::StringLiteral(s) = self.current_token.kind.clone() {
            s
        } else {
            return Err(self.cur_error("Expected string for path"));
        };
        
        let mut alias = None;
        if self.peek_is(&TokenKind::TokAs) {
            self.next_token(); // string -> as
            self.next_token(); // as -> identifier
            alias = Some(self.expect_identifier_string()?);
        }
        Ok(Item::Import { path, alias })
    }

    fn parse_struct_decl(
        &mut self,
        visibility: Visibility,
    ) -> Result<StructDecl, CompileError> {
        self.next_token(); // struct
        let name = self.expect_identifier_string()?;
        self.next_token();
        let generic_params = if self.cur_is(&TokenKind::Less) {
            let gp = self.parse_generic_params()?;
            self.next_token(); // move to '>'
            if !self.cur_is(&TokenKind::Greater) { return Err(self.cur_error("Expected '>'")); }
            self.next_token(); // move past '>'
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
            if self.cur_is(&TokenKind::TokPub) {
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
            self.next_token(); // move past type
            fields.push((fname, typ, vis));
            if self.cur_is(&TokenKind::Comma) {
                self.next_token();
            }
            self.skip_newlines();
        }
        if self.cur_is(&TokenKind::RBrace) {
            // STOP ON '}'
        }
        Ok(StructDecl {
            name,
            generic_params,
            fields,
            visibility,
            layout: StructLayout::Aos,
        })
    }

    fn parse_impl_item(&mut self) -> Result<Item, CompileError> {
        self.next_token(); // impl
        let generic_params = if self.cur_is(&TokenKind::Less) {
            let gp = self.parse_generic_params()?;
            self.next_token(); // move to '>'
            if !self.cur_is(&TokenKind::Greater) { return Err(self.cur_error("Expected '>'")); }
            self.next_token(); // move past '>'
            gp
        } else {
            vec![]
        };
        let struct_name = self.expect_identifier_string()?;
        self.next_token();
        if self.cur_is(&TokenKind::Less) {
            let _ = self.parse_type_arguments()?;
            self.next_token(); // move to '>'
            if !self.cur_is(&TokenKind::Greater) {
                 return Err(self.cur_error("Expected '>' after impl type args"));
            }
            self.next_token(); // move past '>'
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
            if self.cur_is(&TokenKind::TokPub) {
                vis = Visibility::Public;
                self.next_token();
            }
            let is_p = if self.cur_is(&TokenKind::TokPure) {
                self.next_token();
                true
            } else {
                false
            };
            if !self.cur_is(&TokenKind::TokFn) {
                return Err(self.cur_error("Expected fn"));
            }
            methods.push(self.parse_function_decl(vis, is_p)?);
            self.next_token(); // move past blocks '}'
            self.skip_newlines();
        }
        if self.cur_is(&TokenKind::RBrace) {
            // STOP ON '}'
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
            self.next_token(); // move to '>'
            if !self.cur_is(&TokenKind::Greater) { return Err(self.cur_error("Expected '>'")); }
            self.next_token(); // move past '>'
            gp
        } else {
            vec![]
        };
        if !self.cur_is(&TokenKind::LParen) {
            return Err(self.cur_error("Expected '('"));
        }
        let params = self.parse_function_params()?;
        self.next_token(); // move past ')'
        let return_type = if self.cur_is(&TokenKind::Arrow) {
            self.next_token();
            let t = self.parse_type()?;
            self.next_token(); // move past type
            t
        } else {
            Type::Void
        };
        self.skip_newlines();
        let body = self.parse_block()?;
        Ok(FunctionDecl {
            name,
            generic_params,
            params,
            return_type,
            body,
            visibility,
            is_pure,
            contract: None,
        })
    }

    fn parse_function_params(&mut self) -> Result<Vec<(String, Type, bool)>, CompileError> {
        self.next_token(); // (
        let mut params = Vec::new();
        while !self.cur_is(&TokenKind::RParen) {
            let is_m = if self.cur_is(&TokenKind::TokMut) {
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
            self.next_token(); // move past type
            params.push((name, typ, is_m));
            if self.cur_is(&TokenKind::Comma) {
                self.next_token();
            }
        }
        // STOP ON ')'
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
            self.next_token(); // ALWAYS move past the last token of the statement
            self.skip_newlines();
        }
        if !self.cur_is(&TokenKind::RBrace) {
            return Err(self.cur_error("Expected '}'"));
        }
        // Ends ON '}'
        Ok(Block { statements: stmts })
    }

    fn parse_statement(&mut self) -> Result<Statement, CompileError> {
        if self.cur_is(&TokenKind::TokLet) {
            return self.parse_let_statement();
        }
        if self.cur_is(&TokenKind::TokReturn) {
            return self.parse_return_statement();
        }
        if self.cur_is(&TokenKind::TokIf) {
            return self.parse_if_statement();
        }
        if self.cur_is(&TokenKind::TokWhile) {
            return self.parse_while_statement();
        }
        if self.cur_is(&TokenKind::TokTry) {
            return self.parse_try_catch_statement();
        }
        if self.cur_is(&TokenKind::TokThrow) {
            return self.parse_throw_statement();
        }
        if self.cur_is(&TokenKind::TokWhen) {
            return self.parse_when_statement();
        }
        self.parse_expression_statement()
    }

    fn parse_when_statement(&mut self) -> Result<Statement, CompileError> {
        self.next_token(); // when
        if !self.cur_is(&TokenKind::LParen) {
            return Err(self.cur_error("Expected '(' after when"));
        }
        self.next_token(); // (
        let subject = self.parse_expression(Precedence::Lowest)?;
        self.next_token(); // move past subject
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
            self.next_token(); // move to =>
            if !self.cur_is(&TokenKind::FatArrow) {
                return Err(self.cur_error("Expected '=>' after pattern"));
            }
            self.next_token(); // =>
            let body = if self.cur_is(&TokenKind::LBrace) {
                let b = self.parse_block()?;
                self.next_token();
                b
            } else {
                let expr = self.parse_expression(Precedence::Lowest)?;
                self.next_token();
                Block { statements: vec![Statement::Expr(expr)] }
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
        Ok(Statement::When { subject, arms })
    }

    fn parse_when_pattern(&mut self) -> Result<WhenPattern, CompileError> {
        if self.cur_is(&TokenKind::TokElse) {
            return Ok(WhenPattern::Else);
        }
        let mut current_name = String::new();
        if let TokenKind::Identifier(name) = &self.current_token.kind {
            current_name = name.clone();
            if self.peek_is(&TokenKind::Dot) || self.peek_is(&TokenKind::ColonColon) {
                if self.peek_is(&TokenKind::Dot) {
                    self.next_token(); self.next_token();
                    let member = self.expect_identifier_string()?;
                    current_name.push('.'); current_name.push_str(&member);
                }
                if self.peek_is(&TokenKind::ColonColon) {
                    let enum_name = current_name;
                    self.next_token(); self.next_token();
                    let variant_name = self.expect_identifier_string()?;
                    let mut binding = None;
                    if self.peek_is(&TokenKind::LParen) {
                        self.next_token(); self.next_token();
                        binding = Some(self.expect_identifier_string()?);
                        if !self.peek_is(&TokenKind::RParen) { return Err(self.cur_error("Expected ')'")); }
                        self.next_token();
                    }
                    return Ok(WhenPattern::EnumVariant { enum_name, variant_name, binding });
                }
            }
        }
        let expr = self.parse_expression(Precedence::Lowest)?;
        Ok(WhenPattern::Literal(expr))
    }

    fn parse_let_statement(&mut self) -> Result<Statement, CompileError> {
        self.next_token(); // let
        let is_m = if self.cur_is(&TokenKind::TokMut) { self.next_token(); true } else { false };
        let name = self.expect_identifier_string()?;
        self.next_token();
        let type_name = if self.cur_is(&TokenKind::Colon) {
            self.next_token();
            let t = self.parse_type()?;
            self.next_token();
            Some(t)
        } else { None };
        let mut val = None;
        if self.cur_is(&TokenKind::Equal) {
            self.next_token();
            val = Some(self.parse_expression(Precedence::Lowest)?);
        }
        Ok(Statement::Let { name, is_mutable: is_m, type_name, value: val })
    }

    fn parse_if_statement(&mut self) -> Result<Statement, CompileError> {
        self.next_token(); // if
        let c = self.parse_expression(Precedence::Lowest)?;
        self.next_token();
        let t = self.parse_block()?;
        let mut e = None;
        while self.peek_is(&TokenKind::Newline) {
            self.next_token();
        }
        if self.peek_is(&TokenKind::TokElse) {
            self.next_token(); self.next_token();
            if self.cur_is(&TokenKind::TokIf) {
                e = Some(Block { statements: vec![self.parse_if_statement()?] });
            } else {
                e = Some(self.parse_block()?);
            }
        }
        Ok(Statement::If { condition: c, then_branch: t, else_branch: e })
    }

    fn parse_while_statement(&mut self) -> Result<Statement, CompileError> {
        self.next_token(); // while
        let c = self.parse_expression(Precedence::Lowest)?;
        self.next_token();
        let b = self.parse_block()?;
        Ok(Statement::While { condition: c, body: b })
    }

    fn parse_try_catch_statement(&mut self) -> Result<Statement, CompileError> {
        self.next_token(); // try
        let t = self.parse_block()?;
        self.next_token();
        self.skip_newlines();
        if !self.cur_is(&TokenKind::TokCatch) { return Err(self.cur_error("Expected catch")); }
        self.next_token();
        let v = self.expect_identifier_string()?;
        self.next_token();
        let c = self.parse_block()?;
        Ok(Statement::TryCatch { try_block: t, catch_variable: v, catch_block: c })
    }

    fn parse_throw_statement(&mut self) -> Result<Statement, CompileError> {
        self.next_token(); // throw
        let v = self.parse_expression(Precedence::Lowest)?;
        Ok(Statement::Throw { value: v })
    }

    fn parse_return_statement(&mut self) -> Result<Statement, CompileError> {
        self.next_token(); // return
        if self.cur_is(&TokenKind::Newline) || self.cur_is(&TokenKind::RBrace) {
            return Ok(Statement::Return(None));
        }
        let v = self.parse_expression(Precedence::Lowest)?;
        Ok(Statement::Return(Some(v)))
    }

    fn parse_expression_statement(&mut self) -> Result<Statement, CompileError> {
        let l = self.parse_expression(Precedence::Lowest)?;
        if self.peek_is(&TokenKind::Equal) {
            self.next_token(); self.next_token();
            let r = self.parse_expression(Precedence::Lowest)?;
            Ok(Statement::Assign { lvalue: l, value: r })
        } else {
            Ok(Statement::Expr(l))
        }
    }

    fn parse_type(&mut self) -> Result<Type, CompileError> {
        match self.current_token.kind.clone() {
            TokenKind::TypeInt => Ok(Type::Int),
            TokenKind::TypeFloat => Ok(Type::Float),
            TokenKind::TypeBool => Ok(Type::Bool),
            TokenKind::TypeString => Ok(Type::String),
            TokenKind::TypeVoid => Ok(Type::Void),
            TokenKind::Star => {
                self.next_token();
                Ok(Type::Pointer(Box::new(self.parse_type()?)))
            }
            TokenKind::Identifier(mut n) => {
                if n == "Result" && self.peek_is(&TokenKind::Less) {
                    self.next_token();
                    let args = self.parse_type_arguments()?;
                    self.next_token();
                    if !self.cur_is(&TokenKind::Greater) { return Err(self.cur_error("Expected '>' in Result type")); }
                    return Ok(Type::Result(Box::new(args[0].clone()), Box::new(args[1].clone())));
                }
                while self.peek_is(&TokenKind::Dot) {
                    self.next_token(); self.next_token();
                    if let TokenKind::Identifier(suffix) = &self.current_token.kind {
                        n.push('.'); n.push_str(suffix);
                    } else { return Err(self.cur_error("Expected identifier after dot")); }
                }
                if self.peek_is(&TokenKind::Less) {
                    let mut checkpoint = self.clone();
                    checkpoint.next_token(); // Move to '<'
                    match checkpoint.parse_type_arguments() {
                        Ok(args) => {
                            checkpoint.next_token(); // Move to '>'
                            if checkpoint.cur_is(&TokenKind::Greater) {
                                *self = checkpoint;
                                return Ok(Type::Custom(n, args));
                            }
                        }
                        Err(_) => {}
                    }
                }
                Ok(Type::Custom(n, vec![]))
            }
            _ => Err(self.cur_error("Expected type")),
        }
    }

    fn parse_generic_params(&mut self) -> Result<Vec<String>, CompileError> {
        self.next_token();
        let mut params = Vec::new();
        params.push(self.expect_identifier_string()?);
        while self.peek_is(&TokenKind::Comma) {
            self.next_token(); self.next_token();
            params.push(self.expect_identifier_string()?);
        }
        Ok(params)
    }

    fn parse_type_arguments(&mut self) -> Result<Vec<Type>, CompileError> {
        self.next_token();
        let mut args = Vec::new();
        args.push(self.parse_type()?);
        while self.peek_is(&TokenKind::Comma) {
            self.next_token(); self.next_token();
            args.push(self.parse_type()?);
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
            TokenKind::StringLiteral(s) => Ok(Expression::String(s.clone())),
            TokenKind::TokTrue => Ok(Expression::Boolean(true)),
            TokenKind::TokFalse => Ok(Expression::Boolean(false)),
            TokenKind::TokNull => Ok(Expression::Null),
            TokenKind::Identifier(_) => self.parse_identifier(),
            TokenKind::Minus | TokenKind::Bang => {
                let op = self.current_token.kind.clone();
                self.next_token();
                Ok(Expression::Unary { operator: op, right: Box::new(self.parse_expression(Precedence::Prefix)?) })
            }
            TokenKind::LParen => {
                self.next_token();
                let e = self.parse_expression(Precedence::Lowest)?;
                self.next_token();
                if !self.cur_is(&TokenKind::RParen) { return Err(self.cur_error("Expected ')'")); }
                Ok(e)
            }
            TokenKind::TokComptime => {
                self.next_token();
                let body = self.parse_block()?;
                Ok(Expression::Comptime { body })
            }
            TokenKind::TokSizeof => {
                self.next_token();
                if !self.cur_is(&TokenKind::LParen) { return Err(self.cur_error("Expected '('")); }
                self.next_token();
                let typ = self.parse_type()?;
                self.next_token();
                if !self.cur_is(&TokenKind::RParen) { return Err(self.cur_error("Expected ')'")); }
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
            let mut checkpoint = self.clone();
            checkpoint.next_token(); // Move to '<'
            match checkpoint.parse_type_arguments() {
                Ok(args) => {
                    checkpoint.next_token(); // Move to '>'
                    if checkpoint.cur_is(&TokenKind::Greater) {
                        *self = checkpoint;
                        expr = Expression::GenericSpecialization { expression: Box::new(expr), type_args: args };
                    }
                }
                Err(_) => {}
            }
        }

        loop {
            if self.peek_is(&TokenKind::Dot) {
                self.next_token(); self.next_token();
                let f = self.expect_identifier_string()?;
                expr = Expression::MemberAccess { object: Box::new(expr), field: f.clone() };
                current_path.push('.'); current_path.push_str(&f);
                
                if self.peek_is(&TokenKind::Less) {
                    let mut checkpoint = self.clone();
                    checkpoint.next_token(); // Move to '<'
                    match checkpoint.parse_type_arguments() {
                        Ok(args) => {
                            checkpoint.next_token(); // Move to '>'
                            if checkpoint.cur_is(&TokenKind::Greater) {
                                *self = checkpoint;
                                expr = Expression::GenericSpecialization { expression: Box::new(expr), type_args: args };
                            }
                        }
                        Err(_) => {}
                    }
                }
                continue;
            }
            if self.peek_is(&TokenKind::ColonColon) {
                let enum_name = current_path.clone();
                self.next_token(); self.next_token();
                let variant = self.expect_identifier_string()?;
                let mut value = None;
                if self.peek_is(&TokenKind::LParen) {
                    self.next_token(); self.next_token();
                    value = Some(Box::new(self.parse_expression(Precedence::Lowest)?));
                    self.next_token();
                    if !self.cur_is(&TokenKind::RParen) { return Err(self.cur_error("Expected ')'")); }
                }
                expr = Expression::EnumInit { enum_name, variant_name: variant, value, type_args: vec![] };
                break;
            }
            if self.peek_is(&TokenKind::LBrace) {
                expr = self.parse_struct_init(expr)?;
                continue;
            }
            break;
        }
        Ok(expr)
    }

    fn parse_struct_init(&mut self, expr: Expression) -> Result<Expression, CompileError> {
        let (name, t_args) = match expr {
            Expression::Identifier(n) => (n, vec![]),
            Expression::MemberAccess { .. } => (self.expr_to_string(&expr)?, vec![]),
            Expression::GenericSpecialization { expression, type_args } => {
                 let n = match *expression {
                     Expression::Identifier(n) => n,
                     Expression::MemberAccess { .. } => self.expr_to_string(&expression)?,
                     _ => return Err(self.cur_error("Invalid generic struct init")),
                 };
                 (n, type_args)
            },
            _ => return Err(self.cur_error("Invalid struct init")),
        };
        self.next_token();
        self.next_token(); // Move past '{'
        let mut fields = Vec::new();
        while !self.cur_is(&TokenKind::RBrace) {
            self.skip_newlines();
            if self.cur_is(&TokenKind::RBrace) { break; }
            let fnm = self.expect_identifier_string()?;
            self.next_token();
            if !self.cur_is(&TokenKind::Colon) { return Err(self.cur_error("Expected ':'")); }
            self.next_token();
            let fval = self.parse_expression(Precedence::Lowest)?;
            self.next_token();
            fields.push((fnm, fval));
            if self.cur_is(&TokenKind::Comma) { self.next_token(); }
            self.skip_newlines();
        }
        Ok(Expression::StructInit { name, fields, type_args: t_args })
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
                Ok(Expression::Binary { left: Box::new(left), operator: op, right: Box::new(self.parse_expression(pr)?) })
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
                } else { self.next_token(); }
                if !self.cur_is(&TokenKind::RParen) { return Err(self.cur_error("Expected )")); }
                Ok(Expression::Call { function: Box::new(left), args, type_args: vec![] })
            }
            TokenKind::Dot => {
                self.next_token();
                let f = self.expect_identifier_string()?;
                Ok(Expression::MemberAccess { object: Box::new(left), field: f })
            }
            TokenKind::LBracket => {
                self.next_token();
                let index = self.parse_expression(Precedence::Lowest)?;
                self.next_token();
                if !self.cur_is(&TokenKind::RBracket) { return Err(self.cur_error("Expected ']'")); }
                Ok(Expression::Index { left: Box::new(left), index: Box::new(index) })
            }
            TokenKind::TokAs => {
                self.next_token();
                let target_type = self.parse_type()?;
                Ok(Expression::Cast { expression: Box::new(left), target_type })
            }
            TokenKind::Question => Ok(Expression::Try { expression: Box::new(left) }),
            _ => Err(self.cur_error("No infix")),
        }
    }
}