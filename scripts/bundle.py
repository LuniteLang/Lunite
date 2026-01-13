import os
import re

def bundle(entry_file, output_file):
    processed_files = set()
    bundled_content = []
    
    # Simple dependency order for compiler
    files_to_bundle = [
        "std/io.lun",
        "std/sys.lun",
        "std/string.lun",
        "std/list.lun",
        "std/map.lun",
        "compiler_lunite/token.lun",
        "compiler_lunite/ast.lun",
        "compiler_lunite/lexer.lun",
        "compiler_lunite/parser.lun",
        "compiler_lunite/codegen_c.lun",
        "compiler_lunite/main_compiler.lun"
    ]
    
    aliases = {
        "io": "io",
        "sys": "sys",
        "str": "str",
        "list": "list",
        "map": "map",
        "tok": "tok",
        "ast": "ast",
        "lexer": "lexer",
        "parser": "parser",
        "codegen": "codegen"
    }

    for file_path in files_to_bundle:
        if not os.path.exists(file_path):
            print(f"Warning: {file_path} not found")
            continue
            
        with open(file_path, 'r') as f:
            content = f.read()
            
            # Remove imports
            content = re.sub(r'import\s+".*?"\s+as\s+\w+', '', content)
            
            # Replace alias calls (e.g., str.println -> println)
            # This is tricky because some aliases might be parts of other words.
            # We'll use a regex for common aliases.
            for alias in aliases:
                content = re.sub(r'\b' + alias + r'\.', '', content)
            
            bundled_content.append(f"// --- From {file_path} ---\n")
            bundled_content.append(content)
            bundled_content.append("\n")

    with open(output_file, 'w') as f:
        f.write("".join(bundled_content))
    print(f"Bundled into {output_file}")

bundle("compiler_lunite/main_compiler.lun", "build_artifacts/compiler_bundled.lun")
