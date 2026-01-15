use std::fs;
use std::net::{TcpListener, TcpStream};
use std::ptr;
use regex::Regex as RustRegex;

#[repr(C)]
pub struct LuniteString {
    pub ptr: *const u8,
    pub len: usize,
}

static mut G_ARGC: i32 = 0;
static mut G_ARGV: *const *const i8 = ptr::null();

#[no_mangle]
pub unsafe extern "C" fn lunite_init_args(argc: i32, argv: *const *const i8) {
    G_ARGC = argc;
    G_ARGV = argv;
}

#[no_mangle]
pub extern "C" fn lunite_sys_get_argc() -> i64 {
    unsafe { G_ARGC as i64 }
}

#[no_mangle]
pub extern "C" fn lunite_sys_get_arg(i: i64) -> *mut LuniteString {
    unsafe {
        if i < 0 || i >= G_ARGC as i64 {
            return make_lunite_string("");
        }
        let ptr = *G_ARGV.add(i as usize);
        if ptr.is_null() {
            return make_lunite_string("");
        }
        let c_str = std::ffi::CStr::from_ptr(ptr);
        make_lunite_string(c_str.to_str().unwrap_or(""))
    }
}

#[no_mangle]
pub extern "C" fn lunite_alloc(size: usize, _p1: *mut u8, _p2: *mut u8) -> *mut u8 {
    println!("[RUNTIME] lunite_alloc({})", size);
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

use std::sync::atomic::{AtomicUsize, Ordering};

#[no_mangle]
pub extern "C" fn lunite_retain(user_ptr: *mut u8) {
    if user_ptr.is_null() {
        return;
    }
    println!("[RUNTIME] lunite_retain({:p})", user_ptr);
    unsafe {
        let rc_ptr = user_ptr.sub(8) as *const AtomicUsize;
        (*rc_ptr).fetch_add(1, Ordering::Relaxed);
    }
}

#[no_mangle]
pub extern "C" fn lunite_release(user_ptr: *mut u8) {
    if user_ptr.is_null() {
        return;
    }
    // println!("[RUNTIME] lunite_release({:p})", user_ptr);
    unsafe {
        let rc_ptr = user_ptr.sub(8) as *const AtomicUsize;
        if (*rc_ptr).fetch_sub(1, Ordering::Release) == 1 {
            std::sync::atomic::fence(Ordering::Acquire);
            let size_ptr = user_ptr.sub(16) as *mut usize;
            let size = *size_ptr;
            // println!("[RUNTIME] lunite_free({:p}, size={})", user_ptr.sub(16), size);
            let layout = std::alloc::Layout::from_size_align(size + 16, 16).unwrap();
            std::alloc::dealloc(user_ptr.sub(16), layout);
        }
    }
}

#[no_mangle]
pub extern "C" fn lunite_dec_ref(user_ptr: *mut u8) -> bool {
    if user_ptr.is_null() {
        return false;
    }
    unsafe {
        let rc_ptr = user_ptr.sub(8) as *const AtomicUsize;
        let old_count = (*rc_ptr).fetch_sub(1, Ordering::Release);
        if old_count == 1 {
            std::sync::atomic::fence(Ordering::Acquire);
            return true;
        }
        false
    }
}

#[no_mangle]
pub extern "C" fn lunite_free_memory(user_ptr: *mut u8) {
    if user_ptr.is_null() {
        return;
    }
    unsafe {
        let size_ptr = user_ptr.sub(16) as *mut usize;
        let size = *size_ptr;
        // println!("[RUNTIME] lunite_free_memory({:p}, size={})", user_ptr.sub(16), size);
        let layout = std::alloc::Layout::from_size_align(size + 16, 16).unwrap();
        std::alloc::dealloc(user_ptr.sub(16), layout);
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
pub extern "C" fn lunite_net_connect(host: *const LuniteString, port: i64) -> LuniteResult {
    unsafe {
        let host_slice = std::slice::from_raw_parts((*host).ptr, (*host).len);
        let host_str = std::str::from_utf8_unchecked(host_slice);
        let addr = format!("{}:{}", host_str, port);
        match TcpStream::connect(addr) {
            Ok(stream) => LuniteResult {
                tag: 0,
                payload: Box::into_raw(Box::new(stream)) as i64,
            },
            Err(_) => LuniteResult { tag: 1, payload: 0 },
        }
    }
}

#[no_mangle]
pub extern "C" fn lunite_net_bind(port: i64) -> LuniteResult {
    match TcpListener::bind(format!("0.0.0.0:{}", port)) {
        Ok(listener) => LuniteResult {
            tag: 0,
            payload: Box::into_raw(Box::new(listener)) as i64,
        },
        Err(_) => LuniteResult { tag: 1, payload: 0 },
    }
}

#[no_mangle]
pub extern "C" fn lunite_net_accept(listener_ptr: *mut TcpListener) -> LuniteResult {
    if listener_ptr.is_null() {
        return LuniteResult { tag: 1, payload: 0 };
    }
    let listener = unsafe { &*listener_ptr };
    match listener.accept() {
        Ok((stream, _)) => LuniteResult {
            tag: 0,
            payload: Box::into_raw(Box::new(stream)) as i64,
        },
        Err(_) => LuniteResult { tag: 1, payload: 0 },
    }
}

#[no_mangle]
pub extern "C" fn lunite_net_read(stream_ptr: *mut TcpStream) -> *mut LuniteString {
    if stream_ptr.is_null() {
        return make_lunite_string("");
    }
    let stream = unsafe { &mut *stream_ptr };
    let mut buffer = [0u8; 4096];
    use std::io::Read;
    match stream.read(&mut buffer) {
        Ok(n) if n > 0 => {
            let s = String::from_utf8_lossy(&buffer[..n]);
            make_lunite_string(&s)
        }
        _ => make_lunite_string(""),
    }
}

#[no_mangle]
pub extern "C" fn lunite_net_write(stream_ptr: *mut TcpStream, s: *const LuniteString) {
    if stream_ptr.is_null() || s.is_null() {
        return;
    }
    let stream = unsafe { &mut *stream_ptr };
    let content = unsafe { std::slice::from_raw_parts((*s).ptr, (*s).len) };
    use std::io::Write;
    let _ = stream.write_all(content);
}

#[no_mangle]
pub extern "C" fn lunite_net_close_socket(stream_ptr: *mut TcpStream) {
    if !stream_ptr.is_null() {
        unsafe {
            drop(Box::from_raw(stream_ptr));
        }
    }
}

#[no_mangle]
pub extern "C" fn lunite_net_close_server(listener_ptr: *mut TcpListener) {
    if !listener_ptr.is_null() {
        unsafe {
            drop(Box::from_raw(listener_ptr));
        }
    }
}
#[no_mangle]
pub extern "C" fn lunite_channel_create() -> *mut u8 {
    let (tx, rx) = std::sync::mpsc::channel::<i64>();
    Box::into_raw(Box::new(LuniteChannel {
        sender: tx,
        receiver: rx,
    })) as *mut u8
}

struct LuniteChannel {
    sender: std::sync::mpsc::Sender<i64>,
    receiver: std::sync::mpsc::Receiver<i64>,
}

#[no_mangle]
pub extern "C" fn lunite_channel_send(chan_ptr: *mut u8, val: i64) {
    if chan_ptr.is_null() {
        return;
    }
    let chan = unsafe { &*(chan_ptr as *const LuniteChannel) };
    let _ = chan.sender.send(val);
}

#[no_mangle]
pub extern "C" fn lunite_channel_recv(chan_ptr: *mut u8) -> i64 {
    if chan_ptr.is_null() {
        return 0;
    }
    let chan = unsafe { &*(chan_ptr as *const LuniteChannel) };
    chan.receiver.recv().unwrap_or(0)
}

#[no_mangle]
pub extern "C" fn lunite_spawn(f: extern "C" fn(*mut u8), arg: *mut u8) {
    let f_addr = f as usize;
    let arg_addr = arg as usize;
    std::thread::spawn(move || unsafe {
        let f_actual = std::mem::transmute::<usize, extern "C" fn(*mut u8)>(f_addr);
        f_actual(arg_addr as *mut u8);
    });
}

#[no_mangle]
pub extern "C" fn lunite_time_now() -> i64 {
    use std::time::{SystemTime, UNIX_EPOCH};
    SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .unwrap_or_default()
        .as_millis() as i64
}

#[no_mangle]
pub extern "C" fn lunite_time_sleep(ms: i64) {
    if ms > 0 {
        std::thread::sleep(std::time::Duration::from_millis(ms as u64));
    }
}

#[no_mangle]
pub extern "C" fn lunite_srand(seed: i64) {
    // Placeholder as Rust's rand is an external crate
}

#[no_mangle]
pub extern "C" fn lunite_rand_int() -> i64 {
    // Simple LCG for now if we don't want deps
    static mut SEED: u64 = 12345;
    unsafe {
        SEED = SEED.wrapping_mul(6364136223846793005).wrapping_add(1);
        (SEED >> 33) as i64
    }
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
pub extern "C" fn lunite_regex_compile(pattern_ptr: *const LuniteString) -> LuniteResult {
    unsafe {
        if pattern_ptr.is_null() || (*pattern_ptr).ptr.is_null() {
            return LuniteResult { tag: 1, payload: 0 };
        }
        let pattern_slice = std::slice::from_raw_parts((*pattern_ptr).ptr, (*pattern_ptr).len);
        let pattern = String::from_utf8_lossy(pattern_slice);
        match RustRegex::new(&pattern) {
            Ok(re) => LuniteResult {
                tag: 0,
                payload: Box::into_raw(Box::new(re)) as i64,
            },
            Err(_) => LuniteResult { tag: 1, payload: 0 },
        }
    }
}

#[no_mangle]
pub extern "C" fn lunite_regex_match(re_ptr: i64, text_ptr: *const LuniteString) -> bool {
    unsafe {
        if re_ptr == 0 || text_ptr.is_null() || (*text_ptr).ptr.is_null() {
            return false;
        }
        let re = &*(re_ptr as *const RustRegex);
        let text_slice = std::slice::from_raw_parts((*text_ptr).ptr, (*text_ptr).len);
        let text_str = std::str::from_utf8_unchecked(text_slice);
        re.is_match(text_str)
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
