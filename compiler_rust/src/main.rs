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

use ast::Program;
use codegen::CodeGenerator;
use inkwell::context::Context;
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
            eprintln!(
                "\x1b[1;31mError\x1b[0m in {}:{}:{}",
                filename, err.line, err.column
            );
            eprintln!("   |");
            eprintln!("{:2} | {}", err.line, line_content);
            eprintln!(
                "   | \x1b[1;31m{}^\x1b[0m {}",
                " ".repeat(err.column),
                err.message
            );
            eprintln!("   |");
        } else {
            eprintln!("Error in {}: {}", filename, err.message);
        }
    } else {
        eprintln!("Error reading file {}: {}", filename, err.message);
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
        eprintln!("  lsp                                  Start Language Server");
        std::process::exit(1);
    }

    let command = &args[1];
    let mut lib_paths = Vec::new();
    let mut file_arg = None;
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
                run_file(&filename, lib_paths);
            } else {
                eprintln!("Usage: lunite run <file.lun> [--lib-path <path>]");
                std::process::exit(1);
            }
        }
        "build" => {
            if let Some(filename) = file_arg {
                build_file(&filename, lib_paths);
            } else {
                eprintln!("Usage: lunite build <file.lun> [--lib-path <path>]");
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
        _ => {
            eprintln!("Unknown command: {}", command);
            std::process::exit(1);
        }
    }
}

fn parse_modules(_entry_file: &str) -> (HashMap<PathBuf, Program>, HashMap<PathBuf, String>) {
    (HashMap::new(), HashMap::new())
}

fn run_file(filename: &str, lib_paths: Vec<PathBuf>) {
    let mut analyzer = SemanticAnalyzer::new(lib_paths);
    let main_path = PathBuf::from(filename);

    match analyzer.analyze_main(main_path) {
        Ok(modules) => {
            let context = Context::create();
            let mut generator = CodeGenerator::new(&context);
            if let Err(e) = generator.compile_modules(modules) {
                print_error_report(filename, e);
                std::process::exit(1);
            }
            generator.run_main();
        }
        Err(e) => {
            print_error_report(filename, e);
            std::process::exit(1);
        }
    }
}

fn build_file(filename: &str, lib_paths: Vec<PathBuf>) {
    ensure_runtime_lib();

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
            let mut generator = CodeGenerator::new(&context);
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
