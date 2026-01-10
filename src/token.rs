#[derive(Debug, Clone, PartialEq)]
pub enum TokenKind {
    Illegal,
    EOF,
    Identifier(String),
    IntLiteral(i64),
    FloatLiteral(f64),
    StringLiteral(String),
    
    // Operators
    Plus, Minus, Star, Slash, Percent,
    Equal, EqualEqual,
    Bang, BangEqual,
    Less, LessEqual, Greater, GreaterEqual,
    Ampersand, AndAnd, Pipe, PipePipe, Caret,
    LessLess, GreaterGreater,
    Question,
    
    // Punctuation
    LParen, RParen, LBrace, RBrace, LBracket, RBracket,
    Colon, ColonColon, Comma, Dot, Arrow, FatArrow,
    Semicolon, Newline,

    // Keywords
    TokFn, TokLet, TokReturn, TokIf, TokElse, TokWhile, TokFor, TokIn,
    TokStruct, TokEnum, TokImpl, TokUse, TokImport, TokExtern, TokNative,
    TokPub, TokPure, TokReq, TokLayout, TokSoa, TokAs, TokTry, TokCatch, TokThrow,
    TokTrue, TokFalse, TokNull, TokMut, TokWhen, TokAsKeyword, // Tránh trùng với TokAs
    TokRegion, TokComptime, TokSpawn, TokSizeof,
    
    // Types
    TypeInt, TypeFloat, TypeBool, TypeString, TypeVoid
}

#[derive(Debug, Clone)]
pub struct Token {
    pub kind: TokenKind,
    pub line: usize,
    pub column: usize,
}