use inkwell::debug_info::{DICompileUnit, DIType, DWARFSourceLanguage, DebugInfoBuilder, AsDIScope};
use inkwell::attributes::AttributeLoc;
use inkwell::basic_block::BasicBlock;
use inkwell::builder::Builder;
use inkwell::context::Context;
use inkwell::execution_engine::ExecutionEngine;
use inkwell::module::{Linkage, Module};
use inkwell::passes::PassManager;
use inkwell::targets::{
    CodeModel, FileType, InitializationConfig, RelocMode, Target, TargetMachine, TargetTriple,
};
use inkwell::types::{
    BasicMetadataTypeEnum, BasicType, BasicTypeEnum, IntType, PointerType, StructType,
};
use inkwell::values::{
    BasicValue, BasicValueEnum, FunctionValue, InstructionValue, IntValue, PointerValue,
};
use inkwell::{AddressSpace, FloatPredicate, IntPredicate, OptimizationLevel};
use std::collections::{HashMap, HashSet};
use std::path::Path;

use crate::ast::{EnumDecl, StructDecl, StructLayout, Type};
use crate::semantic::{
    TBlock, TExpression, TExpressionKind, TExternFunctionDecl, TFunctionDecl, TItem, TModule,
    TStatement, TStatementKind, TWhenArm, TWhenPattern,
};
use crate::token::TokenKind;
use crate::CompileError;

pub struct CodeGenerator<'ctx> {
    pub context: &'ctx Context,
    pub module: Module<'ctx>,
    pub builder: Builder<'ctx>,
    pub dibuilder: DebugInfoBuilder<'ctx>,
    pub compile_unit: DICompileUnit<'ctx>,
    struct_types: HashMap<String, StructType<'ctx>>,
    enum_types: HashMap<String, StructType<'ctx>>,
    struct_decls: HashMap<String, StructDecl>,
    enum_decls: HashMap<String, EnumDecl>,
    string_type: StructType<'ctx>,
    personality_fn: FunctionValue<'ctx>,
    pub extern_functions: HashSet<String>,
    pub opt_level: OptimizationLevel,
    fpm: PassManager<FunctionValue<'ctx>>,
    mpm: PassManager<Module<'ctx>>,
}

struct FunctionCompiler<'a, 'ctx> {
    gen: &'a CodeGenerator<'ctx>,
    fn_value: FunctionValue<'ctx>,
    variables: HashMap<String, (VarLoc<'ctx>, Type)>,
    scope_stack: Vec<Vec<String>>,
    loop_exit_stack: Vec<BasicBlock<'ctx>>,
}

#[derive(Clone, Copy, Debug)]
enum VarLoc<'ctx> {
    Stack(PointerValue<'ctx>),
    Register(BasicValueEnum<'ctx>),
}

impl<'ctx> CodeGenerator<'ctx> {
    pub fn new(context: &'ctx Context, opt_level: OptimizationLevel, target_triple: Option<String>) -> Self {
        Target::initialize_native(&InitializationConfig::default())
            .expect("Failed to init native target");
        Target::initialize_webassembly(&InitializationConfig::default()); // Support WASM

        let triple = if let Some(t) = target_triple {
            TargetTriple::create(&t)
        } else {
            TargetMachine::get_default_triple()
        };
        
        eprintln!("[CODEGEN] Target Triple: {:?}", triple);
        let target = Target::from_triple(&triple).expect("Failed to create target");
        let target_machine = target
            .create_target_machine(
                &triple,
                "generic",
                "",
                OptimizationLevel::None,
                RelocMode::PIC,
                CodeModel::Default,
            )
            .expect("Failed to create machine");
        eprintln!(
            "[CODEGEN] Data Layout: {:?}",
            target_machine.get_target_data().get_data_layout()
        );
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

        module.add_function(
            "lunite_alloc",
            i8_ptr_type.fn_type(
                &[i64_type.into(), i8_ptr_type.into(), i8_ptr_type.into()],
                false,
            ),
            None,
        );
        module.add_function(
            "lunite_free",
            void_type.fn_type(&[i8_ptr_type.into()], false),
            None,
        );
        module.add_function(
            "lunite_retain",
            void_type.fn_type(&[i8_ptr_type.into()], false),
            None,
        );
        module.add_function(
            "lunite_release",
            void_type.fn_type(&[i8_ptr_type.into()], false),
            None,
        );
        module.add_function(
            "lunite_dec_ref",
            context.bool_type().fn_type(&[i8_ptr_type.into()], false),
            None,
        );
        module.add_function(
            "lunite_free_memory",
            void_type.fn_type(&[i8_ptr_type.into()], false),
            None,
        );
        module.add_function(
            "lunite_throw",
            void_type.fn_type(&[i8_ptr_type.into()], false),
            None,
        );
        module.add_function("lunite_arena_save", i64_type.fn_type(&[], false), None);
        module.add_function(
            "lunite_arena_restore",
            void_type.fn_type(&[i64_type.into()], false),
            None,
        );
        module.add_function(
            "lunite_init_args",
            void_type.fn_type(&[i32_type.into(), i8_ptr_type.into()], false),
            None,
        );
        module.add_function("lunite_sys_get_argc", i64_type.fn_type(&[], false), None);
        module.add_function(
            "lunite_sys_get_arg",
            i8_ptr_type.fn_type(&[i64_type.into()], false),
            None,
        );

        let str_ptr_type = context.ptr_type(AddressSpace::default());
        module.add_function(
            "print",
            void_type.fn_type(&[str_ptr_type.into()], false),
            None,
        );
        module.add_function(
            "lunite_print",
            void_type.fn_type(&[str_ptr_type.into()], false),
            None,
        );
        module.add_function(
            "lunite_print_int",
            void_type.fn_type(&[i64_type.into()], false),
            None,
        );
        module.add_function(
            "lunite_print_float",
            void_type.fn_type(&[context.f64_type().into()], false),
            None,
        );
        module.add_function(
            "lunite_str_eq",
            i64_type.fn_type(&[str_ptr_type.into(), str_ptr_type.into()], false),
            None,
        );
        module.add_function(
            "lunite_str_len_runtime",
            i64_type.fn_type(&[str_ptr_type.into()], false),
            None,
        );
        module.add_function(
            "lunite_str_concat",
            str_ptr_type.fn_type(&[str_ptr_type.into(), str_ptr_type.into()], false),
            None,
        );
        module.add_function(
            "lunite_str_substring",
            str_ptr_type.fn_type(
                &[str_ptr_type.into(), i64_type.into(), i64_type.into()],
                false,
            ),
            None,
        );
        module.add_function(
            "lunite_str_at",
            i64_type.fn_type(&[str_ptr_type.into(), i64_type.into()], false),
            None,
        );
        module.add_function(
            "lunite_io_read_file",
            result_type.fn_type(&[str_ptr_type.into()], false),
            None,
        );
        module.add_function(
            "lunite_io_read_file_str",
            str_ptr_type.fn_type(&[str_ptr_type.into()], false),
            None,
        );
        module.add_function(
            "lunite_io_write_file",
            i64_type.fn_type(&[str_ptr_type.into()], false),
            None,
        );
        module.add_function(
            "lunite_sys_system",
            i64_type.fn_type(&[str_ptr_type.into()], false),
            None,
        );
        module.add_function(
            "lunite_sys_exit",
            void_type.fn_type(&[i64_type.into()], false),
            None,
        );
        module.add_function(
            "lunite_math_pow",
            context.f64_type().fn_type(
                &[context.f64_type().into(), context.f64_type().into()],
                false,
            ),
            None,
        );
        module.add_function(
            "lunite_math_abs",
            context
                .f64_type()
                .fn_type(&[context.f64_type().into()], false),
            None,
        );
        module.add_function(
            "lunite_math_ceil",
            context
                .f64_type()
                .fn_type(&[context.f64_type().into()], false),
            None,
        );
        module.add_function(
            "lunite_math_floor",
            context
                .f64_type()
                .fn_type(&[context.f64_type().into()], false),
            None,
        );
        module.add_function(
            "lunite_net_bind",
            result_type.fn_type(&[i64_type.into()], false),
            None,
        );
        module.add_function(
            "lunite_net_accept",
            result_type.fn_type(&[i8_ptr_type.into()], false),
            None,
        );
        module.add_function(
            "lunite_net_read",
            result_type.fn_type(&[i8_ptr_type.into()], false),
            None,
        );
        module.add_function(
            "lunite_net_write",
            void_type.fn_type(&[i8_ptr_type.into(), str_ptr_type.into()], false),
            None,
        );
        module.add_function(
            "lunite_net_close_socket",
            void_type.fn_type(&[i8_ptr_type.into()], false),
            None,
        );
        module.add_function(
            "lunite_net_close_server",
            void_type.fn_type(&[i8_ptr_type.into()], false),
            None,
        );
        module.add_function(
            "lunite_channel_create",
            i8_ptr_type.fn_type(&[], false),
            None,
        );
        module.add_function(
            "lunite_channel_send",
            void_type.fn_type(&[i8_ptr_type.into(), i64_type.into()], false),
            None,
        );
        module.add_function(
            "lunite_channel_recv",
            i64_type.fn_type(&[i8_ptr_type.into()], false),
            None,
        );
        module.add_function(
            "lunite_spawn",
            void_type.fn_type(&[i8_ptr_type.into(), i8_ptr_type.into()], false),
            None,
        );
        module.add_function("lunite_time_now", i64_type.fn_type(&[], false), None);
        module.add_function(
            "lunite_time_sleep",
            void_type.fn_type(&[i64_type.into()], false),
            None,
        );
        module.add_function(
            "lunite_srand",
            void_type.fn_type(&[i64_type.into()], false),
            None,
        );
        module.add_function("lunite_rand_int", i64_type.fn_type(&[], false), None);
        module.add_function(
            "lunite_realloc",
            i8_ptr_type.fn_type(
                &[i8_ptr_type.into(), i64_type.into(), i64_type.into()],
                false,
            ),
            None,
        );
        module.add_function(
            "lunite_array_copy",
            void_type.fn_type(
                &[
                    i8_ptr_type.into(),
                    i8_ptr_type.into(),
                    i64_type.into(),
                    i64_type.into(),
                ],
                false,
            ),
            None,
        );

        let personality = module.add_function(
            "__gxx_personality_v0",
            context.i32_type().fn_type(&[], true),
            Some(Linkage::External),
        );

        let mut extern_functions = HashSet::new();
        extern_functions.insert("print".to_string());
        extern_functions.insert("lunite_alloc".to_string());
        extern_functions.insert("lunite_realloc".to_string());
        extern_functions.insert("lunite_array_copy".to_string());
        extern_functions.insert("lunite_free".to_string());
        extern_functions.insert("lunite_retain".to_string());
        extern_functions.insert("lunite_release".to_string());
        extern_functions.insert("lunite_dec_ref".to_string());
        extern_functions.insert("lunite_free_memory".to_string());
        extern_functions.insert("lunite_print".to_string());
        extern_functions.insert("lunite_print_int".to_string());
        extern_functions.insert("lunite_print_float".to_string());
        extern_functions.insert("lunite_str_eq".to_string());
        extern_functions.insert("lunite_str_len_runtime".to_string());
        extern_functions.insert("lunite_str_concat".to_string());
        extern_functions.insert("lunite_str_substring".to_string());
        extern_functions.insert("lunite_str_at".to_string());
        extern_functions.insert("lunite_io_read_file".to_string());
        extern_functions.insert("lunite_io_read_file_str".to_string());
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
        extern_functions.insert("lunite_init_args".to_string());
        extern_functions.insert("lunite_sys_get_argc".to_string());
        extern_functions.insert("lunite_sys_get_arg".to_string());
        extern_functions.insert("lunite_throw".to_string());
        extern_functions.insert("lunite_from_c_str".to_string());
        extern_functions.insert("__gxx_personality_v0".to_string());

        extern_functions.insert("lunite_channel_recv".to_string());
        extern_functions.insert("lunite_spawn".to_string());
        extern_functions.insert("lunite_time_now".to_string());
        extern_functions.insert("lunite_time_sleep".to_string());
        extern_functions.insert("lunite_srand".to_string());
        extern_functions.insert("lunite_rand_int".to_string());
        extern_functions.insert("lunite_arena_save".to_string());
        extern_functions.insert("lunite_arena_restore".to_string());
        extern_functions.insert("lunite_init_args".to_string());
        extern_functions.insert("lunite_sys_get_argc".to_string());
        extern_functions.insert("lunite_sys_get_arg".to_string());
        extern_functions.insert("lunite_throw".to_string());
        extern_functions.insert("__gxx_personality_v0".to_string());

        let (dibuilder, compile_unit) = module.create_debug_info_builder(
            true,
            DWARFSourceLanguage::C,
            "lunite_program",
            ".",
            "Lunite Compiler",
            false,
            "",
            0,
            "",
            inkwell::debug_info::DWARFEmissionKind::Full,
            0,
            false,
            false,
            "",
            "",
        );

        let fpm = PassManager::create(&module);
        let mpm = PassManager::create(());

        // Optimization passes for JIT (TODO: Update for LLVM 18 NewPM)
        /*
        if opt_level != OptimizationLevel::None {
             // New Pass Manager logic required here
        }
        */

        fpm.initialize();

        Self {
            context,
            module,
            builder,
            dibuilder,
            compile_unit,
            struct_types: HashMap::new(),
            enum_types: HashMap::new(),
            struct_decls: HashMap::new(),
            enum_decls: HashMap::new(),
            string_type,
            personality_fn: personality,
            extern_functions,
            opt_level,
            fpm,
            mpm,
        }
    }

    pub fn type_to_basic_type(&self, typ: &Type) -> Option<BasicTypeEnum<'ctx>> {
        match typ {
            Type::Int => Some(self.context.i64_type().into()),
            Type::Float => Some(self.context.f64_type().into()),
            Type::Bool => Some(self.context.bool_type().into()),
            Type::String => Some(self.context.ptr_type(AddressSpace::default()).into()),
            Type::Result(_, _) | Type::Option(_) => {
                let i64_t = self.context.i64_type();
                Some(
                    self.context
                        .struct_type(&[i64_t.into(), i64_t.into()], false)
                        .into(),
                )
            }
            Type::Custom(name, _) => Some(self.context.ptr_type(AddressSpace::default()).into()),
            Type::Enum(name, _) => self
                .enum_types
                .get(name)
                .map(|st| self.context.ptr_type(AddressSpace::default()).into())
                .or_else(|| Some(self.context.ptr_type(AddressSpace::default()).into())),
            Type::Array(inner, size) => {
                let et = self
                    .type_to_basic_type(inner)
                    .unwrap_or(self.context.ptr_type(AddressSpace::default()).into());
                Some(self.context.ptr_type(AddressSpace::default()).into())
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
            }
            _ => false,
        }
    }

    pub fn emit_release_value(&self, builder: &Builder<'ctx>, val: BasicValueEnum<'ctx>, typ: &Type) {
        if !self.is_ref_counted(typ) {
            return;
        }
        
        match typ {
            Type::Custom(name, _) => {
                let release_fn = self.get_or_create_struct_release_fn(name);
                if val.is_pointer_value() {
                     builder.build_call(release_fn, &[val.into_pointer_value().into()], "").unwrap();
                }
            }
            _ => {
                let release_fn = self.module.get_function("lunite_release").unwrap();
                if val.is_pointer_value() {
                    builder.build_call(release_fn, &[val.into_pointer_value().into()], "").unwrap();
                }
            }
        }
    }

    pub fn get_or_create_struct_release_fn(&self, struct_name: &str) -> FunctionValue<'ctx> {
        let fn_name = format!("release_{}", struct_name);
        if let Some(f) = self.module.get_function(&fn_name) {
            return f;
        }

        let i8_ptr_type = self.context.ptr_type(AddressSpace::default());
        let fn_type = self.context.void_type().fn_type(&[i8_ptr_type.into()], false);
        let f = self.module.add_function(&fn_name, fn_type, None);
        
        let bb = self.context.append_basic_block(f, "entry");
        let builder = self.context.create_builder();
        builder.position_at_end(bb);

        let ptr = f.get_nth_param(0).unwrap().into_pointer_value();
        
        let dec_ref_fn = self.module.get_function("lunite_dec_ref").unwrap();
        let should_free = builder.build_call(dec_ref_fn, &[ptr.into()], "should_free").unwrap().try_as_basic_value().left().unwrap().into_int_value();
        
        let free_bb = self.context.append_basic_block(f, "free");
        let end_bb = self.context.append_basic_block(f, "end");
        
        builder.build_conditional_branch(should_free, free_bb, end_bb).unwrap();
        
        builder.position_at_end(free_bb);
        
        let st_type = self.struct_types.get(struct_name).unwrap();
        let typed_ptr = builder.build_bit_cast(ptr, st_type.ptr_type(AddressSpace::default()), "typed_ptr").unwrap().into_pointer_value();
        
        let decl = self.struct_decls.get(struct_name).unwrap();
        
        for (i, (_, field_type, _)) in decl.fields.iter().enumerate() {
             if self.is_ref_counted(field_type) {
                 let field_ptr = builder.build_struct_gep(*st_type, typed_ptr, i as u32, "f_ptr").unwrap();
                 let field_val = builder.build_load(self.type_to_basic_type(field_type).unwrap(), field_ptr, "f_val").unwrap();
                 
                 self.emit_release_value(&builder, field_val, field_type);
             }
        }
        
        let free_mem_fn = self.module.get_function("lunite_free_memory").unwrap();
        builder.build_call(free_mem_fn, &[ptr.into()], "").unwrap();
        builder.build_unconditional_branch(end_bb).unwrap();
        
        builder.position_at_end(end_bb);
        builder.build_return(None).unwrap();
        
        f
    }

    pub fn compile_modules(&mut self, modules: Vec<TModule>) -> Result<(), CompileError> {
        let tm = Target::from_triple(&TargetMachine::get_default_triple())
            .unwrap()
            .create_target_machine(
                &TargetMachine::get_default_triple(),
                "generic",
                "",
                OptimizationLevel::None,
                RelocMode::PIC,
                CodeModel::Default,
            )
            .unwrap();
        let target_data = tm.get_target_data();

        for m in &modules {
            for (name, s) in &m.struct_decls {
                // eprintln!("[CODEGEN] Registering struct: {}", name);
                self.struct_decls.insert(name.clone(), s.clone());
                self.struct_types
                    .insert(name.clone(), self.context.opaque_struct_type(name));
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
                        if size > max_size {
                            max_size = size;
                        }
                    }
                }
            }
            if max_size == 0 {
                max_size = 1;
            }
            let tag_type = self.context.i64_type();
            let payload_type = self.context.i8_type().array_type(max_size);
            let enum_struct = self
                .context
                .struct_type(&[tag_type.into(), payload_type.into()], false);
            self.enum_types.insert(name, enum_struct);
        }

        for (name, decl) in self.struct_decls.clone() {
            let fields: Vec<_> = decl
                .fields
                .iter()
                .map(|(_, t, _)| self.type_to_basic_type(t).unwrap())
                .collect();
            self.struct_types
                .get(&name)
                .unwrap()
                .set_body(&fields, false);
        }

        for m in &modules {
            for item in &m.items {
                match item {
                    TItem::Function(f) => {
                        self.compile_prototype(&f.name, &f.params, &f.return_type)?
                    }
                    TItem::ExternFunction(f) => {
                        self.compile_prototype(&f.name, &f.params, &f.return_type)?
                    }
                    TItem::NativeFunction(f) => {
                        self.compile_prototype(&f.name, &f.params, &f.return_type)?
                    }
                    _ => {}
                }
            }
        }
        for m in &modules {
            for item in &m.items {
                if let TItem::Function(f) = item {
                    if f.body.is_some() {
                        self.compile_function_body(f)?;
                    }
                }
            }
        }

        // Finalize Debug Info
        self.dibuilder.finalize();

        // Final module-level optimizations
        if self.opt_level != OptimizationLevel::None {
            eprintln!("[CODEGEN] Running module optimizations...");
            self.mpm.run_on(&self.module);
        }

        eprintln!("[CODEGEN] Compilation finished successfully.");
        Ok(())
    }

    fn compile_prototype(
        &self,
        name: &str,
        params: &[(String, Type, bool)],
        ret: &Type,
    ) -> Result<(), CompileError> {
        eprintln!("[DEBUG] Compiling prototype for: {}", name);
        if self.extern_functions.contains(name) {
            return Ok(());
        }
        let args: Vec<BasicMetadataTypeEnum> = if name == "main" {
            vec![
                self.context.i32_type().into(),
                self.context.ptr_type(AddressSpace::default()).into(), // char**
            ]
        } else {
            params
                .iter()
                .map(|(_, t, _)| self.type_to_basic_type(t).unwrap().into())
                .collect()
        };
        let ret_type = if name == "main" { &Type::Int } else { ret };
        let ft = match self.type_to_basic_type(ret_type) {
            Some(t) => t.fn_type(&args, false),
            None => self.context.void_type().fn_type(&args, false),
        };
        let f = self.module.add_function(name, ft, None);
        
        // Add debug info for function
        // Need DIType for return and params
        // For MVP, we use void type or basic int
        let di_file = self.compile_unit.get_file();
        let di_type = self.dibuilder.create_subroutine_type(
            di_file,
            Some(self.dibuilder.create_basic_type("void", 0, 0x00, 0).unwrap().as_type()), // TODO: Real types
            &[],
            0
        );
        let subprogram = self.dibuilder.create_function(
            di_file.as_debug_info_scope(),
            name,
            None,
            di_file,
            0,
            di_type,
            false,
            true,
            0,
            0,
            false
        );
        f.set_subprogram(subprogram);

        for (i, arg) in f.get_param_iter().enumerate() {
            if i < params.len() {
                arg.set_name(&params[i].0);
            }
        }
        Ok(())
    }

    fn compile_function_body(&mut self, f: &TFunctionDecl) -> Result<(), CompileError> {
        eprintln!("[DEBUG] Compiling body for: {}", f.name);
        let fn_val = self.module.get_function(&f.name).unwrap();

        // Use a dedicated entry block for allocas to prevent stack corruption
        let alloca_bb = self.context.append_basic_block(fn_val, "entry");
        let body_bb = self.context.append_basic_block(fn_val, "body");

        // Terminate the alloca block with a jump to body
        self.builder.position_at_end(alloca_bb);
        self.builder.build_unconditional_branch(body_bb).unwrap();

        // Start code generation in the body block
        self.builder.position_at_end(body_bb);
        
        // Set current debug location to function start
        if f.span.line > 0 {
            let loc = self.dibuilder.create_debug_location(
                self.context,
                f.span.line,
                f.span.col,
                fn_val.get_subprogram().unwrap().as_debug_info_scope(),
                None,
            );
            self.builder.set_current_debug_location(loc);
        }

        if f.name == "main" {
            let init_args = self.module.get_function("lunite_init_args").unwrap();
            let argc = fn_val.get_nth_param(0).unwrap();
            let argv = fn_val.get_nth_param(1).unwrap();
            self.builder
                .build_call(init_args, &[argc.into(), argv.into()], "")
                .unwrap();
        }

        let mut compiler = FunctionCompiler {
            gen: self,
            fn_value: fn_val,
            variables: HashMap::new(),
            scope_stack: vec![Vec::new()],
            loop_exit_stack: Vec::new(),
        };
        for (i, (name, typ, _)) in f.params.iter().enumerate() {
            let val = fn_val.get_nth_param(i as u32).unwrap();
            let alloca = compiler.create_alloca(name, typ);
            compiler.emit_retain(val, typ);
            compiler.gen.builder.build_store(alloca, val).unwrap();
            compiler
                .variables
                .insert(name.clone(), (VarLoc::Stack(alloca), typ.clone()));
            compiler.scope_stack.last_mut().unwrap().push(name.clone());
        }
        compiler.compile_block(f.body.as_ref().unwrap())?;
        if self
            .builder
            .get_insert_block()
            .unwrap()
            .get_terminator()
            .is_none()
        {
            compiler.cleanup_scope(0)?;
            if f.name == "main" {
                self.builder
                    .build_return(Some(&self.context.i64_type().const_zero()))
                    .unwrap();
            } else if f.return_type == Type::Void {
                self.builder.build_return(None).unwrap();
            } else {
                self.builder
                    .build_return(Some(
                        &self
                            .type_to_basic_type(&f.return_type)
                            .unwrap()
                            .const_zero(),
                    ))
                    .unwrap();
            }
        }
        Ok(())
    }

    pub fn run_main(&self, argc: i32, argv: *const *const i8) {
        eprintln!("[CODEGEN] Starting JIT Execution...");
        // self.module.print_to_stderr(); // DEBUG: Print IR
        unsafe {
            let ee = self
                .module
                .create_jit_execution_engine(OptimizationLevel::None)
                .unwrap();

            // Manual Mapping of Runtime Functions
            let mappings = [
                ("print", crate::runtime::print as usize),
                ("lunite_print", crate::runtime::lunite_print as usize),
                ("lunite_print_int", crate::runtime::lunite_print_int as usize),
                ("lunite_print_float", crate::runtime::lunite_print_float as usize),
                ("lunite_alloc", crate::runtime::lunite_alloc as usize),
                ("lunite_realloc", crate::runtime::lunite_realloc as usize),
                ("lunite_retain", crate::runtime::lunite_retain as usize),
                ("lunite_release", crate::runtime::lunite_release as usize),
                ("lunite_dec_ref", crate::runtime::lunite_dec_ref as usize),
                ("lunite_free_memory", crate::runtime::lunite_free_memory as usize),
                ("lunite_throw", crate::runtime::lunite_throw as usize),
                ("lunite_str_eq", crate::runtime::lunite_str_eq as usize),
                ("lunite_str_len_runtime", crate::runtime::lunite_str_len_runtime as usize),
                ("lunite_str_concat", crate::runtime::lunite_str_concat as usize),
                ("lunite_str_substring", crate::runtime::lunite_str_substring as usize),
                ("lunite_str_at", crate::runtime::lunite_str_at as usize),
                ("lunite_int_to_str", crate::runtime::lunite_int_to_str as usize),
                ("lunite_io_read_file", crate::runtime::lunite_io_read_file as usize),
                ("lunite_io_read_file_str", crate::runtime::lunite_io_read_file_str as usize),
                ("lunite_io_write_file", crate::runtime::lunite_io_write_file as usize),
                ("lunite_sys_system", crate::runtime::lunite_sys_system as usize),
                ("lunite_sys_exit", crate::runtime::lunite_sys_exit as usize),
                ("lunite_init_args", crate::runtime::lunite_init_args as usize),
                ("lunite_sys_get_argc", crate::runtime::lunite_sys_get_argc as usize),
                ("lunite_sys_get_arg", crate::runtime::lunite_sys_get_arg as usize),
                ("lunite_math_pow", crate::runtime::lunite_math_pow as usize),
                ("lunite_math_abs", crate::runtime::lunite_math_abs as usize),
                ("lunite_math_ceil", crate::runtime::lunite_math_ceil as usize),
                ("lunite_math_floor", crate::runtime::lunite_math_floor as usize),
                ("lunite_time_now", crate::runtime::lunite_time_now as usize),
                ("lunite_time_sleep", crate::runtime::lunite_time_sleep as usize),
                ("lunite_srand", crate::runtime::lunite_srand as usize),
                ("lunite_rand_int", crate::runtime::lunite_rand_int as usize),
                ("lunite_array_copy", crate::runtime::lunite_array_copy as usize),
                ("lunite_channel_create", crate::runtime::lunite_channel_create as usize),
                ("lunite_channel_send", crate::runtime::lunite_channel_send as usize),
                ("lunite_channel_recv", crate::runtime::lunite_channel_recv as usize),
                ("lunite_spawn", crate::runtime::lunite_spawn as usize),
                ("lunite_net_bind", crate::runtime::lunite_net_bind as usize),
                ("lunite_net_accept", crate::runtime::lunite_net_accept as usize),
                ("lunite_net_read", crate::runtime::lunite_net_read as usize),
                ("lunite_net_write", crate::runtime::lunite_net_write as usize),
                ("lunite_net_close_socket", crate::runtime::lunite_net_close_socket as usize),
                ("lunite_net_close_server", crate::runtime::lunite_net_close_server as usize),
                ("lunite_from_c_str", crate::runtime::lunite_from_c_str as usize),
            ];

            for (name, addr) in mappings {
                if let Some(f) = self.module.get_function(name) {
                    // eprintln!("[CODEGEN] Mapping function: {} to 0x{:x}", name, addr);
                    ee.add_global_mapping(&f, addr);
                }
            }

            if let Some(f) = self.module.get_function("__gxx_personality_v0") {
                ee.add_global_mapping(&f, crate::runtime::lunite_throw as usize);
            } // Map to dummy


            let main_fn = ee.get_function::<unsafe extern "C" fn(i32, *const *const i8) -> i64>("main");
            if let Ok(main) = main_fn {
                eprintln!("[CODEGEN] Calling main() at address 0x{:x}...", main.as_raw() as usize);
                let res = main.call(argc, argv);
                eprintln!("[CODEGEN] Main returned: {}", res);
            } else {
                eprintln!("[CODEGEN] Main function not found!");
            }
        }
    }

    pub fn build_object_file(&self, path: &Path) -> Result<(), String> {
        let triple = self.module.get_triple();
        let target = Target::from_triple(&triple).map_err(|e| e.to_string())?;
        let tm = target
            .create_target_machine(
                &triple,
                "generic",
                "",
                self.opt_level,
                RelocMode::PIC,
                CodeModel::Default,
            )
            .ok_or("Failed to create target machine".to_string())?;
        tm.write_to_file(&self.module, FileType::Object, path)
            .map_err(|e| e.to_string())
    }
}

impl<'a, 'ctx> FunctionCompiler<'a, 'ctx> {
    fn emit_retain(&self, val: BasicValueEnum<'ctx>, typ: &Type) {
        if !self.gen.is_ref_counted(typ) {
            return;
        }
        let retain_fn = self.gen.module.get_function("lunite_retain").unwrap();
        if val.is_pointer_value() {
            self.gen
                .builder
                .build_call(retain_fn, &[val.into_pointer_value().into()], "")
                .unwrap();
        }
    }

    fn emit_release(&self, val: BasicValueEnum<'ctx>, typ: &Type) {
        self.gen.emit_release_value(&self.gen.builder, val, typ);
    }

    fn create_alloca(&self, name: &str, typ: &Type) -> PointerValue<'ctx> {
        let b = self.gen.context.create_builder();
        let e = self.fn_value.get_first_basic_block().unwrap();
        match e.get_first_instruction() {
            Some(i) => b.position_before(&i),
            None => b.position_at_end(e),
        }
        b.build_alloca(self.gen.type_to_basic_type(typ).unwrap(), name)
            .unwrap()
    }

    fn compile_block(&mut self, block: &TBlock) -> Result<(), CompileError> {
        self.scope_stack.push(Vec::new());
        for stmt in &block.statements {
            self.compile_statement(stmt)?;
        }
        if self
            .gen
            .builder
            .get_insert_block()
            .unwrap()
            .get_terminator()
            .is_none()
        {
            self.cleanup_current_scope()?;
        }
        self.scope_stack.pop();
        Ok(())
    }

    fn cleanup_scope(&self, level: usize) -> Result<(), CompileError> {
        for scope in self
            .scope_stack
            .iter()
            .rev()
            .take(self.scope_stack.len() - level)
        {
            for var in scope.iter().rev() {
                if let Some((loc, typ)) = self.variables.get(var) {
                    if self.gen.is_ref_counted(typ) {
                        let val = match loc {
                            VarLoc::Stack(ptr) => self
                                .gen
                                .builder
                                .build_load(self.gen.type_to_basic_type(typ).unwrap(), *ptr, "tmp")
                                .unwrap(),
                            VarLoc::Register(v) => *v,
                        };
                        self.emit_release(val, typ);
                    }
                }
            }
        }
        Ok(())
    }

    fn cleanup_current_scope(&self) -> Result<(), CompileError> {
        self.cleanup_scope(self.scope_stack.len() - 1)
    }

    fn compile_expression(
        &mut self,
        expr: &TExpression,
    ) -> Result<BasicValueEnum<'ctx>, CompileError> {
        match &expr.kind {
            TExpressionKind::Int(v) => Ok(self
                .gen
                .context
                .i64_type()
                .const_int(*v as u64, false)
                .into()),
            TExpressionKind::Float(v) => Ok(self.gen.context.f64_type().const_float(*v).into()),
            TExpressionKind::Boolean(v) => Ok(self
                .gen
                .context
                .bool_type()
                .const_int(if *v { 1 } else { 0 }, false)
                .into()),
            TExpressionKind::String(s) => {
                let len_val = self.gen.context.i64_type().const_int(s.len() as u64, false);
                let data_ptr = self
                    .gen
                    .builder
                    .build_call(
                        self.gen.module.get_function("lunite_alloc").unwrap(),
                        &[
                            len_val.into(),
                            self.gen
                                .context
                                .ptr_type(AddressSpace::default())
                                .const_null()
                                .into(),
                            self.gen
                                .context
                                .ptr_type(AddressSpace::default())
                                .const_null()
                                .into(),
                        ],
                        "sdata",
                    )
                    .unwrap()
                    .try_as_basic_value()
                    .left()
                    .unwrap()
                    .into_pointer_value();
                self.gen
                    .builder
                    .build_memcpy(
                        data_ptr,
                        1,
                        self.gen
                            .builder
                            .build_global_string_ptr(s, "slit")
                            .unwrap()
                            .as_pointer_value(),
                        1,
                        len_val,
                    )
                    .unwrap();
                let str_struct = self
                    .gen
                    .builder
                    .build_call(
                        self.gen.module.get_function("lunite_alloc").unwrap(),
                        &[
                            self.gen.context.i64_type().const_int(16, false).into(),
                            self.gen
                                .context
                                .ptr_type(AddressSpace::default())
                                .const_null()
                                .into(),
                            self.gen
                                .context
                                .ptr_type(AddressSpace::default())
                                .const_null()
                                .into(),
                        ],
                        "sstruct",
                    )
                    .unwrap()
                    .try_as_basic_value()
                    .left()
                    .unwrap()
                    .into_pointer_value();
                let cast = self
                    .gen
                    .builder
                    .build_bit_cast(
                        str_struct,
                        self.gen.context.ptr_type(AddressSpace::default()),
                        "scast",
                    )
                    .unwrap()
                    .into_pointer_value();
                let p_ptr = self
                    .gen
                    .builder
                    .build_struct_gep(self.gen.string_type, cast, 0, "p")
                    .unwrap();
                let l_ptr = self
                    .gen
                    .builder
                    .build_struct_gep(self.gen.string_type, cast, 1, "l")
                    .unwrap();
                self.gen.builder.build_store(p_ptr, data_ptr).unwrap();
                self.gen.builder.build_store(l_ptr, len_val).unwrap();
                // Retain string literal once to keep it alive
                self.emit_retain(cast.into(), &Type::String);
                Ok(cast.into())
            }
            TExpressionKind::Identifier(n) => {
                let (loc, typ) = self.variables.get(n).ok_or_else(|| CompileError {
                    message: format!("Var not found: {}", n),
                    line: 0,
                    column: 0,
                })?;
                match loc {
                    VarLoc::Stack(ptr) => Ok(self
                        .gen
                        .builder
                        .build_load(self.gen.type_to_basic_type(typ).unwrap(), *ptr, n)
                        .unwrap()),
                    VarLoc::Register(v) => Ok(*v),
                }
            }
            TExpressionKind::Binary {
                left,
                operator,
                right,
            } => {
                let lv = self.compile_expression(left)?;
                let rv = self.compile_expression(right)?;
                let is_f = left.typ == Type::Float || right.typ == Type::Float;
                match operator {
                    TokenKind::Plus => {
                        if is_f {
                            Ok(self
                                .gen
                                .builder
                                .build_float_add(lv.into_float_value(), rv.into_float_value(), "")
                                .unwrap()
                                .into())
                        } else if matches!(left.typ, Type::String) {
                            let concat_fn =
                                self.gen.module.get_function("lunite_str_concat").unwrap();
                            let res = self
                                .gen
                                .builder
                                .build_call(concat_fn, &[lv.into(), rv.into()], "sconcat")
                                .unwrap()
                                .try_as_basic_value()
                                .left()
                                .unwrap()
                                .into_pointer_value();
                            Ok(res.into())
                        } else {
                            Ok(self
                                .gen
                                .builder
                                .build_int_add(lv.into_int_value(), rv.into_int_value(), "")
                                .unwrap()
                                .into())
                        }
                    }
                    TokenKind::Minus => {
                        if is_f {
                            Ok(self
                                .gen
                                .builder
                                .build_float_sub(lv.into_float_value(), rv.into_float_value(), "")
                                .unwrap()
                                .into())
                        } else {
                            Ok(self
                                .gen
                                .builder
                                .build_int_sub(lv.into_int_value(), rv.into_int_value(), "")
                                .unwrap()
                                .into())
                        }
                    }
                    TokenKind::Star => {
                        if is_f {
                            Ok(self
                                .gen
                                .builder
                                .build_float_mul(lv.into_float_value(), rv.into_float_value(), "")
                                .unwrap()
                                .into())
                        } else {
                            Ok(self
                                .gen
                                .builder
                                .build_int_mul(lv.into_int_value(), rv.into_int_value(), "")
                                .unwrap()
                                .into())
                        }
                    }
                    TokenKind::Slash => {
                        if is_f {
                            Ok(self
                                .gen
                                .builder
                                .build_float_div(lv.into_float_value(), rv.into_float_value(), "")
                                .unwrap()
                                .into())
                        } else {
                            Ok(self
                                .gen
                                .builder
                                .build_int_signed_div(lv.into_int_value(), rv.into_int_value(), "")
                                .unwrap()
                                .into())
                        }
                    }
                    TokenKind::EqualEqual => {
                        if is_f {
                            Ok(self
                                .gen
                                .builder
                                .build_float_compare(
                                    FloatPredicate::OEQ,
                                    lv.into_float_value(),
                                    rv.into_float_value(),
                                    "",
                                )
                                .unwrap()
                                .into())
                        } else if matches!(left.typ, Type::String) {
                            let eq_fn = self.gen.module.get_function("lunite_str_eq").unwrap();
                            let res = self
                                .gen
                                .builder
                                .build_call(eq_fn, &[lv.into(), rv.into()], "seq")
                                .unwrap()
                                .try_as_basic_value()
                                .left()
                                .unwrap()
                                .into_int_value();
                            Ok(self
                                .gen
                                .builder
                                .build_int_compare(
                                    IntPredicate::NE,
                                    res,
                                    self.gen.context.i64_type().const_zero(),
                                    "bool",
                                )
                                .unwrap()
                                .into())
                        } else {
                            Ok(self
                                .gen
                                .builder
                                .build_int_compare(
                                    IntPredicate::EQ,
                                    lv.into_int_value(),
                                    rv.into_int_value(),
                                    "bool",
                                )
                                .unwrap()
                                .into())
                        }
                    }
                    TokenKind::BangEqual => {
                        if is_f {
                            Ok(self
                                .gen
                                .builder
                                .build_float_compare(
                                    FloatPredicate::ONE,
                                    lv.into_float_value(),
                                    rv.into_float_value(),
                                    "",
                                )
                                .unwrap()
                                .into())
                        } else if matches!(left.typ, Type::String) {
                            let eq_fn = self.gen.module.get_function("lunite_str_eq").unwrap();
                            let res = self
                                .gen
                                .builder
                                .build_call(eq_fn, &[lv.into(), rv.into()], "seq")
                                .unwrap()
                                .try_as_basic_value()
                                .left()
                                .unwrap()
                                .into_int_value();
                            Ok(self
                                .gen
                                .builder
                                .build_int_compare(
                                    IntPredicate::EQ,
                                    res,
                                    self.gen.context.i64_type().const_zero(),
                                    "bool",
                                )
                                .unwrap()
                                .into())
                        } else {
                            Ok(self
                                .gen
                                .builder
                                .build_int_compare(
                                    IntPredicate::NE,
                                    lv.into_int_value(),
                                    rv.into_int_value(),
                                    "bool",
                                )
                                .unwrap()
                                .into())
                        }
                    }
                    TokenKind::Less => {
                        if is_f {
                            Ok(self
                                .gen
                                .builder
                                .build_float_compare(
                                    FloatPredicate::OLT,
                                    lv.into_float_value(),
                                    rv.into_float_value(),
                                    "",
                                )
                                .unwrap()
                                .into())
                        } else {
                            Ok(self
                                .gen
                                .builder
                                .build_int_compare(
                                    IntPredicate::SLT,
                                    lv.into_int_value(),
                                    rv.into_int_value(),
                                    "bool",
                                )
                                .unwrap()
                                .into())
                        }
                    }
                    TokenKind::Greater => {
                        if is_f {
                            Ok(self
                                .gen
                                .builder
                                .build_float_compare(
                                    FloatPredicate::OGT,
                                    lv.into_float_value(),
                                    rv.into_float_value(),
                                    "",
                                )
                                .unwrap()
                                .into())
                        } else {
                            Ok(self
                                .gen
                                .builder
                                .build_int_compare(
                                    IntPredicate::SGT,
                                    lv.into_int_value(),
                                    rv.into_int_value(),
                                    "bool",
                                )
                                .unwrap()
                                .into())
                        }
                    }
                    TokenKind::LessEqual => {
                        if is_f {
                            Ok(self
                                .gen
                                .builder
                                .build_float_compare(
                                    FloatPredicate::OLE,
                                    lv.into_float_value(),
                                    rv.into_float_value(),
                                    "",
                                )
                                .unwrap()
                                .into())
                        } else {
                            Ok(self
                                .gen
                                .builder
                                .build_int_compare(
                                    IntPredicate::SLE,
                                    lv.into_int_value(),
                                    rv.into_int_value(),
                                    "bool",
                                )
                                .unwrap()
                                .into())
                        }
                    }
                    TokenKind::GreaterEqual => {
                        if is_f {
                            Ok(self
                                .gen
                                .builder
                                .build_float_compare(
                                    FloatPredicate::OGE,
                                    lv.into_float_value(),
                                    rv.into_float_value(),
                                    "",
                                )
                                .unwrap()
                                .into())
                        } else {
                            Ok(self
                                .gen
                                .builder
                                .build_int_compare(
                                    IntPredicate::SGE,
                                    lv.into_int_value(),
                                    rv.into_int_value(),
                                    "bool",
                                )
                                .unwrap()
                                .into())
                        }
                    }
                    _ => Err(CompileError {
                        message: "Unknown operator".into(),
                        line: 0,
                        column: 0,
                    }),
                }
            }
            TExpressionKind::Unary {
                operator: TokenKind::Minus,
                right,
            } => {
                let rv = self.compile_expression(right)?;
                if right.typ == Type::Float {
                    Ok(self
                        .gen
                        .builder
                        .build_float_neg(rv.into_float_value(), "")
                        .unwrap()
                        .into())
                } else {
                    Ok(self
                        .gen
                        .builder
                        .build_int_neg(rv.into_int_value(), "")
                        .unwrap()
                        .into())
                }
            }
            TExpressionKind::Unary {
                operator: TokenKind::Bang,
                right,
            } => {
                let rv = self.compile_expression(right)?;
                // bool is i1, so not is xor 1
                Ok(self
                    .gen
                    .builder
                    .build_not(rv.into_int_value(), "")
                    .unwrap()
                    .into())
            }
            TExpressionKind::Call {
                function,
                args: arg_exprs,
            } => {
                let func = self
                    .gen
                    .module
                    .get_function(function)
                    .ok_or_else(|| CompileError {
                        message: format!("Function not found: {}", function),
                        line: 0,
                        column: 0,
                    })?;
                let mut args = Vec::new();
                for e in arg_exprs {
                    args.push(self.compile_expression(e)?.into());
                }
                let call = self.gen.builder.build_call(func, &args, "call").unwrap();
                match call.try_as_basic_value().left() {
                    Some(v) => Ok(v),
                    None => Ok(self.gen.context.i64_type().const_zero().into()),
                }
            }
            TExpressionKind::StructInit { name, fields } => {
                let st = self.gen.struct_types.get(name).unwrap();
                let decl = self.gen.struct_decls.get(name).unwrap();
                let alloc_fn = self.gen.module.get_function("lunite_alloc").unwrap();
                let size = st
                    .size_of()
                    .unwrap()
                    .const_bit_cast(self.gen.context.i64_type());
                let ptr = self
                    .gen
                    .builder
                    .build_call(
                        alloc_fn,
                        &[
                            size.into(),
                            self.gen
                                .context
                                .ptr_type(AddressSpace::default())
                                .const_null()
                                .into(),
                            self.gen
                                .context
                                .ptr_type(AddressSpace::default())
                                .const_null()
                                .into(),
                        ],
                        "struct_alloc",
                    )
                    .unwrap()
                    .try_as_basic_value()
                    .left()
                    .unwrap()
                    .into_pointer_value();
                let typed_ptr = self
                    .gen
                    .builder
                    .build_bit_cast(
                        ptr,
                        st.ptr_type(AddressSpace::default()),
                        "struct_cast",
                    )
                    .unwrap()
                    .into_pointer_value();

                for (fname, fexpr) in fields {
                    let val = self.compile_expression(fexpr)?;
                    let idx = decl
                        .fields
                        .iter()
                        .position(|(n, _, _)| n == fname)
                        .unwrap();
                    let fptr = self
                        .gen
                        .builder
                        .build_struct_gep(*st, typed_ptr, idx as u32, fname)
                        .unwrap();
                    self.emit_retain(val, &fexpr.typ);
                    self.gen.builder.build_store(fptr, val).unwrap();
                }
                Ok(ptr.into())
            }
            TExpressionKind::EnumInit {
                enum_name,
                tag,
                value,
                ..
            } => {
                let et = self.gen.enum_types.get(enum_name).unwrap();
                let alloc_fn = self.gen.module.get_function("lunite_alloc").unwrap();
                let size = et
                    .size_of()
                    .unwrap()
                    .const_bit_cast(self.gen.context.i64_type());
                let ptr = self
                    .gen
                    .builder
                    .build_call(
                        alloc_fn,
                        &[
                            size.into(),
                            self.gen
                                .context
                                .ptr_type(AddressSpace::default())
                                .const_null()
                                .into(),
                            self.gen
                                .context
                                .ptr_type(AddressSpace::default())
                                .const_null()
                                .into(),
                        ],
                        "enum_alloc",
                    )
                    .unwrap()
                    .try_as_basic_value()
                    .left()
                    .unwrap()
                    .into_pointer_value();
                let typed_ptr = self
                    .gen
                    .builder
                    .build_bit_cast(ptr, et.ptr_type(AddressSpace::default()), "enum_cast")
                    .unwrap()
                    .into_pointer_value();

                let tag_ptr = self
                    .gen
                    .builder
                    .build_struct_gep(*et, typed_ptr, 0, "tag")
                    .unwrap();
                self.gen
                    .builder
                    .build_store(
                        tag_ptr,
                        self.gen.context.i64_type().const_int(*tag as u64, false),
                    )
                    .unwrap();

                if let Some(v) = value {
                    let val = self.compile_expression(v)?;
                    let payload_ptr = self
                        .gen
                        .builder
                        .build_struct_gep(*et, typed_ptr, 1, "payload")
                        .unwrap();
                    // Bitcast payload ptr to value type pointer
                    let val_type = self.gen.type_to_basic_type(&v.typ).unwrap();
                    let cast_payload = self
                        .gen
                        .builder
                        .build_bit_cast(
                            payload_ptr,
                            val_type.ptr_type(AddressSpace::default()),
                            "payload_cast",
                        )
                        .unwrap()
                        .into_pointer_value();
                    self.emit_retain(val, &v.typ);
                    self.gen.builder.build_store(cast_payload, val).unwrap();
                }
                Ok(ptr.into())
            }
            TExpressionKind::MemberAccess { object, field } => {
                let obj_ptr = self.compile_expression(object)?.into_pointer_value();
                let (sn, is_ptr) = match &object.typ {
                    Type::Custom(name, _) => (name, false),
                    Type::Pointer(inner) => {
                        if let Type::Custom(name, _) = &**inner {
                            (name, true)
                        } else {
                            unreachable!()
                        }
                    }
                    _ => unreachable!(),
                };
                if !self.gen.struct_types.contains_key(sn) {
                    eprintln!(
                        "[CODEGEN] PANIC: Struct type not found for member access: {}",
                        sn
                    );
                    eprintln!(
                        "[CODEGEN] Available structs: {:?}",
                        self.gen.struct_types.keys().collect::<Vec<_>>()
                    );
                }
                let st = self.gen.struct_types.get(sn).unwrap();
                let sd = self.gen.struct_decls.get(sn).unwrap();
                let idx = sd.fields.iter().position(|(n, _, _)| n == field).unwrap();
                let ptr = self
                    .gen
                    .builder
                    .build_struct_gep(*st, obj_ptr, idx as u32, "fp")
                    .unwrap();
                Ok(self
                    .gen
                    .builder
                    .build_load(
                        self.gen.type_to_basic_type(&expr.typ).unwrap(),
                        ptr,
                        "fval",
                    )
                    .unwrap())
            }
            TExpressionKind::Unary {
                operator: TokenKind::Ampersand,
                right,
            } => {
                // Address of
                // Only for lvalues (variables, fields)
                // For now only variables
                if let TExpressionKind::Identifier(name) = &right.kind {
                    let (loc, _) = self.variables.get(name).unwrap();
                    match loc {
                        VarLoc::Stack(ptr) => Ok(ptr.clone().into()),
                        _ => panic!("Cannot take address of register var"),
                    }
                } else if let TExpressionKind::MemberAccess { object, field } = &right.kind {
                    // Re-implement member access to get pointer
                    let obj_ptr = self.compile_expression(object)?.into_pointer_value();
                    let sn = if let Type::Custom(name, _) = &object.typ {
                        name
                    } else if let Type::Pointer(inner) = &object.typ {
                        if let Type::Custom(name, _) = &**inner {
                            name
                        } else {
                            unreachable!()
                        }
                    } else {
                        unreachable!()
                    };
                    let st = self.gen.struct_types.get(sn).unwrap();
                    let sd = self.gen.struct_decls.get(sn).unwrap();
                    let idx = sd.fields.iter().position(|(n, _, _)| n == field).unwrap();
                    Ok(self
                        .gen
                        .builder
                        .build_struct_gep(*st, obj_ptr, idx as u32, "fp")
                        .unwrap()
                        .into())
                } else {
                    eprintln!("[CODEGEN] PANIC: Invalid lvalue: {:?}", &expr.kind);
                    unreachable!()
                }
            }
            TExpressionKind::Unary {
                operator: TokenKind::Star,
                right,
            } => {
                let ptr = self.compile_expression(right)?.into_pointer_value();
                Ok(self
                    .gen
                    .builder
                    .build_load(
                        self.gen.type_to_basic_type(&expr.typ).unwrap(),
                        ptr,
                        "deref",
                    )
                    .unwrap())
            }
            TExpressionKind::Try { expression } => {
                let val = self.compile_expression(expression)?;
                // Check tag
                let st_val = val.into_struct_value();
                let tag = self
                    .gen
                    .builder
                    .build_extract_value(st_val, 0, "tag")
                    .unwrap()
                    .into_int_value();
                let err_bb = self
                    .gen
                    .context
                    .append_basic_block(self.fn_value, "try_err");
                let ok_bb = self.gen.context.append_basic_block(self.fn_value, "try_ok");
                let is_err = self
                    .gen
                    .builder
                    .build_int_compare(
                        IntPredicate::NE,
                        tag,
                        self.gen.context.i32_type().const_zero(),
                        "is_err",
                    )
                    .unwrap();
                self.gen
                    .builder
                    .build_conditional_branch(is_err, err_bb, ok_bb)
                    .unwrap();
                self.gen.builder.position_at_end(err_bb);
                self.gen.builder.build_return(Some(&val)).unwrap();
                self.gen.builder.position_at_end(ok_bb);
                let payload = self
                    .gen
                    .builder
                    .build_extract_value(st_val, 1, "ok_val")
                    .unwrap()
                    .into_int_value();
                let target_type = self.gen.type_to_basic_type(&expr.typ).unwrap();
                Ok(if target_type.is_pointer_type() {
                    self.gen
                        .builder
                        .build_int_to_ptr(payload, target_type.into_pointer_type(), "to_ptr")
                        .unwrap()
                        .into()
                } else if target_type.is_float_type() {
                    self.gen
                        .builder
                        .build_bit_cast(payload, self.gen.context.f64_type(), "to_f64")
                        .unwrap()
                } else {
                    self.gen
                        .builder
                        .build_int_cast(payload, target_type.into_int_type(), "to_int")
                        .unwrap()
                        .into()
                })
            }
            TExpressionKind::Index { array, index } => {
                let arr_ptr = self.compile_expression(array)?.into_pointer_value();
                let idx_val = self.compile_expression(index)?.into_int_value();
                let (inner, is_ptr) = match &array.typ {
                    Type::Array(t, _) => (t, false),
                    Type::Pointer(t) => (t, true),
                    _ => unreachable!(),
                };
                let b_ty = self.gen.type_to_basic_type(inner).unwrap();
                unsafe {
                    let ptr = if is_ptr {
                        self.gen
                            .builder
                            .build_gep(b_ty, arr_ptr, &[idx_val], "ptr")
                            .unwrap()
                    } else {
                        self.gen
                            .builder
                            .build_gep(
                                b_ty.array_type(100),
                                arr_ptr,
                                &[self.gen.context.i64_type().const_zero(), idx_val],
                                "ptr",
                            )
                            .unwrap()
                    };
                    Ok(self.gen.builder.build_load(b_ty, ptr, "val").unwrap())
                }
            }
            TExpressionKind::Cast {
                expression,
                target_type,
            } => {
                let val = self.compile_expression(expression)?;
                let src_type = &expression.typ;
                let dst_type = target_type;

                if (matches!(
                    src_type,
                    Type::Pointer(_) | Type::Custom(_, _) | Type::String
                ) || matches!(src_type, Type::Array(_, _)))
                    && matches!(dst_type, Type::Int)
                    && val.is_pointer_value()
                {
                    return Ok(self
                        .gen
                        .builder
                        .build_ptr_to_int(val.into_pointer_value(), self.gen.context.i64_type(), "")
                        .unwrap()
                        .into());
                } else if matches!(src_type, Type::Int) && matches!(dst_type, Type::Pointer(_)) {
                    return Ok(self
                        .gen
                        .builder
                        .build_int_to_ptr(
                            val.into_int_value(),
                            self.gen.context.ptr_type(AddressSpace::default()),
                            "",
                        )
                        .unwrap()
                        .into());
                }

                Ok(val)
            }
            TExpressionKind::Sizeof(t) => {
                let size = if let Some(basic) = self.gen.type_to_basic_type(t) {
                    let tm = Target::from_triple(&TargetMachine::get_default_triple())
                        .unwrap()
                        .create_target_machine(
                            &TargetMachine::get_default_triple(),
                            "generic",
                            "",
                            OptimizationLevel::None,
                            RelocMode::PIC,
                            CodeModel::Default,
                        )
                        .unwrap();
                    let td = tm.get_target_data();
                    td.get_store_size(&basic)
                } else {
                    0
                };
                Ok(self
                    .gen
                    .context
                    .i64_type()
                    .const_int(size, false)
                    .into())
            }
            _ => Ok(self.gen.context.i64_type().const_zero().into()),
        }
    }

    fn compile_lvalue(&mut self, expr: &TExpression) -> Result<PointerValue<'ctx>, CompileError> {
        match &expr.kind {
            TExpressionKind::Identifier(name) => {
                if let Some((loc, _)) = self.variables.get(name) {
                    match loc {
                        VarLoc::Stack(ptr) => Ok(*ptr),
                        _ => {
                            eprintln!("[CODEGEN] PANIC: Invalid lvalue: register var");
                            unreachable!()
                        }
                    }
                } else {
                    eprintln!("[CODEGEN] PANIC: Var not found: {}", name);
                    unreachable!()
                }
            }
            TExpressionKind::MemberAccess { object, field } => {
                let obj_ptr = self.compile_expression(object)?.into_pointer_value();
                let sn = if let Type::Custom(name, _) = &object.typ {
                    name
                } else if let Type::Pointer(inner) = &object.typ {
                    if let Type::Custom(name, _) = &**inner {
                        name
                    } else {
                        unreachable!()
                    }
                } else {
                    unreachable!()
                };
                if !self.gen.struct_types.contains_key(sn) {
                    eprintln!(
                        "[CODEGEN] PANIC: Struct type not found for member access: {}",
                        sn
                    );
                    eprintln!(
                        "[CODEGEN] Available structs: {:?}",
                        self.gen.struct_types.keys().collect::<Vec<_>>()
                    );
                }
                let st = self.gen.struct_types.get(sn).unwrap();
                let sd = self.gen.struct_decls.get(sn).unwrap();
                let idx = sd.fields.iter().position(|(n, _, _)| n == field).unwrap();
                Ok(self
                    .gen
                    .builder
                    .build_struct_gep(*st, obj_ptr, idx as u32, "fp")
                    .unwrap())
            }
            TExpressionKind::Unary {
                operator: TokenKind::Star,
                right,
            } => Ok(self.compile_expression(right)?.into_pointer_value()),
            _ => {
                eprintln!("[CODEGEN] PANIC: Invalid lvalue: {:?}", &expr.kind);
                unreachable!()
            }
        }
    }

    fn compile_statement(&mut self, stmt: &TStatement) -> Result<(), CompileError> {
        // Emit debug location
        if stmt.span.line > 0 {
            let loc = self.gen.dibuilder.create_debug_location(
                self.gen.context,
                stmt.span.line,
                stmt.span.col,
                self.gen.compile_unit.get_file().as_debug_info_scope(),
                None,
            );
            self.gen.builder.set_current_debug_location(loc);
        } else {
            self.gen.builder.unset_current_debug_location();
        }

        match &stmt.kind {
            TStatementKind::Let {
                name,
                var_type,
                value,
            } => {
                let val = if let Some(e) = value {
                    self.compile_expression(e)?
                } else {
                    self.gen.type_to_basic_type(var_type).unwrap().const_zero()
                };
                let alloca = self.create_alloca(name, var_type);
                self.emit_retain(val, var_type);
                self.gen.builder.build_store(alloca, val).unwrap();
                self.variables
                    .insert(name.clone(), (VarLoc::Stack(alloca), var_type.clone()));
                self.scope_stack.last_mut().unwrap().push(name.clone());
                Ok(())
            }
            TStatementKind::Assign { lvalue, rvalue } => {
                let addr = self.compile_lvalue(lvalue)?;
                let val = self.compile_expression(rvalue)?;
                if self.gen.is_ref_counted(&lvalue.typ) {
                    let old = self
                        .gen
                        .builder
                        .build_load(
                            self.gen.type_to_basic_type(&lvalue.typ).unwrap(),
                            addr,
                            "old",
                        )
                        .unwrap();
                    self.emit_retain(val, &lvalue.typ);
                    self.gen.builder.build_store(addr, val).unwrap();
                    self.emit_release(old, &lvalue.typ);
                } else {
                    self.gen.builder.build_store(addr, val).unwrap();
                }
                Ok(())
            }
            TStatementKind::Expr(e) => {
                self.compile_expression(e)?;
                Ok(())
            }
            TStatementKind::Break => {
                if let Some(bb) = self.loop_exit_stack.last() {
                    self.gen.builder.build_unconditional_branch(*bb).unwrap();
                } else {
                    return Err(CompileError {
                        message: "Break statement outside of loop".into(),
                        line: 0,
                        column: 0,
                    });
                }
                Ok(())
            }
            TStatementKind::Return(oe) => {
                let rv = oe
                    .as_ref()
                    .map(|e| self.compile_expression(e))
                    .transpose()?;
                if let Some(v) = rv {
                    self.emit_retain(v, &oe.as_ref().unwrap().typ);
                }
                self.cleanup_scope(0)?;
                if let Some(v) = rv {
                    self.gen.builder.build_return(Some(&v)).unwrap();
                } else {
                    self.gen.builder.build_return(None).unwrap();
                }
                Ok(())
            }
            TStatementKind::If {
                condition,
                then_block,
                else_block,
            } => {
                let cond = self.compile_expression(condition)?.into_int_value();
                let then_bb = self.gen.context.append_basic_block(self.fn_value, "then");
                let else_bb = self.gen.context.append_basic_block(self.fn_value, "else");
                let merge = self.gen.context.append_basic_block(self.fn_value, "cont");
                self.gen
                    .builder
                    .build_conditional_branch(cond, then_bb, else_bb)
                    .unwrap();
                self.gen.builder.position_at_end(then_bb);
                self.compile_block(then_block)?;
                if self
                    .gen
                    .builder
                    .get_insert_block()
                    .unwrap()
                    .get_terminator()
                    .is_none()
                {
                    self.gen.builder.build_unconditional_branch(merge).unwrap();
                }
                self.gen.builder.position_at_end(else_bb);
                if let Some(b) = else_block {
                    self.compile_block(b)?;
                }
                if self
                    .gen
                    .builder
                    .get_insert_block()
                    .unwrap()
                    .get_terminator()
                    .is_none()
                {
                    self.gen.builder.build_unconditional_branch(merge).unwrap();
                }
                self.gen.builder.position_at_end(merge);
                Ok(())
            }
            TStatementKind::While { condition, body } => {
                let cond_bb = self
                    .gen
                    .context
                    .append_basic_block(self.fn_value, "while_cond");
                let body_bb = self
                    .gen
                    .context
                    .append_basic_block(self.fn_value, "while_body");
                let end_bb = self
                    .gen
                    .context
                    .append_basic_block(self.fn_value, "while_end");
                self.gen
                    .builder
                    .build_unconditional_branch(cond_bb)
                    .unwrap();
                self.gen.builder.position_at_end(cond_bb);
                let cond = self.compile_expression(condition)?.into_int_value();
                self.gen
                    .builder
                    .build_conditional_branch(cond, body_bb, end_bb)
                    .unwrap();
                self.gen.builder.position_at_end(body_bb);
                self.loop_exit_stack.push(end_bb);
                self.compile_block(body)?;
                self.loop_exit_stack.pop();
                if self
                    .gen
                    .builder
                    .get_insert_block()
                    .unwrap()
                    .get_terminator()
                    .is_none()
                {
                    self.gen
                        .builder
                        .build_unconditional_branch(cond_bb)
                        .unwrap();
                }
                self.gen.builder.position_at_end(end_bb);
                Ok(())
            }
            TStatementKind::Block(b) => {
                self.compile_block(b)?;
                Ok(())
            }
            TStatementKind::Region { body } => {
                let save_fn = self.gen.module.get_function("lunite_arena_save").unwrap();
                let restore_fn = self
                    .gen
                    .module
                    .get_function("lunite_arena_restore")
                    .unwrap();
                let token = self
                    .gen
                    .builder
                    .build_call(save_fn, &[], "atoken")
                    .unwrap()
                    .try_as_basic_value()
                    .left()
                    .unwrap();
                self.compile_block(body)?;
                self.gen
                    .builder
                    .build_call(restore_fn, &[token.into()], "")
                    .unwrap();
                Ok(())
            }
            TStatementKind::Throw { value } => {
                 let val = self.compile_expression(value)?;
                 let throw_fn = self.gen.module.get_function("lunite_throw").unwrap();
                 let void_ptr = self.gen.builder.build_bit_cast(
                     val.into_pointer_value(),
                     self.gen.context.ptr_type(AddressSpace::default()),
                     "throw_val"
                 ).unwrap();
                 self.gen.builder.build_call(throw_fn, &[void_ptr.into()], "").unwrap();
                 self.gen.builder.build_unreachable().unwrap();
                 Ok(())
            }
            TStatementKind::Spawn(e) => {
                if let TExpressionKind::Call { function, args } = &e.kind {
                    let mut arg_vals = Vec::new();
                    for arg in args {
                        arg_vals.push(self.compile_expression(arg)?);
                    }

                    let spawn_fn =
                        self.gen
                            .module
                            .get_function("lunite_spawn")
                            .unwrap_or_else(|| {
                                let void_type = self.gen.context.void_type();
                                let ptr_type = self.gen.context.ptr_type(AddressSpace::default());
                                let func_type =
                                    void_type.fn_type(&[ptr_type.into(), ptr_type.into()], false);
                                self.gen
                                    .module
                                    .add_function("lunite_spawn", func_type, None)
                            });

                    let target_fn = self
                        .gen
                        .module
                        .get_function(function)
                        .expect("Spawned function not found");

                    // Simple case: function takes one argument that fits in a pointer
                    let arg0 = if !arg_vals.is_empty() {
                        let v = arg_vals[0];
                        if v.is_pointer_value() {
                            v.into_pointer_value()
                        } else {
                            // Cast int to pointer for lunite_spawn
                            self.gen
                                .builder
                                .build_int_to_ptr(
                                    v.into_int_value(),
                                    self.gen.context.ptr_type(AddressSpace::default()),
                                    "argcat",
                                )
                                .unwrap()
                        }
                    } else {
                        self.gen
                            .context
                            .ptr_type(AddressSpace::default())
                            .const_null()
                    };

                    let fn_ptr_cast = self
                        .gen
                        .builder
                        .build_bit_cast(
                            target_fn.as_global_value().as_pointer_value(),
                            self.gen.context.ptr_type(AddressSpace::default()),
                            "fn_cast",
                        )
                        .unwrap();

                    self.gen
                        .builder
                        .build_call(spawn_fn, &[fn_ptr_cast.into(), arg0.into()], "")
                        .unwrap();
                }
                Ok(())
            }
            TStatementKind::TryCatch {
                try_block,
                catch_variable,
                catch_block,
            } => {
                self.compile_block(try_block)?;
                Ok(())
            }
            TStatementKind::When { subject, arms } => {
                let subj_val = self.compile_expression(subject)?;
                let end_bb = self
                    .gen
                    .context
                    .append_basic_block(self.fn_value, "when_end");

                for arm in arms {
                    let next_arm_bb = self
                        .gen
                        .context
                        .append_basic_block(self.fn_value, "when_next");
                    let body_bb = self
                        .gen
                        .context
                        .append_basic_block(self.fn_value, "when_body");

                    match &arm.pattern {
                        TWhenPattern::Else => {
                            self.gen
                                .builder
                                .build_unconditional_branch(body_bb)
                                .unwrap();
                        }
                        TWhenPattern::Literal(lit) => {
                            let lv = self.compile_expression(lit)?;
                            let is_match = if subj_val.is_int_value() {
                                self.gen
                                    .builder
                                    .build_int_compare(
                                        IntPredicate::EQ,
                                        subj_val.into_int_value(),
                                        lv.into_int_value(),
                                        "match",
                                    )
                                    .unwrap()
                            } else {
                                let s = self
                                    .gen
                                    .builder
                                    .build_ptr_to_int(
                                        subj_val.into_pointer_value(),
                                        self.gen.context.i64_type(),
                                        "s",
                                    )
                                    .unwrap();
                                let l = self
                                    .gen
                                    .builder
                                    .build_ptr_to_int(
                                        lv.into_pointer_value(),
                                        self.gen.context.i64_type(),
                                        "l",
                                    )
                                    .unwrap();
                                self.gen
                                    .builder
                                    .build_int_compare(IntPredicate::EQ, s, l, "match")
                                    .unwrap()
                            };
                            self.gen
                                .builder
                                .build_conditional_branch(is_match, body_bb, next_arm_bb)
                                .unwrap();
                        }
                        TWhenPattern::EnumVariant {
                            enum_name,
                            tag,
                            binding,
                            ..
                        } => {
                            let et = self.gen.enum_types.get(enum_name).unwrap();
                            let tag_ptr = self
                                .gen
                                .builder
                                .build_struct_gep(*et, subj_val.into_pointer_value(), 0, "tptr")
                                .unwrap();
                            let actual_tag = self
                                .gen
                                .builder
                                .build_load(self.gen.context.i64_type(), tag_ptr, "tag")
                                .unwrap()
                                .into_int_value();
                            let is_match = self
                                .gen
                                .builder
                                .build_int_compare(
                                    IntPredicate::EQ,
                                    actual_tag,
                                    self.gen.context.i64_type().const_int(*tag as u64, false),
                                    "match",
                                )
                                .unwrap();
                            self.gen
                                .builder
                                .build_conditional_branch(is_match, body_bb, next_arm_bb)
                                .unwrap();

                            if let Some(bname) = binding {
                                let current_bb = self.gen.builder.get_insert_block().unwrap();
                                self.gen.builder.position_at_end(body_bb);
                                let p_ptr = self
                                    .gen
                                    .builder
                                    .build_struct_gep(*et, subj_val.into_pointer_value(), 1, "pptr")
                                    .unwrap();
                                let ed = self.gen.enum_decls.get(enum_name).unwrap();
                                let v_ty = ed.variants[*tag as usize].typ.as_ref().unwrap();
                                let b_ty = self.gen.type_to_basic_type(v_ty).unwrap();
                                let p_cast = self
                                    .gen
                                    .builder
                                    .build_bit_cast(
                                        p_ptr,
                                        self.gen.context.ptr_type(AddressSpace::default()),
                                        "pcast",
                                    )
                                    .unwrap()
                                    .into_pointer_value();
                                let val =
                                    self.gen.builder.build_load(b_ty, p_cast, "pval").unwrap();

                                let alloca = self.create_alloca(bname, v_ty);
                                self.emit_retain(val, v_ty);
                                self.gen.builder.build_store(alloca, val).unwrap();
                                self.variables
                                    .insert(bname.clone(), (VarLoc::Stack(alloca), v_ty.clone()));
                                // We will push this to scope later when entering the arm body
                                self.gen.builder.position_at_end(current_bb);
                            }
                        }
                    }

                    self.gen.builder.position_at_end(body_bb);
                    self.scope_stack.push(Vec::new());
                    if let TWhenPattern::EnumVariant {
                        binding: Some(bname),
                        ..
                    } = &arm.pattern
                    {
                        self.scope_stack.last_mut().unwrap().push(bname.clone());
                    }
                    for stmt in &arm.body.statements {
                        self.compile_statement(stmt)?;
                    }
                    if self
                        .gen
                        .builder
                        .get_insert_block()
                        .unwrap()
                        .get_terminator()
                        .is_none()
                    {
                        self.cleanup_current_scope()?;
                        self.gen.builder.build_unconditional_branch(end_bb).unwrap();
                    }
                    self.scope_stack.pop();
                    self.gen.builder.position_at_end(next_arm_bb);
                }

                if self
                    .gen
                    .builder
                    .get_insert_block()
                    .unwrap()
                    .get_terminator()
                    .is_none()
                {
                    self.gen.builder.build_unconditional_branch(end_bb).unwrap();
                }
                self.gen.builder.position_at_end(end_bb);
                Ok(())
            }
            _ => Ok(()),
        }
    }
}