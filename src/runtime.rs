use std::alloc::{dealloc, Layout};
use std::collections::{HashSet};
use std::ptr;
use std::sync::{Mutex, Once, mpsc};
use std::sync::atomic::{AtomicUsize, Ordering};
use std::thread;
use std::time::{SystemTime, UNIX_EPOCH, Duration};
use std::fs;
use std::io::{Read, Write};
use std::net::{TcpListener, TcpStream};

// --- Runtime State ---
pub struct RuntimeState {
    pub allocations: HashSet<usize>,
    pub head: *mut ObjHeader,
    pub tail: *mut ObjHeader,
    pub allocation_count: usize,
    pub roots: HashSet<usize>,
    pub allocated_bytes: usize,
    pub threshold: usize,
}

unsafe impl Send for RuntimeState {}

static STATE_INIT: Once = Once::new();
static mut STATE_PTR: *mut Mutex<RuntimeState> = ptr::null_mut();

fn get_state() -> &'static Mutex<RuntimeState> {
    STATE_INIT.call_once(|| {
        let state = Box::new(Mutex::new(RuntimeState {
            allocations: HashSet::new(),
            head: ptr::null_mut(),
            tail: ptr::null_mut(),
            allocation_count: 0,
            roots: HashSet::new(),
            allocated_bytes: 0,
            threshold: 1024 * 1024, 
        }));
        unsafe { STATE_PTR = Box::into_raw(state); }
    });
    unsafe { &*STATE_PTR }
}

#[repr(C)]
pub struct LuniteString {
    pub ptr: *const u8,
    pub len: usize,
}

#[repr(C)]
pub struct ObjHeader {
    pub actual_allocated_size: usize,
    pub size: usize,
    pub ref_count: AtomicUsize,
    pub marked: bool,
    pub prev: *mut ObjHeader,
    pub next: *mut ObjHeader,
}

const HEADER_SIZE: usize = std::mem::size_of::<ObjHeader>();
const PADDING: usize = 1024;

#[repr(C)]
pub struct LuniteResult {
    pub tag: i64,
    pub payload: i64,
}

// --- Memory Management ---

#[no_mangle]
pub extern "C" fn lunite_alloc(size: usize, _p1: *mut u8, _p2: *mut u8) -> *mut u8 {
    {
        let state = get_state().lock().unwrap();
        if state.allocated_bytes > state.threshold {
            drop(state);
            lunite_gc_collect();
        }
    }

    unsafe {
        let req_size = if size < 8 { 8 } else { size };
        let total_size = HEADER_SIZE + req_size + PADDING;
        let layout = Layout::from_size_align(total_size, 16).unwrap();
        let ptr = std::alloc::alloc_zeroed(layout) as *mut ObjHeader;
        if ptr.is_null() { return ptr as *mut u8; }
        
        (*ptr).size = req_size;
        (*ptr).actual_allocated_size = total_size;
        (*ptr).ref_count = AtomicUsize::new(1);
        (*ptr).marked = false;
        
        let user_ptr = (ptr as usize) + HEADER_SIZE;
        let mut state = get_state().lock().unwrap();
        
        (*ptr).prev = state.tail;
        (*ptr).next = ptr::null_mut();
        if !state.tail.is_null() { (*state.tail).next = ptr; } else { state.head = ptr; }
        state.tail = ptr;
        
        state.allocations.insert(user_ptr);
        state.allocation_count += 1;
        state.allocated_bytes += req_size;
        
        user_ptr as *mut u8
    }
}

#[no_mangle]
pub extern "C" fn lunite_retain(user_ptr: *mut u8) {
    if user_ptr.is_null() { return; }
    unsafe {
        let header = (user_ptr as usize - HEADER_SIZE) as *mut ObjHeader;
        (*header).ref_count.fetch_add(1, Ordering::Relaxed);
    }
}

#[no_mangle]
pub extern "C" fn lunite_release(user_ptr: *mut u8) {
    if user_ptr.is_null() { return; }
    unsafe {
        let header_ptr = (user_ptr as usize - HEADER_SIZE) as *mut ObjHeader;
        if (*header_ptr).ref_count.fetch_sub(1, Ordering::Release) == 1 {
            std::sync::atomic::fence(Ordering::Acquire);
            let mut state = get_state().lock().unwrap();
            if state.allocations.remove(&(user_ptr as usize)) {
                let prev = (*header_ptr).prev;
                let next = (*header_ptr).next;
                if !prev.is_null() { (*prev).next = next; } else { state.head = next; }
                if !next.is_null() { (*next).prev = prev; } else { state.tail = prev; }
                
                state.allocation_count -= 1;
                state.allocated_bytes -= (*header_ptr).size;
                let total_size = (*header_ptr).actual_allocated_size;
                dealloc(header_ptr as *mut u8, Layout::from_size_align(total_size, 16).unwrap());
            }
        }
    }
}

#[no_mangle]
pub extern "C" fn lunite_realloc(ptr: *mut u8, _old_size: i64, new_size: i64) -> *mut u8 {
    if new_size <= 0 { lunite_release(ptr); return ptr::null_mut(); }
    if ptr.is_null() { return lunite_alloc(new_size as usize, ptr::null_mut(), ptr::null_mut()); }
    unsafe {
        let new_user_ptr = lunite_alloc(new_size as usize, ptr::null_mut(), ptr::null_mut());
        if new_user_ptr.is_null() { return ptr::null_mut(); }
        let header = (ptr as usize - HEADER_SIZE) as *mut ObjHeader;
        let copy_size = std::cmp::min((*header).size, new_size as usize);
        ptr::copy_nonoverlapping(ptr, new_user_ptr, copy_size);
        lunite_release(ptr);
        new_user_ptr
    }
}

#[no_mangle]
pub extern "C" fn lunite_array_copy(src: *mut u8, dst: *mut u8, count: i64, elem_size: i64) {
    if src.is_null() || dst.is_null() || count <= 0 { return; }
    unsafe { ptr::copy_nonoverlapping(src, dst, (count * elem_size) as usize); }
}

// --- GC Logic ---

unsafe fn mark_object(ptr: usize, state: &mut RuntimeState) {
    if !state.allocations.contains(&ptr) { return; }
    let header = (ptr - HEADER_SIZE) as *mut ObjHeader;
    if (*header).marked { return; }
    (*header).marked = true;
    let size = (*header).size;
    let words = size / std::mem::size_of::<usize>();
    let data_ptr = ptr as *const usize;
    for i in 0..words {
        let potential_ptr = *data_ptr.add(i);
        if state.allocations.contains(&potential_ptr) { mark_object(potential_ptr, state); }
    }
}

#[no_mangle]
pub extern "C" fn lunite_gc_collect() {
    let mut state = get_state().lock().unwrap();
    let roots: Vec<usize> = state.roots.iter().cloned().collect();
    for root in roots { unsafe { mark_object(root, &mut state); } }
    let mut current = state.head;
    let mut to_free = Vec::new();
    while !current.is_null() {
        unsafe {
            let next = (*current).next;
            if (*current).marked { (*current).marked = false; }
            else {
                let prev = (*current).prev;
                if !prev.is_null() { (*prev).next = next; } else { state.head = next; }
                if !next.is_null() { (*next).prev = prev; } else { state.tail = prev; }
                to_free.push(current);
            }
            current = next;
        }
    }
    for header_ptr in to_free {
        unsafe {
            let user_ptr = (header_ptr as usize) + HEADER_SIZE;
            state.allocations.remove(&user_ptr);
            state.allocation_count -= 1;
            let size = (*header_ptr).size;
            let total_size = (*header_ptr).actual_allocated_size;
            state.allocated_bytes -= size;
            dealloc(header_ptr as *mut u8, Layout::from_size_align(total_size, 16).unwrap());
        }
    }
    if state.allocated_bytes > state.threshold / 2 { state.threshold *= 2; }
}

#[no_mangle] pub extern "C" fn lunite_gc_register_root(ptr: *mut u8) { if !ptr.is_null() { get_state().lock().unwrap().roots.insert(ptr as usize); } }
#[no_mangle] pub extern "C" fn lunite_gc_remove_root(ptr: *mut u8) { if !ptr.is_null() { get_state().lock().unwrap().roots.remove(&(ptr as usize)); } }

// --- Helpers ---

pub fn make_lunite_string(s: &str) -> *mut LuniteString {
    unsafe {
        let len = s.len();
        let data = lunite_alloc(len, ptr::null_mut(), ptr::null_mut());
        ptr::copy_nonoverlapping(s.as_ptr(), data, len);
        let res = lunite_alloc(16, ptr::null_mut(), ptr::null_mut()) as *mut LuniteString;
        (*res).ptr = data; (*res).len = len;
        res
    }
}

// --- IO & System ---

#[no_mangle]
pub extern "C" fn print(s: *const LuniteString) {
    if s.is_null() { println!("(null)"); return; }
    unsafe {
        if (*s).ptr.is_null() { println!("(null)"); return; }
        let slice = std::slice::from_raw_parts((*s).ptr, (*s).len);
        println!("{}", String::from_utf8_lossy(slice));
    }
}

#[no_mangle] pub extern "C" fn lunite_print_int(n: i64) { println!("{}", n); }
#[no_mangle] pub extern "C" fn lunite_print_float(n: f64) { println!("{}", n); }

#[no_mangle]
pub extern "C" fn lunite_io_read_file(p: *const LuniteString) -> LuniteResult {
    if p.is_null() { return LuniteResult { tag: 1, payload: 0 }; }
    unsafe {
        let path = String::from_utf8_lossy(std::slice::from_raw_parts((*p).ptr, (*p).len));
        match fs::read_to_string(path.as_ref()) {
            Ok(c) => LuniteResult { tag: 0, payload: make_lunite_string(&c) as i64 },
            Err(_) => LuniteResult { tag: 1, payload: 0 }
        }
    }
}

#[no_mangle]
pub extern "C" fn lunite_sys_system(p: *const LuniteString) -> i64 {
    if p.is_null() { return -1; }
    unsafe {
        let s = String::from_utf8_lossy(std::slice::from_raw_parts((*p).ptr, (*p).len));
        std::process::Command::new("sh").arg("-c").arg(s.as_ref()).status().map(|s| s.code().unwrap_or(0) as i64).unwrap_or(-1)
    }
}

#[no_mangle] pub extern "C" fn lunite_sys_exit(c: i64) { std::process::exit(c as i32); }
#[no_mangle] pub extern "C" fn lunite_math_pow(b: f64, e: f64) -> f64 { b.powf(e) }
#[no_mangle] pub extern "C" fn lunite_math_abs(n: f64) -> f64 { n.abs() }
#[no_mangle] pub extern "C" fn lunite_math_ceil(n: f64) -> f64 { n.ceil() }
#[no_mangle] pub extern "C" fn lunite_math_floor(n: f64) -> f64 { n.floor() }

#[no_mangle]
pub extern "C" fn lunite_str_len_runtime(s: *const LuniteString) -> i64 {
    if s.is_null() { 0 } else { unsafe { (*s).len as i64 } }
}

#[no_mangle]
pub extern "C" fn lunite_str_eq(s1: *const LuniteString, s2: *const LuniteString) -> i64 {
    if s1 == s2 { return 1; }
    if s1.is_null() || s2.is_null() { return 0; }
    unsafe {
        if (*s1).len != (*s2).len { return 0; }
        let sl1 = std::slice::from_raw_parts((*s1).ptr, (*s1).len);
        let sl2 = std::slice::from_raw_parts((*s2).ptr, (*s2).len);
        if sl1 == sl2 { 1 } else { 0 }
    }
}

#[no_mangle]
pub extern "C" fn lunite_str_substring(s: *const LuniteString, start: i64, end: i64) -> *mut LuniteString {
    if s.is_null() { return ptr::null_mut(); }
    unsafe {
        let len = (*s).len as i64;
        if start < 0 || end > len || start > end { return ptr::null_mut(); }
        let new_len = (end - start) as usize;
        let data = lunite_alloc(new_len, ptr::null_mut(), ptr::null_mut());
        ptr::copy_nonoverlapping((*s).ptr.add(start as usize), data, new_len);
        let res = lunite_alloc(16, ptr::null_mut(), ptr::null_mut()) as *mut LuniteString;
        (*res).ptr = data; (*res).len = new_len;
        res
    }
}

#[no_mangle]
pub extern "C" fn lunite_str_concat(s1: *const LuniteString, s2: *const LuniteString) -> *mut LuniteString {
    unsafe {
        let l1 = if s1.is_null() { 0 } else { (*s1).len };
        let l2 = if s2.is_null() { 0 } else { (*s2).len };
        let new_len = l1 + l2;
        let data = lunite_alloc(new_len, ptr::null_mut(), ptr::null_mut());
        if !s1.is_null() { ptr::copy_nonoverlapping((*s1).ptr, data, l1); }
        if !s2.is_null() { ptr::copy_nonoverlapping((*s2).ptr, data.add(l1), l2); }
        let res = lunite_alloc(16, ptr::null_mut(), ptr::null_mut()) as *mut LuniteString;
        (*res).ptr = data; (*res).len = new_len;
        res
    }
}

#[no_mangle] pub extern "C" fn lunite_str_at(s: *const LuniteString, i: i64) -> i64 {
    if s.is_null() || i < 0 || i as usize >= unsafe { (*s).len } { -1 } else { unsafe { *(*s).ptr.add(i as usize) as i64 } }
}

#[no_mangle]
pub extern "C" fn lunite_net_bind(port: i64) -> LuniteResult {
    match TcpListener::bind(format!("0.0.0.0:{}", port)) {
        Ok(l) => LuniteResult { tag: 0, payload: Box::into_raw(Box::new(l)) as i64 },
        Err(_) => LuniteResult { tag: 1, payload: 0 }
    }
}

#[no_mangle]
pub extern "C" fn lunite_net_accept(l: *mut TcpListener) -> LuniteResult {
    unsafe {
        if l.is_null() { return LuniteResult { tag: 1, payload: 0 }; }
        match (*l).accept() {
            Ok((s, _)) => LuniteResult { tag: 0, payload: Box::into_raw(Box::new(s)) as i64 },
            Err(_) => LuniteResult { tag: 1, payload: 0 }
        }
    }
}

#[no_mangle]
pub extern "C" fn lunite_net_read(s: *mut TcpStream) -> LuniteResult {
    unsafe {
        if s.is_null() { return LuniteResult { tag: 1, payload: 0 }; }
        let mut b = [0; 4096];
        match (*s).read(&mut b) {
            Ok(n) if n > 0 => LuniteResult { tag: 0, payload: make_lunite_string(&String::from_utf8_lossy(&b[..n])) as i64 },
            _ => LuniteResult { tag: 1, payload: 0 }
        }
    }
}

#[no_mangle]
pub extern "C" fn lunite_net_write(s: *mut TcpStream, d: *const LuniteString) {
    unsafe {
        if s.is_null() || d.is_null() { return; }
        let _ = (*s).write_all(std::slice::from_raw_parts((*d).ptr, (*d).len));
    }
}

#[no_mangle] pub extern "C" fn lunite_net_close_socket(s: *mut TcpStream) { unsafe { if !s.is_null() { let _ = Box::from_raw(s); } } }
#[no_mangle] pub extern "C" fn lunite_net_close_server(l: *mut TcpListener) { unsafe { if !l.is_null() { let _ = Box::from_raw(l); } } }

pub struct LuniteChannel {
    pub sender: mpsc::Sender<i64>,
    pub receiver: Mutex<mpsc::Receiver<i64>>,
}

#[no_mangle]
pub extern "C" fn lunite_channel_create() -> *mut LuniteChannel {
    let (tx, rx) = mpsc::channel();
    Box::into_raw(Box::new(LuniteChannel { sender: tx, receiver: Mutex::new(rx) }))
}

#[no_mangle]
pub extern "C" fn lunite_channel_send(c: *mut LuniteChannel, v: i64) {
    unsafe { if !c.is_null() { let _ = (*c).sender.send(v); } }
}

#[no_mangle]
pub extern "C" fn lunite_channel_recv(c: *mut LuniteChannel) -> i64 {
    unsafe { if c.is_null() { 0 } else { (*c).receiver.lock().unwrap().recv().unwrap_or(0) } }
}

#[no_mangle]
pub extern "C" fn lunite_spawn(f: extern "C" fn(*mut u8), a: *mut u8) {
    let fp = f as usize; let ap = a as usize;
    thread::spawn(move || { let f: extern "C" fn(*mut u8) = unsafe { std::mem::transmute(fp) }; f(ap as *mut u8); });
}

#[no_mangle] pub extern "C" fn lunite_time_now() -> i64 { SystemTime::now().duration_since(UNIX_EPOCH).unwrap().as_secs() as i64 }
#[no_mangle] pub extern "C" fn lunite_time_sleep(s: i64) { thread::sleep(Duration::from_secs(s as u64)); }

static mut RAND_SEED: u64 = 12345;
#[no_mangle] pub extern "C" fn lunite_srand(s: i64) { unsafe { RAND_SEED = s as u64; } }
#[no_mangle] pub extern "C" fn lunite_rand_int() -> i64 {
    unsafe {
        RAND_SEED = RAND_SEED.wrapping_mul(6364136223846793005).wrapping_add(1442695040888963407);
        (RAND_SEED >> 33) as i64
    }
}

#[no_mangle] pub extern "C" fn lunite_arena_save() -> i64 {
    get_state().lock().unwrap().allocation_count as i64
}

#[no_mangle] pub extern "C" fn lunite_arena_restore(target_count: i64) {
    unsafe {
        let mut to_free = Vec::new();
        {
            let mut state = get_state().lock().unwrap();
            while state.allocation_count > target_count as usize {
                if let Some(ptr) = state.tail.as_mut() {
                    let header_ptr = ptr as *mut ObjHeader;
                    let user_ptr = (header_ptr as usize) + HEADER_SIZE;
                    let prev = (*header_ptr).prev;
                    state.tail = prev;
                    if !prev.is_null() { (*prev).next = ptr::null_mut(); } else { state.head = ptr::null_mut(); }
                    state.allocations.remove(&user_ptr);
                    state.allocation_count -= 1;
                    state.allocated_bytes -= (*header_ptr).size;
                    to_free.push(header_ptr);
                } else { break; }
            }
        }
        for header_ptr in to_free {
            let total_size = (*header_ptr).actual_allocated_size;
            dealloc(header_ptr as *mut u8, Layout::from_size_align(total_size, 16).unwrap());
        }
    }
}

#[no_mangle] pub extern "C" fn lunite_throw(_m: *const i8) {}