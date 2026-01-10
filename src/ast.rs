use crate::token::TokenKind;

#[derive(Debug, Clone, PartialEq)]
pub enum Visibility {
    Public,
    Private,
}

#[derive(Debug, Clone, PartialEq)]
pub enum Type {
    Int,
    Float,
    Bool,
    String,
    Void,
    Custom(String, Vec<Type>),
    Enum(String, Vec<Type>),
    Array(Box<Type>, u32),
    Pointer(Box<Type>),
    Function(Vec<Type>, Box<Type>),
    Result(Box<Type>, Box<Type>),
    Option(Box<Type>),
    Null,
}

#[derive(Debug, Clone)]
pub struct Program {
    pub items: Vec<Item>,
}

#[derive(Debug, Clone, PartialEq)]
pub enum Item {
    Use {
        path: Vec<String>,
        alias: Option<String>,
    },
    Import {
        path: String,
        alias: Option<String>,
    },
    Function(FunctionDecl),
    NativeFunction(NativeFunctionDecl),
    ExternFunction(ExternFunctionDecl),
    Struct(StructDecl),
    Enum(EnumDecl),
    Impl(ImplDecl),
}

#[derive(Debug, Clone, PartialEq)]
pub struct ImplDecl {
    pub struct_name: String,
    pub generic_params: Vec<String>,
    pub methods: Vec<FunctionDecl>,
}

#[derive(Debug, Clone, PartialEq)]
pub struct NativeFunctionDecl {
    pub name: String,
    pub generic_params: Vec<String>,
    pub params: Vec<(String, Type, bool)>,
    pub return_type: Type,
    pub visibility: Visibility,
}

#[derive(Debug, Clone, PartialEq)]
pub struct ExternFunctionDecl {
    pub name: String,
    pub generic_params: Vec<String>,
    pub params: Vec<(String, Type, bool)>,
    pub return_type: Type,
}

#[derive(Debug, Clone, PartialEq)]
pub enum StructLayout {
    Aos, // Default: Array of Structures
    Soa, // Structure of Arrays
}

#[derive(Debug, Clone, PartialEq)]
pub struct StructDecl {
    pub name: String,
    pub generic_params: Vec<String>,
    pub fields: Vec<(String, Type, Visibility)>,
    pub visibility: Visibility,
    pub layout: StructLayout,
}

#[derive(Debug, Clone, PartialEq)]
pub struct EnumDecl {
    pub name: String,
    pub generic_params: Vec<String>,
    pub variants: Vec<EnumVariant>,
    pub visibility: Visibility,
}

#[derive(Debug, Clone, PartialEq)]
pub struct EnumVariant {
    pub name: String,
    pub typ: Option<Type>,
}

#[derive(Debug, Clone, PartialEq)]
pub struct FunctionDecl {
    pub name: String,
    pub generic_params: Vec<String>,
    pub params: Vec<(String, Type, bool)>,
    pub return_type: Type,
    pub body: Block,
    pub visibility: Visibility,
    pub is_pure: bool,
    pub contract: Option<Expression>,
}

#[derive(Debug, Clone, PartialEq)]
pub struct Block {
    pub statements: Vec<Statement>,
}

#[derive(Debug, Clone, PartialEq)]
pub enum Statement {
    Let {
        name: String,
        is_mutable: bool,
        type_name: Option<Type>,
        value: Option<Expression>,
    },
    Assign {
        lvalue: Expression,
        value: Expression,
    },
    Return(Option<Expression>),
    If {
        condition: Expression,
        then_branch: Block,
        else_branch: Option<Block>,
    },
    While {
        condition: Expression,
        body: Block,
    },
    Region {
        body: Block,
    },
    Spawn(Expression),
    For {
        variable: String,
        start: Expression,
        end: Expression,
        body: Block,
    },
    When {
        subject: Expression,
        arms: Vec<WhenArm>,
    },
    Throw {
        value: Expression,
    },
    TryCatch {
        try_block: Block,
        catch_variable: String,
        catch_block: Block,
    },
    Expr(Expression),
    Block(Block),
}

#[derive(Debug, Clone, PartialEq)]
pub struct WhenArm {
    pub pattern: WhenPattern,
    pub body: Block,
}

#[derive(Debug, Clone, PartialEq)]
pub enum WhenPattern {
    Literal(Expression),
    Range(Expression, Expression),
    EnumVariant {
        enum_name: String,
        variant_name: String,
        binding: Option<String>,
    },
    Else,
}

#[derive(Debug, Clone, PartialEq)]
pub enum Expression {
    Int(i64),
    Float(f64),
    String(String),
    Identifier(String),
    Boolean(bool),
    Null,
    Unary {
        operator: TokenKind,
        right: Box<Expression>,
    },
    Comptime {
        body: Block,
    },
    Binary {
        left: Box<Expression>,
        operator: TokenKind,
        right: Box<Expression>,
    },
    Call {
        function: Box<Expression>,
        args: Vec<Expression>,
        type_args: Vec<Type>,
    },
    StructInit {
        name: String,
        type_args: Vec<Type>,
        fields: Vec<(String, Expression)>,
    },
    EnumInit {
        enum_name: String,
        variant_name: String,
        type_args: Vec<Type>,
        value: Option<Box<Expression>>,
    },
    ArrayLiteral {
        elements: Vec<Expression>,
    },
    ArrayRepeat {
        value: Box<Expression>,
        size: usize,
    },
    MemberAccess {
        object: Box<Expression>,
        field: String,
    },
    GenericSpecialization {
        expression: Box<Expression>,
        type_args: Vec<Type>,
    },
    Index {
        left: Box<Expression>,
        index: Box<Expression>,
    },
    Cast {
        expression: Box<Expression>,
        target_type: Type,
    },
    Try {
        expression: Box<Expression>,
    },
    Sizeof(Type),
}

impl Expression {
    pub fn is_lvalue(&self) -> bool {
        matches!(
            self,
            Expression::Identifier(_) | Expression::MemberAccess { .. } | Expression::Index { .. }
        )
    }
}
