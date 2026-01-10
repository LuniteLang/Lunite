fn main() {
    // No C files to compile anymore. Pure Rust!
    println!("cargo:rerun-if-changed=build.rs");
}
