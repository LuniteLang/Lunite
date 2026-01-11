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
use inkwell::attributes::AttributeLoc;
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
    variables: HashMap<String, (VarLoc<'ctx>, Type)>,
    scope_stack: Vec<Vec<String>>,
}

#[derive(Clone, Copy, Debug)]
enum VarLoc<'ctx> {
    Stack(PointerValue<'ctx>),
    Register(BasicValueEnum<'ctx>),
}

impl<'ctx> CodeGenerator<'ctx> {
    pub fn new(context: &'ctx Context) -> Self {
        Target::initialize_native(&InitializationConfig::default()).expect("Failed to init native target");
        let triple = TargetMachine::get_default_triple();
        eprintln!("[CODEGEN] Default Triple: {:?}", triple);
        let target = Target::from_triple(&triple).expect("Failed to create target");
        let target_machine = target.create_target_machine(&triple, "generic", "", OptimizationLevel::None, RelocMode::PIC, CodeModel::Default).expect("Failed to create machine");
        eprintln!("[CODEGEN] Data Layout: {:?}", target_machine.get_target_data().get_data_layout());
        let module = context.create_module("lunite");
        module.set_data_layout(&target_machine.get_target_data().get_data_layout());
        module.set_triple(&triple);
        let builder = context.create_builder();
        let i8_ptr_type = context.ptr_type(AddressSpace::default());
        let i64_type = context.i64_type();
        let i32_type = context.i32_type();
        let result_type = context.struct_type(&[i64_type.into(), i64_type.into()], false);
        let string_type = context.struct_type(&[i8_ptr_type.into(), i64_type.into()], false);
        let void_type = context.void_type();

        module.add_function("lunite_alloc", i8_ptr_type.fn_type(&[i64_type.into(), i8_ptr_type.into(), i8_ptr_type.into()], false), None);
        module.add_function("lunite_free", void_type.fn_type(&[i8_ptr_type.into()], false), None);
        module.add_function("lunite_retain", void_type.fn_type(&[i8_ptr_type.into()], false), None);
        module.add_function("lunite_release", void_type.fn_type(&[i8_ptr_type.into()], false), None);
        module.add_function("lunite_throw", void_type.fn_type(&[i8_ptr_type.into()], false), None);
        module.add_function("lunite_arena_save", i64_type.fn_type(&[], false), None);
        module.add_function("lunite_arena_restore", void_type.fn_type(&[i64_type.into()], false), None);
        
        let str_ptr_type = string_type.ptr_type(AddressSpace::default());
        module.add_function("print", void_type.fn_type(&[str_ptr_type.into()], false), None);
        module.add_function("lunite_print_int", void_type.fn_type(&[i64_type.into()], false), None);
        module.add_function("lunite_print_float", void_type.fn_type(&[context.f64_type().into()], false), None);
        module.add_function("lunite_str_eq", i64_type.fn_type(&[str_ptr_type.into(), str_ptr_type.into()], false), None);
        module.add_function("lunite_str_len_runtime", i64_type.fn_type(&[str_ptr_type.into()], false), None);
        module.add_function("lunite_str_concat", str_ptr_type.fn_type(&[str_ptr_type.into(), str_ptr_type.into()], false), None);
        module.add_function("lunite_str_substring", str_ptr_type.fn_type(&[str_ptr_type.into(), i64_type.into(), i64_type.into()], false), None);
        module.add_function("lunite_str_at", i64_type.fn_type(&[str_ptr_type.into(), i64_type.into()], false), None);
        module.add_function("lunite_io_read_file", result_type.fn_type(&[str_ptr_type.into()], false), None);
        module.add_function("lunite_io_write_file", i64_type.fn_type(&[str_ptr_type.into(), str_ptr_type.into()], false), None);
        module.add_function("lunite_sys_system", i64_type.fn_type(&[str_ptr_type.into()], false), None);
        module.add_function("lunite_sys_exit", void_type.fn_type(&[i64_type.into()], false), None);
        module.add_function("lunite_math_pow", context.f64_type().fn_type(&[context.f64_type().into(), context.f64_type().into()], false), None);
        module.add_function("lunite_math_abs", context.f64_type().fn_type(&[context.f64_type().into()], false), None);
        module.add_function("lunite_math_ceil", context.f64_type().fn_type(&[context.f64_type().into()], false), None);
        module.add_function("lunite_math_floor", context.f64_type().fn_type(&[context.f64_type().into()], false), None);
        module.add_function("lunite_net_bind", result_type.fn_type(&[i64_type.into()], false), None);
        module.add_function("lunite_net_accept", result_type.fn_type(&[i8_ptr_type.into()], false), None);
        module.add_function("lunite_net_read", result_type.fn_type(&[i8_ptr_type.into()], false), None);
        module.add_function("lunite_net_write", void_type.fn_type(&[i8_ptr_type.into(), str_ptr_type.into()], false), None);
        module.add_function("lunite_net_close_socket", void_type.fn_type(&[i8_ptr_type.into()], false), None);
        module.add_function("lunite_net_close_server", void_type.fn_type(&[i8_ptr_type.into()], false), None);
        module.add_function("lunite_channel_create", i8_ptr_type.fn_type(&[], false), None);
        module.add_function("lunite_channel_send", void_type.fn_type(&[i8_ptr_type.into(), i64_type.into()], false), None);
        module.add_function("lunite_channel_recv", i64_type.fn_type(&[i8_ptr_type.into()], false), None);
        module.add_function("lunite_spawn", void_type.fn_type(&[i8_ptr_type.into(), i8_ptr_type.into()], false), None);
        module.add_function("lunite_time_now", i64_type.fn_type(&[], false), None);
        module.add_function("lunite_time_sleep", void_type.fn_type(&[i64_type.into()], false), None);
        module.add_function("lunite_srand", void_type.fn_type(&[i64_type.into()], false), None);
        module.add_function("lunite_rand_int", i64_type.fn_type(&[], false), None);
        module.add_function("lunite_realloc", i8_ptr_type.fn_type(&[i8_ptr_type.into(), i64_type.into(), i64_type.into()], false), None);
        module.add_function("lunite_array_copy", void_type.fn_type(&[i8_ptr_type.into(), i8_ptr_type.into(), i64_type.into(), i64_type.into()], false), None);

        let personality = module.add_function("__gxx_personality_v0", context.i32_type().fn_type(&[], true), Some(Linkage::External));
        
        let mut extern_functions = HashSet::new();
        extern_functions.insert("print".to_string());
        extern_functions.insert("lunite_alloc".to_string());
        extern_functions.insert("lunite_realloc".to_string());
        extern_functions.insert("lunite_array_copy".to_string());
        extern_functions.insert("lunite_free".to_string());
        extern_functions.insert("lunite_retain".to_string());
        extern_functions.insert("lunite_release".to_string());
        extern_functions.insert("lunite_print_int".to_string());
        extern_functions.insert("lunite_print_float".to_string());
        extern_functions.insert("lunite_str_eq".to_string());
        extern_functions.insert("lunite_str_len_runtime".to_string());
        extern_functions.insert("lunite_str_concat".to_string());
        extern_functions.insert("lunite_str_substring".to_string());
        extern_functions.insert("lunite_str_at".to_string());
        extern_functions.insert("lunite_io_read_file".to_string());
        extern_functions.insert("lunite_io_write_file".to_string());
        extern_functions.insert("lunite_sys_system".to_string());
        extern_functions.insert("lunite_sys_exit".to_string());
        extern_functions.insert("lunite_math_pow".to_string());
        extern_functions.insert("lunite_math_abs".to_string());
        extern_functions.insert("lunite_math_ceil".to_string());
        extern_functions.insert("lunite_math_floor".to_string());
        extern_functions.insert("lunite_net_bind".to_string());
        extern_functions.insert("lunite_net_accept".to_string());
        extern_functions.insert("lunite_net_read".to_string());
        extern_functions.insert("lunite_net_write".to_string());
        extern_functions.insert("lunite_net_close_socket".to_string());
        extern_functions.insert("lunite_net_close_server".to_string());
        extern_functions.insert("lunite_channel_create".to_string());
        extern_functions.insert("lunite_channel_send".to_string());
        extern_functions.insert("lunite_channel_recv".to_string());
        extern_functions.insert("lunite_spawn".to_string());
        extern_functions.insert("lunite_time_now".to_string());
        extern_functions.insert("lunite_time_sleep".to_string());
        extern_functions.insert("lunite_srand".to_string());
        extern_functions.insert("lunite_rand_int".to_string());
        extern_functions.insert("lunite_arena_save".to_string());
        extern_functions.insert("lunite_arena_restore".to_string());
        extern_functions.insert("lunite_throw".to_string());
        extern_functions.insert("__gxx_personality_v0".to_string());

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
                Some(self.context.struct_type(&[i64_t.into(), i64_t.into()], false).into())
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
            Type::String | Type::Array(_, _) | Type::Enum(_, _) | Type::Result(_, _) => true,
            Type::Custom(name, _) => {
                !name.contains("Stream") && !name.contains("Listener") && !name.contains("Channel")
            },
            _ => false,
        }
    }

    pub fn compile_modules(&mut self, modules: Vec<TModule>) -> Result<(), CompileError> {
        let tm = Target::from_triple(&TargetMachine::get_default_triple()).unwrap().create_target_machine(&TargetMachine::get_default_triple(), "generic", "", OptimizationLevel::None, RelocMode::PIC, CodeModel::Default).unwrap();
        let target_data = tm.get_target_data();

        for m in &modules {
            for (name, s) in &m.struct_decls {
                // eprintln!("[CODEGEN] Registering struct: {}", name);
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
            let tag_type = self.context.i64_type();
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
        eprintln!("[CODEGEN] Compilation finished successfully.");
        Ok(())
    }

    fn compile_prototype(&self, name: &str, params: &Vec<(String, Type, bool)>, ret: &Type) -> Result<(), CompileError> {
        if self.extern_functions.contains(name) {
            return Ok(());
        }
        let args: Vec<BasicMetadataTypeEnum> = params.iter().map(|(_, t, _)| self.type_to_basic_type(t).unwrap().into()).collect();
        let ret_type = if name == "main" { &Type::Int } else { ret };
        let ft = match self.type_to_basic_type(ret_type) { Some(t) => t.fn_type(&args, false), None => self.context.void_type().fn_type(&args, false) };
        let fn_val = self.module.add_function(name, ft, None);
        
        let attr = self.context.create_string_attribute("frame-pointer", "all");
        fn_val.add_attribute(AttributeLoc::Function, attr);
        
        Ok(())
    }

    fn compile_function_body(&self, f: &TFunctionDecl) -> Result<(), CompileError> {
        let fn_val = self.module.get_function(&f.name).unwrap();
        
        // Use a dedicated entry block for allocas to prevent stack corruption
        let alloca_bb = self.context.append_basic_block(fn_val, "entry");
        let body_bb = self.context.append_basic_block(fn_val, "body");
        
        // Terminate the alloca block with a jump to body
        self.builder.position_at_end(alloca_bb);
        self.builder.build_unconditional_branch(body_bb).unwrap();
        
        // Start code generation in the body block
        self.builder.position_at_end(body_bb);

        let mut compiler = FunctionCompiler { gen: self, fn_value: fn_val, variables: HashMap::new(), scope_stack: vec![Vec::new()] };
        for (i, (name, typ, _)) in f.params.iter().enumerate() {
            let val = fn_val.get_nth_param(i as u32).unwrap();
            let alloca = compiler.create_alloca(name, typ);
            compiler.emit_retain(val, typ);
            compiler.gen.builder.build_store(alloca, val).unwrap();
            compiler.variables.insert(name.clone(), (VarLoc::Stack(alloca), typ.clone()));
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
    
    // ...

    pub fn run_main(&self) {
        eprintln!("[CODEGEN] Starting JIT Execution...");
        self.module.print_to_stderr(); // DEBUG: Print IR
        unsafe {
            let ee = self.module.create_jit_execution_engine(OptimizationLevel::None).unwrap();
            
            // Manual Mapping of Runtime Functions
            if let Some(f) = self.module.get_function("print") { ee.add_global_mapping(&f, crate::runtime::print as usize); }
            if let Some(f) = self.module.get_function("lunite_print_int") { ee.add_global_mapping(&f, crate::runtime::lunite_print_int as usize); }
            if let Some(f) = self.module.get_function("lunite_alloc") { ee.add_global_mapping(&f, crate::runtime::lunite_alloc as usize); }
            if let Some(f) = self.module.get_function("lunite_retain") { ee.add_global_mapping(&f, crate::runtime::lunite_retain as usize); }
            if let Some(f) = self.module.get_function("lunite_release") { ee.add_global_mapping(&f, crate::runtime::lunite_release as usize); }
            if let Some(f) = self.module.get_function("lunite_str_eq") { ee.add_global_mapping(&f, crate::runtime::lunite_str_eq as usize); }
            if let Some(f) = self.module.get_function("lunite_str_len_runtime") { ee.add_global_mapping(&f, crate::runtime::lunite_str_len_runtime as usize); }
            if let Some(f) = self.module.get_function("lunite_str_concat") { ee.add_global_mapping(&f, crate::runtime::lunite_str_concat as usize); }
            if let Some(f) = self.module.get_function("lunite_str_substring") { ee.add_global_mapping(&f, crate::runtime::lunite_str_substring as usize); }
            if let Some(f) = self.module.get_function("lunite_str_at") { ee.add_global_mapping(&f, crate::runtime::lunite_str_at as usize); }
            if let Some(f) = self.module.get_function("lunite_io_read_file") { ee.add_global_mapping(&f, crate::runtime::lunite_io_read_file as usize); }
            if let Some(f) = self.module.get_function("lunite_sys_system") { ee.add_global_mapping(&f, crate::runtime::lunite_sys_system as usize); }
            if let Some(f) = self.module.get_function("lunite_sys_exit") { ee.add_global_mapping(&f, crate::runtime::lunite_sys_exit as usize); }
            if let Some(f) = self.module.get_function("lunite_math_pow") { ee.add_global_mapping(&f, crate::runtime::lunite_math_pow as usize); }
            if let Some(f) = self.module.get_function("lunite_math_abs") { ee.add_global_mapping(&f, crate::runtime::lunite_math_abs as usize); }
            if let Some(f) = self.module.get_function("lunite_math_ceil") { ee.add_global_mapping(&f, crate::runtime::lunite_math_ceil as usize); }
            if let Some(f) = self.module.get_function("lunite_math_floor") { ee.add_global_mapping(&f, crate::runtime::lunite_math_floor as usize); }
            if let Some(f) = self.module.get_function("lunite_net_bind") { ee.add_global_mapping(&f, crate::runtime::lunite_net_bind as usize); }
            if let Some(f) = self.module.get_function("lunite_net_accept") { ee.add_global_mapping(&f, crate::runtime::lunite_net_accept as usize); }
            if let Some(f) = self.module.get_function("lunite_net_read") { ee.add_global_mapping(&f, crate::runtime::lunite_net_read as usize); }
            if let Some(f) = self.module.get_function("lunite_net_write") { ee.add_global_mapping(&f, crate::runtime::lunite_net_write as usize); }
            if let Some(f) = self.module.get_function("lunite_net_close_socket") { ee.add_global_mapping(&f, crate::runtime::lunite_net_close_socket as usize); }
            if let Some(f) = self.module.get_function("lunite_net_close_server") { ee.add_global_mapping(&f, crate::runtime::lunite_net_close_server as usize); }
            if let Some(f) = self.module.get_function("lunite_channel_create") { ee.add_global_mapping(&f, crate::runtime::lunite_channel_create as usize); }
            if let Some(f) = self.module.get_function("lunite_channel_send") { ee.add_global_mapping(&f, crate::runtime::lunite_channel_send as usize); }
            if let Some(f) = self.module.get_function("lunite_channel_recv") { ee.add_global_mapping(&f, crate::runtime::lunite_channel_recv as usize); }
            if let Some(f) = self.module.get_function("lunite_spawn") { ee.add_global_mapping(&f, crate::runtime::lunite_spawn as usize); }
            if let Some(f) = self.module.get_function("lunite_time_now") { ee.add_global_mapping(&f, crate::runtime::lunite_time_now as usize); }
            if let Some(f) = self.module.get_function("lunite_time_sleep") { ee.add_global_mapping(&f, crate::runtime::lunite_time_sleep as usize); }
            if let Some(f) = self.module.get_function("lunite_srand") { ee.add_global_mapping(&f, crate::runtime::lunite_srand as usize); }
            if let Some(f) = self.module.get_function("lunite_rand_int") { ee.add_global_mapping(&f, crate::runtime::lunite_rand_int as usize); }
            if let Some(f) = self.module.get_function("lunite_realloc") { ee.add_global_mapping(&f, crate::runtime::lunite_realloc as usize); }
            if let Some(f) = self.module.get_function("lunite_array_copy") { ee.add_global_mapping(&f, crate::runtime::lunite_array_copy as usize); }
            if let Some(f) = self.module.get_function("lunite_arena_save") { ee.add_global_mapping(&f, crate::runtime::lunite_arena_save as usize); }
            if let Some(f) = self.module.get_function("lunite_arena_restore") { ee.add_global_mapping(&f, crate::runtime::lunite_arena_restore as usize); }
            if let Some(f) = self.module.get_function("lunite_print_float") { ee.add_global_mapping(&f, crate::runtime::lunite_print_float as usize); }
            if let Some(f) = self.module.get_function("__gxx_personality_v0") { ee.add_global_mapping(&f, crate::runtime::lunite_throw as usize); } // Map to dummy

            let main_fn = ee.get_function::<unsafe extern "C" fn() -> i64>("main");
            if let Ok(main) = main_fn { 
                eprintln!("[CODEGEN] Calling main()...");
                let res = main.call(); 
                eprintln!("[CODEGEN] Main returned: {}", res);
            } else {
                eprintln!("[CODEGEN] Main function not found!");
            }
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
                if let Some((loc, typ)) = self.variables.get(var) {
                    if self.gen.is_ref_counted(typ) {
                        let val = match loc {
                            VarLoc::Stack(ptr) => self.gen.builder.build_load(self.gen.type_to_basic_type(typ).unwrap(), *ptr, "tmp").unwrap(),
                            VarLoc::Register(v) => *v,
                        };
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
                let (loc, typ) = self.variables.get(n).ok_or_else(|| CompileError { message: format!("Var not found: {}", n), line: 0, column: 0 })?;
                match loc {
                    VarLoc::Stack(ptr) => Ok(self.gen.builder.build_load(self.gen.type_to_basic_type(typ).unwrap(), *ptr, n).unwrap()),
                    VarLoc::Register(v) => Ok(*v),
                }
            }
            TExpressionKind::Binary { left, operator, right } => {
                let lv = self.compile_expression(left)?; let rv = self.compile_expression(right)?;
                let is_f = left.typ == Type::Float || right.typ == Type::Float;
                match operator {
                    TokenKind::Plus => {
                        if is_f { Ok(self.gen.builder.build_float_add(lv.into_float_value(), rv.into_float_value(), "").unwrap().into()) }
                        else if matches!(left.typ, Type::String) {
                            let concat_fn = self.gen.module.get_function("lunite_str_concat").unwrap();
                            let res = self.gen.builder.build_call(concat_fn, &[lv.into(), rv.into()], "sconcat").unwrap().try_as_basic_value().left().unwrap().into_pointer_value();
                            Ok(res.into())
                        }
                        else { Ok(self.gen.builder.build_int_add(lv.into_int_value(), rv.into_int_value(), "").unwrap().into()) }
                    },
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
                        else if let Type::Enum(name, _) = &left.typ {
                            let et = self.gen.enum_types.get(name).unwrap();
                            let l_ptr = if lv.is_pointer_value() { lv.into_pointer_value() } else { self.gen.context.ptr_type(AddressSpace::default()).const_null() };
                            let r_ptr = if rv.is_pointer_value() { rv.into_pointer_value() } else { self.gen.context.ptr_type(AddressSpace::default()).const_null() };
                            
                            let is_l_null = self.gen.builder.build_is_null(l_ptr, "l_null").unwrap();
                            let is_r_null = self.gen.builder.build_is_null(r_ptr, "r_null").unwrap();
                            let both_null = self.gen.builder.build_and(is_l_null, is_r_null, "both_null").unwrap();
                            let either_null = self.gen.builder.build_or(is_l_null, is_r_null, "either_null").unwrap();
                            
                            let curr_bb = self.gen.builder.get_insert_block().unwrap();
                            let load_bb = self.gen.context.append_basic_block(self.fn_value, "enum_load");
                            let res_bb = self.gen.context.append_basic_block(self.fn_value, "enum_res");
                            
                            self.gen.builder.build_conditional_branch(either_null, res_bb, load_bb).unwrap();
                            
                            self.gen.builder.position_at_end(load_bb);
                            let l_tag_ptr = self.gen.builder.build_struct_gep(*et, l_ptr, 0, "ltag").unwrap();
                            let r_tag_ptr = self.gen.builder.build_struct_gep(*et, r_ptr, 0, "rtag").unwrap();
                            let l_tag = self.gen.builder.build_load(self.gen.context.i64_type(), l_tag_ptr, "lt").unwrap().into_int_value();
                            let r_tag = self.gen.builder.build_load(self.gen.context.i64_type(), r_tag_ptr, "rt").unwrap().into_int_value();
                            let tags_eq = self.gen.builder.build_int_compare(IntPredicate::EQ, l_tag, r_tag, "teq").unwrap();
                            self.gen.builder.build_unconditional_branch(res_bb).unwrap();
                            
                            self.gen.builder.position_at_end(res_bb);
                            let phi = self.gen.builder.build_phi(self.gen.context.bool_type(), "eq").unwrap();
                            phi.add_incoming(&[(&both_null, curr_bb), (&tags_eq, load_bb)]);
                            Ok(phi.as_basic_value().into())
                        }
                        else {
                            let l_val = if lv.is_pointer_value() { self.gen.builder.build_ptr_to_int(lv.into_pointer_value(), self.gen.context.i64_type(), "l_cast").unwrap() } else { lv.into_int_value() };
                            let r_val = if rv.is_pointer_value() { self.gen.builder.build_ptr_to_int(rv.into_pointer_value(), self.gen.context.i64_type(), "r_cast").unwrap() } else { rv.into_int_value() };
                            Ok(self.gen.builder.build_int_compare(IntPredicate::EQ, l_val, r_val, "").unwrap().into())
                        }
                    },
                    TokenKind::BangEqual => {
                        if is_f { Ok(self.gen.builder.build_float_compare(FloatPredicate::ONE, lv.into_float_value(), rv.into_float_value(), "").unwrap().into()) }
                        else if matches!(left.typ, Type::String) {
                            let eq_fn = self.gen.module.get_function("lunite_str_eq").unwrap();
                            let res = self.gen.builder.build_call(eq_fn, &[lv.into(), rv.into()], "seq").unwrap().try_as_basic_value().left().unwrap().into_int_value();
                            Ok(self.gen.builder.build_int_compare(IntPredicate::EQ, res, self.gen.context.i64_type().const_zero(), "bool").unwrap().into())
                        }
                        else if let Type::Enum(name, _) = &left.typ {
                            let et = self.gen.enum_types.get(name).unwrap();
                            let l_ptr = if lv.is_pointer_value() { lv.into_pointer_value() } else { self.gen.context.ptr_type(AddressSpace::default()).const_null() };
                            let r_ptr = if rv.is_pointer_value() { rv.into_pointer_value() } else { self.gen.context.ptr_type(AddressSpace::default()).const_null() };
                            
                            let is_l_null = self.gen.builder.build_is_null(l_ptr, "l_null").unwrap();
                            let is_r_null = self.gen.builder.build_is_null(r_ptr, "r_null").unwrap();
                            let one_null = self.gen.builder.build_xor(is_l_null, is_r_null, "one_null").unwrap();
                            let both_null = self.gen.builder.build_and(is_l_null, is_r_null, "both_null").unwrap();
                            let either_null = self.gen.builder.build_or(is_l_null, is_r_null, "either_null").unwrap();
                            
                            let curr_bb = self.gen.builder.get_insert_block().unwrap();
                            let load_bb = self.gen.context.append_basic_block(self.fn_value, "enum_load_ne");
                            let res_bb = self.gen.context.append_basic_block(self.fn_value, "enum_res_ne");
                            
                            self.gen.builder.build_conditional_branch(either_null, res_bb, load_bb).unwrap();
                            
                            self.gen.builder.position_at_end(load_bb);
                            let l_tag_ptr = self.gen.builder.build_struct_gep(*et, l_ptr, 0, "ltag").unwrap();
                            let r_tag_ptr = self.gen.builder.build_struct_gep(*et, r_ptr, 0, "rtag").unwrap();
                            let l_tag = self.gen.builder.build_load(self.gen.context.i64_type(), l_tag_ptr, "lt").unwrap().into_int_value();
                            let r_tag = self.gen.builder.build_load(self.gen.context.i64_type(), r_tag_ptr, "rt").unwrap().into_int_value();
                            let tags_ne = self.gen.builder.build_int_compare(IntPredicate::NE, l_tag, r_tag, "tne").unwrap();
                            self.gen.builder.build_unconditional_branch(res_bb).unwrap();
                            
                            self.gen.builder.position_at_end(res_bb);
                            let phi = self.gen.builder.build_phi(self.gen.context.bool_type(), "ne").unwrap();
                            phi.add_incoming(&[(&one_null, curr_bb), (&tags_ne, load_bb)]);
                            Ok(phi.as_basic_value().into())
                        }
                        else {
                            let l_val = if lv.is_pointer_value() { self.gen.builder.build_ptr_to_int(lv.into_pointer_value(), self.gen.context.i64_type(), "l_cast").unwrap() } else { lv.into_int_value() };
                            let r_val = if rv.is_pointer_value() { self.gen.builder.build_ptr_to_int(rv.into_pointer_value(), self.gen.context.i64_type(), "r_cast").unwrap() } else { rv.into_int_value() };
                            Ok(self.gen.builder.build_int_compare(IntPredicate::NE, l_val, r_val, "").unwrap().into())
                        }
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
                    let st_ty = self.gen.context.struct_type(&[i64_t.into(), i64_t.into()], false);
                    let mut st_val = st_ty.get_undef();
                    st_val = self.gen.builder.build_insert_value(st_val, i64_t.const_int(*tag as u64, false), 0, "tag").unwrap().into_struct_value();
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
                self.gen.builder.build_store(tag_ptr, self.gen.context.i64_type().const_int(*tag as u64, false)).unwrap();
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
                if !self.gen.struct_types.contains_key(name) {
                    eprintln!("[CODEGEN] PANIC: Struct type '{}' not found in registry (StructInit)!", name);
                    eprintln!("[CODEGEN] Available structs: {:?}", self.gen.struct_types.keys().collect::<Vec<_>>());
                }
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
                let tm = Target::from_triple(&TargetMachine::get_default_triple()).unwrap().create_target_machine(&TargetMachine::get_default_triple(), "generic", "", OptimizationLevel::None, RelocMode::PIC, CodeModel::Default).unwrap();
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
                if !self.gen.struct_types.contains_key(sn) {
                    eprintln!("[CODEGEN] PANIC in compile_expression: Struct type '{}' not found in registry!", sn);
                    eprintln!("[CODEGEN] Available structs: {:?}", self.gen.struct_types.keys().collect::<Vec<_>>());
                }
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
            TExpressionKind::Index { array, index } => {
                let arr_ptr = self.compile_expression(array)?.into_pointer_value();
                let idx_val = self.compile_expression(index)?.into_int_value();
                let (inner, is_ptr) = match &array.typ { Type::Array(t, _) => (t, false), Type::Pointer(t) => (t, true), _ => unreachable!() };
                let b_ty = self.gen.type_to_basic_type(inner).unwrap();
                unsafe { 
                    let ptr = if is_ptr { self.gen.builder.build_gep(b_ty, arr_ptr, &[idx_val], "ptr").unwrap() }
                              else { self.gen.builder.build_gep(b_ty.array_type(100), arr_ptr, &[self.gen.context.i64_type().const_zero(), idx_val], "ptr").unwrap() };
                    Ok(self.gen.builder.build_load(b_ty, ptr, "val").unwrap())
                }
            }
            TExpressionKind::Cast { expression, target_type } => {
                let val = self.compile_expression(expression)?;
                let src_type = &expression.typ;
                let dst_type = target_type;
                
                if (matches!(src_type, Type::Pointer(_) | Type::Custom(_, _) | Type::String) || matches!(src_type, Type::Array(_, _))) && matches!(dst_type, Type::Int) {
                     if val.is_pointer_value() {
                         return Ok(self.gen.builder.build_ptr_to_int(val.into_pointer_value(), self.gen.context.i64_type(), "cast").unwrap().into());
                     }
                }
                if matches!(src_type, Type::Int) && matches!(dst_type, Type::Pointer(_)) {
                     let dst_basic = self.gen.type_to_basic_type(dst_type).unwrap().into_pointer_type();
                     return Ok(self.gen.builder.build_int_to_ptr(val.into_int_value(), dst_basic, "cast").unwrap().into());
                }
                if matches!(src_type, Type::Int) && matches!(dst_type, Type::Float) {
                    return Ok(self.gen.builder.build_signed_int_to_float(val.into_int_value(), self.gen.context.f64_type(), "cast").unwrap().into());
                }
                if matches!(src_type, Type::Float) && matches!(dst_type, Type::Int) {
                    return Ok(self.gen.builder.build_float_to_signed_int(val.into_float_value(), self.gen.context.i64_type(), "cast").unwrap().into());
                }
                if (matches!(src_type, Type::Pointer(_) | Type::Custom(_, _) | Type::Array(_, _)) && matches!(dst_type, Type::Pointer(_) | Type::Custom(_, _) | Type::Array(_, _))) {
                     let dst_basic = self.gen.type_to_basic_type(dst_type).unwrap().into_pointer_type();
                     return Ok(self.gen.builder.build_bit_cast(val.into_pointer_value(), dst_basic, "cast").unwrap().into());
                }
                Ok(val)
            }
            _ => Ok(self.gen.context.i64_type().const_zero().into())
        }
    }

    fn compile_lvalue(&mut self, expr: &TExpression) -> Result<PointerValue<'ctx>, CompileError> {
        match &expr.kind {
            TExpressionKind::Identifier(n) => Ok(match self.variables.get(n).unwrap().0 {
                VarLoc::Stack(p) => p,
                VarLoc::Register(_) => return Err(CompileError{ message: format!("Cannot assign to immutable parameter {}", n), line: 0, column: 0 })
            }),
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
                if !self.gen.struct_types.contains_key(sn) {
                    eprintln!("[CODEGEN] PANIC: Struct type '{}' not found in registry (lvalue)!", sn);
                    eprintln!("[CODEGEN] Available structs: {:?}", self.gen.struct_types.keys().collect::<Vec<_>>());
                }
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
                self.variables.insert(name.clone(), (VarLoc::Stack(alloca), var_type.clone()));
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
                } else { 
                    self.gen.builder.build_store(addr, val).unwrap(); 
                }
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
            TStatement::Block(b) => { self.compile_block(b)?; Ok(()) }
            TStatement::Region { body } => {
                let save_fn = self.gen.module.get_function("lunite_arena_save").unwrap();
                let restore_fn = self.gen.module.get_function("lunite_arena_restore").unwrap();
                let token = self.gen.builder.build_call(save_fn, &[], "atoken").unwrap().try_as_basic_value().left().unwrap();
                self.compile_block(body)?;
                self.gen.builder.build_call(restore_fn, &[token.into()], "").unwrap();
                Ok(())
            }
            TStatement::Spawn(e) => {
                let val = self.compile_expression(e)?;
                // Mock implementation for spawn
                Ok(())
            }
            TStatement::TryCatch { try_block, catch_variable, catch_block } => {
                self.compile_block(try_block)?;
                Ok(())
            }
            TStatement::When { subject, arms } => {
                let subj_val = self.compile_expression(subject)?;
                let end_bb = self.gen.context.append_basic_block(self.fn_value, "when_end");
                
                for arm in arms {
                    let next_arm_bb = self.gen.context.append_basic_block(self.fn_value, "when_next");
                    let body_bb = self.gen.context.append_basic_block(self.fn_value, "when_body");
                    
                    match &arm.pattern {
                        TWhenPattern::Else => {
                            self.gen.builder.build_unconditional_branch(body_bb).unwrap();
                        }
                        TWhenPattern::Literal(lit) => {
                            let lv = self.compile_expression(lit)?;
                            let is_match = if subj_val.is_int_value() {
                                self.gen.builder.build_int_compare(IntPredicate::EQ, subj_val.into_int_value(), lv.into_int_value(), "match").unwrap()
                            } else {
                                let s = self.gen.builder.build_ptr_to_int(subj_val.into_pointer_value(), self.gen.context.i64_type(), "s").unwrap();
                                let l = self.gen.builder.build_ptr_to_int(lv.into_pointer_value(), self.gen.context.i64_type(), "l").unwrap();
                                self.gen.builder.build_int_compare(IntPredicate::EQ, s, l, "match").unwrap()
                            };
                            self.gen.builder.build_conditional_branch(is_match, body_bb, next_arm_bb).unwrap();
                        }
                        TWhenPattern::EnumVariant { enum_name, tag, binding, .. } => {
                            let et = self.gen.enum_types.get(enum_name).unwrap();
                            let tag_ptr = self.gen.builder.build_struct_gep(*et, subj_val.into_pointer_value(), 0, "tptr").unwrap();
                            let actual_tag = self.gen.builder.build_load(self.gen.context.i64_type(), tag_ptr, "tag").unwrap().into_int_value();
                            let is_match = self.gen.builder.build_int_compare(IntPredicate::EQ, actual_tag, self.gen.context.i64_type().const_int(*tag as u64, false), "match").unwrap();
                            self.gen.builder.build_conditional_branch(is_match, body_bb, next_arm_bb).unwrap();
                            
                            if let Some(bname) = binding {
                                let current_bb = self.gen.builder.get_insert_block().unwrap();
                                self.gen.builder.position_at_end(body_bb);
                                let p_ptr = self.gen.builder.build_struct_gep(*et, subj_val.into_pointer_value(), 1, "pptr").unwrap();
                                let ed = self.gen.enum_decls.get(enum_name).unwrap();
                                let v_ty = ed.variants[*tag as usize].typ.as_ref().unwrap();
                                let b_ty = self.gen.type_to_basic_type(v_ty).unwrap();
                                let p_cast = self.gen.builder.build_bit_cast(p_ptr, b_ty.ptr_type(AddressSpace::default()), "pcast").unwrap().into_pointer_value();
                                let val = self.gen.builder.build_load(b_ty, p_cast, "pval").unwrap();
                                
                                let alloca = self.create_alloca(bname, v_ty);
                                self.emit_retain(val, v_ty);
                                self.gen.builder.build_store(alloca, val).unwrap();
                                self.variables.insert(bname.clone(), (VarLoc::Stack(alloca), v_ty.clone()));
                                // We will push this to scope later when entering the arm body
                                self.gen.builder.position_at_end(current_bb);
                            }
                        }
                    }
                    
                    self.gen.builder.position_at_end(body_bb);
                    self.scope_stack.push(Vec::new());
                    if let TWhenPattern::EnumVariant { binding: Some(bname), .. } = &arm.pattern {
                        self.scope_stack.last_mut().unwrap().push(bname.clone());
                    }
                    for stmt in &arm.body.statements { self.compile_statement(stmt)?; }
                    if self.gen.builder.get_insert_block().unwrap().get_terminator().is_none() {
                        self.cleanup_current_scope()?;
                        self.gen.builder.build_unconditional_branch(end_bb).unwrap();
                    }
                    self.scope_stack.pop();
                    self.gen.builder.position_at_end(next_arm_bb);
                }
                
                if self.gen.builder.get_insert_block().unwrap().get_terminator().is_none() {
                    self.gen.builder.build_unconditional_branch(end_bb).unwrap();
                }
                self.gen.builder.position_at_end(end_bb); Ok(())
            }
            _ => Ok(())
        }
    }
}
