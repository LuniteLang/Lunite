[CODEGEN] Default Triple: TargetTriple("x86_64-pc-linux-gnu")
[CODEGEN] Data Layout: DataLayout { address: 0x59aa473d8860, repr: "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128" }
[CODEGEN] Compilation finished successfully.
[CODEGEN] Starting JIT Execution...
; ModuleID = 'lunite'
source_filename = "lunite"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%lexer_Lexer = type { ptr, i64, i64, i64, i64, i64 }
%token_Token = type { ptr, i64, i64 }

@slit = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@slit.1 = private unnamed_addr constant [10 x i8] c"Lexer new\00", align 1
@slit.2 = private unnamed_addr constant [18 x i8] c"Calling read_char\00", align 1
@slit.3 = private unnamed_addr constant [32 x i8] c"Start Minimal with Lexer Import\00", align 1

declare ptr @lunite_alloc(i64 %0, ptr %1, ptr %2)

declare void @lunite_free(ptr %0)

declare void @lunite_retain(ptr %0)

declare void @lunite_release(ptr %0)

declare void @lunite_throw(ptr %0)

declare i64 @lunite_arena_save()

declare void @lunite_arena_restore(i64 %0)

declare void @lunite_init_args(i32 %0, ptr %1)

declare i64 @lunite_sys_get_argc()

declare ptr @lunite_sys_get_arg(i64 %0)

declare void @print(ptr %0)

declare void @lunite_print_int(i64 %0)

declare void @lunite_print_float(double %0)

declare i64 @lunite_str_eq(ptr %0, ptr %1)

declare i64 @lunite_str_len_runtime(ptr %0)

declare ptr @lunite_str_concat(ptr %0, ptr %1)

declare ptr @lunite_str_substring(ptr %0, i64 %1, i64 %2)

declare i64 @lunite_str_at(ptr %0, i64 %1)

declare { i64, i64 } @lunite_io_read_file(ptr %0)

declare i64 @lunite_io_write_file(ptr %0, ptr %1)

declare i64 @lunite_sys_system(ptr %0)

declare void @lunite_sys_exit(i64 %0)

declare double @lunite_math_pow(double %0, double %1)

declare double @lunite_math_abs(double %0)

declare double @lunite_math_ceil(double %0)

declare double @lunite_math_floor(double %0)

declare { i64, i64 } @lunite_net_bind(i64 %0)

declare { i64, i64 } @lunite_net_accept(ptr %0)

declare { i64, i64 } @lunite_net_read(ptr %0)

declare void @lunite_net_write(ptr %0, ptr %1)

declare void @lunite_net_close_socket(ptr %0)

declare void @lunite_net_close_server(ptr %0)

declare ptr @lunite_channel_create()

declare void @lunite_channel_send(ptr %0, i64 %1)

declare i64 @lunite_channel_recv(ptr %0)

declare void @lunite_spawn(ptr %0, ptr %1)

declare i64 @lunite_time_now()

declare void @lunite_time_sleep(i64 %0)

declare void @lunite_srand(i64 %0)

declare i64 @lunite_rand_int()

declare ptr @lunite_realloc(ptr %0, i64 %1, i64 %2)

declare void @lunite_array_copy(ptr %0, ptr %1, i64 %2, i64 %3)

declare i32 @__gxx_personality_v0(...)

declare void @lunite_print(ptr %0) #0

declare ptr @lunite_int_to_str(i64 %0) #0

define ptr @string_concat(ptr %0, ptr %1) #0 {
entry:
  %s2 = alloca ptr, align 8
  %s1 = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %s1, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %s2, align 8
  %s11 = load ptr, ptr %s1, align 8
  call void @lunite_retain(ptr %s11)
  %s22 = load ptr, ptr %s2, align 8
  call void @lunite_retain(ptr %s22)
  %res = call ptr @lunite_str_concat(ptr %s11, ptr %s22)
  call void @lunite_retain(ptr %res)
  %tmp = load ptr, ptr %s2, align 8
  call void @lunite_release(ptr %tmp)
  %tmp3 = load ptr, ptr %s1, align 8
  call void @lunite_release(ptr %tmp3)
  ret ptr %res
}

define ptr @string_int_to_string(i64 %0) #0 {
entry:
  %n = alloca i64, align 8
  br label %body

body:                                             ; preds = %entry
  store i64 %0, ptr %n, align 8
  %n1 = load i64, ptr %n, align 8
  %res = call ptr @lunite_int_to_str(i64 %n1)
  call void @lunite_retain(ptr %res)
  ret ptr %res
}

define i64 @string_char_at(ptr %0, i64 %1) #0 {
entry:
  %idx = alloca i64, align 8
  %s = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %s, align 8
  store i64 %1, ptr %idx, align 8
  %s1 = load ptr, ptr %s, align 8
  call void @lunite_retain(ptr %s1)
  %idx2 = load i64, ptr %idx, align 8
  %res = call i64 @lunite_str_at(ptr %s1, i64 %idx2)
  %tmp = load ptr, ptr %s, align 8
  call void @lunite_release(ptr %tmp)
  ret i64 %res
}

define i64 @string_length(ptr %0) #0 {
entry:
  %s = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %s, align 8
  %s1 = load ptr, ptr %s, align 8
  call void @lunite_retain(ptr %s1)
  %res = call i64 @lunite_str_len_runtime(ptr %s1)
  %tmp = load ptr, ptr %s, align 8
  call void @lunite_release(ptr %tmp)
  ret i64 %res
}

define ptr @string_sub(ptr %0, i64 %1, i64 %2) #0 {
entry:
  %end = alloca i64, align 8
  %start = alloca i64, align 8
  %s = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %s, align 8
  store i64 %1, ptr %start, align 8
  store i64 %2, ptr %end, align 8
  %s1 = load ptr, ptr %s, align 8
  call void @lunite_retain(ptr %s1)
  %start2 = load i64, ptr %start, align 8
  %end3 = load i64, ptr %end, align 8
  %res = call ptr @lunite_str_substring(ptr %s1, i64 %start2, i64 %end3)
  call void @lunite_retain(ptr %res)
  %tmp = load ptr, ptr %s, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %res
}

define void @string_print(ptr %0) #0 {
entry:
  %s = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %s, align 8
  %s1 = load ptr, ptr %s, align 8
  call void @lunite_retain(ptr %s1)
  call void @lunite_print(ptr %s1)
  %tmp = load ptr, ptr %s, align 8
  call void @lunite_release(ptr %tmp)
  ret void
}

define void @string_println(ptr %0) #0 {
entry:
  %s = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %s, align 8
  %s1 = load ptr, ptr %s, align 8
  call void @lunite_retain(ptr %s1)
  call void @print(ptr %s1)
  %sdata = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit, i64 1, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p, align 8
  store i64 1, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  call void @print(ptr %sstruct)
  %tmp = load ptr, ptr %s, align 8
  call void @lunite_release(ptr %tmp)
  ret void
}

define { i64, i64 } @io_read_file(ptr %0) #0 {
entry:
  %path = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %path, align 8
  %path1 = load ptr, ptr %path, align 8
  call void @lunite_retain(ptr %path1)
  %res = call { i64, i64 } @lunite_io_read_file(ptr %path1)
  %tmp = load ptr, ptr %path, align 8
  call void @lunite_release(ptr %tmp)
  ret { i64, i64 } %res
}

define i1 @io_write_file(ptr %0, ptr %1) #0 {
entry:
  %res3 = alloca i64, align 8
  %content = alloca ptr, align 8
  %path = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %path, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %content, align 8
  %path1 = load ptr, ptr %path, align 8
  call void @lunite_retain(ptr %path1)
  %content2 = load ptr, ptr %content, align 8
  call void @lunite_retain(ptr %content2)
  %res = call i64 @lunite_io_write_file(ptr %path1, ptr %content2)
  store i64 %res, ptr %res3, align 8
  %res4 = load i64, ptr %res3, align 8
  %2 = icmp eq i64 %res4, 0
  %tmp = load ptr, ptr %content, align 8
  call void @lunite_release(ptr %tmp)
  %tmp5 = load ptr, ptr %path, align 8
  call void @lunite_release(ptr %tmp5)
  ret i1 %2
}

declare ptr @lunite_io_read_file_str(ptr %0) #0

define ptr @io_read_file_text(ptr %0) #0 {
entry:
  %path = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %path, align 8
  %path1 = load ptr, ptr %path, align 8
  call void @lunite_retain(ptr %path1)
  %res = call ptr @lunite_io_read_file_str(ptr %path1)
  call void @lunite_retain(ptr %res)
  %tmp = load ptr, ptr %path, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %res
}

define i1 @io_write_file_text(ptr %0, ptr %1) #0 {
entry:
  %res3 = alloca i64, align 8
  %content = alloca ptr, align 8
  %path = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %path, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %content, align 8
  %path1 = load ptr, ptr %path, align 8
  call void @lunite_retain(ptr %path1)
  %content2 = load ptr, ptr %content, align 8
  call void @lunite_retain(ptr %content2)
  %res = call i64 @lunite_io_write_file(ptr %path1, ptr %content2)
  store i64 %res, ptr %res3, align 8
  %res4 = load i64, ptr %res3, align 8
  %2 = icmp eq i64 %res4, 0
  %tmp = load ptr, ptr %content, align 8
  call void @lunite_release(ptr %tmp)
  %tmp5 = load ptr, ptr %path, align 8
  call void @lunite_release(ptr %tmp5)
  ret i1 %2
}

define i64 @io_level_to_int(ptr %0) #0 {
entry:
  %l = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %l, align 8
  %l1 = load ptr, ptr %l, align 8
  %tptr = getelementptr inbounds { i64, [1 x i8] }, ptr %l1, i32 0, i32 0
  %tag = load i64, ptr %tptr, align 8
  %match = icmp eq i64 %tag, 0
  br i1 %match, label %when_body, label %when_next

when_end:                                         ; preds = %when_next26
  %tmp29 = load ptr, ptr %l, align 8
  call void @lunite_release(ptr %tmp29)
  ret i64 0

when_next:                                        ; preds = %body
  %tptr4 = getelementptr inbounds { i64, [1 x i8] }, ptr %l1, i32 0, i32 0
  %tag5 = load i64, ptr %tptr4, align 8
  %match6 = icmp eq i64 %tag5, 1
  br i1 %match6, label %when_body3, label %when_next2

when_body:                                        ; preds = %body
  %tmp = load ptr, ptr %l, align 8
  call void @lunite_release(ptr %tmp)
  ret i64 0

when_next2:                                       ; preds = %when_next
  %tptr10 = getelementptr inbounds { i64, [1 x i8] }, ptr %l1, i32 0, i32 0
  %tag11 = load i64, ptr %tptr10, align 8
  %match12 = icmp eq i64 %tag11, 2
  br i1 %match12, label %when_body9, label %when_next8

when_body3:                                       ; preds = %when_next
  %tmp7 = load ptr, ptr %l, align 8
  call void @lunite_release(ptr %tmp7)
  ret i64 1

when_next8:                                       ; preds = %when_next2
  %tptr16 = getelementptr inbounds { i64, [1 x i8] }, ptr %l1, i32 0, i32 0
  %tag17 = load i64, ptr %tptr16, align 8
  %match18 = icmp eq i64 %tag17, 3
  br i1 %match18, label %when_body15, label %when_next14

when_body9:                                       ; preds = %when_next2
  %tmp13 = load ptr, ptr %l, align 8
  call void @lunite_release(ptr %tmp13)
  ret i64 2

when_next14:                                      ; preds = %when_next8
  %tptr22 = getelementptr inbounds { i64, [1 x i8] }, ptr %l1, i32 0, i32 0
  %tag23 = load i64, ptr %tptr22, align 8
  %match24 = icmp eq i64 %tag23, 4
  br i1 %match24, label %when_body21, label %when_next20

when_body15:                                      ; preds = %when_next8
  %tmp19 = load ptr, ptr %l, align 8
  call void @lunite_release(ptr %tmp19)
  ret i64 3

when_next20:                                      ; preds = %when_next14
  br label %when_body27

when_body21:                                      ; preds = %when_next14
  %tmp25 = load ptr, ptr %l, align 8
  call void @lunite_release(ptr %tmp25)
  ret i64 4

when_next26:                                      ; No predecessors!
  br label %when_end

when_body27:                                      ; preds = %when_next20
  %tmp28 = load ptr, ptr %l, align 8
  call void @lunite_release(ptr %tmp28)
  ret i64 5
}

define void @io_log(ptr %0, ptr %1) #0 {
entry:
  %l_int = alloca i64, align 8
  %current_level = alloca i64, align 8
  %msg = alloca ptr, align 8
  %level = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %level, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %msg, align 8
  store i64 3, ptr %current_level, align 8
  %level1 = load ptr, ptr %level, align 8
  call void @lunite_retain(ptr %level1)
  %res = call i64 @io_level_to_int(ptr %level1)
  store i64 %res, ptr %l_int, align 8
  %l_int2 = load i64, ptr %l_int, align 8
  %current_level3 = load i64, ptr %current_level, align 8
  %2 = icmp sle i64 %l_int2, %current_level3
  br i1 %2, label %then, label %else

then:                                             ; preds = %body
  %msg4 = load ptr, ptr %msg, align 8
  call void @lunite_retain(ptr %msg4)
  call void @string_print(ptr %msg4)
  br label %cont

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else, %then
  %tmp = load ptr, ptr %msg, align 8
  call void @lunite_release(ptr %tmp)
  %tmp5 = load ptr, ptr %level, align 8
  call void @lunite_release(ptr %tmp5)
  ret void
}

define ptr @lexer_create(ptr %0) #0 {
entry:
  %input = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %input, align 8
  %input1 = load ptr, ptr %input, align 8
  call void @lunite_retain(ptr %input1)
  %res = call ptr @lexer_Lexer_new(ptr %input1)
  call void @lunite_retain(ptr %res)
  %tmp = load ptr, ptr %input, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %res
}

define ptr @lexer_Lexer_new(ptr %0) #0 {
entry:
  %l7 = alloca ptr, align 8
  %input = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %input, align 8
  %sdata = call ptr @lunite_alloc(i64 9, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.1, i64 9, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p, align 8
  store i64 9, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  call void @string_print(ptr %sstruct)
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%lexer_Lexer, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %lexer_Lexer, ptr %ptr, i32 0, i32 0
  %input1 = load ptr, ptr %input, align 8
  call void @lunite_retain(ptr %input1)
  store ptr %input1, ptr %fp, align 8
  %fp2 = getelementptr inbounds %lexer_Lexer, ptr %ptr, i32 0, i32 1
  store i64 0, ptr %fp2, align 8
  %fp3 = getelementptr inbounds %lexer_Lexer, ptr %ptr, i32 0, i32 2
  store i64 0, ptr %fp3, align 8
  %fp4 = getelementptr inbounds %lexer_Lexer, ptr %ptr, i32 0, i32 3
  store i64 0, ptr %fp4, align 8
  %fp5 = getelementptr inbounds %lexer_Lexer, ptr %ptr, i32 0, i32 4
  store i64 1, ptr %fp5, align 8
  %fp6 = getelementptr inbounds %lexer_Lexer, ptr %ptr, i32 0, i32 5
  store i64 0, ptr %fp6, align 8
  call void @lunite_retain(ptr %ptr)
  store ptr %ptr, ptr %l7, align 8
  %sdata8 = call ptr @lunite_alloc(i64 17, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata8, ptr align 1 @slit.2, i64 17, i1 false)
  %sstruct9 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p10 = getelementptr inbounds { ptr, i64 }, ptr %sstruct9, i32 0, i32 0
  %l11 = getelementptr inbounds { ptr, i64 }, ptr %sstruct9, i32 0, i32 1
  store ptr %sdata8, ptr %p10, align 8
  store i64 17, ptr %l11, align 8
  call void @lunite_retain(ptr %sstruct9)
  call void @string_print(ptr %sstruct9)
  %l12 = load ptr, ptr %l7, align 8
  call void @lunite_retain(ptr %l12)
  call void @lexer_Lexer_read_char(ptr %l12)
  %l13 = load ptr, ptr %l7, align 8
  call void @lunite_retain(ptr %l13)
  %tmp = load ptr, ptr %l7, align 8
  call void @lunite_release(ptr %tmp)
  %tmp14 = load ptr, ptr %input, align 8
  call void @lunite_release(ptr %tmp14)
  ret ptr %l13
}

define void @lexer_Lexer_read_char(ptr %0) #0 {
entry:
  %input_len = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %lexer_Lexer, ptr %self1, i32 0, i32 0
  %input = load ptr, ptr %fp, align 8
  call void @lunite_retain(ptr %input)
  %res = call i64 @string_length(ptr %input)
  store i64 %res, ptr %input_len, align 8
  %self2 = load ptr, ptr %self, align 8
  %fp3 = getelementptr inbounds %lexer_Lexer, ptr %self2, i32 0, i32 2
  %read_pos = load i64, ptr %fp3, align 8
  %input_len4 = load i64, ptr %input_len, align 8
  %1 = icmp sge i64 %read_pos, %input_len4
  br i1 %1, label %then, label %else

then:                                             ; preds = %body
  %self5 = load ptr, ptr %self, align 8
  %fp6 = getelementptr inbounds %lexer_Lexer, ptr %self5, i32 0, i32 3
  store i64 0, ptr %fp6, align 8
  br label %cont

else:                                             ; preds = %body
  %self7 = load ptr, ptr %self, align 8
  %fp8 = getelementptr inbounds %lexer_Lexer, ptr %self7, i32 0, i32 3
  %self9 = load ptr, ptr %self, align 8
  %fp10 = getelementptr inbounds %lexer_Lexer, ptr %self9, i32 0, i32 0
  %input11 = load ptr, ptr %fp10, align 8
  call void @lunite_retain(ptr %input11)
  %self12 = load ptr, ptr %self, align 8
  %fp13 = getelementptr inbounds %lexer_Lexer, ptr %self12, i32 0, i32 2
  %read_pos14 = load i64, ptr %fp13, align 8
  %res15 = call i64 @string_char_at(ptr %input11, i64 %read_pos14)
  store i64 %res15, ptr %fp8, align 8
  br label %cont

cont:                                             ; preds = %else, %then
  %self16 = load ptr, ptr %self, align 8
  %fp17 = getelementptr inbounds %lexer_Lexer, ptr %self16, i32 0, i32 1
  %self18 = load ptr, ptr %self, align 8
  %fp19 = getelementptr inbounds %lexer_Lexer, ptr %self18, i32 0, i32 2
  %read_pos20 = load i64, ptr %fp19, align 8
  store i64 %read_pos20, ptr %fp17, align 8
  %self21 = load ptr, ptr %self, align 8
  %fp22 = getelementptr inbounds %lexer_Lexer, ptr %self21, i32 0, i32 2
  %self23 = load ptr, ptr %self, align 8
  %fp24 = getelementptr inbounds %lexer_Lexer, ptr %self23, i32 0, i32 2
  %read_pos25 = load i64, ptr %fp24, align 8
  %2 = add i64 %read_pos25, 1
  store i64 %2, ptr %fp22, align 8
  %self26 = load ptr, ptr %self, align 8
  %fp27 = getelementptr inbounds %lexer_Lexer, ptr %self26, i32 0, i32 3
  %ch = load i64, ptr %fp27, align 8
  %3 = icmp eq i64 %ch, 10
  br i1 %3, label %then28, label %else29

then28:                                           ; preds = %cont
  %self31 = load ptr, ptr %self, align 8
  %fp32 = getelementptr inbounds %lexer_Lexer, ptr %self31, i32 0, i32 4
  %self33 = load ptr, ptr %self, align 8
  %fp34 = getelementptr inbounds %lexer_Lexer, ptr %self33, i32 0, i32 4
  %line = load i64, ptr %fp34, align 8
  %4 = add i64 %line, 1
  store i64 %4, ptr %fp32, align 8
  %self35 = load ptr, ptr %self, align 8
  %fp36 = getelementptr inbounds %lexer_Lexer, ptr %self35, i32 0, i32 5
  store i64 0, ptr %fp36, align 8
  br label %cont30

else29:                                           ; preds = %cont
  %self37 = load ptr, ptr %self, align 8
  %fp38 = getelementptr inbounds %lexer_Lexer, ptr %self37, i32 0, i32 5
  %self39 = load ptr, ptr %self, align 8
  %fp40 = getelementptr inbounds %lexer_Lexer, ptr %self39, i32 0, i32 5
  %col = load i64, ptr %fp40, align 8
  %5 = add i64 %col, 1
  store i64 %5, ptr %fp38, align 8
  br label %cont30

cont30:                                           ; preds = %else29, %then28
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret void
}

define void @lexer_Lexer_skip_whitespace(ptr %0) #0 {
entry:
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  br label %while_cond

while_cond:                                       ; preds = %while_body, %body
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %lexer_Lexer, ptr %self1, i32 0, i32 3
  %ch = load i64, ptr %fp, align 8
  %1 = icmp eq i64 %ch, 32
  %self2 = load ptr, ptr %self, align 8
  %fp3 = getelementptr inbounds %lexer_Lexer, ptr %self2, i32 0, i32 3
  %ch4 = load i64, ptr %fp3, align 8
  %2 = icmp eq i64 %ch4, 9
  %3 = or i1 %1, %2
  %self5 = load ptr, ptr %self, align 8
  %fp6 = getelementptr inbounds %lexer_Lexer, ptr %self5, i32 0, i32 3
  %ch7 = load i64, ptr %fp6, align 8
  %4 = icmp eq i64 %ch7, 13
  %5 = or i1 %3, %4
  %self8 = load ptr, ptr %self, align 8
  %fp9 = getelementptr inbounds %lexer_Lexer, ptr %self8, i32 0, i32 3
  %ch10 = load i64, ptr %fp9, align 8
  %6 = icmp eq i64 %ch10, 10
  %7 = or i1 %5, %6
  br i1 %7, label %while_body, label %while_end

while_body:                                       ; preds = %while_cond
  %self11 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self11)
  call void @lexer_Lexer_read_char(ptr %self11)
  br label %while_cond

while_end:                                        ; preds = %while_cond
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret void
}

define ptr @lexer_Lexer_lookup_keyword(ptr %0, ptr %1) #0 {
entry:
  %ident = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %ident, align 8
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 2, ptr %t, align 8
  %ident1 = load ptr, ptr %ident, align 8
  call void @lunite_retain(ptr %ident1)
  %p = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 1
  store ptr %ident1, ptr %p, align 8
  call void @lunite_retain(ptr %eptr)
  %tmp = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp)
  %tmp2 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp2)
  ret ptr %eptr
}

define ptr @lexer_Lexer_next_token(ptr %0) #0 {
entry:
  %kind = alloca ptr, align 8
  %c = alloca i64, align 8
  %cur_c = alloca i64, align 8
  %cur_l = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self1)
  call void @lexer_Lexer_skip_whitespace(ptr %self1)
  %self2 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %lexer_Lexer, ptr %self2, i32 0, i32 4
  %line = load i64, ptr %fp, align 8
  store i64 %line, ptr %cur_l, align 8
  %self3 = load ptr, ptr %self, align 8
  %fp4 = getelementptr inbounds %lexer_Lexer, ptr %self3, i32 0, i32 5
  %col = load i64, ptr %fp4, align 8
  store i64 %col, ptr %cur_c, align 8
  %self5 = load ptr, ptr %self, align 8
  %fp6 = getelementptr inbounds %lexer_Lexer, ptr %self5, i32 0, i32 3
  %ch = load i64, ptr %fp6, align 8
  %1 = icmp eq i64 %ch, 0
  br i1 %1, label %then, label %else

then:                                             ; preds = %body
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%token_Token, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp7 = getelementptr inbounds %token_Token, ptr %ptr, i32 0, i32 0
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 1, ptr %t, align 8
  call void @lunite_retain(ptr %eptr)
  store ptr %eptr, ptr %fp7, align 8
  %fp8 = getelementptr inbounds %token_Token, ptr %ptr, i32 0, i32 1
  %cur_l9 = load i64, ptr %cur_l, align 8
  store i64 %cur_l9, ptr %fp8, align 8
  %fp10 = getelementptr inbounds %token_Token, ptr %ptr, i32 0, i32 2
  %cur_c11 = load i64, ptr %cur_c, align 8
  store i64 %cur_c11, ptr %fp10, align 8
  call void @lunite_retain(ptr %ptr)
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %ptr

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else
  %self12 = load ptr, ptr %self, align 8
  %fp13 = getelementptr inbounds %lexer_Lexer, ptr %self12, i32 0, i32 3
  %ch14 = load i64, ptr %fp13, align 8
  store i64 %ch14, ptr %c, align 8
  %self15 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self15)
  call void @lexer_Lexer_read_char(ptr %self15)
  %eptr16 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t17 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr16, i32 0, i32 0
  store i64 0, ptr %t17, align 8
  call void @lunite_retain(ptr %eptr16)
  store ptr %eptr16, ptr %kind, align 8
  %ptr18 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%token_Token, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp19 = getelementptr inbounds %token_Token, ptr %ptr18, i32 0, i32 0
  %kind20 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %kind20)
  store ptr %kind20, ptr %fp19, align 8
  %fp21 = getelementptr inbounds %token_Token, ptr %ptr18, i32 0, i32 1
  %cur_l22 = load i64, ptr %cur_l, align 8
  store i64 %cur_l22, ptr %fp21, align 8
  %fp23 = getelementptr inbounds %token_Token, ptr %ptr18, i32 0, i32 2
  %cur_c24 = load i64, ptr %cur_c, align 8
  store i64 %cur_c24, ptr %fp23, align 8
  call void @lunite_retain(ptr %ptr18)
  %tmp25 = load ptr, ptr %kind, align 8
  call void @lunite_release(ptr %tmp25)
  %tmp26 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp26)
  ret ptr %ptr18
}

define i1 @lexer_Lexer_is_letter_val(ptr %0, i64 %1) #0 {
entry:
  %c = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %c, align 8
  %c1 = load i64, ptr %c, align 8
  %2 = icmp sge i64 %c1, 97
  %c2 = load i64, ptr %c, align 8
  %3 = icmp sle i64 %c2, 122
  %4 = and i1 %2, %3
  %c3 = load i64, ptr %c, align 8
  %5 = icmp sge i64 %c3, 65
  %c4 = load i64, ptr %c, align 8
  %6 = icmp sle i64 %c4, 90
  %7 = and i1 %5, %6
  %8 = or i1 %4, %7
  %c5 = load i64, ptr %c, align 8
  %9 = icmp eq i64 %c5, 95
  %10 = or i1 %8, %9
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret i1 %10
}

define i1 @lexer_Lexer_is_digit_val(ptr %0, i64 %1) #0 {
entry:
  %c = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %c, align 8
  %c1 = load i64, ptr %c, align 8
  %2 = icmp sge i64 %c1, 48
  %c2 = load i64, ptr %c, align 8
  %3 = icmp sle i64 %c2, 57
  %4 = and i1 %2, %3
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret i1 %4
}

define ptr @lexer_Lexer_read_identifier_with_start(ptr %0, i64 %1) #0 {
entry:
  %start_pos = alloca i64, align 8
  %start_ch = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %start_ch, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %lexer_Lexer, ptr %self1, i32 0, i32 1
  %pos = load i64, ptr %fp, align 8
  %2 = sub i64 %pos, 1
  store i64 %2, ptr %start_pos, align 8
  br label %while_cond

while_cond:                                       ; preds = %while_body, %body
  %self2 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self2)
  %self3 = load ptr, ptr %self, align 8
  %fp4 = getelementptr inbounds %lexer_Lexer, ptr %self3, i32 0, i32 3
  %ch = load i64, ptr %fp4, align 8
  %res = call i1 @lexer_Lexer_is_letter_val(ptr %self2, i64 %ch)
  %self5 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self5)
  %self6 = load ptr, ptr %self, align 8
  %fp7 = getelementptr inbounds %lexer_Lexer, ptr %self6, i32 0, i32 3
  %ch8 = load i64, ptr %fp7, align 8
  %res9 = call i1 @lexer_Lexer_is_digit_val(ptr %self5, i64 %ch8)
  %3 = or i1 %res, %res9
  br i1 %3, label %while_body, label %while_end

while_body:                                       ; preds = %while_cond
  %self10 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self10)
  call void @lexer_Lexer_read_char(ptr %self10)
  br label %while_cond

while_end:                                        ; preds = %while_cond
  %self11 = load ptr, ptr %self, align 8
  %fp12 = getelementptr inbounds %lexer_Lexer, ptr %self11, i32 0, i32 0
  %input = load ptr, ptr %fp12, align 8
  call void @lunite_retain(ptr %input)
  %start_pos13 = load i64, ptr %start_pos, align 8
  %self14 = load ptr, ptr %self, align 8
  %fp15 = getelementptr inbounds %lexer_Lexer, ptr %self14, i32 0, i32 1
  %pos16 = load i64, ptr %fp15, align 8
  %res17 = call ptr @string_sub(ptr %input, i64 %start_pos13, i64 %pos16)
  call void @lunite_retain(ptr %res17)
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %res17
}

define ptr @lexer_Lexer_read_number_token_with_start(ptr %0, i64 %1) #0 {
entry:
  %s = alloca ptr, align 8
  %start_pos = alloca i64, align 8
  %start_ch = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %start_ch, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %lexer_Lexer, ptr %self1, i32 0, i32 1
  %pos = load i64, ptr %fp, align 8
  %2 = sub i64 %pos, 1
  store i64 %2, ptr %start_pos, align 8
  br label %while_cond

while_cond:                                       ; preds = %while_body, %body
  %self2 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self2)
  %self3 = load ptr, ptr %self, align 8
  %fp4 = getelementptr inbounds %lexer_Lexer, ptr %self3, i32 0, i32 3
  %ch = load i64, ptr %fp4, align 8
  %res = call i1 @lexer_Lexer_is_digit_val(ptr %self2, i64 %ch)
  br i1 %res, label %while_body, label %while_end

while_body:                                       ; preds = %while_cond
  %self5 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self5)
  call void @lexer_Lexer_read_char(ptr %self5)
  br label %while_cond

while_end:                                        ; preds = %while_cond
  %self6 = load ptr, ptr %self, align 8
  %fp7 = getelementptr inbounds %lexer_Lexer, ptr %self6, i32 0, i32 0
  %input = load ptr, ptr %fp7, align 8
  call void @lunite_retain(ptr %input)
  %start_pos8 = load i64, ptr %start_pos, align 8
  %self9 = load ptr, ptr %self, align 8
  %fp10 = getelementptr inbounds %lexer_Lexer, ptr %self9, i32 0, i32 1
  %pos11 = load i64, ptr %fp10, align 8
  %res12 = call ptr @string_sub(ptr %input, i64 %start_pos8, i64 %pos11)
  call void @lunite_retain(ptr %res12)
  store ptr %res12, ptr %s, align 8
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 3, ptr %t, align 8
  %self13 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self13)
  %s14 = load ptr, ptr %s, align 8
  call void @lunite_retain(ptr %s14)
  %res15 = call i64 @lexer_Lexer_parse_int(ptr %self13, ptr %s14)
  %p = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 1
  store i64 %res15, ptr %p, align 8
  call void @lunite_retain(ptr %eptr)
  %tmp = load ptr, ptr %s, align 8
  call void @lunite_release(ptr %tmp)
  %tmp16 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp16)
  ret ptr %eptr
}

define i64 @lexer_Lexer_parse_int(ptr %0, ptr %1) #0 {
entry:
  %c = alloca i64, align 8
  %res2 = alloca i64, align 8
  %i = alloca i64, align 8
  %len = alloca i64, align 8
  %s = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %s, align 8
  %s1 = load ptr, ptr %s, align 8
  call void @lunite_retain(ptr %s1)
  %res = call i64 @string_length(ptr %s1)
  store i64 %res, ptr %len, align 8
  store i64 0, ptr %i, align 8
  store i64 0, ptr %res2, align 8
  br label %while_cond

while_cond:                                       ; preds = %while_body, %body
  %len3 = load i64, ptr %len, align 8
  %i4 = load i64, ptr %i, align 8
  %2 = icmp sgt i64 %len3, %i4
  br i1 %2, label %while_body, label %while_end

while_body:                                       ; preds = %while_cond
  %s5 = load ptr, ptr %s, align 8
  call void @lunite_retain(ptr %s5)
  %i6 = load i64, ptr %i, align 8
  %res7 = call i64 @string_char_at(ptr %s5, i64 %i6)
  store i64 %res7, ptr %c, align 8
  %res8 = load i64, ptr %res2, align 8
  %3 = mul i64 %res8, 10
  %c9 = load i64, ptr %c, align 8
  %4 = sub i64 %c9, 48
  %5 = add i64 %3, %4
  store i64 %5, ptr %res2, align 8
  %i10 = load i64, ptr %i, align 8
  %6 = add i64 %i10, 1
  store i64 %6, ptr %i, align 8
  br label %while_cond

while_end:                                        ; preds = %while_cond
  %res11 = load i64, ptr %res2, align 8
  %tmp = load ptr, ptr %s, align 8
  call void @lunite_release(ptr %tmp)
  %tmp12 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp12)
  ret i64 %res11
}

define ptr @lexer_Lexer_read_string(ptr %0) #0 {
entry:
  %lit = alloca ptr, align 8
  %start_pos = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %lexer_Lexer, ptr %self1, i32 0, i32 1
  %pos = load i64, ptr %fp, align 8
  store i64 %pos, ptr %start_pos, align 8
  br label %while_cond

while_cond:                                       ; preds = %cont, %body
  %self2 = load ptr, ptr %self, align 8
  %fp3 = getelementptr inbounds %lexer_Lexer, ptr %self2, i32 0, i32 3
  %ch = load i64, ptr %fp3, align 8
  %1 = icmp ne i64 %ch, 34
  %self4 = load ptr, ptr %self, align 8
  %fp5 = getelementptr inbounds %lexer_Lexer, ptr %self4, i32 0, i32 3
  %ch6 = load i64, ptr %fp5, align 8
  %2 = icmp ne i64 %ch6, 0
  %3 = and i1 %1, %2
  br i1 %3, label %while_body, label %while_end

while_body:                                       ; preds = %while_cond
  %self7 = load ptr, ptr %self, align 8
  %fp8 = getelementptr inbounds %lexer_Lexer, ptr %self7, i32 0, i32 3
  %ch9 = load i64, ptr %fp8, align 8
  %4 = icmp eq i64 %ch9, 92
  br i1 %4, label %then, label %else

while_end:                                        ; preds = %while_cond
  %self12 = load ptr, ptr %self, align 8
  %fp13 = getelementptr inbounds %lexer_Lexer, ptr %self12, i32 0, i32 0
  %input = load ptr, ptr %fp13, align 8
  call void @lunite_retain(ptr %input)
  %start_pos14 = load i64, ptr %start_pos, align 8
  %self15 = load ptr, ptr %self, align 8
  %fp16 = getelementptr inbounds %lexer_Lexer, ptr %self15, i32 0, i32 1
  %pos17 = load i64, ptr %fp16, align 8
  %res = call ptr @string_sub(ptr %input, i64 %start_pos14, i64 %pos17)
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %lit, align 8
  %self18 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self18)
  call void @lexer_Lexer_read_char(ptr %self18)
  %lit19 = load ptr, ptr %lit, align 8
  call void @lunite_retain(ptr %lit19)
  %tmp = load ptr, ptr %lit, align 8
  call void @lunite_release(ptr %tmp)
  %tmp20 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp20)
  ret ptr %lit19

then:                                             ; preds = %while_body
  %self10 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self10)
  call void @lexer_Lexer_read_char(ptr %self10)
  br label %cont

else:                                             ; preds = %while_body
  br label %cont

cont:                                             ; preds = %else, %then
  %self11 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self11)
  call void @lexer_Lexer_read_char(ptr %self11)
  br label %while_cond
}

define i64 @main(i32 %0, ptr %1) #0 {
entry:
  br label %body

body:                                             ; preds = %entry
  %sdata = call ptr @lunite_alloc(i64 31, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.3, i64 31, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p, align 8
  store i64 31, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  call void @string_println(ptr %sstruct)
  ret i64 0
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly %0, ptr noalias nocapture readonly %1, i64 %2, i1 immarg %3) #1

attributes #0 = { "frame-pointer"="all" }
attributes #1 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
[CODEGEN] Mapping function: print to 0x59aa33e277c0
[CODEGEN] Mapping function: lunite_print_int to 0x59aa33e26560
[CODEGEN] Mapping function: lunite_print to 0x59aa33e277c0
[CODEGEN] Mapping function: lunite_alloc to 0x59aa33e257d0
[CODEGEN] Mapping function: lunite_retain to 0x59aa33e26890
[CODEGEN] Mapping function: lunite_release to 0x59aa33e265c0
[CODEGEN] Mapping function: lunite_str_eq to 0x59aa33e26eb0
[CODEGEN] Mapping function: lunite_str_len_runtime to 0x59aa33e271f0
[CODEGEN] Mapping function: lunite_str_concat to 0x59aa33e26aa0
[CODEGEN] Mapping function: lunite_str_substring to 0x59aa33e27290
[CODEGEN] Mapping function: lunite_str_at to 0x59aa33e26950
[CODEGEN] Mapping function: lunite_int_to_str to 0x59aa33e25ad0
[CODEGEN] Mapping function: lunite_io_read_file to 0x59aa33e25b70
[CODEGEN] Mapping function: lunite_io_read_file_str to 0x59aa33e25e60
[CODEGEN] Mapping function: lunite_sys_system to 0x59aa33e277b0
[CODEGEN] Mapping function: lunite_sys_exit to 0x59aa33e27570
[CODEGEN] Mapping function: lunite_init_args to 0x59aa33e25a50
[CODEGEN] Mapping function: lunite_sys_get_argc to 0x59aa33e27780
[CODEGEN] Mapping function: lunite_sys_get_arg to 0x59aa33e27590
[CODEGEN] Calling main()...
