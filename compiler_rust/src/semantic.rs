use std::cell::RefCell;
use std::collections::{HashMap, HashSet};
use std::fs;
use std::path::{Path, PathBuf};
use std::rc::Rc;

use crate::ast::{
    Block, EnumDecl, Expression, FunctionDecl, ImplDecl, Item, Program, Statement, StructDecl,
    StructLayout, Type, Visibility,
};
use crate::interpreter::{Interpreter, Value};
use crate::lexer::Lexer;
use crate::parser::Parser;
use crate::token::TokenKind;
use crate::CompileError;

#[derive(Debug, Clone, PartialEq)]
pub struct Symbol {
    pub name: String,
    pub typ: Type,
    pub is_mutable: bool,
    pub visibility: Visibility,
}

#[derive(Debug, Clone)]
pub struct Scope {
    pub symbols: HashMap<String, Symbol>,
    pub parent: Option<Rc<RefCell<Scope>>>,
}

impl Scope {
    pub fn new() -> Self {
        Self {
            symbols: HashMap::new(),
            parent: None,
        }
    }
    pub fn with_parent(parent: Rc<RefCell<Scope>>) -> Self {
        Self {
            symbols: HashMap::new(),
            parent: Some(parent),
        }
    }
    pub fn insert(&mut self, name: String, symbol: Symbol) {
        self.symbols.insert(name, symbol);
    }
    pub fn lookup(&self, name: &str) -> Option<Symbol> {
        if let Some(sym) = self.symbols.get(name) {
            return Some(sym.clone());
        }
        if let Some(parent) = &self.parent {
            return parent.borrow().lookup(name);
        }
        None
    }
}

#[derive(Debug, Clone)]
pub struct TModule {
    pub name: String,
    pub items: Vec<TItem>,
    pub exports: HashMap<String, Symbol>,
    pub imports: HashMap<String, String>,
    pub struct_decls: HashMap<String, StructDecl>,
    pub enum_decls: HashMap<String, EnumDecl>,
    pub generic_structs: HashMap<String, (StructDecl, String)>,
    pub generic_impls: HashMap<String, (ImplDecl, String)>,
}

#[derive(Debug, Clone)]
pub enum TItem {
    Function(TFunctionDecl),
    NativeFunction(TNativeFunctionDecl),
    ExternFunction(TExternFunctionDecl),
    Struct(StructDecl),
    Enum(EnumDecl),
}

#[derive(Debug, Clone)]
pub struct TNativeFunctionDecl {
    pub name: String,
    pub params: Vec<(String, Type, bool)>,
    pub return_type: Type,
    pub visibility: Visibility,
}

#[derive(Debug, Clone)]
pub struct TExternFunctionDecl {
    pub name: String,
    pub params: Vec<(String, Type, bool)>,
    pub return_type: Type,
}

#[derive(Debug, Clone)]
pub struct TFunctionDecl {
    pub name: String,
    pub params: Vec<(String, Type, bool)>,
    pub return_type: Type,
    pub body: TBlock,
    pub visibility: Visibility,
    pub is_pure: bool,
}

#[derive(Debug, Clone)]
pub struct TBlock {
    pub statements: Vec<TStatement>,
}

#[derive(Debug, Clone)]
pub enum TStatement {
    Let {
        name: String,
        var_type: Type,
        value: Option<TExpression>,
    },
    Return(Option<TExpression>),
    Expr(TExpression),
    Assign {
        lvalue: TExpression,
        rvalue: TExpression,
    },
    If {
        condition: TExpression,
        then_block: TBlock,
        else_block: Option<TBlock>,
    },
    While {
        condition: TExpression,
        body: TBlock,
    },
    Region {
        body: TBlock,
    },
    Block(TBlock),
    Throw {
        value: TExpression,
    },
    Spawn(TExpression),
    TryCatch {
        try_block: TBlock,
        catch_variable: String,
        catch_block: TBlock,
    },
    Break,
    When {
        subject: TExpression,
        arms: Vec<TWhenArm>,
    },
}

#[derive(Debug, Clone)]
pub struct TWhenArm {
    pub pattern: TWhenPattern,
    pub body: TBlock,
}

#[derive(Debug, Clone)]
pub enum TWhenPattern {
    Literal(TExpression),
    EnumVariant {
        enum_name: String,
        variant_name: String,
        binding: Option<String>,
        tag: u32,
    },
    Else,
}

#[derive(Debug, Clone)]
pub struct TExpression {
    pub kind: TExpressionKind,
    pub typ: Type,
}

#[derive(Debug, Clone)]
pub enum TExpressionKind {
    Int(i64),
    Float(f64),
    Boolean(bool),
    Null,
    String(String),
    Identifier(String),
    StructInit {
        name: String,
        fields: Vec<(String, TExpression)>,
    },
    EnumInit {
        enum_name: String,
        variant_name: String,
        value: Option<Box<TExpression>>,
        tag: u32,
    },
    Call {
        function: String,
        args: Vec<TExpression>,
    },
    MemberAccess {
        object: Box<TExpression>,
        field: String,
    },
    ArrayRepeat {
        value: Box<TExpression>,
        size: usize,
    },
    ArrayLiteral {
        elements: Vec<TExpression>,
    },
    Index {
        array: Box<TExpression>,
        index: Box<TExpression>,
    },
    Binary {
        left: Box<TExpression>,
        operator: TokenKind,
        right: Box<TExpression>,
    },
    Unary {
        operator: TokenKind,
        right: Box<TExpression>,
    },
    Cast {
        expression: Box<TExpression>,
        target_type: Type,
    },
    Comptime {
        body: TBlock,
    },
    Try {
        expression: Box<TExpression>,
    },
    Sizeof(Type),
}

pub struct SemanticAnalyzer {
    pub analyzed_modules: HashMap<String, TModule>,
    pub structs: HashMap<String, (StructDecl, String)>,
    pub functions: HashMap<String, (Vec<Type>, Type, Visibility, bool, String)>,
    pub enum_names: HashSet<String>,
    pub enum_decls_global: HashMap<String, EnumDecl>,
    pub generic_structs: HashMap<String, (StructDecl, String)>,
    pub generic_impls: HashMap<String, (ImplDecl, String)>,
    pub generic_functions: HashMap<String, (FunctionDecl, String)>,
    pub monomorphized_functions: HashSet<String>,
    pub monomorphized_structs: HashSet<String>,
    pub pending_items: Vec<TItem>,
    pub in_pure_context: bool,
    pub current_return_type: Option<Type>,
    processing_stack: HashSet<PathBuf>,
    parsed_files: HashSet<PathBuf>,
    lib_paths: Vec<PathBuf>,
    current_scope: Rc<RefCell<Scope>>,
    current_module_name: String,
    current_module_path: PathBuf,
    current_imports: HashMap<String, String>,
    instantiation_queue: Vec<(String, FunctionDecl, HashMap<String, Type>)>,
}

impl SemanticAnalyzer {
    pub fn new(lib_paths: Vec<PathBuf>) -> Self {
        Self {
            analyzed_modules: HashMap::new(),
            structs: HashMap::new(),
            functions: HashMap::new(),
            enum_names: HashSet::new(),
            enum_decls_global: HashMap::new(),
            generic_structs: HashMap::new(),
            generic_impls: HashMap::new(),
            generic_functions: HashMap::new(),
            monomorphized_functions: HashSet::new(),
            monomorphized_structs: HashSet::new(),
            pending_items: Vec::new(),
            in_pure_context: false,
            current_return_type: None,
            processing_stack: HashSet::new(),
            parsed_files: HashSet::new(),
            lib_paths,
            current_scope: Rc::new(RefCell::new(Scope::new())),
            current_module_name: String::new(),
            current_module_path: PathBuf::new(),
            current_imports: HashMap::new(),
            instantiation_queue: Vec::new(),
        }
    }

    fn cur_error(&self, msg: &str) -> CompileError {
        CompileError {
            message: msg.into(),
            line: 0,
            column: 0,
        }
    }
    fn enter_scope(&mut self) {
        let new_scope = Scope::with_parent(self.current_scope.clone());
        self.current_scope = Rc::new(RefCell::new(new_scope));
    }
    fn exit_scope(&mut self) {
        let parent = self.current_scope.borrow().parent.clone();
        if let Some(p) = parent {
            self.current_scope = p;
        }
    }

    fn mangle_name(&self, base_name: &str, type_args: &[Type]) -> String {
        let suffix = type_args
            .iter()
            .map(|t| match t {
                Type::Int => "int".to_string(),
                Type::Float => "float".to_string(),
                Type::Bool => "bool".to_string(),
                Type::String => "string".to_string(),
                Type::Void => "void".to_string(),
                Type::Custom(n, args) => self.mangle_name(n, args),
                Type::Array(inner, size) => {
                    format!("arr_{}_{}", self.mangle_name("", &[*inner.clone()]), size)
                }
                Type::Pointer(inner) => format!("ptr_{}", self.mangle_name("", &[*inner.clone()])),
                Type::Enum(n, args) => self.mangle_name(n, args),
                _ => "unknown".to_string(),
            })
            .collect::<Vec<_>>()
            .join("_");

        if base_name.is_empty() {
            return suffix;
        }
        format!("{}_{}", base_name, suffix)
    }

    fn substitute_type(&self, typ: &Type, mapping: &HashMap<String, Type>) -> Type {
        match typ {
            Type::Custom(name, args) => {
                if let Some(sub) = mapping.get(name) {
                    return sub.clone();
                }
                let new_args: Vec<Type> = args
                    .iter()
                    .map(|t| self.substitute_type(t, mapping))
                    .collect();
                Type::Custom(name.clone(), new_args)
            }
            Type::Array(inner, size) => {
                Type::Array(Box::new(self.substitute_type(inner, mapping)), *size)
            }
            Type::Pointer(inner) => Type::Pointer(Box::new(self.substitute_type(inner, mapping))),
            Type::Function(params, ret) => {
                let new_params = params
                    .iter()
                    .map(|p| self.substitute_type(p, mapping))
                    .collect();
                Type::Function(new_params, Box::new(self.substitute_type(ret, mapping)))
            }
            _ => typ.clone(),
        }
    }

    fn instantiate_struct(
        &mut self,
        base_name: &str,
        type_args: &[Type],
    ) -> Result<String, CompileError> {
        let (origin_decl, origin_mod) =
            if let Some((decl, mod_name)) = self.generic_structs.get(base_name) {
                (decl.clone(), mod_name.clone())
            } else {
                let found = self
                    .generic_structs
                    .iter()
                    .find(|(k, _)| base_name.ends_with(*k));
                if let Some((_, val)) = found {
                    val.clone()
                } else {
                    // Try lookup in other modules
                    let mut found_external = None;
                    for module in self.analyzed_modules.values() {
                        if let Some(val) = module.generic_structs.get(base_name) {
                            found_external = Some(val.clone());
                            break;
                        }
                        if let Some((_, val)) = module
                            .generic_structs
                            .iter()
                            .find(|(k, _)| base_name.ends_with(*k))
                        {
                            found_external = Some(val.clone());
                            break;
                        }
                    }
                    if let Some(val) = found_external {
                        val
                    } else {
                        return Err(
                            self.cur_error(&format!("Generic struct '{}' not found", base_name))
                        );
                    }
                }
            };

        let full_base_name = if base_name.contains(&origin_mod) {
            base_name.to_string()
        } else {
            format!("{}_{}", origin_mod, origin_decl.name)
        };
        let mangled_name = self.mangle_name(&full_base_name, type_args);
        // eprintln!("[SEM] Generated Mangled Name: {}", mangled_name);

        if self.monomorphized_structs.contains(&mangled_name) {
            return Ok(mangled_name);
        }
        if origin_decl.generic_params.len() != type_args.len() {
            return Err(self.cur_error("Generic args mismatch"));
        }
        let mut mapping = HashMap::new();
        for (i, param) in origin_decl.generic_params.iter().enumerate() {
            mapping.insert(param.clone(), type_args[i].clone());
        }
        let mut new_decl = origin_decl.clone();
        new_decl.name = mangled_name.clone();
        new_decl.generic_params.clear();
        for field in &mut new_decl.fields {
            field.1 = self.substitute_type(&field.1, &mapping);
            field.1 = self.mangle_type(field.1.clone());
        }
        self.structs
            .insert(mangled_name.clone(), (new_decl.clone(), origin_mod.clone()));
        self.monomorphized_structs.insert(mangled_name.clone());
        self.pending_items.push(TItem::Struct(new_decl.clone()));

        if let Some(mod_data) = self.analyzed_modules.get_mut(&self.current_module_name) {
            mod_data.struct_decls.insert(mangled_name.clone(), new_decl);
        }

        let original_name = &origin_decl.name;
        if let Some((impl_decl, _)) = self.generic_impls.get(original_name).cloned() {
            for method in impl_decl.methods {
                self.instantiate_function_from_decl(method, &mapping, &mangled_name, &origin_mod)?;
            }
        }
        Ok(mangled_name)
    }

    fn instantiate_function(
        &mut self,
        base_name: &str,
        type_args: &[Type],
    ) -> Result<String, CompileError> {
        let (origin_decl, origin_mod) = if let Some((decl, mod_name)) =
            self.generic_functions.get(base_name)
        {
            (decl.clone(), mod_name.clone())
        } else {
            let found = self
                .generic_functions
                .iter()
                .find(|(k, _)| base_name.ends_with(*k));
            if let Some((_, val)) = found {
                val.clone()
            } else {
                return Err(self.cur_error(&format!("Generic function '{}' not found", base_name)));
            }
        };
        let mangled_name =
            self.mangle_name(&format!("{}_{}", origin_mod, origin_decl.name), type_args);
        if self.monomorphized_functions.contains(&mangled_name) {
            return Ok(mangled_name);
        }
        if origin_decl.generic_params.len() != type_args.len() {
            return Err(self.cur_error("Generic function expects more args"));
        }
        let mut mapping = HashMap::new();
        for (i, param) in origin_decl.generic_params.iter().enumerate() {
            mapping.insert(param.clone(), type_args[i].clone());
        }
        self.instantiate_function_from_decl(origin_decl, &mapping, "", &origin_mod)?;
        Ok(mangled_name)
    }

    fn instantiate_function_from_decl(
        &mut self,
        decl: FunctionDecl,
        mapping: &HashMap<String, Type>,
        struct_prefix: &str,
        origin_mod: &str,
    ) -> Result<(), CompileError> {
        let mangled_name = if !struct_prefix.is_empty() {
            format!("{}_{}", struct_prefix, decl.name)
        } else {
            let args: Vec<Type> = decl
                .generic_params
                .iter()
                .map(|p| mapping.get(p).unwrap().clone())
                .collect();
            self.mangle_name(&format!("{}_{}", origin_mod, decl.name), &args)
        };
        if self.functions.contains_key(&mangled_name) {
            return Ok(());
        }

        let mut new_decl = decl.clone();
        new_decl.name = mangled_name.clone();
        new_decl.generic_params.clear();
        for param in &mut new_decl.params {
            param.1 = self.substitute_type(&param.1, mapping);
            param.1 = self.mangle_type(param.1.clone());
        }
        new_decl.return_type = self.substitute_type(&new_decl.return_type, mapping);
        new_decl.return_type = self.mangle_type(new_decl.return_type.clone());
        self.instantiation_queue
            .push((origin_mod.to_string(), new_decl, mapping.clone()));
        Ok(())
    }

    fn process_instantiation_queue(&mut self) -> Result<(), CompileError> {
        while let Some((mod_name, decl, mapping)) = self.instantiation_queue.pop() {
            let old_mod = self.current_module_name.clone();
            let old_imports = self.current_imports.clone();

            self.current_module_name = mod_name.clone();
            if let Some(m) = self.analyzed_modules.get(&mod_name) {
                self.current_imports = m.imports.clone();
            } else if mod_name != old_mod {
                // Should not happen if dependencies are analyzed first
                // But for current module (self recursion), imports are already set.
                // If switching to a module that is analyzed but not current, we need its imports.
                // If switching to current module, do nothing (keep current imports).
                // Wait, analyzed_modules contains finished modules. Current module is NOT in analyzed_modules yet.
                // So if mod_name == current_module_name (before switch), we keep imports.
                // If mod_name != current_module_name, it must be in analyzed_modules.
            }

            let mut substituted_body = decl.body.clone();
            self.substitute_block(&mut substituted_body, &mapping)?;
            let mut concrete_decl = decl.clone();
            concrete_decl.body = substituted_body;
            let t_func = self.analyze_function(concrete_decl)?;

            self.current_module_name = old_mod;
            self.current_imports = old_imports;

            self.pending_items.push(TItem::Function(t_func.clone()));
            let pts: Vec<Type> = t_func.params.iter().map(|(_, t, _)| t.clone()).collect();
            self.functions.insert(
                t_func.name.clone(),
                (
                    pts,
                    t_func.return_type,
                    t_func.visibility,
                    t_func.is_pure,
                    self.current_module_name.clone(),
                ),
            );
        }
        Ok(())
    }

    fn substitute_block(
        &self,
        block: &mut Block,
        mapping: &HashMap<String, Type>,
    ) -> Result<(), CompileError> {
        for stmt in &mut block.statements {
            self.substitute_statement(stmt, mapping)?;
        }
        Ok(())
    }

    fn substitute_statement(
        &self,
        stmt: &mut Statement,
        mapping: &HashMap<String, Type>,
    ) -> Result<(), CompileError> {
        match stmt {
            Statement::Let {
                type_name, value, ..
            } => {
                if let Some(t) = type_name {
                    *t = self.substitute_type(t, mapping);
                }
                if let Some(v) = value {
                    self.substitute_expression(v, mapping)?;
                }
            }
            Statement::Expr(e) => self.substitute_expression(e, mapping)?,
            Statement::Assign { lvalue, value } => {
                self.substitute_expression(lvalue, mapping)?;
                self.substitute_expression(value, mapping)?;
            }
            Statement::If {
                condition,
                then_branch,
                else_branch,
            } => {
                self.substitute_expression(condition, mapping)?;
                self.substitute_block(then_branch, mapping)?;
                if let Some(b) = else_branch {
                    self.substitute_block(b, mapping)?;
                }
            }
            Statement::While { condition, body } => {
                self.substitute_expression(condition, mapping)?;
                self.substitute_block(body, mapping)?;
            }
            Statement::Return(Some(e)) => {
                self.substitute_expression(e, mapping)?;
            }
            Statement::Block(b) => self.substitute_block(b, mapping)?,
            Statement::Region { body } => self.substitute_block(body, mapping)?,
            Statement::When { subject, arms } => {
                self.substitute_expression(subject, mapping)?;
                for arm in arms {
                    self.substitute_block(&mut arm.body, mapping)?;
                }
            }
            Statement::Throw { value } => self.substitute_expression(value, mapping)?,
            Statement::Spawn(value) => self.substitute_expression(value, mapping)?,
            _ => {}
        }
        Ok(())
    }

    fn substitute_expression(
        &self,
        expr: &mut Expression,
        mapping: &HashMap<String, Type>,
    ) -> Result<(), CompileError> {
        match expr {
            Expression::Call {
                type_args,
                args,
                function,
                ..
            } => {
                for t in type_args {
                    *t = self.substitute_type(t, mapping);
                }
                for a in args {
                    self.substitute_expression(a, mapping)?;
                }
                self.substitute_expression(function, mapping)?;
            }
            Expression::StructInit {
                type_args, fields, ..
            } => {
                for t in type_args {
                    *t = self.substitute_type(t, mapping);
                }
                for (_, e) in fields {
                    self.substitute_expression(e, mapping)?;
                }
            }
            Expression::Binary { left, right, .. } => {
                self.substitute_expression(left, mapping)?;
                self.substitute_expression(right, mapping)?;
            }
            Expression::Unary { right, .. } => {
                self.substitute_expression(right, mapping)?;
            }
            Expression::MemberAccess { object, .. } => {
                self.substitute_expression(object, mapping)?;
            }
            Expression::Cast {
                expression,
                target_type,
            } => {
                self.substitute_expression(expression, mapping)?;
                *target_type = self.substitute_type(target_type, mapping);
            }
            Expression::ArrayRepeat { value, .. } => {
                self.substitute_expression(value, mapping)?;
            }
            Expression::Index { left, index } => {
                self.substitute_expression(left, mapping)?;
                self.substitute_expression(index, mapping)?;
            }
            Expression::Sizeof(t) => {
                *t = self.substitute_type(t, mapping);
            }
            _ => {}
        }
        Ok(())
    }

    fn mangle_type(&mut self, typ: Type) -> Type {
        match typ {
            Type::Custom(name, args) => {
                if args.is_empty() {
                    if name.contains('_') {
                        return Type::Custom(name, args);
                    }

                    let mangled = format!("{}_{}", self.current_module_name, name);
                    if self.enum_names.contains(&mangled) {
                        return Type::Enum(mangled, args);
                    }
                    if self.structs.contains_key(&mangled) {
                        return Type::Custom(mangled, args);
                    }

                    if self.structs.contains_key(&name) {
                        return Type::Custom(name, args);
                    }

                    if let Some(pos) = name.find('.') {
                        let alias = &name[..pos];
                        let sname = &name[pos + 1..];
                        if let Some(real_mod) = self.current_imports.get(alias) {
                            let mangled = format!("{}_{}", real_mod, sname);
                            if self.enum_names.contains(&mangled) {
                                return Type::Enum(mangled, args);
                            }
                            return Type::Custom(mangled, args);
                        }
                    }
                    Type::Custom(mangled, args)
                } else {
                    let suffix = self.mangle_name("", &args);

                    let (origin_mod, origin_struct_name) = if let Some(pos) = name.find('.') {
                        let alias = &name[..pos];
                        if !self.current_imports.contains_key(alias) {
                            eprintln!(
                                "[SEM] PANIC AHEAD: Alias '{}' not found in imports for type '{}'",
                                alias, name
                            );
                            eprintln!("[SEM] Current Imports: {:?}", self.current_imports);
                        }
                        (
                            self.current_imports.get(alias).cloned().unwrap(),
                            name[pos + 1..].to_string(),
                        )
                    } else if let Some(real_mod) = self.current_imports.get(&name) {
                        (real_mod.clone(), name.clone())
                    } else if let Some((_, mod_name)) = self.generic_structs.get(&name) {
                        (mod_name.clone(), name.clone())
                    } else {
                        (self.current_module_name.clone(), name.clone())
                    };

                    let mangled_base = if name.contains('.') {
                        let sname = name.split('.').next_back().unwrap();
                        format!("{}_{}", origin_mod, sname)
                    } else {
                        format!("{}_{}", origin_mod, name)
                    };

                    let concrete_name = format!("{}_{}", mangled_base, suffix);

                    if self.structs.contains_key(&concrete_name) {
                        return Type::Custom(concrete_name, vec![]);
                    }

                    let generic_lookup = self
                        .generic_structs
                        .get(&origin_struct_name)
                        .cloned()
                        .or_else(|| self.generic_structs.get(&name).cloned());
                    let (generic_decl, origin_mod_found) = if let Some(val) = generic_lookup {
                        val
                    } else {
                        // Lookup external
                        let mut found = None;
                        for module in self.analyzed_modules.values() {
                            if let Some(val) = module
                                .generic_structs
                                .get(&origin_struct_name)
                                .cloned()
                                .or_else(|| module.generic_structs.get(&name).cloned())
                            {
                                found = Some(val);
                                break;
                            }
                        }
                        if let Some(val) = found {
                            val
                        } else {
                            // If still not found, return as is (maybe not generic or not found)
                            return Type::Custom(concrete_name, args.to_vec()); // Or panic?
                        }
                    };

                    let mangled_base_found = format!("{}_{}", origin_mod_found, generic_decl.name);
                    let concrete_name = format!("{}_{}", mangled_base_found, suffix);

                    let mut mapping = HashMap::new();
                    for (i, param) in generic_decl.generic_params.iter().enumerate() {
                        if i < args.len() {
                            mapping.insert(param.clone(), self.mangle_type(args[i].clone()));
                        }
                    }
                    let mut new_decl = generic_decl.clone();
                    new_decl.name = concrete_name.clone();
                    new_decl.generic_params.clear();
                    for field in &mut new_decl.fields {
                        field.1 = self.substitute_type(&field.1, &mapping);
                        field.1 = self.mangle_type(field.1.clone());
                    }
                    self.structs.insert(
                        concrete_name.clone(),
                        (new_decl.clone(), origin_mod.clone()),
                    );

                    let impl_lookup =
                        self.generic_impls
                            .get(&generic_decl.name)
                            .cloned()
                            .or_else(|| {
                                let mut found = None;
                                for module in self.analyzed_modules.values() {
                                    if let Some(val) =
                                        module.generic_impls.get(&generic_decl.name).cloned()
                                    {
                                        found = Some(val);
                                        break;
                                    }
                                }
                                found
                            });

                    if let Some((impl_decl, _)) = impl_lookup {
                        for method in &impl_decl.methods {
                            let _ = self.instantiate_function_from_decl(
                                method.clone(),
                                &mapping,
                                &concrete_name,
                                &origin_mod,
                            );
                        }
                    }
                    Type::Custom(concrete_name, vec![])
                }
            }
            Type::Array(inner, size) => Type::Array(Box::new(self.mangle_type(*inner)), size),
            Type::Pointer(inner) => Type::Pointer(Box::new(self.mangle_type(*inner))),
            _ => typ,
        }
    }

    fn mangle_type_in_discovery(
        &self,
        typ: Type,
        mod_name: &str,
        skip_names: &HashSet<String>,
    ) -> Type {
        match typ {
            Type::Custom(name, args) => {
                let mangled_args: Vec<Type> = args
                    .iter()
                    .map(|t| self.mangle_type_in_discovery(t.clone(), mod_name, skip_names))
                    .collect();
                if name.contains('_') || skip_names.contains(&name) {
                    return Type::Custom(name, mangled_args);
                }
                let (final_mod, final_name) = if let Some(pos) = name.find('.') {
                    let alias = &name[..pos];
                    let real_mod = self
                        .current_imports
                        .get(alias)
                        .cloned()
                        .unwrap_or(alias.to_string());
                    (real_mod, name[pos + 1..].to_string())
                } else {
                    (mod_name.to_string(), name)
                };
                let mangled = format!("{}_{}", final_mod, final_name);
                if self.enum_names.contains(&mangled) {
                    return Type::Enum(mangled, mangled_args);
                }
                Type::Custom(mangled, mangled_args)
            }
            Type::Array(inner, size) => Type::Array(
                Box::new(self.mangle_type_in_discovery(*inner, mod_name, skip_names)),
                size,
            ),
            Type::Pointer(inner) => Type::Pointer(Box::new(
                self.mangle_type_in_discovery(*inner, mod_name, skip_names),
            )),
            _ => typ,
        }
    }

    pub fn analyze_main(&mut self, main_path: PathBuf) -> Result<Vec<TModule>, CompileError> {
        self.analyze_module_recursive(main_path)?;
        Ok(self.analyzed_modules.values().cloned().collect())
    }

    fn analyze_module_recursive(&mut self, path: PathBuf) -> Result<String, CompileError> {
        let abs_path = fs::canonicalize(&path)
            .map_err(|e| self.cur_error(&format!("Path error: {} ({})", e, path.display())))?;
        let mod_name = abs_path.file_stem().unwrap().to_string_lossy().to_string();

        if self.analyzed_modules.contains_key(&mod_name) {
            return Ok(mod_name);
        }
        if self.processing_stack.contains(&abs_path) {
            return Err(
                self.cur_error(&format!("Circular import detected: {}", abs_path.display()))
            );
        }

        self.processing_stack.insert(abs_path.clone());
        self.parsed_files.insert(abs_path.clone());

        let source = fs::read_to_string(&abs_path)
            .map_err(|e| self.cur_error(&format!("Read error: {}", e)))?;
        let lexer = Lexer::new(&source);
        let mut parser = Parser::new(lexer);
        let program = parser.parse_program()?;
        let old_mod_name = self.current_module_name.clone();
        let old_mod_path = self.current_module_path.clone();
        let old_imports = self.current_imports.clone();
        let old_scope = self.current_scope.clone();
        let old_pending_items = std::mem::take(&mut self.pending_items);
        self.current_module_name = mod_name.clone();
        self.current_module_path = abs_path.clone();
        self.current_imports = HashMap::new();
        self.current_scope = Rc::new(RefCell::new(Scope::new()));
        self.pending_items = Vec::new();
        let mut raw_items = Vec::new();
        for item in program.items {
            match item {
                Item::Import {
                    path: imp_path,
                    alias,
                } => {
                    let mut found_path = None;

                    // 1. Check relative to current file
                    let local_path = abs_path.parent().unwrap().join(&imp_path);
                    if local_path.exists() {
                        found_path = Some(local_path);
                    } else if Path::new(&imp_path).exists() {
                        // 2. Check relative to current working directory (e.g. root)
                        found_path = Some(PathBuf::from(&imp_path));
                    } else {
                        // 3. Check in 'lib/' directory
                        let lib_try = PathBuf::from("lib").join(&imp_path);
                        if lib_try.exists() {
                            found_path = Some(lib_try);
                        } else {
                            // 4. Check in 'std/' directory
                            let std_try = PathBuf::from("std").join(&imp_path);
                            if std_try.exists() {
                                found_path = Some(std_try);
                            } else {
                                // 5. Check lib_paths
                                for lib_dir in &self.lib_paths {
                                    let lib_try = lib_dir.join(&imp_path);
                                    if lib_try.exists() {
                                        found_path = Some(lib_try);
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    if let Some(target_path) = found_path {
                        let target_mod_name = self.analyze_module_recursive(target_path)?;
                        let final_alias = alias.unwrap_or(target_mod_name.clone());
                        self.current_imports.insert(final_alias, target_mod_name);
                    } else {
                        return Err(self.cur_error(&format!("Import not found: {}", imp_path)));
                    }
                }
                _ => raw_items.push(item),
            }
        }
        let mut exports = HashMap::new();
        for item in &raw_items {
            match item {
                Item::Enum(e) => {
                    let mangled = format!("{}_{}", mod_name, e.name);
                    let mut me = e.clone();
                    let skip: std::collections::HashSet<String> =
                        e.generic_params.iter().cloned().collect();
                    for v in &mut me.variants {
                        if let Some(t) = &mut v.typ {
                            *t = self.mangle_type_in_discovery(t.clone(), &mod_name, &skip);
                        }
                    }
                    self.enum_names.insert(mangled.clone());
                    self.enum_decls_global.insert(mangled.clone(), me.clone());
                    if e.visibility == Visibility::Public {
                        exports.insert(
                            e.name.clone(),
                            Symbol {
                                name: mangled.clone(),
                                typ: Type::Enum(mangled, vec![]),
                                is_mutable: false,
                                visibility: Visibility::Public,
                            },
                        );
                    }
                }
                Item::Struct(s) => {
                    let mangled = format!("{}_{}", mod_name, s.name);
                    let mut ms = s.clone();
                    ms.name = mangled.clone();
                    let skip: HashSet<String> = s.generic_params.iter().cloned().collect();
                    for field in &mut ms.fields {
                        field.1 = self.mangle_type_in_discovery(field.1.clone(), &mod_name, &skip);
                    }
                    self.structs
                        .insert(mangled.clone(), (ms.clone(), mod_name.clone()));
                    if !s.generic_params.is_empty() {
                        let mut gs = ms.clone();
                        gs.name = s.name.clone();
                        self.generic_structs
                            .insert(s.name.clone(), (gs.clone(), mod_name.clone()));
                        self.generic_structs
                            .insert(mangled.clone(), (gs, mod_name.clone()));
                    }
                    if s.visibility == Visibility::Public {
                        exports.insert(
                            s.name.clone(),
                            Symbol {
                                name: mangled.clone(),
                                typ: Type::Custom(mangled, vec![]),
                                is_mutable: false,
                                visibility: Visibility::Public,
                            },
                        );
                    }
                }
                Item::Function(f) => {
                    let prefix = format!("{}_", mod_name);
                    let mangled = if f.name == "main" {
                        "main".to_string()
                    } else if f.name.starts_with(&prefix) {
                        f.name.clone()
                    } else {
                        format!("{}{}", prefix, f.name)
                    };
                    let skip: HashSet<String> = f.generic_params.iter().cloned().collect();
                    let pts: Vec<Type> = f
                        .params
                        .iter()
                        .map(|(_, t, _)| self.mangle_type_in_discovery(t.clone(), &mod_name, &skip))
                        .collect();
                    let ret =
                        self.mangle_type_in_discovery(f.return_type.clone(), &mod_name, &skip);
                    self.functions.insert(
                        mangled.clone(),
                        (
                            pts.clone(),
                            ret.clone(),
                            f.visibility.clone(),
                            f.is_pure,
                            mod_name.clone(),
                        ),
                    );
                    if !f.generic_params.is_empty() {
                        self.generic_functions
                            .insert(f.name.clone(), (f.clone(), mod_name.clone()));
                    }
                    if f.visibility == Visibility::Public {
                        exports.insert(
                            f.name.clone(),
                            Symbol {
                                name: mangled,
                                typ: Type::Function(pts, Box::new(ret)),
                                is_mutable: false,
                                visibility: Visibility::Public,
                            },
                        );
                    }
                }
                Item::ExternFunction(f) => {
                    let pts = f.params.iter().map(|(_, t, _)| t.clone()).collect();
                    self.functions.insert(
                        f.name.clone(),
                        (
                            pts,
                            f.return_type.clone(),
                            Visibility::Public,
                            false,
                            "extern".into(),
                        ),
                    );
                }
                Item::NativeFunction(f) => {
                    let pts: Vec<Type> = f.params.iter().map(|(_, t, _)| t.clone()).collect();
                    self.functions.insert(
                        f.name.clone(),
                        (
                            pts.clone(),
                            f.return_type.clone(),
                            f.visibility.clone(),
                            false,
                            "native".into(),
                        ),
                    );
                    if f.visibility == Visibility::Public {
                        exports.insert(
                            f.name.clone(),
                            Symbol {
                                name: f.name.clone(),
                                typ: Type::Function(pts, Box::new(f.return_type.clone())),
                                is_mutable: false,
                                visibility: Visibility::Public,
                            },
                        );
                    }
                }
                Item::Impl(i) => {
                    if !i.generic_params.is_empty() {
                        self.generic_impls
                            .insert(i.struct_name.clone(), (i.clone(), mod_name.clone()));
                    }
                    for m in &i.methods {
                        let mangled = format!("{}_{}_{}", mod_name, i.struct_name, m.name);
                        let mut skip: HashSet<String> = m.generic_params.iter().cloned().collect();
                        skip.extend(i.generic_params.iter().cloned());
                        let pts: Vec<Type> = m
                            .params
                            .iter()
                            .map(|(_, t, _)| {
                                self.mangle_type_in_discovery(t.clone(), &mod_name, &skip)
                            })
                            .collect();
                        let ret =
                            self.mangle_type_in_discovery(m.return_type.clone(), &mod_name, &skip);
                        self.functions.insert(
                            mangled.clone(),
                            (
                                pts.clone(),
                                ret.clone(),
                                m.visibility.clone(),
                                m.is_pure,
                                mod_name.clone(),
                            ),
                        );
                    }
                }
                _ => {}
            }
        }
        let mut t_items = Vec::new();
        for item in raw_items {
            match item {
                Item::Impl(i) => {
                    if i.generic_params.is_empty() {
                        for mut m in i.methods {
                            m.name = format!("{}_{}", i.struct_name, m.name);
                            t_items.push(TItem::Function(self.analyze_function(m)?));
                        }
                    }
                }
                Item::Function(f) => {
                    if f.generic_params.is_empty() {
                        t_items.push(TItem::Function(self.analyze_function(f)?));
                    }
                }
                Item::ExternFunction(f) => {
                    t_items.push(TItem::ExternFunction(TExternFunctionDecl {
                        name: f.name,
                        params: f.params,
                        return_type: f.return_type,
                    }));
                }
                Item::NativeFunction(f) => {
                    t_items.push(TItem::NativeFunction(TNativeFunctionDecl {
                        name: f.name,
                        params: f.params,
                        return_type: f.return_type,
                        visibility: f.visibility,
                    }));
                }
                Item::Struct(s) => {
                    let mut ms = s.clone();
                    ms.name = format!("{}_{}", mod_name, s.name);
                    let skip: HashSet<String> = s.generic_params.iter().cloned().collect();
                    for field in &mut ms.fields {
                        field.1 = self.mangle_type_in_discovery(field.1.clone(), &mod_name, &skip);
                    }
                    self.structs
                        .insert(ms.name.clone(), (ms.clone(), mod_name.clone()));
                    t_items.push(TItem::Struct(ms));
                }
                Item::Enum(e) => {
                    let mut me = e.clone();
                    me.name = format!("{}_{}", mod_name, e.name);
                    let skip: HashSet<String> = e.generic_params.iter().cloned().collect();
                    for variant in &mut me.variants {
                        if let Some(vt) = &variant.typ {
                            variant.typ =
                                Some(self.mangle_type_in_discovery(vt.clone(), &mod_name, &skip));
                        }
                    }
                    t_items.push(TItem::Enum(me));
                }
                _ => {}
            }
        }

        self.process_instantiation_queue()?;
        t_items.append(&mut self.pending_items);

        let mut final_structs = HashMap::new();
        let mut final_enums = HashMap::new();
        for item in &t_items {
            match item {
                TItem::Struct(s) => {
                    final_structs.insert(s.name.clone(), s.clone());
                }
                TItem::Enum(e) => {
                    final_enums.insert(e.name.clone(), e.clone());
                }
                _ => {}
            }
        }
        self.analyzed_modules.insert(
            mod_name.clone(),
            TModule {
                name: mod_name.clone(),
                items: t_items,
                exports,
                imports: self.current_imports.clone(),
                struct_decls: final_structs,
                enum_decls: final_enums,
                generic_structs: self.generic_structs.clone(),
                generic_impls: self.generic_impls.clone(),
            },
        );

        self.processing_stack.remove(&abs_path);
        self.current_module_name = old_mod_name;
        self.current_module_path = old_mod_path;
        self.current_imports = old_imports;
        self.current_scope = old_scope;
        self.pending_items = old_pending_items;
        Ok(mod_name)
    }

    fn resolve_qualified_identifier(&self, name: &str) -> Result<Symbol, CompileError> {
        if name == "print" {
            return Ok(Symbol {
                name: "print".into(),
                typ: Type::Function(vec![Type::String], Box::new(Type::Void)),
                is_mutable: false,
                visibility: Visibility::Public,
            });
        }
        if name == "lunite_print_int" {
            return Ok(Symbol {
                name: "lunite_print_int".into(),
                typ: Type::Function(vec![Type::Int], Box::new(Type::Void)),
                is_mutable: false,
                visibility: Visibility::Public,
            });
        }
        if name == "lunite_print" {
            return Ok(Symbol {
                name: "lunite_print".into(),
                typ: Type::Function(vec![Type::String], Box::new(Type::Void)),
                is_mutable: false,
                visibility: Visibility::Public,
            });
        }
        if name == "lunite_print_float" {
            return Ok(Symbol {
                name: "lunite_print_float".into(),
                typ: Type::Function(vec![Type::Float], Box::new(Type::Void)),
                is_mutable: false,
                visibility: Visibility::Public,
            });
        }
        if name == "lunite_alloc" {
            return Ok(Symbol {
                name: "lunite_alloc".into(),
                typ: Type::Function(
                    vec![
                        Type::Int,
                        Type::Pointer(Box::new(Type::Void)),
                        Type::Pointer(Box::new(Type::Void)),
                    ],
                    Box::new(Type::Pointer(Box::new(Type::Void))),
                ),
                is_mutable: false,
                visibility: Visibility::Public,
            });
        }
        if name == "lunite_str_concat" {
            return Ok(Symbol {
                name: "lunite_str_concat".into(),
                typ: Type::Function(vec![Type::String, Type::String], Box::new(Type::String)),
                is_mutable: false,
                visibility: Visibility::Public,
            });
        }
        if name == "lunite_str_at" {
            return Ok(Symbol {
                name: "lunite_str_at".into(),
                typ: Type::Function(vec![Type::String, Type::Int], Box::new(Type::Int)),
                is_mutable: false,
                visibility: Visibility::Public,
            });
        }
        if name == "lunite_str_len_runtime" {
            return Ok(Symbol {
                name: "lunite_str_len_runtime".into(),
                typ: Type::Function(vec![Type::String], Box::new(Type::Int)),
                is_mutable: false,
                visibility: Visibility::Public,
            });
        }
        if name == "lunite_str_substring" {
            return Ok(Symbol {
                name: "lunite_str_substring".into(),
                typ: Type::Function(
                    vec![Type::String, Type::Int, Type::Int],
                    Box::new(Type::String),
                ),
                is_mutable: false,
                visibility: Visibility::Public,
            });
        }
        if name == "lunite_io_read_file" {
            return Ok(Symbol {
                name: "lunite_io_read_file".into(),
                typ: Type::Function(
                    vec![Type::String],
                    Box::new(Type::Result(Box::new(Type::String), Box::new(Type::String))),
                ),
                is_mutable: false,
                visibility: Visibility::Public,
            });
        }
        if name == "lunite_io_read_file_str" {
            return Ok(Symbol {
                name: "lunite_io_read_file_str".into(),
                typ: Type::Function(vec![Type::String], Box::new(Type::String)),
                is_mutable: false,
                visibility: Visibility::Public,
            });
        }
        if name == "lunite_realloc" {
            return Ok(Symbol {
                name: "lunite_realloc".into(),
                typ: Type::Function(
                    vec![Type::Pointer(Box::new(Type::Void)), Type::Int, Type::Int],
                    Box::new(Type::Pointer(Box::new(Type::Void))),
                ),
                is_mutable: false,
                visibility: Visibility::Public,
            });
        }
        if name == "lunite_array_copy" {
            return Ok(Symbol {
                name: "lunite_array_copy".into(),
                typ: Type::Function(
                    vec![
                        Type::Pointer(Box::new(Type::Void)),
                        Type::Pointer(Box::new(Type::Void)),
                        Type::Int,
                        Type::Int,
                    ],
                    Box::new(Type::Void),
                ),
                is_mutable: false,
                visibility: Visibility::Public,
            });
        }
        if name == "lunite_sys_system" {
            return Ok(Symbol {
                name: "lunite_sys_system".into(),
                typ: Type::Function(vec![Type::String], Box::new(Type::Int)),
                is_mutable: false,
                visibility: Visibility::Public,
            });
        }
        if name == "lunite_sys_exit" {
            return Ok(Symbol {
                name: "lunite_sys_exit".into(),
                typ: Type::Function(vec![Type::Int], Box::new(Type::Void)),
                is_mutable: false,
                visibility: Visibility::Public,
            });
        }
        if name == "lunite_time_now" {
            return Ok(Symbol {
                name: "lunite_time_now".into(),
                typ: Type::Function(vec![], Box::new(Type::Int)),
                is_mutable: false,
                visibility: Visibility::Public,
            });
        }
        if name == "lunite_time_sleep" {
            return Ok(Symbol {
                name: "lunite_time_sleep".into(),
                typ: Type::Function(vec![Type::Int], Box::new(Type::Void)),
                is_mutable: false,
                visibility: Visibility::Public,
            });
        }
        if name == "lunite_srand" {
            return Ok(Symbol {
                name: "lunite_srand".into(),
                typ: Type::Function(vec![Type::Int], Box::new(Type::Void)),
                is_mutable: false,
                visibility: Visibility::Public,
            });
        }
        if name == "lunite_rand_int" {
            return Ok(Symbol {
                name: "lunite_rand_int".into(),
                typ: Type::Function(vec![], Box::new(Type::Int)),
                is_mutable: false,
                visibility: Visibility::Public,
            });
        }

        if let Some(pos) = name.find('.') {
            let alias = &name[..pos];
            let member = &name[pos + 1..];
            if let Some(real_mod) = self.current_imports.get(alias) {
                let target_mod = self
                    .analyzed_modules
                    .get(real_mod)
                    .ok_or_else(|| self.cur_error("Module not analyzed"))?;
                if let Some(sym) = target_mod.exports.get(member) {
                    return Ok(sym.clone());
                }
                return Err(
                    self.cur_error(&format!("Module '{}' does not export '{}'", alias, member))
                );
            }
        }

        // Priority 1: Local Scope (Shadowing)
        if let Some(sym) = self.current_scope.borrow().lookup(name) {
            return Ok(sym);
        }

        // Priority 2: Global Functions (already mangled)
        if let Some((pts, ret, vis, _, _)) = self.functions.get(name) {
            return Ok(Symbol {
                name: name.to_string(),
                typ: Type::Function(pts.clone(), Box::new(ret.clone())),
                is_mutable: false,
                visibility: vis.clone(),
            });
        }

        // Priority 2.5: Try stripping prefix if it was added incorrectly
        let prefix = format!("{}_", self.current_module_name);
        if name.starts_with(&prefix) {
            let stripped = &name[prefix.len()..];
            if let Some((pts, ret, vis, _, _)) = self.functions.get(stripped) {
                return Ok(Symbol {
                    name: stripped.to_string(),
                    typ: Type::Function(pts.clone(), Box::new(ret.clone())),
                    is_mutable: false,
                    visibility: vis.clone(),
                });
            }
        }

        // Priority 3: Current Module Prefix
        if !name.starts_with(&prefix) {
            let current_mangled = format!("{}{}", prefix, name);
            if let Some((pts, ret, vis, _, _)) = self.functions.get(&current_mangled) {
                return Ok(Symbol {
                    name: current_mangled,
                    typ: Type::Function(pts.clone(), Box::new(ret.clone())),
                    is_mutable: false,
                    visibility: vis.clone(),
                });
            }
        }

        for real_mod in self.current_imports.values() {
            if let Some(target_mod) = self.analyzed_modules.get(real_mod) {
                if let Some(sym) = target_mod.exports.get(name) {
                    return Ok(sym.clone());
                }
            }
        }

        // Check for Structs and Enums
        let mangled_type = format!("{}_{}", self.current_module_name, name);
        if self.structs.contains_key(&mangled_type) {
            return Ok(Symbol {
                name: mangled_type.clone(),
                typ: Type::Custom(mangled_type, vec![]),
                is_mutable: false,
                visibility: Visibility::Public,
            });
        }
        if self.enum_names.contains(&mangled_type) {
            return Ok(Symbol {
                name: mangled_type.clone(),
                typ: Type::Enum(mangled_type, vec![]),
                is_mutable: false,
                visibility: Visibility::Public,
            });
        }
        if self.structs.contains_key(name) {
            return Ok(Symbol {
                name: name.to_string(),
                typ: Type::Custom(name.to_string(), vec![]),
                is_mutable: false,
                visibility: Visibility::Public,
            });
        }
        if self.enum_names.contains(name) {
            return Ok(Symbol {
                name: name.to_string(),
                typ: Type::Enum(name.to_string(), vec![]),
                is_mutable: false,
                visibility: Visibility::Public,
            });
        }

        Err(self.cur_error(&format!("Undefined variable '{}'", name)))
    }

    fn analyze_function(&mut self, f: FunctionDecl) -> Result<TFunctionDecl, CompileError> {
        let old_pure = self.in_pure_context;
        self.in_pure_context = f.is_pure;
        let old_ret = self.current_return_type.clone();

        // Pre-mangle return type to store in context
        let ret_type = self.mangle_type(f.return_type.clone());
        self.current_return_type = Some(ret_type.clone());

        self.enter_scope();
        let prefix = format!("{}_", self.current_module_name);
        let mangled = if f.name == "main" {
            "main".into()
        } else if f.name.starts_with(&prefix) {
            f.name.clone()
        } else {
            format!("{}{}", prefix, f.name)
        };
        // eprintln!("[SEM] Analyze Func: {} -> {}", f.name, mangled);
        let mut typed_params = Vec::new();
        for (name, typ, is_mut) in f.params {
            let mt = self.mangle_type(typ);
            self.current_scope.borrow_mut().insert(
                name.clone(),
                Symbol {
                    name: name.clone(),
                    typ: mt.clone(),
                    is_mutable: is_mut,
                    visibility: Visibility::Private,
                },
            );
            typed_params.push((name, mt, is_mut));
        }
        // ret_type is already mangled
        let body = self.analyze_block(f.body)?;
        self.exit_scope();
        self.in_pure_context = old_pure;
        self.current_return_type = old_ret;
        Ok(TFunctionDecl {
            name: mangled,
            params: typed_params,
            return_type: ret_type,
            body,
            visibility: f.visibility,
            is_pure: f.is_pure,
        })
    }

    fn analyze_block(&mut self, block: Block) -> Result<TBlock, CompileError> {
        let mut stmts = Vec::new();
        for s in block.statements {
            stmts.push(self.analyze_statement(s)?);
        }
        Ok(TBlock { statements: stmts })
    }

    fn analyze_statement(&mut self, stmt: Statement) -> Result<TStatement, CompileError> {
        match stmt {
            Statement::Let {
                name,
                is_mutable,
                type_name,
                value,
            } => {
                let te = if let Some(e) = value {
                    Some(self.analyze_expression(e)?)
                } else {
                    None
                };
                let typ = if let Some(t) = type_name {
                    self.mangle_type(t)
                } else {
                    te.as_ref().unwrap().typ.clone()
                };
                self.current_scope.borrow_mut().insert(
                    name.clone(),
                    Symbol {
                        name: name.clone(),
                        typ: typ.clone(),
                        is_mutable,
                        visibility: Visibility::Private,
                    },
                );
                Ok(TStatement::Let {
                    name,
                    var_type: typ,
                    value: te,
                })
            }
            Statement::Expr(e) => Ok(TStatement::Expr(self.analyze_expression(e)?)),
            Statement::Assign { lvalue, value } => Ok(TStatement::Assign {
                lvalue: self.analyze_expression(lvalue)?,
                rvalue: self.analyze_expression(value)?,
            }),
            Statement::If {
                condition,
                then_branch,
                else_branch,
            } => Ok(TStatement::If {
                condition: self.analyze_expression(condition)?,
                then_block: self.analyze_block(then_branch)?,
                else_block: else_branch.map(|b| self.analyze_block(b)).transpose()?,
            }),
            Statement::While { condition, body } => Ok(TStatement::While {
                condition: self.analyze_expression(condition)?,
                body: self.analyze_block(body)?,
            }),
            Statement::Return(oe) => Ok(TStatement::Return(
                oe.map(|e| self.analyze_expression(e)).transpose()?,
            )),
            Statement::Throw { value } => Ok(TStatement::Throw {
                value: self.analyze_expression(value)?,
            }),
            Statement::Spawn(value) => Ok(TStatement::Spawn(self.analyze_expression(value)?)),
            Statement::TryCatch {
                try_block,
                catch_variable,
                catch_block,
            } => {
                let t_try = self.analyze_block(try_block)?;
                self.enter_scope();
                self.current_scope.borrow_mut().insert(
                    catch_variable.clone(),
                    Symbol {
                        name: catch_variable.clone(),
                        typ: Type::String,
                        is_mutable: false,
                        visibility: Visibility::Private,
                    },
                );
                let t_catch = self.analyze_block(catch_block)?;
                self.exit_scope();
                Ok(TStatement::TryCatch {
                    try_block: t_try,
                    catch_variable,
                    catch_block: t_catch,
                })
            }
            Statement::When { subject, arms } => {
                let t_subj = self.analyze_expression(subject)?;
                let mut t_arms = Vec::new();
                for arm in arms {
                    self.enter_scope();
                    let t_pat = match arm.pattern {
                        crate::ast::WhenPattern::Literal(l) => {
                            TWhenPattern::Literal(self.analyze_expression(l)?)
                        }
                        crate::ast::WhenPattern::Else => TWhenPattern::Else,
                        crate::ast::WhenPattern::EnumVariant {
                            enum_name,
                            variant_name,
                            binding,
                        } => {
                            let mangled_enum = if let Some(pos) = enum_name.find('.') {
                                let alias = &enum_name[..pos];
                                let real_mod = self
                                    .current_imports
                                    .get(alias)
                                    .ok_or_else(|| self.cur_error("Module not found"))?;
                                format!("{}_{}", real_mod, &enum_name[pos + 1..])
                            } else {
                                format!("{}_{}", self.current_module_name, enum_name)
                            };
                            let mut tag = 0;
                            let mut actual_binding = None;
                            if let Some(ed) = self.enum_decls_global.get(&mangled_enum) {
                                if let Some(pos) =
                                    ed.variants.iter().position(|v| v.name == variant_name)
                                {
                                    tag = pos as u32;
                                    if let Some(b_name) = &binding {
                                        if let Some(v_type) = &ed.variants[pos].typ {
                                            let mut resolved_type = v_type.clone();
                                            let mut mapping = std::collections::HashMap::new();
                                            if let Type::Custom(_, type_args)
                                            | Type::Enum(_, type_args) = &t_subj.typ
                                            {
                                                for (i, param) in
                                                    ed.generic_params.iter().enumerate()
                                                {
                                                    if i < type_args.len() {
                                                        mapping.insert(
                                                            param.clone(),
                                                            type_args[i].clone(),
                                                        );
                                                    }
                                                }
                                                resolved_type =
                                                    self.substitute_type(v_type, &mapping);
                                            }

                                            self.current_scope.borrow_mut().insert(
                                                b_name.clone(),
                                                Symbol {
                                                    name: b_name.clone(),
                                                    typ: resolved_type,
                                                    is_mutable: false,
                                                    visibility: Visibility::Private,
                                                },
                                            );
                                            actual_binding = Some(b_name.clone());
                                        }
                                    }
                                }
                            }
                            TWhenPattern::EnumVariant {
                                enum_name: mangled_enum,
                                variant_name,
                                binding: actual_binding,
                                tag,
                            }
                        }
                        _ => TWhenPattern::Else,
                    };
                    let t_body = self.analyze_block(arm.body)?;
                    self.exit_scope();
                    t_arms.push(TWhenArm {
                        pattern: t_pat,
                        body: t_body,
                    });
                }
                Ok(TStatement::When {
                    subject: t_subj,
                    arms: t_arms,
                })
            }
            Statement::Region { body } => Ok(TStatement::Region {
                body: self.analyze_block(body)?,
            }),
            Statement::Break => Ok(TStatement::Break),
            Statement::Block(body) => Ok(TStatement::Block(self.analyze_block(body)?)),
            _ => Err(self.cur_error(&format!("Unhandled statement: {:?}", stmt))),
        }
    }

    fn analyze_expression(&mut self, expr: Expression) -> Result<TExpression, CompileError> {
        match expr {
            Expression::Try { expression } => {
                let te = self.analyze_expression(*expression)?;
                match &te.typ.clone() {
                    Type::Result(ok, err) => {
                        if let Some(Type::Result(_, cur_err)) = &self.current_return_type {
                            if err != cur_err {
                                return Err(self.cur_error(&format!(
                                    "Try operator error type mismatch: Expected {:?}, got {:?}",
                                    cur_err, err
                                )));
                            }
                        } else {
                            return Err(self.cur_error("The try operator '?' can only be used in functions that return a Result type."));
                        }
                        Ok(TExpression {
                            kind: TExpressionKind::Try {
                                expression: Box::new(te),
                            },
                            typ: *ok.clone(),
                        })
                    }
                    _ => Err(self.cur_error(
                        "The try operator '?' can only be applied to expressions of type Result.",
                    )),
                }
            }
            Expression::Call {
                function,
                args,
                type_args,
            } => {
                self.process_instantiation_queue()?;
                if let Expression::MemberAccess { object, field } = *function.clone() {
                    let (inner_obj, extracted_targs) = if let Expression::GenericSpecialization {
                        expression,
                        type_args,
                    } = *object.clone()
                    {
                        (*expression, type_args)
                    } else {
                        (*object.clone(), vec![])
                    };

                    // Unified Static / Enum Call Check
                    let mut qualified_name = None;
                    if let Expression::Identifier(name) = inner_obj.clone() {
                        qualified_name = Some(name);
                    } else if let Expression::MemberAccess {
                        object: mod_obj,
                        field: struct_name,
                    } = inner_obj.clone()
                    {
                        if let Expression::Identifier(alias) = *mod_obj {
                            qualified_name = Some(format!("{}.{}", alias, struct_name));
                        }
                    }

                    if let Some(name) = qualified_name {
                        if let Ok(sym) = self.resolve_qualified_identifier(&name) {
                            let is_type = matches!(sym.typ, Type::Custom(_, _) | Type::Enum(_, _));
                            if is_type {
                                let base_name = sym.name.clone();
                                let concrete_name = if !extracted_targs.is_empty() {
                                    let mut mangled_args = Vec::new();
                                    for t in &extracted_targs {
                                        mangled_args.push(self.mangle_type(t.clone()));
                                    }

                                    // Check if it's an Enum
                                    if let Type::Enum(_, _) = &sym.typ {
                                        let suffix = self.mangle_name("", &mangled_args);
                                        let mangled_enum_name = format!("{}_{}", base_name, suffix);
                                        // Instantiate Enum Manually if not exists
                                        if !self.enum_decls_global.contains_key(&mangled_enum_name)
                                        {
                                            // Find generic key
                                            // Hack: Look for base_name in enum_decls_global assuming it stores generic decl?
                                            // Or search enum_decls_global keys ending with base_name?
                                            // Since we don't have generic_enums map, we try to use base_name.
                                            // But base_name is fully qualified e.g. std_ast_Option.
                                            // Note: This requires the generic decl to be registered already.

                                            let mut found_decl = None;
                                            if let Some(decl) =
                                                self.enum_decls_global.get(&base_name)
                                            {
                                                found_decl = Some(decl.clone());
                                            }

                                            if let Some(mut decl) = found_decl {
                                                decl.name = mangled_enum_name.clone();
                                                let mut mapping = HashMap::new();
                                                for (i, param) in
                                                    decl.generic_params.iter().enumerate()
                                                {
                                                    if i < mangled_args.len() {
                                                        mapping.insert(
                                                            param.clone(),
                                                            mangled_args[i].clone(),
                                                        );
                                                    }
                                                }
                                                decl.generic_params.clear();
                                                for variant in &mut decl.variants {
                                                    if let Some(t) = &variant.typ {
                                                        variant.typ =
                                                            Some(self.substitute_type(t, &mapping));
                                                        variant.typ = Some(self.mangle_type(
                                                            variant.typ.clone().unwrap(),
                                                        ));
                                                    }
                                                }
                                                self.enum_decls_global
                                                    .insert(mangled_enum_name.clone(), decl);
                                                self.enum_names.insert(mangled_enum_name.clone());
                                            }
                                        }
                                        mangled_enum_name
                                    } else {
                                        let instantiated =
                                            self.instantiate_struct(&base_name, &mangled_args)?;
                                        self.process_instantiation_queue()?;
                                        instantiated
                                    }
                                } else {
                                    base_name
                                };
                                let mangled_method = format!("{}_{}", concrete_name, field);

                                if let Some((_, ret, _, is_pure, _)) =
                                    self.functions.get(&mangled_method).cloned()
                                {
                                    if self.in_pure_context && !is_pure {
                                        return Err(self.cur_error("Pure call impure"));
                                    }
                                    let mut tas = Vec::new();
                                    for a in args {
                                        tas.push(self.analyze_expression(a)?);
                                    }
                                    return Ok(TExpression {
                                        kind: TExpressionKind::Call {
                                            function: mangled_method,
                                            args: tas,
                                        },
                                        typ: ret,
                                    });
                                }

                                // Check for Enum Variant Constructor
                                if let Type::Enum(mangled_enum, _) = &sym.typ {
                                    if let Some(ed) = self.enum_decls_global.get(mangled_enum) {
                                        if let Some(pos) =
                                            ed.variants.iter().position(|v| v.name == field)
                                        {
                                            if args.len() != 1 {
                                                return Err(self.cur_error("Enum variant constructor expects exactly 1 argument"));
                                            }
                                            let mut tas = Vec::new();
                                            for a in args {
                                                tas.push(self.analyze_expression(a)?);
                                            }
                                            return Ok(TExpression {
                                                kind: TExpressionKind::EnumInit {
                                                    enum_name: mangled_enum.clone(),
                                                    variant_name: field,
                                                    value: Some(Box::new(tas[0].clone())),
                                                    tag: pos as u32,
                                                },
                                                typ: Type::Enum(mangled_enum.clone(), vec![]),
                                            });
                                        }
                                    }
                                }
                            }
                        }
                    }

                    // Instance Method Check
                    if let Ok(tobj) = self.analyze_expression(inner_obj.clone()) {
                        if let Type::Custom(sn, struct_args) = &tobj.typ {
                            let concrete_sn = if !struct_args.is_empty() {
                                self.mangle_name(sn, struct_args)
                            } else {
                                sn.clone()
                            };
                            let mangled_method = format!("{}_{}", concrete_sn, field);
                            if self.functions.contains_key(&mangled_method) {
                                let mut tas = vec![tobj];
                                for a in args {
                                    tas.push(self.analyze_expression(a)?);
                                }
                                let ret_typ = if let Some((_, ret, _, is_pure, _)) =
                                    self.functions.get(&mangled_method)
                                {
                                    if self.in_pure_context && !is_pure {
                                        return Err(self.cur_error("Pure call impure"));
                                    }
                                    ret.clone()
                                } else {
                                    Type::Void
                                };
                                return Ok(TExpression {
                                    kind: TExpressionKind::Call {
                                        function: mangled_method,
                                        args: tas,
                                    },
                                    typ: ret_typ,
                                });
                            }

                            // Fallback to local mangling
                            let local_mangled =
                                format!("{}_{}_{}", self.current_module_name, concrete_sn, field);
                            if self.functions.contains_key(&local_mangled) {
                                let mut tas = vec![tobj];
                                for a in args {
                                    tas.push(self.analyze_expression(a)?);
                                }
                                let ret_typ = if let Some((_, ret, _, is_pure, _)) =
                                    self.functions.get(&local_mangled)
                                {
                                    if self.in_pure_context && !is_pure {
                                        return Err(self.cur_error("Pure call impure"));
                                    }
                                    ret.clone()
                                } else {
                                    Type::Void
                                };
                                return Ok(TExpression {
                                    kind: TExpressionKind::Call {
                                        function: local_mangled,
                                        args: tas,
                                    },
                                    typ: ret_typ,
                                });
                            }
                        }
                    }
                }

                // Normal Call Logic
                let fe = self.analyze_expression(*function)?;
                let (mut fnm, mut ret_typ) = match &fe.typ {
                    Type::Function(_, ret) => {
                        if let TExpressionKind::Identifier(n) = &fe.kind {
                            (n.clone(), (**ret).clone())
                        } else {
                            return Err(self.cur_error("Invalid call"));
                        }
                    }
                    _ => {
                        if let TExpressionKind::Identifier(n) = &fe.kind {
                            (n.clone(), Type::Void)
                        } else {
                            return Err(self.cur_error("Invalid call"));
                        }
                    }
                };
                if !type_args.is_empty() {
                    let mut mangled_args = Vec::new();
                    for t in &type_args {
                        mangled_args.push(self.mangle_type(t.clone()));
                    }
                    let simple_name = if fnm.starts_with(&format!("{}_", self.current_module_name))
                    {
                        &fnm[self.current_module_name.len() + 1..]
                    } else {
                        &fnm
                    };
                    let concrete_name = self.instantiate_function(simple_name, &mangled_args)?;
                    self.process_instantiation_queue()?;
                    fnm = concrete_name;
                    if let Some((_, ret, _, is_pure, _)) = self.functions.get(&fnm) {
                        if self.in_pure_context && !is_pure {
                            return Err(self.cur_error("Pure call impure"));
                        }
                        ret_typ = ret.clone();
                    }
                } else if let Some((_, _, _, is_pure, _)) = self.functions.get(&fnm) {
                    if self.in_pure_context && !is_pure {
                        return Err(self.cur_error("Pure call impure"));
                    }
                }
                let mut tas = Vec::new();
                for a in args {
                    tas.push(self.analyze_expression(a)?);
                }
                Ok(TExpression {
                    kind: TExpressionKind::Call {
                        function: fnm,
                        args: tas,
                    },
                    typ: ret_typ,
                })
            }
            Expression::Int(i) => Ok(TExpression {
                kind: TExpressionKind::Int(i),
                typ: Type::Int,
            }),
            Expression::Float(f) => Ok(TExpression {
                kind: TExpressionKind::Float(f),
                typ: Type::Float,
            }),
            Expression::String(s) => Ok(TExpression {
                kind: TExpressionKind::String(s),
                typ: Type::String,
            }),
            Expression::Boolean(b) => Ok(TExpression {
                kind: TExpressionKind::Boolean(b),
                typ: Type::Bool,
            }),
            Expression::Identifier(n) => {
                let sym = self.resolve_qualified_identifier(&n)?;
                Ok(TExpression {
                    kind: TExpressionKind::Identifier(sym.name),
                    typ: sym.typ,
                })
            }
            Expression::Binary {
                left,
                operator,
                right,
            } => {
                let tl = self.analyze_expression(*left)?;
                let tr = self.analyze_expression(*right)?;

                // Type Check
                // Type Check
                // Allow comparisons between Pointer and Void (for null checks)
                let is_ptr_void_cmp = match (&tl.typ, &tr.typ) {
                    (
                        Type::Pointer(_)
                        | Type::Custom(_, _)
                        | Type::String
                        | Type::Array(_, _)
                        | Type::Enum(_, _),
                        Type::Void,
                    ) => true,
                    (
                        Type::Void,
                        Type::Pointer(_)
                        | Type::Custom(_, _)
                        | Type::String
                        | Type::Array(_, _)
                        | Type::Enum(_, _),
                    ) => true,
                    _ => false,
                };

                if tl.typ != tr.typ && !is_ptr_void_cmp {
                    return Err(self.cur_error(&format!(
                        "Binary operator type mismatch: {:?} and {:?}",
                        tl.typ, tr.typ
                    )));
                }

                if is_ptr_void_cmp {
                    match operator {
                        TokenKind::EqualEqual | TokenKind::BangEqual => {}
                        _ => {
                            return Err(
                                self.cur_error("Invalid operator for pointer/void comparison")
                            )
                        }
                    }
                }

                let ret_typ = match operator {
                    TokenKind::EqualEqual
                    | TokenKind::BangEqual
                    | TokenKind::Less
                    | TokenKind::LessEqual
                    | TokenKind::Greater
                    | TokenKind::GreaterEqual => Type::Bool,
                    _ => tl.typ.clone(),
                };

                Ok(TExpression {
                    kind: TExpressionKind::Binary {
                        left: Box::new(tl),
                        operator,
                        right: Box::new(tr),
                    },
                    typ: ret_typ,
                })
            }
            Expression::Unary { operator, right } => {
                let tr = self.analyze_expression(*right)?;
                let ret_typ = match operator {
                    TokenKind::Ampersand => Type::Pointer(Box::new(tr.typ.clone())),
                    TokenKind::Star => {
                        if let Type::Pointer(inner) = tr.typ.clone() {
                            *inner
                        } else {
                            return Err(self.cur_error("Cannot dereference non-pointer type"));
                        }
                    }
                    _ => tr.typ.clone(),
                };
                Ok(TExpression {
                    kind: TExpressionKind::Unary {
                        operator,
                        right: Box::new(tr.clone()),
                    },
                    typ: ret_typ,
                })
            }
            Expression::MemberAccess { object, field } => {
                let (inner_obj, extracted_targs) = if let Expression::GenericSpecialization {
                    expression,
                    type_args,
                } = *object.clone()
                {
                    (*expression, type_args)
                } else {
                    (*object.clone(), vec![])
                };
                if let Expression::Identifier(alias) = inner_obj.clone() {
                    if let Some(real_mod) = self.current_imports.get(&alias).cloned() {
                        // eprintln!("[SEM] Found alias '{}' -> '{}'", alias, real_mod);
                        // eprintln!("[SEM] Available modules: {:?}", self.analyzed_modules.keys());
                        let target_mod = if let Some(m) = self.analyzed_modules.get(&real_mod) {
                            m
                        } else {
                            // Try without std_ prefix if it fails?
                            self.analyzed_modules
                                .get(&real_mod.trim_start_matches("std_").to_string())
                                .ok_or_else(|| self.cur_error("Module not analyzed"))?
                        };
                        if let Some(sym) = target_mod.exports.get(&field) {
                            return Ok(TExpression {
                                kind: TExpressionKind::Identifier(sym.name.clone()),
                                typ: sym.typ.clone(),
                            });
                        }
                    }
                }
                // Enum variant access
                let mut qualified_name = None;
                if let Expression::Identifier(name) = inner_obj.clone() {
                    qualified_name = Some(name);
                } else if let Expression::MemberAccess {
                    object: mod_obj,
                    field: struct_name,
                } = inner_obj.clone()
                {
                    if let Expression::Identifier(alias) = *mod_obj {
                        qualified_name = Some(format!("{}.{}", alias, struct_name));
                    }
                }

                if let Some(name) = qualified_name {
                    if let Ok(sym) = self.resolve_qualified_identifier(&name) {
                        if let Type::Enum(mangled_name, _) = &sym.typ {
                            if let Some(ed) = self.enum_decls_global.get(mangled_name) {
                                if let Some(pos) = ed.variants.iter().position(|v| v.name == field)
                                {
                                    return Ok(TExpression {
                                        kind: TExpressionKind::EnumInit {
                                            enum_name: mangled_name.clone(),
                                            variant_name: field,
                                            value: None,
                                            tag: pos as u32,
                                        },
                                        typ: Type::Enum(mangled_name.clone(), vec![]),
                                    });
                                }
                            }
                        }
                    }
                }

                // Static method access is handled in Call expression

                let tobj = self.analyze_expression(*object)?;
                let mut current_typ = &tobj.typ;

                // Automatic dereferencing for pointers
                if let Type::Pointer(inner) = current_typ {
                    current_typ = inner;
                }

                match current_typ {
                    Type::String if field == "len" => Ok(TExpression {
                        kind: TExpressionKind::MemberAccess {
                            object: Box::new(tobj),
                            field,
                        },
                        typ: Type::Int,
                    }),
                    Type::Custom(sn, type_args) => {
                        if let Some((s, _)) = self.structs.get(sn) {
                            if let Some(f) = s.fields.iter().find(|(n, _, _)| n == &field) {
                                let mut mapping = std::collections::HashMap::new();
                                for (i, param) in s.generic_params.iter().enumerate() {
                                    if i < type_args.len() {
                                        mapping.insert(param.clone(), type_args[i].clone());
                                    }
                                }
                                let typ = self.substitute_type(&f.1, &mapping);
                                return Ok(TExpression {
                                    kind: TExpressionKind::MemberAccess {
                                        object: Box::new(tobj),
                                        field,
                                    },
                                    typ,
                                });
                            }
                        }
                        eprintln!("[SEM] Field '{}' not found in struct '{}'", field, sn);
                        Err(self.cur_error("Field not found"))
                    }
                    _ => {
                        eprintln!(
                            "[SEM] Invalid member access on type: {:?}, field: '{}'",
                            tobj.typ, field
                        );
                        Err(self.cur_error("Invalid member access"))
                    }
                }
            }
            Expression::StructInit {
                name,
                fields,
                type_args,
            } => {
                let base_name = if let Some(pos) = name.find('.') {
                    let alias = &name[..pos];
                    let sname = &name[pos + 1..];
                    let real_mod = self
                        .current_imports
                        .get(alias)
                        .ok_or_else(|| self.cur_error("Module not found"))?;
                    format!("{}_{}", real_mod, sname)
                } else {
                    format!("{}_{}", self.current_module_name, name)
                };
                let concrete_name = if !type_args.is_empty() {
                    let mut mangled_args = Vec::new();
                    for t in &type_args {
                        mangled_args.push(self.mangle_type(t.clone()));
                    }
                    let instantiated = self.instantiate_struct(&base_name, &mangled_args)?;
                    self.process_instantiation_queue()?;
                    instantiated
                } else {
                    base_name
                };

                let mut tfs = Vec::new();
                for (fnm, fv) in fields {
                    tfs.push((fnm, self.analyze_expression(fv)?));
                }

                Ok(TExpression {
                    kind: TExpressionKind::StructInit {
                        name: concrete_name.clone(),
                        fields: tfs,
                    },
                    typ: Type::Custom(concrete_name, vec![]),
                })
            }
            Expression::Index { left, index } => {
                let tl = self.analyze_expression(*left)?;
                let ti = self.analyze_expression(*index)?;
                match tl.typ.clone() {
                    Type::Array(inner, _) | Type::Pointer(inner) => Ok(TExpression {
                        kind: TExpressionKind::Index {
                            array: Box::new(tl),
                            index: Box::new(ti),
                        },
                        typ: (*inner).clone(),
                    }),
                    _ => Err(self.cur_error("Indexing non-array")),
                }
            }
            Expression::Cast {
                expression,
                target_type,
            } => {
                let te = self.analyze_expression(*expression)?;
                let mt = self.mangle_type(target_type);
                Ok(TExpression {
                    kind: TExpressionKind::Cast {
                        expression: Box::new(te),
                        target_type: mt.clone(),
                    },
                    typ: mt,
                })
            }
            Expression::Comptime { body } => {
                self.enter_scope();
                let tbody = self.analyze_block(body)?;
                self.exit_scope();
                let mut interpreter = Interpreter::new();
                let res = interpreter.eval_block(&tbody);
                match res {
                    Ok(Some(val)) => match val {
                        Value::Int(i) => Ok(TExpression {
                            kind: TExpressionKind::Int(i),
                            typ: Type::Int,
                        }),
                        Value::Float(f) => Ok(TExpression {
                            kind: TExpressionKind::Float(f),
                            typ: Type::Float,
                        }),
                        Value::Bool(b) => Ok(TExpression {
                            kind: TExpressionKind::Boolean(b),
                            typ: Type::Bool,
                        }),
                        Value::String(s) => Ok(TExpression {
                            kind: TExpressionKind::String(s),
                            typ: Type::String,
                        }),
                        Value::Void => Ok(TExpression {
                            kind: TExpressionKind::Null,
                            typ: Type::Void,
                        }),
                    },
                    Ok(None) => Ok(TExpression {
                        kind: TExpressionKind::Null,
                        typ: Type::Void,
                    }),
                    Err(msg) => Err(self.cur_error(&msg)),
                }
            }
            Expression::ArrayLiteral { elements } => {
                let mut tes = Vec::new();
                for e in elements {
                    tes.push(self.analyze_expression(e)?);
                }
                let elem_typ = if let Some(first) = tes.first() {
                    first.typ.clone()
                } else {
                    Type::Void
                };
                let size = tes.len() as u32;
                Ok(TExpression {
                    kind: TExpressionKind::ArrayLiteral { elements: tes },
                    typ: Type::Array(Box::new(elem_typ), size),
                })
            }
            Expression::ArrayRepeat { value, size } => {
                let te = self.analyze_expression(*value)?;
                let t_typ = te.typ.clone();
                Ok(TExpression {
                    kind: TExpressionKind::ArrayRepeat {
                        value: Box::new(te),
                        size,
                    },
                    typ: Type::Array(Box::new(t_typ), size as u32),
                })
            }
            Expression::EnumInit {
                enum_name,
                variant_name,
                value,
                type_args,
            } => {
                if enum_name == "Result" {
                    let tag = if variant_name == "Ok" { 0 } else { 1 };
                    let t_val = if let Some(v) = value {
                        Some(Box::new(self.analyze_expression(*v)?))
                    } else {
                        None
                    };

                    let result_type = if type_args.len() == 2 {
                        Type::Result(
                            Box::new(self.mangle_type(type_args[0].clone())),
                            Box::new(self.mangle_type(type_args[1].clone())),
                        )
                    } else {
                        Type::Result(Box::new(Type::Int), Box::new(Type::String))
                    };

                    return Ok(TExpression {
                        kind: TExpressionKind::EnumInit {
                            enum_name: "Result".to_string(),
                            variant_name,
                            value: t_val,
                            tag,
                        },
                        typ: result_type,
                    });
                }

                let mangled = if let Some(pos) = enum_name.find('.') {
                    let alias = &enum_name[..pos];
                    let real_mod = self
                        .current_imports
                        .get(alias)
                        .ok_or_else(|| self.cur_error("Module not found"))?;
                    format!("{}_{}", real_mod, &enum_name[pos + 1..])
                } else {
                    format!("{}_{}", self.current_module_name, enum_name)
                };

                let mut tag = 0;
                if let Some(ed) = self.enum_decls_global.get(&mangled) {
                    if let Some(pos) = ed.variants.iter().position(|v| v.name == variant_name) {
                        tag = pos as u32;
                    }
                }
                let t_val = if let Some(v) = value {
                    Some(Box::new(self.analyze_expression(*v)?))
                } else {
                    None
                };
                Ok(TExpression {
                    kind: TExpressionKind::EnumInit {
                        enum_name: mangled.clone(),
                        variant_name,
                        value: t_val,
                        tag,
                    },
                    typ: Type::Enum(mangled, vec![]),
                })
            }
            Expression::Sizeof(t) => {
                let mt = self.mangle_type(t);
                Ok(TExpression {
                    kind: TExpressionKind::Sizeof(mt),
                    typ: Type::Int,
                })
            }
            _ => Ok(TExpression {
                kind: TExpressionKind::Null,
                typ: Type::Void,
            }),
        }
    }
}
