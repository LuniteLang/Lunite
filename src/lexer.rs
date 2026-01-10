use crate::token::{Token, TokenKind};

#[derive(Debug, Clone, Copy, PartialEq)]
pub struct Span {
    pub start: usize,
    pub end: usize,
    pub line: usize,
    pub column: usize,
}

impl Span {
    pub fn new(start: usize, end: usize, line: usize, column: usize) -> Self {
        Self {
            start,
            end,
            line,
            column,
        }
    }
}

pub struct Lexer<'a> {
    input: &'a str,
    chars: std::iter::Peekable<std::str::CharIndices<'a>>,
    current_char: Option<char>,
    current_pos: usize, // Byte index
    line: usize,
    column: usize,
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
            if c == '\n' {
                self.line += 1;
                self.column = 1;
            } else {
                self.column += 1;
            }
            self.current_pos += c.len_utf8();
        }

        self.current_char = self.chars.next().map(|(_, c)| c);
        c
    }

    pub fn peek(&mut self) -> Option<char> {
        self.current_char
    }

    fn skip_whitespace(&mut self) {
        while let Some(c) = self.peek() {
            if c.is_whitespace() && c != '\n' {
                self.advance();
            } else if c == '/' {
                let next_char = self.chars.peek().map(|(_, c)| *c);
                if next_char == Some('/') {
                    self.advance(); // consume /
                    self.advance(); // consume /
                    while let Some(c) = self.peek() {
                        if c == '\n' {
                            break;
                        }
                        self.advance();
                    }
                } else if next_char == Some('*') {
                    self.advance(); // consume /
                    self.advance(); // consume *
                    while let Some(c) = self.peek() {
                        if c == '*' {
                            let next = self.chars.peek().map(|(_, c)| *c);
                            if next == Some('/') {
                                self.advance(); // consume *
                                self.advance(); // consume /
                                break;
                            }
                            self.advance();
                        } else {
                            self.advance();
                        }
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
        let start_col = self.column;
        let start_line = self.line;

        let kind = match self.peek() {
            Some(c) => match c {
                '\n' => {
                    self.advance();
                    TokenKind::Newline
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
                    TokenKind::Dot
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
            None => TokenKind::EOF,
        };

        let end_pos = self.current_pos;
        Token {
            kind,
            line: start_line,
            column: start_col,
            // We could add Span struct to Token if we update token.rs
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
            "fn" => TokenKind::Fn,
            "let" => TokenKind::Let,
            "return" => TokenKind::Return,
            "if" => TokenKind::If,
            "else" => TokenKind::Else,
            "while" => TokenKind::While,
            "for" => TokenKind::For,
            "struct" => TokenKind::Struct,
            "int" => TokenKind::Int,
            "float" => TokenKind::Float,
            "string" => TokenKind::StringType,
            "bool" => TokenKind::Bool,
            "void" => TokenKind::Void,
            "throw" => TokenKind::Throw,
            "pub" => TokenKind::Pub,
            "pure" => TokenKind::Pure,
            "layout" => TokenKind::Layout,
            "soa" => TokenKind::Soa,
            "use" => TokenKind::Use,
            "import" => TokenKind::Import,
            "extern" => TokenKind::Extern,
            "native" => TokenKind::Native,
            "enum" => TokenKind::Enum,
            "impl" => TokenKind::Impl,
            "region" => TokenKind::Region,
            "comptime" => TokenKind::Comptime,
            "try" => TokenKind::Try,
            "catch" => TokenKind::Catch,
            "true" => TokenKind::True,
            "false" => TokenKind::False,
            "null" => TokenKind::Null,
            "mut" => TokenKind::Mut,
            "in" => TokenKind::In,
            "when" => TokenKind::When,
            "as" => TokenKind::As,
            "spawn" => TokenKind::Spawn,
            "sizeof" => TokenKind::Sizeof,
            _ => TokenKind::Identifier(text.to_string()),
        }
    }

    fn read_number(&mut self) -> TokenKind {
        let start = self.current_pos;
        
        if self.current_char == Some('0') {
            let next = self.chars.peek().map(|(_, c)| *c);
            if let Some(c) = next {
                if c == 'x' || c == 'b' || c == 'o' {
                    self.advance(); // 0
                    self.advance(); // x/b/o
                    while let Some(c) = self.peek() {
                        if c.is_digit(16) { self.advance(); } else { break; }
                    }
                    let text = &self.input[start..self.current_pos];
                    let val = if text.starts_with("0x") { i64::from_str_radix(&text[2..], 16) }
                              else if text.starts_with("0b") { i64::from_str_radix(&text[2..], 2) }
                              else { i64::from_str_radix(&text[2..], 8) };
                    return TokenKind::IntLiteral(val.unwrap_or(0));
                }
            }
        }

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
        TokenKind::String(s)
    }
}
