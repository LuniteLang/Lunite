# 🌙 Lunite Programming Language

**Lunite** là một ngôn ngữ lập trình biên dịch hiệu năng cao, được xây dựng bằng Rust và tận dụng sức mạnh của LLVM làm backend. Lunite kết hợp các tính năng hiện đại như Generics, Pattern Matching với một hệ thống quản lý bộ nhớ lai độc đáo.

## 🚀 Tính năng nổi bật

- **Biên dịch LLVM:** Tối ưu hóa mã máy ở cấp độ cao nhất (Aggressive Optimization).
- **Quản lý bộ nhớ lai (Hybrid Memory Management):** 
    - **ARC (Automatic Reference Counting):** Giải phóng bộ nhớ tức thì cho hiệu năng tối đa.
    - **Mark-and-Sweep GC:** Tự động dọn dẹp các vòng lặp tham chiếu (cycles) và bộ nhớ rò rỉ.
    - **Memory Regions:** Cơ chế Arena allocation giúp quản lý bộ nhớ theo vùng cực nhanh.
- **Tính năng ngôn ngữ hiện đại:**
    - **Generics:** Hỗ trợ đa hình thông qua Monomorphization (giống C++/Rust).
    - **Pattern Matching:** Sử dụng từ khóa `when` mạnh mẽ và trực quan.
    - **Xử lý lỗi:** Hệ thống `Result<T, E>` với toán tử `?` (Early Return).
    - **Comptime:** Cho phép thực thi mã ngay trong quá trình biên dịch.
    - **Struct Layouts:** Hỗ trợ cả AoS (Array of Structures) và SoA (Structure of Arrays).
- **Concurrency & Networking:** Hỗ trợ `spawn` luồng, giao tiếp qua `channel` và lập trình mạng TCP/IP.

## 🛠️ Yêu cầu hệ thống

- **Rust** (phiên bản mới nhất)
- **LLVM 18** (bao gồm cả các file tiêu đề cho thư viện C++)
- **Linker (cc/gcc)**

## 🔨 Hướng dẫn Build

Để biên dịch trình biên dịch Lunite:

```bash
cargo build --release
```

Sau khi build xong, file thực thi sẽ nằm tại `./target/release/lunite_lang`.

## 📦 Cách sử dụng

### Biên dịch một file .lun
```bash
./target/release/lunite_lang build your_file.lun
./your_file
```

### Chạy trực tiếp (JIT mode)
```bash
./target/release/lunite_lang run your_file.lun
```

## 📝 Ví dụ mã nguồn (List động với Generics)

```rust
import "std/list.lun" as list

fn main() {
    let li = list.List<int>.new(0)
    let i = 0
    while (500 > i) {
        li.push(i)
        i = i + 1
    }
    print("List count:")
    lunite_print_int(li.len())
}
```

## 📂 Cấu trúc dự án

- `src/`: Mã nguồn của trình biên dịch (Lexer, Parser, Semantic, Codegen).
- `std/`: Thư viện tiêu chuẩn (IO, Math, Net, Sync, String, v.v.).
- `runtime_build/`: (Legacy) Thư mục chứa runtime tách biệt.
- `src/runtime.rs`: Linh hồn của hệ thống runtime Lunite (Memory, GC, FFI).

---
*Dự án được phát triển và tối ưu bởi Matty GPT & Sếp.*
