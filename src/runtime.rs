use std::fs;
use std::net::{TcpListener, TcpStream};
use std::ptr;

#[repr(C)]
pub struct LuniteString {
    pub ptr: *const u8,
    pub len: usize,
}

#[no_mangle]
pub extern "C" fn lunite_alloc(size: usize, _p1: *mut u8, _p2: *mut u8) -> *mut u8 {
    unsafe {
        let layout = std::alloc::Layout::from_size_align(size + 16, 16).unwrap();
        let ptr = std::alloc::alloc_zeroed(layout);
        if ptr.is_null() {
            return ptr;
        }
        *(ptr as *mut usize) = size;
        *(ptr.add(8) as *mut usize) = 1; // Ref count
        ptr.add(16)
    }
}

#[no_mangle]
pub extern "C" fn lunite_retain(user_ptr: *mut u8) {
    if user_ptr.is_null() {
        return;
    }
    unsafe {
        let rc_ptr = user_ptr.sub(8) as *mut usize;
        *rc_ptr += 1;
    }
}

#[no_mangle]
pub extern "C" fn lunite_release(user_ptr: *mut u8) {
    if user_ptr.is_null() {
        return;
    }
    unsafe {
        let rc_ptr = user_ptr.sub(8) as *mut usize;
        if *rc_ptr > 0 {
            *rc_ptr -= 1;
            if *rc_ptr == 0 {
                let size_ptr = user_ptr.sub(16) as *mut usize;
                let size = *size_ptr;
                let layout = std::alloc::Layout::from_size_align(size + 16, 16).unwrap();
                std::alloc::dealloc(user_ptr.sub(16), layout);
            }
        }
    }
}

#[no_mangle]
pub extern "C" fn lunite_print(s: *const LuniteString) {
    if s.is_null() {
        println!("(null)");
        return;
    }
    unsafe {
        if (*s).ptr.is_null() {
            println!("(null)");
            return;
        }
        let slice = std::slice::from_raw_parts((*s).ptr, (*s).len);
        println!("{}", String::from_utf8_lossy(slice));
    }
}

#[no_mangle]
pub extern "C" fn print(s: *const LuniteString) {
    lunite_print(s);
}

#[no_mangle]
pub extern "C" fn lunite_print_int(n: i64) {
    println!("{}", n);
}
#[no_mangle]
pub extern "C" fn lunite_print_float(n: f64) {
    println!("{}", n);
}

pub fn make_lunite_string(s: &str) -> *mut LuniteString {
    unsafe {
        let len = s.len();
        let data = lunite_alloc(len, ptr::null_mut(), ptr::null_mut());
        ptr::copy_nonoverlapping(s.as_ptr(), data, len);
        let res = lunite_alloc(16, ptr::null_mut(), ptr::null_mut()) as *mut LuniteString;
        (*res).ptr = data;
        (*res).len = len;
        res
    }
}

#[no_mangle]
pub extern "C" fn lunite_io_read_file(p: *const LuniteString) -> LuniteResult {
    unsafe {
        let path = String::from_utf8_lossy(std::slice::from_raw_parts((*p).ptr, (*p).len));
        match fs::read_to_string(path.as_ref()) {
            Ok(c) => LuniteResult {
                tag: 0,
                payload: make_lunite_string(&c) as i64,
            },
            Err(_) => LuniteResult { tag: 1, payload: 0 },
        }
    }
}

#[repr(C)]
pub struct LuniteResult {
    pub tag: i64,
    pub payload: i64,
}

#[no_mangle]
pub extern "C" fn lunite_io_write_file(p: *const LuniteString, c: *const LuniteString) -> i64 {
    unsafe {
        let path = String::from_utf8_lossy(std::slice::from_raw_parts((*p).ptr, (*p).len));
        let content = std::slice::from_raw_parts((*c).ptr, (*c).len);
        match fs::write(path.as_ref(), content) {
            Ok(_) => 0,
            Err(_) => -1,
        }
    }
}

#[no_mangle]
pub extern "C" fn lunite_str_len_runtime(s: *const LuniteString) -> i64 {
    if s.is_null() {
        0
    } else {
        unsafe { (*s).len as i64 }
    }
}
#[no_mangle]
pub extern "C" fn lunite_str_at(s: *const LuniteString, i: i64) -> i64 {
    if s.is_null() || i < 0 || i as usize >= unsafe { (*s).len } {
        -1
    } else {
        unsafe { *(*s).ptr.add(i as usize) as i64 }
    }
}

#[no_mangle]
pub extern "C" fn lunite_str_concat(
    s1: *const LuniteString,
    s2: *const LuniteString,
) -> *mut LuniteString {
    unsafe {
        let l1 = if s1.is_null() { 0 } else { (*s1).len };
        let l2 = if s2.is_null() { 0 } else { (*s2).len };
        let new_len = l1 + l2;
        let data = lunite_alloc(new_len, ptr::null_mut(), ptr::null_mut());
        if !s1.is_null() {
            ptr::copy_nonoverlapping((*s1).ptr, data, l1);
        }
        if !s2.is_null() {
            ptr::copy_nonoverlapping((*s2).ptr, data.add(l1), l2);
        }
        let res = lunite_alloc(16, ptr::null_mut(), ptr::null_mut()) as *mut LuniteString;
        (*res).ptr = data;
        (*res).len = new_len;
        res
    }
}

#[no_mangle]
pub extern "C" fn lunite_sys_exit(c: i64) {
    std::process::exit(c as i32);
}
#[no_mangle]
pub extern "C" fn lunite_realloc(p: *mut u8, os: i64, ns: i64) -> *mut u8 {
    if ns <= 0 {
        lunite_release(p);
        return ptr::null_mut();
    }
    if p.is_null() {
        return lunite_alloc(ns as usize, ptr::null_mut(), ptr::null_mut());
    }

    unsafe {
        let old_size = os as usize;
        let new_size = ns as usize;
        let old_layout = std::alloc::Layout::from_size_align(old_size + 16, 16).unwrap();
        let base_ptr = p.sub(16);
        let new_base_ptr = std::alloc::realloc(base_ptr, old_layout, new_size + 16);

        if new_base_ptr.is_null() {
            return ptr::null_mut();
        }

        *(new_base_ptr as *mut usize) = new_size;
        // Ref count remains the same in the header
        new_base_ptr.add(16)
    }
}
#[no_mangle]
pub extern "C" fn lunite_arena_save() -> i64 {
    0
}
#[no_mangle]
pub extern "C" fn lunite_arena_restore(_: i64) {}
#[no_mangle]
pub extern "C" fn lunite_throw(_: *const i8) {}
#[no_mangle]
pub extern "C" fn lunite_sys_system(_: *const LuniteString) -> i64 {
    0
}
#[no_mangle]
pub extern "C" fn lunite_str_eq(s1: *const LuniteString, s2: *const LuniteString) -> i64 {
    if s1 == s2 {
        return 1;
    }
    if s1.is_null() || s2.is_null() {
        return 0;
    }
    unsafe {
        if (*s1).len != (*s2).len {
            return 0;
        }
        if std::slice::from_raw_parts((*s1).ptr, (*s1).len)
            == std::slice::from_raw_parts((*s2).ptr, (*s2).len)
        {
            1
        } else {
            0
        }
    }
}
#[no_mangle]
pub extern "C" fn lunite_str_substring(
    s: *const LuniteString,
    start: i64,
    end: i64,
) -> *mut LuniteString {
    if s.is_null() {
        return ptr::null_mut();
    }
    unsafe {
        let len = (*s).len as i64;
        if start < 0 || end > len || start > end {
            return ptr::null_mut();
        }
        let new_len = (end - start) as usize;
        let data = lunite_alloc(new_len, ptr::null_mut(), ptr::null_mut());
        ptr::copy_nonoverlapping((*s).ptr.add(start as usize), data, new_len);
        let res = lunite_alloc(16, ptr::null_mut(), ptr::null_mut()) as *mut LuniteString;
        (*res).ptr = data;
        (*res).len = new_len;
        res
    }
}
#[no_mangle]
pub extern "C" fn lunite_math_pow(b: f64, e: f64) -> f64 {
    b.powf(e)
}
#[no_mangle]
pub extern "C" fn lunite_math_abs(n: f64) -> f64 {
    n.abs()
}
#[no_mangle]
pub extern "C" fn lunite_math_ceil(n: f64) -> f64 {
    n.ceil()
}
#[no_mangle]
pub extern "C" fn lunite_math_floor(n: f64) -> f64 {
    n.floor()
}
#[no_mangle]
pub extern "C" fn lunite_net_bind(_port: i64) -> LuniteResult {
    LuniteResult { tag: 1, payload: 0 }
}
#[no_mangle]
pub extern "C" fn lunite_net_accept(_: *mut TcpListener) -> LuniteResult {
    LuniteResult { tag: 1, payload: 0 }
}
#[no_mangle]
pub extern "C" fn lunite_net_read(_: *mut TcpStream) -> LuniteResult {
    LuniteResult { tag: 1, payload: 0 }
}
#[no_mangle]
pub extern "C" fn lunite_net_write(_: *mut TcpStream, _: *const LuniteString) {}
#[no_mangle]
pub extern "C" fn lunite_net_close_socket(_: *mut TcpStream) {}
#[no_mangle]
pub extern "C" fn lunite_net_close_server(_: *mut TcpListener) {}
#[no_mangle]
pub extern "C" fn lunite_channel_create() -> *mut u8 {
    ptr::null_mut()
}
#[no_mangle]
pub extern "C" fn lunite_channel_send(_: *mut u8, _: i64) {}
#[no_mangle]
pub extern "C" fn lunite_channel_recv(_: *mut u8) -> i64 {
    0
}
#[no_mangle]
pub extern "C" fn lunite_spawn(_: extern "C" fn(*mut u8), _: *mut u8) {}
#[no_mangle]
pub extern "C" fn lunite_time_now() -> i64 {
    0
}
#[no_mangle]
pub extern "C" fn lunite_time_sleep(_: i64) {}
#[no_mangle]
pub extern "C" fn lunite_srand(_: i64) {}
#[no_mangle]
pub extern "C" fn lunite_rand_int() -> i64 {
    0
}
#[no_mangle]
pub extern "C" fn lunite_array_copy(src: *mut u8, dst: *mut u8, count: i64, elem_size: i64) {
    if src.is_null() || dst.is_null() || count <= 0 {
        return;
    }
    unsafe {
        ptr::copy_nonoverlapping(src, dst, (count * elem_size) as usize);
    }
}

#[no_mangle]
pub extern "C" fn lunite_int_to_str(n: i64) -> *mut LuniteString {
    let s = n.to_string();
    make_lunite_string(&s)
}

#[no_mangle]
pub extern "C" fn lunite_io_read_file_str(path_ptr: *mut LuniteString) -> *mut LuniteString {
    println!("Called lunite_io_read_file_str");
    if path_ptr.is_null() {
        return make_lunite_string("");
    }
    unsafe {
        let path_str = std::str::from_utf8_unchecked(std::slice::from_raw_parts(
            (*path_ptr).ptr,
            (*path_ptr).len,
        ));
        println!("Path: {}", path_str);
        match std::fs::read_to_string(path_str) {
            Ok(content) => {
                println!("Read content len: {}", content.len());
                make_lunite_string(&content)
            }
            Err(e) => {
                println!("Error: {}", e);
                make_lunite_string("")
            }
        }
    }
}

#[no_mangle]
pub extern "C" fn lunite_from_c_str(s: *const i8) -> *mut LuniteString {
    if s.is_null() {
        return ptr::null_mut();
    }
    unsafe {
        let c_str = std::ffi::CStr::from_ptr(s);
        let str_slice = c_str.to_str().unwrap_or("");
        make_lunite_string(str_slice)
    }
}
