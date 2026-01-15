use crate::token::{Token, TokenKind};
use crate::span::Span;

#[derive(Clone)]
pub struct Lexer<'a> {
    input: &'a str,
    chars: std::iter::Peekable<std::str::CharIndices<'a>>,
    current_char: Option<char>,
    current_pos: usize,
    line: u32,
    column: u32,
}

impl<'a> Lexer<'a> {
    pub fn new(input: &'a str) -> Self {
        let mut chars = input.char_indices().peekable();
        let current_char = chars.next().map(|(_, c)| c);
        Self {
            input,
            chars,
            current_char,
            current_pos: 0,
            line: 1,
            column: 1,
        }
    }

    fn advance(&mut self) -> Option<char> {
        let c = self.current_char;
        if let Some(c) = c {
            self.current_pos += c.len_utf8();
            if c == '\n' {
                self.line += 1;
                self.column = 1;
            } else {
                self.column += 1;
            }
        }
        self.current_char = self.chars.next().map(|(_, c)| c);
        c
    }

    pub fn peek(&mut self) -> Option<char> {
        self.current_char
    }

    fn skip_whitespace(&mut self) {
        while let Some(c) = self.peek() {
            if c.is_whitespace() {
                self.advance();
            } else if c == '/' {
                let mut chars_clone = self.chars.clone();
                let next_char = chars_clone.next().map(|(_, c)| c);
                if next_char == Some('/') {
                    self.advance();
                    self.advance();
                    while let Some(c) = self.peek() {
                        if c == '\n' {
                            break;
                        }
                        self.advance();
                    }
                } else if next_char == Some('*') {
                    self.advance();
                    self.advance();
                    while let Some(c) = self.peek() {
                        if c == '*' {
                            let mut inner_clone = self.chars.clone();
                            if inner_clone.next().map(|(_, c)| c) == Some('/') {
                                self.advance();
                                self.advance();
                                break;
                            }
                        }
                        self.advance();
                    }
                } else {
                    break;
                }
            } else {
                break;
            }
        }
    }

    pub fn next_token(&mut self) -> Token {
        self.skip_whitespace();
        let start_pos = self.current_pos;
        let start_line = self.line;
        let start_col = self.column;

        let kind = match self.peek() {
            Some(c) => match c {
                '\n' => {
                    self.advance(); // consume \n
                    // Newline token logic handled in advance, but we want to return a token
                    // Actually, skip_whitespace consumes newlines usually, but if we want to support significant whitespace or semicolons insertion
                    // For now, let's treat explicit Newline if not skipped.
                    // But wait, skip_whitespace consumes \n if char::is_whitespace() includes \n. Yes it does.
                    // So we probably won't reach here for \n unless skip_whitespace logic changes.
                    // Let's assume standard C-style whitespace for now.
                    TokenKind::Newline // Should be consumed by skip_whitespace usually
                }
                '+' => {
                    self.advance();
                    TokenKind::Plus
                }
                '-' => {
                    self.advance();
                    if self.peek() == Some('>') {
                        self.advance();
                        TokenKind::Arrow
                    } else {
                        TokenKind::Minus
                    }
                }
                '*' => {
                    self.advance();
                    TokenKind::Star
                }
                '%' => {
                    self.advance();
                    TokenKind::Percent
                }
                '/' => {
                    self.advance();
                    TokenKind::Slash
                }
                '=' => {
                    self.advance();
                    if self.peek() == Some('=') {
                        self.advance();
                        TokenKind::EqualEqual
                    } else if self.peek() == Some('>') {
                        self.advance();
                        TokenKind::FatArrow
                    } else {
                        TokenKind::Equal
                    }
                }
                '(' => {
                    self.advance();
                    TokenKind::LParen
                }
                ')' => {
                    self.advance();
                    TokenKind::RParen
                }
                '{' => {
                    self.advance();
                    TokenKind::LBrace
                }
                '}' => {
                    self.advance();
                    TokenKind::RBrace
                }
                '[' => {
                    self.advance();
                    TokenKind::LBracket
                }
                ']' => {
                    self.advance();
                    TokenKind::RBracket
                }
                ':' => {
                    self.advance();
                    if self.peek() == Some(':') {
                        self.advance();
                        TokenKind::ColonColon
                    } else {
                        TokenKind::Colon
                    }
                }
                ';' => {
                    self.advance();
                    TokenKind::Semicolon
                }
                ',' => {
                    self.advance();
                    TokenKind::Comma
                }
                '.' => {
                    self.advance();
                    if self.peek() == Some('.') {
                        self.advance();
                        TokenKind::DotDot
                    } else {
                        TokenKind::Dot
                    }
                }
                '!' => {
                    self.advance();
                    if self.peek() == Some('=') {
                        self.advance();
                        TokenKind::BangEqual
                    } else {
                        TokenKind::Bang
                    }
                }
                '&' => {
                    self.advance();
                    if self.peek() == Some('&') {
                        self.advance();
                        TokenKind::AndAnd
                    } else {
                        TokenKind::Ampersand
                    }
                }
                '|' => {
                    self.advance();
                    if self.peek() == Some('|') {
                        self.advance();
                        TokenKind::PipePipe
                    } else {
                        TokenKind::Pipe
                    }
                }
                '^' => {
                    self.advance();
                    TokenKind::Caret
                }
                '?' => {
                    self.advance();
                    TokenKind::Question
                }
                '<' => {
                    self.advance();
                    if self.peek() == Some('=') {
                        self.advance();
                        TokenKind::LessEqual
                    } else if self.peek() == Some('<') {
                        self.advance();
                        TokenKind::LessLess
                    } else {
                        TokenKind::Less
                    }
                }
                '>' => {
                    self.advance();
                    if self.peek() == Some('=') {
                        self.advance();
                        TokenKind::GreaterEqual
                    } else if self.peek() == Some('>') {
                        self.advance();
                        TokenKind::GreaterGreater
                    } else {
                        TokenKind::Greater
                    }
                }
                '"' => self.read_string(),
                c if c.is_alphabetic() || c == '_' => self.read_identifier(),
                c if c.is_numeric() => self.read_number(),
                _ => {
                    self.advance();
                    TokenKind::Illegal
                }
            },
            None => TokenKind::Eof,
        };

        Token {
            kind,
            span: Span::new(start_pos, self.current_pos, start_line, start_col),
        }
    }

    fn read_identifier(&mut self) -> TokenKind {
        let start = self.current_pos;
        while let Some(c) = self.peek() {
            if c.is_alphanumeric() || c == '_' {
                self.advance();
            } else {
                break;
            }
        }
        let text = &self.input[start..self.current_pos];
        match text {
            "fn" => TokenKind::TokFn,
            "let" => TokenKind::TokLet,
            "return" => TokenKind::TokReturn,
            "if" => TokenKind::TokIf,
            "else" => TokenKind::TokElse,
            "while" => TokenKind::TokWhile,
            "for" => TokenKind::TokFor,
            "break" => TokenKind::TokBreak,
            "struct" => TokenKind::TokStruct,
            "int" => TokenKind::TypeInt,
            "float" => TokenKind::TypeFloat,
            "string" => TokenKind::TypeString,
            "bool" => TokenKind::TypeBool,
            "void" => TokenKind::TypeVoid,
            "throw" => TokenKind::TokThrow,
            "pub" => TokenKind::TokPub,
            "pure" => TokenKind::TokPure,
            "req" => TokenKind::TokReq,
            "layout" => TokenKind::TokLayout,
            "soa" => TokenKind::TokSoa,
            "use" => TokenKind::TokUse,
            "import" => TokenKind::TokImport,
            "extern" => TokenKind::TokExtern,
            "native" => TokenKind::TokNative,
            "enum" => TokenKind::TokEnum,
            "impl" => TokenKind::TokImpl,
            "region" => TokenKind::TokRegion,
            "comptime" => TokenKind::TokComptime,
            "try" => TokenKind::TokTry,
            "catch" => TokenKind::TokCatch,
            "true" => TokenKind::TokTrue,
            "false" => TokenKind::TokFalse,
            "null" => TokenKind::TokNull,
            "mut" => TokenKind::TokMut,
            "in" => TokenKind::TokIn,
            "when" => TokenKind::TokWhen,
            "as" => TokenKind::TokAs,
            "spawn" => TokenKind::TokSpawn,
            "sizeof" => TokenKind::TokSizeof,
            "trait" => TokenKind::TokTrait,
            _ => TokenKind::Identifier(text.to_string()),
        }
    }

    fn read_number(&mut self) -> TokenKind {
        let start = self.current_pos;
        let mut is_float = false;
        while let Some(c) = self.peek() {
            if c.is_numeric() {
                self.advance();
            } else if c == '.' && !is_float {
                is_float = true;
                self.advance();
            } else {
                break;
            }
        }
        let text = &self.input[start..self.current_pos];
        if is_float {
            TokenKind::FloatLiteral(text.parse().unwrap_or(0.0))
        } else {
            TokenKind::IntLiteral(text.parse().unwrap_or(0))
        }
    }

    fn read_string(&mut self) -> TokenKind {
        self.advance(); // open quote
        let mut s = String::new();
        while let Some(c) = self.peek() {
            if c == '"' {
                break;
            }
            if c == '\\' {
                self.advance();
                match self.peek() {
                    Some('n') => s.push('\n'),
                    Some('r') => s.push('\r'),
                    Some('t') => s.push('\t'),
                    Some('"') => s.push('"'),
                    Some('\\') => s.push('\\'),
                    Some(other) => {
                        s.push('\\');
                        s.push(other);
                    }
                    None => break,
                }
            } else {
                s.push(c);
            }
            self.advance();
        }
        self.advance(); // close quote
        TokenKind::StringLiteral(s)
    }
}
