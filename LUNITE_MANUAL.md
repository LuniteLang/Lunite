# Lunite Language Manual

Lunite is a high-performance, systems-oriented programming language designed for the self-hosting challenge. It features a modern syntax, a robust type system with generics, and automatic reference counting (ARC) for memory safety.

## 1. Getting Started

### Project Structure
- `compiler_rust/`: The bootstrap compiler written in Rust.
- `compiler_lunite/`: The self-hosted compiler implementation in Lunite.
- `std/`: The standard library containing core modules like `string`, `io`, `list`, and `map`.
- `tests/`: A comprehensive suite of language and compiler tests.

### Building the Compiler
To build the Rust-based compiler:
```bash
cd compiler_rust
cargo build
```

### Running the Compiler
```bash
# Compile a Lunite file
./compiler_rust/target/debug/lunite_lang build input.lun

# Execute the resulting binary
./input
```

## 2. Basic Syntax

### Variables
Use `let` for immutable variables and `let mut` for mutable ones.
```lunite
let x = 10;
let mut y = 20;
y = 30;
```

### Functions
Functions are declared with `fn`.
```lunite
pub fn add(a: int, b: int) -> int {
    return a + b;
}
```

### Visibility
Use `pub` to make functions, structs, and enums accessible from other modules.

## 3. Type System

### Primitive Types
- `int`: 64-bit integer
- `float`: 64-bit floating point
- `bool`: `true` or `false`
- `string`: UTF-8 string
- `void`: Empty type

### Pointers
Pointers are declared using `*T`.
```lunite
let x = 10;
let p: *int = &x;
let val = *p; // Dereference
```

### Structs
Structs group related data.
```lunite
pub struct Point {
    pub x: int,
    pub y: int
}

let p = Point { x: 1, y: 2 };
```

### Enums
Enums support variants with optional payloads.
```lunite
pub enum Option<T> {
    Some(T),
    None
}
```

### Generics
Structs, Enums, and Functions support generic parameters.
```lunite
pub struct List<T> {
    pub data: *T,
    pub len: int
}
```

## 4. Control Flow

### If-Else
```lunite
if (x > 0) {
    print("Positive");
} else {
    print("Zero or Negative");
}
```

### While Loop
```lunite
while (i < 10) {
    i = i + 1;
}
```

### When Statement
`when` is a powerful pattern matching construct, especially useful for enums.
```lunite
when (opt) {
    Option::Some(v) => { print(v); },
    Option::None => { print("Nothing"); },
    else => { print("Unknown"); }
}
```

## 5. Error Handling

### Result and Option
Lunite uses `Result<T, E>` and `Option<T>` for error handling.
```lunite
fn compute() -> Result<int, string> {
    if (error) { return Result::Err("failed"); }
    return Result::Ok(1);
}
```

### Try Operator (?)
The `?` operator can be used to propagate errors.
```lunite
let val = compute()?; // Returns early if Err
```

## 6. Standard Library

### string
- `str.concat(s1, s2)`
- `str.length(s)`
- `str.println(s)`

### io
- `io.read_file(path)`
- `io.print(s)`

### list
- `list.List<T>.new()`
- `list.push(item)`
- `list.get(index)`

## 7. Memory Management
Lunite uses **Automatic Reference Counting (ARC)** for managed types (Structs and Enums). Memory is automatically freed when the last reference to an object is dropped. Manual memory management via pointers is also available for low-level tasks.
