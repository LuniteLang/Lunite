use std::collections::{HashMap, HashSet};
use std::path::Path;
use inkwell::builder::Builder;
use inkwell::context::Context;
use inkwell::execution_engine::ExecutionEngine;
use inkwell::module::{Module, Linkage};
use inkwell::targets::{CodeModel, FileType, InitializationConfig, RelocMode, Target, TargetMachine};
use inkwell::types::{BasicMetadataTypeEnum, BasicType, BasicTypeEnum, StructType, IntType, PointerType};
use inkwell::values::{BasicValueEnum, FunctionValue, PointerValue, IntValue, InstructionValue, BasicValue};
use inkwell::{AddressSpace, FloatPredicate, IntPredicate, OptimizationLevel};
use inkwell::basic_block::BasicBlock;

use crate::ast::{StructDecl, EnumDecl, Type, StructLayout};
use crate::semantic::{TItem, TFunctionDecl, TExternFunctionDecl, TStatement, TExpression, TExpressionKind, TBlock, TModule, TWhenArm, TWhenPattern};
use crate::token::TokenKind;
use crate::CompileError;

pub struct CodeGenerator<'ctx> {
    pub context: &'ctx Context,
    pub module: Module<'ctx>,
    pub builder: Builder<'ctx>,
    struct_types: HashMap<String, StructType<'ctx>>,
    enum_types: HashMap<String, StructType<'ctx>>,
    struct_decls: HashMap<String, StructDecl>,
    enum_decls: HashMap<String, EnumDecl>,
    string_type: StructType<'ctx>,
    personality_fn: FunctionValue<'ctx>,
    pub extern_functions: HashSet<String>,
}

struct FunctionCompiler<'a, 'ctx> {
    gen: &'a CodeGenerator<'ctx>,
    fn_value: FunctionValue<'ctx>,
    variables: HashMap<String, (PointerValue<'ctx>, Type)>,
    scope_stack: Vec<Vec<String>>,
}

impl<'ctx> CodeGenerator<'ctx> {
    pub fn new(context: &'ctx Context) -> Self {
        Target::initialize_native(&InitializationConfig::default()).expect("Failed to init native target");
        let triple = TargetMachine::get_default_triple();
        let target = Target::from_triple(&triple).expect("Failed to create target");
        let target_machine = target.create_target_machine(&triple, "generic", "", OptimizationLevel::Aggressive, RelocMode::PIC, CodeModel::Default).expect("Failed to create machine");
        let module = context.create_module("lunite");
        module.set_data_layout(&target_machine.get_target_data().get_data_layout());
        module.set_triple(&triple);
        let builder = context.create_builder();
        let i8_ptr_type = context.ptr_type(AddressSpace::default());
        let i64_type = context.i64_type();
        let i32_type = context.i32_type();
        let result_type = context.struct_type(&[i32_type.into(), i64_type.into()], false);
        let string_type = context.struct_type(&[i8_ptr_type.into(), i64_type.into()], false);
        let void_type = context.void_type();

        module.add_function("lunite_alloc", i8_ptr_type.fn_type(&[i64_type.into(), i8_ptr_type.into(), i8_ptr_type.into()], false), None);
        module.add_function("lunite_free", void_type.fn_type(&[i8_ptr_type.into()], false), None);
        module.add_function("lunite_retain", void_type.fn_type(&[i8_ptr_type.into()], false), None);
        module.add_function("lunite_release", void_type.fn_type(&[i8_ptr_type.into()], false), None);
        module.add_function("lunite_throw", void_type.fn_type(&[i8_ptr_type.into()], false), None);
        module.add_function("lunite_arena_save", i64_type.fn_type(&[], false), None);
        module.add_function("lunite_arena_restore", void_type.fn_type(&[i64_type.into()], false), None);
        
        module.add_function("print", void_type.fn_type(&[i8_ptr_type.into()], false), None);
        module.add_function("lunite_print_int", void_type.fn_type(&[i64_type.into()], false), None);
        module.add_function("lunite_str_eq", i64_type.fn_type(&[i8_ptr_type.into(), i8_ptr_type.into()], false), None);

        let personality = module.add_function("__gxx_personality_v0", context.i32_type().fn_type(&[], true), Some(Linkage::External));
        
        let mut extern_functions = HashSet::new();
        extern_functions.insert("print".to_string());
        extern_functions.insert("lunite_alloc".to_string());
        extern_functions.insert("lunite_free".to_string());
        extern_functions.insert("lunite_retain".to_string());
        extern_functions.insert("lunite_release".to_string());

        Self { context, module, builder, struct_types: HashMap::new(), enum_types: HashMap::new(), struct_decls: HashMap::new(), enum_decls: HashMap::new(), string_type, personality_fn: personality, extern_functions }
    }

    pub fn type_to_basic_type(&self, typ: &Type) -> Option<BasicTypeEnum<'ctx>> {
        match typ {
            Type::Int => Some(self.context.i64_type().into()),
            Type::Float => Some(self.context.f64_type().into()),
            Type::Bool => Some(self.context.bool_type().into()),
            Type::String => Some(self.context.ptr_type(AddressSpace::default()).into()),
            Type::Result(_, _) | Type::Option(_) => {
                let i64_t = self.context.i64_type();
                let i32_t = self.context.i32_type();
                Some(self.context.struct_type(&[i32_t.into(), i64_t.into()], false).into())
            }
            Type::Custom(name, _) => Some(self.context.ptr_type(AddressSpace::default()).into()),
            Type::Enum(name, _) => self.enum_types.get(name).map(|st| self.context.ptr_type(AddressSpace::default()).into()).or_else(|| Some(self.context.ptr_type(AddressSpace::default()).into())),
            Type::Array(inner, size) => {
                 let et = self.type_to_basic_type(inner).unwrap_or(self.context.ptr_type(AddressSpace::default()).into());
                 Some(et.array_type(*size).ptr_type(AddressSpace::default()).into())
            }
            Type::Pointer(_) => Some(self.context.ptr_type(AddressSpace::default()).into()),
            Type::Void => None,
            _ => Some(self.context.ptr_type(AddressSpace::default()).into()),
        }
    }

    pub fn is_ref_counted(&self, typ: &Type) -> bool {
        match typ {
            Type::String | Type::Array(_, _) => true,
            Type::Custom(name, _) => {
                !name.contains("Stream") && !name.contains("Listener") && !name.contains("Channel")
            },
            _ => false,
        }
    }

    pub fn compile_modules(&mut self, modules: Vec<TModule>) -> Result<(), CompileError> {
        let tm = Target::from_triple(&TargetMachine::get_default_triple()).unwrap().create_target_machine(&TargetMachine::get_default_triple(), "generic", "", OptimizationLevel::Aggressive, RelocMode::PIC, CodeModel::Default).unwrap();
        let target_data = tm.get_target_data();

        for m in &modules {
            for (name, s) in &m.struct_decls {
                self.struct_decls.insert(name.clone(), s.clone());
                self.struct_types.insert(name.clone(), self.context.opaque_struct_type(name));
            }
            for (name, e) in &m.enum_decls {
                self.enum_decls.insert(name.clone(), e.clone());
            }
        }
        
        for (name, decl) in self.enum_decls.clone() {
            let mut max_size = 0;
            for v in &decl.variants {
                if let Some(t) = &v.typ {
                    if let Some(basic_ty) = self.type_to_basic_type(t) {
                        let size = target_data.get_store_size(&basic_ty) as u32;
                        if size > max_size { max_size = size; }
                    }
                }
            }
            if max_size == 0 { max_size = 1; }
            let tag_type = self.context.i32_type();
            let payload_type = self.context.i8_type().array_type(max_size);
            let enum_struct = self.context.struct_type(&[tag_type.into(), payload_type.into()], false);
            self.enum_types.insert(name, enum_struct);
        }

        for (name, decl) in self.struct_decls.clone() {
            let fields: Vec<_> = decl.fields.iter().map(|(_, t, _)| self.type_to_basic_type(t).unwrap()).collect();
            self.struct_types.get(&name).unwrap().set_body(&fields, false);
        }

        for m in &modules {
            for item in &m.items {
                match item {
                    TItem::Function(f) => self.compile_prototype(&f.name, &f.params, &f.return_type)?,
                    TItem::ExternFunction(f) => self.compile_prototype(&f.name, &f.params, &f.return_type)?,
                    TItem::NativeFunction(f) => self.compile_prototype(&f.name, &f.params, &f.return_type)?,
                    _ => {}
                }
            }
        }
        for m in &modules {
            for item in &m.items {
                if let TItem::Function(f) = item { self.compile_function_body(f)?; }
            }
        }
        Ok(())
    }

    fn compile_prototype(&self, name: &str, params: &Vec<(String, Type, bool)>, ret: &Type) -> Result<(), CompileError> {
        let args: Vec<BasicMetadataTypeEnum> = params.iter().map(|(_, t, _)| self.type_to_basic_type(t).unwrap().into()).collect();
        let ret_type = if name == "main" { &Type::Int } else { ret };
        let ft = match self.type_to_basic_type(ret_type) { Some(t) => t.fn_type(&args, false), None => self.context.void_type().fn_type(&args, false) };
        let fn_val = self.module.add_function(name, ft, None);
        Ok(())
    }

    fn compile_function_body(&self, f: &TFunctionDecl) -> Result<(), CompileError> {
        let fn_val = self.module.get_function(&f.name).unwrap();
        let entry = self.context.append_basic_block(fn_val, "entry");
        self.builder.position_at_end(entry);
        let mut compiler = FunctionCompiler { gen: self, fn_value: fn_val, variables: HashMap::new(), scope_stack: vec![Vec::new()] };
        for (i, (name, typ, _)) in f.params.iter().enumerate() {
            let val = fn_val.get_nth_param(i as u32).unwrap();
            let alloca = compiler.create_alloca(name, typ);
            compiler.gen.builder.build_store(alloca, val).unwrap();
            compiler.variables.insert(name.clone(), (alloca, typ.clone()));
            compiler.scope_stack.last_mut().unwrap().push(name.clone());
        }
        compiler.compile_block(&f.body)?;
        if self.builder.get_insert_block().unwrap().get_terminator().is_none() {
            compiler.cleanup_scope(0)?;
            if f.name == "main" {
                self.builder.build_return(Some(&self.context.i64_type().const_zero())).unwrap();
            } else if f.return_type == Type::Void {
                self.builder.build_return(None).unwrap();
            } else {
                self.builder.build_return(Some(&self.type_to_basic_type(&f.return_type).unwrap().const_zero())).unwrap();
            }
        }
        Ok(())
    }

    pub fn run_main(&self) {
        unsafe {
            let ee = self.module.create_jit_execution_engine(OptimizationLevel::Aggressive).unwrap();
            let main_fn = ee.get_function::<unsafe extern "C" fn()>("main");
            if let Ok(main) = main_fn { main.call(); }
        }
    }

    pub fn build_object_file(&self, path: &Path) -> Result<(), String> {
        let tm = Target::from_triple(&TargetMachine::get_default_triple()).unwrap().create_target_machine(&TargetMachine::get_default_triple(), "generic", "", OptimizationLevel::Aggressive, RelocMode::PIC, CodeModel::Default).unwrap();
        tm.write_to_file(&self.module, FileType::Object, path).map_err(|e| e.to_string())
    }
}

impl<'a, 'ctx> FunctionCompiler<'a, 'ctx> {
    fn emit_retain(&self, val: BasicValueEnum<'ctx>, typ: &Type) {
        if !self.gen.is_ref_counted(typ) { return; }
        let retain_fn = self.gen.module.get_function("lunite_retain").unwrap();
        if val.is_pointer_value() { self.gen.builder.build_call(retain_fn, &[val.into_pointer_value().into()], "").unwrap(); }
    }

    fn emit_release(&self, val: BasicValueEnum<'ctx>, typ: &Type) {
        if !self.gen.is_ref_counted(typ) { return; }
        let release_fn = self.gen.module.get_function("lunite_release").unwrap();
        if val.is_pointer_value() { self.gen.builder.build_call(release_fn, &[val.into_pointer_value().into()], "").unwrap(); }
    }

    fn create_alloca(&self, name: &str, typ: &Type) -> PointerValue<'ctx> {
        let b = self.gen.context.create_builder();
        let e = self.fn_value.get_first_basic_block().unwrap();
        match e.get_first_instruction() { Some(i) => b.position_before(&i), None => b.position_at_end(e) }
        b.build_alloca(self.gen.type_to_basic_type(typ).unwrap(), name).unwrap()
    }

    fn compile_block(&mut self, block: &TBlock) -> Result<(), CompileError> {
        self.scope_stack.push(Vec::new());
        for stmt in &block.statements { self.compile_statement(stmt)?; }
        if self.gen.builder.get_insert_block().unwrap().get_terminator().is_none() { self.cleanup_current_scope()?; }
        self.scope_stack.pop(); Ok(())
    }

    fn cleanup_scope(&self, level: usize) -> Result<(), CompileError> {
        for scope in self.scope_stack.iter().rev().take(self.scope_stack.len() - level) {
            for var in scope.iter().rev() {
                if let Some((ptr, typ)) = self.variables.get(var) {
                    if self.gen.is_ref_counted(typ) {
                        let val = self.gen.builder.build_load(self.gen.type_to_basic_type(typ).unwrap(), *ptr, "tmp").unwrap();
                        self.emit_release(val, typ);
                    }
                }
            }
        }
        Ok(())
    }

    fn cleanup_current_scope(&self) -> Result<(), CompileError> { self.cleanup_scope(self.scope_stack.len() - 1) }

    fn compile_expression(&mut self, expr: &TExpression) -> Result<BasicValueEnum<'ctx>, CompileError> {
        match &expr.kind {
            TExpressionKind::Int(v) => Ok(self.gen.context.i64_type().const_int(*v as u64, false).into()),
            TExpressionKind::Float(v) => Ok(self.gen.context.f64_type().const_float(*v).into()),
            TExpressionKind::Boolean(v) => Ok(self.gen.context.bool_type().const_int(if *v { 1 } else { 0 }, false).into()),
            TExpressionKind::String(s) => {
                let len_val = self.gen.context.i64_type().const_int(s.len() as u64, false);
                let data_ptr = self.gen.builder.build_call(self.gen.module.get_function("lunite_alloc").unwrap(), &[len_val.into(), self.gen.context.ptr_type(AddressSpace::default()).const_null().into(), self.gen.context.ptr_type(AddressSpace::default()).const_null().into()], "sdata").unwrap().try_as_basic_value().left().unwrap().into_pointer_value();
                self.gen.builder.build_memcpy(data_ptr, 1, self.gen.builder.build_global_string_ptr(s, "slit").unwrap().as_pointer_value(), 1, len_val).unwrap();
                let str_struct = self.gen.builder.build_call(self.gen.module.get_function("lunite_alloc").unwrap(), &[self.gen.context.i64_type().const_int(16, false).into(), self.gen.context.ptr_type(AddressSpace::default()).const_null().into(), self.gen.context.ptr_type(AddressSpace::default()).const_null().into()], "sstruct").unwrap().try_as_basic_value().left().unwrap().into_pointer_value();
                let cast = self.gen.builder.build_bit_cast(str_struct, self.gen.string_type.ptr_type(AddressSpace::default()), "scast").unwrap().into_pointer_value();
                let p_ptr = self.gen.builder.build_struct_gep(self.gen.string_type, cast, 0, "p").unwrap();
                let l_ptr = self.gen.builder.build_struct_gep(self.gen.string_type, cast, 1, "l").unwrap();
                self.gen.builder.build_store(p_ptr, data_ptr).unwrap();
                self.gen.builder.build_store(l_ptr, len_val).unwrap();
                Ok(cast.into())
            }
            TExpressionKind::Identifier(n) => {
                let (ptr, typ) = self.variables.get(n).ok_or_else(|| CompileError { message: format!("Var not found: {}", n), line: 0, column: 0 })?;
                Ok(self.gen.builder.build_load(self.gen.type_to_basic_type(typ).unwrap(), *ptr, n).unwrap())
            }
            TExpressionKind::Binary { left, operator, right } => {
                let lv = self.compile_expression(left)?; let rv = self.compile_expression(right)?;
                let is_f = left.typ == Type::Float || right.typ == Type::Float;
                match operator {
                    TokenKind::Plus => if is_f { Ok(self.gen.builder.build_float_add(lv.into_float_value(), rv.into_float_value(), "").unwrap().into()) } else { Ok(self.gen.builder.build_int_add(lv.into_int_value(), rv.into_int_value(), "").unwrap().into()) },
                    TokenKind::Minus => if is_f { Ok(self.gen.builder.build_float_sub(lv.into_float_value(), rv.into_float_value(), "").unwrap().into()) } else { Ok(self.gen.builder.build_int_sub(lv.into_int_value(), rv.into_int_value(), "").unwrap().into()) },
                    TokenKind::Star => if is_f { Ok(self.gen.builder.build_float_mul(lv.into_float_value(), rv.into_float_value(), "").unwrap().into()) } else { Ok(self.gen.builder.build_int_mul(lv.into_int_value(), rv.into_int_value(), "").unwrap().into()) },
                    TokenKind::Slash => if is_f { Ok(self.gen.builder.build_float_div(lv.into_float_value(), rv.into_float_value(), "").unwrap().into()) } else { Ok(self.gen.builder.build_int_signed_div(lv.into_int_value(), rv.into_int_value(), "").unwrap().into()) },
                    TokenKind::EqualEqual => {
                        if is_f { Ok(self.gen.builder.build_float_compare(FloatPredicate::OEQ, lv.into_float_value(), rv.into_float_value(), "").unwrap().into()) }
                        else if matches!(left.typ, Type::String) {
                            let eq_fn = self.gen.module.get_function("lunite_str_eq").unwrap();
                            let res = self.gen.builder.build_call(eq_fn, &[lv.into(), rv.into()], "seq").unwrap().try_as_basic_value().left().unwrap().into_int_value();
                            Ok(self.gen.builder.build_int_compare(IntPredicate::NE, res, self.gen.context.i64_type().const_zero(), "bool").unwrap().into())
                        }
                        else { Ok(self.gen.builder.build_int_compare(IntPredicate::EQ, lv.into_int_value(), rv.into_int_value(), "").unwrap().into()) }
                    },
                    TokenKind::Less => if is_f { Ok(self.gen.builder.build_float_compare(FloatPredicate::OLT, lv.into_float_value(), rv.into_float_value(), "").unwrap().into()) } else { Ok(self.gen.builder.build_int_compare(IntPredicate::SLT, lv.into_int_value(), rv.into_int_value(), "").unwrap().into()) },
                    TokenKind::Greater => if is_f { Ok(self.gen.builder.build_float_compare(FloatPredicate::OGT, lv.into_float_value(), rv.into_float_value(), "").unwrap().into()) } else { Ok(self.gen.builder.build_int_compare(IntPredicate::SGT, lv.into_int_value(), rv.into_int_value(), "").unwrap().into()) },
                    TokenKind::LessEqual => if is_f { Ok(self.gen.builder.build_float_compare(FloatPredicate::OLE, lv.into_float_value(), rv.into_float_value(), "").unwrap().into()) } else { Ok(self.gen.builder.build_int_compare(IntPredicate::SLE, lv.into_int_value(), rv.into_int_value(), "").unwrap().into()) },
                    TokenKind::GreaterEqual => if is_f { Ok(self.gen.builder.build_float_compare(FloatPredicate::OGE, lv.into_float_value(), rv.into_float_value(), "").unwrap().into()) } else { Ok(self.gen.builder.build_int_compare(IntPredicate::SGE, lv.into_int_value(), rv.into_int_value(), "").unwrap().into()) },
                    TokenKind::Percent => Ok(self.gen.builder.build_int_signed_rem(lv.into_int_value(), rv.into_int_value(), "").unwrap().into()),
                    TokenKind::Ampersand | TokenKind::AndAnd => Ok(self.gen.builder.build_and(lv.into_int_value(), rv.into_int_value(), "").unwrap().into()),
                    TokenKind::Pipe | TokenKind::PipePipe => Ok(self.gen.builder.build_or(lv.into_int_value(), rv.into_int_value(), "").unwrap().into()),
                    TokenKind::Caret => Ok(self.gen.builder.build_xor(lv.into_int_value(), rv.into_int_value(), "").unwrap().into()),
                    TokenKind::LessLess => Ok(self.gen.builder.build_left_shift(lv.into_int_value(), rv.into_int_value(), "").unwrap().into()),
                    TokenKind::GreaterGreater => Ok(self.gen.builder.build_right_shift(lv.into_int_value(), rv.into_int_value(), true, "").unwrap().into()),
                    _ => Err(CompileError { message: format!("Op {:?} not impl", operator), line: 0, column: 0 })
                }
            }
            TExpressionKind::EnumInit { enum_name, variant_name: _, value, tag } => {
                if enum_name == "Result" {
                    let i64_t = self.gen.context.i64_type();
                    let i32_t = self.gen.context.i32_type();
                    let st_ty = self.gen.context.struct_type(&[i32_t.into(), i64_t.into()], false);
                    let mut st_val = st_ty.get_undef();
                    st_val = self.gen.builder.build_insert_value(st_val, i32_t.const_int(*tag as u64, false), 0, "tag").unwrap().into_struct_value();
                    let payload = if let Some(v) = value {
                        let val = self.compile_expression(v)?;
                        self.emit_retain(val, &v.typ);
                        if val.is_pointer_value() { self.gen.builder.build_ptr_to_int(val.into_pointer_value(), i64_t, "payload").unwrap() }
                        else if val.is_float_value() { self.gen.builder.build_bit_cast(val.into_float_value(), i64_t, "payload").unwrap().into_int_value() }
                        else { val.into_int_value() }
                    } else { i64_t.const_zero() };
                    st_val = self.gen.builder.build_insert_value(st_val, payload, 1, "payload").unwrap().into_struct_value();
                    return Ok(st_val.into());
                }
                let et = self.gen.enum_types.get(enum_name).unwrap();
                let ptr = self.gen.builder.build_call(self.gen.module.get_function("lunite_alloc").unwrap(), &[et.size_of().unwrap().into(), self.gen.context.ptr_type(AddressSpace::default()).const_null().into(), self.gen.context.ptr_type(AddressSpace::default()).const_null().into()], "eptr").unwrap().try_as_basic_value().left().unwrap().into_pointer_value();
                let cast = self.gen.builder.build_bit_cast(ptr, et.ptr_type(AddressSpace::default()), "ecast").unwrap().into_pointer_value();
                let tag_ptr = self.gen.builder.build_struct_gep(*et, cast, 0, "t").unwrap();
                self.gen.builder.build_store(tag_ptr, self.gen.context.i32_type().const_int(*tag as u64, false)).unwrap();
                if let Some(v) = value {
                    let val = self.compile_expression(v)?;
                    self.emit_retain(val, &v.typ);
                    let p_ptr = self.gen.builder.build_struct_gep(*et, cast, 1, "p").unwrap();
                    let v_ty = self.gen.type_to_basic_type(&v.typ).unwrap();
                    let p_cast = self.gen.builder.build_bit_cast(p_ptr, v_ty.ptr_type(AddressSpace::default()), "pc").unwrap().into_pointer_value();
                    self.gen.builder.build_store(p_cast, val).unwrap();
                }
                Ok(cast.into())
            }
            TExpressionKind::StructInit { name, fields } => {
                let st = self.gen.struct_types.get(name).unwrap();
                let ptr = self.gen.builder.build_call(self.gen.module.get_function("lunite_alloc").unwrap(), &[st.size_of().unwrap().into(), self.gen.context.ptr_type(AddressSpace::default()).const_null().into(), self.gen.context.ptr_type(AddressSpace::default()).const_null().into()], "ptr").unwrap().try_as_basic_value().left().unwrap().into_pointer_value();
                let cast = self.gen.builder.build_bit_cast(ptr, st.ptr_type(AddressSpace::default()), "cast").unwrap().into_pointer_value();
                let sd = self.gen.struct_decls.get(name).unwrap();
                for (fnm, fv) in fields {
                    let idx = sd.fields.iter().position(|(n,_,_)| n == fnm).unwrap();
                    let fp = self.gen.builder.build_struct_gep(*st, cast, idx as u32, "fp").unwrap();
                    let val = self.compile_expression(fv)?; 
                    self.emit_retain(val, &fv.typ);
                    self.gen.builder.build_store(fp, val).unwrap();
                }
                Ok(cast.into())
            }
            TExpressionKind::Sizeof(t) => {
                let bt = match self.gen.type_to_basic_type(t) {
                    Some(ty) => ty,
                    None => self.gen.context.i8_type().into()
                };
                let tm = Target::from_triple(&TargetMachine::get_default_triple()).unwrap().create_target_machine(&TargetMachine::get_default_triple(), "generic", "", OptimizationLevel::Aggressive, RelocMode::PIC, CodeModel::Default).unwrap();
                let td = tm.get_target_data();
                Ok(self.gen.context.i64_type().const_int(td.get_store_size(&bt), false).into())
            }
            TExpressionKind::Call { function, args } => {
                let func = self.gen.module.get_function(function).ok_or_else(|| CompileError { message: format!("Unknown func {}", function), line: 0, column: 0 })?;
                let mut c_args = Vec::new();
                for arg in args {
                    let val = self.compile_expression(arg)?;
                    self.emit_retain(val, &arg.typ);
                    c_args.push(val.into());
                }
                let res = self.gen.builder.build_call(func, &c_args, "res").unwrap();
                Ok(match res.try_as_basic_value().left() { Some(v) => v, None => self.gen.context.i64_type().const_zero().into() })
            }
            TExpressionKind::MemberAccess { object, field } => {
                let op = self.compile_expression(object)?;
                if matches!(object.typ, Type::String) {
                    let len_fn = self.gen.module.get_function("lunite_str_len_runtime").unwrap();
                    return Ok(self.gen.builder.build_call(len_fn, &[op.into()], "slen").unwrap().try_as_basic_value().left().unwrap());
                }
                let sn = match &object.typ { Type::Custom(n, _) => n, _ => unreachable!() };
                let st = self.gen.struct_types.get(sn).unwrap();
                let sd = self.gen.struct_decls.get(sn).unwrap();
                let idx = sd.fields.iter().position(|(n, _, _)| n == field).unwrap();
                let fp = self.gen.builder.build_struct_gep(*st, op.into_pointer_value(), idx as u32, "fp").unwrap();
                Ok(self.gen.builder.build_load(self.gen.type_to_basic_type(&sd.fields[idx].1).unwrap(), fp, field).unwrap())
            }
            TExpressionKind::Try { expression } => {
                let val = self.compile_expression(expression)?;
                let st_val = val.into_struct_value();
                let tag = self.gen.builder.build_extract_value(st_val, 0, "tag").unwrap().into_int_value();
                let err_bb = self.gen.context.append_basic_block(self.fn_value, "try_err");
                let ok_bb = self.gen.context.append_basic_block(self.fn_value, "try_ok");
                let is_err = self.gen.builder.build_int_compare(IntPredicate::NE, tag, self.gen.context.i32_type().const_zero(), "is_err").unwrap();
                self.gen.builder.build_conditional_branch(is_err, err_bb, ok_bb).unwrap();
                self.gen.builder.position_at_end(err_bb);
                self.gen.builder.build_return(Some(&val)).unwrap();
                self.gen.builder.position_at_end(ok_bb);
                let payload = self.gen.builder.build_extract_value(st_val, 1, "ok_val").unwrap().into_int_value();
                let target_type = self.gen.type_to_basic_type(&expr.typ).unwrap();
                Ok(if target_type.is_pointer_type() { self.gen.builder.build_int_to_ptr(payload, target_type.into_pointer_type(), "to_ptr").unwrap().into() }
                   else if target_type.is_float_type() { self.gen.builder.build_bit_cast(payload, self.gen.context.f64_type(), "to_f64").unwrap().into() }
                   else { self.gen.builder.build_int_cast(payload, target_type.into_int_type(), "to_int").unwrap().into() })
            }
            _ => Ok(self.gen.context.i64_type().const_zero().into())
        }
    }

    fn compile_lvalue(&mut self, expr: &TExpression) -> Result<PointerValue<'ctx>, CompileError> {
        match &expr.kind {
            TExpressionKind::Identifier(n) => Ok(self.variables.get(n).unwrap().0),
            TExpressionKind::Index { array, index } => {
                let arr_ptr = self.compile_expression(array)?.into_pointer_value();
                let idx_val = self.compile_expression(index)?.into_int_value();
                let (inner, is_ptr) = match &array.typ { Type::Array(t, _) => (t, false), Type::Pointer(t) => (t, true), _ => unreachable!() };
                let b_ty = self.gen.type_to_basic_type(inner).unwrap();
                unsafe { 
                    if is_ptr { Ok(self.gen.builder.build_gep(b_ty, arr_ptr, &[idx_val], "ptr").unwrap()) }
                    else { Ok(self.gen.builder.build_gep(b_ty.array_type(100), arr_ptr, &[self.gen.context.i64_type().const_zero(), idx_val], "ptr").unwrap()) }
                }
            }
            TExpressionKind::MemberAccess { object, field } => {
                let obj_ptr = self.compile_expression(object)?.into_pointer_value();
                let sn = match &object.typ { Type::Custom(n, _) => n, _ => unreachable!() };
                let st = self.gen.struct_types.get(sn).unwrap();
                let sd = self.gen.struct_decls.get(sn).unwrap();
                let idx = sd.fields.iter().position(|(n, _, _)| n == field).unwrap();
                Ok(self.gen.builder.build_struct_gep(*st, obj_ptr, idx as u32, "fp").unwrap())
            }
            _ => unreachable!()
        }
    }

    fn compile_statement(&mut self, stmt: &TStatement) -> Result<(), CompileError> {
        match stmt {
            TStatement::Let { name, var_type, value } => {
                let val = if let Some(e) = value { self.compile_expression(e)? } else { self.gen.type_to_basic_type(var_type).unwrap().const_zero() };
                let alloca = self.create_alloca(name, var_type);
                self.emit_retain(val, var_type);
                self.gen.builder.build_store(alloca, val).unwrap();
                self.variables.insert(name.clone(), (alloca, var_type.clone()));
                self.scope_stack.last_mut().unwrap().push(name.clone()); Ok(())
            }
            TStatement::Assign { lvalue, rvalue } => {
                let addr = self.compile_lvalue(lvalue)?;
                let val = self.compile_expression(rvalue)?;
                if self.gen.is_ref_counted(&lvalue.typ) {
                    let old = self.gen.builder.build_load(self.gen.type_to_basic_type(&lvalue.typ).unwrap(), addr, "old").unwrap();
                    self.emit_retain(val, &lvalue.typ);
                    self.gen.builder.build_store(addr, val).unwrap();
                    self.emit_release(old, &lvalue.typ);
                } else { self.gen.builder.build_store(addr, val).unwrap(); }
                Ok(())
            }
            TStatement::Expr(e) => { self.compile_expression(e)?; Ok(()) }
            TStatement::Return(oe) => {
                let rv = oe.as_ref().map(|e| self.compile_expression(e)).transpose()?;
                if let Some(v) = rv { self.emit_retain(v, &oe.as_ref().unwrap().typ); }
                self.cleanup_scope(0)?;
                if let Some(v) = rv { self.gen.builder.build_return(Some(&v)).unwrap(); } else { self.gen.builder.build_return(None).unwrap(); }
                Ok(())
            }
            TStatement::If { condition, then_block, else_block } => {
                let cond = self.compile_expression(condition)?.into_int_value();
                let then_bb = self.gen.context.append_basic_block(self.fn_value, "then");
                let else_bb = self.gen.context.append_basic_block(self.fn_value, "else");
                let merge = self.gen.context.append_basic_block(self.fn_value, "cont");
                self.gen.builder.build_conditional_branch(cond, then_bb, else_bb).unwrap();
                self.gen.builder.position_at_end(then_bb); self.compile_block(then_block)?;
                if self.gen.builder.get_insert_block().unwrap().get_terminator().is_none() { self.gen.builder.build_unconditional_branch(merge).unwrap(); }
                self.gen.builder.position_at_end(else_bb); if let Some(b) = else_block { self.compile_block(b)?; }
                if self.gen.builder.get_insert_block().unwrap().get_terminator().is_none() { self.gen.builder.build_unconditional_branch(merge).unwrap(); }
                self.gen.builder.position_at_end(merge); Ok(())
            }
            TStatement::While { condition, body } => {
                let cond_bb = self.gen.context.append_basic_block(self.fn_value, "while_cond");
                let body_bb = self.gen.context.append_basic_block(self.fn_value, "while_body");
                let end_bb = self.gen.context.append_basic_block(self.fn_value, "while_end");
                self.gen.builder.build_unconditional_branch(cond_bb).unwrap();
                self.gen.builder.position_at_end(cond_bb);
                let cond = self.compile_expression(condition)?.into_int_value();
                self.gen.builder.build_conditional_branch(cond, body_bb, end_bb).unwrap();
                self.gen.builder.position_at_end(body_bb); self.compile_block(body)?;
                if self.gen.builder.get_insert_block().unwrap().get_terminator().is_none() { self.gen.builder.build_unconditional_branch(cond_bb).unwrap(); }
                self.gen.builder.position_at_end(end_bb); Ok(())
            }
            _ => Ok(())
        }
    }
}
