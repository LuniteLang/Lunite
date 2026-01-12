[CODEGEN] Default Triple: TargetTriple("x86_64-pc-linux-gnu")
[CODEGEN] Data Layout: DataLayout { address: 0x5cbe864acfd0, repr: "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128" }
[CODEGEN] Compilation finished successfully.
[CODEGEN] Starting JIT Execution...
; ModuleID = 'lunite'
source_filename = "lunite"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%lexer_Lexer = type { ptr, i64, i64, i64, i64, i64 }
%token_Token = type { ptr, i64, i64 }
%parser_Parser = type { ptr, ptr, ptr }
%ast_Program = type { ptr }
%ast_ImportDecl = type { ptr, ptr }
%ast_FunctionDecl = type { ptr, ptr, ptr, ptr, ptr, ptr, i1, ptr }
%ast_CustomTypePayload = type { ptr, ptr }
%ast_Block = type { ptr }
%ast_LetStatementPayload = type { ptr, i1, ptr, ptr }
%ast_IfStatementPayload = type { ptr, ptr, ptr }
%ast_WhileStatementPayload = type { ptr, ptr }
%ast_ForStatementPayload = type { ptr, ptr, ptr, ptr }
%ast_WhenStatementPayload = type { ptr, ptr }
%ast_WhenArm = type { ptr, ptr }
%ast_RegionStatementPayload = type { ptr }
%ast_UnaryExpressionPayload = type { ptr, ptr }
%ast_BinaryExpressionPayload = type { ptr, ptr, ptr }
%ast_CallExpressionPayload = type { ptr, ptr, ptr }
%ast_MemberAccessExpressionPayload = type { ptr, ptr }
%list_List_ast_Item_ = type { ptr, i64, i64 }
%list_List_string = type { ptr, i64, i64 }
%list_List_ast_Param_.0 = type { ptr, i64, i64 }
%list_List_ast_Type_ = type { ptr, i64, i64 }
%list_List_ast_Statement_ = type { ptr, i64, i64 }
%list_List_ast_WhenArm_ = type { ptr, i64, i64 }
%list_List_ast_Expression_ = type { ptr, i64, i64 }

@slit = private unnamed_addr constant [21 x i8] c"Lexer new simplified\00", align 1
@slit.3 = private unnamed_addr constant [3 x i8] c"fn\00", align 1
@slit.4 = private unnamed_addr constant [4 x i8] c"let\00", align 1
@slit.5 = private unnamed_addr constant [7 x i8] c"return\00", align 1
@slit.6 = private unnamed_addr constant [3 x i8] c"if\00", align 1
@slit.7 = private unnamed_addr constant [5 x i8] c"else\00", align 1
@slit.8 = private unnamed_addr constant [6 x i8] c"while\00", align 1
@slit.9 = private unnamed_addr constant [4 x i8] c"for\00", align 1
@slit.10 = private unnamed_addr constant [3 x i8] c"in\00", align 1
@slit.11 = private unnamed_addr constant [7 x i8] c"struct\00", align 1
@slit.12 = private unnamed_addr constant [5 x i8] c"enum\00", align 1
@slit.13 = private unnamed_addr constant [5 x i8] c"impl\00", align 1
@slit.14 = private unnamed_addr constant [4 x i8] c"use\00", align 1
@slit.15 = private unnamed_addr constant [7 x i8] c"import\00", align 1
@slit.16 = private unnamed_addr constant [7 x i8] c"extern\00", align 1
@slit.17 = private unnamed_addr constant [7 x i8] c"native\00", align 1
@slit.18 = private unnamed_addr constant [4 x i8] c"pub\00", align 1
@slit.19 = private unnamed_addr constant [5 x i8] c"pure\00", align 1
@slit.20 = private unnamed_addr constant [4 x i8] c"req\00", align 1
@slit.21 = private unnamed_addr constant [7 x i8] c"layout\00", align 1
@slit.22 = private unnamed_addr constant [4 x i8] c"soa\00", align 1
@slit.23 = private unnamed_addr constant [3 x i8] c"as\00", align 1
@slit.24 = private unnamed_addr constant [4 x i8] c"try\00", align 1
@slit.25 = private unnamed_addr constant [6 x i8] c"catch\00", align 1
@slit.26 = private unnamed_addr constant [6 x i8] c"throw\00", align 1
@slit.27 = private unnamed_addr constant [5 x i8] c"true\00", align 1
@slit.28 = private unnamed_addr constant [6 x i8] c"false\00", align 1
@slit.29 = private unnamed_addr constant [5 x i8] c"null\00", align 1
@slit.30 = private unnamed_addr constant [4 x i8] c"mut\00", align 1
@slit.31 = private unnamed_addr constant [5 x i8] c"when\00", align 1
@slit.32 = private unnamed_addr constant [7 x i8] c"region\00", align 1
@slit.33 = private unnamed_addr constant [9 x i8] c"comptime\00", align 1
@slit.34 = private unnamed_addr constant [6 x i8] c"spawn\00", align 1
@slit.35 = private unnamed_addr constant [7 x i8] c"sizeof\00", align 1
@slit.36 = private unnamed_addr constant [4 x i8] c"int\00", align 1
@slit.37 = private unnamed_addr constant [6 x i8] c"float\00", align 1
@slit.38 = private unnamed_addr constant [5 x i8] c"bool\00", align 1
@slit.39 = private unnamed_addr constant [7 x i8] c"string\00", align 1
@slit.40 = private unnamed_addr constant [5 x i8] c"void\00", align 1
@slit.41 = private unnamed_addr constant [6 x i8] c"error\00", align 1
@slit.42 = private unnamed_addr constant [16 x i8] c"error_semicolon\00", align 1
@slit.43 = private unnamed_addr constant [16 x i8] c"error_semicolon\00", align 1
@slit.44 = private unnamed_addr constant [6 x i8] c"error\00", align 1
@slit.45 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@slit.46 = private unnamed_addr constant [45 x i8] c"Error: Expected identifier for function name\00", align 1
@slit.47 = private unnamed_addr constant [40 x i8] c"Error: Expected '(' after function name\00", align 1
@slit.48 = private unnamed_addr constant [20 x i8] c"Error: Unknown type\00", align 1
@slit.49 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@slit.50 = private unnamed_addr constant [44 x i8] c"Error: Expected identifier in let statement\00", align 1
@slit.51 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@slit.52 = private unnamed_addr constant [42 x i8] c"Error: Expected variable name in for loop\00", align 1
@slit.53 = private unnamed_addr constant [33 x i8] c"Error: Expected 'in' in for loop\00", align 1
@slit.54 = private unnamed_addr constant [31 x i8] c"Error: Expected '(' after when\00", align 1
@slit.55 = private unnamed_addr constant [39 x i8] c"Error: Expected ')' after when subject\00", align 1
@slit.56 = private unnamed_addr constant [31 x i8] c"Error: Expected '{' after when\00", align 1
@slit.57 = private unnamed_addr constant [35 x i8] c"Error: Expected '=>' after pattern\00", align 1
@slit.58 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@slit.59 = private unnamed_addr constant [47 x i8] c"Error: Expected string literal for import path\00", align 1
@slit.60 = private unnamed_addr constant [44 x i8] c"Error: Expected identifier for import alias\00", align 1
@slit.61 = private unnamed_addr constant [20 x i8] c"Error: Expected ')'\00", align 1
@slit.62 = private unnamed_addr constant [27 x i8] c"Error: No prefix for token\00", align 1
@slit.63 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@slit.64 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@slit.65 = private unnamed_addr constant [37 x i8] c"Error: Expected field name after '.'\00", align 1
@slit.66 = private unnamed_addr constant [33 x i8] c"Start Minimal with Parser Import\00", align 1
@slit.67 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1

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

define ptr @lexer_create(ptr %0) {
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

define ptr @lexer_Lexer_new(ptr %0) {
entry:
  %l7 = alloca ptr, align 8
  %input = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %input, align 8
  %sdata = call ptr @lunite_alloc(i64 20, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit, i64 20, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p, align 8
  store i64 20, ptr %l, align 8
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
  %l8 = load ptr, ptr %l7, align 8
  call void @lunite_retain(ptr %l8)
  call void @lexer_Lexer_read_char(ptr %l8)
  %l9 = load ptr, ptr %l7, align 8
  call void @lunite_retain(ptr %l9)
  %tmp = load ptr, ptr %l7, align 8
  call void @lunite_release(ptr %tmp)
  %tmp10 = load ptr, ptr %input, align 8
  call void @lunite_release(ptr %tmp10)
  ret ptr %l9
}

define void @lexer_Lexer_read_char(ptr %0) {
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

define void @lexer_Lexer_skip_whitespace(ptr %0) {
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

define ptr @lexer_Lexer_lookup_keyword(ptr %0, ptr %1) {
entry:
  %ident = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %ident, align 8
  %ident1 = load ptr, ptr %ident, align 8
  %sdata = call ptr @lunite_alloc(i64 2, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.3, i64 2, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p, align 8
  store i64 2, ptr %l, align 8
  %seq = call i64 @lunite_str_eq(ptr %ident1, ptr %sstruct)
  %bool = icmp ne i64 %seq, 0
  br i1 %bool, label %then, label %else

then:                                             ; preds = %body
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 42, ptr %t, align 8
  call void @lunite_retain(ptr %eptr)
  %tmp = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp)
  %tmp2 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp2)
  ret ptr %eptr

else:                                             ; preds = %body
  %ident3 = load ptr, ptr %ident, align 8
  %sdata4 = call ptr @lunite_alloc(i64 3, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata4, ptr align 1 @slit.4, i64 3, i1 false)
  %sstruct5 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p6 = getelementptr inbounds { ptr, i64 }, ptr %sstruct5, i32 0, i32 0
  %l7 = getelementptr inbounds { ptr, i64 }, ptr %sstruct5, i32 0, i32 1
  store ptr %sdata4, ptr %p6, align 8
  store i64 3, ptr %l7, align 8
  %seq8 = call i64 @lunite_str_eq(ptr %ident3, ptr %sstruct5)
  %bool9 = icmp ne i64 %seq8, 0
  br i1 %bool9, label %then10, label %else11

cont:                                             ; preds = %cont12
  %eptr521 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t522 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr521, i32 0, i32 0
  store i64 2, ptr %t522, align 8
  %ident523 = load ptr, ptr %ident, align 8
  call void @lunite_retain(ptr %ident523)
  %p524 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr521, i32 0, i32 1
  store ptr %ident523, ptr %p524, align 8
  call void @lunite_retain(ptr %eptr521)
  %tmp525 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp525)
  %tmp526 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp526)
  ret ptr %eptr521

then10:                                           ; preds = %else
  %eptr13 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t14 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr13, i32 0, i32 0
  store i64 43, ptr %t14, align 8
  call void @lunite_retain(ptr %eptr13)
  %tmp15 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp15)
  %tmp16 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp16)
  ret ptr %eptr13

else11:                                           ; preds = %else
  %ident17 = load ptr, ptr %ident, align 8
  %sdata18 = call ptr @lunite_alloc(i64 6, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata18, ptr align 1 @slit.5, i64 6, i1 false)
  %sstruct19 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p20 = getelementptr inbounds { ptr, i64 }, ptr %sstruct19, i32 0, i32 0
  %l21 = getelementptr inbounds { ptr, i64 }, ptr %sstruct19, i32 0, i32 1
  store ptr %sdata18, ptr %p20, align 8
  store i64 6, ptr %l21, align 8
  %seq22 = call i64 @lunite_str_eq(ptr %ident17, ptr %sstruct19)
  %bool23 = icmp ne i64 %seq22, 0
  br i1 %bool23, label %then24, label %else25

cont12:                                           ; preds = %cont26
  br label %cont

then24:                                           ; preds = %else11
  %eptr27 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t28 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr27, i32 0, i32 0
  store i64 44, ptr %t28, align 8
  call void @lunite_retain(ptr %eptr27)
  %tmp29 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp29)
  %tmp30 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp30)
  ret ptr %eptr27

else25:                                           ; preds = %else11
  %ident31 = load ptr, ptr %ident, align 8
  %sdata32 = call ptr @lunite_alloc(i64 2, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata32, ptr align 1 @slit.6, i64 2, i1 false)
  %sstruct33 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p34 = getelementptr inbounds { ptr, i64 }, ptr %sstruct33, i32 0, i32 0
  %l35 = getelementptr inbounds { ptr, i64 }, ptr %sstruct33, i32 0, i32 1
  store ptr %sdata32, ptr %p34, align 8
  store i64 2, ptr %l35, align 8
  %seq36 = call i64 @lunite_str_eq(ptr %ident31, ptr %sstruct33)
  %bool37 = icmp ne i64 %seq36, 0
  br i1 %bool37, label %then38, label %else39

cont26:                                           ; preds = %cont40
  br label %cont12

then38:                                           ; preds = %else25
  %eptr41 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t42 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr41, i32 0, i32 0
  store i64 45, ptr %t42, align 8
  call void @lunite_retain(ptr %eptr41)
  %tmp43 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp43)
  %tmp44 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp44)
  ret ptr %eptr41

else39:                                           ; preds = %else25
  %ident45 = load ptr, ptr %ident, align 8
  %sdata46 = call ptr @lunite_alloc(i64 4, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata46, ptr align 1 @slit.7, i64 4, i1 false)
  %sstruct47 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p48 = getelementptr inbounds { ptr, i64 }, ptr %sstruct47, i32 0, i32 0
  %l49 = getelementptr inbounds { ptr, i64 }, ptr %sstruct47, i32 0, i32 1
  store ptr %sdata46, ptr %p48, align 8
  store i64 4, ptr %l49, align 8
  %seq50 = call i64 @lunite_str_eq(ptr %ident45, ptr %sstruct47)
  %bool51 = icmp ne i64 %seq50, 0
  br i1 %bool51, label %then52, label %else53

cont40:                                           ; preds = %cont54
  br label %cont26

then52:                                           ; preds = %else39
  %eptr55 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t56 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr55, i32 0, i32 0
  store i64 46, ptr %t56, align 8
  call void @lunite_retain(ptr %eptr55)
  %tmp57 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp57)
  %tmp58 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp58)
  ret ptr %eptr55

else53:                                           ; preds = %else39
  %ident59 = load ptr, ptr %ident, align 8
  %sdata60 = call ptr @lunite_alloc(i64 5, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata60, ptr align 1 @slit.8, i64 5, i1 false)
  %sstruct61 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p62 = getelementptr inbounds { ptr, i64 }, ptr %sstruct61, i32 0, i32 0
  %l63 = getelementptr inbounds { ptr, i64 }, ptr %sstruct61, i32 0, i32 1
  store ptr %sdata60, ptr %p62, align 8
  store i64 5, ptr %l63, align 8
  %seq64 = call i64 @lunite_str_eq(ptr %ident59, ptr %sstruct61)
  %bool65 = icmp ne i64 %seq64, 0
  br i1 %bool65, label %then66, label %else67

cont54:                                           ; preds = %cont68
  br label %cont40

then66:                                           ; preds = %else53
  %eptr69 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t70 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr69, i32 0, i32 0
  store i64 47, ptr %t70, align 8
  call void @lunite_retain(ptr %eptr69)
  %tmp71 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp71)
  %tmp72 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp72)
  ret ptr %eptr69

else67:                                           ; preds = %else53
  %ident73 = load ptr, ptr %ident, align 8
  %sdata74 = call ptr @lunite_alloc(i64 3, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata74, ptr align 1 @slit.9, i64 3, i1 false)
  %sstruct75 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p76 = getelementptr inbounds { ptr, i64 }, ptr %sstruct75, i32 0, i32 0
  %l77 = getelementptr inbounds { ptr, i64 }, ptr %sstruct75, i32 0, i32 1
  store ptr %sdata74, ptr %p76, align 8
  store i64 3, ptr %l77, align 8
  %seq78 = call i64 @lunite_str_eq(ptr %ident73, ptr %sstruct75)
  %bool79 = icmp ne i64 %seq78, 0
  br i1 %bool79, label %then80, label %else81

cont68:                                           ; preds = %cont82
  br label %cont54

then80:                                           ; preds = %else67
  %eptr83 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t84 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr83, i32 0, i32 0
  store i64 48, ptr %t84, align 8
  call void @lunite_retain(ptr %eptr83)
  %tmp85 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp85)
  %tmp86 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp86)
  ret ptr %eptr83

else81:                                           ; preds = %else67
  %ident87 = load ptr, ptr %ident, align 8
  %sdata88 = call ptr @lunite_alloc(i64 2, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata88, ptr align 1 @slit.10, i64 2, i1 false)
  %sstruct89 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p90 = getelementptr inbounds { ptr, i64 }, ptr %sstruct89, i32 0, i32 0
  %l91 = getelementptr inbounds { ptr, i64 }, ptr %sstruct89, i32 0, i32 1
  store ptr %sdata88, ptr %p90, align 8
  store i64 2, ptr %l91, align 8
  %seq92 = call i64 @lunite_str_eq(ptr %ident87, ptr %sstruct89)
  %bool93 = icmp ne i64 %seq92, 0
  br i1 %bool93, label %then94, label %else95

cont82:                                           ; preds = %cont96
  br label %cont68

then94:                                           ; preds = %else81
  %eptr97 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t98 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr97, i32 0, i32 0
  store i64 49, ptr %t98, align 8
  call void @lunite_retain(ptr %eptr97)
  %tmp99 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp99)
  %tmp100 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp100)
  ret ptr %eptr97

else95:                                           ; preds = %else81
  %ident101 = load ptr, ptr %ident, align 8
  %sdata102 = call ptr @lunite_alloc(i64 6, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata102, ptr align 1 @slit.11, i64 6, i1 false)
  %sstruct103 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p104 = getelementptr inbounds { ptr, i64 }, ptr %sstruct103, i32 0, i32 0
  %l105 = getelementptr inbounds { ptr, i64 }, ptr %sstruct103, i32 0, i32 1
  store ptr %sdata102, ptr %p104, align 8
  store i64 6, ptr %l105, align 8
  %seq106 = call i64 @lunite_str_eq(ptr %ident101, ptr %sstruct103)
  %bool107 = icmp ne i64 %seq106, 0
  br i1 %bool107, label %then108, label %else109

cont96:                                           ; preds = %cont110
  br label %cont82

then108:                                          ; preds = %else95
  %eptr111 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t112 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr111, i32 0, i32 0
  store i64 50, ptr %t112, align 8
  call void @lunite_retain(ptr %eptr111)
  %tmp113 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp113)
  %tmp114 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp114)
  ret ptr %eptr111

else109:                                          ; preds = %else95
  %ident115 = load ptr, ptr %ident, align 8
  %sdata116 = call ptr @lunite_alloc(i64 4, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata116, ptr align 1 @slit.12, i64 4, i1 false)
  %sstruct117 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p118 = getelementptr inbounds { ptr, i64 }, ptr %sstruct117, i32 0, i32 0
  %l119 = getelementptr inbounds { ptr, i64 }, ptr %sstruct117, i32 0, i32 1
  store ptr %sdata116, ptr %p118, align 8
  store i64 4, ptr %l119, align 8
  %seq120 = call i64 @lunite_str_eq(ptr %ident115, ptr %sstruct117)
  %bool121 = icmp ne i64 %seq120, 0
  br i1 %bool121, label %then122, label %else123

cont110:                                          ; preds = %cont124
  br label %cont96

then122:                                          ; preds = %else109
  %eptr125 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t126 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr125, i32 0, i32 0
  store i64 51, ptr %t126, align 8
  call void @lunite_retain(ptr %eptr125)
  %tmp127 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp127)
  %tmp128 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp128)
  ret ptr %eptr125

else123:                                          ; preds = %else109
  %ident129 = load ptr, ptr %ident, align 8
  %sdata130 = call ptr @lunite_alloc(i64 4, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata130, ptr align 1 @slit.13, i64 4, i1 false)
  %sstruct131 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p132 = getelementptr inbounds { ptr, i64 }, ptr %sstruct131, i32 0, i32 0
  %l133 = getelementptr inbounds { ptr, i64 }, ptr %sstruct131, i32 0, i32 1
  store ptr %sdata130, ptr %p132, align 8
  store i64 4, ptr %l133, align 8
  %seq134 = call i64 @lunite_str_eq(ptr %ident129, ptr %sstruct131)
  %bool135 = icmp ne i64 %seq134, 0
  br i1 %bool135, label %then136, label %else137

cont124:                                          ; preds = %cont138
  br label %cont110

then136:                                          ; preds = %else123
  %eptr139 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t140 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr139, i32 0, i32 0
  store i64 52, ptr %t140, align 8
  call void @lunite_retain(ptr %eptr139)
  %tmp141 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp141)
  %tmp142 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp142)
  ret ptr %eptr139

else137:                                          ; preds = %else123
  %ident143 = load ptr, ptr %ident, align 8
  %sdata144 = call ptr @lunite_alloc(i64 3, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata144, ptr align 1 @slit.14, i64 3, i1 false)
  %sstruct145 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p146 = getelementptr inbounds { ptr, i64 }, ptr %sstruct145, i32 0, i32 0
  %l147 = getelementptr inbounds { ptr, i64 }, ptr %sstruct145, i32 0, i32 1
  store ptr %sdata144, ptr %p146, align 8
  store i64 3, ptr %l147, align 8
  %seq148 = call i64 @lunite_str_eq(ptr %ident143, ptr %sstruct145)
  %bool149 = icmp ne i64 %seq148, 0
  br i1 %bool149, label %then150, label %else151

cont138:                                          ; preds = %cont152
  br label %cont124

then150:                                          ; preds = %else137
  %eptr153 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t154 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr153, i32 0, i32 0
  store i64 53, ptr %t154, align 8
  call void @lunite_retain(ptr %eptr153)
  %tmp155 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp155)
  %tmp156 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp156)
  ret ptr %eptr153

else151:                                          ; preds = %else137
  %ident157 = load ptr, ptr %ident, align 8
  %sdata158 = call ptr @lunite_alloc(i64 6, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata158, ptr align 1 @slit.15, i64 6, i1 false)
  %sstruct159 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p160 = getelementptr inbounds { ptr, i64 }, ptr %sstruct159, i32 0, i32 0
  %l161 = getelementptr inbounds { ptr, i64 }, ptr %sstruct159, i32 0, i32 1
  store ptr %sdata158, ptr %p160, align 8
  store i64 6, ptr %l161, align 8
  %seq162 = call i64 @lunite_str_eq(ptr %ident157, ptr %sstruct159)
  %bool163 = icmp ne i64 %seq162, 0
  br i1 %bool163, label %then164, label %else165

cont152:                                          ; preds = %cont166
  br label %cont138

then164:                                          ; preds = %else151
  %eptr167 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t168 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr167, i32 0, i32 0
  store i64 54, ptr %t168, align 8
  call void @lunite_retain(ptr %eptr167)
  %tmp169 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp169)
  %tmp170 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp170)
  ret ptr %eptr167

else165:                                          ; preds = %else151
  %ident171 = load ptr, ptr %ident, align 8
  %sdata172 = call ptr @lunite_alloc(i64 6, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata172, ptr align 1 @slit.16, i64 6, i1 false)
  %sstruct173 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p174 = getelementptr inbounds { ptr, i64 }, ptr %sstruct173, i32 0, i32 0
  %l175 = getelementptr inbounds { ptr, i64 }, ptr %sstruct173, i32 0, i32 1
  store ptr %sdata172, ptr %p174, align 8
  store i64 6, ptr %l175, align 8
  %seq176 = call i64 @lunite_str_eq(ptr %ident171, ptr %sstruct173)
  %bool177 = icmp ne i64 %seq176, 0
  br i1 %bool177, label %then178, label %else179

cont166:                                          ; preds = %cont180
  br label %cont152

then178:                                          ; preds = %else165
  %eptr181 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t182 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr181, i32 0, i32 0
  store i64 55, ptr %t182, align 8
  call void @lunite_retain(ptr %eptr181)
  %tmp183 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp183)
  %tmp184 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp184)
  ret ptr %eptr181

else179:                                          ; preds = %else165
  %ident185 = load ptr, ptr %ident, align 8
  %sdata186 = call ptr @lunite_alloc(i64 6, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata186, ptr align 1 @slit.17, i64 6, i1 false)
  %sstruct187 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p188 = getelementptr inbounds { ptr, i64 }, ptr %sstruct187, i32 0, i32 0
  %l189 = getelementptr inbounds { ptr, i64 }, ptr %sstruct187, i32 0, i32 1
  store ptr %sdata186, ptr %p188, align 8
  store i64 6, ptr %l189, align 8
  %seq190 = call i64 @lunite_str_eq(ptr %ident185, ptr %sstruct187)
  %bool191 = icmp ne i64 %seq190, 0
  br i1 %bool191, label %then192, label %else193

cont180:                                          ; preds = %cont194
  br label %cont166

then192:                                          ; preds = %else179
  %eptr195 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t196 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr195, i32 0, i32 0
  store i64 56, ptr %t196, align 8
  call void @lunite_retain(ptr %eptr195)
  %tmp197 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp197)
  %tmp198 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp198)
  ret ptr %eptr195

else193:                                          ; preds = %else179
  %ident199 = load ptr, ptr %ident, align 8
  %sdata200 = call ptr @lunite_alloc(i64 3, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata200, ptr align 1 @slit.18, i64 3, i1 false)
  %sstruct201 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p202 = getelementptr inbounds { ptr, i64 }, ptr %sstruct201, i32 0, i32 0
  %l203 = getelementptr inbounds { ptr, i64 }, ptr %sstruct201, i32 0, i32 1
  store ptr %sdata200, ptr %p202, align 8
  store i64 3, ptr %l203, align 8
  %seq204 = call i64 @lunite_str_eq(ptr %ident199, ptr %sstruct201)
  %bool205 = icmp ne i64 %seq204, 0
  br i1 %bool205, label %then206, label %else207

cont194:                                          ; preds = %cont208
  br label %cont180

then206:                                          ; preds = %else193
  %eptr209 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t210 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr209, i32 0, i32 0
  store i64 57, ptr %t210, align 8
  call void @lunite_retain(ptr %eptr209)
  %tmp211 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp211)
  %tmp212 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp212)
  ret ptr %eptr209

else207:                                          ; preds = %else193
  %ident213 = load ptr, ptr %ident, align 8
  %sdata214 = call ptr @lunite_alloc(i64 4, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata214, ptr align 1 @slit.19, i64 4, i1 false)
  %sstruct215 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p216 = getelementptr inbounds { ptr, i64 }, ptr %sstruct215, i32 0, i32 0
  %l217 = getelementptr inbounds { ptr, i64 }, ptr %sstruct215, i32 0, i32 1
  store ptr %sdata214, ptr %p216, align 8
  store i64 4, ptr %l217, align 8
  %seq218 = call i64 @lunite_str_eq(ptr %ident213, ptr %sstruct215)
  %bool219 = icmp ne i64 %seq218, 0
  br i1 %bool219, label %then220, label %else221

cont208:                                          ; preds = %cont222
  br label %cont194

then220:                                          ; preds = %else207
  %eptr223 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t224 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr223, i32 0, i32 0
  store i64 58, ptr %t224, align 8
  call void @lunite_retain(ptr %eptr223)
  %tmp225 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp225)
  %tmp226 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp226)
  ret ptr %eptr223

else221:                                          ; preds = %else207
  %ident227 = load ptr, ptr %ident, align 8
  %sdata228 = call ptr @lunite_alloc(i64 3, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata228, ptr align 1 @slit.20, i64 3, i1 false)
  %sstruct229 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p230 = getelementptr inbounds { ptr, i64 }, ptr %sstruct229, i32 0, i32 0
  %l231 = getelementptr inbounds { ptr, i64 }, ptr %sstruct229, i32 0, i32 1
  store ptr %sdata228, ptr %p230, align 8
  store i64 3, ptr %l231, align 8
  %seq232 = call i64 @lunite_str_eq(ptr %ident227, ptr %sstruct229)
  %bool233 = icmp ne i64 %seq232, 0
  br i1 %bool233, label %then234, label %else235

cont222:                                          ; preds = %cont236
  br label %cont208

then234:                                          ; preds = %else221
  %eptr237 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t238 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr237, i32 0, i32 0
  store i64 59, ptr %t238, align 8
  call void @lunite_retain(ptr %eptr237)
  %tmp239 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp239)
  %tmp240 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp240)
  ret ptr %eptr237

else235:                                          ; preds = %else221
  %ident241 = load ptr, ptr %ident, align 8
  %sdata242 = call ptr @lunite_alloc(i64 6, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata242, ptr align 1 @slit.21, i64 6, i1 false)
  %sstruct243 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p244 = getelementptr inbounds { ptr, i64 }, ptr %sstruct243, i32 0, i32 0
  %l245 = getelementptr inbounds { ptr, i64 }, ptr %sstruct243, i32 0, i32 1
  store ptr %sdata242, ptr %p244, align 8
  store i64 6, ptr %l245, align 8
  %seq246 = call i64 @lunite_str_eq(ptr %ident241, ptr %sstruct243)
  %bool247 = icmp ne i64 %seq246, 0
  br i1 %bool247, label %then248, label %else249

cont236:                                          ; preds = %cont250
  br label %cont222

then248:                                          ; preds = %else235
  %eptr251 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t252 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr251, i32 0, i32 0
  store i64 60, ptr %t252, align 8
  call void @lunite_retain(ptr %eptr251)
  %tmp253 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp253)
  %tmp254 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp254)
  ret ptr %eptr251

else249:                                          ; preds = %else235
  %ident255 = load ptr, ptr %ident, align 8
  %sdata256 = call ptr @lunite_alloc(i64 3, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata256, ptr align 1 @slit.22, i64 3, i1 false)
  %sstruct257 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p258 = getelementptr inbounds { ptr, i64 }, ptr %sstruct257, i32 0, i32 0
  %l259 = getelementptr inbounds { ptr, i64 }, ptr %sstruct257, i32 0, i32 1
  store ptr %sdata256, ptr %p258, align 8
  store i64 3, ptr %l259, align 8
  %seq260 = call i64 @lunite_str_eq(ptr %ident255, ptr %sstruct257)
  %bool261 = icmp ne i64 %seq260, 0
  br i1 %bool261, label %then262, label %else263

cont250:                                          ; preds = %cont264
  br label %cont236

then262:                                          ; preds = %else249
  %eptr265 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t266 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr265, i32 0, i32 0
  store i64 61, ptr %t266, align 8
  call void @lunite_retain(ptr %eptr265)
  %tmp267 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp267)
  %tmp268 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp268)
  ret ptr %eptr265

else263:                                          ; preds = %else249
  %ident269 = load ptr, ptr %ident, align 8
  %sdata270 = call ptr @lunite_alloc(i64 2, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata270, ptr align 1 @slit.23, i64 2, i1 false)
  %sstruct271 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p272 = getelementptr inbounds { ptr, i64 }, ptr %sstruct271, i32 0, i32 0
  %l273 = getelementptr inbounds { ptr, i64 }, ptr %sstruct271, i32 0, i32 1
  store ptr %sdata270, ptr %p272, align 8
  store i64 2, ptr %l273, align 8
  %seq274 = call i64 @lunite_str_eq(ptr %ident269, ptr %sstruct271)
  %bool275 = icmp ne i64 %seq274, 0
  br i1 %bool275, label %then276, label %else277

cont264:                                          ; preds = %cont278
  br label %cont250

then276:                                          ; preds = %else263
  %eptr279 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t280 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr279, i32 0, i32 0
  store i64 62, ptr %t280, align 8
  call void @lunite_retain(ptr %eptr279)
  %tmp281 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp281)
  %tmp282 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp282)
  ret ptr %eptr279

else277:                                          ; preds = %else263
  %ident283 = load ptr, ptr %ident, align 8
  %sdata284 = call ptr @lunite_alloc(i64 3, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata284, ptr align 1 @slit.24, i64 3, i1 false)
  %sstruct285 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p286 = getelementptr inbounds { ptr, i64 }, ptr %sstruct285, i32 0, i32 0
  %l287 = getelementptr inbounds { ptr, i64 }, ptr %sstruct285, i32 0, i32 1
  store ptr %sdata284, ptr %p286, align 8
  store i64 3, ptr %l287, align 8
  %seq288 = call i64 @lunite_str_eq(ptr %ident283, ptr %sstruct285)
  %bool289 = icmp ne i64 %seq288, 0
  br i1 %bool289, label %then290, label %else291

cont278:                                          ; preds = %cont292
  br label %cont264

then290:                                          ; preds = %else277
  %eptr293 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t294 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr293, i32 0, i32 0
  store i64 63, ptr %t294, align 8
  call void @lunite_retain(ptr %eptr293)
  %tmp295 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp295)
  %tmp296 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp296)
  ret ptr %eptr293

else291:                                          ; preds = %else277
  %ident297 = load ptr, ptr %ident, align 8
  %sdata298 = call ptr @lunite_alloc(i64 5, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata298, ptr align 1 @slit.25, i64 5, i1 false)
  %sstruct299 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p300 = getelementptr inbounds { ptr, i64 }, ptr %sstruct299, i32 0, i32 0
  %l301 = getelementptr inbounds { ptr, i64 }, ptr %sstruct299, i32 0, i32 1
  store ptr %sdata298, ptr %p300, align 8
  store i64 5, ptr %l301, align 8
  %seq302 = call i64 @lunite_str_eq(ptr %ident297, ptr %sstruct299)
  %bool303 = icmp ne i64 %seq302, 0
  br i1 %bool303, label %then304, label %else305

cont292:                                          ; preds = %cont306
  br label %cont278

then304:                                          ; preds = %else291
  %eptr307 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t308 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr307, i32 0, i32 0
  store i64 64, ptr %t308, align 8
  call void @lunite_retain(ptr %eptr307)
  %tmp309 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp309)
  %tmp310 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp310)
  ret ptr %eptr307

else305:                                          ; preds = %else291
  %ident311 = load ptr, ptr %ident, align 8
  %sdata312 = call ptr @lunite_alloc(i64 5, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata312, ptr align 1 @slit.26, i64 5, i1 false)
  %sstruct313 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p314 = getelementptr inbounds { ptr, i64 }, ptr %sstruct313, i32 0, i32 0
  %l315 = getelementptr inbounds { ptr, i64 }, ptr %sstruct313, i32 0, i32 1
  store ptr %sdata312, ptr %p314, align 8
  store i64 5, ptr %l315, align 8
  %seq316 = call i64 @lunite_str_eq(ptr %ident311, ptr %sstruct313)
  %bool317 = icmp ne i64 %seq316, 0
  br i1 %bool317, label %then318, label %else319

cont306:                                          ; preds = %cont320
  br label %cont292

then318:                                          ; preds = %else305
  %eptr321 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t322 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr321, i32 0, i32 0
  store i64 65, ptr %t322, align 8
  call void @lunite_retain(ptr %eptr321)
  %tmp323 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp323)
  %tmp324 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp324)
  ret ptr %eptr321

else319:                                          ; preds = %else305
  %ident325 = load ptr, ptr %ident, align 8
  %sdata326 = call ptr @lunite_alloc(i64 4, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata326, ptr align 1 @slit.27, i64 4, i1 false)
  %sstruct327 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p328 = getelementptr inbounds { ptr, i64 }, ptr %sstruct327, i32 0, i32 0
  %l329 = getelementptr inbounds { ptr, i64 }, ptr %sstruct327, i32 0, i32 1
  store ptr %sdata326, ptr %p328, align 8
  store i64 4, ptr %l329, align 8
  %seq330 = call i64 @lunite_str_eq(ptr %ident325, ptr %sstruct327)
  %bool331 = icmp ne i64 %seq330, 0
  br i1 %bool331, label %then332, label %else333

cont320:                                          ; preds = %cont334
  br label %cont306

then332:                                          ; preds = %else319
  %eptr335 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t336 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr335, i32 0, i32 0
  store i64 66, ptr %t336, align 8
  call void @lunite_retain(ptr %eptr335)
  %tmp337 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp337)
  %tmp338 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp338)
  ret ptr %eptr335

else333:                                          ; preds = %else319
  %ident339 = load ptr, ptr %ident, align 8
  %sdata340 = call ptr @lunite_alloc(i64 5, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata340, ptr align 1 @slit.28, i64 5, i1 false)
  %sstruct341 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p342 = getelementptr inbounds { ptr, i64 }, ptr %sstruct341, i32 0, i32 0
  %l343 = getelementptr inbounds { ptr, i64 }, ptr %sstruct341, i32 0, i32 1
  store ptr %sdata340, ptr %p342, align 8
  store i64 5, ptr %l343, align 8
  %seq344 = call i64 @lunite_str_eq(ptr %ident339, ptr %sstruct341)
  %bool345 = icmp ne i64 %seq344, 0
  br i1 %bool345, label %then346, label %else347

cont334:                                          ; preds = %cont348
  br label %cont320

then346:                                          ; preds = %else333
  %eptr349 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t350 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr349, i32 0, i32 0
  store i64 67, ptr %t350, align 8
  call void @lunite_retain(ptr %eptr349)
  %tmp351 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp351)
  %tmp352 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp352)
  ret ptr %eptr349

else347:                                          ; preds = %else333
  %ident353 = load ptr, ptr %ident, align 8
  %sdata354 = call ptr @lunite_alloc(i64 4, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata354, ptr align 1 @slit.29, i64 4, i1 false)
  %sstruct355 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p356 = getelementptr inbounds { ptr, i64 }, ptr %sstruct355, i32 0, i32 0
  %l357 = getelementptr inbounds { ptr, i64 }, ptr %sstruct355, i32 0, i32 1
  store ptr %sdata354, ptr %p356, align 8
  store i64 4, ptr %l357, align 8
  %seq358 = call i64 @lunite_str_eq(ptr %ident353, ptr %sstruct355)
  %bool359 = icmp ne i64 %seq358, 0
  br i1 %bool359, label %then360, label %else361

cont348:                                          ; preds = %cont362
  br label %cont334

then360:                                          ; preds = %else347
  %eptr363 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t364 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr363, i32 0, i32 0
  store i64 68, ptr %t364, align 8
  call void @lunite_retain(ptr %eptr363)
  %tmp365 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp365)
  %tmp366 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp366)
  ret ptr %eptr363

else361:                                          ; preds = %else347
  %ident367 = load ptr, ptr %ident, align 8
  %sdata368 = call ptr @lunite_alloc(i64 3, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata368, ptr align 1 @slit.30, i64 3, i1 false)
  %sstruct369 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p370 = getelementptr inbounds { ptr, i64 }, ptr %sstruct369, i32 0, i32 0
  %l371 = getelementptr inbounds { ptr, i64 }, ptr %sstruct369, i32 0, i32 1
  store ptr %sdata368, ptr %p370, align 8
  store i64 3, ptr %l371, align 8
  %seq372 = call i64 @lunite_str_eq(ptr %ident367, ptr %sstruct369)
  %bool373 = icmp ne i64 %seq372, 0
  br i1 %bool373, label %then374, label %else375

cont362:                                          ; preds = %cont376
  br label %cont348

then374:                                          ; preds = %else361
  %eptr377 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t378 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr377, i32 0, i32 0
  store i64 69, ptr %t378, align 8
  call void @lunite_retain(ptr %eptr377)
  %tmp379 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp379)
  %tmp380 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp380)
  ret ptr %eptr377

else375:                                          ; preds = %else361
  %ident381 = load ptr, ptr %ident, align 8
  %sdata382 = call ptr @lunite_alloc(i64 4, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata382, ptr align 1 @slit.31, i64 4, i1 false)
  %sstruct383 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p384 = getelementptr inbounds { ptr, i64 }, ptr %sstruct383, i32 0, i32 0
  %l385 = getelementptr inbounds { ptr, i64 }, ptr %sstruct383, i32 0, i32 1
  store ptr %sdata382, ptr %p384, align 8
  store i64 4, ptr %l385, align 8
  %seq386 = call i64 @lunite_str_eq(ptr %ident381, ptr %sstruct383)
  %bool387 = icmp ne i64 %seq386, 0
  br i1 %bool387, label %then388, label %else389

cont376:                                          ; preds = %cont390
  br label %cont362

then388:                                          ; preds = %else375
  %eptr391 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t392 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr391, i32 0, i32 0
  store i64 70, ptr %t392, align 8
  call void @lunite_retain(ptr %eptr391)
  %tmp393 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp393)
  %tmp394 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp394)
  ret ptr %eptr391

else389:                                          ; preds = %else375
  %ident395 = load ptr, ptr %ident, align 8
  %sdata396 = call ptr @lunite_alloc(i64 6, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata396, ptr align 1 @slit.32, i64 6, i1 false)
  %sstruct397 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p398 = getelementptr inbounds { ptr, i64 }, ptr %sstruct397, i32 0, i32 0
  %l399 = getelementptr inbounds { ptr, i64 }, ptr %sstruct397, i32 0, i32 1
  store ptr %sdata396, ptr %p398, align 8
  store i64 6, ptr %l399, align 8
  %seq400 = call i64 @lunite_str_eq(ptr %ident395, ptr %sstruct397)
  %bool401 = icmp ne i64 %seq400, 0
  br i1 %bool401, label %then402, label %else403

cont390:                                          ; preds = %cont404
  br label %cont376

then402:                                          ; preds = %else389
  %eptr405 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t406 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr405, i32 0, i32 0
  store i64 72, ptr %t406, align 8
  call void @lunite_retain(ptr %eptr405)
  %tmp407 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp407)
  %tmp408 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp408)
  ret ptr %eptr405

else403:                                          ; preds = %else389
  %ident409 = load ptr, ptr %ident, align 8
  %sdata410 = call ptr @lunite_alloc(i64 8, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata410, ptr align 1 @slit.33, i64 8, i1 false)
  %sstruct411 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p412 = getelementptr inbounds { ptr, i64 }, ptr %sstruct411, i32 0, i32 0
  %l413 = getelementptr inbounds { ptr, i64 }, ptr %sstruct411, i32 0, i32 1
  store ptr %sdata410, ptr %p412, align 8
  store i64 8, ptr %l413, align 8
  %seq414 = call i64 @lunite_str_eq(ptr %ident409, ptr %sstruct411)
  %bool415 = icmp ne i64 %seq414, 0
  br i1 %bool415, label %then416, label %else417

cont404:                                          ; preds = %cont418
  br label %cont390

then416:                                          ; preds = %else403
  %eptr419 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t420 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr419, i32 0, i32 0
  store i64 73, ptr %t420, align 8
  call void @lunite_retain(ptr %eptr419)
  %tmp421 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp421)
  %tmp422 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp422)
  ret ptr %eptr419

else417:                                          ; preds = %else403
  %ident423 = load ptr, ptr %ident, align 8
  %sdata424 = call ptr @lunite_alloc(i64 5, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata424, ptr align 1 @slit.34, i64 5, i1 false)
  %sstruct425 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p426 = getelementptr inbounds { ptr, i64 }, ptr %sstruct425, i32 0, i32 0
  %l427 = getelementptr inbounds { ptr, i64 }, ptr %sstruct425, i32 0, i32 1
  store ptr %sdata424, ptr %p426, align 8
  store i64 5, ptr %l427, align 8
  %seq428 = call i64 @lunite_str_eq(ptr %ident423, ptr %sstruct425)
  %bool429 = icmp ne i64 %seq428, 0
  br i1 %bool429, label %then430, label %else431

cont418:                                          ; preds = %cont432
  br label %cont404

then430:                                          ; preds = %else417
  %eptr433 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t434 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr433, i32 0, i32 0
  store i64 74, ptr %t434, align 8
  call void @lunite_retain(ptr %eptr433)
  %tmp435 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp435)
  %tmp436 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp436)
  ret ptr %eptr433

else431:                                          ; preds = %else417
  %ident437 = load ptr, ptr %ident, align 8
  %sdata438 = call ptr @lunite_alloc(i64 6, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata438, ptr align 1 @slit.35, i64 6, i1 false)
  %sstruct439 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p440 = getelementptr inbounds { ptr, i64 }, ptr %sstruct439, i32 0, i32 0
  %l441 = getelementptr inbounds { ptr, i64 }, ptr %sstruct439, i32 0, i32 1
  store ptr %sdata438, ptr %p440, align 8
  store i64 6, ptr %l441, align 8
  %seq442 = call i64 @lunite_str_eq(ptr %ident437, ptr %sstruct439)
  %bool443 = icmp ne i64 %seq442, 0
  br i1 %bool443, label %then444, label %else445

cont432:                                          ; preds = %cont446
  br label %cont418

then444:                                          ; preds = %else431
  %eptr447 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t448 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr447, i32 0, i32 0
  store i64 75, ptr %t448, align 8
  call void @lunite_retain(ptr %eptr447)
  %tmp449 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp449)
  %tmp450 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp450)
  ret ptr %eptr447

else445:                                          ; preds = %else431
  %ident451 = load ptr, ptr %ident, align 8
  %sdata452 = call ptr @lunite_alloc(i64 3, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata452, ptr align 1 @slit.36, i64 3, i1 false)
  %sstruct453 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p454 = getelementptr inbounds { ptr, i64 }, ptr %sstruct453, i32 0, i32 0
  %l455 = getelementptr inbounds { ptr, i64 }, ptr %sstruct453, i32 0, i32 1
  store ptr %sdata452, ptr %p454, align 8
  store i64 3, ptr %l455, align 8
  %seq456 = call i64 @lunite_str_eq(ptr %ident451, ptr %sstruct453)
  %bool457 = icmp ne i64 %seq456, 0
  br i1 %bool457, label %then458, label %else459

cont446:                                          ; preds = %cont460
  br label %cont432

then458:                                          ; preds = %else445
  %eptr461 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t462 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr461, i32 0, i32 0
  store i64 76, ptr %t462, align 8
  call void @lunite_retain(ptr %eptr461)
  %tmp463 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp463)
  %tmp464 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp464)
  ret ptr %eptr461

else459:                                          ; preds = %else445
  %ident465 = load ptr, ptr %ident, align 8
  %sdata466 = call ptr @lunite_alloc(i64 5, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata466, ptr align 1 @slit.37, i64 5, i1 false)
  %sstruct467 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p468 = getelementptr inbounds { ptr, i64 }, ptr %sstruct467, i32 0, i32 0
  %l469 = getelementptr inbounds { ptr, i64 }, ptr %sstruct467, i32 0, i32 1
  store ptr %sdata466, ptr %p468, align 8
  store i64 5, ptr %l469, align 8
  %seq470 = call i64 @lunite_str_eq(ptr %ident465, ptr %sstruct467)
  %bool471 = icmp ne i64 %seq470, 0
  br i1 %bool471, label %then472, label %else473

cont460:                                          ; preds = %cont474
  br label %cont446

then472:                                          ; preds = %else459
  %eptr475 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t476 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr475, i32 0, i32 0
  store i64 77, ptr %t476, align 8
  call void @lunite_retain(ptr %eptr475)
  %tmp477 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp477)
  %tmp478 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp478)
  ret ptr %eptr475

else473:                                          ; preds = %else459
  %ident479 = load ptr, ptr %ident, align 8
  %sdata480 = call ptr @lunite_alloc(i64 4, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata480, ptr align 1 @slit.38, i64 4, i1 false)
  %sstruct481 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p482 = getelementptr inbounds { ptr, i64 }, ptr %sstruct481, i32 0, i32 0
  %l483 = getelementptr inbounds { ptr, i64 }, ptr %sstruct481, i32 0, i32 1
  store ptr %sdata480, ptr %p482, align 8
  store i64 4, ptr %l483, align 8
  %seq484 = call i64 @lunite_str_eq(ptr %ident479, ptr %sstruct481)
  %bool485 = icmp ne i64 %seq484, 0
  br i1 %bool485, label %then486, label %else487

cont474:                                          ; preds = %cont488
  br label %cont460

then486:                                          ; preds = %else473
  %eptr489 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t490 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr489, i32 0, i32 0
  store i64 78, ptr %t490, align 8
  call void @lunite_retain(ptr %eptr489)
  %tmp491 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp491)
  %tmp492 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp492)
  ret ptr %eptr489

else487:                                          ; preds = %else473
  %ident493 = load ptr, ptr %ident, align 8
  %sdata494 = call ptr @lunite_alloc(i64 6, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata494, ptr align 1 @slit.39, i64 6, i1 false)
  %sstruct495 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p496 = getelementptr inbounds { ptr, i64 }, ptr %sstruct495, i32 0, i32 0
  %l497 = getelementptr inbounds { ptr, i64 }, ptr %sstruct495, i32 0, i32 1
  store ptr %sdata494, ptr %p496, align 8
  store i64 6, ptr %l497, align 8
  %seq498 = call i64 @lunite_str_eq(ptr %ident493, ptr %sstruct495)
  %bool499 = icmp ne i64 %seq498, 0
  br i1 %bool499, label %then500, label %else501

cont488:                                          ; preds = %cont502
  br label %cont474

then500:                                          ; preds = %else487
  %eptr503 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t504 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr503, i32 0, i32 0
  store i64 79, ptr %t504, align 8
  call void @lunite_retain(ptr %eptr503)
  %tmp505 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp505)
  %tmp506 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp506)
  ret ptr %eptr503

else501:                                          ; preds = %else487
  %ident507 = load ptr, ptr %ident, align 8
  %sdata508 = call ptr @lunite_alloc(i64 4, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata508, ptr align 1 @slit.40, i64 4, i1 false)
  %sstruct509 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p510 = getelementptr inbounds { ptr, i64 }, ptr %sstruct509, i32 0, i32 0
  %l511 = getelementptr inbounds { ptr, i64 }, ptr %sstruct509, i32 0, i32 1
  store ptr %sdata508, ptr %p510, align 8
  store i64 4, ptr %l511, align 8
  %seq512 = call i64 @lunite_str_eq(ptr %ident507, ptr %sstruct509)
  %bool513 = icmp ne i64 %seq512, 0
  br i1 %bool513, label %then514, label %else515

cont502:                                          ; preds = %cont516
  br label %cont488

then514:                                          ; preds = %else501
  %eptr517 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t518 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr517, i32 0, i32 0
  store i64 80, ptr %t518, align 8
  call void @lunite_retain(ptr %eptr517)
  %tmp519 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp519)
  %tmp520 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp520)
  ret ptr %eptr517

else515:                                          ; preds = %else501
  br label %cont516

cont516:                                          ; preds = %else515
  br label %cont502
}

define ptr @lexer_Lexer_next_token(ptr %0) {
entry:
  %ident = alloca ptr, align 8
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
  %c18 = load i64, ptr %c, align 8
  %2 = icmp eq i64 %c18, 43
  br i1 %2, label %then19, label %else20

then19:                                           ; preds = %cont
  %eptr22 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t23 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr22, i32 0, i32 0
  store i64 6, ptr %t23, align 8
  %old = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr22)
  store ptr %eptr22, ptr %kind, align 8
  call void @lunite_release(ptr %old)
  br label %cont21

else20:                                           ; preds = %cont
  %c24 = load i64, ptr %c, align 8
  %3 = icmp eq i64 %c24, 45
  br i1 %3, label %then25, label %else26

cont21:                                           ; preds = %cont27, %then19
  %ptr330 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%token_Token, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp331 = getelementptr inbounds %token_Token, ptr %ptr330, i32 0, i32 0
  %kind332 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %kind332)
  store ptr %kind332, ptr %fp331, align 8
  %fp333 = getelementptr inbounds %token_Token, ptr %ptr330, i32 0, i32 1
  %cur_l334 = load i64, ptr %cur_l, align 8
  store i64 %cur_l334, ptr %fp333, align 8
  %fp335 = getelementptr inbounds %token_Token, ptr %ptr330, i32 0, i32 2
  %cur_c336 = load i64, ptr %cur_c, align 8
  store i64 %cur_c336, ptr %fp335, align 8
  call void @lunite_retain(ptr %ptr330)
  %tmp337 = load ptr, ptr %kind, align 8
  call void @lunite_release(ptr %tmp337)
  %tmp338 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp338)
  ret ptr %ptr330

then25:                                           ; preds = %else20
  %self28 = load ptr, ptr %self, align 8
  %fp29 = getelementptr inbounds %lexer_Lexer, ptr %self28, i32 0, i32 3
  %ch30 = load i64, ptr %fp29, align 8
  %4 = icmp eq i64 %ch30, 62
  br i1 %4, label %then31, label %else32

else26:                                           ; preds = %else20
  %c41 = load i64, ptr %c, align 8
  %5 = icmp eq i64 %c41, 42
  br i1 %5, label %then42, label %else43

cont27:                                           ; preds = %cont44, %cont33
  br label %cont21

then31:                                           ; preds = %then25
  %self34 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self34)
  call void @lexer_Lexer_read_char(ptr %self34)
  %eptr35 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t36 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr35, i32 0, i32 0
  store i64 38, ptr %t36, align 8
  %old37 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr35)
  store ptr %eptr35, ptr %kind, align 8
  call void @lunite_release(ptr %old37)
  br label %cont33

else32:                                           ; preds = %then25
  %eptr38 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t39 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr38, i32 0, i32 0
  store i64 7, ptr %t39, align 8
  %old40 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr38)
  store ptr %eptr38, ptr %kind, align 8
  call void @lunite_release(ptr %old40)
  br label %cont33

cont33:                                           ; preds = %else32, %then31
  br label %cont27

then42:                                           ; preds = %else26
  %eptr45 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t46 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr45, i32 0, i32 0
  store i64 8, ptr %t46, align 8
  %old47 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr45)
  store ptr %eptr45, ptr %kind, align 8
  call void @lunite_release(ptr %old47)
  br label %cont44

else43:                                           ; preds = %else26
  %c48 = load i64, ptr %c, align 8
  %6 = icmp eq i64 %c48, 47
  br i1 %6, label %then49, label %else50

cont44:                                           ; preds = %cont51, %then42
  br label %cont27

then49:                                           ; preds = %else43
  %eptr52 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t53 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr52, i32 0, i32 0
  store i64 9, ptr %t53, align 8
  %old54 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr52)
  store ptr %eptr52, ptr %kind, align 8
  call void @lunite_release(ptr %old54)
  br label %cont51

else50:                                           ; preds = %else43
  %c55 = load i64, ptr %c, align 8
  %7 = icmp eq i64 %c55, 37
  br i1 %7, label %then56, label %else57

cont51:                                           ; preds = %cont58, %then49
  br label %cont44

then56:                                           ; preds = %else50
  %eptr59 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t60 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr59, i32 0, i32 0
  store i64 10, ptr %t60, align 8
  %old61 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr59)
  store ptr %eptr59, ptr %kind, align 8
  call void @lunite_release(ptr %old61)
  br label %cont58

else57:                                           ; preds = %else50
  %c62 = load i64, ptr %c, align 8
  %8 = icmp eq i64 %c62, 61
  br i1 %8, label %then63, label %else64

cont58:                                           ; preds = %cont65, %then56
  br label %cont51

then63:                                           ; preds = %else57
  %self66 = load ptr, ptr %self, align 8
  %fp67 = getelementptr inbounds %lexer_Lexer, ptr %self66, i32 0, i32 3
  %ch68 = load i64, ptr %fp67, align 8
  %9 = icmp eq i64 %ch68, 61
  br i1 %9, label %then69, label %else70

else64:                                           ; preds = %else57
  %c89 = load i64, ptr %c, align 8
  %10 = icmp eq i64 %c89, 33
  br i1 %10, label %then90, label %else91

cont65:                                           ; preds = %cont92, %cont71
  br label %cont58

then69:                                           ; preds = %then63
  %self72 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self72)
  call void @lexer_Lexer_read_char(ptr %self72)
  %eptr73 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t74 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr73, i32 0, i32 0
  store i64 12, ptr %t74, align 8
  %old75 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr73)
  store ptr %eptr73, ptr %kind, align 8
  call void @lunite_release(ptr %old75)
  br label %cont71

else70:                                           ; preds = %then63
  %self76 = load ptr, ptr %self, align 8
  %fp77 = getelementptr inbounds %lexer_Lexer, ptr %self76, i32 0, i32 3
  %ch78 = load i64, ptr %fp77, align 8
  %11 = icmp eq i64 %ch78, 62
  br i1 %11, label %then79, label %else80

cont71:                                           ; preds = %cont81, %then69
  br label %cont65

then79:                                           ; preds = %else70
  %self82 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self82)
  call void @lexer_Lexer_read_char(ptr %self82)
  %eptr83 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t84 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr83, i32 0, i32 0
  store i64 39, ptr %t84, align 8
  %old85 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr83)
  store ptr %eptr83, ptr %kind, align 8
  call void @lunite_release(ptr %old85)
  br label %cont81

else80:                                           ; preds = %else70
  %eptr86 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t87 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr86, i32 0, i32 0
  store i64 11, ptr %t87, align 8
  %old88 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr86)
  store ptr %eptr86, ptr %kind, align 8
  call void @lunite_release(ptr %old88)
  br label %cont81

cont81:                                           ; preds = %else80, %then79
  br label %cont71

then90:                                           ; preds = %else64
  %self93 = load ptr, ptr %self, align 8
  %fp94 = getelementptr inbounds %lexer_Lexer, ptr %self93, i32 0, i32 3
  %ch95 = load i64, ptr %fp94, align 8
  %12 = icmp eq i64 %ch95, 61
  br i1 %12, label %then96, label %else97

else91:                                           ; preds = %else64
  %c106 = load i64, ptr %c, align 8
  %13 = icmp eq i64 %c106, 40
  br i1 %13, label %then107, label %else108

cont92:                                           ; preds = %cont109, %cont98
  br label %cont65

then96:                                           ; preds = %then90
  %self99 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self99)
  call void @lexer_Lexer_read_char(ptr %self99)
  %eptr100 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t101 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr100, i32 0, i32 0
  store i64 14, ptr %t101, align 8
  %old102 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr100)
  store ptr %eptr100, ptr %kind, align 8
  call void @lunite_release(ptr %old102)
  br label %cont98

else97:                                           ; preds = %then90
  %eptr103 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t104 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr103, i32 0, i32 0
  store i64 13, ptr %t104, align 8
  %old105 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr103)
  store ptr %eptr103, ptr %kind, align 8
  call void @lunite_release(ptr %old105)
  br label %cont98

cont98:                                           ; preds = %else97, %then96
  br label %cont92

then107:                                          ; preds = %else91
  %eptr110 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t111 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr110, i32 0, i32 0
  store i64 27, ptr %t111, align 8
  %old112 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr110)
  store ptr %eptr110, ptr %kind, align 8
  call void @lunite_release(ptr %old112)
  br label %cont109

else108:                                          ; preds = %else91
  %c113 = load i64, ptr %c, align 8
  %14 = icmp eq i64 %c113, 41
  br i1 %14, label %then114, label %else115

cont109:                                          ; preds = %cont116, %then107
  br label %cont92

then114:                                          ; preds = %else108
  %eptr117 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t118 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr117, i32 0, i32 0
  store i64 28, ptr %t118, align 8
  %old119 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr117)
  store ptr %eptr117, ptr %kind, align 8
  call void @lunite_release(ptr %old119)
  br label %cont116

else115:                                          ; preds = %else108
  %c120 = load i64, ptr %c, align 8
  %15 = icmp eq i64 %c120, 123
  br i1 %15, label %then121, label %else122

cont116:                                          ; preds = %cont123, %then114
  br label %cont109

then121:                                          ; preds = %else115
  %eptr124 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t125 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr124, i32 0, i32 0
  store i64 29, ptr %t125, align 8
  %old126 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr124)
  store ptr %eptr124, ptr %kind, align 8
  call void @lunite_release(ptr %old126)
  br label %cont123

else122:                                          ; preds = %else115
  %c127 = load i64, ptr %c, align 8
  %16 = icmp eq i64 %c127, 125
  br i1 %16, label %then128, label %else129

cont123:                                          ; preds = %cont130, %then121
  br label %cont116

then128:                                          ; preds = %else122
  %eptr131 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t132 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr131, i32 0, i32 0
  store i64 30, ptr %t132, align 8
  %old133 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr131)
  store ptr %eptr131, ptr %kind, align 8
  call void @lunite_release(ptr %old133)
  br label %cont130

else129:                                          ; preds = %else122
  %c134 = load i64, ptr %c, align 8
  %17 = icmp eq i64 %c134, 91
  br i1 %17, label %then135, label %else136

cont130:                                          ; preds = %cont137, %then128
  br label %cont123

then135:                                          ; preds = %else129
  %eptr138 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t139 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr138, i32 0, i32 0
  store i64 31, ptr %t139, align 8
  %old140 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr138)
  store ptr %eptr138, ptr %kind, align 8
  call void @lunite_release(ptr %old140)
  br label %cont137

else136:                                          ; preds = %else129
  %c141 = load i64, ptr %c, align 8
  %18 = icmp eq i64 %c141, 93
  br i1 %18, label %then142, label %else143

cont137:                                          ; preds = %cont144, %then135
  br label %cont130

then142:                                          ; preds = %else136
  %eptr145 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t146 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr145, i32 0, i32 0
  store i64 32, ptr %t146, align 8
  %old147 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr145)
  store ptr %eptr145, ptr %kind, align 8
  call void @lunite_release(ptr %old147)
  br label %cont144

else143:                                          ; preds = %else136
  %c148 = load i64, ptr %c, align 8
  %19 = icmp eq i64 %c148, 58
  br i1 %19, label %then149, label %else150

cont144:                                          ; preds = %cont151, %then142
  br label %cont137

then149:                                          ; preds = %else143
  %self152 = load ptr, ptr %self, align 8
  %fp153 = getelementptr inbounds %lexer_Lexer, ptr %self152, i32 0, i32 3
  %ch154 = load i64, ptr %fp153, align 8
  %20 = icmp eq i64 %ch154, 58
  br i1 %20, label %then155, label %else156

else150:                                          ; preds = %else143
  %c165 = load i64, ptr %c, align 8
  %21 = icmp eq i64 %c165, 44
  br i1 %21, label %then166, label %else167

cont151:                                          ; preds = %cont168, %cont157
  br label %cont144

then155:                                          ; preds = %then149
  %self158 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self158)
  call void @lexer_Lexer_read_char(ptr %self158)
  %eptr159 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t160 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr159, i32 0, i32 0
  store i64 34, ptr %t160, align 8
  %old161 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr159)
  store ptr %eptr159, ptr %kind, align 8
  call void @lunite_release(ptr %old161)
  br label %cont157

else156:                                          ; preds = %then149
  %eptr162 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t163 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr162, i32 0, i32 0
  store i64 33, ptr %t163, align 8
  %old164 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr162)
  store ptr %eptr162, ptr %kind, align 8
  call void @lunite_release(ptr %old164)
  br label %cont157

cont157:                                          ; preds = %else156, %then155
  br label %cont151

then166:                                          ; preds = %else150
  %eptr169 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t170 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr169, i32 0, i32 0
  store i64 35, ptr %t170, align 8
  %old171 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr169)
  store ptr %eptr169, ptr %kind, align 8
  call void @lunite_release(ptr %old171)
  br label %cont168

else167:                                          ; preds = %else150
  %c172 = load i64, ptr %c, align 8
  %22 = icmp eq i64 %c172, 46
  br i1 %22, label %then173, label %else174

cont168:                                          ; preds = %cont175, %then166
  br label %cont151

then173:                                          ; preds = %else167
  %self176 = load ptr, ptr %self, align 8
  %fp177 = getelementptr inbounds %lexer_Lexer, ptr %self176, i32 0, i32 3
  %ch178 = load i64, ptr %fp177, align 8
  %23 = icmp eq i64 %ch178, 46
  br i1 %23, label %then179, label %else180

else174:                                          ; preds = %else167
  %c189 = load i64, ptr %c, align 8
  %24 = icmp eq i64 %c189, 59
  br i1 %24, label %then190, label %else191

cont175:                                          ; preds = %cont192, %cont181
  br label %cont168

then179:                                          ; preds = %then173
  %self182 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self182)
  call void @lexer_Lexer_read_char(ptr %self182)
  %eptr183 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t184 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr183, i32 0, i32 0
  store i64 37, ptr %t184, align 8
  %old185 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr183)
  store ptr %eptr183, ptr %kind, align 8
  call void @lunite_release(ptr %old185)
  br label %cont181

else180:                                          ; preds = %then173
  %eptr186 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t187 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr186, i32 0, i32 0
  store i64 36, ptr %t187, align 8
  %old188 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr186)
  store ptr %eptr186, ptr %kind, align 8
  call void @lunite_release(ptr %old188)
  br label %cont181

cont181:                                          ; preds = %else180, %then179
  br label %cont175

then190:                                          ; preds = %else174
  %eptr193 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t194 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr193, i32 0, i32 0
  store i64 40, ptr %t194, align 8
  %old195 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr193)
  store ptr %eptr193, ptr %kind, align 8
  call void @lunite_release(ptr %old195)
  br label %cont192

else191:                                          ; preds = %else174
  %c196 = load i64, ptr %c, align 8
  %25 = icmp eq i64 %c196, 38
  br i1 %25, label %then197, label %else198

cont192:                                          ; preds = %cont199, %then190
  br label %cont175

then197:                                          ; preds = %else191
  %self200 = load ptr, ptr %self, align 8
  %fp201 = getelementptr inbounds %lexer_Lexer, ptr %self200, i32 0, i32 3
  %ch202 = load i64, ptr %fp201, align 8
  %26 = icmp eq i64 %ch202, 38
  br i1 %26, label %then203, label %else204

else198:                                          ; preds = %else191
  %c213 = load i64, ptr %c, align 8
  %27 = icmp eq i64 %c213, 124
  br i1 %27, label %then214, label %else215

cont199:                                          ; preds = %cont216, %cont205
  br label %cont192

then203:                                          ; preds = %then197
  %self206 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self206)
  call void @lexer_Lexer_read_char(ptr %self206)
  %eptr207 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t208 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr207, i32 0, i32 0
  store i64 24, ptr %t208, align 8
  %old209 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr207)
  store ptr %eptr207, ptr %kind, align 8
  call void @lunite_release(ptr %old209)
  br label %cont205

else204:                                          ; preds = %then197
  %eptr210 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t211 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr210, i32 0, i32 0
  store i64 19, ptr %t211, align 8
  %old212 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr210)
  store ptr %eptr210, ptr %kind, align 8
  call void @lunite_release(ptr %old212)
  br label %cont205

cont205:                                          ; preds = %else204, %then203
  br label %cont199

then214:                                          ; preds = %else198
  %self217 = load ptr, ptr %self, align 8
  %fp218 = getelementptr inbounds %lexer_Lexer, ptr %self217, i32 0, i32 3
  %ch219 = load i64, ptr %fp218, align 8
  %28 = icmp eq i64 %ch219, 124
  br i1 %28, label %then220, label %else221

else215:                                          ; preds = %else198
  %c230 = load i64, ptr %c, align 8
  %29 = icmp eq i64 %c230, 94
  br i1 %29, label %then231, label %else232

cont216:                                          ; preds = %cont233, %cont222
  br label %cont199

then220:                                          ; preds = %then214
  %self223 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self223)
  call void @lexer_Lexer_read_char(ptr %self223)
  %eptr224 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t225 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr224, i32 0, i32 0
  store i64 25, ptr %t225, align 8
  %old226 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr224)
  store ptr %eptr224, ptr %kind, align 8
  call void @lunite_release(ptr %old226)
  br label %cont222

else221:                                          ; preds = %then214
  %eptr227 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t228 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr227, i32 0, i32 0
  store i64 20, ptr %t228, align 8
  %old229 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr227)
  store ptr %eptr227, ptr %kind, align 8
  call void @lunite_release(ptr %old229)
  br label %cont222

cont222:                                          ; preds = %else221, %then220
  br label %cont216

then231:                                          ; preds = %else215
  %eptr234 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t235 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr234, i32 0, i32 0
  store i64 21, ptr %t235, align 8
  %old236 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr234)
  store ptr %eptr234, ptr %kind, align 8
  call void @lunite_release(ptr %old236)
  br label %cont233

else232:                                          ; preds = %else215
  %c237 = load i64, ptr %c, align 8
  %30 = icmp eq i64 %c237, 63
  br i1 %30, label %then238, label %else239

cont233:                                          ; preds = %cont240, %then231
  br label %cont216

then238:                                          ; preds = %else232
  %eptr241 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t242 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr241, i32 0, i32 0
  store i64 26, ptr %t242, align 8
  %old243 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr241)
  store ptr %eptr241, ptr %kind, align 8
  call void @lunite_release(ptr %old243)
  br label %cont240

else239:                                          ; preds = %else232
  %c244 = load i64, ptr %c, align 8
  %31 = icmp eq i64 %c244, 60
  br i1 %31, label %then245, label %else246

cont240:                                          ; preds = %cont247, %then238
  br label %cont233

then245:                                          ; preds = %else239
  %self248 = load ptr, ptr %self, align 8
  %fp249 = getelementptr inbounds %lexer_Lexer, ptr %self248, i32 0, i32 3
  %ch250 = load i64, ptr %fp249, align 8
  %32 = icmp eq i64 %ch250, 60
  br i1 %32, label %then251, label %else252

else246:                                          ; preds = %else239
  %c271 = load i64, ptr %c, align 8
  %33 = icmp eq i64 %c271, 62
  br i1 %33, label %then272, label %else273

cont247:                                          ; preds = %cont274, %cont253
  br label %cont240

then251:                                          ; preds = %then245
  %self254 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self254)
  call void @lexer_Lexer_read_char(ptr %self254)
  %eptr255 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t256 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr255, i32 0, i32 0
  store i64 22, ptr %t256, align 8
  %old257 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr255)
  store ptr %eptr255, ptr %kind, align 8
  call void @lunite_release(ptr %old257)
  br label %cont253

else252:                                          ; preds = %then245
  %self258 = load ptr, ptr %self, align 8
  %fp259 = getelementptr inbounds %lexer_Lexer, ptr %self258, i32 0, i32 3
  %ch260 = load i64, ptr %fp259, align 8
  %34 = icmp eq i64 %ch260, 61
  br i1 %34, label %then261, label %else262

cont253:                                          ; preds = %cont263, %then251
  br label %cont247

then261:                                          ; preds = %else252
  %self264 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self264)
  call void @lexer_Lexer_read_char(ptr %self264)
  %eptr265 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t266 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr265, i32 0, i32 0
  store i64 16, ptr %t266, align 8
  %old267 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr265)
  store ptr %eptr265, ptr %kind, align 8
  call void @lunite_release(ptr %old267)
  br label %cont263

else262:                                          ; preds = %else252
  %eptr268 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t269 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr268, i32 0, i32 0
  store i64 15, ptr %t269, align 8
  %old270 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr268)
  store ptr %eptr268, ptr %kind, align 8
  call void @lunite_release(ptr %old270)
  br label %cont263

cont263:                                          ; preds = %else262, %then261
  br label %cont253

then272:                                          ; preds = %else246
  %self275 = load ptr, ptr %self, align 8
  %fp276 = getelementptr inbounds %lexer_Lexer, ptr %self275, i32 0, i32 3
  %ch277 = load i64, ptr %fp276, align 8
  %35 = icmp eq i64 %ch277, 62
  br i1 %35, label %then278, label %else279

else273:                                          ; preds = %else246
  %c298 = load i64, ptr %c, align 8
  %36 = icmp eq i64 %c298, 34
  br i1 %36, label %then299, label %else300

cont274:                                          ; preds = %cont301, %cont280
  br label %cont247

then278:                                          ; preds = %then272
  %self281 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self281)
  call void @lexer_Lexer_read_char(ptr %self281)
  %eptr282 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t283 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr282, i32 0, i32 0
  store i64 23, ptr %t283, align 8
  %old284 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr282)
  store ptr %eptr282, ptr %kind, align 8
  call void @lunite_release(ptr %old284)
  br label %cont280

else279:                                          ; preds = %then272
  %self285 = load ptr, ptr %self, align 8
  %fp286 = getelementptr inbounds %lexer_Lexer, ptr %self285, i32 0, i32 3
  %ch287 = load i64, ptr %fp286, align 8
  %37 = icmp eq i64 %ch287, 61
  br i1 %37, label %then288, label %else289

cont280:                                          ; preds = %cont290, %then278
  br label %cont274

then288:                                          ; preds = %else279
  %self291 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self291)
  call void @lexer_Lexer_read_char(ptr %self291)
  %eptr292 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t293 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr292, i32 0, i32 0
  store i64 18, ptr %t293, align 8
  %old294 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr292)
  store ptr %eptr292, ptr %kind, align 8
  call void @lunite_release(ptr %old294)
  br label %cont290

else289:                                          ; preds = %else279
  %eptr295 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t296 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr295, i32 0, i32 0
  store i64 17, ptr %t296, align 8
  %old297 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr295)
  store ptr %eptr295, ptr %kind, align 8
  call void @lunite_release(ptr %old297)
  br label %cont290

cont290:                                          ; preds = %else289, %then288
  br label %cont280

then299:                                          ; preds = %else273
  %eptr302 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t303 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr302, i32 0, i32 0
  store i64 5, ptr %t303, align 8
  %self304 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self304)
  %res = call ptr @lexer_Lexer_read_string(ptr %self304)
  call void @lunite_retain(ptr %res)
  %p = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr302, i32 0, i32 1
  store ptr %res, ptr %p, align 8
  %old305 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %eptr302)
  store ptr %eptr302, ptr %kind, align 8
  call void @lunite_release(ptr %old305)
  br label %cont301

else300:                                          ; preds = %else273
  %self306 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self306)
  %c307 = load i64, ptr %c, align 8
  %res308 = call i1 @lexer_Lexer_is_letter_val(ptr %self306, i64 %c307)
  br i1 %res308, label %then309, label %else310

cont301:                                          ; preds = %cont311, %then299
  br label %cont274

then309:                                          ; preds = %else300
  %self312 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self312)
  %c313 = load i64, ptr %c, align 8
  %res314 = call ptr @lexer_Lexer_read_identifier_with_start(ptr %self312, i64 %c313)
  call void @lunite_retain(ptr %res314)
  store ptr %res314, ptr %ident, align 8
  %self315 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self315)
  %ident316 = load ptr, ptr %ident, align 8
  call void @lunite_retain(ptr %ident316)
  %res317 = call ptr @lexer_Lexer_lookup_keyword(ptr %self315, ptr %ident316)
  %old318 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %res317)
  store ptr %res317, ptr %kind, align 8
  call void @lunite_release(ptr %old318)
  %tmp319 = load ptr, ptr %ident, align 8
  call void @lunite_release(ptr %tmp319)
  br label %cont311

else310:                                          ; preds = %else300
  %self320 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self320)
  %c321 = load i64, ptr %c, align 8
  %res322 = call i1 @lexer_Lexer_is_digit_val(ptr %self320, i64 %c321)
  br i1 %res322, label %then323, label %else324

cont311:                                          ; preds = %cont325, %then309
  br label %cont301

then323:                                          ; preds = %else310
  %self326 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self326)
  %c327 = load i64, ptr %c, align 8
  %res328 = call ptr @lexer_Lexer_read_number_token_with_start(ptr %self326, i64 %c327)
  %old329 = load ptr, ptr %kind, align 8
  call void @lunite_retain(ptr %res328)
  store ptr %res328, ptr %kind, align 8
  call void @lunite_release(ptr %old329)
  br label %cont325

else324:                                          ; preds = %else310
  br label %cont325

cont325:                                          ; preds = %else324, %then323
  br label %cont311
}

define i1 @lexer_Lexer_is_letter_val(ptr %0, i64 %1) {
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

define i1 @lexer_Lexer_is_digit_val(ptr %0, i64 %1) {
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

define ptr @lexer_Lexer_read_identifier_with_start(ptr %0, i64 %1) {
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

define ptr @lexer_Lexer_read_number_token_with_start(ptr %0, i64 %1) {
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

define i64 @lexer_Lexer_parse_int(ptr %0, ptr %1) {
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

define ptr @lexer_Lexer_read_string(ptr %0) {
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

define ptr @parser_precedence_of(ptr %0) {
entry:
  %kind = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %kind, align 8
  %kind1 = load ptr, ptr %kind, align 8
  %tptr = getelementptr inbounds { i64, [8 x i8] }, ptr %kind1, i32 0, i32 0
  %tag = load i64, ptr %tptr, align 8
  %match = icmp eq i64 %tag, 25
  br i1 %match, label %when_body, label %when_next

when_end:                                         ; preds = %when_next178
  %tmp183 = load ptr, ptr %kind, align 8
  call void @lunite_release(ptr %tmp183)
  ret ptr null

when_next:                                        ; preds = %body
  %tptr4 = getelementptr inbounds { i64, [8 x i8] }, ptr %kind1, i32 0, i32 0
  %tag5 = load i64, ptr %tptr4, align 8
  %match6 = icmp eq i64 %tag5, 24
  br i1 %match6, label %when_body3, label %when_next2

when_body:                                        ; preds = %body
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 2, ptr %t, align 8
  call void @lunite_retain(ptr %eptr)
  %tmp = load ptr, ptr %kind, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %eptr

when_next2:                                       ; preds = %when_next
  %tptr12 = getelementptr inbounds { i64, [8 x i8] }, ptr %kind1, i32 0, i32 0
  %tag13 = load i64, ptr %tptr12, align 8
  %match14 = icmp eq i64 %tag13, 12
  br i1 %match14, label %when_body11, label %when_next10

when_body3:                                       ; preds = %when_next
  %eptr7 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t8 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr7, i32 0, i32 0
  store i64 3, ptr %t8, align 8
  call void @lunite_retain(ptr %eptr7)
  %tmp9 = load ptr, ptr %kind, align 8
  call void @lunite_release(ptr %tmp9)
  ret ptr %eptr7

when_next10:                                      ; preds = %when_next2
  %tptr20 = getelementptr inbounds { i64, [8 x i8] }, ptr %kind1, i32 0, i32 0
  %tag21 = load i64, ptr %tptr20, align 8
  %match22 = icmp eq i64 %tag21, 14
  br i1 %match22, label %when_body19, label %when_next18

when_body11:                                      ; preds = %when_next2
  %eptr15 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t16 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr15, i32 0, i32 0
  store i64 4, ptr %t16, align 8
  call void @lunite_retain(ptr %eptr15)
  %tmp17 = load ptr, ptr %kind, align 8
  call void @lunite_release(ptr %tmp17)
  ret ptr %eptr15

when_next18:                                      ; preds = %when_next10
  %tptr28 = getelementptr inbounds { i64, [8 x i8] }, ptr %kind1, i32 0, i32 0
  %tag29 = load i64, ptr %tptr28, align 8
  %match30 = icmp eq i64 %tag29, 15
  br i1 %match30, label %when_body27, label %when_next26

when_body19:                                      ; preds = %when_next10
  %eptr23 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t24 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr23, i32 0, i32 0
  store i64 4, ptr %t24, align 8
  call void @lunite_retain(ptr %eptr23)
  %tmp25 = load ptr, ptr %kind, align 8
  call void @lunite_release(ptr %tmp25)
  ret ptr %eptr23

when_next26:                                      ; preds = %when_next18
  %tptr36 = getelementptr inbounds { i64, [8 x i8] }, ptr %kind1, i32 0, i32 0
  %tag37 = load i64, ptr %tptr36, align 8
  %match38 = icmp eq i64 %tag37, 17
  br i1 %match38, label %when_body35, label %when_next34

when_body27:                                      ; preds = %when_next18
  %eptr31 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t32 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr31, i32 0, i32 0
  store i64 8, ptr %t32, align 8
  call void @lunite_retain(ptr %eptr31)
  %tmp33 = load ptr, ptr %kind, align 8
  call void @lunite_release(ptr %tmp33)
  ret ptr %eptr31

when_next34:                                      ; preds = %when_next26
  %tptr44 = getelementptr inbounds { i64, [8 x i8] }, ptr %kind1, i32 0, i32 0
  %tag45 = load i64, ptr %tptr44, align 8
  %match46 = icmp eq i64 %tag45, 16
  br i1 %match46, label %when_body43, label %when_next42

when_body35:                                      ; preds = %when_next26
  %eptr39 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t40 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr39, i32 0, i32 0
  store i64 8, ptr %t40, align 8
  call void @lunite_retain(ptr %eptr39)
  %tmp41 = load ptr, ptr %kind, align 8
  call void @lunite_release(ptr %tmp41)
  ret ptr %eptr39

when_next42:                                      ; preds = %when_next34
  %tptr52 = getelementptr inbounds { i64, [8 x i8] }, ptr %kind1, i32 0, i32 0
  %tag53 = load i64, ptr %tptr52, align 8
  %match54 = icmp eq i64 %tag53, 18
  br i1 %match54, label %when_body51, label %when_next50

when_body43:                                      ; preds = %when_next34
  %eptr47 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t48 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr47, i32 0, i32 0
  store i64 8, ptr %t48, align 8
  call void @lunite_retain(ptr %eptr47)
  %tmp49 = load ptr, ptr %kind, align 8
  call void @lunite_release(ptr %tmp49)
  ret ptr %eptr47

when_next50:                                      ; preds = %when_next42
  %tptr60 = getelementptr inbounds { i64, [8 x i8] }, ptr %kind1, i32 0, i32 0
  %tag61 = load i64, ptr %tptr60, align 8
  %match62 = icmp eq i64 %tag61, 6
  br i1 %match62, label %when_body59, label %when_next58

when_body51:                                      ; preds = %when_next42
  %eptr55 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t56 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr55, i32 0, i32 0
  store i64 8, ptr %t56, align 8
  call void @lunite_retain(ptr %eptr55)
  %tmp57 = load ptr, ptr %kind, align 8
  call void @lunite_release(ptr %tmp57)
  ret ptr %eptr55

when_next58:                                      ; preds = %when_next50
  %tptr68 = getelementptr inbounds { i64, [8 x i8] }, ptr %kind1, i32 0, i32 0
  %tag69 = load i64, ptr %tptr68, align 8
  %match70 = icmp eq i64 %tag69, 7
  br i1 %match70, label %when_body67, label %when_next66

when_body59:                                      ; preds = %when_next50
  %eptr63 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t64 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr63, i32 0, i32 0
  store i64 10, ptr %t64, align 8
  call void @lunite_retain(ptr %eptr63)
  %tmp65 = load ptr, ptr %kind, align 8
  call void @lunite_release(ptr %tmp65)
  ret ptr %eptr63

when_next66:                                      ; preds = %when_next58
  %tptr76 = getelementptr inbounds { i64, [8 x i8] }, ptr %kind1, i32 0, i32 0
  %tag77 = load i64, ptr %tptr76, align 8
  %match78 = icmp eq i64 %tag77, 8
  br i1 %match78, label %when_body75, label %when_next74

when_body67:                                      ; preds = %when_next58
  %eptr71 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t72 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr71, i32 0, i32 0
  store i64 10, ptr %t72, align 8
  call void @lunite_retain(ptr %eptr71)
  %tmp73 = load ptr, ptr %kind, align 8
  call void @lunite_release(ptr %tmp73)
  ret ptr %eptr71

when_next74:                                      ; preds = %when_next66
  %tptr84 = getelementptr inbounds { i64, [8 x i8] }, ptr %kind1, i32 0, i32 0
  %tag85 = load i64, ptr %tptr84, align 8
  %match86 = icmp eq i64 %tag85, 9
  br i1 %match86, label %when_body83, label %when_next82

when_body75:                                      ; preds = %when_next66
  %eptr79 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t80 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr79, i32 0, i32 0
  store i64 11, ptr %t80, align 8
  call void @lunite_retain(ptr %eptr79)
  %tmp81 = load ptr, ptr %kind, align 8
  call void @lunite_release(ptr %tmp81)
  ret ptr %eptr79

when_next82:                                      ; preds = %when_next74
  %tptr92 = getelementptr inbounds { i64, [8 x i8] }, ptr %kind1, i32 0, i32 0
  %tag93 = load i64, ptr %tptr92, align 8
  %match94 = icmp eq i64 %tag93, 10
  br i1 %match94, label %when_body91, label %when_next90

when_body83:                                      ; preds = %when_next74
  %eptr87 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t88 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr87, i32 0, i32 0
  store i64 11, ptr %t88, align 8
  call void @lunite_retain(ptr %eptr87)
  %tmp89 = load ptr, ptr %kind, align 8
  call void @lunite_release(ptr %tmp89)
  ret ptr %eptr87

when_next90:                                      ; preds = %when_next82
  %tptr100 = getelementptr inbounds { i64, [8 x i8] }, ptr %kind1, i32 0, i32 0
  %tag101 = load i64, ptr %tptr100, align 8
  %match102 = icmp eq i64 %tag101, 22
  br i1 %match102, label %when_body99, label %when_next98

when_body91:                                      ; preds = %when_next82
  %eptr95 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t96 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr95, i32 0, i32 0
  store i64 11, ptr %t96, align 8
  call void @lunite_retain(ptr %eptr95)
  %tmp97 = load ptr, ptr %kind, align 8
  call void @lunite_release(ptr %tmp97)
  ret ptr %eptr95

when_next98:                                      ; preds = %when_next90
  %tptr108 = getelementptr inbounds { i64, [8 x i8] }, ptr %kind1, i32 0, i32 0
  %tag109 = load i64, ptr %tptr108, align 8
  %match110 = icmp eq i64 %tag109, 23
  br i1 %match110, label %when_body107, label %when_next106

when_body99:                                      ; preds = %when_next90
  %eptr103 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t104 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr103, i32 0, i32 0
  store i64 9, ptr %t104, align 8
  call void @lunite_retain(ptr %eptr103)
  %tmp105 = load ptr, ptr %kind, align 8
  call void @lunite_release(ptr %tmp105)
  ret ptr %eptr103

when_next106:                                     ; preds = %when_next98
  %tptr116 = getelementptr inbounds { i64, [8 x i8] }, ptr %kind1, i32 0, i32 0
  %tag117 = load i64, ptr %tptr116, align 8
  %match118 = icmp eq i64 %tag117, 19
  br i1 %match118, label %when_body115, label %when_next114

when_body107:                                     ; preds = %when_next98
  %eptr111 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t112 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr111, i32 0, i32 0
  store i64 9, ptr %t112, align 8
  call void @lunite_retain(ptr %eptr111)
  %tmp113 = load ptr, ptr %kind, align 8
  call void @lunite_release(ptr %tmp113)
  ret ptr %eptr111

when_next114:                                     ; preds = %when_next106
  %tptr124 = getelementptr inbounds { i64, [8 x i8] }, ptr %kind1, i32 0, i32 0
  %tag125 = load i64, ptr %tptr124, align 8
  %match126 = icmp eq i64 %tag125, 21
  br i1 %match126, label %when_body123, label %when_next122

when_body115:                                     ; preds = %when_next106
  %eptr119 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t120 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr119, i32 0, i32 0
  store i64 7, ptr %t120, align 8
  call void @lunite_retain(ptr %eptr119)
  %tmp121 = load ptr, ptr %kind, align 8
  call void @lunite_release(ptr %tmp121)
  ret ptr %eptr119

when_next122:                                     ; preds = %when_next114
  %tptr132 = getelementptr inbounds { i64, [8 x i8] }, ptr %kind1, i32 0, i32 0
  %tag133 = load i64, ptr %tptr132, align 8
  %match134 = icmp eq i64 %tag133, 20
  br i1 %match134, label %when_body131, label %when_next130

when_body123:                                     ; preds = %when_next114
  %eptr127 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t128 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr127, i32 0, i32 0
  store i64 6, ptr %t128, align 8
  call void @lunite_retain(ptr %eptr127)
  %tmp129 = load ptr, ptr %kind, align 8
  call void @lunite_release(ptr %tmp129)
  ret ptr %eptr127

when_next130:                                     ; preds = %when_next122
  %tptr140 = getelementptr inbounds { i64, [8 x i8] }, ptr %kind1, i32 0, i32 0
  %tag141 = load i64, ptr %tptr140, align 8
  %match142 = icmp eq i64 %tag141, 27
  br i1 %match142, label %when_body139, label %when_next138

when_body131:                                     ; preds = %when_next122
  %eptr135 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t136 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr135, i32 0, i32 0
  store i64 5, ptr %t136, align 8
  call void @lunite_retain(ptr %eptr135)
  %tmp137 = load ptr, ptr %kind, align 8
  call void @lunite_release(ptr %tmp137)
  ret ptr %eptr135

when_next138:                                     ; preds = %when_next130
  %tptr148 = getelementptr inbounds { i64, [8 x i8] }, ptr %kind1, i32 0, i32 0
  %tag149 = load i64, ptr %tptr148, align 8
  %match150 = icmp eq i64 %tag149, 31
  br i1 %match150, label %when_body147, label %when_next146

when_body139:                                     ; preds = %when_next130
  %eptr143 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t144 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr143, i32 0, i32 0
  store i64 13, ptr %t144, align 8
  call void @lunite_retain(ptr %eptr143)
  %tmp145 = load ptr, ptr %kind, align 8
  call void @lunite_release(ptr %tmp145)
  ret ptr %eptr143

when_next146:                                     ; preds = %when_next138
  %tptr156 = getelementptr inbounds { i64, [8 x i8] }, ptr %kind1, i32 0, i32 0
  %tag157 = load i64, ptr %tptr156, align 8
  %match158 = icmp eq i64 %tag157, 26
  br i1 %match158, label %when_body155, label %when_next154

when_body147:                                     ; preds = %when_next138
  %eptr151 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t152 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr151, i32 0, i32 0
  store i64 14, ptr %t152, align 8
  call void @lunite_retain(ptr %eptr151)
  %tmp153 = load ptr, ptr %kind, align 8
  call void @lunite_release(ptr %tmp153)
  ret ptr %eptr151

when_next154:                                     ; preds = %when_next146
  %tptr164 = getelementptr inbounds { i64, [8 x i8] }, ptr %kind1, i32 0, i32 0
  %tag165 = load i64, ptr %tptr164, align 8
  %match166 = icmp eq i64 %tag165, 36
  br i1 %match166, label %when_body163, label %when_next162

when_body155:                                     ; preds = %when_next146
  %eptr159 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t160 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr159, i32 0, i32 0
  store i64 15, ptr %t160, align 8
  call void @lunite_retain(ptr %eptr159)
  %tmp161 = load ptr, ptr %kind, align 8
  call void @lunite_release(ptr %tmp161)
  ret ptr %eptr159

when_next162:                                     ; preds = %when_next154
  %tptr172 = getelementptr inbounds { i64, [8 x i8] }, ptr %kind1, i32 0, i32 0
  %tag173 = load i64, ptr %tptr172, align 8
  %match174 = icmp eq i64 %tag173, 62
  br i1 %match174, label %when_body171, label %when_next170

when_body163:                                     ; preds = %when_next154
  %eptr167 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t168 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr167, i32 0, i32 0
  store i64 16, ptr %t168, align 8
  call void @lunite_retain(ptr %eptr167)
  %tmp169 = load ptr, ptr %kind, align 8
  call void @lunite_release(ptr %tmp169)
  ret ptr %eptr167

when_next170:                                     ; preds = %when_next162
  br label %when_body179

when_body171:                                     ; preds = %when_next162
  %eptr175 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t176 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr175, i32 0, i32 0
  store i64 12, ptr %t176, align 8
  call void @lunite_retain(ptr %eptr175)
  %tmp177 = load ptr, ptr %kind, align 8
  call void @lunite_release(ptr %tmp177)
  ret ptr %eptr175

when_next178:                                     ; No predecessors!
  br label %when_end

when_body179:                                     ; preds = %when_next170
  %eptr180 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t181 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr180, i32 0, i32 0
  store i64 0, ptr %t181, align 8
  call void @lunite_retain(ptr %eptr180)
  %tmp182 = load ptr, ptr %kind, align 8
  call void @lunite_release(ptr %tmp182)
  ret ptr %eptr180
}

define ptr @parser_Parser_new(ptr %0) {
entry:
  %peek = alloca ptr, align 8
  %cur = alloca ptr, align 8
  %l = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %l, align 8
  %l1 = load ptr, ptr %l, align 8
  call void @lunite_retain(ptr %l1)
  %res = call ptr @lexer_Lexer_next_token(ptr %l1)
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %cur, align 8
  %l2 = load ptr, ptr %l, align 8
  call void @lunite_retain(ptr %l2)
  %res3 = call ptr @lexer_Lexer_next_token(ptr %l2)
  call void @lunite_retain(ptr %res3)
  store ptr %res3, ptr %peek, align 8
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%parser_Parser, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %parser_Parser, ptr %ptr, i32 0, i32 0
  %l4 = load ptr, ptr %l, align 8
  call void @lunite_retain(ptr %l4)
  store ptr %l4, ptr %fp, align 8
  %fp5 = getelementptr inbounds %parser_Parser, ptr %ptr, i32 0, i32 1
  %cur6 = load ptr, ptr %cur, align 8
  call void @lunite_retain(ptr %cur6)
  store ptr %cur6, ptr %fp5, align 8
  %fp7 = getelementptr inbounds %parser_Parser, ptr %ptr, i32 0, i32 2
  %peek8 = load ptr, ptr %peek, align 8
  call void @lunite_retain(ptr %peek8)
  store ptr %peek8, ptr %fp7, align 8
  call void @lunite_retain(ptr %ptr)
  %tmp = load ptr, ptr %peek, align 8
  call void @lunite_release(ptr %tmp)
  %tmp9 = load ptr, ptr %cur, align 8
  call void @lunite_release(ptr %tmp9)
  %tmp10 = load ptr, ptr %l, align 8
  call void @lunite_release(ptr %tmp10)
  ret ptr %ptr
}

define void @parser_Parser_next_token(ptr %0) {
entry:
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %parser_Parser, ptr %self1, i32 0, i32 1
  %self2 = load ptr, ptr %self, align 8
  %fp3 = getelementptr inbounds %parser_Parser, ptr %self2, i32 0, i32 2
  %peek_token = load ptr, ptr %fp3, align 8
  %old = load ptr, ptr %fp, align 8
  call void @lunite_retain(ptr %peek_token)
  store ptr %peek_token, ptr %fp, align 8
  call void @lunite_release(ptr %old)
  %self4 = load ptr, ptr %self, align 8
  %fp5 = getelementptr inbounds %parser_Parser, ptr %self4, i32 0, i32 2
  %self6 = load ptr, ptr %self, align 8
  %fp7 = getelementptr inbounds %parser_Parser, ptr %self6, i32 0, i32 0
  %lexer = load ptr, ptr %fp7, align 8
  call void @lunite_retain(ptr %lexer)
  %res = call ptr @lexer_Lexer_next_token(ptr %lexer)
  %old8 = load ptr, ptr %fp5, align 8
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %fp5, align 8
  call void @lunite_release(ptr %old8)
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret void
}

define i1 @parser_Parser_cur_is(ptr %0, ptr %1) {
entry:
  %kind = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %kind, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %parser_Parser, ptr %self1, i32 0, i32 1
  %cur_token = load ptr, ptr %fp, align 8
  %fp2 = getelementptr inbounds %token_Token, ptr %cur_token, i32 0, i32 0
  %kind3 = load ptr, ptr %fp2, align 8
  %kind4 = load ptr, ptr %kind, align 8
  %l_null = icmp eq ptr %kind3, null
  %r_null = icmp eq ptr %kind4, null
  %both_null = and i1 %l_null, %r_null
  %either_null = or i1 %l_null, %r_null
  br i1 %either_null, label %enum_res, label %enum_load

enum_load:                                        ; preds = %body
  %ltag = getelementptr inbounds { i64, [8 x i8] }, ptr %kind3, i32 0, i32 0
  %rtag = getelementptr inbounds { i64, [8 x i8] }, ptr %kind4, i32 0, i32 0
  %lt = load i64, ptr %ltag, align 8
  %rt = load i64, ptr %rtag, align 8
  %teq = icmp eq i64 %lt, %rt
  br label %enum_res

enum_res:                                         ; preds = %enum_load, %body
  %eq = phi i1 [ %both_null, %body ], [ %teq, %enum_load ]
  %tmp = load ptr, ptr %kind, align 8
  call void @lunite_release(ptr %tmp)
  %tmp5 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp5)
  ret i1 %eq
}

define i1 @parser_Parser_peek_is(ptr %0, ptr %1) {
entry:
  %kind = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %kind, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %parser_Parser, ptr %self1, i32 0, i32 2
  %peek_token = load ptr, ptr %fp, align 8
  %fp2 = getelementptr inbounds %token_Token, ptr %peek_token, i32 0, i32 0
  %kind3 = load ptr, ptr %fp2, align 8
  %kind4 = load ptr, ptr %kind, align 8
  %l_null = icmp eq ptr %kind3, null
  %r_null = icmp eq ptr %kind4, null
  %both_null = and i1 %l_null, %r_null
  %either_null = or i1 %l_null, %r_null
  br i1 %either_null, label %enum_res, label %enum_load

enum_load:                                        ; preds = %body
  %ltag = getelementptr inbounds { i64, [8 x i8] }, ptr %kind3, i32 0, i32 0
  %rtag = getelementptr inbounds { i64, [8 x i8] }, ptr %kind4, i32 0, i32 0
  %lt = load i64, ptr %ltag, align 8
  %rt = load i64, ptr %rtag, align 8
  %teq = icmp eq i64 %lt, %rt
  br label %enum_res

enum_res:                                         ; preds = %enum_load, %body
  %eq = phi i1 [ %both_null, %body ], [ %teq, %enum_load ]
  %tmp = load ptr, ptr %kind, align 8
  call void @lunite_release(ptr %tmp)
  %tmp5 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp5)
  ret i1 %eq
}

define void @parser_Parser_skip_newlines(ptr %0) {
entry:
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  br label %while_cond

while_cond:                                       ; preds = %while_body, %body
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %parser_Parser, ptr %self1, i32 0, i32 1
  %cur_token = load ptr, ptr %fp, align 8
  %fp2 = getelementptr inbounds %token_Token, ptr %cur_token, i32 0, i32 0
  %kind = load ptr, ptr %fp2, align 8
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 41, ptr %t, align 8
  %l_null = icmp eq ptr %kind, null
  %r_null = icmp eq ptr %eptr, null
  %both_null = and i1 %l_null, %r_null
  %either_null = or i1 %l_null, %r_null
  br i1 %either_null, label %enum_res, label %enum_load

while_body:                                       ; preds = %enum_res15
  %self22 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self22)
  call void @parser_Parser_next_token(ptr %self22)
  br label %while_cond

while_end:                                        ; preds = %enum_res15
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret void

enum_load:                                        ; preds = %while_cond
  %ltag = getelementptr inbounds { i64, [8 x i8] }, ptr %kind, i32 0, i32 0
  %rtag = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  %lt = load i64, ptr %ltag, align 8
  %rt = load i64, ptr %rtag, align 8
  %teq = icmp eq i64 %lt, %rt
  br label %enum_res

enum_res:                                         ; preds = %enum_load, %while_cond
  %eq = phi i1 [ %both_null, %while_cond ], [ %teq, %enum_load ]
  %self3 = load ptr, ptr %self, align 8
  %fp4 = getelementptr inbounds %parser_Parser, ptr %self3, i32 0, i32 1
  %cur_token5 = load ptr, ptr %fp4, align 8
  %fp6 = getelementptr inbounds %token_Token, ptr %cur_token5, i32 0, i32 0
  %kind7 = load ptr, ptr %fp6, align 8
  %eptr8 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t9 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr8, i32 0, i32 0
  store i64 40, ptr %t9, align 8
  %l_null10 = icmp eq ptr %kind7, null
  %r_null11 = icmp eq ptr %eptr8, null
  %both_null12 = and i1 %l_null10, %r_null11
  %either_null13 = or i1 %l_null10, %r_null11
  br i1 %either_null13, label %enum_res15, label %enum_load14

enum_load14:                                      ; preds = %enum_res
  %ltag16 = getelementptr inbounds { i64, [8 x i8] }, ptr %kind7, i32 0, i32 0
  %rtag17 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr8, i32 0, i32 0
  %lt18 = load i64, ptr %ltag16, align 8
  %rt19 = load i64, ptr %rtag17, align 8
  %teq20 = icmp eq i64 %lt18, %rt19
  br label %enum_res15

enum_res15:                                       ; preds = %enum_load14, %enum_res
  %eq21 = phi i1 [ %both_null12, %enum_res ], [ %teq20, %enum_load14 ]
  %1 = or i1 %eq, %eq21
  br i1 %1, label %while_body, label %while_end
}

define ptr @parser_Parser_parse_program(ptr %0) {
entry:
  %i = alloca ptr, align 8
  %is_valid = alloca i1, align 1
  %item = alloca ptr, align 8
  %items = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %res = call ptr @list_List_ast_Item__new()
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %items, align 8
  br label %while_cond

while_cond:                                       ; preds = %cont41, %body
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %parser_Parser, ptr %self1, i32 0, i32 1
  %cur_token = load ptr, ptr %fp, align 8
  %fp2 = getelementptr inbounds %token_Token, ptr %cur_token, i32 0, i32 0
  %kind = load ptr, ptr %fp2, align 8
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 1, ptr %t, align 8
  %l_null = icmp eq ptr %kind, null
  %r_null = icmp eq ptr %eptr, null
  %one_null = xor i1 %l_null, %r_null
  %both_null = and i1 %l_null, %r_null
  %either_null = or i1 %l_null, %r_null
  br i1 %either_null, label %enum_res_ne, label %enum_load_ne

while_body:                                       ; preds = %enum_res_ne
  %self3 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self3)
  call void @parser_Parser_skip_newlines(ptr %self3)
  %self4 = load ptr, ptr %self, align 8
  %fp5 = getelementptr inbounds %parser_Parser, ptr %self4, i32 0, i32 1
  %cur_token6 = load ptr, ptr %fp5, align 8
  %fp7 = getelementptr inbounds %token_Token, ptr %cur_token6, i32 0, i32 0
  %kind8 = load ptr, ptr %fp7, align 8
  %eptr9 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t10 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr9, i32 0, i32 0
  store i64 1, ptr %t10, align 8
  %l_null11 = icmp eq ptr %kind8, null
  %r_null12 = icmp eq ptr %eptr9, null
  %both_null13 = and i1 %l_null11, %r_null12
  %either_null14 = or i1 %l_null11, %r_null12
  br i1 %either_null14, label %enum_res, label %enum_load

while_end:                                        ; preds = %then, %enum_res_ne
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%ast_Program, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp46 = getelementptr inbounds %ast_Program, ptr %ptr, i32 0, i32 0
  %items47 = load ptr, ptr %items, align 8
  call void @lunite_retain(ptr %items47)
  store ptr %items47, ptr %fp46, align 8
  call void @lunite_retain(ptr %ptr)
  %tmp48 = load ptr, ptr %items, align 8
  call void @lunite_release(ptr %tmp48)
  %tmp49 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp49)
  ret ptr %ptr

enum_load_ne:                                     ; preds = %while_cond
  %ltag = getelementptr inbounds { i64, [8 x i8] }, ptr %kind, i32 0, i32 0
  %rtag = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  %lt = load i64, ptr %ltag, align 8
  %rt = load i64, ptr %rtag, align 8
  %tne = icmp ne i64 %lt, %rt
  br label %enum_res_ne

enum_res_ne:                                      ; preds = %enum_load_ne, %while_cond
  %ne = phi i1 [ %one_null, %while_cond ], [ %tne, %enum_load_ne ]
  br i1 %ne, label %while_body, label %while_end

enum_load:                                        ; preds = %while_body
  %ltag15 = getelementptr inbounds { i64, [8 x i8] }, ptr %kind8, i32 0, i32 0
  %rtag16 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr9, i32 0, i32 0
  %lt17 = load i64, ptr %ltag15, align 8
  %rt18 = load i64, ptr %rtag16, align 8
  %teq = icmp eq i64 %lt17, %rt18
  br label %enum_res

enum_res:                                         ; preds = %enum_load, %while_body
  %eq = phi i1 [ %both_null13, %while_body ], [ %teq, %enum_load ]
  br i1 %eq, label %then, label %else

then:                                             ; preds = %enum_res
  br label %while_end

else:                                             ; preds = %enum_res
  br label %cont

cont:                                             ; preds = %else
  %self19 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self19)
  %res20 = call ptr @parser_Parser_parse_item(ptr %self19)
  call void @lunite_retain(ptr %res20)
  store ptr %res20, ptr %item, align 8
  store i1 true, ptr %is_valid, align 1
  %item21 = load ptr, ptr %item, align 8
  %tptr = getelementptr inbounds { i64, [8 x i8] }, ptr %item21, i32 0, i32 0
  %tag = load i64, ptr %tptr, align 8
  %match = icmp eq i64 %tag, 0
  br i1 %match, label %when_body, label %when_next

when_end:                                         ; preds = %when_next36, %when_body37, %cont35
  %is_valid38 = load i1, ptr %is_valid, align 1
  br i1 %is_valid38, label %then39, label %else40

when_next:                                        ; preds = %cont
  br label %when_body37

when_body:                                        ; preds = %cont
  %pptr = getelementptr inbounds { i64, [8 x i8] }, ptr %item21, i32 0, i32 1
  %pval = load ptr, ptr %pptr, align 8
  call void @lunite_retain(ptr %pval)
  store ptr %pval, ptr %i, align 8
  %i22 = load ptr, ptr %i, align 8
  %fp23 = getelementptr inbounds %ast_ImportDecl, ptr %i22, i32 0, i32 0
  %path = load ptr, ptr %fp23, align 8
  %sdata = call ptr @lunite_alloc(i64 5, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.41, i64 5, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p, align 8
  store i64 5, ptr %l, align 8
  %seq = call i64 @lunite_str_eq(ptr %path, ptr %sstruct)
  %bool = icmp ne i64 %seq, 0
  %i24 = load ptr, ptr %i, align 8
  %fp25 = getelementptr inbounds %ast_ImportDecl, ptr %i24, i32 0, i32 0
  %path26 = load ptr, ptr %fp25, align 8
  %sdata27 = call ptr @lunite_alloc(i64 15, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata27, ptr align 1 @slit.42, i64 15, i1 false)
  %sstruct28 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p29 = getelementptr inbounds { ptr, i64 }, ptr %sstruct28, i32 0, i32 0
  %l30 = getelementptr inbounds { ptr, i64 }, ptr %sstruct28, i32 0, i32 1
  store ptr %sdata27, ptr %p29, align 8
  store i64 15, ptr %l30, align 8
  %seq31 = call i64 @lunite_str_eq(ptr %path26, ptr %sstruct28)
  %bool32 = icmp ne i64 %seq31, 0
  %1 = or i1 %bool, %bool32
  br i1 %1, label %then33, label %else34

then33:                                           ; preds = %when_body
  store i1 false, ptr %is_valid, align 1
  br label %cont35

else34:                                           ; preds = %when_body
  br label %cont35

cont35:                                           ; preds = %else34, %then33
  %tmp = load ptr, ptr %i, align 8
  call void @lunite_release(ptr %tmp)
  br label %when_end

when_next36:                                      ; No predecessors!
  br label %when_end

when_body37:                                      ; preds = %when_next
  br label %when_end

then39:                                           ; preds = %when_end
  %items42 = load ptr, ptr %items, align 8
  call void @lunite_retain(ptr %items42)
  %item43 = load ptr, ptr %item, align 8
  call void @lunite_retain(ptr %item43)
  call void @list_List_ast_Item__push(ptr %items42, ptr %item43)
  br label %cont41

else40:                                           ; preds = %when_end
  br label %cont41

cont41:                                           ; preds = %else40, %then39
  %self44 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self44)
  call void @parser_Parser_skip_newlines(ptr %self44)
  %tmp45 = load ptr, ptr %item, align 8
  call void @lunite_release(ptr %tmp45)
  br label %while_cond
}

define ptr @parser_Parser_parse_item(ptr %0) {
entry:
  %k = alloca ptr, align 8
  %vis = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 1, ptr %t, align 8
  call void @lunite_retain(ptr %eptr)
  store ptr %eptr, ptr %vis, align 8
  %self1 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self1)
  %eptr2 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t3 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr2, i32 0, i32 0
  store i64 57, ptr %t3, align 8
  call void @lunite_retain(ptr %eptr2)
  %res = call i1 @parser_Parser_cur_is(ptr %self1, ptr %eptr2)
  br i1 %res, label %then, label %else

then:                                             ; preds = %body
  %eptr4 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t5 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr4, i32 0, i32 0
  store i64 0, ptr %t5, align 8
  %old = load ptr, ptr %vis, align 8
  call void @lunite_retain(ptr %eptr4)
  store ptr %eptr4, ptr %vis, align 8
  call void @lunite_release(ptr %old)
  %self6 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self6)
  call void @parser_Parser_next_token(ptr %self6)
  br label %cont

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else, %then
  %self7 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %parser_Parser, ptr %self7, i32 0, i32 1
  %cur_token = load ptr, ptr %fp, align 8
  %fp8 = getelementptr inbounds %token_Token, ptr %cur_token, i32 0, i32 0
  %kind = load ptr, ptr %fp8, align 8
  call void @lunite_retain(ptr %kind)
  store ptr %kind, ptr %k, align 8
  %k9 = load ptr, ptr %k, align 8
  %eptr10 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t11 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr10, i32 0, i32 0
  store i64 54, ptr %t11, align 8
  %l_null = icmp eq ptr %k9, null
  %r_null = icmp eq ptr %eptr10, null
  %both_null = and i1 %l_null, %r_null
  %either_null = or i1 %l_null, %r_null
  br i1 %either_null, label %enum_res, label %enum_load

enum_load:                                        ; preds = %cont
  %ltag = getelementptr inbounds { i64, [8 x i8] }, ptr %k9, i32 0, i32 0
  %rtag = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr10, i32 0, i32 0
  %lt = load i64, ptr %ltag, align 8
  %rt = load i64, ptr %rtag, align 8
  %teq = icmp eq i64 %lt, %rt
  br label %enum_res

enum_res:                                         ; preds = %enum_load, %cont
  %eq = phi i1 [ %both_null, %cont ], [ %teq, %enum_load ]
  br i1 %eq, label %then12, label %else13

then12:                                           ; preds = %enum_res
  %self15 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self15)
  %res16 = call ptr @parser_Parser_parse_import_item(ptr %self15)
  call void @lunite_retain(ptr %res16)
  %tmp = load ptr, ptr %k, align 8
  call void @lunite_release(ptr %tmp)
  %tmp17 = load ptr, ptr %vis, align 8
  call void @lunite_release(ptr %tmp17)
  %tmp18 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp18)
  ret ptr %res16

else13:                                           ; preds = %enum_res
  %k19 = load ptr, ptr %k, align 8
  %eptr20 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t21 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr20, i32 0, i32 0
  store i64 42, ptr %t21, align 8
  %l_null22 = icmp eq ptr %k19, null
  %r_null23 = icmp eq ptr %eptr20, null
  %both_null24 = and i1 %l_null22, %r_null23
  %either_null25 = or i1 %l_null22, %r_null23
  br i1 %either_null25, label %enum_res27, label %enum_load26

cont14:                                           ; preds = %cont36
  %k45 = load ptr, ptr %k, align 8
  %eptr46 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t47 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr46, i32 0, i32 0
  store i64 40, ptr %t47, align 8
  %l_null48 = icmp eq ptr %k45, null
  %r_null49 = icmp eq ptr %eptr46, null
  %both_null50 = and i1 %l_null48, %r_null49
  %either_null51 = or i1 %l_null48, %r_null49
  br i1 %either_null51, label %enum_res53, label %enum_load52

enum_load26:                                      ; preds = %else13
  %ltag28 = getelementptr inbounds { i64, [8 x i8] }, ptr %k19, i32 0, i32 0
  %rtag29 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr20, i32 0, i32 0
  %lt30 = load i64, ptr %ltag28, align 8
  %rt31 = load i64, ptr %rtag29, align 8
  %teq32 = icmp eq i64 %lt30, %rt31
  br label %enum_res27

enum_res27:                                       ; preds = %enum_load26, %else13
  %eq33 = phi i1 [ %both_null24, %else13 ], [ %teq32, %enum_load26 ]
  br i1 %eq33, label %then34, label %else35

then34:                                           ; preds = %enum_res27
  %eptr37 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t38 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr37, i32 0, i32 0
  store i64 1, ptr %t38, align 8
  %self39 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self39)
  %vis40 = load ptr, ptr %vis, align 8
  call void @lunite_retain(ptr %vis40)
  %res41 = call ptr @parser_Parser_parse_function_decl(ptr %self39, ptr %vis40, i1 false)
  call void @lunite_retain(ptr %res41)
  %p = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr37, i32 0, i32 1
  store ptr %res41, ptr %p, align 8
  call void @lunite_retain(ptr %eptr37)
  %tmp42 = load ptr, ptr %k, align 8
  call void @lunite_release(ptr %tmp42)
  %tmp43 = load ptr, ptr %vis, align 8
  call void @lunite_release(ptr %tmp43)
  %tmp44 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp44)
  ret ptr %eptr37

else35:                                           ; preds = %enum_res27
  br label %cont36

cont36:                                           ; preds = %else35
  br label %cont14

enum_load52:                                      ; preds = %cont14
  %ltag54 = getelementptr inbounds { i64, [8 x i8] }, ptr %k45, i32 0, i32 0
  %rtag55 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr46, i32 0, i32 0
  %lt56 = load i64, ptr %ltag54, align 8
  %rt57 = load i64, ptr %rtag55, align 8
  %teq58 = icmp eq i64 %lt56, %rt57
  br label %enum_res53

enum_res53:                                       ; preds = %enum_load52, %cont14
  %eq59 = phi i1 [ %both_null50, %cont14 ], [ %teq58, %enum_load52 ]
  br i1 %eq59, label %then60, label %else61

then60:                                           ; preds = %enum_res53
  %self63 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self63)
  call void @parser_Parser_next_token(ptr %self63)
  %eptr64 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t65 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr64, i32 0, i32 0
  store i64 0, ptr %t65, align 8
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%ast_ImportDecl, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp66 = getelementptr inbounds %ast_ImportDecl, ptr %ptr, i32 0, i32 0
  %sdata = call ptr @lunite_alloc(i64 15, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.43, i64 15, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p67 = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p67, align 8
  store i64 15, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  store ptr %sstruct, ptr %fp66, align 8
  %fp68 = getelementptr inbounds %ast_ImportDecl, ptr %ptr, i32 0, i32 1
  %eptr69 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t70 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr69, i32 0, i32 0
  store i64 1, ptr %t70, align 8
  call void @lunite_retain(ptr %eptr69)
  store ptr %eptr69, ptr %fp68, align 8
  call void @lunite_retain(ptr %ptr)
  %p71 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr64, i32 0, i32 1
  store ptr %ptr, ptr %p71, align 8
  call void @lunite_retain(ptr %eptr64)
  %tmp72 = load ptr, ptr %k, align 8
  call void @lunite_release(ptr %tmp72)
  %tmp73 = load ptr, ptr %vis, align 8
  call void @lunite_release(ptr %tmp73)
  %tmp74 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp74)
  ret ptr %eptr64

else61:                                           ; preds = %enum_res53
  br label %cont62

cont62:                                           ; preds = %else61
  %self75 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self75)
  call void @parser_Parser_next_token(ptr %self75)
  %eptr76 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t77 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr76, i32 0, i32 0
  store i64 0, ptr %t77, align 8
  %ptr78 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%ast_ImportDecl, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp79 = getelementptr inbounds %ast_ImportDecl, ptr %ptr78, i32 0, i32 0
  %sdata80 = call ptr @lunite_alloc(i64 5, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata80, ptr align 1 @slit.44, i64 5, i1 false)
  %sstruct81 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p82 = getelementptr inbounds { ptr, i64 }, ptr %sstruct81, i32 0, i32 0
  %l83 = getelementptr inbounds { ptr, i64 }, ptr %sstruct81, i32 0, i32 1
  store ptr %sdata80, ptr %p82, align 8
  store i64 5, ptr %l83, align 8
  call void @lunite_retain(ptr %sstruct81)
  store ptr %sstruct81, ptr %fp79, align 8
  %fp84 = getelementptr inbounds %ast_ImportDecl, ptr %ptr78, i32 0, i32 1
  %eptr85 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t86 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr85, i32 0, i32 0
  store i64 1, ptr %t86, align 8
  call void @lunite_retain(ptr %eptr85)
  store ptr %eptr85, ptr %fp84, align 8
  call void @lunite_retain(ptr %ptr78)
  %p87 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr76, i32 0, i32 1
  store ptr %ptr78, ptr %p87, align 8
  call void @lunite_retain(ptr %eptr76)
  %tmp88 = load ptr, ptr %k, align 8
  call void @lunite_release(ptr %tmp88)
  %tmp89 = load ptr, ptr %vis, align 8
  call void @lunite_release(ptr %tmp89)
  %tmp90 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp90)
  ret ptr %eptr76
}

define ptr @parser_Parser_parse_function_decl(ptr %0, ptr %1, i1 %2) {
entry:
  %body35 = alloca ptr, align 8
  %ret_type = alloca ptr, align 8
  %params = alloca ptr, align 8
  %generic_params = alloca ptr, align 8
  %s = alloca ptr, align 8
  %name = alloca ptr, align 8
  %is_pure = alloca i1, align 1
  %vis = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %vis, align 8
  store i1 %2, ptr %is_pure, align 1
  %self1 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self1)
  call void @parser_Parser_next_token(ptr %self1)
  %sdata = call ptr @lunite_alloc(i64 0, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.45, i64 0, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p, align 8
  store i64 0, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  store ptr %sstruct, ptr %name, align 8
  %self2 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %parser_Parser, ptr %self2, i32 0, i32 1
  %cur_token = load ptr, ptr %fp, align 8
  %fp3 = getelementptr inbounds %token_Token, ptr %cur_token, i32 0, i32 0
  %kind = load ptr, ptr %fp3, align 8
  %tptr = getelementptr inbounds { i64, [8 x i8] }, ptr %kind, i32 0, i32 0
  %tag = load i64, ptr %tptr, align 8
  %match = icmp eq i64 %tag, 2
  br i1 %match, label %when_body, label %when_next

when_end:                                         ; preds = %when_next5, %when_body6, %when_body
  %self11 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self11)
  call void @parser_Parser_next_token(ptr %self11)
  %res = call ptr @list_List_string_new()
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %generic_params, align 8
  %self12 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self12)
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 27, ptr %t, align 8
  call void @lunite_retain(ptr %eptr)
  %res13 = call i1 @parser_Parser_cur_is(ptr %self12, ptr %eptr)
  %not = xor i1 %res13, true
  br i1 %not, label %then, label %else

when_next:                                        ; preds = %body
  br label %when_body6

when_body:                                        ; preds = %body
  %pptr = getelementptr inbounds { i64, [8 x i8] }, ptr %kind, i32 0, i32 1
  %pval = load ptr, ptr %pptr, align 8
  call void @lunite_retain(ptr %pval)
  store ptr %pval, ptr %s, align 8
  %s4 = load ptr, ptr %s, align 8
  %old = load ptr, ptr %name, align 8
  call void @lunite_retain(ptr %s4)
  store ptr %s4, ptr %name, align 8
  call void @lunite_release(ptr %old)
  %tmp = load ptr, ptr %s, align 8
  call void @lunite_release(ptr %tmp)
  br label %when_end

when_next5:                                       ; No predecessors!
  br label %when_end

when_body6:                                       ; preds = %when_next
  %sdata7 = call ptr @lunite_alloc(i64 44, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata7, ptr align 1 @slit.46, i64 44, i1 false)
  %sstruct8 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p9 = getelementptr inbounds { ptr, i64 }, ptr %sstruct8, i32 0, i32 0
  %l10 = getelementptr inbounds { ptr, i64 }, ptr %sstruct8, i32 0, i32 1
  store ptr %sdata7, ptr %p9, align 8
  store i64 44, ptr %l10, align 8
  call void @lunite_retain(ptr %sstruct8)
  call void @string_print(ptr %sstruct8)
  br label %when_end

then:                                             ; preds = %when_end
  %sdata14 = call ptr @lunite_alloc(i64 39, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata14, ptr align 1 @slit.47, i64 39, i1 false)
  %sstruct15 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p16 = getelementptr inbounds { ptr, i64 }, ptr %sstruct15, i32 0, i32 0
  %l17 = getelementptr inbounds { ptr, i64 }, ptr %sstruct15, i32 0, i32 1
  store ptr %sdata14, ptr %p16, align 8
  store i64 39, ptr %l17, align 8
  call void @lunite_retain(ptr %sstruct15)
  call void @string_print(ptr %sstruct15)
  br label %cont

else:                                             ; preds = %when_end
  br label %cont

cont:                                             ; preds = %else, %then
  %self18 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self18)
  %res19 = call ptr @parser_Parser_parse_function_params(ptr %self18)
  call void @lunite_retain(ptr %res19)
  store ptr %res19, ptr %params, align 8
  %eptr20 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t21 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr20, i32 0, i32 0
  store i64 4, ptr %t21, align 8
  call void @lunite_retain(ptr %eptr20)
  store ptr %eptr20, ptr %ret_type, align 8
  %self22 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self22)
  %eptr23 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t24 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr23, i32 0, i32 0
  store i64 38, ptr %t24, align 8
  call void @lunite_retain(ptr %eptr23)
  %res25 = call i1 @parser_Parser_cur_is(ptr %self22, ptr %eptr23)
  br i1 %res25, label %then26, label %else27

then26:                                           ; preds = %cont
  %self29 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self29)
  call void @parser_Parser_next_token(ptr %self29)
  %self30 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self30)
  %res31 = call ptr @parser_Parser_parse_type(ptr %self30)
  %old32 = load ptr, ptr %ret_type, align 8
  call void @lunite_retain(ptr %res31)
  store ptr %res31, ptr %ret_type, align 8
  call void @lunite_release(ptr %old32)
  br label %cont28

else27:                                           ; preds = %cont
  br label %cont28

cont28:                                           ; preds = %else27, %then26
  %self33 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self33)
  %res34 = call ptr @parser_Parser_parse_block(ptr %self33)
  call void @lunite_retain(ptr %res34)
  store ptr %res34, ptr %body35, align 8
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%ast_FunctionDecl, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp36 = getelementptr inbounds %ast_FunctionDecl, ptr %ptr, i32 0, i32 0
  %name37 = load ptr, ptr %name, align 8
  call void @lunite_retain(ptr %name37)
  store ptr %name37, ptr %fp36, align 8
  %fp38 = getelementptr inbounds %ast_FunctionDecl, ptr %ptr, i32 0, i32 1
  %generic_params39 = load ptr, ptr %generic_params, align 8
  call void @lunite_retain(ptr %generic_params39)
  store ptr %generic_params39, ptr %fp38, align 8
  %fp40 = getelementptr inbounds %ast_FunctionDecl, ptr %ptr, i32 0, i32 2
  %params41 = load ptr, ptr %params, align 8
  call void @lunite_retain(ptr %params41)
  store ptr %params41, ptr %fp40, align 8
  %fp42 = getelementptr inbounds %ast_FunctionDecl, ptr %ptr, i32 0, i32 3
  %ret_type43 = load ptr, ptr %ret_type, align 8
  call void @lunite_retain(ptr %ret_type43)
  store ptr %ret_type43, ptr %fp42, align 8
  %fp44 = getelementptr inbounds %ast_FunctionDecl, ptr %ptr, i32 0, i32 4
  %body45 = load ptr, ptr %body35, align 8
  call void @lunite_retain(ptr %body45)
  store ptr %body45, ptr %fp44, align 8
  %fp46 = getelementptr inbounds %ast_FunctionDecl, ptr %ptr, i32 0, i32 5
  %vis47 = load ptr, ptr %vis, align 8
  call void @lunite_retain(ptr %vis47)
  store ptr %vis47, ptr %fp46, align 8
  %fp48 = getelementptr inbounds %ast_FunctionDecl, ptr %ptr, i32 0, i32 6
  %is_pure49 = load i1, ptr %is_pure, align 1
  store i1 %is_pure49, ptr %fp48, align 1
  %fp50 = getelementptr inbounds %ast_FunctionDecl, ptr %ptr, i32 0, i32 7
  %eptr51 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t52 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr51, i32 0, i32 0
  store i64 1, ptr %t52, align 8
  call void @lunite_retain(ptr %eptr51)
  store ptr %eptr51, ptr %fp50, align 8
  call void @lunite_retain(ptr %ptr)
  %tmp53 = load ptr, ptr %body35, align 8
  call void @lunite_release(ptr %tmp53)
  %tmp54 = load ptr, ptr %ret_type, align 8
  call void @lunite_release(ptr %tmp54)
  %tmp55 = load ptr, ptr %params, align 8
  call void @lunite_release(ptr %tmp55)
  %tmp56 = load ptr, ptr %generic_params, align 8
  call void @lunite_release(ptr %tmp56)
  %tmp57 = load ptr, ptr %name, align 8
  call void @lunite_release(ptr %tmp57)
  %tmp58 = load ptr, ptr %vis, align 8
  call void @lunite_release(ptr %tmp58)
  %tmp59 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp59)
  ret ptr %ptr
}

define ptr @parser_Parser_parse_function_params(ptr %0) {
entry:
  %params = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self1)
  call void @parser_Parser_next_token(ptr %self1)
  %res = call ptr @list_List_ast_Param__new()
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %params, align 8
  br label %while_cond

while_cond:                                       ; preds = %while_body, %body
  %self2 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self2)
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 28, ptr %t, align 8
  call void @lunite_retain(ptr %eptr)
  %res3 = call i1 @parser_Parser_cur_is(ptr %self2, ptr %eptr)
  %not = xor i1 %res3, true
  %self4 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self4)
  %eptr5 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t6 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr5, i32 0, i32 0
  store i64 1, ptr %t6, align 8
  call void @lunite_retain(ptr %eptr5)
  %res7 = call i1 @parser_Parser_cur_is(ptr %self4, ptr %eptr5)
  %not8 = xor i1 %res7, true
  %1 = and i1 %not, %not8
  br i1 %1, label %while_body, label %while_end

while_body:                                       ; preds = %while_cond
  %self9 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self9)
  call void @parser_Parser_next_token(ptr %self9)
  br label %while_cond

while_end:                                        ; preds = %while_cond
  %self10 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self10)
  call void @parser_Parser_next_token(ptr %self10)
  %params11 = load ptr, ptr %params, align 8
  call void @lunite_retain(ptr %params11)
  %tmp = load ptr, ptr %params, align 8
  call void @lunite_release(ptr %tmp)
  %tmp12 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp12)
  ret ptr %params11
}

define ptr @parser_Parser_parse_type(ptr %0) {
entry:
  %s = alloca ptr, align 8
  %t1 = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 4, ptr %t, align 8
  call void @lunite_retain(ptr %eptr)
  store ptr %eptr, ptr %t1, align 8
  %self2 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %parser_Parser, ptr %self2, i32 0, i32 1
  %cur_token = load ptr, ptr %fp, align 8
  %fp3 = getelementptr inbounds %token_Token, ptr %cur_token, i32 0, i32 0
  %kind = load ptr, ptr %fp3, align 8
  %tptr = getelementptr inbounds { i64, [8 x i8] }, ptr %kind, i32 0, i32 0
  %tag = load i64, ptr %tptr, align 8
  %match = icmp eq i64 %tag, 76
  br i1 %match, label %when_body, label %when_next

when_end:                                         ; preds = %when_next49, %when_body50, %when_body39, %when_body31, %when_body23, %when_body15, %when_body7, %when_body
  %self52 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self52)
  call void @parser_Parser_next_token(ptr %self52)
  %t53 = load ptr, ptr %t1, align 8
  call void @lunite_retain(ptr %t53)
  %tmp54 = load ptr, ptr %t1, align 8
  call void @lunite_release(ptr %tmp54)
  %tmp55 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp55)
  ret ptr %t53

when_next:                                        ; preds = %body
  %tptr8 = getelementptr inbounds { i64, [8 x i8] }, ptr %kind, i32 0, i32 0
  %tag9 = load i64, ptr %tptr8, align 8
  %match10 = icmp eq i64 %tag9, 77
  br i1 %match10, label %when_body7, label %when_next6

when_body:                                        ; preds = %body
  %eptr4 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t5 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr4, i32 0, i32 0
  store i64 0, ptr %t5, align 8
  %old = load ptr, ptr %t1, align 8
  call void @lunite_retain(ptr %eptr4)
  store ptr %eptr4, ptr %t1, align 8
  call void @lunite_release(ptr %old)
  br label %when_end

when_next6:                                       ; preds = %when_next
  %tptr16 = getelementptr inbounds { i64, [8 x i8] }, ptr %kind, i32 0, i32 0
  %tag17 = load i64, ptr %tptr16, align 8
  %match18 = icmp eq i64 %tag17, 78
  br i1 %match18, label %when_body15, label %when_next14

when_body7:                                       ; preds = %when_next
  %eptr11 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t12 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr11, i32 0, i32 0
  store i64 1, ptr %t12, align 8
  %old13 = load ptr, ptr %t1, align 8
  call void @lunite_retain(ptr %eptr11)
  store ptr %eptr11, ptr %t1, align 8
  call void @lunite_release(ptr %old13)
  br label %when_end

when_next14:                                      ; preds = %when_next6
  %tptr24 = getelementptr inbounds { i64, [8 x i8] }, ptr %kind, i32 0, i32 0
  %tag25 = load i64, ptr %tptr24, align 8
  %match26 = icmp eq i64 %tag25, 79
  br i1 %match26, label %when_body23, label %when_next22

when_body15:                                      ; preds = %when_next6
  %eptr19 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t20 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr19, i32 0, i32 0
  store i64 2, ptr %t20, align 8
  %old21 = load ptr, ptr %t1, align 8
  call void @lunite_retain(ptr %eptr19)
  store ptr %eptr19, ptr %t1, align 8
  call void @lunite_release(ptr %old21)
  br label %when_end

when_next22:                                      ; preds = %when_next14
  %tptr32 = getelementptr inbounds { i64, [8 x i8] }, ptr %kind, i32 0, i32 0
  %tag33 = load i64, ptr %tptr32, align 8
  %match34 = icmp eq i64 %tag33, 80
  br i1 %match34, label %when_body31, label %when_next30

when_body23:                                      ; preds = %when_next14
  %eptr27 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t28 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr27, i32 0, i32 0
  store i64 3, ptr %t28, align 8
  %old29 = load ptr, ptr %t1, align 8
  call void @lunite_retain(ptr %eptr27)
  store ptr %eptr27, ptr %t1, align 8
  call void @lunite_release(ptr %old29)
  br label %when_end

when_next30:                                      ; preds = %when_next22
  %tptr40 = getelementptr inbounds { i64, [8 x i8] }, ptr %kind, i32 0, i32 0
  %tag41 = load i64, ptr %tptr40, align 8
  %match42 = icmp eq i64 %tag41, 2
  br i1 %match42, label %when_body39, label %when_next38

when_body31:                                      ; preds = %when_next22
  %eptr35 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t36 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr35, i32 0, i32 0
  store i64 4, ptr %t36, align 8
  %old37 = load ptr, ptr %t1, align 8
  call void @lunite_retain(ptr %eptr35)
  store ptr %eptr35, ptr %t1, align 8
  call void @lunite_release(ptr %old37)
  br label %when_end

when_next38:                                      ; preds = %when_next30
  br label %when_body50

when_body39:                                      ; preds = %when_next30
  %pptr = getelementptr inbounds { i64, [8 x i8] }, ptr %kind, i32 0, i32 1
  %pval = load ptr, ptr %pptr, align 8
  call void @lunite_retain(ptr %pval)
  store ptr %pval, ptr %s, align 8
  %eptr43 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t44 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr43, i32 0, i32 0
  store i64 5, ptr %t44, align 8
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%ast_CustomTypePayload, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp45 = getelementptr inbounds %ast_CustomTypePayload, ptr %ptr, i32 0, i32 0
  %s46 = load ptr, ptr %s, align 8
  call void @lunite_retain(ptr %s46)
  store ptr %s46, ptr %fp45, align 8
  %fp47 = getelementptr inbounds %ast_CustomTypePayload, ptr %ptr, i32 0, i32 1
  %res = call ptr @list_List_ast_Type__new()
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %fp47, align 8
  call void @lunite_retain(ptr %ptr)
  %p = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr43, i32 0, i32 1
  store ptr %ptr, ptr %p, align 8
  %old48 = load ptr, ptr %t1, align 8
  call void @lunite_retain(ptr %eptr43)
  store ptr %eptr43, ptr %t1, align 8
  call void @lunite_release(ptr %old48)
  %tmp = load ptr, ptr %s, align 8
  call void @lunite_release(ptr %tmp)
  br label %when_end

when_next49:                                      ; No predecessors!
  br label %when_end

when_body50:                                      ; preds = %when_next38
  %sdata = call ptr @lunite_alloc(i64 19, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.48, i64 19, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p51 = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p51, align 8
  store i64 19, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  call void @string_print(ptr %sstruct)
  br label %when_end
}

define ptr @parser_Parser_parse_block(ptr %0) {
entry:
  %stmts = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self1)
  call void @parser_Parser_next_token(ptr %self1)
  %res = call ptr @list_List_ast_Statement__new()
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %stmts, align 8
  br label %while_cond

while_cond:                                       ; preds = %cont, %body
  %self2 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self2)
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 30, ptr %t, align 8
  call void @lunite_retain(ptr %eptr)
  %res3 = call i1 @parser_Parser_cur_is(ptr %self2, ptr %eptr)
  %not = xor i1 %res3, true
  %self4 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self4)
  %eptr5 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t6 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr5, i32 0, i32 0
  store i64 1, ptr %t6, align 8
  call void @lunite_retain(ptr %eptr5)
  %res7 = call i1 @parser_Parser_cur_is(ptr %self4, ptr %eptr5)
  %not8 = xor i1 %res7, true
  %1 = and i1 %not, %not8
  br i1 %1, label %while_body, label %while_end

while_body:                                       ; preds = %while_cond
  %self9 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self9)
  call void @parser_Parser_skip_newlines(ptr %self9)
  %self10 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self10)
  %eptr11 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t12 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr11, i32 0, i32 0
  store i64 30, ptr %t12, align 8
  call void @lunite_retain(ptr %eptr11)
  %res13 = call i1 @parser_Parser_cur_is(ptr %self10, ptr %eptr11)
  br i1 %res13, label %then, label %else

while_end:                                        ; preds = %then, %while_cond
  %self18 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self18)
  call void @parser_Parser_next_token(ptr %self18)
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%ast_Block, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %ast_Block, ptr %ptr, i32 0, i32 0
  %stmts19 = load ptr, ptr %stmts, align 8
  call void @lunite_retain(ptr %stmts19)
  store ptr %stmts19, ptr %fp, align 8
  call void @lunite_retain(ptr %ptr)
  %tmp = load ptr, ptr %stmts, align 8
  call void @lunite_release(ptr %tmp)
  %tmp20 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp20)
  ret ptr %ptr

then:                                             ; preds = %while_body
  br label %while_end

else:                                             ; preds = %while_body
  br label %cont

cont:                                             ; preds = %else
  %stmts14 = load ptr, ptr %stmts, align 8
  call void @lunite_retain(ptr %stmts14)
  %self15 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self15)
  %res16 = call ptr @parser_Parser_parse_statement(ptr %self15)
  call void @lunite_retain(ptr %res16)
  call void @list_List_ast_Statement__push(ptr %stmts14, ptr %res16)
  %self17 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self17)
  call void @parser_Parser_skip_newlines(ptr %self17)
  br label %while_cond
}

define ptr @parser_Parser_parse_statement(ptr %0) {
entry:
  %expr = alloca ptr, align 8
  %k = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %parser_Parser, ptr %self1, i32 0, i32 1
  %cur_token = load ptr, ptr %fp, align 8
  %fp2 = getelementptr inbounds %token_Token, ptr %cur_token, i32 0, i32 0
  %kind = load ptr, ptr %fp2, align 8
  call void @lunite_retain(ptr %kind)
  store ptr %kind, ptr %k, align 8
  %k3 = load ptr, ptr %k, align 8
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 43, ptr %t, align 8
  %l_null = icmp eq ptr %k3, null
  %r_null = icmp eq ptr %eptr, null
  %both_null = and i1 %l_null, %r_null
  %either_null = or i1 %l_null, %r_null
  br i1 %either_null, label %enum_res, label %enum_load

enum_load:                                        ; preds = %body
  %ltag = getelementptr inbounds { i64, [8 x i8] }, ptr %k3, i32 0, i32 0
  %rtag = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  %lt = load i64, ptr %ltag, align 8
  %rt = load i64, ptr %rtag, align 8
  %teq = icmp eq i64 %lt, %rt
  br label %enum_res

enum_res:                                         ; preds = %enum_load, %body
  %eq = phi i1 [ %both_null, %body ], [ %teq, %enum_load ]
  br i1 %eq, label %then, label %else

then:                                             ; preds = %enum_res
  %self4 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self4)
  %res = call ptr @parser_Parser_parse_let_statement(ptr %self4)
  call void @lunite_retain(ptr %res)
  %tmp = load ptr, ptr %k, align 8
  call void @lunite_release(ptr %tmp)
  %tmp5 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp5)
  ret ptr %res

else:                                             ; preds = %enum_res
  %k6 = load ptr, ptr %k, align 8
  %eptr7 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t8 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr7, i32 0, i32 0
  store i64 44, ptr %t8, align 8
  %l_null9 = icmp eq ptr %k6, null
  %r_null10 = icmp eq ptr %eptr7, null
  %both_null11 = and i1 %l_null9, %r_null10
  %either_null12 = or i1 %l_null9, %r_null10
  br i1 %either_null12, label %enum_res14, label %enum_load13

cont:                                             ; preds = %cont23
  %self160 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self160)
  %eptr161 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t162 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr161, i32 0, i32 0
  store i64 0, ptr %t162, align 8
  call void @lunite_retain(ptr %eptr161)
  %res163 = call ptr @parser_Parser_parse_expression(ptr %self160, ptr %eptr161)
  call void @lunite_retain(ptr %res163)
  store ptr %res163, ptr %expr, align 8
  %eptr164 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t165 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr164, i32 0, i32 0
  store i64 11, ptr %t165, align 8
  %expr166 = load ptr, ptr %expr, align 8
  call void @lunite_retain(ptr %expr166)
  %p = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr164, i32 0, i32 1
  store ptr %expr166, ptr %p, align 8
  call void @lunite_retain(ptr %eptr164)
  %tmp167 = load ptr, ptr %expr, align 8
  call void @lunite_release(ptr %tmp167)
  %tmp168 = load ptr, ptr %k, align 8
  call void @lunite_release(ptr %tmp168)
  %tmp169 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp169)
  ret ptr %eptr164

enum_load13:                                      ; preds = %else
  %ltag15 = getelementptr inbounds { i64, [8 x i8] }, ptr %k6, i32 0, i32 0
  %rtag16 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr7, i32 0, i32 0
  %lt17 = load i64, ptr %ltag15, align 8
  %rt18 = load i64, ptr %rtag16, align 8
  %teq19 = icmp eq i64 %lt17, %rt18
  br label %enum_res14

enum_res14:                                       ; preds = %enum_load13, %else
  %eq20 = phi i1 [ %both_null11, %else ], [ %teq19, %enum_load13 ]
  br i1 %eq20, label %then21, label %else22

then21:                                           ; preds = %enum_res14
  %self24 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self24)
  %res25 = call ptr @parser_Parser_parse_return_statement(ptr %self24)
  call void @lunite_retain(ptr %res25)
  %tmp26 = load ptr, ptr %k, align 8
  call void @lunite_release(ptr %tmp26)
  %tmp27 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp27)
  ret ptr %res25

else22:                                           ; preds = %enum_res14
  %k28 = load ptr, ptr %k, align 8
  %eptr29 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t30 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr29, i32 0, i32 0
  store i64 45, ptr %t30, align 8
  %l_null31 = icmp eq ptr %k28, null
  %r_null32 = icmp eq ptr %eptr29, null
  %both_null33 = and i1 %l_null31, %r_null32
  %either_null34 = or i1 %l_null31, %r_null32
  br i1 %either_null34, label %enum_res36, label %enum_load35

cont23:                                           ; preds = %cont45
  br label %cont

enum_load35:                                      ; preds = %else22
  %ltag37 = getelementptr inbounds { i64, [8 x i8] }, ptr %k28, i32 0, i32 0
  %rtag38 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr29, i32 0, i32 0
  %lt39 = load i64, ptr %ltag37, align 8
  %rt40 = load i64, ptr %rtag38, align 8
  %teq41 = icmp eq i64 %lt39, %rt40
  br label %enum_res36

enum_res36:                                       ; preds = %enum_load35, %else22
  %eq42 = phi i1 [ %both_null33, %else22 ], [ %teq41, %enum_load35 ]
  br i1 %eq42, label %then43, label %else44

then43:                                           ; preds = %enum_res36
  %self46 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self46)
  %res47 = call ptr @parser_Parser_parse_if_statement(ptr %self46)
  call void @lunite_retain(ptr %res47)
  %tmp48 = load ptr, ptr %k, align 8
  call void @lunite_release(ptr %tmp48)
  %tmp49 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp49)
  ret ptr %res47

else44:                                           ; preds = %enum_res36
  %k50 = load ptr, ptr %k, align 8
  %eptr51 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t52 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr51, i32 0, i32 0
  store i64 47, ptr %t52, align 8
  %l_null53 = icmp eq ptr %k50, null
  %r_null54 = icmp eq ptr %eptr51, null
  %both_null55 = and i1 %l_null53, %r_null54
  %either_null56 = or i1 %l_null53, %r_null54
  br i1 %either_null56, label %enum_res58, label %enum_load57

cont45:                                           ; preds = %cont67
  br label %cont23

enum_load57:                                      ; preds = %else44
  %ltag59 = getelementptr inbounds { i64, [8 x i8] }, ptr %k50, i32 0, i32 0
  %rtag60 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr51, i32 0, i32 0
  %lt61 = load i64, ptr %ltag59, align 8
  %rt62 = load i64, ptr %rtag60, align 8
  %teq63 = icmp eq i64 %lt61, %rt62
  br label %enum_res58

enum_res58:                                       ; preds = %enum_load57, %else44
  %eq64 = phi i1 [ %both_null55, %else44 ], [ %teq63, %enum_load57 ]
  br i1 %eq64, label %then65, label %else66

then65:                                           ; preds = %enum_res58
  %self68 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self68)
  %res69 = call ptr @parser_Parser_parse_while_statement(ptr %self68)
  call void @lunite_retain(ptr %res69)
  %tmp70 = load ptr, ptr %k, align 8
  call void @lunite_release(ptr %tmp70)
  %tmp71 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp71)
  ret ptr %res69

else66:                                           ; preds = %enum_res58
  %k72 = load ptr, ptr %k, align 8
  %eptr73 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t74 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr73, i32 0, i32 0
  store i64 48, ptr %t74, align 8
  %l_null75 = icmp eq ptr %k72, null
  %r_null76 = icmp eq ptr %eptr73, null
  %both_null77 = and i1 %l_null75, %r_null76
  %either_null78 = or i1 %l_null75, %r_null76
  br i1 %either_null78, label %enum_res80, label %enum_load79

cont67:                                           ; preds = %cont89
  br label %cont45

enum_load79:                                      ; preds = %else66
  %ltag81 = getelementptr inbounds { i64, [8 x i8] }, ptr %k72, i32 0, i32 0
  %rtag82 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr73, i32 0, i32 0
  %lt83 = load i64, ptr %ltag81, align 8
  %rt84 = load i64, ptr %rtag82, align 8
  %teq85 = icmp eq i64 %lt83, %rt84
  br label %enum_res80

enum_res80:                                       ; preds = %enum_load79, %else66
  %eq86 = phi i1 [ %both_null77, %else66 ], [ %teq85, %enum_load79 ]
  br i1 %eq86, label %then87, label %else88

then87:                                           ; preds = %enum_res80
  %self90 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self90)
  %res91 = call ptr @parser_Parser_parse_for_statement(ptr %self90)
  call void @lunite_retain(ptr %res91)
  %tmp92 = load ptr, ptr %k, align 8
  call void @lunite_release(ptr %tmp92)
  %tmp93 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp93)
  ret ptr %res91

else88:                                           ; preds = %enum_res80
  %k94 = load ptr, ptr %k, align 8
  %eptr95 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t96 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr95, i32 0, i32 0
  store i64 70, ptr %t96, align 8
  %l_null97 = icmp eq ptr %k94, null
  %r_null98 = icmp eq ptr %eptr95, null
  %both_null99 = and i1 %l_null97, %r_null98
  %either_null100 = or i1 %l_null97, %r_null98
  br i1 %either_null100, label %enum_res102, label %enum_load101

cont89:                                           ; preds = %cont111
  br label %cont67

enum_load101:                                     ; preds = %else88
  %ltag103 = getelementptr inbounds { i64, [8 x i8] }, ptr %k94, i32 0, i32 0
  %rtag104 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr95, i32 0, i32 0
  %lt105 = load i64, ptr %ltag103, align 8
  %rt106 = load i64, ptr %rtag104, align 8
  %teq107 = icmp eq i64 %lt105, %rt106
  br label %enum_res102

enum_res102:                                      ; preds = %enum_load101, %else88
  %eq108 = phi i1 [ %both_null99, %else88 ], [ %teq107, %enum_load101 ]
  br i1 %eq108, label %then109, label %else110

then109:                                          ; preds = %enum_res102
  %self112 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self112)
  %res113 = call ptr @parser_Parser_parse_when_statement(ptr %self112)
  call void @lunite_retain(ptr %res113)
  %tmp114 = load ptr, ptr %k, align 8
  call void @lunite_release(ptr %tmp114)
  %tmp115 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp115)
  ret ptr %res113

else110:                                          ; preds = %enum_res102
  %k116 = load ptr, ptr %k, align 8
  %eptr117 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t118 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr117, i32 0, i32 0
  store i64 74, ptr %t118, align 8
  %l_null119 = icmp eq ptr %k116, null
  %r_null120 = icmp eq ptr %eptr117, null
  %both_null121 = and i1 %l_null119, %r_null120
  %either_null122 = or i1 %l_null119, %r_null120
  br i1 %either_null122, label %enum_res124, label %enum_load123

cont111:                                          ; preds = %cont133
  br label %cont89

enum_load123:                                     ; preds = %else110
  %ltag125 = getelementptr inbounds { i64, [8 x i8] }, ptr %k116, i32 0, i32 0
  %rtag126 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr117, i32 0, i32 0
  %lt127 = load i64, ptr %ltag125, align 8
  %rt128 = load i64, ptr %rtag126, align 8
  %teq129 = icmp eq i64 %lt127, %rt128
  br label %enum_res124

enum_res124:                                      ; preds = %enum_load123, %else110
  %eq130 = phi i1 [ %both_null121, %else110 ], [ %teq129, %enum_load123 ]
  br i1 %eq130, label %then131, label %else132

then131:                                          ; preds = %enum_res124
  %self134 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self134)
  %res135 = call ptr @parser_Parser_parse_spawn_statement(ptr %self134)
  call void @lunite_retain(ptr %res135)
  %tmp136 = load ptr, ptr %k, align 8
  call void @lunite_release(ptr %tmp136)
  %tmp137 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp137)
  ret ptr %res135

else132:                                          ; preds = %enum_res124
  %k138 = load ptr, ptr %k, align 8
  %eptr139 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t140 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr139, i32 0, i32 0
  store i64 72, ptr %t140, align 8
  %l_null141 = icmp eq ptr %k138, null
  %r_null142 = icmp eq ptr %eptr139, null
  %both_null143 = and i1 %l_null141, %r_null142
  %either_null144 = or i1 %l_null141, %r_null142
  br i1 %either_null144, label %enum_res146, label %enum_load145

cont133:                                          ; preds = %cont155
  br label %cont111

enum_load145:                                     ; preds = %else132
  %ltag147 = getelementptr inbounds { i64, [8 x i8] }, ptr %k138, i32 0, i32 0
  %rtag148 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr139, i32 0, i32 0
  %lt149 = load i64, ptr %ltag147, align 8
  %rt150 = load i64, ptr %rtag148, align 8
  %teq151 = icmp eq i64 %lt149, %rt150
  br label %enum_res146

enum_res146:                                      ; preds = %enum_load145, %else132
  %eq152 = phi i1 [ %both_null143, %else132 ], [ %teq151, %enum_load145 ]
  br i1 %eq152, label %then153, label %else154

then153:                                          ; preds = %enum_res146
  %self156 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self156)
  %res157 = call ptr @parser_Parser_parse_region_statement(ptr %self156)
  call void @lunite_retain(ptr %res157)
  %tmp158 = load ptr, ptr %k, align 8
  call void @lunite_release(ptr %tmp158)
  %tmp159 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp159)
  ret ptr %res157

else154:                                          ; preds = %enum_res146
  br label %cont155

cont155:                                          ; preds = %else154
  br label %cont133
}

define ptr @parser_Parser_parse_let_statement(ptr %0) {
entry:
  %val = alloca ptr, align 8
  %typ = alloca ptr, align 8
  %s = alloca ptr, align 8
  %name = alloca ptr, align 8
  %is_mut = alloca i1, align 1
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self1)
  call void @parser_Parser_next_token(ptr %self1)
  store i1 false, ptr %is_mut, align 1
  %self2 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self2)
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 69, ptr %t, align 8
  call void @lunite_retain(ptr %eptr)
  %res = call i1 @parser_Parser_cur_is(ptr %self2, ptr %eptr)
  br i1 %res, label %then, label %else

then:                                             ; preds = %body
  store i1 true, ptr %is_mut, align 1
  %self3 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self3)
  call void @parser_Parser_next_token(ptr %self3)
  br label %cont

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else, %then
  %sdata = call ptr @lunite_alloc(i64 0, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.49, i64 0, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p, align 8
  store i64 0, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  store ptr %sstruct, ptr %name, align 8
  %self4 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %parser_Parser, ptr %self4, i32 0, i32 1
  %cur_token = load ptr, ptr %fp, align 8
  %fp5 = getelementptr inbounds %token_Token, ptr %cur_token, i32 0, i32 0
  %kind = load ptr, ptr %fp5, align 8
  %tptr = getelementptr inbounds { i64, [8 x i8] }, ptr %kind, i32 0, i32 0
  %tag = load i64, ptr %tptr, align 8
  %match = icmp eq i64 %tag, 2
  br i1 %match, label %when_body, label %when_next

when_end:                                         ; preds = %when_next7, %when_body8, %when_body
  %self13 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self13)
  call void @parser_Parser_next_token(ptr %self13)
  %eptr14 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t15 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr14, i32 0, i32 0
  store i64 1, ptr %t15, align 8
  call void @lunite_retain(ptr %eptr14)
  store ptr %eptr14, ptr %typ, align 8
  %self16 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self16)
  %eptr17 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t18 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr17, i32 0, i32 0
  store i64 33, ptr %t18, align 8
  call void @lunite_retain(ptr %eptr17)
  %res19 = call i1 @parser_Parser_cur_is(ptr %self16, ptr %eptr17)
  br i1 %res19, label %then20, label %else21

when_next:                                        ; preds = %cont
  br label %when_body8

when_body:                                        ; preds = %cont
  %pptr = getelementptr inbounds { i64, [8 x i8] }, ptr %kind, i32 0, i32 1
  %pval = load ptr, ptr %pptr, align 8
  call void @lunite_retain(ptr %pval)
  store ptr %pval, ptr %s, align 8
  %s6 = load ptr, ptr %s, align 8
  %old = load ptr, ptr %name, align 8
  call void @lunite_retain(ptr %s6)
  store ptr %s6, ptr %name, align 8
  call void @lunite_release(ptr %old)
  %tmp = load ptr, ptr %s, align 8
  call void @lunite_release(ptr %tmp)
  br label %when_end

when_next7:                                       ; No predecessors!
  br label %when_end

when_body8:                                       ; preds = %when_next
  %sdata9 = call ptr @lunite_alloc(i64 43, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata9, ptr align 1 @slit.50, i64 43, i1 false)
  %sstruct10 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p11 = getelementptr inbounds { ptr, i64 }, ptr %sstruct10, i32 0, i32 0
  %l12 = getelementptr inbounds { ptr, i64 }, ptr %sstruct10, i32 0, i32 1
  store ptr %sdata9, ptr %p11, align 8
  store i64 43, ptr %l12, align 8
  call void @lunite_retain(ptr %sstruct10)
  call void @string_print(ptr %sstruct10)
  br label %when_end

then20:                                           ; preds = %when_end
  %self23 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self23)
  call void @parser_Parser_next_token(ptr %self23)
  %eptr24 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t25 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr24, i32 0, i32 0
  store i64 0, ptr %t25, align 8
  %self26 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self26)
  %res27 = call ptr @parser_Parser_parse_type(ptr %self26)
  call void @lunite_retain(ptr %res27)
  %p28 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr24, i32 0, i32 1
  store ptr %res27, ptr %p28, align 8
  %old29 = load ptr, ptr %typ, align 8
  call void @lunite_retain(ptr %eptr24)
  store ptr %eptr24, ptr %typ, align 8
  call void @lunite_release(ptr %old29)
  br label %cont22

else21:                                           ; preds = %when_end
  br label %cont22

cont22:                                           ; preds = %else21, %then20
  %eptr30 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t31 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr30, i32 0, i32 0
  store i64 1, ptr %t31, align 8
  call void @lunite_retain(ptr %eptr30)
  store ptr %eptr30, ptr %val, align 8
  %self32 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self32)
  %eptr33 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t34 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr33, i32 0, i32 0
  store i64 11, ptr %t34, align 8
  call void @lunite_retain(ptr %eptr33)
  %res35 = call i1 @parser_Parser_cur_is(ptr %self32, ptr %eptr33)
  br i1 %res35, label %then36, label %else37

then36:                                           ; preds = %cont22
  %self39 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self39)
  call void @parser_Parser_next_token(ptr %self39)
  %eptr40 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t41 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr40, i32 0, i32 0
  store i64 0, ptr %t41, align 8
  %self42 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self42)
  %eptr43 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t44 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr43, i32 0, i32 0
  store i64 0, ptr %t44, align 8
  call void @lunite_retain(ptr %eptr43)
  %res45 = call ptr @parser_Parser_parse_expression(ptr %self42, ptr %eptr43)
  call void @lunite_retain(ptr %res45)
  %p46 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr40, i32 0, i32 1
  store ptr %res45, ptr %p46, align 8
  %old47 = load ptr, ptr %val, align 8
  call void @lunite_retain(ptr %eptr40)
  store ptr %eptr40, ptr %val, align 8
  call void @lunite_release(ptr %old47)
  br label %cont38

else37:                                           ; preds = %cont22
  br label %cont38

cont38:                                           ; preds = %else37, %then36
  %eptr48 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t49 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr48, i32 0, i32 0
  store i64 0, ptr %t49, align 8
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%ast_LetStatementPayload, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp50 = getelementptr inbounds %ast_LetStatementPayload, ptr %ptr, i32 0, i32 0
  %name51 = load ptr, ptr %name, align 8
  call void @lunite_retain(ptr %name51)
  store ptr %name51, ptr %fp50, align 8
  %fp52 = getelementptr inbounds %ast_LetStatementPayload, ptr %ptr, i32 0, i32 1
  %is_mut53 = load i1, ptr %is_mut, align 1
  store i1 %is_mut53, ptr %fp52, align 1
  %fp54 = getelementptr inbounds %ast_LetStatementPayload, ptr %ptr, i32 0, i32 2
  %typ55 = load ptr, ptr %typ, align 8
  call void @lunite_retain(ptr %typ55)
  store ptr %typ55, ptr %fp54, align 8
  %fp56 = getelementptr inbounds %ast_LetStatementPayload, ptr %ptr, i32 0, i32 3
  %val57 = load ptr, ptr %val, align 8
  call void @lunite_retain(ptr %val57)
  store ptr %val57, ptr %fp56, align 8
  call void @lunite_retain(ptr %ptr)
  %p58 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr48, i32 0, i32 1
  store ptr %ptr, ptr %p58, align 8
  call void @lunite_retain(ptr %eptr48)
  %tmp59 = load ptr, ptr %val, align 8
  call void @lunite_release(ptr %tmp59)
  %tmp60 = load ptr, ptr %typ, align 8
  call void @lunite_release(ptr %tmp60)
  %tmp61 = load ptr, ptr %name, align 8
  call void @lunite_release(ptr %tmp61)
  %tmp62 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp62)
  ret ptr %eptr48
}

define ptr @parser_Parser_parse_return_statement(ptr %0) {
entry:
  %val = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self1)
  call void @parser_Parser_next_token(ptr %self1)
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 1, ptr %t, align 8
  call void @lunite_retain(ptr %eptr)
  store ptr %eptr, ptr %val, align 8
  %self2 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self2)
  %eptr3 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t4 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr3, i32 0, i32 0
  store i64 40, ptr %t4, align 8
  call void @lunite_retain(ptr %eptr3)
  %res = call i1 @parser_Parser_cur_is(ptr %self2, ptr %eptr3)
  %not = xor i1 %res, true
  %self5 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self5)
  %eptr6 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t7 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr6, i32 0, i32 0
  store i64 41, ptr %t7, align 8
  call void @lunite_retain(ptr %eptr6)
  %res8 = call i1 @parser_Parser_cur_is(ptr %self5, ptr %eptr6)
  %not9 = xor i1 %res8, true
  %1 = and i1 %not, %not9
  %self10 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self10)
  %eptr11 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t12 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr11, i32 0, i32 0
  store i64 30, ptr %t12, align 8
  call void @lunite_retain(ptr %eptr11)
  %res13 = call i1 @parser_Parser_cur_is(ptr %self10, ptr %eptr11)
  %not14 = xor i1 %res13, true
  %2 = and i1 %1, %not14
  br i1 %2, label %then, label %else

then:                                             ; preds = %body
  %eptr15 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t16 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr15, i32 0, i32 0
  store i64 0, ptr %t16, align 8
  %self17 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self17)
  %eptr18 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t19 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr18, i32 0, i32 0
  store i64 0, ptr %t19, align 8
  call void @lunite_retain(ptr %eptr18)
  %res20 = call ptr @parser_Parser_parse_expression(ptr %self17, ptr %eptr18)
  call void @lunite_retain(ptr %res20)
  %p = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr15, i32 0, i32 1
  store ptr %res20, ptr %p, align 8
  %old = load ptr, ptr %val, align 8
  call void @lunite_retain(ptr %eptr15)
  store ptr %eptr15, ptr %val, align 8
  call void @lunite_release(ptr %old)
  br label %cont

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else, %then
  %eptr21 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t22 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr21, i32 0, i32 0
  store i64 2, ptr %t22, align 8
  %val23 = load ptr, ptr %val, align 8
  call void @lunite_retain(ptr %val23)
  %p24 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr21, i32 0, i32 1
  store ptr %val23, ptr %p24, align 8
  call void @lunite_retain(ptr %eptr21)
  %tmp = load ptr, ptr %val, align 8
  call void @lunite_release(ptr %tmp)
  %tmp25 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp25)
  ret ptr %eptr21
}

define ptr @parser_Parser_parse_if_statement(ptr %0) {
entry:
  %else_branch = alloca ptr, align 8
  %then_branch = alloca ptr, align 8
  %condition = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self1)
  call void @parser_Parser_next_token(ptr %self1)
  %self2 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self2)
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 0, ptr %t, align 8
  call void @lunite_retain(ptr %eptr)
  %res = call ptr @parser_Parser_parse_expression(ptr %self2, ptr %eptr)
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %condition, align 8
  %self3 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self3)
  %res4 = call ptr @parser_Parser_parse_block(ptr %self3)
  call void @lunite_retain(ptr %res4)
  store ptr %res4, ptr %then_branch, align 8
  %eptr5 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t6 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr5, i32 0, i32 0
  store i64 1, ptr %t6, align 8
  call void @lunite_retain(ptr %eptr5)
  store ptr %eptr5, ptr %else_branch, align 8
  %self7 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self7)
  %eptr8 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t9 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr8, i32 0, i32 0
  store i64 46, ptr %t9, align 8
  call void @lunite_retain(ptr %eptr8)
  %res10 = call i1 @parser_Parser_cur_is(ptr %self7, ptr %eptr8)
  br i1 %res10, label %then, label %else

then:                                             ; preds = %body
  %self11 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self11)
  call void @parser_Parser_next_token(ptr %self11)
  %eptr12 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t13 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr12, i32 0, i32 0
  store i64 0, ptr %t13, align 8
  %self14 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self14)
  %res15 = call ptr @parser_Parser_parse_block(ptr %self14)
  call void @lunite_retain(ptr %res15)
  %p = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr12, i32 0, i32 1
  store ptr %res15, ptr %p, align 8
  %old = load ptr, ptr %else_branch, align 8
  call void @lunite_retain(ptr %eptr12)
  store ptr %eptr12, ptr %else_branch, align 8
  call void @lunite_release(ptr %old)
  br label %cont

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else, %then
  %eptr16 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t17 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr16, i32 0, i32 0
  store i64 3, ptr %t17, align 8
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%ast_IfStatementPayload, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %ast_IfStatementPayload, ptr %ptr, i32 0, i32 0
  %condition18 = load ptr, ptr %condition, align 8
  call void @lunite_retain(ptr %condition18)
  store ptr %condition18, ptr %fp, align 8
  %fp19 = getelementptr inbounds %ast_IfStatementPayload, ptr %ptr, i32 0, i32 1
  %then_branch20 = load ptr, ptr %then_branch, align 8
  call void @lunite_retain(ptr %then_branch20)
  store ptr %then_branch20, ptr %fp19, align 8
  %fp21 = getelementptr inbounds %ast_IfStatementPayload, ptr %ptr, i32 0, i32 2
  %else_branch22 = load ptr, ptr %else_branch, align 8
  call void @lunite_retain(ptr %else_branch22)
  store ptr %else_branch22, ptr %fp21, align 8
  call void @lunite_retain(ptr %ptr)
  %p23 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr16, i32 0, i32 1
  store ptr %ptr, ptr %p23, align 8
  call void @lunite_retain(ptr %eptr16)
  %tmp = load ptr, ptr %else_branch, align 8
  call void @lunite_release(ptr %tmp)
  %tmp24 = load ptr, ptr %then_branch, align 8
  call void @lunite_release(ptr %tmp24)
  %tmp25 = load ptr, ptr %condition, align 8
  call void @lunite_release(ptr %tmp25)
  %tmp26 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp26)
  ret ptr %eptr16
}

define ptr @parser_Parser_parse_while_statement(ptr %0) {
entry:
  %body5 = alloca ptr, align 8
  %cond = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self1)
  call void @parser_Parser_next_token(ptr %self1)
  %self2 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self2)
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 0, ptr %t, align 8
  call void @lunite_retain(ptr %eptr)
  %res = call ptr @parser_Parser_parse_expression(ptr %self2, ptr %eptr)
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %cond, align 8
  %self3 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self3)
  %res4 = call ptr @parser_Parser_parse_block(ptr %self3)
  call void @lunite_retain(ptr %res4)
  store ptr %res4, ptr %body5, align 8
  %eptr6 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t7 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr6, i32 0, i32 0
  store i64 4, ptr %t7, align 8
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%ast_WhileStatementPayload, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %ast_WhileStatementPayload, ptr %ptr, i32 0, i32 0
  %cond8 = load ptr, ptr %cond, align 8
  call void @lunite_retain(ptr %cond8)
  store ptr %cond8, ptr %fp, align 8
  %fp9 = getelementptr inbounds %ast_WhileStatementPayload, ptr %ptr, i32 0, i32 1
  %body10 = load ptr, ptr %body5, align 8
  call void @lunite_retain(ptr %body10)
  store ptr %body10, ptr %fp9, align 8
  call void @lunite_retain(ptr %ptr)
  %p = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr6, i32 0, i32 1
  store ptr %ptr, ptr %p, align 8
  call void @lunite_retain(ptr %eptr6)
  %tmp = load ptr, ptr %body5, align 8
  call void @lunite_release(ptr %tmp)
  %tmp11 = load ptr, ptr %cond, align 8
  call void @lunite_release(ptr %tmp11)
  %tmp12 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp12)
  ret ptr %eptr6
}

define ptr @parser_Parser_parse_for_statement(ptr %0) {
entry:
  %body37 = alloca ptr, align 8
  %end = alloca ptr, align 8
  %start = alloca ptr, align 8
  %s = alloca ptr, align 8
  %var_name = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self1)
  call void @parser_Parser_next_token(ptr %self1)
  %sdata = call ptr @lunite_alloc(i64 0, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.51, i64 0, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p, align 8
  store i64 0, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  store ptr %sstruct, ptr %var_name, align 8
  %self2 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %parser_Parser, ptr %self2, i32 0, i32 1
  %cur_token = load ptr, ptr %fp, align 8
  %fp3 = getelementptr inbounds %token_Token, ptr %cur_token, i32 0, i32 0
  %kind = load ptr, ptr %fp3, align 8
  %tptr = getelementptr inbounds { i64, [8 x i8] }, ptr %kind, i32 0, i32 0
  %tag = load i64, ptr %tptr, align 8
  %match = icmp eq i64 %tag, 2
  br i1 %match, label %when_body, label %when_next

when_end:                                         ; preds = %when_next5, %when_body6, %when_body
  %self11 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self11)
  call void @parser_Parser_next_token(ptr %self11)
  %self12 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self12)
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 49, ptr %t, align 8
  call void @lunite_retain(ptr %eptr)
  %res = call i1 @parser_Parser_cur_is(ptr %self12, ptr %eptr)
  %not = xor i1 %res, true
  br i1 %not, label %then, label %else

when_next:                                        ; preds = %body
  br label %when_body6

when_body:                                        ; preds = %body
  %pptr = getelementptr inbounds { i64, [8 x i8] }, ptr %kind, i32 0, i32 1
  %pval = load ptr, ptr %pptr, align 8
  call void @lunite_retain(ptr %pval)
  store ptr %pval, ptr %s, align 8
  %s4 = load ptr, ptr %s, align 8
  %old = load ptr, ptr %var_name, align 8
  call void @lunite_retain(ptr %s4)
  store ptr %s4, ptr %var_name, align 8
  call void @lunite_release(ptr %old)
  %tmp = load ptr, ptr %s, align 8
  call void @lunite_release(ptr %tmp)
  br label %when_end

when_next5:                                       ; No predecessors!
  br label %when_end

when_body6:                                       ; preds = %when_next
  %sdata7 = call ptr @lunite_alloc(i64 41, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata7, ptr align 1 @slit.52, i64 41, i1 false)
  %sstruct8 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p9 = getelementptr inbounds { ptr, i64 }, ptr %sstruct8, i32 0, i32 0
  %l10 = getelementptr inbounds { ptr, i64 }, ptr %sstruct8, i32 0, i32 1
  store ptr %sdata7, ptr %p9, align 8
  store i64 41, ptr %l10, align 8
  call void @lunite_retain(ptr %sstruct8)
  call void @string_print(ptr %sstruct8)
  br label %when_end

then:                                             ; preds = %when_end
  %sdata13 = call ptr @lunite_alloc(i64 32, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata13, ptr align 1 @slit.53, i64 32, i1 false)
  %sstruct14 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p15 = getelementptr inbounds { ptr, i64 }, ptr %sstruct14, i32 0, i32 0
  %l16 = getelementptr inbounds { ptr, i64 }, ptr %sstruct14, i32 0, i32 1
  store ptr %sdata13, ptr %p15, align 8
  store i64 32, ptr %l16, align 8
  call void @lunite_retain(ptr %sstruct14)
  call void @string_print(ptr %sstruct14)
  br label %cont

else:                                             ; preds = %when_end
  br label %cont

cont:                                             ; preds = %else, %then
  %self17 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self17)
  call void @parser_Parser_next_token(ptr %self17)
  %self18 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self18)
  %eptr19 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t20 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr19, i32 0, i32 0
  store i64 0, ptr %t20, align 8
  call void @lunite_retain(ptr %eptr19)
  %res21 = call ptr @parser_Parser_parse_expression(ptr %self18, ptr %eptr19)
  call void @lunite_retain(ptr %res21)
  store ptr %res21, ptr %start, align 8
  %self22 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self22)
  %eptr23 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t24 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr23, i32 0, i32 0
  store i64 37, ptr %t24, align 8
  call void @lunite_retain(ptr %eptr23)
  %res25 = call i1 @parser_Parser_cur_is(ptr %self22, ptr %eptr23)
  %not26 = xor i1 %res25, true
  br i1 %not26, label %then27, label %else28

then27:                                           ; preds = %cont
  br label %cont29

else28:                                           ; preds = %cont
  br label %cont29

cont29:                                           ; preds = %else28, %then27
  %self30 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self30)
  call void @parser_Parser_next_token(ptr %self30)
  %self31 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self31)
  %eptr32 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t33 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr32, i32 0, i32 0
  store i64 0, ptr %t33, align 8
  call void @lunite_retain(ptr %eptr32)
  %res34 = call ptr @parser_Parser_parse_expression(ptr %self31, ptr %eptr32)
  call void @lunite_retain(ptr %res34)
  store ptr %res34, ptr %end, align 8
  %self35 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self35)
  %res36 = call ptr @parser_Parser_parse_block(ptr %self35)
  call void @lunite_retain(ptr %res36)
  store ptr %res36, ptr %body37, align 8
  %eptr38 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t39 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr38, i32 0, i32 0
  store i64 7, ptr %t39, align 8
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%ast_ForStatementPayload, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp40 = getelementptr inbounds %ast_ForStatementPayload, ptr %ptr, i32 0, i32 0
  %var_name41 = load ptr, ptr %var_name, align 8
  call void @lunite_retain(ptr %var_name41)
  store ptr %var_name41, ptr %fp40, align 8
  %fp42 = getelementptr inbounds %ast_ForStatementPayload, ptr %ptr, i32 0, i32 1
  %start43 = load ptr, ptr %start, align 8
  call void @lunite_retain(ptr %start43)
  store ptr %start43, ptr %fp42, align 8
  %fp44 = getelementptr inbounds %ast_ForStatementPayload, ptr %ptr, i32 0, i32 2
  %end45 = load ptr, ptr %end, align 8
  call void @lunite_retain(ptr %end45)
  store ptr %end45, ptr %fp44, align 8
  %fp46 = getelementptr inbounds %ast_ForStatementPayload, ptr %ptr, i32 0, i32 3
  %body47 = load ptr, ptr %body37, align 8
  call void @lunite_retain(ptr %body47)
  store ptr %body47, ptr %fp46, align 8
  call void @lunite_retain(ptr %ptr)
  %p48 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr38, i32 0, i32 1
  store ptr %ptr, ptr %p48, align 8
  call void @lunite_retain(ptr %eptr38)
  %tmp49 = load ptr, ptr %body37, align 8
  call void @lunite_release(ptr %tmp49)
  %tmp50 = load ptr, ptr %end, align 8
  call void @lunite_release(ptr %tmp50)
  %tmp51 = load ptr, ptr %start, align 8
  call void @lunite_release(ptr %tmp51)
  %tmp52 = load ptr, ptr %var_name, align 8
  call void @lunite_release(ptr %tmp52)
  %tmp53 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp53)
  ret ptr %eptr38
}

define ptr @parser_Parser_parse_when_statement(ptr %0) {
entry:
  %expr = alloca ptr, align 8
  %body70 = alloca ptr, align 8
  %pattern = alloca ptr, align 8
  %arms = alloca ptr, align 8
  %subject = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self1)
  call void @parser_Parser_next_token(ptr %self1)
  %self2 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self2)
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 27, ptr %t, align 8
  call void @lunite_retain(ptr %eptr)
  %res = call i1 @parser_Parser_cur_is(ptr %self2, ptr %eptr)
  %not = xor i1 %res, true
  br i1 %not, label %then, label %else

then:                                             ; preds = %body
  %sdata = call ptr @lunite_alloc(i64 30, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.54, i64 30, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p, align 8
  store i64 30, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  call void @string_print(ptr %sstruct)
  br label %cont

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else, %then
  %self3 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self3)
  call void @parser_Parser_next_token(ptr %self3)
  %self4 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self4)
  %eptr5 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t6 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr5, i32 0, i32 0
  store i64 0, ptr %t6, align 8
  call void @lunite_retain(ptr %eptr5)
  %res7 = call ptr @parser_Parser_parse_expression(ptr %self4, ptr %eptr5)
  call void @lunite_retain(ptr %res7)
  store ptr %res7, ptr %subject, align 8
  %self8 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self8)
  %eptr9 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t10 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr9, i32 0, i32 0
  store i64 28, ptr %t10, align 8
  call void @lunite_retain(ptr %eptr9)
  %res11 = call i1 @parser_Parser_cur_is(ptr %self8, ptr %eptr9)
  %not12 = xor i1 %res11, true
  br i1 %not12, label %then13, label %else14

then13:                                           ; preds = %cont
  %sdata16 = call ptr @lunite_alloc(i64 38, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata16, ptr align 1 @slit.55, i64 38, i1 false)
  %sstruct17 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p18 = getelementptr inbounds { ptr, i64 }, ptr %sstruct17, i32 0, i32 0
  %l19 = getelementptr inbounds { ptr, i64 }, ptr %sstruct17, i32 0, i32 1
  store ptr %sdata16, ptr %p18, align 8
  store i64 38, ptr %l19, align 8
  call void @lunite_retain(ptr %sstruct17)
  call void @string_print(ptr %sstruct17)
  br label %cont15

else14:                                           ; preds = %cont
  br label %cont15

cont15:                                           ; preds = %else14, %then13
  %self20 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self20)
  call void @parser_Parser_next_token(ptr %self20)
  %self21 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self21)
  call void @parser_Parser_skip_newlines(ptr %self21)
  %self22 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self22)
  %eptr23 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t24 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr23, i32 0, i32 0
  store i64 29, ptr %t24, align 8
  call void @lunite_retain(ptr %eptr23)
  %res25 = call i1 @parser_Parser_cur_is(ptr %self22, ptr %eptr23)
  %not26 = xor i1 %res25, true
  br i1 %not26, label %then27, label %else28

then27:                                           ; preds = %cont15
  %sdata30 = call ptr @lunite_alloc(i64 30, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata30, ptr align 1 @slit.56, i64 30, i1 false)
  %sstruct31 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p32 = getelementptr inbounds { ptr, i64 }, ptr %sstruct31, i32 0, i32 0
  %l33 = getelementptr inbounds { ptr, i64 }, ptr %sstruct31, i32 0, i32 1
  store ptr %sdata30, ptr %p32, align 8
  store i64 30, ptr %l33, align 8
  call void @lunite_retain(ptr %sstruct31)
  call void @string_print(ptr %sstruct31)
  br label %cont29

else28:                                           ; preds = %cont15
  br label %cont29

cont29:                                           ; preds = %else28, %then27
  %self34 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self34)
  call void @parser_Parser_next_token(ptr %self34)
  %res35 = call ptr @list_List_ast_WhenArm__new()
  call void @lunite_retain(ptr %res35)
  store ptr %res35, ptr %arms, align 8
  br label %while_cond

while_cond:                                       ; preds = %cont102, %cont29
  %self36 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self36)
  %eptr37 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t38 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr37, i32 0, i32 0
  store i64 30, ptr %t38, align 8
  call void @lunite_retain(ptr %eptr37)
  %res39 = call i1 @parser_Parser_cur_is(ptr %self36, ptr %eptr37)
  %not40 = xor i1 %res39, true
  %self41 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self41)
  %eptr42 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t43 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr42, i32 0, i32 0
  store i64 1, ptr %t43, align 8
  call void @lunite_retain(ptr %eptr42)
  %res44 = call i1 @parser_Parser_cur_is(ptr %self41, ptr %eptr42)
  %not45 = xor i1 %res44, true
  %1 = and i1 %not40, %not45
  br i1 %1, label %while_body, label %while_end

while_body:                                       ; preds = %while_cond
  %self46 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self46)
  call void @parser_Parser_skip_newlines(ptr %self46)
  %self47 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self47)
  %eptr48 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t49 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr48, i32 0, i32 0
  store i64 30, ptr %t49, align 8
  call void @lunite_retain(ptr %eptr48)
  %res50 = call i1 @parser_Parser_cur_is(ptr %self47, ptr %eptr48)
  br i1 %res50, label %then51, label %else52

while_end:                                        ; preds = %then51, %while_cond
  %self107 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self107)
  call void @parser_Parser_next_token(ptr %self107)
  %eptr108 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t109 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr108, i32 0, i32 0
  store i64 8, ptr %t109, align 8
  %ptr110 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%ast_WhenStatementPayload, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp111 = getelementptr inbounds %ast_WhenStatementPayload, ptr %ptr110, i32 0, i32 0
  %subject112 = load ptr, ptr %subject, align 8
  call void @lunite_retain(ptr %subject112)
  store ptr %subject112, ptr %fp111, align 8
  %fp113 = getelementptr inbounds %ast_WhenStatementPayload, ptr %ptr110, i32 0, i32 1
  %arms114 = load ptr, ptr %arms, align 8
  call void @lunite_retain(ptr %arms114)
  store ptr %arms114, ptr %fp113, align 8
  call void @lunite_retain(ptr %ptr110)
  %p115 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr108, i32 0, i32 1
  store ptr %ptr110, ptr %p115, align 8
  call void @lunite_retain(ptr %eptr108)
  %tmp116 = load ptr, ptr %arms, align 8
  call void @lunite_release(ptr %tmp116)
  %tmp117 = load ptr, ptr %subject, align 8
  call void @lunite_release(ptr %tmp117)
  %tmp118 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp118)
  ret ptr %eptr108

then51:                                           ; preds = %while_body
  br label %while_end

else52:                                           ; preds = %while_body
  br label %cont53

cont53:                                           ; preds = %else52
  %self54 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self54)
  %res55 = call ptr @parser_Parser_parse_when_pattern(ptr %self54)
  call void @lunite_retain(ptr %res55)
  store ptr %res55, ptr %pattern, align 8
  %self56 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self56)
  %eptr57 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t58 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr57, i32 0, i32 0
  store i64 39, ptr %t58, align 8
  call void @lunite_retain(ptr %eptr57)
  %res59 = call i1 @parser_Parser_cur_is(ptr %self56, ptr %eptr57)
  %not60 = xor i1 %res59, true
  br i1 %not60, label %then61, label %else62

then61:                                           ; preds = %cont53
  %sdata64 = call ptr @lunite_alloc(i64 34, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata64, ptr align 1 @slit.57, i64 34, i1 false)
  %sstruct65 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p66 = getelementptr inbounds { ptr, i64 }, ptr %sstruct65, i32 0, i32 0
  %l67 = getelementptr inbounds { ptr, i64 }, ptr %sstruct65, i32 0, i32 1
  store ptr %sdata64, ptr %p66, align 8
  store i64 34, ptr %l67, align 8
  call void @lunite_retain(ptr %sstruct65)
  call void @string_print(ptr %sstruct65)
  br label %cont63

else62:                                           ; preds = %cont53
  br label %cont63

cont63:                                           ; preds = %else62, %then61
  %self68 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self68)
  call void @parser_Parser_next_token(ptr %self68)
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%ast_Block, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %ast_Block, ptr %ptr, i32 0, i32 0
  %res69 = call ptr @list_List_ast_Statement__new()
  call void @lunite_retain(ptr %res69)
  store ptr %res69, ptr %fp, align 8
  call void @lunite_retain(ptr %ptr)
  store ptr %ptr, ptr %body70, align 8
  %self71 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self71)
  %eptr72 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t73 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr72, i32 0, i32 0
  store i64 29, ptr %t73, align 8
  call void @lunite_retain(ptr %eptr72)
  %res74 = call i1 @parser_Parser_cur_is(ptr %self71, ptr %eptr72)
  br i1 %res74, label %then75, label %else76

then75:                                           ; preds = %cont63
  %self78 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self78)
  %res79 = call ptr @parser_Parser_parse_block(ptr %self78)
  %old = load ptr, ptr %body70, align 8
  call void @lunite_retain(ptr %res79)
  store ptr %res79, ptr %body70, align 8
  call void @lunite_release(ptr %old)
  br label %cont77

else76:                                           ; preds = %cont63
  %self80 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self80)
  %eptr81 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t82 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr81, i32 0, i32 0
  store i64 0, ptr %t82, align 8
  call void @lunite_retain(ptr %eptr81)
  %res83 = call ptr @parser_Parser_parse_expression(ptr %self80, ptr %eptr81)
  call void @lunite_retain(ptr %res83)
  store ptr %res83, ptr %expr, align 8
  %body84 = load ptr, ptr %body70, align 8
  %fp85 = getelementptr inbounds %ast_Block, ptr %body84, i32 0, i32 0
  %statements = load ptr, ptr %fp85, align 8
  call void @lunite_retain(ptr %statements)
  %eptr86 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t87 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr86, i32 0, i32 0
  store i64 11, ptr %t87, align 8
  %expr88 = load ptr, ptr %expr, align 8
  call void @lunite_retain(ptr %expr88)
  %p89 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr86, i32 0, i32 1
  store ptr %expr88, ptr %p89, align 8
  call void @lunite_retain(ptr %eptr86)
  call void @list_List_ast_Statement__push(ptr %statements, ptr %eptr86)
  %tmp = load ptr, ptr %expr, align 8
  call void @lunite_release(ptr %tmp)
  br label %cont77

cont77:                                           ; preds = %else76, %then75
  %arms90 = load ptr, ptr %arms, align 8
  call void @lunite_retain(ptr %arms90)
  %ptr91 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%ast_WhenArm, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp92 = getelementptr inbounds %ast_WhenArm, ptr %ptr91, i32 0, i32 0
  %pattern93 = load ptr, ptr %pattern, align 8
  call void @lunite_retain(ptr %pattern93)
  store ptr %pattern93, ptr %fp92, align 8
  %fp94 = getelementptr inbounds %ast_WhenArm, ptr %ptr91, i32 0, i32 1
  %body95 = load ptr, ptr %body70, align 8
  call void @lunite_retain(ptr %body95)
  store ptr %body95, ptr %fp94, align 8
  call void @lunite_retain(ptr %ptr91)
  call void @list_List_ast_WhenArm__push(ptr %arms90, ptr %ptr91)
  %self96 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self96)
  %eptr97 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t98 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr97, i32 0, i32 0
  store i64 35, ptr %t98, align 8
  call void @lunite_retain(ptr %eptr97)
  %res99 = call i1 @parser_Parser_cur_is(ptr %self96, ptr %eptr97)
  br i1 %res99, label %then100, label %else101

then100:                                          ; preds = %cont77
  %self103 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self103)
  call void @parser_Parser_next_token(ptr %self103)
  br label %cont102

else101:                                          ; preds = %cont77
  br label %cont102

cont102:                                          ; preds = %else101, %then100
  %self104 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self104)
  call void @parser_Parser_skip_newlines(ptr %self104)
  %tmp105 = load ptr, ptr %body70, align 8
  call void @lunite_release(ptr %tmp105)
  %tmp106 = load ptr, ptr %pattern, align 8
  call void @lunite_release(ptr %tmp106)
  br label %while_cond
}

define ptr @parser_Parser_parse_when_pattern(ptr %0) {
entry:
  %expr = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self1)
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 46, ptr %t, align 8
  call void @lunite_retain(ptr %eptr)
  %res = call i1 @parser_Parser_cur_is(ptr %self1, ptr %eptr)
  br i1 %res, label %then, label %else

then:                                             ; preds = %body
  %self2 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self2)
  call void @parser_Parser_next_token(ptr %self2)
  %eptr3 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t4 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr3, i32 0, i32 0
  store i64 3, ptr %t4, align 8
  call void @lunite_retain(ptr %eptr3)
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %eptr3

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else
  %self5 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self5)
  %eptr6 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t7 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr6, i32 0, i32 0
  store i64 0, ptr %t7, align 8
  call void @lunite_retain(ptr %eptr6)
  %res8 = call ptr @parser_Parser_parse_expression(ptr %self5, ptr %eptr6)
  call void @lunite_retain(ptr %res8)
  store ptr %res8, ptr %expr, align 8
  %eptr9 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t10 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr9, i32 0, i32 0
  store i64 0, ptr %t10, align 8
  %expr11 = load ptr, ptr %expr, align 8
  call void @lunite_retain(ptr %expr11)
  %p = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr9, i32 0, i32 1
  store ptr %expr11, ptr %p, align 8
  call void @lunite_retain(ptr %eptr9)
  %tmp12 = load ptr, ptr %expr, align 8
  call void @lunite_release(ptr %tmp12)
  %tmp13 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp13)
  ret ptr %eptr9
}

define ptr @parser_Parser_parse_spawn_statement(ptr %0) {
entry:
  %expr = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self1)
  call void @parser_Parser_next_token(ptr %self1)
  %self2 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self2)
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 0, ptr %t, align 8
  call void @lunite_retain(ptr %eptr)
  %res = call ptr @parser_Parser_parse_expression(ptr %self2, ptr %eptr)
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %expr, align 8
  %eptr3 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t4 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr3, i32 0, i32 0
  store i64 6, ptr %t4, align 8
  %expr5 = load ptr, ptr %expr, align 8
  call void @lunite_retain(ptr %expr5)
  %p = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr3, i32 0, i32 1
  store ptr %expr5, ptr %p, align 8
  call void @lunite_retain(ptr %eptr3)
  %tmp = load ptr, ptr %expr, align 8
  call void @lunite_release(ptr %tmp)
  %tmp6 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp6)
  ret ptr %eptr3
}

define ptr @parser_Parser_parse_region_statement(ptr %0) {
entry:
  %body3 = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self1)
  call void @parser_Parser_next_token(ptr %self1)
  %self2 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self2)
  %res = call ptr @parser_Parser_parse_block(ptr %self2)
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %body3, align 8
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 5, ptr %t, align 8
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%ast_RegionStatementPayload, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %ast_RegionStatementPayload, ptr %ptr, i32 0, i32 0
  %body4 = load ptr, ptr %body3, align 8
  call void @lunite_retain(ptr %body4)
  store ptr %body4, ptr %fp, align 8
  call void @lunite_retain(ptr %ptr)
  %p = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 1
  store ptr %ptr, ptr %p, align 8
  call void @lunite_retain(ptr %eptr)
  %tmp = load ptr, ptr %body3, align 8
  call void @lunite_release(ptr %tmp)
  %tmp5 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp5)
  ret ptr %eptr
}

define ptr @parser_Parser_parse_import_item(ptr %0) {
entry:
  %s29 = alloca ptr, align 8
  %alias = alloca ptr, align 8
  %s = alloca ptr, align 8
  %path = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self1)
  call void @parser_Parser_next_token(ptr %self1)
  %sdata = call ptr @lunite_alloc(i64 0, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.58, i64 0, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p, align 8
  store i64 0, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  store ptr %sstruct, ptr %path, align 8
  %self2 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %parser_Parser, ptr %self2, i32 0, i32 1
  %cur_token = load ptr, ptr %fp, align 8
  %fp3 = getelementptr inbounds %token_Token, ptr %cur_token, i32 0, i32 0
  %kind = load ptr, ptr %fp3, align 8
  %tptr = getelementptr inbounds { i64, [8 x i8] }, ptr %kind, i32 0, i32 0
  %tag = load i64, ptr %tptr, align 8
  %match = icmp eq i64 %tag, 5
  br i1 %match, label %when_body, label %when_next

when_end:                                         ; preds = %when_next5, %when_body6, %when_body
  %self11 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self11)
  call void @parser_Parser_next_token(ptr %self11)
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 1, ptr %t, align 8
  call void @lunite_retain(ptr %eptr)
  store ptr %eptr, ptr %alias, align 8
  %self12 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self12)
  %eptr13 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t14 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr13, i32 0, i32 0
  store i64 62, ptr %t14, align 8
  call void @lunite_retain(ptr %eptr13)
  %res = call i1 @parser_Parser_cur_is(ptr %self12, ptr %eptr13)
  br i1 %res, label %then, label %else

when_next:                                        ; preds = %body
  br label %when_body6

when_body:                                        ; preds = %body
  %pptr = getelementptr inbounds { i64, [8 x i8] }, ptr %kind, i32 0, i32 1
  %pval = load ptr, ptr %pptr, align 8
  call void @lunite_retain(ptr %pval)
  store ptr %pval, ptr %s, align 8
  %s4 = load ptr, ptr %s, align 8
  %old = load ptr, ptr %path, align 8
  call void @lunite_retain(ptr %s4)
  store ptr %s4, ptr %path, align 8
  call void @lunite_release(ptr %old)
  %tmp = load ptr, ptr %s, align 8
  call void @lunite_release(ptr %tmp)
  br label %when_end

when_next5:                                       ; No predecessors!
  br label %when_end

when_body6:                                       ; preds = %when_next
  %sdata7 = call ptr @lunite_alloc(i64 46, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata7, ptr align 1 @slit.59, i64 46, i1 false)
  %sstruct8 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p9 = getelementptr inbounds { ptr, i64 }, ptr %sstruct8, i32 0, i32 0
  %l10 = getelementptr inbounds { ptr, i64 }, ptr %sstruct8, i32 0, i32 1
  store ptr %sdata7, ptr %p9, align 8
  store i64 46, ptr %l10, align 8
  call void @lunite_retain(ptr %sstruct8)
  call void @string_print(ptr %sstruct8)
  br label %when_end

then:                                             ; preds = %when_end
  %self15 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self15)
  call void @parser_Parser_next_token(ptr %self15)
  %self16 = load ptr, ptr %self, align 8
  %fp17 = getelementptr inbounds %parser_Parser, ptr %self16, i32 0, i32 1
  %cur_token18 = load ptr, ptr %fp17, align 8
  %fp19 = getelementptr inbounds %token_Token, ptr %cur_token18, i32 0, i32 0
  %kind20 = load ptr, ptr %fp19, align 8
  %tptr24 = getelementptr inbounds { i64, [8 x i8] }, ptr %kind20, i32 0, i32 0
  %tag25 = load i64, ptr %tptr24, align 8
  %match26 = icmp eq i64 %tag25, 2
  br i1 %match26, label %when_body23, label %when_next22

else:                                             ; preds = %when_end
  br label %cont

cont:                                             ; preds = %else, %when_end21
  %self43 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self43)
  %eptr44 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t45 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr44, i32 0, i32 0
  store i64 40, ptr %t45, align 8
  call void @lunite_retain(ptr %eptr44)
  %res46 = call i1 @parser_Parser_cur_is(ptr %self43, ptr %eptr44)
  br i1 %res46, label %then47, label %else48

when_end21:                                       ; preds = %when_next36, %when_body37, %when_body23
  %self42 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self42)
  call void @parser_Parser_next_token(ptr %self42)
  br label %cont

when_next22:                                      ; preds = %then
  br label %when_body37

when_body23:                                      ; preds = %then
  %pptr27 = getelementptr inbounds { i64, [8 x i8] }, ptr %kind20, i32 0, i32 1
  %pval28 = load ptr, ptr %pptr27, align 8
  call void @lunite_retain(ptr %pval28)
  store ptr %pval28, ptr %s29, align 8
  %eptr30 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t31 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr30, i32 0, i32 0
  store i64 0, ptr %t31, align 8
  %s32 = load ptr, ptr %s29, align 8
  call void @lunite_retain(ptr %s32)
  %p33 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr30, i32 0, i32 1
  store ptr %s32, ptr %p33, align 8
  %old34 = load ptr, ptr %alias, align 8
  call void @lunite_retain(ptr %eptr30)
  store ptr %eptr30, ptr %alias, align 8
  call void @lunite_release(ptr %old34)
  %tmp35 = load ptr, ptr %s29, align 8
  call void @lunite_release(ptr %tmp35)
  br label %when_end21

when_next36:                                      ; No predecessors!
  br label %when_end21

when_body37:                                      ; preds = %when_next22
  %sdata38 = call ptr @lunite_alloc(i64 43, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata38, ptr align 1 @slit.60, i64 43, i1 false)
  %sstruct39 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p40 = getelementptr inbounds { ptr, i64 }, ptr %sstruct39, i32 0, i32 0
  %l41 = getelementptr inbounds { ptr, i64 }, ptr %sstruct39, i32 0, i32 1
  store ptr %sdata38, ptr %p40, align 8
  store i64 43, ptr %l41, align 8
  call void @lunite_retain(ptr %sstruct39)
  call void @string_print(ptr %sstruct39)
  br label %when_end21

then47:                                           ; preds = %cont
  %self50 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self50)
  call void @parser_Parser_next_token(ptr %self50)
  br label %cont49

else48:                                           ; preds = %cont
  br label %cont49

cont49:                                           ; preds = %else48, %then47
  %eptr51 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t52 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr51, i32 0, i32 0
  store i64 0, ptr %t52, align 8
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%ast_ImportDecl, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp53 = getelementptr inbounds %ast_ImportDecl, ptr %ptr, i32 0, i32 0
  %path54 = load ptr, ptr %path, align 8
  call void @lunite_retain(ptr %path54)
  store ptr %path54, ptr %fp53, align 8
  %fp55 = getelementptr inbounds %ast_ImportDecl, ptr %ptr, i32 0, i32 1
  %alias56 = load ptr, ptr %alias, align 8
  call void @lunite_retain(ptr %alias56)
  store ptr %alias56, ptr %fp55, align 8
  call void @lunite_retain(ptr %ptr)
  %p57 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr51, i32 0, i32 1
  store ptr %ptr, ptr %p57, align 8
  call void @lunite_retain(ptr %eptr51)
  %tmp58 = load ptr, ptr %alias, align 8
  call void @lunite_release(ptr %tmp58)
  %tmp59 = load ptr, ptr %path, align 8
  call void @lunite_release(ptr %tmp59)
  %tmp60 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp60)
  ret ptr %eptr51
}

define ptr @parser_Parser_parse_expression(ptr %0, ptr %1) {
entry:
  %left = alloca ptr, align 8
  %precedence = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %precedence, align 8
  %self1 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self1)
  %res = call ptr @parser_Parser_parse_prefix(ptr %self1)
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %left, align 8
  br label %while_cond

while_cond:                                       ; preds = %cont, %body
  %self2 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self2)
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 1, ptr %t, align 8
  call void @lunite_retain(ptr %eptr)
  %res3 = call i1 @parser_Parser_cur_is(ptr %self2, ptr %eptr)
  %not = xor i1 %res3, true
  %precedence4 = load ptr, ptr %precedence, align 8
  %self5 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %parser_Parser, ptr %self5, i32 0, i32 2
  %peek_token = load ptr, ptr %fp, align 8
  %fp6 = getelementptr inbounds %token_Token, ptr %peek_token, i32 0, i32 0
  %kind = load ptr, ptr %fp6, align 8
  call void @lunite_retain(ptr %kind)
  %res7 = call ptr @parser_precedence_of(ptr %kind)
  %ltp = getelementptr inbounds { i64, [1 x i8] }, ptr %precedence4, i32 0, i32 0
  %lt = load i64, ptr %ltp, align 8
  %rtp = getelementptr inbounds { i64, [1 x i8] }, ptr %res7, i32 0, i32 0
  %rt = load i64, ptr %rtp, align 8
  %2 = icmp slt i64 %lt, %rt
  %3 = and i1 %not, %2
  br i1 %3, label %while_body, label %while_end

while_body:                                       ; preds = %while_cond
  %self8 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self8)
  %eptr9 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t10 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr9, i32 0, i32 0
  store i64 41, ptr %t10, align 8
  call void @lunite_retain(ptr %eptr9)
  %res11 = call i1 @parser_Parser_peek_is(ptr %self8, ptr %eptr9)
  %self12 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self12)
  %eptr13 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t14 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr13, i32 0, i32 0
  store i64 40, ptr %t14, align 8
  call void @lunite_retain(ptr %eptr13)
  %res15 = call i1 @parser_Parser_peek_is(ptr %self12, ptr %eptr13)
  %4 = or i1 %res11, %res15
  %self16 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self16)
  %eptr17 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t18 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr17, i32 0, i32 0
  store i64 28, ptr %t18, align 8
  call void @lunite_retain(ptr %eptr17)
  %res19 = call i1 @parser_Parser_peek_is(ptr %self16, ptr %eptr17)
  %5 = or i1 %4, %res19
  %self20 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self20)
  %eptr21 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t22 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr21, i32 0, i32 0
  store i64 30, ptr %t22, align 8
  call void @lunite_retain(ptr %eptr21)
  %res23 = call i1 @parser_Parser_peek_is(ptr %self20, ptr %eptr21)
  %6 = or i1 %5, %res23
  %self24 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self24)
  %eptr25 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t26 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr25, i32 0, i32 0
  store i64 35, ptr %t26, align 8
  call void @lunite_retain(ptr %eptr25)
  %res27 = call i1 @parser_Parser_peek_is(ptr %self24, ptr %eptr25)
  %7 = or i1 %6, %res27
  br i1 %7, label %then, label %else

while_end:                                        ; preds = %then, %while_cond
  %left32 = load ptr, ptr %left, align 8
  call void @lunite_retain(ptr %left32)
  %tmp = load ptr, ptr %left, align 8
  call void @lunite_release(ptr %tmp)
  %tmp33 = load ptr, ptr %precedence, align 8
  call void @lunite_release(ptr %tmp33)
  %tmp34 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp34)
  ret ptr %left32

then:                                             ; preds = %while_body
  br label %while_end

else:                                             ; preds = %while_body
  br label %cont

cont:                                             ; preds = %else
  %self28 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self28)
  call void @parser_Parser_next_token(ptr %self28)
  %self29 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self29)
  %left30 = load ptr, ptr %left, align 8
  call void @lunite_retain(ptr %left30)
  %res31 = call ptr @parser_Parser_parse_infix(ptr %self29, ptr %left30)
  %old = load ptr, ptr %left, align 8
  call void @lunite_retain(ptr %res31)
  store ptr %res31, ptr %left, align 8
  call void @lunite_release(ptr %old)
  br label %while_cond
}

define ptr @parser_Parser_parse_prefix(ptr %0) {
entry:
  %e = alloca ptr, align 8
  %right179 = alloca ptr, align 8
  %op173 = alloca ptr, align 8
  %right151 = alloca ptr, align 8
  %op145 = alloca ptr, align 8
  %right123 = alloca ptr, align 8
  %op117 = alloca ptr, align 8
  %right = alloca ptr, align 8
  %op = alloca ptr, align 8
  %v45 = alloca ptr, align 8
  %v29 = alloca ptr, align 8
  %v14 = alloca double, align 8
  %v = alloca i64, align 8
  %k = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %parser_Parser, ptr %self1, i32 0, i32 1
  %cur_token = load ptr, ptr %fp, align 8
  %fp2 = getelementptr inbounds %token_Token, ptr %cur_token, i32 0, i32 0
  %kind = load ptr, ptr %fp2, align 8
  call void @lunite_retain(ptr %kind)
  store ptr %kind, ptr %k, align 8
  %k3 = load ptr, ptr %k, align 8
  %tptr = getelementptr inbounds { i64, [8 x i8] }, ptr %k3, i32 0, i32 0
  %tag = load i64, ptr %tptr, align 8
  %match = icmp eq i64 %tag, 3
  br i1 %match, label %when_body, label %when_next

when_end:                                         ; preds = %when_next211
  %tmp222 = load ptr, ptr %k, align 8
  call void @lunite_release(ptr %tmp222)
  %tmp223 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp223)
  ret ptr null

when_next:                                        ; preds = %body
  %tptr9 = getelementptr inbounds { i64, [8 x i8] }, ptr %k3, i32 0, i32 0
  %tag10 = load i64, ptr %tptr9, align 8
  %match11 = icmp eq i64 %tag10, 4
  br i1 %match11, label %when_body8, label %when_next7

when_body:                                        ; preds = %body
  %pptr = getelementptr inbounds { i64, [8 x i8] }, ptr %k3, i32 0, i32 1
  %pval = load i64, ptr %pptr, align 8
  store i64 %pval, ptr %v, align 8
  %self4 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self4)
  call void @parser_Parser_next_token(ptr %self4)
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 0, ptr %t, align 8
  %v5 = load i64, ptr %v, align 8
  %p = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 1
  store i64 %v5, ptr %p, align 8
  call void @lunite_retain(ptr %eptr)
  %tmp = load ptr, ptr %k, align 8
  call void @lunite_release(ptr %tmp)
  %tmp6 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp6)
  ret ptr %eptr

when_next7:                                       ; preds = %when_next
  %tptr24 = getelementptr inbounds { i64, [8 x i8] }, ptr %k3, i32 0, i32 0
  %tag25 = load i64, ptr %tptr24, align 8
  %match26 = icmp eq i64 %tag25, 5
  br i1 %match26, label %when_body23, label %when_next22

when_body8:                                       ; preds = %when_next
  %pptr12 = getelementptr inbounds { i64, [8 x i8] }, ptr %k3, i32 0, i32 1
  %pval13 = load double, ptr %pptr12, align 8
  store double %pval13, ptr %v14, align 8
  %self15 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self15)
  call void @parser_Parser_next_token(ptr %self15)
  %eptr16 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t17 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr16, i32 0, i32 0
  store i64 1, ptr %t17, align 8
  %v18 = load double, ptr %v14, align 8
  %p19 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr16, i32 0, i32 1
  store double %v18, ptr %p19, align 8
  call void @lunite_retain(ptr %eptr16)
  %tmp20 = load ptr, ptr %k, align 8
  call void @lunite_release(ptr %tmp20)
  %tmp21 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp21)
  ret ptr %eptr16

when_next22:                                      ; preds = %when_next7
  %tptr40 = getelementptr inbounds { i64, [8 x i8] }, ptr %k3, i32 0, i32 0
  %tag41 = load i64, ptr %tptr40, align 8
  %match42 = icmp eq i64 %tag41, 2
  br i1 %match42, label %when_body39, label %when_next38

when_body23:                                      ; preds = %when_next7
  %pptr27 = getelementptr inbounds { i64, [8 x i8] }, ptr %k3, i32 0, i32 1
  %pval28 = load ptr, ptr %pptr27, align 8
  call void @lunite_retain(ptr %pval28)
  store ptr %pval28, ptr %v29, align 8
  %self30 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self30)
  call void @parser_Parser_next_token(ptr %self30)
  %eptr31 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t32 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr31, i32 0, i32 0
  store i64 2, ptr %t32, align 8
  %v33 = load ptr, ptr %v29, align 8
  call void @lunite_retain(ptr %v33)
  %p34 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr31, i32 0, i32 1
  store ptr %v33, ptr %p34, align 8
  call void @lunite_retain(ptr %eptr31)
  %tmp35 = load ptr, ptr %v29, align 8
  call void @lunite_release(ptr %tmp35)
  %tmp36 = load ptr, ptr %k, align 8
  call void @lunite_release(ptr %tmp36)
  %tmp37 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp37)
  ret ptr %eptr31

when_next38:                                      ; preds = %when_next22
  %tptr52 = getelementptr inbounds { i64, [8 x i8] }, ptr %k3, i32 0, i32 0
  %tag53 = load i64, ptr %tptr52, align 8
  %match54 = icmp eq i64 %tag53, 66
  br i1 %match54, label %when_body51, label %when_next50

when_body39:                                      ; preds = %when_next22
  %pptr43 = getelementptr inbounds { i64, [8 x i8] }, ptr %k3, i32 0, i32 1
  %pval44 = load ptr, ptr %pptr43, align 8
  call void @lunite_retain(ptr %pval44)
  store ptr %pval44, ptr %v45, align 8
  %self46 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self46)
  %res = call ptr @parser_Parser_parse_identifier(ptr %self46)
  call void @lunite_retain(ptr %res)
  %tmp47 = load ptr, ptr %v45, align 8
  call void @lunite_release(ptr %tmp47)
  %tmp48 = load ptr, ptr %k, align 8
  call void @lunite_release(ptr %tmp48)
  %tmp49 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp49)
  ret ptr %res

when_next50:                                      ; preds = %when_next38
  %tptr63 = getelementptr inbounds { i64, [8 x i8] }, ptr %k3, i32 0, i32 0
  %tag64 = load i64, ptr %tptr63, align 8
  %match65 = icmp eq i64 %tag64, 67
  br i1 %match65, label %when_body62, label %when_next61

when_body51:                                      ; preds = %when_next38
  %self55 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self55)
  call void @parser_Parser_next_token(ptr %self55)
  %eptr56 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t57 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr56, i32 0, i32 0
  store i64 4, ptr %t57, align 8
  %p58 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr56, i32 0, i32 1
  store i1 true, ptr %p58, align 1
  call void @lunite_retain(ptr %eptr56)
  %tmp59 = load ptr, ptr %k, align 8
  call void @lunite_release(ptr %tmp59)
  %tmp60 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp60)
  ret ptr %eptr56

when_next61:                                      ; preds = %when_next50
  %tptr74 = getelementptr inbounds { i64, [8 x i8] }, ptr %k3, i32 0, i32 0
  %tag75 = load i64, ptr %tptr74, align 8
  %match76 = icmp eq i64 %tag75, 68
  br i1 %match76, label %when_body73, label %when_next72

when_body62:                                      ; preds = %when_next50
  %self66 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self66)
  call void @parser_Parser_next_token(ptr %self66)
  %eptr67 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t68 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr67, i32 0, i32 0
  store i64 4, ptr %t68, align 8
  %p69 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr67, i32 0, i32 1
  store i1 false, ptr %p69, align 1
  call void @lunite_retain(ptr %eptr67)
  %tmp70 = load ptr, ptr %k, align 8
  call void @lunite_release(ptr %tmp70)
  %tmp71 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp71)
  ret ptr %eptr67

when_next72:                                      ; preds = %when_next61
  %tptr84 = getelementptr inbounds { i64, [8 x i8] }, ptr %k3, i32 0, i32 0
  %tag85 = load i64, ptr %tptr84, align 8
  %match86 = icmp eq i64 %tag85, 7
  br i1 %match86, label %when_body83, label %when_next82

when_body73:                                      ; preds = %when_next61
  %self77 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self77)
  call void @parser_Parser_next_token(ptr %self77)
  %eptr78 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t79 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr78, i32 0, i32 0
  store i64 5, ptr %t79, align 8
  call void @lunite_retain(ptr %eptr78)
  %tmp80 = load ptr, ptr %k, align 8
  call void @lunite_release(ptr %tmp80)
  %tmp81 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp81)
  ret ptr %eptr78

when_next82:                                      ; preds = %when_next72
  %tptr109 = getelementptr inbounds { i64, [8 x i8] }, ptr %k3, i32 0, i32 0
  %tag110 = load i64, ptr %tptr109, align 8
  %match111 = icmp eq i64 %tag110, 13
  br i1 %match111, label %when_body108, label %when_next107

when_body83:                                      ; preds = %when_next72
  %self87 = load ptr, ptr %self, align 8
  %fp88 = getelementptr inbounds %parser_Parser, ptr %self87, i32 0, i32 1
  %cur_token89 = load ptr, ptr %fp88, align 8
  %fp90 = getelementptr inbounds %token_Token, ptr %cur_token89, i32 0, i32 0
  %kind91 = load ptr, ptr %fp90, align 8
  call void @lunite_retain(ptr %kind91)
  store ptr %kind91, ptr %op, align 8
  %self92 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self92)
  call void @parser_Parser_next_token(ptr %self92)
  %self93 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self93)
  %eptr94 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t95 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr94, i32 0, i32 0
  store i64 12, ptr %t95, align 8
  call void @lunite_retain(ptr %eptr94)
  %res96 = call ptr @parser_Parser_parse_expression(ptr %self93, ptr %eptr94)
  call void @lunite_retain(ptr %res96)
  store ptr %res96, ptr %right, align 8
  %eptr97 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t98 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr97, i32 0, i32 0
  store i64 6, ptr %t98, align 8
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%ast_UnaryExpressionPayload, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp99 = getelementptr inbounds %ast_UnaryExpressionPayload, ptr %ptr, i32 0, i32 0
  %op100 = load ptr, ptr %op, align 8
  call void @lunite_retain(ptr %op100)
  store ptr %op100, ptr %fp99, align 8
  %fp101 = getelementptr inbounds %ast_UnaryExpressionPayload, ptr %ptr, i32 0, i32 1
  store ptr %right, ptr %fp101, align 8
  call void @lunite_retain(ptr %ptr)
  %p102 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr97, i32 0, i32 1
  store ptr %ptr, ptr %p102, align 8
  call void @lunite_retain(ptr %eptr97)
  %tmp103 = load ptr, ptr %right, align 8
  call void @lunite_release(ptr %tmp103)
  %tmp104 = load ptr, ptr %op, align 8
  call void @lunite_release(ptr %tmp104)
  %tmp105 = load ptr, ptr %k, align 8
  call void @lunite_release(ptr %tmp105)
  %tmp106 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp106)
  ret ptr %eptr97

when_next107:                                     ; preds = %when_next82
  %tptr137 = getelementptr inbounds { i64, [8 x i8] }, ptr %k3, i32 0, i32 0
  %tag138 = load i64, ptr %tptr137, align 8
  %match139 = icmp eq i64 %tag138, 19
  br i1 %match139, label %when_body136, label %when_next135

when_body108:                                     ; preds = %when_next82
  %self112 = load ptr, ptr %self, align 8
  %fp113 = getelementptr inbounds %parser_Parser, ptr %self112, i32 0, i32 1
  %cur_token114 = load ptr, ptr %fp113, align 8
  %fp115 = getelementptr inbounds %token_Token, ptr %cur_token114, i32 0, i32 0
  %kind116 = load ptr, ptr %fp115, align 8
  call void @lunite_retain(ptr %kind116)
  store ptr %kind116, ptr %op117, align 8
  %self118 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self118)
  call void @parser_Parser_next_token(ptr %self118)
  %self119 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self119)
  %eptr120 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t121 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr120, i32 0, i32 0
  store i64 12, ptr %t121, align 8
  call void @lunite_retain(ptr %eptr120)
  %res122 = call ptr @parser_Parser_parse_expression(ptr %self119, ptr %eptr120)
  call void @lunite_retain(ptr %res122)
  store ptr %res122, ptr %right123, align 8
  %eptr124 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t125 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr124, i32 0, i32 0
  store i64 6, ptr %t125, align 8
  %ptr126 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%ast_UnaryExpressionPayload, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp127 = getelementptr inbounds %ast_UnaryExpressionPayload, ptr %ptr126, i32 0, i32 0
  %op128 = load ptr, ptr %op117, align 8
  call void @lunite_retain(ptr %op128)
  store ptr %op128, ptr %fp127, align 8
  %fp129 = getelementptr inbounds %ast_UnaryExpressionPayload, ptr %ptr126, i32 0, i32 1
  store ptr %right123, ptr %fp129, align 8
  call void @lunite_retain(ptr %ptr126)
  %p130 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr124, i32 0, i32 1
  store ptr %ptr126, ptr %p130, align 8
  call void @lunite_retain(ptr %eptr124)
  %tmp131 = load ptr, ptr %right123, align 8
  call void @lunite_release(ptr %tmp131)
  %tmp132 = load ptr, ptr %op117, align 8
  call void @lunite_release(ptr %tmp132)
  %tmp133 = load ptr, ptr %k, align 8
  call void @lunite_release(ptr %tmp133)
  %tmp134 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp134)
  ret ptr %eptr124

when_next135:                                     ; preds = %when_next107
  %tptr165 = getelementptr inbounds { i64, [8 x i8] }, ptr %k3, i32 0, i32 0
  %tag166 = load i64, ptr %tptr165, align 8
  %match167 = icmp eq i64 %tag166, 8
  br i1 %match167, label %when_body164, label %when_next163

when_body136:                                     ; preds = %when_next107
  %self140 = load ptr, ptr %self, align 8
  %fp141 = getelementptr inbounds %parser_Parser, ptr %self140, i32 0, i32 1
  %cur_token142 = load ptr, ptr %fp141, align 8
  %fp143 = getelementptr inbounds %token_Token, ptr %cur_token142, i32 0, i32 0
  %kind144 = load ptr, ptr %fp143, align 8
  call void @lunite_retain(ptr %kind144)
  store ptr %kind144, ptr %op145, align 8
  %self146 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self146)
  call void @parser_Parser_next_token(ptr %self146)
  %self147 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self147)
  %eptr148 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t149 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr148, i32 0, i32 0
  store i64 12, ptr %t149, align 8
  call void @lunite_retain(ptr %eptr148)
  %res150 = call ptr @parser_Parser_parse_expression(ptr %self147, ptr %eptr148)
  call void @lunite_retain(ptr %res150)
  store ptr %res150, ptr %right151, align 8
  %eptr152 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t153 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr152, i32 0, i32 0
  store i64 6, ptr %t153, align 8
  %ptr154 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%ast_UnaryExpressionPayload, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp155 = getelementptr inbounds %ast_UnaryExpressionPayload, ptr %ptr154, i32 0, i32 0
  %op156 = load ptr, ptr %op145, align 8
  call void @lunite_retain(ptr %op156)
  store ptr %op156, ptr %fp155, align 8
  %fp157 = getelementptr inbounds %ast_UnaryExpressionPayload, ptr %ptr154, i32 0, i32 1
  store ptr %right151, ptr %fp157, align 8
  call void @lunite_retain(ptr %ptr154)
  %p158 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr152, i32 0, i32 1
  store ptr %ptr154, ptr %p158, align 8
  call void @lunite_retain(ptr %eptr152)
  %tmp159 = load ptr, ptr %right151, align 8
  call void @lunite_release(ptr %tmp159)
  %tmp160 = load ptr, ptr %op145, align 8
  call void @lunite_release(ptr %tmp160)
  %tmp161 = load ptr, ptr %k, align 8
  call void @lunite_release(ptr %tmp161)
  %tmp162 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp162)
  ret ptr %eptr152

when_next163:                                     ; preds = %when_next135
  %tptr193 = getelementptr inbounds { i64, [8 x i8] }, ptr %k3, i32 0, i32 0
  %tag194 = load i64, ptr %tptr193, align 8
  %match195 = icmp eq i64 %tag194, 27
  br i1 %match195, label %when_body192, label %when_next191

when_body164:                                     ; preds = %when_next135
  %self168 = load ptr, ptr %self, align 8
  %fp169 = getelementptr inbounds %parser_Parser, ptr %self168, i32 0, i32 1
  %cur_token170 = load ptr, ptr %fp169, align 8
  %fp171 = getelementptr inbounds %token_Token, ptr %cur_token170, i32 0, i32 0
  %kind172 = load ptr, ptr %fp171, align 8
  call void @lunite_retain(ptr %kind172)
  store ptr %kind172, ptr %op173, align 8
  %self174 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self174)
  call void @parser_Parser_next_token(ptr %self174)
  %self175 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self175)
  %eptr176 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t177 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr176, i32 0, i32 0
  store i64 12, ptr %t177, align 8
  call void @lunite_retain(ptr %eptr176)
  %res178 = call ptr @parser_Parser_parse_expression(ptr %self175, ptr %eptr176)
  call void @lunite_retain(ptr %res178)
  store ptr %res178, ptr %right179, align 8
  %eptr180 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t181 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr180, i32 0, i32 0
  store i64 6, ptr %t181, align 8
  %ptr182 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%ast_UnaryExpressionPayload, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp183 = getelementptr inbounds %ast_UnaryExpressionPayload, ptr %ptr182, i32 0, i32 0
  %op184 = load ptr, ptr %op173, align 8
  call void @lunite_retain(ptr %op184)
  store ptr %op184, ptr %fp183, align 8
  %fp185 = getelementptr inbounds %ast_UnaryExpressionPayload, ptr %ptr182, i32 0, i32 1
  store ptr %right179, ptr %fp185, align 8
  call void @lunite_retain(ptr %ptr182)
  %p186 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr180, i32 0, i32 1
  store ptr %ptr182, ptr %p186, align 8
  call void @lunite_retain(ptr %eptr180)
  %tmp187 = load ptr, ptr %right179, align 8
  call void @lunite_release(ptr %tmp187)
  %tmp188 = load ptr, ptr %op173, align 8
  call void @lunite_release(ptr %tmp188)
  %tmp189 = load ptr, ptr %k, align 8
  call void @lunite_release(ptr %tmp189)
  %tmp190 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp190)
  ret ptr %eptr180

when_next191:                                     ; preds = %when_next163
  br label %when_body212

when_body192:                                     ; preds = %when_next163
  %self196 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self196)
  call void @parser_Parser_next_token(ptr %self196)
  %self197 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self197)
  %eptr198 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t199 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr198, i32 0, i32 0
  store i64 0, ptr %t199, align 8
  call void @lunite_retain(ptr %eptr198)
  %res200 = call ptr @parser_Parser_parse_expression(ptr %self197, ptr %eptr198)
  call void @lunite_retain(ptr %res200)
  store ptr %res200, ptr %e, align 8
  %self201 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self201)
  %eptr202 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t203 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr202, i32 0, i32 0
  store i64 28, ptr %t203, align 8
  call void @lunite_retain(ptr %eptr202)
  %res204 = call i1 @parser_Parser_cur_is(ptr %self201, ptr %eptr202)
  %not = xor i1 %res204, true
  br i1 %not, label %then, label %else

then:                                             ; preds = %when_body192
  %sdata = call ptr @lunite_alloc(i64 19, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.61, i64 19, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p205 = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p205, align 8
  store i64 19, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  call void @string_print(ptr %sstruct)
  br label %cont

else:                                             ; preds = %when_body192
  br label %cont

cont:                                             ; preds = %else, %then
  %self206 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self206)
  call void @parser_Parser_next_token(ptr %self206)
  %e207 = load ptr, ptr %e, align 8
  call void @lunite_retain(ptr %e207)
  %tmp208 = load ptr, ptr %e, align 8
  call void @lunite_release(ptr %tmp208)
  %tmp209 = load ptr, ptr %k, align 8
  call void @lunite_release(ptr %tmp209)
  %tmp210 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp210)
  ret ptr %e207

when_next211:                                     ; No predecessors!
  br label %when_end

when_body212:                                     ; preds = %when_next191
  %sdata213 = call ptr @lunite_alloc(i64 26, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata213, ptr align 1 @slit.62, i64 26, i1 false)
  %sstruct214 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p215 = getelementptr inbounds { ptr, i64 }, ptr %sstruct214, i32 0, i32 0
  %l216 = getelementptr inbounds { ptr, i64 }, ptr %sstruct214, i32 0, i32 1
  store ptr %sdata213, ptr %p215, align 8
  store i64 26, ptr %l216, align 8
  call void @lunite_retain(ptr %sstruct214)
  call void @string_print(ptr %sstruct214)
  %self217 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self217)
  call void @parser_Parser_next_token(ptr %self217)
  %eptr218 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t219 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr218, i32 0, i32 0
  store i64 5, ptr %t219, align 8
  call void @lunite_retain(ptr %eptr218)
  %tmp220 = load ptr, ptr %k, align 8
  call void @lunite_release(ptr %tmp220)
  %tmp221 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp221)
  ret ptr %eptr218
}

define ptr @parser_Parser_parse_infix(ptr %0, ptr %1) {
entry:
  %right = alloca ptr, align 8
  %prec = alloca ptr, align 8
  %op = alloca ptr, align 8
  %left = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %left, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %parser_Parser, ptr %self1, i32 0, i32 1
  %cur_token = load ptr, ptr %fp, align 8
  %fp2 = getelementptr inbounds %token_Token, ptr %cur_token, i32 0, i32 0
  %kind = load ptr, ptr %fp2, align 8
  call void @lunite_retain(ptr %kind)
  store ptr %kind, ptr %op, align 8
  %op3 = load ptr, ptr %op, align 8
  call void @lunite_retain(ptr %op3)
  %res = call ptr @parser_precedence_of(ptr %op3)
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %prec, align 8
  %op4 = load ptr, ptr %op, align 8
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 27, ptr %t, align 8
  %l_null = icmp eq ptr %op4, null
  %r_null = icmp eq ptr %eptr, null
  %both_null = and i1 %l_null, %r_null
  %either_null = or i1 %l_null, %r_null
  br i1 %either_null, label %enum_res, label %enum_load

enum_load:                                        ; preds = %body
  %ltag = getelementptr inbounds { i64, [8 x i8] }, ptr %op4, i32 0, i32 0
  %rtag = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  %lt = load i64, ptr %ltag, align 8
  %rt = load i64, ptr %rtag, align 8
  %teq = icmp eq i64 %lt, %rt
  br label %enum_res

enum_res:                                         ; preds = %enum_load, %body
  %eq = phi i1 [ %both_null, %body ], [ %teq, %enum_load ]
  br i1 %eq, label %then, label %else

then:                                             ; preds = %enum_res
  %self5 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self5)
  %left6 = load ptr, ptr %left, align 8
  call void @lunite_retain(ptr %left6)
  %res7 = call ptr @parser_Parser_parse_call_expression(ptr %self5, ptr %left6)
  call void @lunite_retain(ptr %res7)
  %tmp = load ptr, ptr %prec, align 8
  call void @lunite_release(ptr %tmp)
  %tmp8 = load ptr, ptr %op, align 8
  call void @lunite_release(ptr %tmp8)
  %tmp9 = load ptr, ptr %left, align 8
  call void @lunite_release(ptr %tmp9)
  %tmp10 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp10)
  ret ptr %res7

else:                                             ; preds = %enum_res
  %op11 = load ptr, ptr %op, align 8
  %eptr12 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t13 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr12, i32 0, i32 0
  store i64 36, ptr %t13, align 8
  %l_null14 = icmp eq ptr %op11, null
  %r_null15 = icmp eq ptr %eptr12, null
  %both_null16 = and i1 %l_null14, %r_null15
  %either_null17 = or i1 %l_null14, %r_null15
  br i1 %either_null17, label %enum_res19, label %enum_load18

cont:                                             ; preds = %cont28
  %self36 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self36)
  call void @parser_Parser_next_token(ptr %self36)
  %self37 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self37)
  %prec38 = load ptr, ptr %prec, align 8
  call void @lunite_retain(ptr %prec38)
  %res39 = call ptr @parser_Parser_parse_expression(ptr %self37, ptr %prec38)
  call void @lunite_retain(ptr %res39)
  store ptr %res39, ptr %right, align 8
  %eptr40 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t41 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr40, i32 0, i32 0
  store i64 8, ptr %t41, align 8
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%ast_BinaryExpressionPayload, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp42 = getelementptr inbounds %ast_BinaryExpressionPayload, ptr %ptr, i32 0, i32 0
  store ptr %left, ptr %fp42, align 8
  %fp43 = getelementptr inbounds %ast_BinaryExpressionPayload, ptr %ptr, i32 0, i32 1
  %op44 = load ptr, ptr %op, align 8
  call void @lunite_retain(ptr %op44)
  store ptr %op44, ptr %fp43, align 8
  %fp45 = getelementptr inbounds %ast_BinaryExpressionPayload, ptr %ptr, i32 0, i32 2
  store ptr %right, ptr %fp45, align 8
  call void @lunite_retain(ptr %ptr)
  %p = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr40, i32 0, i32 1
  store ptr %ptr, ptr %p, align 8
  call void @lunite_retain(ptr %eptr40)
  %tmp46 = load ptr, ptr %right, align 8
  call void @lunite_release(ptr %tmp46)
  %tmp47 = load ptr, ptr %prec, align 8
  call void @lunite_release(ptr %tmp47)
  %tmp48 = load ptr, ptr %op, align 8
  call void @lunite_release(ptr %tmp48)
  %tmp49 = load ptr, ptr %left, align 8
  call void @lunite_release(ptr %tmp49)
  %tmp50 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp50)
  ret ptr %eptr40

enum_load18:                                      ; preds = %else
  %ltag20 = getelementptr inbounds { i64, [8 x i8] }, ptr %op11, i32 0, i32 0
  %rtag21 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr12, i32 0, i32 0
  %lt22 = load i64, ptr %ltag20, align 8
  %rt23 = load i64, ptr %rtag21, align 8
  %teq24 = icmp eq i64 %lt22, %rt23
  br label %enum_res19

enum_res19:                                       ; preds = %enum_load18, %else
  %eq25 = phi i1 [ %both_null16, %else ], [ %teq24, %enum_load18 ]
  br i1 %eq25, label %then26, label %else27

then26:                                           ; preds = %enum_res19
  %self29 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self29)
  %left30 = load ptr, ptr %left, align 8
  call void @lunite_retain(ptr %left30)
  %res31 = call ptr @parser_Parser_parse_member_access(ptr %self29, ptr %left30)
  call void @lunite_retain(ptr %res31)
  %tmp32 = load ptr, ptr %prec, align 8
  call void @lunite_release(ptr %tmp32)
  %tmp33 = load ptr, ptr %op, align 8
  call void @lunite_release(ptr %tmp33)
  %tmp34 = load ptr, ptr %left, align 8
  call void @lunite_release(ptr %tmp34)
  %tmp35 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp35)
  ret ptr %res31

else27:                                           ; preds = %enum_res19
  br label %cont28

cont28:                                           ; preds = %else27
  br label %cont
}

define ptr @parser_Parser_parse_identifier(ptr %0) {
entry:
  %s = alloca ptr, align 8
  %name = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %sdata = call ptr @lunite_alloc(i64 0, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.63, i64 0, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p, align 8
  store i64 0, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  store ptr %sstruct, ptr %name, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %parser_Parser, ptr %self1, i32 0, i32 1
  %cur_token = load ptr, ptr %fp, align 8
  %fp2 = getelementptr inbounds %token_Token, ptr %cur_token, i32 0, i32 0
  %kind = load ptr, ptr %fp2, align 8
  %tptr = getelementptr inbounds { i64, [8 x i8] }, ptr %kind, i32 0, i32 0
  %tag = load i64, ptr %tptr, align 8
  %match = icmp eq i64 %tag, 2
  br i1 %match, label %when_body, label %when_next

when_end:                                         ; preds = %when_next4, %when_body5, %when_body
  %self6 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self6)
  call void @parser_Parser_next_token(ptr %self6)
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 3, ptr %t, align 8
  %name7 = load ptr, ptr %name, align 8
  call void @lunite_retain(ptr %name7)
  %p8 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 1
  store ptr %name7, ptr %p8, align 8
  call void @lunite_retain(ptr %eptr)
  %tmp9 = load ptr, ptr %name, align 8
  call void @lunite_release(ptr %tmp9)
  %tmp10 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp10)
  ret ptr %eptr

when_next:                                        ; preds = %body
  br label %when_body5

when_body:                                        ; preds = %body
  %pptr = getelementptr inbounds { i64, [8 x i8] }, ptr %kind, i32 0, i32 1
  %pval = load ptr, ptr %pptr, align 8
  call void @lunite_retain(ptr %pval)
  store ptr %pval, ptr %s, align 8
  %s3 = load ptr, ptr %s, align 8
  %old = load ptr, ptr %name, align 8
  call void @lunite_retain(ptr %s3)
  store ptr %s3, ptr %name, align 8
  call void @lunite_release(ptr %old)
  %tmp = load ptr, ptr %s, align 8
  call void @lunite_release(ptr %tmp)
  br label %when_end

when_next4:                                       ; No predecessors!
  br label %when_end

when_body5:                                       ; preds = %when_next
  br label %when_end
}

define ptr @parser_Parser_parse_call_expression(ptr %0, ptr %1) {
entry:
  %args = alloca ptr, align 8
  %function = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %function, align 8
  %self1 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self1)
  call void @parser_Parser_next_token(ptr %self1)
  %res = call ptr @list_List_ast_Expression__new()
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %args, align 8
  br label %while_cond

while_cond:                                       ; preds = %cont, %body
  %self2 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self2)
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 28, ptr %t, align 8
  call void @lunite_retain(ptr %eptr)
  %res3 = call i1 @parser_Parser_cur_is(ptr %self2, ptr %eptr)
  %not = xor i1 %res3, true
  %self4 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self4)
  %eptr5 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t6 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr5, i32 0, i32 0
  store i64 1, ptr %t6, align 8
  call void @lunite_retain(ptr %eptr5)
  %res7 = call i1 @parser_Parser_cur_is(ptr %self4, ptr %eptr5)
  %not8 = xor i1 %res7, true
  %2 = and i1 %not, %not8
  br i1 %2, label %while_body, label %while_end

while_body:                                       ; preds = %while_cond
  %args9 = load ptr, ptr %args, align 8
  call void @lunite_retain(ptr %args9)
  %self10 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self10)
  %eptr11 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t12 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr11, i32 0, i32 0
  store i64 0, ptr %t12, align 8
  call void @lunite_retain(ptr %eptr11)
  %res13 = call ptr @parser_Parser_parse_expression(ptr %self10, ptr %eptr11)
  call void @lunite_retain(ptr %res13)
  call void @list_List_ast_Expression__push(ptr %args9, ptr %res13)
  %self14 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self14)
  %eptr15 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t16 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr15, i32 0, i32 0
  store i64 35, ptr %t16, align 8
  call void @lunite_retain(ptr %eptr15)
  %res17 = call i1 @parser_Parser_cur_is(ptr %self14, ptr %eptr15)
  br i1 %res17, label %then, label %else

while_end:                                        ; preds = %while_cond
  %self19 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self19)
  call void @parser_Parser_next_token(ptr %self19)
  %eptr20 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t21 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr20, i32 0, i32 0
  store i64 9, ptr %t21, align 8
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%ast_CallExpressionPayload, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %ast_CallExpressionPayload, ptr %ptr, i32 0, i32 0
  store ptr %function, ptr %fp, align 8
  %fp22 = getelementptr inbounds %ast_CallExpressionPayload, ptr %ptr, i32 0, i32 1
  %args23 = load ptr, ptr %args, align 8
  call void @lunite_retain(ptr %args23)
  store ptr %args23, ptr %fp22, align 8
  %fp24 = getelementptr inbounds %ast_CallExpressionPayload, ptr %ptr, i32 0, i32 2
  %res25 = call ptr @list_List_ast_Type__new()
  call void @lunite_retain(ptr %res25)
  store ptr %res25, ptr %fp24, align 8
  call void @lunite_retain(ptr %ptr)
  %p = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr20, i32 0, i32 1
  store ptr %ptr, ptr %p, align 8
  call void @lunite_retain(ptr %eptr20)
  %tmp = load ptr, ptr %args, align 8
  call void @lunite_release(ptr %tmp)
  %tmp26 = load ptr, ptr %function, align 8
  call void @lunite_release(ptr %tmp26)
  %tmp27 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp27)
  ret ptr %eptr20

then:                                             ; preds = %while_body
  %self18 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self18)
  call void @parser_Parser_next_token(ptr %self18)
  br label %cont

else:                                             ; preds = %while_body
  br label %cont

cont:                                             ; preds = %else, %then
  br label %while_cond
}

define ptr @parser_Parser_parse_member_access(ptr %0, ptr %1) {
entry:
  %s = alloca ptr, align 8
  %field = alloca ptr, align 8
  %object = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %object, align 8
  %self1 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self1)
  call void @parser_Parser_next_token(ptr %self1)
  %sdata = call ptr @lunite_alloc(i64 0, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.64, i64 0, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p, align 8
  store i64 0, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  store ptr %sstruct, ptr %field, align 8
  %self2 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %parser_Parser, ptr %self2, i32 0, i32 1
  %cur_token = load ptr, ptr %fp, align 8
  %fp3 = getelementptr inbounds %token_Token, ptr %cur_token, i32 0, i32 0
  %kind = load ptr, ptr %fp3, align 8
  %tptr = getelementptr inbounds { i64, [8 x i8] }, ptr %kind, i32 0, i32 0
  %tag = load i64, ptr %tptr, align 8
  %match = icmp eq i64 %tag, 2
  br i1 %match, label %when_body, label %when_next

when_end:                                         ; preds = %when_next5, %when_body6, %when_body
  %self11 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self11)
  call void @parser_Parser_next_token(ptr %self11)
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 14, ptr %t, align 8
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%ast_MemberAccessExpressionPayload, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp12 = getelementptr inbounds %ast_MemberAccessExpressionPayload, ptr %ptr, i32 0, i32 0
  store ptr %object, ptr %fp12, align 8
  %fp13 = getelementptr inbounds %ast_MemberAccessExpressionPayload, ptr %ptr, i32 0, i32 1
  %field14 = load ptr, ptr %field, align 8
  call void @lunite_retain(ptr %field14)
  store ptr %field14, ptr %fp13, align 8
  call void @lunite_retain(ptr %ptr)
  %p15 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 1
  store ptr %ptr, ptr %p15, align 8
  call void @lunite_retain(ptr %eptr)
  %tmp16 = load ptr, ptr %field, align 8
  call void @lunite_release(ptr %tmp16)
  %tmp17 = load ptr, ptr %object, align 8
  call void @lunite_release(ptr %tmp17)
  %tmp18 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp18)
  ret ptr %eptr

when_next:                                        ; preds = %body
  br label %when_body6

when_body:                                        ; preds = %body
  %pptr = getelementptr inbounds { i64, [8 x i8] }, ptr %kind, i32 0, i32 1
  %pval = load ptr, ptr %pptr, align 8
  call void @lunite_retain(ptr %pval)
  store ptr %pval, ptr %s, align 8
  %s4 = load ptr, ptr %s, align 8
  %old = load ptr, ptr %field, align 8
  call void @lunite_retain(ptr %s4)
  store ptr %s4, ptr %field, align 8
  call void @lunite_release(ptr %old)
  %tmp = load ptr, ptr %s, align 8
  call void @lunite_release(ptr %tmp)
  br label %when_end

when_next5:                                       ; No predecessors!
  br label %when_end

when_body6:                                       ; preds = %when_next
  %sdata7 = call ptr @lunite_alloc(i64 36, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata7, ptr align 1 @slit.65, i64 36, i1 false)
  %sstruct8 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p9 = getelementptr inbounds { ptr, i64 }, ptr %sstruct8, i32 0, i32 0
  %l10 = getelementptr inbounds { ptr, i64 }, ptr %sstruct8, i32 0, i32 1
  store ptr %sdata7, ptr %p9, align 8
  store i64 36, ptr %l10, align 8
  call void @lunite_retain(ptr %sstruct8)
  call void @string_print(ptr %sstruct8)
  br label %when_end
}

define i64 @list_List_ast_Item__len(ptr %0) {
entry:
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_ast_Item_, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret i64 %count
}

define ptr @list_List_ast_Item__get_ptr(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_ast_Item_, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %ptr
}

define ptr @list_List_ast_Item__get(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_ast_Item_, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %val = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val)
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %val
}

define ptr @list_List_ast_Item__new() {
entry:
  %p = alloca ptr, align 8
  %initial_cap = alloca i64, align 8
  br label %body

body:                                             ; preds = %entry
  store i64 10, ptr %initial_cap, align 8
  %initial_cap1 = load i64, ptr %initial_cap, align 8
  %0 = mul i64 %initial_cap1, 8
  %res = call ptr @lunite_alloc(i64 %0, i64 0, i64 0)
  store ptr %res, ptr %p, align 8
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%list_List_ast_Item_, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %list_List_ast_Item_, ptr %ptr, i32 0, i32 0
  %p2 = load ptr, ptr %p, align 8
  store ptr %p2, ptr %fp, align 8
  %fp3 = getelementptr inbounds %list_List_ast_Item_, ptr %ptr, i32 0, i32 1
  store i64 0, ptr %fp3, align 8
  %fp4 = getelementptr inbounds %list_List_ast_Item_, ptr %ptr, i32 0, i32 2
  %initial_cap5 = load i64, ptr %initial_cap, align 8
  store i64 %initial_cap5, ptr %fp4, align 8
  call void @lunite_retain(ptr %ptr)
  ret ptr %ptr
}

define void @list_List_ast_Item__push(ptr %0, ptr %1) {
entry:
  %new_cap = alloca i64, align 8
  %old_cap = alloca i64, align 8
  %c = alloca i64, align 8
  %val = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %val, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_ast_Item_, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  store i64 %count, ptr %c, align 8
  %c2 = load i64, ptr %c, align 8
  %self3 = load ptr, ptr %self, align 8
  %fp4 = getelementptr inbounds %list_List_ast_Item_, ptr %self3, i32 0, i32 2
  %capacity = load i64, ptr %fp4, align 8
  %2 = icmp sge i64 %c2, %capacity
  br i1 %2, label %then, label %else

then:                                             ; preds = %body
  %self5 = load ptr, ptr %self, align 8
  %fp6 = getelementptr inbounds %list_List_ast_Item_, ptr %self5, i32 0, i32 2
  %capacity7 = load i64, ptr %fp6, align 8
  store i64 %capacity7, ptr %old_cap, align 8
  %old_cap8 = load i64, ptr %old_cap, align 8
  %3 = mul i64 %old_cap8, 2
  store i64 %3, ptr %new_cap, align 8
  %self9 = load ptr, ptr %self, align 8
  %fp10 = getelementptr inbounds %list_List_ast_Item_, ptr %self9, i32 0, i32 0
  %self11 = load ptr, ptr %self, align 8
  %fp12 = getelementptr inbounds %list_List_ast_Item_, ptr %self11, i32 0, i32 0
  %data = load ptr, ptr %fp12, align 8
  %old_cap13 = load i64, ptr %old_cap, align 8
  %4 = mul i64 %old_cap13, 8
  %new_cap14 = load i64, ptr %new_cap, align 8
  %5 = mul i64 %new_cap14, 8
  %res = call ptr @lunite_realloc(ptr %data, i64 %4, i64 %5)
  store ptr %res, ptr %fp10, align 8
  %self15 = load ptr, ptr %self, align 8
  %fp16 = getelementptr inbounds %list_List_ast_Item_, ptr %self15, i32 0, i32 2
  %new_cap17 = load i64, ptr %new_cap, align 8
  store i64 %new_cap17, ptr %fp16, align 8
  br label %cont

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else, %then
  %self18 = load ptr, ptr %self, align 8
  %fp19 = getelementptr inbounds %list_List_ast_Item_, ptr %self18, i32 0, i32 0
  %data20 = load ptr, ptr %fp19, align 8
  %c21 = load i64, ptr %c, align 8
  %ptr = getelementptr ptr, ptr %data20, i64 %c21
  %val22 = load ptr, ptr %val, align 8
  %old = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val22)
  store ptr %val22, ptr %ptr, align 8
  call void @lunite_release(ptr %old)
  %self23 = load ptr, ptr %self, align 8
  %fp24 = getelementptr inbounds %list_List_ast_Item_, ptr %self23, i32 0, i32 1
  %c25 = load i64, ptr %c, align 8
  %6 = add i64 %c25, 1
  store i64 %6, ptr %fp24, align 8
  %tmp = load ptr, ptr %val, align 8
  call void @lunite_release(ptr %tmp)
  %tmp26 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp26)
  ret void
}

define i64 @list_List_string_len(ptr %0) {
entry:
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_string, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret i64 %count
}

define ptr @list_List_string_get_ptr(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_string, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %ptr
}

define ptr @list_List_string_get(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_string, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %val = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val)
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %val
}

define ptr @list_List_string_new() {
entry:
  %p = alloca ptr, align 8
  %initial_cap = alloca i64, align 8
  br label %body

body:                                             ; preds = %entry
  store i64 10, ptr %initial_cap, align 8
  %initial_cap1 = load i64, ptr %initial_cap, align 8
  %0 = mul i64 %initial_cap1, 8
  %res = call ptr @lunite_alloc(i64 %0, i64 0, i64 0)
  store ptr %res, ptr %p, align 8
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%list_List_string, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %list_List_string, ptr %ptr, i32 0, i32 0
  %p2 = load ptr, ptr %p, align 8
  store ptr %p2, ptr %fp, align 8
  %fp3 = getelementptr inbounds %list_List_string, ptr %ptr, i32 0, i32 1
  store i64 0, ptr %fp3, align 8
  %fp4 = getelementptr inbounds %list_List_string, ptr %ptr, i32 0, i32 2
  %initial_cap5 = load i64, ptr %initial_cap, align 8
  store i64 %initial_cap5, ptr %fp4, align 8
  call void @lunite_retain(ptr %ptr)
  ret ptr %ptr
}

define void @list_List_string_push(ptr %0, ptr %1) {
entry:
  %new_cap = alloca i64, align 8
  %old_cap = alloca i64, align 8
  %c = alloca i64, align 8
  %val = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %val, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_string, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  store i64 %count, ptr %c, align 8
  %c2 = load i64, ptr %c, align 8
  %self3 = load ptr, ptr %self, align 8
  %fp4 = getelementptr inbounds %list_List_string, ptr %self3, i32 0, i32 2
  %capacity = load i64, ptr %fp4, align 8
  %2 = icmp sge i64 %c2, %capacity
  br i1 %2, label %then, label %else

then:                                             ; preds = %body
  %self5 = load ptr, ptr %self, align 8
  %fp6 = getelementptr inbounds %list_List_string, ptr %self5, i32 0, i32 2
  %capacity7 = load i64, ptr %fp6, align 8
  store i64 %capacity7, ptr %old_cap, align 8
  %old_cap8 = load i64, ptr %old_cap, align 8
  %3 = mul i64 %old_cap8, 2
  store i64 %3, ptr %new_cap, align 8
  %self9 = load ptr, ptr %self, align 8
  %fp10 = getelementptr inbounds %list_List_string, ptr %self9, i32 0, i32 0
  %self11 = load ptr, ptr %self, align 8
  %fp12 = getelementptr inbounds %list_List_string, ptr %self11, i32 0, i32 0
  %data = load ptr, ptr %fp12, align 8
  %old_cap13 = load i64, ptr %old_cap, align 8
  %4 = mul i64 %old_cap13, 8
  %new_cap14 = load i64, ptr %new_cap, align 8
  %5 = mul i64 %new_cap14, 8
  %res = call ptr @lunite_realloc(ptr %data, i64 %4, i64 %5)
  store ptr %res, ptr %fp10, align 8
  %self15 = load ptr, ptr %self, align 8
  %fp16 = getelementptr inbounds %list_List_string, ptr %self15, i32 0, i32 2
  %new_cap17 = load i64, ptr %new_cap, align 8
  store i64 %new_cap17, ptr %fp16, align 8
  br label %cont

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else, %then
  %self18 = load ptr, ptr %self, align 8
  %fp19 = getelementptr inbounds %list_List_string, ptr %self18, i32 0, i32 0
  %data20 = load ptr, ptr %fp19, align 8
  %c21 = load i64, ptr %c, align 8
  %ptr = getelementptr ptr, ptr %data20, i64 %c21
  %val22 = load ptr, ptr %val, align 8
  %old = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val22)
  store ptr %val22, ptr %ptr, align 8
  call void @lunite_release(ptr %old)
  %self23 = load ptr, ptr %self, align 8
  %fp24 = getelementptr inbounds %list_List_string, ptr %self23, i32 0, i32 1
  %c25 = load i64, ptr %c, align 8
  %6 = add i64 %c25, 1
  store i64 %6, ptr %fp24, align 8
  %tmp = load ptr, ptr %val, align 8
  call void @lunite_release(ptr %tmp)
  %tmp26 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp26)
  ret void
}

define i64 @list_List_ast.Param__len(ptr %0) {
entry:
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_ast_Param_.0, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret i64 %count
}

define ptr @list_List_ast.Param__get_ptr(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_ast_Param_.0, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %ptr
}

define ptr @list_List_ast.Param__get(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_ast_Param_.0, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %val = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val)
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %val
}

define i64 @list_List_ast_Param__len(ptr %0) {
entry:
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_ast_Param_.0, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret i64 %count
}

define ptr @list_List_ast_Param__get_ptr(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_ast_Param_.0, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %ptr
}

define ptr @list_List_ast_Param__get(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_ast_Param_.0, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %val = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val)
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %val
}

define ptr @list_List_ast_Param__new() {
entry:
  %p11 = alloca ptr, align 8
  %initial_cap8 = alloca i64, align 8
  %p = alloca ptr, align 8
  %initial_cap = alloca i64, align 8
  br label %body

body:                                             ; preds = %entry
  store i64 10, ptr %initial_cap, align 8
  %initial_cap1 = load i64, ptr %initial_cap, align 8
  %0 = mul i64 %initial_cap1, 8
  %res = call ptr @lunite_alloc(i64 %0, i64 0, i64 0)
  store ptr %res, ptr %p, align 8
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%list_List_ast_Param_.0, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %list_List_ast_Param_.0, ptr %ptr, i32 0, i32 0
  %p2 = load ptr, ptr %p, align 8
  store ptr %p2, ptr %fp, align 8
  %fp3 = getelementptr inbounds %list_List_ast_Param_.0, ptr %ptr, i32 0, i32 1
  store i64 0, ptr %fp3, align 8
  %fp4 = getelementptr inbounds %list_List_ast_Param_.0, ptr %ptr, i32 0, i32 2
  %initial_cap5 = load i64, ptr %initial_cap, align 8
  store i64 %initial_cap5, ptr %fp4, align 8
  call void @lunite_retain(ptr %ptr)
  ret ptr %ptr

entry6:                                           ; No predecessors!
  br label %body7

body7:                                            ; preds = %entry6
  store i64 10, ptr %initial_cap8, align 8
  %initial_cap9 = load i64, ptr %initial_cap8, align 8
  %1 = mul i64 %initial_cap9, 8
  %res10 = call ptr @lunite_alloc(i64 %1, i64 0, i64 0)
  store ptr %res10, ptr %p11, align 8
  %ptr12 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%list_List_ast_Param_.0, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp13 = getelementptr inbounds %list_List_ast_Param_.0, ptr %ptr12, i32 0, i32 0
  %p14 = load ptr, ptr %p11, align 8
  store ptr %p14, ptr %fp13, align 8
  %fp15 = getelementptr inbounds %list_List_ast_Param_.0, ptr %ptr12, i32 0, i32 1
  store i64 0, ptr %fp15, align 8
  %fp16 = getelementptr inbounds %list_List_ast_Param_.0, ptr %ptr12, i32 0, i32 2
  %initial_cap17 = load i64, ptr %initial_cap8, align 8
  store i64 %initial_cap17, ptr %fp16, align 8
  call void @lunite_retain(ptr %ptr12)
  ret ptr %ptr12
}

define void @list_List_ast_Param__push(ptr %0, ptr %1) {
entry:
  %new_cap47 = alloca i64, align 8
  %old_cap45 = alloca i64, align 8
  %c34 = alloca i64, align 8
  %val30 = alloca ptr, align 8
  %self29 = alloca ptr, align 8
  %new_cap = alloca i64, align 8
  %old_cap = alloca i64, align 8
  %c = alloca i64, align 8
  %val = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %val, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_ast_Param_.0, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  store i64 %count, ptr %c, align 8
  %c2 = load i64, ptr %c, align 8
  %self3 = load ptr, ptr %self, align 8
  %fp4 = getelementptr inbounds %list_List_ast_Param_.0, ptr %self3, i32 0, i32 2
  %capacity = load i64, ptr %fp4, align 8
  %2 = icmp sge i64 %c2, %capacity
  br i1 %2, label %then, label %else

then:                                             ; preds = %body
  %self5 = load ptr, ptr %self, align 8
  %fp6 = getelementptr inbounds %list_List_ast_Param_.0, ptr %self5, i32 0, i32 2
  %capacity7 = load i64, ptr %fp6, align 8
  store i64 %capacity7, ptr %old_cap, align 8
  %old_cap8 = load i64, ptr %old_cap, align 8
  %3 = mul i64 %old_cap8, 2
  store i64 %3, ptr %new_cap, align 8
  %self9 = load ptr, ptr %self, align 8
  %fp10 = getelementptr inbounds %list_List_ast_Param_.0, ptr %self9, i32 0, i32 0
  %self11 = load ptr, ptr %self, align 8
  %fp12 = getelementptr inbounds %list_List_ast_Param_.0, ptr %self11, i32 0, i32 0
  %data = load ptr, ptr %fp12, align 8
  %old_cap13 = load i64, ptr %old_cap, align 8
  %4 = mul i64 %old_cap13, 8
  %new_cap14 = load i64, ptr %new_cap, align 8
  %5 = mul i64 %new_cap14, 8
  %res = call ptr @lunite_realloc(ptr %data, i64 %4, i64 %5)
  store ptr %res, ptr %fp10, align 8
  %self15 = load ptr, ptr %self, align 8
  %fp16 = getelementptr inbounds %list_List_ast_Param_.0, ptr %self15, i32 0, i32 2
  %new_cap17 = load i64, ptr %new_cap, align 8
  store i64 %new_cap17, ptr %fp16, align 8
  br label %cont

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else, %then
  %self18 = load ptr, ptr %self, align 8
  %fp19 = getelementptr inbounds %list_List_ast_Param_.0, ptr %self18, i32 0, i32 0
  %data20 = load ptr, ptr %fp19, align 8
  %c21 = load i64, ptr %c, align 8
  %ptr = getelementptr ptr, ptr %data20, i64 %c21
  %val22 = load ptr, ptr %val, align 8
  %old = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val22)
  store ptr %val22, ptr %ptr, align 8
  call void @lunite_release(ptr %old)
  %self23 = load ptr, ptr %self, align 8
  %fp24 = getelementptr inbounds %list_List_ast_Param_.0, ptr %self23, i32 0, i32 1
  %c25 = load i64, ptr %c, align 8
  %6 = add i64 %c25, 1
  store i64 %6, ptr %fp24, align 8
  %tmp = load ptr, ptr %val, align 8
  call void @lunite_release(ptr %tmp)
  %tmp26 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp26)
  ret void

entry27:                                          ; No predecessors!
  br label %body28

body28:                                           ; preds = %entry27
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self29, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %val30, align 8
  %self31 = load ptr, ptr %self29, align 8
  %fp32 = getelementptr inbounds %list_List_ast_Param_.0, ptr %self31, i32 0, i32 1
  %count33 = load i64, ptr %fp32, align 8
  store i64 %count33, ptr %c34, align 8
  %c35 = load i64, ptr %c34, align 8
  %self36 = load ptr, ptr %self29, align 8
  %fp37 = getelementptr inbounds %list_List_ast_Param_.0, ptr %self36, i32 0, i32 2
  %capacity38 = load i64, ptr %fp37, align 8
  %7 = icmp sge i64 %c35, %capacity38
  br i1 %7, label %then39, label %else40

then39:                                           ; preds = %body28
  %self42 = load ptr, ptr %self29, align 8
  %fp43 = getelementptr inbounds %list_List_ast_Param_.0, ptr %self42, i32 0, i32 2
  %capacity44 = load i64, ptr %fp43, align 8
  store i64 %capacity44, ptr %old_cap45, align 8
  %old_cap46 = load i64, ptr %old_cap45, align 8
  %8 = mul i64 %old_cap46, 2
  store i64 %8, ptr %new_cap47, align 8
  %self48 = load ptr, ptr %self29, align 8
  %fp49 = getelementptr inbounds %list_List_ast_Param_.0, ptr %self48, i32 0, i32 0
  %self50 = load ptr, ptr %self29, align 8
  %fp51 = getelementptr inbounds %list_List_ast_Param_.0, ptr %self50, i32 0, i32 0
  %data52 = load ptr, ptr %fp51, align 8
  %old_cap53 = load i64, ptr %old_cap45, align 8
  %9 = mul i64 %old_cap53, 8
  %new_cap54 = load i64, ptr %new_cap47, align 8
  %10 = mul i64 %new_cap54, 8
  %res55 = call ptr @lunite_realloc(ptr %data52, i64 %9, i64 %10)
  store ptr %res55, ptr %fp49, align 8
  %self56 = load ptr, ptr %self29, align 8
  %fp57 = getelementptr inbounds %list_List_ast_Param_.0, ptr %self56, i32 0, i32 2
  %new_cap58 = load i64, ptr %new_cap47, align 8
  store i64 %new_cap58, ptr %fp57, align 8
  br label %cont41

else40:                                           ; preds = %body28
  br label %cont41

cont41:                                           ; preds = %else40, %then39
  %self59 = load ptr, ptr %self29, align 8
  %fp60 = getelementptr inbounds %list_List_ast_Param_.0, ptr %self59, i32 0, i32 0
  %data61 = load ptr, ptr %fp60, align 8
  %c62 = load i64, ptr %c34, align 8
  %ptr63 = getelementptr ptr, ptr %data61, i64 %c62
  %val64 = load ptr, ptr %val30, align 8
  %old65 = load ptr, ptr %ptr63, align 8
  call void @lunite_retain(ptr %val64)
  store ptr %val64, ptr %ptr63, align 8
  call void @lunite_release(ptr %old65)
  %self66 = load ptr, ptr %self29, align 8
  %fp67 = getelementptr inbounds %list_List_ast_Param_.0, ptr %self66, i32 0, i32 1
  %c68 = load i64, ptr %c34, align 8
  %11 = add i64 %c68, 1
  store i64 %11, ptr %fp67, align 8
  %tmp69 = load ptr, ptr %val30, align 8
  call void @lunite_release(ptr %tmp69)
  %tmp70 = load ptr, ptr %self29, align 8
  call void @lunite_release(ptr %tmp70)
  ret void
}

declare ptr @list_List_ast_Param__new.1()

declare void @list_List_ast_Param__push.2(ptr %0, ptr %1)

define ptr @list_List_ast.Param__new() {
entry:
  %p = alloca ptr, align 8
  %initial_cap = alloca i64, align 8
  br label %body

body:                                             ; preds = %entry
  store i64 10, ptr %initial_cap, align 8
  %initial_cap1 = load i64, ptr %initial_cap, align 8
  %0 = mul i64 %initial_cap1, 8
  %res = call ptr @lunite_alloc(i64 %0, i64 0, i64 0)
  store ptr %res, ptr %p, align 8
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%list_List_ast_Param_.0, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %list_List_ast_Param_.0, ptr %ptr, i32 0, i32 0
  %p2 = load ptr, ptr %p, align 8
  store ptr %p2, ptr %fp, align 8
  %fp3 = getelementptr inbounds %list_List_ast_Param_.0, ptr %ptr, i32 0, i32 1
  store i64 0, ptr %fp3, align 8
  %fp4 = getelementptr inbounds %list_List_ast_Param_.0, ptr %ptr, i32 0, i32 2
  %initial_cap5 = load i64, ptr %initial_cap, align 8
  store i64 %initial_cap5, ptr %fp4, align 8
  call void @lunite_retain(ptr %ptr)
  ret ptr %ptr
}

define void @list_List_ast.Param__push(ptr %0, ptr %1) {
entry:
  %new_cap = alloca i64, align 8
  %old_cap = alloca i64, align 8
  %c = alloca i64, align 8
  %val = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %val, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_ast_Param_.0, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  store i64 %count, ptr %c, align 8
  %c2 = load i64, ptr %c, align 8
  %self3 = load ptr, ptr %self, align 8
  %fp4 = getelementptr inbounds %list_List_ast_Param_.0, ptr %self3, i32 0, i32 2
  %capacity = load i64, ptr %fp4, align 8
  %2 = icmp sge i64 %c2, %capacity
  br i1 %2, label %then, label %else

then:                                             ; preds = %body
  %self5 = load ptr, ptr %self, align 8
  %fp6 = getelementptr inbounds %list_List_ast_Param_.0, ptr %self5, i32 0, i32 2
  %capacity7 = load i64, ptr %fp6, align 8
  store i64 %capacity7, ptr %old_cap, align 8
  %old_cap8 = load i64, ptr %old_cap, align 8
  %3 = mul i64 %old_cap8, 2
  store i64 %3, ptr %new_cap, align 8
  %self9 = load ptr, ptr %self, align 8
  %fp10 = getelementptr inbounds %list_List_ast_Param_.0, ptr %self9, i32 0, i32 0
  %self11 = load ptr, ptr %self, align 8
  %fp12 = getelementptr inbounds %list_List_ast_Param_.0, ptr %self11, i32 0, i32 0
  %data = load ptr, ptr %fp12, align 8
  %old_cap13 = load i64, ptr %old_cap, align 8
  %4 = mul i64 %old_cap13, 8
  %new_cap14 = load i64, ptr %new_cap, align 8
  %5 = mul i64 %new_cap14, 8
  %res = call ptr @lunite_realloc(ptr %data, i64 %4, i64 %5)
  store ptr %res, ptr %fp10, align 8
  %self15 = load ptr, ptr %self, align 8
  %fp16 = getelementptr inbounds %list_List_ast_Param_.0, ptr %self15, i32 0, i32 2
  %new_cap17 = load i64, ptr %new_cap, align 8
  store i64 %new_cap17, ptr %fp16, align 8
  br label %cont

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else, %then
  %self18 = load ptr, ptr %self, align 8
  %fp19 = getelementptr inbounds %list_List_ast_Param_.0, ptr %self18, i32 0, i32 0
  %data20 = load ptr, ptr %fp19, align 8
  %c21 = load i64, ptr %c, align 8
  %ptr = getelementptr ptr, ptr %data20, i64 %c21
  %val22 = load ptr, ptr %val, align 8
  %old = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val22)
  store ptr %val22, ptr %ptr, align 8
  call void @lunite_release(ptr %old)
  %self23 = load ptr, ptr %self, align 8
  %fp24 = getelementptr inbounds %list_List_ast_Param_.0, ptr %self23, i32 0, i32 1
  %c25 = load i64, ptr %c, align 8
  %6 = add i64 %c25, 1
  store i64 %6, ptr %fp24, align 8
  %tmp = load ptr, ptr %val, align 8
  call void @lunite_release(ptr %tmp)
  %tmp26 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp26)
  ret void
}

define i64 @list_List_ast_Type__len(ptr %0) {
entry:
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_ast_Type_, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret i64 %count
}

define ptr @list_List_ast_Type__get_ptr(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_ast_Type_, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %ptr
}

define ptr @list_List_ast_Type__get(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_ast_Type_, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %val = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val)
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %val
}

define ptr @list_List_ast_Type__new() {
entry:
  %p = alloca ptr, align 8
  %initial_cap = alloca i64, align 8
  br label %body

body:                                             ; preds = %entry
  store i64 10, ptr %initial_cap, align 8
  %initial_cap1 = load i64, ptr %initial_cap, align 8
  %0 = mul i64 %initial_cap1, 8
  %res = call ptr @lunite_alloc(i64 %0, i64 0, i64 0)
  store ptr %res, ptr %p, align 8
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%list_List_ast_Type_, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %list_List_ast_Type_, ptr %ptr, i32 0, i32 0
  %p2 = load ptr, ptr %p, align 8
  store ptr %p2, ptr %fp, align 8
  %fp3 = getelementptr inbounds %list_List_ast_Type_, ptr %ptr, i32 0, i32 1
  store i64 0, ptr %fp3, align 8
  %fp4 = getelementptr inbounds %list_List_ast_Type_, ptr %ptr, i32 0, i32 2
  %initial_cap5 = load i64, ptr %initial_cap, align 8
  store i64 %initial_cap5, ptr %fp4, align 8
  call void @lunite_retain(ptr %ptr)
  ret ptr %ptr
}

define void @list_List_ast_Type__push(ptr %0, ptr %1) {
entry:
  %new_cap = alloca i64, align 8
  %old_cap = alloca i64, align 8
  %c = alloca i64, align 8
  %val = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %val, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_ast_Type_, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  store i64 %count, ptr %c, align 8
  %c2 = load i64, ptr %c, align 8
  %self3 = load ptr, ptr %self, align 8
  %fp4 = getelementptr inbounds %list_List_ast_Type_, ptr %self3, i32 0, i32 2
  %capacity = load i64, ptr %fp4, align 8
  %2 = icmp sge i64 %c2, %capacity
  br i1 %2, label %then, label %else

then:                                             ; preds = %body
  %self5 = load ptr, ptr %self, align 8
  %fp6 = getelementptr inbounds %list_List_ast_Type_, ptr %self5, i32 0, i32 2
  %capacity7 = load i64, ptr %fp6, align 8
  store i64 %capacity7, ptr %old_cap, align 8
  %old_cap8 = load i64, ptr %old_cap, align 8
  %3 = mul i64 %old_cap8, 2
  store i64 %3, ptr %new_cap, align 8
  %self9 = load ptr, ptr %self, align 8
  %fp10 = getelementptr inbounds %list_List_ast_Type_, ptr %self9, i32 0, i32 0
  %self11 = load ptr, ptr %self, align 8
  %fp12 = getelementptr inbounds %list_List_ast_Type_, ptr %self11, i32 0, i32 0
  %data = load ptr, ptr %fp12, align 8
  %old_cap13 = load i64, ptr %old_cap, align 8
  %4 = mul i64 %old_cap13, 8
  %new_cap14 = load i64, ptr %new_cap, align 8
  %5 = mul i64 %new_cap14, 8
  %res = call ptr @lunite_realloc(ptr %data, i64 %4, i64 %5)
  store ptr %res, ptr %fp10, align 8
  %self15 = load ptr, ptr %self, align 8
  %fp16 = getelementptr inbounds %list_List_ast_Type_, ptr %self15, i32 0, i32 2
  %new_cap17 = load i64, ptr %new_cap, align 8
  store i64 %new_cap17, ptr %fp16, align 8
  br label %cont

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else, %then
  %self18 = load ptr, ptr %self, align 8
  %fp19 = getelementptr inbounds %list_List_ast_Type_, ptr %self18, i32 0, i32 0
  %data20 = load ptr, ptr %fp19, align 8
  %c21 = load i64, ptr %c, align 8
  %ptr = getelementptr ptr, ptr %data20, i64 %c21
  %val22 = load ptr, ptr %val, align 8
  %old = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val22)
  store ptr %val22, ptr %ptr, align 8
  call void @lunite_release(ptr %old)
  %self23 = load ptr, ptr %self, align 8
  %fp24 = getelementptr inbounds %list_List_ast_Type_, ptr %self23, i32 0, i32 1
  %c25 = load i64, ptr %c, align 8
  %6 = add i64 %c25, 1
  store i64 %6, ptr %fp24, align 8
  %tmp = load ptr, ptr %val, align 8
  call void @lunite_release(ptr %tmp)
  %tmp26 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp26)
  ret void
}

define i64 @list_List_ast_Statement__len(ptr %0) {
entry:
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_ast_Statement_, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret i64 %count
}

define ptr @list_List_ast_Statement__get_ptr(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_ast_Statement_, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %ptr
}

define ptr @list_List_ast_Statement__get(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_ast_Statement_, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %val = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val)
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %val
}

define ptr @list_List_ast_Statement__new() {
entry:
  %p = alloca ptr, align 8
  %initial_cap = alloca i64, align 8
  br label %body

body:                                             ; preds = %entry
  store i64 10, ptr %initial_cap, align 8
  %initial_cap1 = load i64, ptr %initial_cap, align 8
  %0 = mul i64 %initial_cap1, 8
  %res = call ptr @lunite_alloc(i64 %0, i64 0, i64 0)
  store ptr %res, ptr %p, align 8
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%list_List_ast_Statement_, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %list_List_ast_Statement_, ptr %ptr, i32 0, i32 0
  %p2 = load ptr, ptr %p, align 8
  store ptr %p2, ptr %fp, align 8
  %fp3 = getelementptr inbounds %list_List_ast_Statement_, ptr %ptr, i32 0, i32 1
  store i64 0, ptr %fp3, align 8
  %fp4 = getelementptr inbounds %list_List_ast_Statement_, ptr %ptr, i32 0, i32 2
  %initial_cap5 = load i64, ptr %initial_cap, align 8
  store i64 %initial_cap5, ptr %fp4, align 8
  call void @lunite_retain(ptr %ptr)
  ret ptr %ptr
}

define void @list_List_ast_Statement__push(ptr %0, ptr %1) {
entry:
  %new_cap = alloca i64, align 8
  %old_cap = alloca i64, align 8
  %c = alloca i64, align 8
  %val = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %val, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_ast_Statement_, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  store i64 %count, ptr %c, align 8
  %c2 = load i64, ptr %c, align 8
  %self3 = load ptr, ptr %self, align 8
  %fp4 = getelementptr inbounds %list_List_ast_Statement_, ptr %self3, i32 0, i32 2
  %capacity = load i64, ptr %fp4, align 8
  %2 = icmp sge i64 %c2, %capacity
  br i1 %2, label %then, label %else

then:                                             ; preds = %body
  %self5 = load ptr, ptr %self, align 8
  %fp6 = getelementptr inbounds %list_List_ast_Statement_, ptr %self5, i32 0, i32 2
  %capacity7 = load i64, ptr %fp6, align 8
  store i64 %capacity7, ptr %old_cap, align 8
  %old_cap8 = load i64, ptr %old_cap, align 8
  %3 = mul i64 %old_cap8, 2
  store i64 %3, ptr %new_cap, align 8
  %self9 = load ptr, ptr %self, align 8
  %fp10 = getelementptr inbounds %list_List_ast_Statement_, ptr %self9, i32 0, i32 0
  %self11 = load ptr, ptr %self, align 8
  %fp12 = getelementptr inbounds %list_List_ast_Statement_, ptr %self11, i32 0, i32 0
  %data = load ptr, ptr %fp12, align 8
  %old_cap13 = load i64, ptr %old_cap, align 8
  %4 = mul i64 %old_cap13, 8
  %new_cap14 = load i64, ptr %new_cap, align 8
  %5 = mul i64 %new_cap14, 8
  %res = call ptr @lunite_realloc(ptr %data, i64 %4, i64 %5)
  store ptr %res, ptr %fp10, align 8
  %self15 = load ptr, ptr %self, align 8
  %fp16 = getelementptr inbounds %list_List_ast_Statement_, ptr %self15, i32 0, i32 2
  %new_cap17 = load i64, ptr %new_cap, align 8
  store i64 %new_cap17, ptr %fp16, align 8
  br label %cont

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else, %then
  %self18 = load ptr, ptr %self, align 8
  %fp19 = getelementptr inbounds %list_List_ast_Statement_, ptr %self18, i32 0, i32 0
  %data20 = load ptr, ptr %fp19, align 8
  %c21 = load i64, ptr %c, align 8
  %ptr = getelementptr ptr, ptr %data20, i64 %c21
  %val22 = load ptr, ptr %val, align 8
  %old = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val22)
  store ptr %val22, ptr %ptr, align 8
  call void @lunite_release(ptr %old)
  %self23 = load ptr, ptr %self, align 8
  %fp24 = getelementptr inbounds %list_List_ast_Statement_, ptr %self23, i32 0, i32 1
  %c25 = load i64, ptr %c, align 8
  %6 = add i64 %c25, 1
  store i64 %6, ptr %fp24, align 8
  %tmp = load ptr, ptr %val, align 8
  call void @lunite_release(ptr %tmp)
  %tmp26 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp26)
  ret void
}

define i64 @list_List_ast_WhenArm__len(ptr %0) {
entry:
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_ast_WhenArm_, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret i64 %count
}

define ptr @list_List_ast_WhenArm__get_ptr(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_ast_WhenArm_, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %ptr
}

define ptr @list_List_ast_WhenArm__get(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_ast_WhenArm_, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %val = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val)
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %val
}

define ptr @list_List_ast_WhenArm__new() {
entry:
  %p = alloca ptr, align 8
  %initial_cap = alloca i64, align 8
  br label %body

body:                                             ; preds = %entry
  store i64 10, ptr %initial_cap, align 8
  %initial_cap1 = load i64, ptr %initial_cap, align 8
  %0 = mul i64 %initial_cap1, 8
  %res = call ptr @lunite_alloc(i64 %0, i64 0, i64 0)
  store ptr %res, ptr %p, align 8
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%list_List_ast_WhenArm_, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %list_List_ast_WhenArm_, ptr %ptr, i32 0, i32 0
  %p2 = load ptr, ptr %p, align 8
  store ptr %p2, ptr %fp, align 8
  %fp3 = getelementptr inbounds %list_List_ast_WhenArm_, ptr %ptr, i32 0, i32 1
  store i64 0, ptr %fp3, align 8
  %fp4 = getelementptr inbounds %list_List_ast_WhenArm_, ptr %ptr, i32 0, i32 2
  %initial_cap5 = load i64, ptr %initial_cap, align 8
  store i64 %initial_cap5, ptr %fp4, align 8
  call void @lunite_retain(ptr %ptr)
  ret ptr %ptr
}

define void @list_List_ast_WhenArm__push(ptr %0, ptr %1) {
entry:
  %new_cap = alloca i64, align 8
  %old_cap = alloca i64, align 8
  %c = alloca i64, align 8
  %val = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %val, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_ast_WhenArm_, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  store i64 %count, ptr %c, align 8
  %c2 = load i64, ptr %c, align 8
  %self3 = load ptr, ptr %self, align 8
  %fp4 = getelementptr inbounds %list_List_ast_WhenArm_, ptr %self3, i32 0, i32 2
  %capacity = load i64, ptr %fp4, align 8
  %2 = icmp sge i64 %c2, %capacity
  br i1 %2, label %then, label %else

then:                                             ; preds = %body
  %self5 = load ptr, ptr %self, align 8
  %fp6 = getelementptr inbounds %list_List_ast_WhenArm_, ptr %self5, i32 0, i32 2
  %capacity7 = load i64, ptr %fp6, align 8
  store i64 %capacity7, ptr %old_cap, align 8
  %old_cap8 = load i64, ptr %old_cap, align 8
  %3 = mul i64 %old_cap8, 2
  store i64 %3, ptr %new_cap, align 8
  %self9 = load ptr, ptr %self, align 8
  %fp10 = getelementptr inbounds %list_List_ast_WhenArm_, ptr %self9, i32 0, i32 0
  %self11 = load ptr, ptr %self, align 8
  %fp12 = getelementptr inbounds %list_List_ast_WhenArm_, ptr %self11, i32 0, i32 0
  %data = load ptr, ptr %fp12, align 8
  %old_cap13 = load i64, ptr %old_cap, align 8
  %4 = mul i64 %old_cap13, 8
  %new_cap14 = load i64, ptr %new_cap, align 8
  %5 = mul i64 %new_cap14, 8
  %res = call ptr @lunite_realloc(ptr %data, i64 %4, i64 %5)
  store ptr %res, ptr %fp10, align 8
  %self15 = load ptr, ptr %self, align 8
  %fp16 = getelementptr inbounds %list_List_ast_WhenArm_, ptr %self15, i32 0, i32 2
  %new_cap17 = load i64, ptr %new_cap, align 8
  store i64 %new_cap17, ptr %fp16, align 8
  br label %cont

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else, %then
  %self18 = load ptr, ptr %self, align 8
  %fp19 = getelementptr inbounds %list_List_ast_WhenArm_, ptr %self18, i32 0, i32 0
  %data20 = load ptr, ptr %fp19, align 8
  %c21 = load i64, ptr %c, align 8
  %ptr = getelementptr ptr, ptr %data20, i64 %c21
  %val22 = load ptr, ptr %val, align 8
  %old = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val22)
  store ptr %val22, ptr %ptr, align 8
  call void @lunite_release(ptr %old)
  %self23 = load ptr, ptr %self, align 8
  %fp24 = getelementptr inbounds %list_List_ast_WhenArm_, ptr %self23, i32 0, i32 1
  %c25 = load i64, ptr %c, align 8
  %6 = add i64 %c25, 1
  store i64 %6, ptr %fp24, align 8
  %tmp = load ptr, ptr %val, align 8
  call void @lunite_release(ptr %tmp)
  %tmp26 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp26)
  ret void
}

define i64 @list_List_ast_Expression__len(ptr %0) {
entry:
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_ast_Expression_, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret i64 %count
}

define ptr @list_List_ast_Expression__get_ptr(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_ast_Expression_, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %ptr
}

define ptr @list_List_ast_Expression__get(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_ast_Expression_, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %val = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val)
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %val
}

define ptr @list_List_ast_Expression__new() {
entry:
  %p = alloca ptr, align 8
  %initial_cap = alloca i64, align 8
  br label %body

body:                                             ; preds = %entry
  store i64 10, ptr %initial_cap, align 8
  %initial_cap1 = load i64, ptr %initial_cap, align 8
  %0 = mul i64 %initial_cap1, 8
  %res = call ptr @lunite_alloc(i64 %0, i64 0, i64 0)
  store ptr %res, ptr %p, align 8
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%list_List_ast_Expression_, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %list_List_ast_Expression_, ptr %ptr, i32 0, i32 0
  %p2 = load ptr, ptr %p, align 8
  store ptr %p2, ptr %fp, align 8
  %fp3 = getelementptr inbounds %list_List_ast_Expression_, ptr %ptr, i32 0, i32 1
  store i64 0, ptr %fp3, align 8
  %fp4 = getelementptr inbounds %list_List_ast_Expression_, ptr %ptr, i32 0, i32 2
  %initial_cap5 = load i64, ptr %initial_cap, align 8
  store i64 %initial_cap5, ptr %fp4, align 8
  call void @lunite_retain(ptr %ptr)
  ret ptr %ptr
}

define void @list_List_ast_Expression__push(ptr %0, ptr %1) {
entry:
  %new_cap = alloca i64, align 8
  %old_cap = alloca i64, align 8
  %c = alloca i64, align 8
  %val = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %val, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_ast_Expression_, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  store i64 %count, ptr %c, align 8
  %c2 = load i64, ptr %c, align 8
  %self3 = load ptr, ptr %self, align 8
  %fp4 = getelementptr inbounds %list_List_ast_Expression_, ptr %self3, i32 0, i32 2
  %capacity = load i64, ptr %fp4, align 8
  %2 = icmp sge i64 %c2, %capacity
  br i1 %2, label %then, label %else

then:                                             ; preds = %body
  %self5 = load ptr, ptr %self, align 8
  %fp6 = getelementptr inbounds %list_List_ast_Expression_, ptr %self5, i32 0, i32 2
  %capacity7 = load i64, ptr %fp6, align 8
  store i64 %capacity7, ptr %old_cap, align 8
  %old_cap8 = load i64, ptr %old_cap, align 8
  %3 = mul i64 %old_cap8, 2
  store i64 %3, ptr %new_cap, align 8
  %self9 = load ptr, ptr %self, align 8
  %fp10 = getelementptr inbounds %list_List_ast_Expression_, ptr %self9, i32 0, i32 0
  %self11 = load ptr, ptr %self, align 8
  %fp12 = getelementptr inbounds %list_List_ast_Expression_, ptr %self11, i32 0, i32 0
  %data = load ptr, ptr %fp12, align 8
  %old_cap13 = load i64, ptr %old_cap, align 8
  %4 = mul i64 %old_cap13, 8
  %new_cap14 = load i64, ptr %new_cap, align 8
  %5 = mul i64 %new_cap14, 8
  %res = call ptr @lunite_realloc(ptr %data, i64 %4, i64 %5)
  store ptr %res, ptr %fp10, align 8
  %self15 = load ptr, ptr %self, align 8
  %fp16 = getelementptr inbounds %list_List_ast_Expression_, ptr %self15, i32 0, i32 2
  %new_cap17 = load i64, ptr %new_cap, align 8
  store i64 %new_cap17, ptr %fp16, align 8
  br label %cont

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else, %then
  %self18 = load ptr, ptr %self, align 8
  %fp19 = getelementptr inbounds %list_List_ast_Expression_, ptr %self18, i32 0, i32 0
  %data20 = load ptr, ptr %fp19, align 8
  %c21 = load i64, ptr %c, align 8
  %ptr = getelementptr ptr, ptr %data20, i64 %c21
  %val22 = load ptr, ptr %val, align 8
  %old = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val22)
  store ptr %val22, ptr %ptr, align 8
  call void @lunite_release(ptr %old)
  %self23 = load ptr, ptr %self, align 8
  %fp24 = getelementptr inbounds %list_List_ast_Expression_, ptr %self23, i32 0, i32 1
  %c25 = load i64, ptr %c, align 8
  %6 = add i64 %c25, 1
  store i64 %6, ptr %fp24, align 8
  %tmp = load ptr, ptr %val, align 8
  call void @lunite_release(ptr %tmp)
  %tmp26 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp26)
  ret void
}

define i64 @main(i32 %0, ptr %1) {
entry:
  br label %body

body:                                             ; preds = %entry
  %sdata = call ptr @lunite_alloc(i64 32, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.66, i64 32, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p, align 8
  store i64 32, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  call void @string_println(ptr %sstruct)
  ret i64 0
}

declare void @lunite_print(ptr %0)

declare ptr @lunite_int_to_str(i64 %0)

define ptr @string_concat(ptr %0, ptr %1) {
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

define ptr @string_int_to_string(i64 %0) {
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

define i64 @string_char_at(ptr %0, i64 %1) {
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

define i64 @string_length(ptr %0) {
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

define ptr @string_sub(ptr %0, i64 %1, i64 %2) {
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

define void @string_print(ptr %0) {
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

define void @string_println(ptr %0) {
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.67, i64 1, i1 false)
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

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly %0, ptr noalias nocapture readonly %1, i64 %2, i1 immarg %3) #0

attributes #0 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
[CODEGEN] Mapping function: print to 0x5cbe4a5d45e0
[CODEGEN] Mapping function: lunite_print_int to 0x5cbe4a5d3380
[CODEGEN] Mapping function: lunite_print to 0x5cbe4a5d45e0
[CODEGEN] Mapping function: lunite_alloc to 0x5cbe4a5d2590
[CODEGEN] Mapping function: lunite_retain to 0x5cbe4a5d36b0
[CODEGEN] Mapping function: lunite_release to 0x5cbe4a5d33e0
[CODEGEN] Mapping function: lunite_str_eq to 0x5cbe4a5d3cd0
[CODEGEN] Mapping function: lunite_str_len_runtime to 0x5cbe4a5d4010
[CODEGEN] Mapping function: lunite_str_concat to 0x5cbe4a5d38c0
[CODEGEN] Mapping function: lunite_str_substring to 0x5cbe4a5d40b0
[CODEGEN] Mapping function: lunite_str_at to 0x5cbe4a5d3770
[CODEGEN] Mapping function: lunite_int_to_str to 0x5cbe4a5d28f0
[CODEGEN] Mapping function: lunite_io_read_file to 0x5cbe4a5d2990
[CODEGEN] Mapping function: lunite_sys_system to 0x5cbe4a5d45d0
[CODEGEN] Mapping function: lunite_sys_exit to 0x5cbe4a5d4390
[CODEGEN] Mapping function: lunite_init_args to 0x5cbe4a5d2870
[CODEGEN] Mapping function: lunite_sys_get_argc to 0x5cbe4a5d45a0
[CODEGEN] Mapping function: lunite_sys_get_arg to 0x5cbe4a5d43b0
[CODEGEN] Calling main() at address 0x7cabcb2689f0...
