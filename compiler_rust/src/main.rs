#![allow(unused)]
use std::collections::{HashMap, VecDeque};
use std::fs;
use std::io::Write;
use std::path::{Path, PathBuf};

mod ast;
mod codegen;
mod interpreter;
mod lexer;
mod parser;
mod runtime;
mod semantic;
mod token;
mod lpm;

use ast::Program;
use codegen::CodeGenerator;
use inkwell::context::Context;
use inkwell::OptimizationLevel;
use lexer::Lexer;
use parser::Parser;
use semantic::SemanticAnalyzer;

#[derive(Debug)]
pub struct CompileError {
    pub message: String,
    pub line: usize,
    pub column: usize,
}

impl std::fmt::Display for CompileError {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        write!(
            f,
            "Error at [{}:{}]: {}",
            self.line, self.column, self.message
        )
    }
}

fn print_error_report(filename: &str, err: CompileError) {
    if let Ok(content) = fs::read_to_string(filename) {
        let lines: Vec<&str> = content.lines().collect();
        if err.line > 0 && err.line <= lines.len() {
            let line_content = lines[err.line - 1];
            eprintln!("\n\x1b[1;31merror\x1b[0m: \x1b[1m{}\x1b[0m", err.message);
            eprintln!(
                "  \x1b[1;34m--\x1b[0m {}:{}:{}",
                filename, err.line, err.column
            );
            eprintln!("\x1b[1;34m   |\x1b[0m");
            eprintln!("\x1b[1;34m{:2} |\x1b[0m {}", err.line, line_content);
            let pointer = if err.column > 0 {
                " ".repeat(err.column.saturating_sub(1)) + "^"
            } else {
                "^".to_string()
            };
            eprintln!("\x1b[1;34m   | \x1b[1;31m{}\x1b[0m", pointer);
            eprintln!("\x1b[1;34m   |\x1b[0m");
        } else {
            eprintln!("\n\x1b[1;31merror\x1b[0m: \x1b[1m{}\x1b[0m", err.message);
            if err.line > 0 {
                eprintln!(
                    "  \x1b[1;34m--\x1b[0m {}:{}:{}",
                    filename, err.line, err.column
                );
            } else {
                eprintln!("  \x1b[1;34m--\x1b[0m {}", filename);
            }
        }
    } else {
        eprintln!("\x1b[1;31merror\x1b[0m: \x1b[1m{}\x1b[0m", err.message);
    }
}

fn main() {
    let args: Vec<String> = std::env::args().collect();
    if args.len() < 2 {
        eprintln!("Usage: lunite <command> [args]");
        eprintln!("Commands:");
        eprintln!("  run <file.lun> [--lib-path <path>]   Run the script (JIT)");
        eprintln!("  build <file.lun> [--lib-path <path>] Build an object file");
        eprintln!("  check <file.lun> [--lib-path <path>] Check for errors");
        eprintln!("  fmt <file.lun>                       Format code");
        eprintln!("  doc <file.lun>                       Generate documentation");
        eprintln!("  init <project_name>                  Initialize a new project");
        eprintln!("  lsp                                  Start Language Server");
        eprintln!("\nOptions:");
        eprintln!("  -O0, -O1, -O2, -O3                   Optimization level (default: -O0)");
        std::process::exit(1);
    }

    let command = &args[1];
    let mut lib_paths = Vec::new();
    let mut file_arg = None;
    let mut opt_level = OptimizationLevel::None;
    let mut target_triple = None;
    let mut i = 2;

    while i < args.len() {
        if args[i] == "--lib-path" {
            if i + 1 < args.len() {
                lib_paths.push(PathBuf::from(&args[i + 1]));
                i += 2;
            } else {
                eprintln!("Error: --lib-path requires a path argument");
                std::process::exit(1);
            }
        } else if args[i] == "--target" {
            if i + 1 < args.len() {
                target_triple = Some(args[i + 1].clone());
                i += 2;
            } else {
                eprintln!("Error: --target requires a triple argument");
                std::process::exit(1);
            }
        } else if args[i] == "-O1" {
            opt_level = OptimizationLevel::Less;
            i += 1;
        } else if args[i] == "-O2" {
            opt_level = OptimizationLevel::Default;
            i += 1;
        } else if args[i] == "-O3" {
            opt_level = OptimizationLevel::Aggressive;
            i += 1;
        } else if args[i] == "-O0" {
            opt_level = OptimizationLevel::None;
            i += 1;
        } else if args[i].starts_with("-") {
            i += 1; // Skip other flags for now
        } else {
            if file_arg.is_none() {
                file_arg = Some(args[i].clone());
            }
            i += 1;
        }
    }

    match command.as_str() {
        "run" => {
            if let Some(filename) = file_arg {
                // Collect args after the script name
                let mut script_args = Vec::new();
                let mut found_script = false;
                for arg in &args {
                    if found_script {
                        script_args.push(arg.clone());
                    }
                    if arg == &filename {
                        found_script = true;
                    }
                }
                
                // Convert to C-style argc/argv
                let c_args: Vec<std::ffi::CString> = script_args.into_iter()
                    .map(|s| std::ffi::CString::new(s).unwrap())
                    .collect();
                let c_argv: Vec<*const i8> = c_args.iter()
                    .map(|s| s.as_ptr())
                    .collect();
                
                run_file(&filename, lib_paths, opt_level, target_triple, c_argv.len() as i32, c_argv.as_ptr());
            } else {
                eprintln!("Usage: lunite run <file.lun> [--lib-path <path>] [-O0/-O1/-O2/-O3] [--target <triple>]");
                std::process::exit(1);
            }
        }
        "build" => {
            if let Some(filename) = file_arg {
                build_file(&filename, lib_paths, opt_level, target_triple);
            } else {
                eprintln!("Usage: lunite build <file.lun> [--lib-path <path>] [-O0/-O1/-O2/-O3] [--target <triple>]");
                std::process::exit(1);
            }
        }
        "check" => {
            if let Some(filename) = file_arg {
                run_check(&filename, lib_paths);
            } else {
                eprintln!("Usage: lunite check <file.lun> [--lib-path <path>]");
                std::process::exit(1);
            }
        }
        "fmt" => {
            if let Some(filename) = file_arg {
                run_fmt(&filename);
            } else {
                eprintln!("Usage: lunite fmt <file.lun>");
                std::process::exit(1);
            }
        }
        "doc" => {
            if let Some(filename) = file_arg {
                run_doc(&filename);
            } else {
                eprintln!("Usage: lunite doc <file.lun>");
                std::process::exit(1);
            }
        }
        "lsp" => run_lsp(),
        "init" => {
            if let Some(name) = file_arg {
                run_init(&name);
            } else {
                eprintln!("Usage: lunite init <project_name>");
                std::process::exit(1);
            }
        }
        _ => {
            eprintln!("Unknown command: {}", command);
            std::process::exit(1);
        }
    }
}

fn parse_modules(_entry_file: &str) -> (HashMap<PathBuf, Program>, HashMap<PathBuf, String>) {
    (HashMap::new(), HashMap::new())
}

fn resolve_lpm_dependencies() -> Vec<PathBuf> {
    let manifest_path = Path::new("lunite.toml");
    if !manifest_path.exists() {
        return Vec::new();
    }
    
    println!("[LPM] Found lunite.toml, resolving dependencies...");
    match lpm::parse_manifest(manifest_path) {
        Ok(m) => {
            match m.fetch_all() {
                Ok(paths) => paths,
                Err(e) => {
                    eprintln!("[LPM] Error fetching dependencies: {}", e);
                    Vec::new()
                }
            }
        },
        Err(e) => {
            eprintln!("[LPM] Error parsing manifest: {}", e);
            Vec::new()
        }
    }
}

fn run_file(filename: &str, mut lib_paths: Vec<PathBuf>, opt_level: OptimizationLevel, target: Option<String>, argc: i32, argv: *const *const i8) {
    let lpm_paths = resolve_lpm_dependencies();
    lib_paths.extend(lpm_paths);

    let mut analyzer = SemanticAnalyzer::new(lib_paths);
    let main_path = PathBuf::from(filename);

    match analyzer.analyze_main(main_path) {
        Ok(modules) => {
            let context = Context::create();
            let mut generator = CodeGenerator::new(&context, opt_level, target);
            if let Err(e) = generator.compile_modules(modules) {
                print_error_report(filename, e);
                std::process::exit(1);
            }
            generator.run_main(argc, argv);
        }
        Err(e) => {
            print_error_report(filename, e);
            std::process::exit(1);
        }
    }
}

fn build_file(filename: &str, mut lib_paths: Vec<PathBuf>, opt_level: OptimizationLevel, target: Option<String>) {
    ensure_runtime_lib();
    
    let lpm_paths = resolve_lpm_dependencies();
    lib_paths.extend(lpm_paths);

    let args: Vec<String> = std::env::args().collect();
    let mut link_args = Vec::new();

    let mut i = 2;
    while i < args.len() {
        if args[i].starts_with("-l") || args[i].starts_with("-L") {
            link_args.push(args[i].clone());
        }
        i += 1;
    }

    let mut analyzer = SemanticAnalyzer::new(lib_paths);

    match analyzer.analyze_main(PathBuf::from(filename)) {
        Ok(modules) => {
            let context = Context::create();
            let mut generator = CodeGenerator::new(&context, opt_level, target);
            if let Err(e) = generator.compile_modules(modules) {
                print_error_report(filename, e);
                std::process::exit(1);
            }
            let obj_file = PathBuf::from(filename).with_extension("o");
            if let Err(e) = generator.build_object_file(&obj_file) {
                eprintln!("Failed to write object file: {}", e);
                std::process::exit(1);
            }
            println!("Built object file: {}", obj_file.display());

            let exe_file = PathBuf::from(filename).with_extension("");
            println!("Linking {}...", exe_file.display());
            let mut cmd = std::process::Command::new("cc");
            let runtime_lib = if Path::new("libruntime.a").exists() {
                "libruntime.a"
            } else {
                "compiler_rust/libruntime.a"
            };
            cmd.arg(&obj_file)
                .arg(runtime_lib)
                .arg("-o")
                .arg(&exe_file)
                .arg("-lm")
                .arg("-lpthread")
                .arg("-ldl");
            // Add user link args
            for arg in link_args {
                cmd.arg(arg);
            }

            let status = cmd.status();

            match status {
                Ok(s) if s.success() => println!("Executable created: {}", exe_file.display()),
                _ => eprintln!("Linking failed."),
            }
        }
        Err(e) => {
            print_error_report(filename, e);
            std::process::exit(1);
        }
    }
}

fn run_init(name: &str) {
    println!("Initializing project: {}...", name);
    let root = PathBuf::from(name);
    fs::create_dir_all(root.join("src")).expect("Failed to create src dir");

    let main_lun = "import \"std/string.lun\" as str\n\nfn main() {\n    str.println(\"Hello, Lunite!\");\n}\n";
    fs::write(root.join("src/main.lun"), main_lun).expect("Failed to write main.lun");

    println!("Project {} initialized successfully!", name);
    println!("To build: cd {} && lunite build src/main.lun", name);
}

fn ensure_runtime_lib() {
    if !Path::new("libruntime.a").exists() {
        println!("Compiling runtime library...");
        let runtime_src = if Path::new("src/runtime.rs").exists() {
            "src/runtime.rs"
        } else {
            "compiler_rust/src/runtime.rs"
        };
        let status = std::process::Command::new("rustc")
            .args([
                "--crate-type",
                "staticlib",
                "--edition",
                "2021",
                "-C",
                "panic=unwind",
                "-C",
                "force-unwind-tables",
                "-o",
                "libruntime.a",
                runtime_src,
            ])
            .status();

        match status {
            Ok(s) if s.success() => println!("Runtime library compiled successfully."),
            _ => {
                eprintln!("Failed to compile runtime library. Ensure 'rustc' is installed.");
                std::process::exit(1);
            }
        }
    }
}

fn run_lsp() {
    use std::io::BufRead;
    let stdin = std::io::stdin();
    for line in stdin.lock().lines() {
        let line = line.unwrap();
        eprintln!("LSP received: {}", line);
    }
}

fn run_check(filename: &str, lib_paths: Vec<PathBuf>) {
    let mut analyzer = SemanticAnalyzer::new(lib_paths);
    match analyzer.analyze_main(PathBuf::from(filename)) {
        Ok(_) => println!("Check successful. No errors found."),
        Err(e) => {
            print_error_report(filename, e);
            std::process::exit(1);
        }
    }
}

fn run_fmt(filename: &str) {
    if let Ok(content) = fs::read_to_string(filename) {
        let mut indent: usize = 0;
        let mut formatted = String::new();
        for line in content.lines() {
            let trimmed = line.trim();
            if trimmed.starts_with("}") {
                indent = indent.saturating_sub(1);
            }
            if !trimmed.is_empty() {
                formatted.push_str(&"    ".repeat(indent));
                formatted.push_str(trimmed);
                formatted.push('\n');
            }
            if trimmed.ends_with("{") {
                indent += 1;
            }
        }
        if let Err(e) = fs::write(filename, formatted) {
            eprintln!("Failed to write formatted file: {}", e);
        } else {
            println!("Formatted {}", filename);
        }
    } else {
        eprintln!("Failed to read file {}", filename);
    }
}

fn run_doc(filename: &str) {
    if let Ok(content) = fs::read_to_string(filename) {
        println!("# Documentation for {}", filename);
        for line in content.lines() {
            let trimmed = line.trim();
            if trimmed.starts_with("///") {
                println!("{}", trimmed.trim_start_matches("///").trim());
            } else if trimmed.starts_with("fn ") || trimmed.starts_with("pub fn ") {
                println!("**Function:** `{}`\n", trimmed.trim_end_matches("{").trim());
            } else if trimmed.starts_with("struct ") || trimmed.starts_with("pub struct ") {
                println!("**Struct:** `{}`\n", trimmed.trim_end_matches("{").trim());
            }
        }
    } else {
        eprintln!("Failed to read file {}", filename);
    }
}
