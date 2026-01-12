; ModuleID = 'lunite'
source_filename = "lunite"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%parser_Parser = type { ptr, ptr, ptr }
%token_Token = type { ptr, i64, i64 }
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
%list_List_ast_Param_.6 = type { ptr, i64, i64 }
%list_List_ast_Type_ = type { ptr, i64, i64 }
%list_List_ast_Statement_ = type { ptr, i64, i64 }
%list_List_ast_WhenArm_ = type { ptr, i64, i64 }
%list_List_ast_Expression_ = type { ptr, i64, i64 }
%lexer_Lexer = type { ptr, i64, i64, i64, i64, i64 }
%codegen_c_CodegenC = type { ptr, i64, ptr, ptr, i64 }
%list_List = type { ptr, i64, i64 }
%ast_ImplDecl = type { ptr, ptr, ptr }
%ast_EnumTypePayload = type { ptr, ptr }
%ast_StructDecl = type { ptr, ptr, ptr, ptr, ptr }
%ast_Field = type { ptr, ptr, ptr }
%ast_EnumDecl = type { ptr, ptr, ptr, ptr }
%ast_EnumVariant = type { ptr, ptr }
%ast_Param = type { ptr, ptr, i1 }
%ast_StructInitExpressionPayload = type { ptr, ptr, ptr }
%ast_NamedExpression = type { ptr, ptr }
%ast_EnumVariantPatternPayload = type { ptr, ptr, ptr }
%semantic_Scope = type { ptr, i64 }
%semantic_SemanticAnalyzer = type { ptr, i64, ptr, ptr }
%semantic_Symbol = type { ptr, ptr, i1, ptr }
%ast_FunctionTypePayload = type { ptr, ptr }
%semantic_TFunctionDecl = type { ptr, ptr, ptr, ptr, ptr, i1 }
%semantic_TBlock = type { ptr }
%semantic_TExpression = type { ptr, ptr }
%semantic_TLetStatementPayload = type { ptr, ptr, ptr }
%semantic_TBinaryExpressionPayload = type { ptr, ptr, ptr }
%semantic_TCallExpressionPayload = type { ptr, ptr }
%list_List_map_MapEntry_string_semantic_Symbol__.3 = type { ptr, i64, i64 }
%list_List_map_MapEntry_K__V__.0 = type { ptr, i64, i64 }
%map_Map_string_semantic_Symbol_ = type { ptr }
%map_MapEntry_string_semantic_Symbol_.1 = type { ptr, ptr }
%list_List_semantic_Scope_ = type { ptr, i64, i64 }
%list_List_map_MapEntry_string_string_.4 = type { ptr, i64, i64 }
%map_Map_string_string = type { ptr }
%map_MapEntry_string_string.2 = type { ptr, ptr }
%list_List_semantic_TItem_.5 = type { ptr, i64, i64 }
%list_List_ast_EnumVariant_ = type { ptr, i64, i64 }
%list_List_semantic_TStatement_ = type { ptr, i64, i64 }
%list_List_semantic_TExpression_ = type { ptr, i64, i64 }

@slit = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@slit.9 = private unnamed_addr constant [6 x i8] c"error\00", align 1
@slit.10 = private unnamed_addr constant [16 x i8] c"error_semicolon\00", align 1
@slit.11 = private unnamed_addr constant [16 x i8] c"error_semicolon\00", align 1
@slit.12 = private unnamed_addr constant [6 x i8] c"error\00", align 1
@slit.13 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@slit.14 = private unnamed_addr constant [45 x i8] c"Error: Expected identifier for function name\00", align 1
@slit.15 = private unnamed_addr constant [40 x i8] c"Error: Expected '(' after function name\00", align 1
@slit.16 = private unnamed_addr constant [20 x i8] c"Error: Unknown type\00", align 1
@slit.17 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@slit.18 = private unnamed_addr constant [44 x i8] c"Error: Expected identifier in let statement\00", align 1
@slit.19 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@slit.20 = private unnamed_addr constant [42 x i8] c"Error: Expected variable name in for loop\00", align 1
@slit.21 = private unnamed_addr constant [33 x i8] c"Error: Expected 'in' in for loop\00", align 1
@slit.22 = private unnamed_addr constant [31 x i8] c"Error: Expected '(' after when\00", align 1
@slit.23 = private unnamed_addr constant [39 x i8] c"Error: Expected ')' after when subject\00", align 1
@slit.24 = private unnamed_addr constant [31 x i8] c"Error: Expected '{' after when\00", align 1
@slit.25 = private unnamed_addr constant [35 x i8] c"Error: Expected '=>' after pattern\00", align 1
@slit.26 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@slit.27 = private unnamed_addr constant [47 x i8] c"Error: Expected string literal for import path\00", align 1
@slit.28 = private unnamed_addr constant [44 x i8] c"Error: Expected identifier for import alias\00", align 1
@slit.29 = private unnamed_addr constant [20 x i8] c"Error: Expected ')'\00", align 1
@slit.30 = private unnamed_addr constant [27 x i8] c"Error: No prefix for token\00", align 1
@slit.31 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@slit.32 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@slit.33 = private unnamed_addr constant [37 x i8] c"Error: Expected field name after '.'\00", align 1
@slit.34 = private unnamed_addr constant [3 x i8] c"fn\00", align 1
@slit.35 = private unnamed_addr constant [4 x i8] c"let\00", align 1
@slit.36 = private unnamed_addr constant [7 x i8] c"return\00", align 1
@slit.37 = private unnamed_addr constant [3 x i8] c"if\00", align 1
@slit.38 = private unnamed_addr constant [5 x i8] c"else\00", align 1
@slit.39 = private unnamed_addr constant [6 x i8] c"while\00", align 1
@slit.40 = private unnamed_addr constant [4 x i8] c"for\00", align 1
@slit.41 = private unnamed_addr constant [3 x i8] c"in\00", align 1
@slit.42 = private unnamed_addr constant [7 x i8] c"struct\00", align 1
@slit.43 = private unnamed_addr constant [5 x i8] c"enum\00", align 1
@slit.44 = private unnamed_addr constant [5 x i8] c"impl\00", align 1
@slit.45 = private unnamed_addr constant [4 x i8] c"use\00", align 1
@slit.46 = private unnamed_addr constant [7 x i8] c"import\00", align 1
@slit.47 = private unnamed_addr constant [7 x i8] c"extern\00", align 1
@slit.48 = private unnamed_addr constant [7 x i8] c"native\00", align 1
@slit.49 = private unnamed_addr constant [4 x i8] c"pub\00", align 1
@slit.50 = private unnamed_addr constant [5 x i8] c"pure\00", align 1
@slit.51 = private unnamed_addr constant [4 x i8] c"req\00", align 1
@slit.52 = private unnamed_addr constant [7 x i8] c"layout\00", align 1
@slit.53 = private unnamed_addr constant [4 x i8] c"soa\00", align 1
@slit.54 = private unnamed_addr constant [3 x i8] c"as\00", align 1
@slit.55 = private unnamed_addr constant [4 x i8] c"try\00", align 1
@slit.56 = private unnamed_addr constant [6 x i8] c"catch\00", align 1
@slit.57 = private unnamed_addr constant [6 x i8] c"throw\00", align 1
@slit.58 = private unnamed_addr constant [5 x i8] c"true\00", align 1
@slit.59 = private unnamed_addr constant [6 x i8] c"false\00", align 1
@slit.60 = private unnamed_addr constant [5 x i8] c"null\00", align 1
@slit.61 = private unnamed_addr constant [4 x i8] c"mut\00", align 1
@slit.62 = private unnamed_addr constant [5 x i8] c"when\00", align 1
@slit.63 = private unnamed_addr constant [7 x i8] c"region\00", align 1
@slit.64 = private unnamed_addr constant [9 x i8] c"comptime\00", align 1
@slit.65 = private unnamed_addr constant [6 x i8] c"spawn\00", align 1
@slit.66 = private unnamed_addr constant [7 x i8] c"sizeof\00", align 1
@slit.67 = private unnamed_addr constant [4 x i8] c"int\00", align 1
@slit.68 = private unnamed_addr constant [6 x i8] c"float\00", align 1
@slit.69 = private unnamed_addr constant [5 x i8] c"bool\00", align 1
@slit.70 = private unnamed_addr constant [7 x i8] c"string\00", align 1
@slit.71 = private unnamed_addr constant [5 x i8] c"void\00", align 1
@slit.72 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@slit.73 = private unnamed_addr constant [5 x i8] c"    \00", align 1
@slit.74 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@slit.75 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@slit.76 = private unnamed_addr constant [5 x i8] c"_tmp\00", align 1
@slit.77 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@slit.78 = private unnamed_addr constant [8 x i8] c"int64_t\00", align 1
@slit.79 = private unnamed_addr constant [7 x i8] c"double\00", align 1
@slit.80 = private unnamed_addr constant [4 x i8] c"int\00", align 1
@slit.81 = private unnamed_addr constant [14 x i8] c"LuniteString*\00", align 1
@slit.82 = private unnamed_addr constant [5 x i8] c"void\00", align 1
@slit.83 = private unnamed_addr constant [2 x i8] c"*\00", align 1
@slit.84 = private unnamed_addr constant [8 x i8] c"struct \00", align 1
@slit.85 = private unnamed_addr constant [8 x i8] c"struct \00", align 1
@slit.86 = private unnamed_addr constant [6 x i8] c"void*\00", align 1
@slit.87 = private unnamed_addr constant [6 x i8] c"void*\00", align 1
@slit.88 = private unnamed_addr constant [44 x i8] c"// Generated by Lunite Self-Hosted Compiler\00", align 1
@slit.89 = private unnamed_addr constant [20 x i8] c"#include <stdint.h>\00", align 1
@slit.90 = private unnamed_addr constant [20 x i8] c"#include <stdlib.h>\00", align 1
@slit.91 = private unnamed_addr constant [20 x i8] c"#include <string.h>\00", align 1
@slit.92 = private unnamed_addr constant [19 x i8] c"#include <stdio.h>\00", align 1
@slit.93 = private unnamed_addr constant [19 x i8] c"// --- Runtime ---\00", align 1
@slit.94 = private unnamed_addr constant [56 x i8] c"typedef struct { char* ptr; size_t len; } LuniteString;\00", align 1
@slit.95 = private unnamed_addr constant [49 x i8] c"LuniteString* lunite_new_string(const char* s) {\00", align 1
@slit.96 = private unnamed_addr constant [54 x i8] c"    LuniteString* str = malloc(sizeof(LuniteString));\00", align 1
@slit.97 = private unnamed_addr constant [26 x i8] c"    str->len = strlen(s);\00", align 1
@slit.98 = private unnamed_addr constant [37 x i8] c"    str->ptr = malloc(str->len + 1);\00", align 1
@slit.99 = private unnamed_addr constant [25 x i8] c"    strcpy(str->ptr, s);\00", align 1
@slit.100 = private unnamed_addr constant [16 x i8] c"    return str;\00", align 1
@slit.101 = private unnamed_addr constant [2 x i8] c"}\00", align 1
@slit.102 = private unnamed_addr constant [75 x i8] c"int64_t lunite_str_len_runtime(LuniteString* s) { return s ? s->len : 0; }\00", align 1
@slit.103 = private unnamed_addr constant [68 x i8] c"LuniteString* lunite_str_concat(LuniteString* a, LuniteString* b) {\00", align 1
@slit.104 = private unnamed_addr constant [40 x i8] c"    if (!a) return b; if (!b) return a;\00", align 1
@slit.105 = private unnamed_addr constant [54 x i8] c"    LuniteString* res = malloc(sizeof(LuniteString));\00", align 1
@slit.106 = private unnamed_addr constant [32 x i8] c"    res->len = a->len + b->len;\00", align 1
@slit.107 = private unnamed_addr constant [37 x i8] c"    res->ptr = malloc(res->len + 1);\00", align 1
@slit.108 = private unnamed_addr constant [38 x i8] c"    memcpy(res->ptr, a->ptr, a->len);\00", align 1
@slit.109 = private unnamed_addr constant [47 x i8] c"    memcpy(res->ptr + a->len, b->ptr, b->len);\00", align 1
@slit.110 = private unnamed_addr constant [28 x i8] c"    res->ptr[res->len] = 0;\00", align 1
@slit.111 = private unnamed_addr constant [16 x i8] c"    return res;\00", align 1
@slit.112 = private unnamed_addr constant [2 x i8] c"}\00", align 1
@slit.113 = private unnamed_addr constant [67 x i8] c"void lunite_print(LuniteString* s) { if(s) printf(\22%s\22, s->ptr); }\00", align 1
@slit.114 = private unnamed_addr constant [88 x i8] c"void lunite_println(LuniteString* s) { if(s) printf(\22%s\0A\22, s->ptr); else printf(\22\0A\22); }\00", align 1
@slit.115 = private unnamed_addr constant [40 x i8] c"char* lunite_int_to_string(int64_t i) {\00", align 1
@slit.116 = private unnamed_addr constant [43 x i8] c"    char buf[32]; sprintf(buf, \22%lld\22, i);\00", align 1
@slit.117 = private unnamed_addr constant [35 x i8] c"    return lunite_new_string(buf);\00", align 1
@slit.118 = private unnamed_addr constant [2 x i8] c"}\00", align 1
@slit.119 = private unnamed_addr constant [16 x i8] c"typedef struct \00", align 1
@slit.120 = private unnamed_addr constant [3 x i8] c" {\00", align 1
@slit.121 = private unnamed_addr constant [2 x i8] c" \00", align 1
@slit.122 = private unnamed_addr constant [2 x i8] c";\00", align 1
@slit.123 = private unnamed_addr constant [3 x i8] c"} \00", align 1
@slit.124 = private unnamed_addr constant [2 x i8] c";\00", align 1
@slit.125 = private unnamed_addr constant [2 x i8] c"_\00", align 1
@slit.126 = private unnamed_addr constant [9 x i8] c"#define \00", align 1
@slit.127 = private unnamed_addr constant [2 x i8] c" \00", align 1
@slit.128 = private unnamed_addr constant [16 x i8] c"typedef struct \00", align 1
@slit.129 = private unnamed_addr constant [3 x i8] c" {\00", align 1
@slit.130 = private unnamed_addr constant [9 x i8] c"int tag;\00", align 1
@slit.131 = private unnamed_addr constant [15 x i8] c"void* payload;\00", align 1
@slit.132 = private unnamed_addr constant [3 x i8] c"} \00", align 1
@slit.133 = private unnamed_addr constant [2 x i8] c";\00", align 1
@slit.134 = private unnamed_addr constant [2 x i8] c"_\00", align 1
@slit.135 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@slit.136 = private unnamed_addr constant [3 x i8] c", \00", align 1
@slit.137 = private unnamed_addr constant [2 x i8] c"*\00", align 1
@slit.138 = private unnamed_addr constant [2 x i8] c" \00", align 1
@slit.139 = private unnamed_addr constant [2 x i8] c" \00", align 1
@slit.140 = private unnamed_addr constant [2 x i8] c"(\00", align 1
@slit.141 = private unnamed_addr constant [3 x i8] c");\00", align 1
@slit.142 = private unnamed_addr constant [2 x i8] c"1\00", align 1
@slit.143 = private unnamed_addr constant [2 x i8] c"0\00", align 1
@slit.144 = private unnamed_addr constant [5 x i8] c"NULL\00", align 1
@slit.145 = private unnamed_addr constant [20 x i8] c"lunite_new_string(\22\00", align 1
@slit.146 = private unnamed_addr constant [3 x i8] c"\22)\00", align 1
@slit.147 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@slit.148 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@slit.149 = private unnamed_addr constant [2 x i8] c"_\00", align 1
@slit.150 = private unnamed_addr constant [2 x i8] c"_\00", align 1
@slit.151 = private unnamed_addr constant [3 x i8] c"->\00", align 1
@slit.152 = private unnamed_addr constant [3 x i8] c", \00", align 1
@slit.153 = private unnamed_addr constant [2 x i8] c"(\00", align 1
@slit.154 = private unnamed_addr constant [2 x i8] c")\00", align 1
@slit.155 = private unnamed_addr constant [3 x i8] c"->\00", align 1
@slit.156 = private unnamed_addr constant [9 x i8] c"(struct \00", align 1
@slit.157 = private unnamed_addr constant [4 x i8] c"){ \00", align 1
@slit.158 = private unnamed_addr constant [3 x i8] c", \00", align 1
@slit.159 = private unnamed_addr constant [2 x i8] c".\00", align 1
@slit.160 = private unnamed_addr constant [4 x i8] c" = \00", align 1
@slit.161 = private unnamed_addr constant [3 x i8] c" }\00", align 1
@slit.162 = private unnamed_addr constant [12 x i8] c"/* expr? */\00", align 1
@slit.163 = private unnamed_addr constant [2 x i8] c"+\00", align 1
@slit.164 = private unnamed_addr constant [2 x i8] c"-\00", align 1
@slit.165 = private unnamed_addr constant [3 x i8] c"==\00", align 1
@slit.166 = private unnamed_addr constant [3 x i8] c"!=\00", align 1
@slit.167 = private unnamed_addr constant [2 x i8] c"+\00", align 1
@slit.168 = private unnamed_addr constant [6 x i8] c"void*\00", align 1
@slit.169 = private unnamed_addr constant [2 x i8] c" \00", align 1
@slit.170 = private unnamed_addr constant [2 x i8] c";\00", align 1
@slit.171 = private unnamed_addr constant [4 x i8] c" = \00", align 1
@slit.172 = private unnamed_addr constant [2 x i8] c";\00", align 1
@slit.173 = private unnamed_addr constant [8 x i8] c"return \00", align 1
@slit.174 = private unnamed_addr constant [2 x i8] c";\00", align 1
@slit.175 = private unnamed_addr constant [8 x i8] c"return;\00", align 1
@slit.176 = private unnamed_addr constant [2 x i8] c";\00", align 1
@slit.177 = private unnamed_addr constant [5 x i8] c"if (\00", align 1
@slit.178 = private unnamed_addr constant [4 x i8] c") {\00", align 1
@slit.179 = private unnamed_addr constant [9 x i8] c"} else {\00", align 1
@slit.180 = private unnamed_addr constant [2 x i8] c"}\00", align 1
@slit.181 = private unnamed_addr constant [8 x i8] c"while (\00", align 1
@slit.182 = private unnamed_addr constant [4 x i8] c") {\00", align 1
@slit.183 = private unnamed_addr constant [2 x i8] c"}\00", align 1
@slit.184 = private unnamed_addr constant [7 x i8] c"void* \00", align 1
@slit.185 = private unnamed_addr constant [4 x i8] c" = \00", align 1
@slit.186 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@slit.187 = private unnamed_addr constant [7 x i8] c" else \00", align 1
@slit.188 = private unnamed_addr constant [2 x i8] c"_\00", align 1
@slit.189 = private unnamed_addr constant [9 x i8] c"(struct \00", align 1
@slit.190 = private unnamed_addr constant [3 x i8] c")*\00", align 1
@slit.191 = private unnamed_addr constant [5 x i8] c".tag\00", align 1
@slit.192 = private unnamed_addr constant [5 x i8] c"if (\00", align 1
@slit.193 = private unnamed_addr constant [5 x i8] c" == \00", align 1
@slit.194 = private unnamed_addr constant [4 x i8] c") {\00", align 1
@slit.195 = private unnamed_addr constant [7 x i8] c"void* \00", align 1
@slit.196 = private unnamed_addr constant [13 x i8] c" = ((struct \00", align 1
@slit.197 = private unnamed_addr constant [22 x i8] c")*)subject)->payload;\00", align 1
@slit.198 = private unnamed_addr constant [9 x i8] c"if (1) {\00", align 1
@slit.199 = private unnamed_addr constant [25 x i8] c"if (0) { /* other pat */\00", align 1
@slit.200 = private unnamed_addr constant [2 x i8] c"}\00", align 1
@slit.201 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@slit.202 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@slit.203 = private unnamed_addr constant [2 x i8] c"_\00", align 1
@slit.204 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@slit.205 = private unnamed_addr constant [3 x i8] c", \00", align 1
@slit.206 = private unnamed_addr constant [2 x i8] c"*\00", align 1
@slit.207 = private unnamed_addr constant [2 x i8] c" \00", align 1
@slit.208 = private unnamed_addr constant [2 x i8] c" \00", align 1
@slit.209 = private unnamed_addr constant [2 x i8] c"(\00", align 1
@slit.210 = private unnamed_addr constant [4 x i8] c") {\00", align 1
@slit.211 = private unnamed_addr constant [2 x i8] c"}\00", align 1
@slit.212 = private unnamed_addr constant [6 x i8] c"Start\00", align 1
@slit.213 = private unnamed_addr constant [28 x i8] c"Lunite Self-Hosted Compiler\00", align 1
@slit.214 = private unnamed_addr constant [28 x i8] c"Usage: lnc [command] [file]\00", align 1
@slit.215 = private unnamed_addr constant [10 x i8] c"Commands:\00", align 1
@slit.216 = private unnamed_addr constant [41 x i8] c"  check [file]  - Check syntax and types\00", align 1
@slit.217 = private unnamed_addr constant [34 x i8] c"  build [file]  - Generate C code\00", align 1
@slit.218 = private unnamed_addr constant [24 x i8] c"Error: Missing filename\00", align 1
@slit.219 = private unnamed_addr constant [24 x i8] c"Error: Missing filename\00", align 1
@slit.220 = private unnamed_addr constant [11 x i8] c"Checking: \00", align 1
@slit.221 = private unnamed_addr constant [15 x i8] c"--- Lexing ---\00", align 1
@slit.222 = private unnamed_addr constant [16 x i8] c"--- Parsing ---\00", align 1
@slit.223 = private unnamed_addr constant [26 x i8] c"--- Semantic Analysis ---\00", align 1
@slit.224 = private unnamed_addr constant [33 x i8] c"Analysis complete. Items found: \00", align 1
@slit.225 = private unnamed_addr constant [14 x i8] c"Check passed!\00", align 1
@slit.226 = private unnamed_addr constant [11 x i8] c"Building: \00", align 1
@slit.227 = private unnamed_addr constant [15 x i8] c"--- Lexing ---\00", align 1
@slit.228 = private unnamed_addr constant [16 x i8] c"--- Parsing ---\00", align 1
@slit.229 = private unnamed_addr constant [26 x i8] c"--- Semantic Analysis ---\00", align 1
@slit.230 = private unnamed_addr constant [24 x i8] c"--- Code Generation ---\00", align 1
@slit.231 = private unnamed_addr constant [3 x i8] c".c\00", align 1
@slit.232 = private unnamed_addr constant [12 x i8] c"Generated: \00", align 1
@slit.233 = private unnamed_addr constant [16 x i8] c"Build complete!\00", align 1
@slit.234 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@slit.235 = private unnamed_addr constant [7 x i8] c"Import\00", align 1
@slit.236 = private unnamed_addr constant [58 x i8] c"Error: Item type not yet supported in semantic analyzer: \00", align 1
@slit.237 = private unnamed_addr constant [6 x i8] c"Error\00", align 1
@slit.238 = private unnamed_addr constant [43 x i8] c"Error: Statement block not yet implemented\00", align 1
@slit.239 = private unnamed_addr constant [8 x i8] c"unknown\00", align 1
@slit.240 = private unnamed_addr constant [32 x i8] c"Error: Callee is not a function\00", align 1
@slit.241 = private unnamed_addr constant [4 x i8] c"str\00", align 1
@slit.242 = private unnamed_addr constant [5 x i8] c"str_\00", align 1
@slit.243 = private unnamed_addr constant [68 x i8] c"Error: MemberAccess not yet fully supported in self-hosted analyzer\00", align 1
@slit.244 = private unnamed_addr constant [65 x i8] c"Error: Expression type not yet implemented in analyze_expression\00", align 1

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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.9, i64 5, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata27, ptr align 1 @slit.10, i64 15, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.11, i64 15, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata80, ptr align 1 @slit.12, i64 5, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.13, i64 0, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata7, ptr align 1 @slit.14, i64 44, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata14, ptr align 1 @slit.15, i64 39, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.16, i64 19, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.17, i64 0, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata9, ptr align 1 @slit.18, i64 43, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.19, i64 0, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata7, ptr align 1 @slit.20, i64 41, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata13, ptr align 1 @slit.21, i64 32, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.22, i64 30, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata16, ptr align 1 @slit.23, i64 38, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata30, ptr align 1 @slit.24, i64 30, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata64, ptr align 1 @slit.25, i64 34, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.26, i64 0, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata7, ptr align 1 @slit.27, i64 46, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata38, ptr align 1 @slit.28, i64 43, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.29, i64 19, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata213, ptr align 1 @slit.30, i64 26, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.31, i64 0, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.32, i64 0, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata7, ptr align 1 @slit.33, i64 36, i1 false)
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
  %fp = getelementptr inbounds %list_List_ast_Param_.6, ptr %self1, i32 0, i32 1
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
  %fp = getelementptr inbounds %list_List_ast_Param_.6, ptr %self1, i32 0, i32 0
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
  %fp = getelementptr inbounds %list_List_ast_Param_.6, ptr %self1, i32 0, i32 0
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
  %fp = getelementptr inbounds %list_List_ast_Param_.6, ptr %self1, i32 0, i32 1
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
  %fp = getelementptr inbounds %list_List_ast_Param_.6, ptr %self1, i32 0, i32 0
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
  %fp = getelementptr inbounds %list_List_ast_Param_.6, ptr %self1, i32 0, i32 0
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
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%list_List_ast_Param_.6, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %list_List_ast_Param_.6, ptr %ptr, i32 0, i32 0
  %p2 = load ptr, ptr %p, align 8
  store ptr %p2, ptr %fp, align 8
  %fp3 = getelementptr inbounds %list_List_ast_Param_.6, ptr %ptr, i32 0, i32 1
  store i64 0, ptr %fp3, align 8
  %fp4 = getelementptr inbounds %list_List_ast_Param_.6, ptr %ptr, i32 0, i32 2
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
  %ptr12 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%list_List_ast_Param_.6, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp13 = getelementptr inbounds %list_List_ast_Param_.6, ptr %ptr12, i32 0, i32 0
  %p14 = load ptr, ptr %p11, align 8
  store ptr %p14, ptr %fp13, align 8
  %fp15 = getelementptr inbounds %list_List_ast_Param_.6, ptr %ptr12, i32 0, i32 1
  store i64 0, ptr %fp15, align 8
  %fp16 = getelementptr inbounds %list_List_ast_Param_.6, ptr %ptr12, i32 0, i32 2
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
  %fp = getelementptr inbounds %list_List_ast_Param_.6, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  store i64 %count, ptr %c, align 8
  %c2 = load i64, ptr %c, align 8
  %self3 = load ptr, ptr %self, align 8
  %fp4 = getelementptr inbounds %list_List_ast_Param_.6, ptr %self3, i32 0, i32 2
  %capacity = load i64, ptr %fp4, align 8
  %2 = icmp sge i64 %c2, %capacity
  br i1 %2, label %then, label %else

then:                                             ; preds = %body
  %self5 = load ptr, ptr %self, align 8
  %fp6 = getelementptr inbounds %list_List_ast_Param_.6, ptr %self5, i32 0, i32 2
  %capacity7 = load i64, ptr %fp6, align 8
  store i64 %capacity7, ptr %old_cap, align 8
  %old_cap8 = load i64, ptr %old_cap, align 8
  %3 = mul i64 %old_cap8, 2
  store i64 %3, ptr %new_cap, align 8
  %self9 = load ptr, ptr %self, align 8
  %fp10 = getelementptr inbounds %list_List_ast_Param_.6, ptr %self9, i32 0, i32 0
  %self11 = load ptr, ptr %self, align 8
  %fp12 = getelementptr inbounds %list_List_ast_Param_.6, ptr %self11, i32 0, i32 0
  %data = load ptr, ptr %fp12, align 8
  %old_cap13 = load i64, ptr %old_cap, align 8
  %4 = mul i64 %old_cap13, 8
  %new_cap14 = load i64, ptr %new_cap, align 8
  %5 = mul i64 %new_cap14, 8
  %res = call ptr @lunite_realloc(ptr %data, i64 %4, i64 %5)
  store ptr %res, ptr %fp10, align 8
  %self15 = load ptr, ptr %self, align 8
  %fp16 = getelementptr inbounds %list_List_ast_Param_.6, ptr %self15, i32 0, i32 2
  %new_cap17 = load i64, ptr %new_cap, align 8
  store i64 %new_cap17, ptr %fp16, align 8
  br label %cont

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else, %then
  %self18 = load ptr, ptr %self, align 8
  %fp19 = getelementptr inbounds %list_List_ast_Param_.6, ptr %self18, i32 0, i32 0
  %data20 = load ptr, ptr %fp19, align 8
  %c21 = load i64, ptr %c, align 8
  %ptr = getelementptr ptr, ptr %data20, i64 %c21
  %val22 = load ptr, ptr %val, align 8
  %old = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val22)
  store ptr %val22, ptr %ptr, align 8
  call void @lunite_release(ptr %old)
  %self23 = load ptr, ptr %self, align 8
  %fp24 = getelementptr inbounds %list_List_ast_Param_.6, ptr %self23, i32 0, i32 1
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
  %fp32 = getelementptr inbounds %list_List_ast_Param_.6, ptr %self31, i32 0, i32 1
  %count33 = load i64, ptr %fp32, align 8
  store i64 %count33, ptr %c34, align 8
  %c35 = load i64, ptr %c34, align 8
  %self36 = load ptr, ptr %self29, align 8
  %fp37 = getelementptr inbounds %list_List_ast_Param_.6, ptr %self36, i32 0, i32 2
  %capacity38 = load i64, ptr %fp37, align 8
  %7 = icmp sge i64 %c35, %capacity38
  br i1 %7, label %then39, label %else40

then39:                                           ; preds = %body28
  %self42 = load ptr, ptr %self29, align 8
  %fp43 = getelementptr inbounds %list_List_ast_Param_.6, ptr %self42, i32 0, i32 2
  %capacity44 = load i64, ptr %fp43, align 8
  store i64 %capacity44, ptr %old_cap45, align 8
  %old_cap46 = load i64, ptr %old_cap45, align 8
  %8 = mul i64 %old_cap46, 2
  store i64 %8, ptr %new_cap47, align 8
  %self48 = load ptr, ptr %self29, align 8
  %fp49 = getelementptr inbounds %list_List_ast_Param_.6, ptr %self48, i32 0, i32 0
  %self50 = load ptr, ptr %self29, align 8
  %fp51 = getelementptr inbounds %list_List_ast_Param_.6, ptr %self50, i32 0, i32 0
  %data52 = load ptr, ptr %fp51, align 8
  %old_cap53 = load i64, ptr %old_cap45, align 8
  %9 = mul i64 %old_cap53, 8
  %new_cap54 = load i64, ptr %new_cap47, align 8
  %10 = mul i64 %new_cap54, 8
  %res55 = call ptr @lunite_realloc(ptr %data52, i64 %9, i64 %10)
  store ptr %res55, ptr %fp49, align 8
  %self56 = load ptr, ptr %self29, align 8
  %fp57 = getelementptr inbounds %list_List_ast_Param_.6, ptr %self56, i32 0, i32 2
  %new_cap58 = load i64, ptr %new_cap47, align 8
  store i64 %new_cap58, ptr %fp57, align 8
  br label %cont41

else40:                                           ; preds = %body28
  br label %cont41

cont41:                                           ; preds = %else40, %then39
  %self59 = load ptr, ptr %self29, align 8
  %fp60 = getelementptr inbounds %list_List_ast_Param_.6, ptr %self59, i32 0, i32 0
  %data61 = load ptr, ptr %fp60, align 8
  %c62 = load i64, ptr %c34, align 8
  %ptr63 = getelementptr ptr, ptr %data61, i64 %c62
  %val64 = load ptr, ptr %val30, align 8
  %old65 = load ptr, ptr %ptr63, align 8
  call void @lunite_retain(ptr %val64)
  store ptr %val64, ptr %ptr63, align 8
  call void @lunite_release(ptr %old65)
  %self66 = load ptr, ptr %self29, align 8
  %fp67 = getelementptr inbounds %list_List_ast_Param_.6, ptr %self66, i32 0, i32 1
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
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%list_List_ast_Param_.6, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %list_List_ast_Param_.6, ptr %ptr, i32 0, i32 0
  %p2 = load ptr, ptr %p, align 8
  store ptr %p2, ptr %fp, align 8
  %fp3 = getelementptr inbounds %list_List_ast_Param_.6, ptr %ptr, i32 0, i32 1
  store i64 0, ptr %fp3, align 8
  %fp4 = getelementptr inbounds %list_List_ast_Param_.6, ptr %ptr, i32 0, i32 2
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
  %fp = getelementptr inbounds %list_List_ast_Param_.6, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  store i64 %count, ptr %c, align 8
  %c2 = load i64, ptr %c, align 8
  %self3 = load ptr, ptr %self, align 8
  %fp4 = getelementptr inbounds %list_List_ast_Param_.6, ptr %self3, i32 0, i32 2
  %capacity = load i64, ptr %fp4, align 8
  %2 = icmp sge i64 %c2, %capacity
  br i1 %2, label %then, label %else

then:                                             ; preds = %body
  %self5 = load ptr, ptr %self, align 8
  %fp6 = getelementptr inbounds %list_List_ast_Param_.6, ptr %self5, i32 0, i32 2
  %capacity7 = load i64, ptr %fp6, align 8
  store i64 %capacity7, ptr %old_cap, align 8
  %old_cap8 = load i64, ptr %old_cap, align 8
  %3 = mul i64 %old_cap8, 2
  store i64 %3, ptr %new_cap, align 8
  %self9 = load ptr, ptr %self, align 8
  %fp10 = getelementptr inbounds %list_List_ast_Param_.6, ptr %self9, i32 0, i32 0
  %self11 = load ptr, ptr %self, align 8
  %fp12 = getelementptr inbounds %list_List_ast_Param_.6, ptr %self11, i32 0, i32 0
  %data = load ptr, ptr %fp12, align 8
  %old_cap13 = load i64, ptr %old_cap, align 8
  %4 = mul i64 %old_cap13, 8
  %new_cap14 = load i64, ptr %new_cap, align 8
  %5 = mul i64 %new_cap14, 8
  %res = call ptr @lunite_realloc(ptr %data, i64 %4, i64 %5)
  store ptr %res, ptr %fp10, align 8
  %self15 = load ptr, ptr %self, align 8
  %fp16 = getelementptr inbounds %list_List_ast_Param_.6, ptr %self15, i32 0, i32 2
  %new_cap17 = load i64, ptr %new_cap, align 8
  store i64 %new_cap17, ptr %fp16, align 8
  br label %cont

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else, %then
  %self18 = load ptr, ptr %self, align 8
  %fp19 = getelementptr inbounds %list_List_ast_Param_.6, ptr %self18, i32 0, i32 0
  %data20 = load ptr, ptr %fp19, align 8
  %c21 = load i64, ptr %c, align 8
  %ptr = getelementptr ptr, ptr %data20, i64 %c21
  %val22 = load ptr, ptr %val, align 8
  %old = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val22)
  store ptr %val22, ptr %ptr, align 8
  call void @lunite_release(ptr %old)
  %self23 = load ptr, ptr %self, align 8
  %fp24 = getelementptr inbounds %list_List_ast_Param_.6, ptr %self23, i32 0, i32 1
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
  %l = alloca ptr, align 8
  %input = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %input, align 8
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
  store ptr %ptr, ptr %l, align 8
  %l7 = load ptr, ptr %l, align 8
  call void @lunite_retain(ptr %l7)
  call void @lexer_Lexer_read_char(ptr %l7)
  %l8 = load ptr, ptr %l, align 8
  call void @lunite_retain(ptr %l8)
  %tmp = load ptr, ptr %l, align 8
  call void @lunite_release(ptr %tmp)
  %tmp9 = load ptr, ptr %input, align 8
  call void @lunite_release(ptr %tmp9)
  ret ptr %l8
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.34, i64 2, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata4, ptr align 1 @slit.35, i64 3, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata18, ptr align 1 @slit.36, i64 6, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata32, ptr align 1 @slit.37, i64 2, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata46, ptr align 1 @slit.38, i64 4, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata60, ptr align 1 @slit.39, i64 5, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata74, ptr align 1 @slit.40, i64 3, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata88, ptr align 1 @slit.41, i64 2, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata102, ptr align 1 @slit.42, i64 6, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata116, ptr align 1 @slit.43, i64 4, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata130, ptr align 1 @slit.44, i64 4, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata144, ptr align 1 @slit.45, i64 3, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata158, ptr align 1 @slit.46, i64 6, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata172, ptr align 1 @slit.47, i64 6, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata186, ptr align 1 @slit.48, i64 6, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata200, ptr align 1 @slit.49, i64 3, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata214, ptr align 1 @slit.50, i64 4, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata228, ptr align 1 @slit.51, i64 3, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata242, ptr align 1 @slit.52, i64 6, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata256, ptr align 1 @slit.53, i64 3, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata270, ptr align 1 @slit.54, i64 2, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata284, ptr align 1 @slit.55, i64 3, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata298, ptr align 1 @slit.56, i64 5, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata312, ptr align 1 @slit.57, i64 5, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata326, ptr align 1 @slit.58, i64 4, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata340, ptr align 1 @slit.59, i64 5, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata354, ptr align 1 @slit.60, i64 4, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata368, ptr align 1 @slit.61, i64 3, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata382, ptr align 1 @slit.62, i64 4, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata396, ptr align 1 @slit.63, i64 6, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata410, ptr align 1 @slit.64, i64 8, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata424, ptr align 1 @slit.65, i64 5, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata438, ptr align 1 @slit.66, i64 6, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata452, ptr align 1 @slit.67, i64 3, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata466, ptr align 1 @slit.68, i64 5, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata480, ptr align 1 @slit.69, i64 4, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata494, ptr align 1 @slit.70, i64 6, i1 false)
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
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata508, ptr align 1 @slit.71, i64 4, i1 false)
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

define ptr @codegen_c_CodegenC_new() {
entry:
  br label %body

body:                                             ; preds = %entry
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%codegen_c_CodegenC, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %codegen_c_CodegenC, ptr %ptr, i32 0, i32 0
  %sdata = call ptr @lunite_alloc(i64 0, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.72, i64 0, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p, align 8
  store i64 0, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  store ptr %sstruct, ptr %fp, align 8
  %fp1 = getelementptr inbounds %codegen_c_CodegenC, ptr %ptr, i32 0, i32 1
  store i64 0, ptr %fp1, align 8
  %fp2 = getelementptr inbounds %codegen_c_CodegenC, ptr %ptr, i32 0, i32 2
  %res = call ptr @map_Map_string_string_new()
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %fp2, align 8
  %fp3 = getelementptr inbounds %codegen_c_CodegenC, ptr %ptr, i32 0, i32 3
  %res4 = call ptr @map_Map_string_string_new()
  call void @lunite_retain(ptr %res4)
  store ptr %res4, ptr %fp3, align 8
  %fp5 = getelementptr inbounds %codegen_c_CodegenC, ptr %ptr, i32 0, i32 4
  store i64 0, ptr %fp5, align 8
  call void @lunite_retain(ptr %ptr)
  ret ptr %ptr
}

define void @codegen_c_CodegenC_emit(ptr %0, ptr %1) {
entry:
  %s = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %s, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %codegen_c_CodegenC, ptr %self1, i32 0, i32 0
  %self2 = load ptr, ptr %self, align 8
  %fp3 = getelementptr inbounds %codegen_c_CodegenC, ptr %self2, i32 0, i32 0
  %output = load ptr, ptr %fp3, align 8
  call void @lunite_retain(ptr %output)
  %s4 = load ptr, ptr %s, align 8
  call void @lunite_retain(ptr %s4)
  %res = call ptr @string_concat(ptr %output, ptr %s4)
  %old = load ptr, ptr %fp, align 8
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %fp, align 8
  call void @lunite_release(ptr %old)
  %tmp = load ptr, ptr %s, align 8
  call void @lunite_release(ptr %tmp)
  %tmp5 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp5)
  ret void
}

define void @codegen_c_CodegenC_emit_line(ptr %0, ptr %1) {
entry:
  %i = alloca i64, align 8
  %s = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %s, align 8
  store i64 0, ptr %i, align 8
  br label %while_cond

while_cond:                                       ; preds = %while_body, %body
  %i1 = load i64, ptr %i, align 8
  %self2 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %codegen_c_CodegenC, ptr %self2, i32 0, i32 1
  %indent = load i64, ptr %fp, align 8
  %2 = icmp slt i64 %i1, %indent
  br i1 %2, label %while_body, label %while_end

while_body:                                       ; preds = %while_cond
  %self3 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self3)
  %sdata = call ptr @lunite_alloc(i64 4, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.73, i64 4, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p, align 8
  store i64 4, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  call void @codegen_c_CodegenC_emit(ptr %self3, ptr %sstruct)
  %i4 = load i64, ptr %i, align 8
  %3 = add i64 %i4, 1
  store i64 %3, ptr %i, align 8
  br label %while_cond

while_end:                                        ; preds = %while_cond
  %self5 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self5)
  %s6 = load ptr, ptr %s, align 8
  call void @lunite_retain(ptr %s6)
  call void @codegen_c_CodegenC_emit(ptr %self5, ptr %s6)
  %self7 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self7)
  %sdata8 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata8, ptr align 1 @slit.74, i64 1, i1 false)
  %sstruct9 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p10 = getelementptr inbounds { ptr, i64 }, ptr %sstruct9, i32 0, i32 0
  %l11 = getelementptr inbounds { ptr, i64 }, ptr %sstruct9, i32 0, i32 1
  store ptr %sdata8, ptr %p10, align 8
  store i64 1, ptr %l11, align 8
  call void @lunite_retain(ptr %sstruct9)
  call void @codegen_c_CodegenC_emit(ptr %self7, ptr %sstruct9)
  %tmp = load ptr, ptr %s, align 8
  call void @lunite_release(ptr %tmp)
  %tmp12 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp12)
  ret void
}

define void @codegen_c_CodegenC_emit_newline(ptr %0) {
entry:
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self1)
  %sdata = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.75, i64 1, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p, align 8
  store i64 1, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  call void @codegen_c_CodegenC_emit(ptr %self1, ptr %sstruct)
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret void
}

define ptr @codegen_c_CodegenC_next_temp(ptr %0) {
entry:
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %codegen_c_CodegenC, ptr %self1, i32 0, i32 4
  %self2 = load ptr, ptr %self, align 8
  %fp3 = getelementptr inbounds %codegen_c_CodegenC, ptr %self2, i32 0, i32 4
  %temp_count = load i64, ptr %fp3, align 8
  %1 = add i64 %temp_count, 1
  store i64 %1, ptr %fp, align 8
  %sdata = call ptr @lunite_alloc(i64 4, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.76, i64 4, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p, align 8
  store i64 4, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  %self4 = load ptr, ptr %self, align 8
  %fp5 = getelementptr inbounds %codegen_c_CodegenC, ptr %self4, i32 0, i32 4
  %temp_count6 = load i64, ptr %fp5, align 8
  %res = call ptr @string_int_to_string(i64 %temp_count6)
  call void @lunite_retain(ptr %res)
  %res7 = call ptr @string_concat(ptr %sstruct, ptr %res)
  call void @lunite_retain(ptr %res7)
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %res7
}

define void @codegen_c_CodegenC_scan_program(ptr %0, ptr %1) {
entry:
  %a = alloca ptr, align 8
  %alias = alloca ptr, align 8
  %imp_decl = alloca ptr, align 8
  %method = alloca ptr, align 8
  %j = alloca i64, align 8
  %impl_decl = alloca ptr, align 8
  %item = alloca ptr, align 8
  %i = alloca i64, align 8
  %p = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %p, align 8
  store i64 0, ptr %i, align 8
  br label %while_cond

while_cond:                                       ; preds = %when_end, %body
  %i1 = load i64, ptr %i, align 8
  %p2 = load ptr, ptr %p, align 8
  %fp = getelementptr inbounds %ast_Program, ptr %p2, i32 0, i32 0
  %items = load ptr, ptr %fp, align 8
  %fp3 = getelementptr inbounds %list_List, ptr %items, i32 0, i32 1
  %count = load i64, ptr %fp3, align 8
  %2 = icmp slt i64 %i1, %count
  br i1 %2, label %while_body, label %while_end

while_body:                                       ; preds = %while_cond
  %p4 = load ptr, ptr %p, align 8
  %fp5 = getelementptr inbounds %ast_Program, ptr %p4, i32 0, i32 0
  %items6 = load ptr, ptr %fp5, align 8
  %fp7 = getelementptr inbounds %list_List, ptr %items6, i32 0, i32 0
  %data = load ptr, ptr %fp7, align 8
  %i8 = load i64, ptr %i, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %i8
  %val = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val)
  store ptr %val, ptr %item, align 8
  %item9 = load ptr, ptr %item, align 8
  %tptr = getelementptr inbounds { i64, [8 x i8] }, ptr %item9, i32 0, i32 0
  %tag = load i64, ptr %tptr, align 8
  %match = icmp eq i64 %tag, 6
  br i1 %match, label %when_body, label %when_next

while_end:                                        ; preds = %while_cond
  %tmp72 = load ptr, ptr %p, align 8
  call void @lunite_release(ptr %tmp72)
  %tmp73 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp73)
  ret void

when_end:                                         ; preds = %when_next68, %when_body69, %when_end45, %while_end12
  %i70 = load i64, ptr %i, align 8
  %3 = add i64 %i70, 1
  store i64 %3, ptr %i, align 8
  %tmp71 = load ptr, ptr %item, align 8
  call void @lunite_release(ptr %tmp71)
  br label %while_cond

when_next:                                        ; preds = %while_body
  %tptr36 = getelementptr inbounds { i64, [8 x i8] }, ptr %item9, i32 0, i32 0
  %tag37 = load i64, ptr %tptr36, align 8
  %match38 = icmp eq i64 %tag37, 0
  br i1 %match38, label %when_body35, label %when_next34

when_body:                                        ; preds = %while_body
  %pptr = getelementptr inbounds { i64, [8 x i8] }, ptr %item9, i32 0, i32 1
  %pval = load ptr, ptr %pptr, align 8
  call void @lunite_retain(ptr %pval)
  store ptr %pval, ptr %impl_decl, align 8
  store i64 0, ptr %j, align 8
  br label %while_cond10

while_cond10:                                     ; preds = %while_body11, %when_body
  %j13 = load i64, ptr %j, align 8
  %impl_decl14 = load ptr, ptr %impl_decl, align 8
  %fp15 = getelementptr inbounds %ast_ImplDecl, ptr %impl_decl14, i32 0, i32 2
  %methods = load ptr, ptr %fp15, align 8
  %fp16 = getelementptr inbounds %list_List, ptr %methods, i32 0, i32 1
  %count17 = load i64, ptr %fp16, align 8
  %4 = icmp slt i64 %j13, %count17
  br i1 %4, label %while_body11, label %while_end12

while_body11:                                     ; preds = %while_cond10
  %impl_decl18 = load ptr, ptr %impl_decl, align 8
  %fp19 = getelementptr inbounds %ast_ImplDecl, ptr %impl_decl18, i32 0, i32 2
  %methods20 = load ptr, ptr %fp19, align 8
  %fp21 = getelementptr inbounds %list_List, ptr %methods20, i32 0, i32 0
  %data22 = load ptr, ptr %fp21, align 8
  %j23 = load i64, ptr %j, align 8
  %ptr24 = getelementptr ptr, ptr %data22, i64 %j23
  %val25 = load ptr, ptr %ptr24, align 8
  call void @lunite_retain(ptr %val25)
  store ptr %val25, ptr %method, align 8
  %self26 = load ptr, ptr %self, align 8
  %fp27 = getelementptr inbounds %codegen_c_CodegenC, ptr %self26, i32 0, i32 2
  %method_map = load ptr, ptr %fp27, align 8
  call void @lunite_retain(ptr %method_map)
  %method28 = load ptr, ptr %method, align 8
  %fp29 = getelementptr inbounds %ast_FunctionDecl, ptr %method28, i32 0, i32 0
  %name = load ptr, ptr %fp29, align 8
  call void @lunite_retain(ptr %name)
  %impl_decl30 = load ptr, ptr %impl_decl, align 8
  %fp31 = getelementptr inbounds %ast_ImplDecl, ptr %impl_decl30, i32 0, i32 0
  %struct_name = load ptr, ptr %fp31, align 8
  call void @lunite_retain(ptr %struct_name)
  call void @map_Map_string_string_put(ptr %method_map, ptr %name, ptr %struct_name)
  %j32 = load i64, ptr %j, align 8
  %5 = add i64 %j32, 1
  store i64 %5, ptr %j, align 8
  %tmp = load ptr, ptr %method, align 8
  call void @lunite_release(ptr %tmp)
  br label %while_cond10

while_end12:                                      ; preds = %while_cond10
  %tmp33 = load ptr, ptr %impl_decl, align 8
  call void @lunite_release(ptr %tmp33)
  br label %when_end

when_next34:                                      ; preds = %when_next
  br label %when_body69

when_body35:                                      ; preds = %when_next
  %pptr39 = getelementptr inbounds { i64, [8 x i8] }, ptr %item9, i32 0, i32 1
  %pval40 = load ptr, ptr %pptr39, align 8
  call void @lunite_retain(ptr %pval40)
  store ptr %pval40, ptr %imp_decl, align 8
  %sdata = call ptr @lunite_alloc(i64 0, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.77, i64 0, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p41 = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p41, align 8
  store i64 0, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  store ptr %sstruct, ptr %alias, align 8
  %imp_decl42 = load ptr, ptr %imp_decl, align 8
  %fp43 = getelementptr inbounds %ast_ImportDecl, ptr %imp_decl42, i32 0, i32 1
  %alias44 = load ptr, ptr %fp43, align 8
  %tptr48 = getelementptr inbounds { i64, [8 x i8] }, ptr %alias44, i32 0, i32 0
  %tag49 = load i64, ptr %tptr48, align 8
  %match50 = icmp eq i64 %tag49, 0
  br i1 %match50, label %when_body47, label %when_next46

when_end45:                                       ; preds = %when_next55, %when_body56, %when_body47
  %self60 = load ptr, ptr %self, align 8
  %fp61 = getelementptr inbounds %codegen_c_CodegenC, ptr %self60, i32 0, i32 3
  %imports = load ptr, ptr %fp61, align 8
  call void @lunite_retain(ptr %imports)
  %alias62 = load ptr, ptr %alias, align 8
  call void @lunite_retain(ptr %alias62)
  %imp_decl63 = load ptr, ptr %imp_decl, align 8
  %fp64 = getelementptr inbounds %ast_ImportDecl, ptr %imp_decl63, i32 0, i32 0
  %path65 = load ptr, ptr %fp64, align 8
  call void @lunite_retain(ptr %path65)
  call void @map_Map_string_string_put(ptr %imports, ptr %alias62, ptr %path65)
  %tmp66 = load ptr, ptr %alias, align 8
  call void @lunite_release(ptr %tmp66)
  %tmp67 = load ptr, ptr %imp_decl, align 8
  call void @lunite_release(ptr %tmp67)
  br label %when_end

when_next46:                                      ; preds = %when_body35
  br label %when_body56

when_body47:                                      ; preds = %when_body35
  %pptr51 = getelementptr inbounds { i64, [8 x i8] }, ptr %alias44, i32 0, i32 1
  %pval52 = load ptr, ptr %pptr51, align 8
  call void @lunite_retain(ptr %pval52)
  store ptr %pval52, ptr %a, align 8
  %a53 = load ptr, ptr %a, align 8
  %old = load ptr, ptr %alias, align 8
  call void @lunite_retain(ptr %a53)
  store ptr %a53, ptr %alias, align 8
  call void @lunite_release(ptr %old)
  %tmp54 = load ptr, ptr %a, align 8
  call void @lunite_release(ptr %tmp54)
  br label %when_end45

when_next55:                                      ; No predecessors!
  br label %when_end45

when_body56:                                      ; preds = %when_next46
  %imp_decl57 = load ptr, ptr %imp_decl, align 8
  %fp58 = getelementptr inbounds %ast_ImportDecl, ptr %imp_decl57, i32 0, i32 0
  %path = load ptr, ptr %fp58, align 8
  %old59 = load ptr, ptr %alias, align 8
  call void @lunite_retain(ptr %path)
  store ptr %path, ptr %alias, align 8
  call void @lunite_release(ptr %old59)
  br label %when_end45

when_next68:                                      ; No predecessors!
  br label %when_end

when_body69:                                      ; preds = %when_next34
  br label %when_end
}

define ptr @codegen_c_CodegenC_gen_type(ptr %0, ptr %1) {
entry:
  %inner103 = alloca ptr, align 8
  %payload84 = alloca ptr, align 8
  %payload = alloca ptr, align 8
  %inner = alloca ptr, align 8
  %t = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %t, align 8
  %t1 = load ptr, ptr %t, align 8
  %tptr = getelementptr inbounds { i64, [8 x i8] }, ptr %t1, i32 0, i32 0
  %tag = load i64, ptr %tptr, align 8
  %match = icmp eq i64 %tag, 0
  br i1 %match, label %when_body, label %when_next

when_end:                                         ; preds = %when_next110
  %tmp118 = load ptr, ptr %t, align 8
  call void @lunite_release(ptr %tmp118)
  %tmp119 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp119)
  ret ptr null

when_next:                                        ; preds = %body
  %tptr5 = getelementptr inbounds { i64, [8 x i8] }, ptr %t1, i32 0, i32 0
  %tag6 = load i64, ptr %tptr5, align 8
  %match7 = icmp eq i64 %tag6, 1
  br i1 %match7, label %when_body4, label %when_next3

when_body:                                        ; preds = %body
  %sdata = call ptr @lunite_alloc(i64 7, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.78, i64 7, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p, align 8
  store i64 7, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  %tmp = load ptr, ptr %t, align 8
  call void @lunite_release(ptr %tmp)
  %tmp2 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp2)
  ret ptr %sstruct

when_next3:                                       ; preds = %when_next
  %tptr16 = getelementptr inbounds { i64, [8 x i8] }, ptr %t1, i32 0, i32 0
  %tag17 = load i64, ptr %tptr16, align 8
  %match18 = icmp eq i64 %tag17, 2
  br i1 %match18, label %when_body15, label %when_next14

when_body4:                                       ; preds = %when_next
  %sdata8 = call ptr @lunite_alloc(i64 6, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata8, ptr align 1 @slit.79, i64 6, i1 false)
  %sstruct9 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p10 = getelementptr inbounds { ptr, i64 }, ptr %sstruct9, i32 0, i32 0
  %l11 = getelementptr inbounds { ptr, i64 }, ptr %sstruct9, i32 0, i32 1
  store ptr %sdata8, ptr %p10, align 8
  store i64 6, ptr %l11, align 8
  call void @lunite_retain(ptr %sstruct9)
  %tmp12 = load ptr, ptr %t, align 8
  call void @lunite_release(ptr %tmp12)
  %tmp13 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp13)
  ret ptr %sstruct9

when_next14:                                      ; preds = %when_next3
  %tptr27 = getelementptr inbounds { i64, [8 x i8] }, ptr %t1, i32 0, i32 0
  %tag28 = load i64, ptr %tptr27, align 8
  %match29 = icmp eq i64 %tag28, 3
  br i1 %match29, label %when_body26, label %when_next25

when_body15:                                      ; preds = %when_next3
  %sdata19 = call ptr @lunite_alloc(i64 3, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata19, ptr align 1 @slit.80, i64 3, i1 false)
  %sstruct20 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p21 = getelementptr inbounds { ptr, i64 }, ptr %sstruct20, i32 0, i32 0
  %l22 = getelementptr inbounds { ptr, i64 }, ptr %sstruct20, i32 0, i32 1
  store ptr %sdata19, ptr %p21, align 8
  store i64 3, ptr %l22, align 8
  call void @lunite_retain(ptr %sstruct20)
  %tmp23 = load ptr, ptr %t, align 8
  call void @lunite_release(ptr %tmp23)
  %tmp24 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp24)
  ret ptr %sstruct20

when_next25:                                      ; preds = %when_next14
  %tptr38 = getelementptr inbounds { i64, [8 x i8] }, ptr %t1, i32 0, i32 0
  %tag39 = load i64, ptr %tptr38, align 8
  %match40 = icmp eq i64 %tag39, 4
  br i1 %match40, label %when_body37, label %when_next36

when_body26:                                      ; preds = %when_next14
  %sdata30 = call ptr @lunite_alloc(i64 13, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata30, ptr align 1 @slit.81, i64 13, i1 false)
  %sstruct31 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p32 = getelementptr inbounds { ptr, i64 }, ptr %sstruct31, i32 0, i32 0
  %l33 = getelementptr inbounds { ptr, i64 }, ptr %sstruct31, i32 0, i32 1
  store ptr %sdata30, ptr %p32, align 8
  store i64 13, ptr %l33, align 8
  call void @lunite_retain(ptr %sstruct31)
  %tmp34 = load ptr, ptr %t, align 8
  call void @lunite_release(ptr %tmp34)
  %tmp35 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp35)
  ret ptr %sstruct31

when_next36:                                      ; preds = %when_next25
  %tptr49 = getelementptr inbounds { i64, [8 x i8] }, ptr %t1, i32 0, i32 0
  %tag50 = load i64, ptr %tptr49, align 8
  %match51 = icmp eq i64 %tag50, 8
  br i1 %match51, label %when_body48, label %when_next47

when_body37:                                      ; preds = %when_next25
  %sdata41 = call ptr @lunite_alloc(i64 4, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata41, ptr align 1 @slit.82, i64 4, i1 false)
  %sstruct42 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p43 = getelementptr inbounds { ptr, i64 }, ptr %sstruct42, i32 0, i32 0
  %l44 = getelementptr inbounds { ptr, i64 }, ptr %sstruct42, i32 0, i32 1
  store ptr %sdata41, ptr %p43, align 8
  store i64 4, ptr %l44, align 8
  call void @lunite_retain(ptr %sstruct42)
  %tmp45 = load ptr, ptr %t, align 8
  call void @lunite_release(ptr %tmp45)
  %tmp46 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp46)
  ret ptr %sstruct42

when_next47:                                      ; preds = %when_next36
  %tptr63 = getelementptr inbounds { i64, [8 x i8] }, ptr %t1, i32 0, i32 0
  %tag64 = load i64, ptr %tptr63, align 8
  %match65 = icmp eq i64 %tag64, 5
  br i1 %match65, label %when_body62, label %when_next61

when_body48:                                      ; preds = %when_next36
  %pptr = getelementptr inbounds { i64, [8 x i8] }, ptr %t1, i32 0, i32 1
  %pval = load ptr, ptr %pptr, align 8
  store ptr %pval, ptr %inner, align 8
  %self52 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self52)
  %inner53 = load ptr, ptr %inner, align 8
  %deref = load ptr, ptr %inner53, align 8
  call void @lunite_retain(ptr %deref)
  %res = call ptr @codegen_c_CodegenC_gen_type(ptr %self52, ptr %deref)
  call void @lunite_retain(ptr %res)
  %sdata54 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata54, ptr align 1 @slit.83, i64 1, i1 false)
  %sstruct55 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p56 = getelementptr inbounds { ptr, i64 }, ptr %sstruct55, i32 0, i32 0
  %l57 = getelementptr inbounds { ptr, i64 }, ptr %sstruct55, i32 0, i32 1
  store ptr %sdata54, ptr %p56, align 8
  store i64 1, ptr %l57, align 8
  call void @lunite_retain(ptr %sstruct55)
  %res58 = call ptr @string_concat(ptr %res, ptr %sstruct55)
  call void @lunite_retain(ptr %res58)
  %tmp59 = load ptr, ptr %t, align 8
  call void @lunite_release(ptr %tmp59)
  %tmp60 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp60)
  ret ptr %res58

when_next61:                                      ; preds = %when_next47
  %tptr79 = getelementptr inbounds { i64, [8 x i8] }, ptr %t1, i32 0, i32 0
  %tag80 = load i64, ptr %tptr79, align 8
  %match81 = icmp eq i64 %tag80, 6
  br i1 %match81, label %when_body78, label %when_next77

when_body62:                                      ; preds = %when_next47
  %pptr66 = getelementptr inbounds { i64, [8 x i8] }, ptr %t1, i32 0, i32 1
  %pval67 = load ptr, ptr %pptr66, align 8
  call void @lunite_retain(ptr %pval67)
  store ptr %pval67, ptr %payload, align 8
  %sdata68 = call ptr @lunite_alloc(i64 7, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata68, ptr align 1 @slit.84, i64 7, i1 false)
  %sstruct69 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p70 = getelementptr inbounds { ptr, i64 }, ptr %sstruct69, i32 0, i32 0
  %l71 = getelementptr inbounds { ptr, i64 }, ptr %sstruct69, i32 0, i32 1
  store ptr %sdata68, ptr %p70, align 8
  store i64 7, ptr %l71, align 8
  call void @lunite_retain(ptr %sstruct69)
  %payload72 = load ptr, ptr %payload, align 8
  %fp = getelementptr inbounds %ast_CustomTypePayload, ptr %payload72, i32 0, i32 0
  %name = load ptr, ptr %fp, align 8
  call void @lunite_retain(ptr %name)
  %res73 = call ptr @string_concat(ptr %sstruct69, ptr %name)
  call void @lunite_retain(ptr %res73)
  %tmp74 = load ptr, ptr %payload, align 8
  call void @lunite_release(ptr %tmp74)
  %tmp75 = load ptr, ptr %t, align 8
  call void @lunite_release(ptr %tmp75)
  %tmp76 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp76)
  ret ptr %res73

when_next77:                                      ; preds = %when_next61
  %tptr98 = getelementptr inbounds { i64, [8 x i8] }, ptr %t1, i32 0, i32 0
  %tag99 = load i64, ptr %tptr98, align 8
  %match100 = icmp eq i64 %tag99, 11
  br i1 %match100, label %when_body97, label %when_next96

when_body78:                                      ; preds = %when_next61
  %pptr82 = getelementptr inbounds { i64, [8 x i8] }, ptr %t1, i32 0, i32 1
  %pval83 = load ptr, ptr %pptr82, align 8
  call void @lunite_retain(ptr %pval83)
  store ptr %pval83, ptr %payload84, align 8
  %sdata85 = call ptr @lunite_alloc(i64 7, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata85, ptr align 1 @slit.85, i64 7, i1 false)
  %sstruct86 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p87 = getelementptr inbounds { ptr, i64 }, ptr %sstruct86, i32 0, i32 0
  %l88 = getelementptr inbounds { ptr, i64 }, ptr %sstruct86, i32 0, i32 1
  store ptr %sdata85, ptr %p87, align 8
  store i64 7, ptr %l88, align 8
  call void @lunite_retain(ptr %sstruct86)
  %payload89 = load ptr, ptr %payload84, align 8
  %fp90 = getelementptr inbounds %ast_EnumTypePayload, ptr %payload89, i32 0, i32 0
  %name91 = load ptr, ptr %fp90, align 8
  call void @lunite_retain(ptr %name91)
  %res92 = call ptr @string_concat(ptr %sstruct86, ptr %name91)
  call void @lunite_retain(ptr %res92)
  %tmp93 = load ptr, ptr %payload84, align 8
  call void @lunite_release(ptr %tmp93)
  %tmp94 = load ptr, ptr %t, align 8
  call void @lunite_release(ptr %tmp94)
  %tmp95 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp95)
  ret ptr %res92

when_next96:                                      ; preds = %when_next77
  br label %when_body111

when_body97:                                      ; preds = %when_next77
  %pptr101 = getelementptr inbounds { i64, [8 x i8] }, ptr %t1, i32 0, i32 1
  %pval102 = load ptr, ptr %pptr101, align 8
  store ptr %pval102, ptr %inner103, align 8
  %sdata104 = call ptr @lunite_alloc(i64 5, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata104, ptr align 1 @slit.86, i64 5, i1 false)
  %sstruct105 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p106 = getelementptr inbounds { ptr, i64 }, ptr %sstruct105, i32 0, i32 0
  %l107 = getelementptr inbounds { ptr, i64 }, ptr %sstruct105, i32 0, i32 1
  store ptr %sdata104, ptr %p106, align 8
  store i64 5, ptr %l107, align 8
  call void @lunite_retain(ptr %sstruct105)
  %tmp108 = load ptr, ptr %t, align 8
  call void @lunite_release(ptr %tmp108)
  %tmp109 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp109)
  ret ptr %sstruct105

when_next110:                                     ; No predecessors!
  br label %when_end

when_body111:                                     ; preds = %when_next96
  %sdata112 = call ptr @lunite_alloc(i64 5, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata112, ptr align 1 @slit.87, i64 5, i1 false)
  %sstruct113 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p114 = getelementptr inbounds { ptr, i64 }, ptr %sstruct113, i32 0, i32 0
  %l115 = getelementptr inbounds { ptr, i64 }, ptr %sstruct113, i32 0, i32 1
  store ptr %sdata112, ptr %p114, align 8
  store i64 5, ptr %l115, align 8
  call void @lunite_retain(ptr %sstruct113)
  %tmp116 = load ptr, ptr %t, align 8
  call void @lunite_release(ptr %tmp116)
  %tmp117 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp117)
  ret ptr %sstruct113
}

define void @codegen_c_CodegenC_gen_header(ptr %0) {
entry:
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self1)
  %sdata = call ptr @lunite_alloc(i64 43, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.88, i64 43, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p, align 8
  store i64 43, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  call void @codegen_c_CodegenC_emit_line(ptr %self1, ptr %sstruct)
  %self2 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self2)
  %sdata3 = call ptr @lunite_alloc(i64 19, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata3, ptr align 1 @slit.89, i64 19, i1 false)
  %sstruct4 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p5 = getelementptr inbounds { ptr, i64 }, ptr %sstruct4, i32 0, i32 0
  %l6 = getelementptr inbounds { ptr, i64 }, ptr %sstruct4, i32 0, i32 1
  store ptr %sdata3, ptr %p5, align 8
  store i64 19, ptr %l6, align 8
  call void @lunite_retain(ptr %sstruct4)
  call void @codegen_c_CodegenC_emit_line(ptr %self2, ptr %sstruct4)
  %self7 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self7)
  %sdata8 = call ptr @lunite_alloc(i64 19, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata8, ptr align 1 @slit.90, i64 19, i1 false)
  %sstruct9 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p10 = getelementptr inbounds { ptr, i64 }, ptr %sstruct9, i32 0, i32 0
  %l11 = getelementptr inbounds { ptr, i64 }, ptr %sstruct9, i32 0, i32 1
  store ptr %sdata8, ptr %p10, align 8
  store i64 19, ptr %l11, align 8
  call void @lunite_retain(ptr %sstruct9)
  call void @codegen_c_CodegenC_emit_line(ptr %self7, ptr %sstruct9)
  %self12 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self12)
  %sdata13 = call ptr @lunite_alloc(i64 19, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata13, ptr align 1 @slit.91, i64 19, i1 false)
  %sstruct14 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p15 = getelementptr inbounds { ptr, i64 }, ptr %sstruct14, i32 0, i32 0
  %l16 = getelementptr inbounds { ptr, i64 }, ptr %sstruct14, i32 0, i32 1
  store ptr %sdata13, ptr %p15, align 8
  store i64 19, ptr %l16, align 8
  call void @lunite_retain(ptr %sstruct14)
  call void @codegen_c_CodegenC_emit_line(ptr %self12, ptr %sstruct14)
  %self17 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self17)
  %sdata18 = call ptr @lunite_alloc(i64 18, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata18, ptr align 1 @slit.92, i64 18, i1 false)
  %sstruct19 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p20 = getelementptr inbounds { ptr, i64 }, ptr %sstruct19, i32 0, i32 0
  %l21 = getelementptr inbounds { ptr, i64 }, ptr %sstruct19, i32 0, i32 1
  store ptr %sdata18, ptr %p20, align 8
  store i64 18, ptr %l21, align 8
  call void @lunite_retain(ptr %sstruct19)
  call void @codegen_c_CodegenC_emit_line(ptr %self17, ptr %sstruct19)
  %self22 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self22)
  call void @codegen_c_CodegenC_emit_newline(ptr %self22)
  %self23 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self23)
  %sdata24 = call ptr @lunite_alloc(i64 18, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata24, ptr align 1 @slit.93, i64 18, i1 false)
  %sstruct25 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p26 = getelementptr inbounds { ptr, i64 }, ptr %sstruct25, i32 0, i32 0
  %l27 = getelementptr inbounds { ptr, i64 }, ptr %sstruct25, i32 0, i32 1
  store ptr %sdata24, ptr %p26, align 8
  store i64 18, ptr %l27, align 8
  call void @lunite_retain(ptr %sstruct25)
  call void @codegen_c_CodegenC_emit_line(ptr %self23, ptr %sstruct25)
  %self28 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self28)
  %sdata29 = call ptr @lunite_alloc(i64 55, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata29, ptr align 1 @slit.94, i64 55, i1 false)
  %sstruct30 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p31 = getelementptr inbounds { ptr, i64 }, ptr %sstruct30, i32 0, i32 0
  %l32 = getelementptr inbounds { ptr, i64 }, ptr %sstruct30, i32 0, i32 1
  store ptr %sdata29, ptr %p31, align 8
  store i64 55, ptr %l32, align 8
  call void @lunite_retain(ptr %sstruct30)
  call void @codegen_c_CodegenC_emit_line(ptr %self28, ptr %sstruct30)
  %self33 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self33)
  %sdata34 = call ptr @lunite_alloc(i64 48, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata34, ptr align 1 @slit.95, i64 48, i1 false)
  %sstruct35 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p36 = getelementptr inbounds { ptr, i64 }, ptr %sstruct35, i32 0, i32 0
  %l37 = getelementptr inbounds { ptr, i64 }, ptr %sstruct35, i32 0, i32 1
  store ptr %sdata34, ptr %p36, align 8
  store i64 48, ptr %l37, align 8
  call void @lunite_retain(ptr %sstruct35)
  call void @codegen_c_CodegenC_emit_line(ptr %self33, ptr %sstruct35)
  %self38 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self38)
  %sdata39 = call ptr @lunite_alloc(i64 53, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata39, ptr align 1 @slit.96, i64 53, i1 false)
  %sstruct40 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p41 = getelementptr inbounds { ptr, i64 }, ptr %sstruct40, i32 0, i32 0
  %l42 = getelementptr inbounds { ptr, i64 }, ptr %sstruct40, i32 0, i32 1
  store ptr %sdata39, ptr %p41, align 8
  store i64 53, ptr %l42, align 8
  call void @lunite_retain(ptr %sstruct40)
  call void @codegen_c_CodegenC_emit_line(ptr %self38, ptr %sstruct40)
  %self43 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self43)
  %sdata44 = call ptr @lunite_alloc(i64 25, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata44, ptr align 1 @slit.97, i64 25, i1 false)
  %sstruct45 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p46 = getelementptr inbounds { ptr, i64 }, ptr %sstruct45, i32 0, i32 0
  %l47 = getelementptr inbounds { ptr, i64 }, ptr %sstruct45, i32 0, i32 1
  store ptr %sdata44, ptr %p46, align 8
  store i64 25, ptr %l47, align 8
  call void @lunite_retain(ptr %sstruct45)
  call void @codegen_c_CodegenC_emit_line(ptr %self43, ptr %sstruct45)
  %self48 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self48)
  %sdata49 = call ptr @lunite_alloc(i64 36, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata49, ptr align 1 @slit.98, i64 36, i1 false)
  %sstruct50 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p51 = getelementptr inbounds { ptr, i64 }, ptr %sstruct50, i32 0, i32 0
  %l52 = getelementptr inbounds { ptr, i64 }, ptr %sstruct50, i32 0, i32 1
  store ptr %sdata49, ptr %p51, align 8
  store i64 36, ptr %l52, align 8
  call void @lunite_retain(ptr %sstruct50)
  call void @codegen_c_CodegenC_emit_line(ptr %self48, ptr %sstruct50)
  %self53 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self53)
  %sdata54 = call ptr @lunite_alloc(i64 24, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata54, ptr align 1 @slit.99, i64 24, i1 false)
  %sstruct55 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p56 = getelementptr inbounds { ptr, i64 }, ptr %sstruct55, i32 0, i32 0
  %l57 = getelementptr inbounds { ptr, i64 }, ptr %sstruct55, i32 0, i32 1
  store ptr %sdata54, ptr %p56, align 8
  store i64 24, ptr %l57, align 8
  call void @lunite_retain(ptr %sstruct55)
  call void @codegen_c_CodegenC_emit_line(ptr %self53, ptr %sstruct55)
  %self58 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self58)
  %sdata59 = call ptr @lunite_alloc(i64 15, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata59, ptr align 1 @slit.100, i64 15, i1 false)
  %sstruct60 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p61 = getelementptr inbounds { ptr, i64 }, ptr %sstruct60, i32 0, i32 0
  %l62 = getelementptr inbounds { ptr, i64 }, ptr %sstruct60, i32 0, i32 1
  store ptr %sdata59, ptr %p61, align 8
  store i64 15, ptr %l62, align 8
  call void @lunite_retain(ptr %sstruct60)
  call void @codegen_c_CodegenC_emit_line(ptr %self58, ptr %sstruct60)
  %self63 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self63)
  %sdata64 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata64, ptr align 1 @slit.101, i64 1, i1 false)
  %sstruct65 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p66 = getelementptr inbounds { ptr, i64 }, ptr %sstruct65, i32 0, i32 0
  %l67 = getelementptr inbounds { ptr, i64 }, ptr %sstruct65, i32 0, i32 1
  store ptr %sdata64, ptr %p66, align 8
  store i64 1, ptr %l67, align 8
  call void @lunite_retain(ptr %sstruct65)
  call void @codegen_c_CodegenC_emit_line(ptr %self63, ptr %sstruct65)
  %self68 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self68)
  %sdata69 = call ptr @lunite_alloc(i64 74, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata69, ptr align 1 @slit.102, i64 74, i1 false)
  %sstruct70 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p71 = getelementptr inbounds { ptr, i64 }, ptr %sstruct70, i32 0, i32 0
  %l72 = getelementptr inbounds { ptr, i64 }, ptr %sstruct70, i32 0, i32 1
  store ptr %sdata69, ptr %p71, align 8
  store i64 74, ptr %l72, align 8
  call void @lunite_retain(ptr %sstruct70)
  call void @codegen_c_CodegenC_emit_line(ptr %self68, ptr %sstruct70)
  %self73 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self73)
  %sdata74 = call ptr @lunite_alloc(i64 67, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata74, ptr align 1 @slit.103, i64 67, i1 false)
  %sstruct75 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p76 = getelementptr inbounds { ptr, i64 }, ptr %sstruct75, i32 0, i32 0
  %l77 = getelementptr inbounds { ptr, i64 }, ptr %sstruct75, i32 0, i32 1
  store ptr %sdata74, ptr %p76, align 8
  store i64 67, ptr %l77, align 8
  call void @lunite_retain(ptr %sstruct75)
  call void @codegen_c_CodegenC_emit_line(ptr %self73, ptr %sstruct75)
  %self78 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self78)
  %sdata79 = call ptr @lunite_alloc(i64 39, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata79, ptr align 1 @slit.104, i64 39, i1 false)
  %sstruct80 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p81 = getelementptr inbounds { ptr, i64 }, ptr %sstruct80, i32 0, i32 0
  %l82 = getelementptr inbounds { ptr, i64 }, ptr %sstruct80, i32 0, i32 1
  store ptr %sdata79, ptr %p81, align 8
  store i64 39, ptr %l82, align 8
  call void @lunite_retain(ptr %sstruct80)
  call void @codegen_c_CodegenC_emit_line(ptr %self78, ptr %sstruct80)
  %self83 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self83)
  %sdata84 = call ptr @lunite_alloc(i64 53, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata84, ptr align 1 @slit.105, i64 53, i1 false)
  %sstruct85 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p86 = getelementptr inbounds { ptr, i64 }, ptr %sstruct85, i32 0, i32 0
  %l87 = getelementptr inbounds { ptr, i64 }, ptr %sstruct85, i32 0, i32 1
  store ptr %sdata84, ptr %p86, align 8
  store i64 53, ptr %l87, align 8
  call void @lunite_retain(ptr %sstruct85)
  call void @codegen_c_CodegenC_emit_line(ptr %self83, ptr %sstruct85)
  %self88 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self88)
  %sdata89 = call ptr @lunite_alloc(i64 31, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata89, ptr align 1 @slit.106, i64 31, i1 false)
  %sstruct90 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p91 = getelementptr inbounds { ptr, i64 }, ptr %sstruct90, i32 0, i32 0
  %l92 = getelementptr inbounds { ptr, i64 }, ptr %sstruct90, i32 0, i32 1
  store ptr %sdata89, ptr %p91, align 8
  store i64 31, ptr %l92, align 8
  call void @lunite_retain(ptr %sstruct90)
  call void @codegen_c_CodegenC_emit_line(ptr %self88, ptr %sstruct90)
  %self93 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self93)
  %sdata94 = call ptr @lunite_alloc(i64 36, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata94, ptr align 1 @slit.107, i64 36, i1 false)
  %sstruct95 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p96 = getelementptr inbounds { ptr, i64 }, ptr %sstruct95, i32 0, i32 0
  %l97 = getelementptr inbounds { ptr, i64 }, ptr %sstruct95, i32 0, i32 1
  store ptr %sdata94, ptr %p96, align 8
  store i64 36, ptr %l97, align 8
  call void @lunite_retain(ptr %sstruct95)
  call void @codegen_c_CodegenC_emit_line(ptr %self93, ptr %sstruct95)
  %self98 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self98)
  %sdata99 = call ptr @lunite_alloc(i64 37, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata99, ptr align 1 @slit.108, i64 37, i1 false)
  %sstruct100 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p101 = getelementptr inbounds { ptr, i64 }, ptr %sstruct100, i32 0, i32 0
  %l102 = getelementptr inbounds { ptr, i64 }, ptr %sstruct100, i32 0, i32 1
  store ptr %sdata99, ptr %p101, align 8
  store i64 37, ptr %l102, align 8
  call void @lunite_retain(ptr %sstruct100)
  call void @codegen_c_CodegenC_emit_line(ptr %self98, ptr %sstruct100)
  %self103 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self103)
  %sdata104 = call ptr @lunite_alloc(i64 46, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata104, ptr align 1 @slit.109, i64 46, i1 false)
  %sstruct105 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p106 = getelementptr inbounds { ptr, i64 }, ptr %sstruct105, i32 0, i32 0
  %l107 = getelementptr inbounds { ptr, i64 }, ptr %sstruct105, i32 0, i32 1
  store ptr %sdata104, ptr %p106, align 8
  store i64 46, ptr %l107, align 8
  call void @lunite_retain(ptr %sstruct105)
  call void @codegen_c_CodegenC_emit_line(ptr %self103, ptr %sstruct105)
  %self108 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self108)
  %sdata109 = call ptr @lunite_alloc(i64 27, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata109, ptr align 1 @slit.110, i64 27, i1 false)
  %sstruct110 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p111 = getelementptr inbounds { ptr, i64 }, ptr %sstruct110, i32 0, i32 0
  %l112 = getelementptr inbounds { ptr, i64 }, ptr %sstruct110, i32 0, i32 1
  store ptr %sdata109, ptr %p111, align 8
  store i64 27, ptr %l112, align 8
  call void @lunite_retain(ptr %sstruct110)
  call void @codegen_c_CodegenC_emit_line(ptr %self108, ptr %sstruct110)
  %self113 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self113)
  %sdata114 = call ptr @lunite_alloc(i64 15, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata114, ptr align 1 @slit.111, i64 15, i1 false)
  %sstruct115 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p116 = getelementptr inbounds { ptr, i64 }, ptr %sstruct115, i32 0, i32 0
  %l117 = getelementptr inbounds { ptr, i64 }, ptr %sstruct115, i32 0, i32 1
  store ptr %sdata114, ptr %p116, align 8
  store i64 15, ptr %l117, align 8
  call void @lunite_retain(ptr %sstruct115)
  call void @codegen_c_CodegenC_emit_line(ptr %self113, ptr %sstruct115)
  %self118 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self118)
  %sdata119 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata119, ptr align 1 @slit.112, i64 1, i1 false)
  %sstruct120 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p121 = getelementptr inbounds { ptr, i64 }, ptr %sstruct120, i32 0, i32 0
  %l122 = getelementptr inbounds { ptr, i64 }, ptr %sstruct120, i32 0, i32 1
  store ptr %sdata119, ptr %p121, align 8
  store i64 1, ptr %l122, align 8
  call void @lunite_retain(ptr %sstruct120)
  call void @codegen_c_CodegenC_emit_line(ptr %self118, ptr %sstruct120)
  %self123 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self123)
  %sdata124 = call ptr @lunite_alloc(i64 66, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata124, ptr align 1 @slit.113, i64 66, i1 false)
  %sstruct125 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p126 = getelementptr inbounds { ptr, i64 }, ptr %sstruct125, i32 0, i32 0
  %l127 = getelementptr inbounds { ptr, i64 }, ptr %sstruct125, i32 0, i32 1
  store ptr %sdata124, ptr %p126, align 8
  store i64 66, ptr %l127, align 8
  call void @lunite_retain(ptr %sstruct125)
  call void @codegen_c_CodegenC_emit_line(ptr %self123, ptr %sstruct125)
  %self128 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self128)
  %sdata129 = call ptr @lunite_alloc(i64 87, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata129, ptr align 1 @slit.114, i64 87, i1 false)
  %sstruct130 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p131 = getelementptr inbounds { ptr, i64 }, ptr %sstruct130, i32 0, i32 0
  %l132 = getelementptr inbounds { ptr, i64 }, ptr %sstruct130, i32 0, i32 1
  store ptr %sdata129, ptr %p131, align 8
  store i64 87, ptr %l132, align 8
  call void @lunite_retain(ptr %sstruct130)
  call void @codegen_c_CodegenC_emit_line(ptr %self128, ptr %sstruct130)
  %self133 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self133)
  %sdata134 = call ptr @lunite_alloc(i64 39, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata134, ptr align 1 @slit.115, i64 39, i1 false)
  %sstruct135 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p136 = getelementptr inbounds { ptr, i64 }, ptr %sstruct135, i32 0, i32 0
  %l137 = getelementptr inbounds { ptr, i64 }, ptr %sstruct135, i32 0, i32 1
  store ptr %sdata134, ptr %p136, align 8
  store i64 39, ptr %l137, align 8
  call void @lunite_retain(ptr %sstruct135)
  call void @codegen_c_CodegenC_emit_line(ptr %self133, ptr %sstruct135)
  %self138 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self138)
  %sdata139 = call ptr @lunite_alloc(i64 42, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata139, ptr align 1 @slit.116, i64 42, i1 false)
  %sstruct140 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p141 = getelementptr inbounds { ptr, i64 }, ptr %sstruct140, i32 0, i32 0
  %l142 = getelementptr inbounds { ptr, i64 }, ptr %sstruct140, i32 0, i32 1
  store ptr %sdata139, ptr %p141, align 8
  store i64 42, ptr %l142, align 8
  call void @lunite_retain(ptr %sstruct140)
  call void @codegen_c_CodegenC_emit_line(ptr %self138, ptr %sstruct140)
  %self143 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self143)
  %sdata144 = call ptr @lunite_alloc(i64 34, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata144, ptr align 1 @slit.117, i64 34, i1 false)
  %sstruct145 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p146 = getelementptr inbounds { ptr, i64 }, ptr %sstruct145, i32 0, i32 0
  %l147 = getelementptr inbounds { ptr, i64 }, ptr %sstruct145, i32 0, i32 1
  store ptr %sdata144, ptr %p146, align 8
  store i64 34, ptr %l147, align 8
  call void @lunite_retain(ptr %sstruct145)
  call void @codegen_c_CodegenC_emit_line(ptr %self143, ptr %sstruct145)
  %self148 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self148)
  %sdata149 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata149, ptr align 1 @slit.118, i64 1, i1 false)
  %sstruct150 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p151 = getelementptr inbounds { ptr, i64 }, ptr %sstruct150, i32 0, i32 0
  %l152 = getelementptr inbounds { ptr, i64 }, ptr %sstruct150, i32 0, i32 1
  store ptr %sdata149, ptr %p151, align 8
  store i64 1, ptr %l152, align 8
  call void @lunite_retain(ptr %sstruct150)
  call void @codegen_c_CodegenC_emit_line(ptr %self148, ptr %sstruct150)
  %self153 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self153)
  call void @codegen_c_CodegenC_emit_newline(ptr %self153)
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret void
}

define void @codegen_c_CodegenC_gen_struct_decl(ptr %0, ptr %1) {
entry:
  %type_str = alloca ptr, align 8
  %f = alloca ptr, align 8
  %i = alloca i64, align 8
  %s = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %s, align 8
  %self1 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self1)
  %sdata = call ptr @lunite_alloc(i64 15, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.119, i64 15, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p, align 8
  store i64 15, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  %s2 = load ptr, ptr %s, align 8
  %fp = getelementptr inbounds %ast_StructDecl, ptr %s2, i32 0, i32 0
  %name = load ptr, ptr %fp, align 8
  call void @lunite_retain(ptr %name)
  %res = call ptr @string_concat(ptr %sstruct, ptr %name)
  call void @lunite_retain(ptr %res)
  %sdata3 = call ptr @lunite_alloc(i64 2, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata3, ptr align 1 @slit.120, i64 2, i1 false)
  %sstruct4 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p5 = getelementptr inbounds { ptr, i64 }, ptr %sstruct4, i32 0, i32 0
  %l6 = getelementptr inbounds { ptr, i64 }, ptr %sstruct4, i32 0, i32 1
  store ptr %sdata3, ptr %p5, align 8
  store i64 2, ptr %l6, align 8
  call void @lunite_retain(ptr %sstruct4)
  %res7 = call ptr @string_concat(ptr %res, ptr %sstruct4)
  call void @lunite_retain(ptr %res7)
  call void @codegen_c_CodegenC_emit_line(ptr %self1, ptr %res7)
  %self8 = load ptr, ptr %self, align 8
  %fp9 = getelementptr inbounds %codegen_c_CodegenC, ptr %self8, i32 0, i32 1
  %self10 = load ptr, ptr %self, align 8
  %fp11 = getelementptr inbounds %codegen_c_CodegenC, ptr %self10, i32 0, i32 1
  %indent = load i64, ptr %fp11, align 8
  %2 = add i64 %indent, 1
  store i64 %2, ptr %fp9, align 8
  store i64 0, ptr %i, align 8
  br label %while_cond

while_cond:                                       ; preds = %while_body, %body
  %i12 = load i64, ptr %i, align 8
  %s13 = load ptr, ptr %s, align 8
  %fp14 = getelementptr inbounds %ast_StructDecl, ptr %s13, i32 0, i32 2
  %fields = load ptr, ptr %fp14, align 8
  %fp15 = getelementptr inbounds %list_List, ptr %fields, i32 0, i32 1
  %count = load i64, ptr %fp15, align 8
  %3 = icmp slt i64 %i12, %count
  br i1 %3, label %while_body, label %while_end

while_body:                                       ; preds = %while_cond
  %s16 = load ptr, ptr %s, align 8
  %fp17 = getelementptr inbounds %ast_StructDecl, ptr %s16, i32 0, i32 2
  %fields18 = load ptr, ptr %fp17, align 8
  %fp19 = getelementptr inbounds %list_List, ptr %fields18, i32 0, i32 0
  %data = load ptr, ptr %fp19, align 8
  %i20 = load i64, ptr %i, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %i20
  %val = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val)
  store ptr %val, ptr %f, align 8
  %self21 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self21)
  %f22 = load ptr, ptr %f, align 8
  %fp23 = getelementptr inbounds %ast_Field, ptr %f22, i32 0, i32 1
  %typ = load ptr, ptr %fp23, align 8
  call void @lunite_retain(ptr %typ)
  %res24 = call ptr @codegen_c_CodegenC_gen_type(ptr %self21, ptr %typ)
  call void @lunite_retain(ptr %res24)
  store ptr %res24, ptr %type_str, align 8
  %self25 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self25)
  %type_str26 = load ptr, ptr %type_str, align 8
  call void @lunite_retain(ptr %type_str26)
  %sdata27 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata27, ptr align 1 @slit.121, i64 1, i1 false)
  %sstruct28 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p29 = getelementptr inbounds { ptr, i64 }, ptr %sstruct28, i32 0, i32 0
  %l30 = getelementptr inbounds { ptr, i64 }, ptr %sstruct28, i32 0, i32 1
  store ptr %sdata27, ptr %p29, align 8
  store i64 1, ptr %l30, align 8
  call void @lunite_retain(ptr %sstruct28)
  %res31 = call ptr @string_concat(ptr %type_str26, ptr %sstruct28)
  call void @lunite_retain(ptr %res31)
  %f32 = load ptr, ptr %f, align 8
  %fp33 = getelementptr inbounds %ast_Field, ptr %f32, i32 0, i32 0
  %name34 = load ptr, ptr %fp33, align 8
  call void @lunite_retain(ptr %name34)
  %res35 = call ptr @string_concat(ptr %res31, ptr %name34)
  call void @lunite_retain(ptr %res35)
  %sdata36 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata36, ptr align 1 @slit.122, i64 1, i1 false)
  %sstruct37 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p38 = getelementptr inbounds { ptr, i64 }, ptr %sstruct37, i32 0, i32 0
  %l39 = getelementptr inbounds { ptr, i64 }, ptr %sstruct37, i32 0, i32 1
  store ptr %sdata36, ptr %p38, align 8
  store i64 1, ptr %l39, align 8
  call void @lunite_retain(ptr %sstruct37)
  call void @codegen_c_CodegenC_emit_line(ptr %self25, ptr %res35, ptr %sstruct37)
  %i40 = load i64, ptr %i, align 8
  %4 = add i64 %i40, 1
  store i64 %4, ptr %i, align 8
  %tmp = load ptr, ptr %type_str, align 8
  call void @lunite_release(ptr %tmp)
  %tmp41 = load ptr, ptr %f, align 8
  call void @lunite_release(ptr %tmp41)
  br label %while_cond

while_end:                                        ; preds = %while_cond
  %self42 = load ptr, ptr %self, align 8
  %fp43 = getelementptr inbounds %codegen_c_CodegenC, ptr %self42, i32 0, i32 1
  %self44 = load ptr, ptr %self, align 8
  %fp45 = getelementptr inbounds %codegen_c_CodegenC, ptr %self44, i32 0, i32 1
  %indent46 = load i64, ptr %fp45, align 8
  %5 = sub i64 %indent46, 1
  store i64 %5, ptr %fp43, align 8
  %self47 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self47)
  %sdata48 = call ptr @lunite_alloc(i64 2, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata48, ptr align 1 @slit.123, i64 2, i1 false)
  %sstruct49 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p50 = getelementptr inbounds { ptr, i64 }, ptr %sstruct49, i32 0, i32 0
  %l51 = getelementptr inbounds { ptr, i64 }, ptr %sstruct49, i32 0, i32 1
  store ptr %sdata48, ptr %p50, align 8
  store i64 2, ptr %l51, align 8
  call void @lunite_retain(ptr %sstruct49)
  %s52 = load ptr, ptr %s, align 8
  %fp53 = getelementptr inbounds %ast_StructDecl, ptr %s52, i32 0, i32 0
  %name54 = load ptr, ptr %fp53, align 8
  call void @lunite_retain(ptr %name54)
  %res55 = call ptr @string_concat(ptr %sstruct49, ptr %name54)
  call void @lunite_retain(ptr %res55)
  %sdata56 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata56, ptr align 1 @slit.124, i64 1, i1 false)
  %sstruct57 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p58 = getelementptr inbounds { ptr, i64 }, ptr %sstruct57, i32 0, i32 0
  %l59 = getelementptr inbounds { ptr, i64 }, ptr %sstruct57, i32 0, i32 1
  store ptr %sdata56, ptr %p58, align 8
  store i64 1, ptr %l59, align 8
  call void @lunite_retain(ptr %sstruct57)
  %res60 = call ptr @string_concat(ptr %res55, ptr %sstruct57)
  call void @lunite_retain(ptr %res60)
  call void @codegen_c_CodegenC_emit_line(ptr %self47, ptr %res60)
  %self61 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self61)
  call void @codegen_c_CodegenC_emit_newline(ptr %self61)
  %tmp62 = load ptr, ptr %s, align 8
  call void @lunite_release(ptr %tmp62)
  %tmp63 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp63)
  ret void
}

define void @codegen_c_CodegenC_gen_enum_decl(ptr %0, ptr %1) {
entry:
  %tag_name = alloca ptr, align 8
  %v = alloca ptr, align 8
  %i = alloca i64, align 8
  %e = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %e, align 8
  store i64 0, ptr %i, align 8
  br label %while_cond

while_cond:                                       ; preds = %while_body, %body
  %i1 = load i64, ptr %i, align 8
  %e2 = load ptr, ptr %e, align 8
  %fp = getelementptr inbounds %ast_EnumDecl, ptr %e2, i32 0, i32 2
  %variants = load ptr, ptr %fp, align 8
  %fp3 = getelementptr inbounds %list_List, ptr %variants, i32 0, i32 1
  %count = load i64, ptr %fp3, align 8
  %2 = icmp slt i64 %i1, %count
  br i1 %2, label %while_body, label %while_end

while_body:                                       ; preds = %while_cond
  %e4 = load ptr, ptr %e, align 8
  %fp5 = getelementptr inbounds %ast_EnumDecl, ptr %e4, i32 0, i32 2
  %variants6 = load ptr, ptr %fp5, align 8
  %fp7 = getelementptr inbounds %list_List, ptr %variants6, i32 0, i32 0
  %data = load ptr, ptr %fp7, align 8
  %i8 = load i64, ptr %i, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %i8
  %val = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val)
  store ptr %val, ptr %v, align 8
  %e9 = load ptr, ptr %e, align 8
  %fp10 = getelementptr inbounds %ast_EnumDecl, ptr %e9, i32 0, i32 0
  %name = load ptr, ptr %fp10, align 8
  call void @lunite_retain(ptr %name)
  %sdata = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.125, i64 1, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p, align 8
  store i64 1, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  %res = call ptr @string_concat(ptr %name, ptr %sstruct)
  call void @lunite_retain(ptr %res)
  %v11 = load ptr, ptr %v, align 8
  %fp12 = getelementptr inbounds %ast_EnumVariant, ptr %v11, i32 0, i32 0
  %name13 = load ptr, ptr %fp12, align 8
  call void @lunite_retain(ptr %name13)
  %res14 = call ptr @string_concat(ptr %res, ptr %name13)
  call void @lunite_retain(ptr %res14)
  store ptr %res14, ptr %tag_name, align 8
  %self15 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self15)
  %sdata16 = call ptr @lunite_alloc(i64 8, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata16, ptr align 1 @slit.126, i64 8, i1 false)
  %sstruct17 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p18 = getelementptr inbounds { ptr, i64 }, ptr %sstruct17, i32 0, i32 0
  %l19 = getelementptr inbounds { ptr, i64 }, ptr %sstruct17, i32 0, i32 1
  store ptr %sdata16, ptr %p18, align 8
  store i64 8, ptr %l19, align 8
  call void @lunite_retain(ptr %sstruct17)
  %tag_name20 = load ptr, ptr %tag_name, align 8
  call void @lunite_retain(ptr %tag_name20)
  %res21 = call ptr @string_concat(ptr %sstruct17, ptr %tag_name20)
  call void @lunite_retain(ptr %res21)
  %sdata22 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata22, ptr align 1 @slit.127, i64 1, i1 false)
  %sstruct23 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p24 = getelementptr inbounds { ptr, i64 }, ptr %sstruct23, i32 0, i32 0
  %l25 = getelementptr inbounds { ptr, i64 }, ptr %sstruct23, i32 0, i32 1
  store ptr %sdata22, ptr %p24, align 8
  store i64 1, ptr %l25, align 8
  call void @lunite_retain(ptr %sstruct23)
  %i26 = load i64, ptr %i, align 8
  %res27 = call ptr @string_int_to_string(i64 %i26)
  call void @lunite_retain(ptr %res27)
  %res28 = call ptr @string_concat(ptr %sstruct23, ptr %res27)
  call void @lunite_retain(ptr %res28)
  %res29 = call ptr @string_concat(ptr %res21, ptr %res28)
  call void @lunite_retain(ptr %res29)
  call void @codegen_c_CodegenC_emit_line(ptr %self15, ptr %res29)
  %i30 = load i64, ptr %i, align 8
  %3 = add i64 %i30, 1
  store i64 %3, ptr %i, align 8
  %tmp = load ptr, ptr %tag_name, align 8
  call void @lunite_release(ptr %tmp)
  %tmp31 = load ptr, ptr %v, align 8
  call void @lunite_release(ptr %tmp31)
  br label %while_cond

while_end:                                        ; preds = %while_cond
  %self32 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self32)
  %sdata33 = call ptr @lunite_alloc(i64 15, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata33, ptr align 1 @slit.128, i64 15, i1 false)
  %sstruct34 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p35 = getelementptr inbounds { ptr, i64 }, ptr %sstruct34, i32 0, i32 0
  %l36 = getelementptr inbounds { ptr, i64 }, ptr %sstruct34, i32 0, i32 1
  store ptr %sdata33, ptr %p35, align 8
  store i64 15, ptr %l36, align 8
  call void @lunite_retain(ptr %sstruct34)
  %e37 = load ptr, ptr %e, align 8
  %fp38 = getelementptr inbounds %ast_EnumDecl, ptr %e37, i32 0, i32 0
  %name39 = load ptr, ptr %fp38, align 8
  call void @lunite_retain(ptr %name39)
  %res40 = call ptr @string_concat(ptr %sstruct34, ptr %name39)
  call void @lunite_retain(ptr %res40)
  %sdata41 = call ptr @lunite_alloc(i64 2, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata41, ptr align 1 @slit.129, i64 2, i1 false)
  %sstruct42 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p43 = getelementptr inbounds { ptr, i64 }, ptr %sstruct42, i32 0, i32 0
  %l44 = getelementptr inbounds { ptr, i64 }, ptr %sstruct42, i32 0, i32 1
  store ptr %sdata41, ptr %p43, align 8
  store i64 2, ptr %l44, align 8
  call void @lunite_retain(ptr %sstruct42)
  %res45 = call ptr @string_concat(ptr %res40, ptr %sstruct42)
  call void @lunite_retain(ptr %res45)
  call void @codegen_c_CodegenC_emit_line(ptr %self32, ptr %res45)
  %self46 = load ptr, ptr %self, align 8
  %fp47 = getelementptr inbounds %codegen_c_CodegenC, ptr %self46, i32 0, i32 1
  %self48 = load ptr, ptr %self, align 8
  %fp49 = getelementptr inbounds %codegen_c_CodegenC, ptr %self48, i32 0, i32 1
  %indent = load i64, ptr %fp49, align 8
  %4 = add i64 %indent, 1
  store i64 %4, ptr %fp47, align 8
  %self50 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self50)
  %sdata51 = call ptr @lunite_alloc(i64 8, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata51, ptr align 1 @slit.130, i64 8, i1 false)
  %sstruct52 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p53 = getelementptr inbounds { ptr, i64 }, ptr %sstruct52, i32 0, i32 0
  %l54 = getelementptr inbounds { ptr, i64 }, ptr %sstruct52, i32 0, i32 1
  store ptr %sdata51, ptr %p53, align 8
  store i64 8, ptr %l54, align 8
  call void @lunite_retain(ptr %sstruct52)
  call void @codegen_c_CodegenC_emit_line(ptr %self50, ptr %sstruct52)
  %self55 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self55)
  %sdata56 = call ptr @lunite_alloc(i64 14, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata56, ptr align 1 @slit.131, i64 14, i1 false)
  %sstruct57 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p58 = getelementptr inbounds { ptr, i64 }, ptr %sstruct57, i32 0, i32 0
  %l59 = getelementptr inbounds { ptr, i64 }, ptr %sstruct57, i32 0, i32 1
  store ptr %sdata56, ptr %p58, align 8
  store i64 14, ptr %l59, align 8
  call void @lunite_retain(ptr %sstruct57)
  call void @codegen_c_CodegenC_emit_line(ptr %self55, ptr %sstruct57)
  %self60 = load ptr, ptr %self, align 8
  %fp61 = getelementptr inbounds %codegen_c_CodegenC, ptr %self60, i32 0, i32 1
  %self62 = load ptr, ptr %self, align 8
  %fp63 = getelementptr inbounds %codegen_c_CodegenC, ptr %self62, i32 0, i32 1
  %indent64 = load i64, ptr %fp63, align 8
  %5 = sub i64 %indent64, 1
  store i64 %5, ptr %fp61, align 8
  %self65 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self65)
  %sdata66 = call ptr @lunite_alloc(i64 2, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata66, ptr align 1 @slit.132, i64 2, i1 false)
  %sstruct67 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p68 = getelementptr inbounds { ptr, i64 }, ptr %sstruct67, i32 0, i32 0
  %l69 = getelementptr inbounds { ptr, i64 }, ptr %sstruct67, i32 0, i32 1
  store ptr %sdata66, ptr %p68, align 8
  store i64 2, ptr %l69, align 8
  call void @lunite_retain(ptr %sstruct67)
  %e70 = load ptr, ptr %e, align 8
  %fp71 = getelementptr inbounds %ast_EnumDecl, ptr %e70, i32 0, i32 0
  %name72 = load ptr, ptr %fp71, align 8
  call void @lunite_retain(ptr %name72)
  %res73 = call ptr @string_concat(ptr %sstruct67, ptr %name72)
  call void @lunite_retain(ptr %res73)
  %sdata74 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata74, ptr align 1 @slit.133, i64 1, i1 false)
  %sstruct75 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p76 = getelementptr inbounds { ptr, i64 }, ptr %sstruct75, i32 0, i32 0
  %l77 = getelementptr inbounds { ptr, i64 }, ptr %sstruct75, i32 0, i32 1
  store ptr %sdata74, ptr %p76, align 8
  store i64 1, ptr %l77, align 8
  call void @lunite_retain(ptr %sstruct75)
  %res78 = call ptr @string_concat(ptr %res73, ptr %sstruct75)
  call void @lunite_retain(ptr %res78)
  call void @codegen_c_CodegenC_emit_line(ptr %self65, ptr %res78)
  %self79 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self79)
  call void @codegen_c_CodegenC_emit_newline(ptr %self79)
  %tmp80 = load ptr, ptr %e, align 8
  call void @lunite_release(ptr %tmp80)
  %tmp81 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp81)
  ret void
}

define void @codegen_c_CodegenC_gen_function_proto(ptr %0, ptr %1, ptr %2) {
entry:
  %ends_with_star = alloca i1, align 1
  %len = alloca i64, align 8
  %p_type = alloca ptr, align 8
  %p38 = alloca ptr, align 8
  %i = alloca i64, align 8
  %params_str = alloca ptr, align 8
  %name5 = alloca ptr, align 8
  %ret_type = alloca ptr, align 8
  %struct_name = alloca ptr, align 8
  %f = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %f, align 8
  call void @lunite_retain(ptr %2)
  store ptr %2, ptr %struct_name, align 8
  %self1 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self1)
  %f2 = load ptr, ptr %f, align 8
  %fp = getelementptr inbounds %ast_FunctionDecl, ptr %f2, i32 0, i32 3
  %return_type = load ptr, ptr %fp, align 8
  call void @lunite_retain(ptr %return_type)
  %res = call ptr @codegen_c_CodegenC_gen_type(ptr %self1, ptr %return_type)
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %ret_type, align 8
  %f3 = load ptr, ptr %f, align 8
  %fp4 = getelementptr inbounds %ast_FunctionDecl, ptr %f3, i32 0, i32 0
  %name = load ptr, ptr %fp4, align 8
  call void @lunite_retain(ptr %name)
  store ptr %name, ptr %name5, align 8
  %struct_name6 = load ptr, ptr %struct_name, align 8
  call void @lunite_retain(ptr %struct_name6)
  %res7 = call i64 @string_length(ptr %struct_name6)
  %3 = icmp sgt i64 %res7, 0
  br i1 %3, label %then, label %else

then:                                             ; preds = %body
  %struct_name8 = load ptr, ptr %struct_name, align 8
  call void @lunite_retain(ptr %struct_name8)
  %sdata = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.134, i64 1, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p, align 8
  store i64 1, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  %f9 = load ptr, ptr %f, align 8
  %fp10 = getelementptr inbounds %ast_FunctionDecl, ptr %f9, i32 0, i32 0
  %name11 = load ptr, ptr %fp10, align 8
  call void @lunite_retain(ptr %name11)
  %res12 = call ptr @string_concat(ptr %sstruct, ptr %name11)
  call void @lunite_retain(ptr %res12)
  %res13 = call ptr @string_concat(ptr %struct_name8, ptr %res12)
  %old = load ptr, ptr %name5, align 8
  call void @lunite_retain(ptr %res13)
  store ptr %res13, ptr %name5, align 8
  call void @lunite_release(ptr %old)
  br label %cont

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else, %then
  %sdata14 = call ptr @lunite_alloc(i64 0, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata14, ptr align 1 @slit.135, i64 0, i1 false)
  %sstruct15 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p16 = getelementptr inbounds { ptr, i64 }, ptr %sstruct15, i32 0, i32 0
  %l17 = getelementptr inbounds { ptr, i64 }, ptr %sstruct15, i32 0, i32 1
  store ptr %sdata14, ptr %p16, align 8
  store i64 0, ptr %l17, align 8
  call void @lunite_retain(ptr %sstruct15)
  store ptr %sstruct15, ptr %params_str, align 8
  store i64 0, ptr %i, align 8
  br label %while_cond

while_cond:                                       ; preds = %cont47, %cont
  %i18 = load i64, ptr %i, align 8
  %f19 = load ptr, ptr %f, align 8
  %fp20 = getelementptr inbounds %ast_FunctionDecl, ptr %f19, i32 0, i32 2
  %params = load ptr, ptr %fp20, align 8
  %fp21 = getelementptr inbounds %list_List, ptr %params, i32 0, i32 1
  %count = load i64, ptr %fp21, align 8
  %4 = icmp slt i64 %i18, %count
  br i1 %4, label %while_body, label %while_end

while_body:                                       ; preds = %while_cond
  %i22 = load i64, ptr %i, align 8
  %5 = icmp sgt i64 %i22, 0
  br i1 %5, label %then23, label %else24

while_end:                                        ; preds = %while_cond
  %self86 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self86)
  %ret_type87 = load ptr, ptr %ret_type, align 8
  call void @lunite_retain(ptr %ret_type87)
  %sdata88 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata88, ptr align 1 @slit.139, i64 1, i1 false)
  %sstruct89 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p90 = getelementptr inbounds { ptr, i64 }, ptr %sstruct89, i32 0, i32 0
  %l91 = getelementptr inbounds { ptr, i64 }, ptr %sstruct89, i32 0, i32 1
  store ptr %sdata88, ptr %p90, align 8
  store i64 1, ptr %l91, align 8
  call void @lunite_retain(ptr %sstruct89)
  %res92 = call ptr @string_concat(ptr %ret_type87, ptr %sstruct89)
  call void @lunite_retain(ptr %res92)
  %name93 = load ptr, ptr %name5, align 8
  call void @lunite_retain(ptr %name93)
  %res94 = call ptr @string_concat(ptr %res92, ptr %name93)
  call void @lunite_retain(ptr %res94)
  %sdata95 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata95, ptr align 1 @slit.140, i64 1, i1 false)
  %sstruct96 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p97 = getelementptr inbounds { ptr, i64 }, ptr %sstruct96, i32 0, i32 0
  %l98 = getelementptr inbounds { ptr, i64 }, ptr %sstruct96, i32 0, i32 1
  store ptr %sdata95, ptr %p97, align 8
  store i64 1, ptr %l98, align 8
  call void @lunite_retain(ptr %sstruct96)
  %res99 = call ptr @string_concat(ptr %res94, ptr %sstruct96)
  call void @lunite_retain(ptr %res99)
  %params_str100 = load ptr, ptr %params_str, align 8
  call void @lunite_retain(ptr %params_str100)
  %sdata101 = call ptr @lunite_alloc(i64 2, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata101, ptr align 1 @slit.141, i64 2, i1 false)
  %sstruct102 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p103 = getelementptr inbounds { ptr, i64 }, ptr %sstruct102, i32 0, i32 0
  %l104 = getelementptr inbounds { ptr, i64 }, ptr %sstruct102, i32 0, i32 1
  store ptr %sdata101, ptr %p103, align 8
  store i64 2, ptr %l104, align 8
  call void @lunite_retain(ptr %sstruct102)
  %res105 = call ptr @string_concat(ptr %params_str100, ptr %sstruct102)
  call void @lunite_retain(ptr %res105)
  %res106 = call ptr @string_concat(ptr %res99, ptr %res105)
  call void @lunite_retain(ptr %res106)
  call void @codegen_c_CodegenC_emit_line(ptr %self86, ptr %res106)
  %tmp107 = load ptr, ptr %params_str, align 8
  call void @lunite_release(ptr %tmp107)
  %tmp108 = load ptr, ptr %name5, align 8
  call void @lunite_release(ptr %tmp108)
  %tmp109 = load ptr, ptr %ret_type, align 8
  call void @lunite_release(ptr %tmp109)
  %tmp110 = load ptr, ptr %struct_name, align 8
  call void @lunite_release(ptr %tmp110)
  %tmp111 = load ptr, ptr %f, align 8
  call void @lunite_release(ptr %tmp111)
  %tmp112 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp112)
  ret void

then23:                                           ; preds = %while_body
  %params_str26 = load ptr, ptr %params_str, align 8
  call void @lunite_retain(ptr %params_str26)
  %sdata27 = call ptr @lunite_alloc(i64 2, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata27, ptr align 1 @slit.136, i64 2, i1 false)
  %sstruct28 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p29 = getelementptr inbounds { ptr, i64 }, ptr %sstruct28, i32 0, i32 0
  %l30 = getelementptr inbounds { ptr, i64 }, ptr %sstruct28, i32 0, i32 1
  store ptr %sdata27, ptr %p29, align 8
  store i64 2, ptr %l30, align 8
  call void @lunite_retain(ptr %sstruct28)
  %res31 = call ptr @string_concat(ptr %params_str26, ptr %sstruct28)
  %old32 = load ptr, ptr %params_str, align 8
  call void @lunite_retain(ptr %res31)
  store ptr %res31, ptr %params_str, align 8
  call void @lunite_release(ptr %old32)
  br label %cont25

else24:                                           ; preds = %while_body
  br label %cont25

cont25:                                           ; preds = %else24, %then23
  %f33 = load ptr, ptr %f, align 8
  %fp34 = getelementptr inbounds %ast_FunctionDecl, ptr %f33, i32 0, i32 2
  %params35 = load ptr, ptr %fp34, align 8
  %fp36 = getelementptr inbounds %list_List, ptr %params35, i32 0, i32 0
  %data = load ptr, ptr %fp36, align 8
  %i37 = load i64, ptr %i, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %i37
  %val = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val)
  store ptr %val, ptr %p38, align 8
  %self39 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self39)
  %p40 = load ptr, ptr %p38, align 8
  %fp41 = getelementptr inbounds %ast_Param, ptr %p40, i32 0, i32 1
  %typ = load ptr, ptr %fp41, align 8
  call void @lunite_retain(ptr %typ)
  %res42 = call ptr @codegen_c_CodegenC_gen_type(ptr %self39, ptr %typ)
  call void @lunite_retain(ptr %res42)
  store ptr %res42, ptr %p_type, align 8
  %p43 = load ptr, ptr %p38, align 8
  %fp44 = getelementptr inbounds %ast_Param, ptr %p43, i32 0, i32 2
  %is_mut = load i1, ptr %fp44, align 1
  br i1 %is_mut, label %then45, label %else46

then45:                                           ; preds = %cont25
  %p_type48 = load ptr, ptr %p_type, align 8
  call void @lunite_retain(ptr %p_type48)
  %res49 = call i64 @string_length(ptr %p_type48)
  store i64 %res49, ptr %len, align 8
  store i1 false, ptr %ends_with_star, align 1
  %len50 = load i64, ptr %len, align 8
  %6 = icmp sgt i64 %len50, 0
  br i1 %6, label %then51, label %else52

else46:                                           ; preds = %cont25
  br label %cont47

cont47:                                           ; preds = %else46, %cont63
  %params_str71 = load ptr, ptr %params_str, align 8
  call void @lunite_retain(ptr %params_str71)
  %p_type72 = load ptr, ptr %p_type, align 8
  call void @lunite_retain(ptr %p_type72)
  %sdata73 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata73, ptr align 1 @slit.138, i64 1, i1 false)
  %sstruct74 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p75 = getelementptr inbounds { ptr, i64 }, ptr %sstruct74, i32 0, i32 0
  %l76 = getelementptr inbounds { ptr, i64 }, ptr %sstruct74, i32 0, i32 1
  store ptr %sdata73, ptr %p75, align 8
  store i64 1, ptr %l76, align 8
  call void @lunite_retain(ptr %sstruct74)
  %res77 = call ptr @string_concat(ptr %p_type72, ptr %sstruct74)
  call void @lunite_retain(ptr %res77)
  %p78 = load ptr, ptr %p38, align 8
  %fp79 = getelementptr inbounds %ast_Param, ptr %p78, i32 0, i32 0
  %name80 = load ptr, ptr %fp79, align 8
  call void @lunite_retain(ptr %name80)
  %res81 = call ptr @string_concat(ptr %res77, ptr %name80)
  call void @lunite_retain(ptr %res81)
  %res82 = call ptr @string_concat(ptr %params_str71, ptr %res81)
  %old83 = load ptr, ptr %params_str, align 8
  call void @lunite_retain(ptr %res82)
  store ptr %res82, ptr %params_str, align 8
  call void @lunite_release(ptr %old83)
  %i84 = load i64, ptr %i, align 8
  %7 = add i64 %i84, 1
  store i64 %7, ptr %i, align 8
  %tmp = load ptr, ptr %p_type, align 8
  call void @lunite_release(ptr %tmp)
  %tmp85 = load ptr, ptr %p38, align 8
  call void @lunite_release(ptr %tmp85)
  br label %while_cond

then51:                                           ; preds = %then45
  %p_type54 = load ptr, ptr %p_type, align 8
  call void @lunite_retain(ptr %p_type54)
  %len55 = load i64, ptr %len, align 8
  %8 = sub i64 %len55, 1
  %res56 = call i64 @string_char_at(ptr %p_type54, i64 %8)
  %9 = icmp eq i64 %res56, 42
  br i1 %9, label %then57, label %else58

else52:                                           ; preds = %then45
  br label %cont53

cont53:                                           ; preds = %else52, %cont59
  %ends_with_star60 = load i1, ptr %ends_with_star, align 1
  %not = xor i1 %ends_with_star60, true
  br i1 %not, label %then61, label %else62

then57:                                           ; preds = %then51
  store i1 true, ptr %ends_with_star, align 1
  br label %cont59

else58:                                           ; preds = %then51
  br label %cont59

cont59:                                           ; preds = %else58, %then57
  br label %cont53

then61:                                           ; preds = %cont53
  %p_type64 = load ptr, ptr %p_type, align 8
  call void @lunite_retain(ptr %p_type64)
  %sdata65 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata65, ptr align 1 @slit.137, i64 1, i1 false)
  %sstruct66 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p67 = getelementptr inbounds { ptr, i64 }, ptr %sstruct66, i32 0, i32 0
  %l68 = getelementptr inbounds { ptr, i64 }, ptr %sstruct66, i32 0, i32 1
  store ptr %sdata65, ptr %p67, align 8
  store i64 1, ptr %l68, align 8
  call void @lunite_retain(ptr %sstruct66)
  %res69 = call ptr @string_concat(ptr %p_type64, ptr %sstruct66)
  %old70 = load ptr, ptr %p_type, align 8
  call void @lunite_retain(ptr %res69)
  store ptr %res69, ptr %p_type, align 8
  call void @lunite_release(ptr %old70)
  br label %cont63

else62:                                           ; preds = %cont53
  br label %cont63

cont63:                                           ; preds = %else62, %then61
  br label %cont47
}

define ptr @codegen_c_CodegenC_gen_expr(ptr %0, ptr %1) {
entry:
  %f = alloca ptr, align 8
  %i310 = alloca i64, align 8
  %init = alloca ptr, align 8
  %payload296 = alloca ptr, align 8
  %obj = alloca ptr, align 8
  %payload268 = alloca ptr, align 8
  %i = alloca i64, align 8
  %args_str = alloca ptr, align 8
  %id = alloca ptr, align 8
  %struct_name = alloca ptr, align 8
  %method_name = alloca ptr, align 8
  %obj_expr = alloca ptr, align 8
  %ma = alloca ptr, align 8
  %first_arg = alloca ptr, align 8
  %func_name = alloca ptr, align 8
  %payload109 = alloca ptr, align 8
  %op = alloca ptr, align 8
  %right79 = alloca ptr, align 8
  %left73 = alloca ptr, align 8
  %payload = alloca ptr, align 8
  %name = alloca ptr, align 8
  %s = alloca ptr, align 8
  %b = alloca i1, align 1
  %n = alloca i64, align 8
  %e = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %e, align 8
  %e1 = load ptr, ptr %e, align 8
  %tptr = getelementptr inbounds { i64, [8 x i8] }, ptr %e1, i32 0, i32 0
  %tag = load i64, ptr %tptr, align 8
  %match = icmp eq i64 %tag, 0
  br i1 %match, label %when_body, label %when_next

when_end:                                         ; preds = %when_next373
  %tmp381 = load ptr, ptr %e, align 8
  call void @lunite_release(ptr %tmp381)
  %tmp382 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp382)
  ret ptr null

when_next:                                        ; preds = %body
  %tptr6 = getelementptr inbounds { i64, [8 x i8] }, ptr %e1, i32 0, i32 0
  %tag7 = load i64, ptr %tptr6, align 8
  %match8 = icmp eq i64 %tag7, 4
  br i1 %match8, label %when_body5, label %when_next4

when_body:                                        ; preds = %body
  %pptr = getelementptr inbounds { i64, [8 x i8] }, ptr %e1, i32 0, i32 1
  %pval = load i64, ptr %pptr, align 8
  store i64 %pval, ptr %n, align 8
  %n2 = load i64, ptr %n, align 8
  %res = call ptr @string_int_to_string(i64 %n2)
  call void @lunite_retain(ptr %res)
  %tmp = load ptr, ptr %e, align 8
  call void @lunite_release(ptr %tmp)
  %tmp3 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp3)
  ret ptr %res

when_next4:                                       ; preds = %when_next
  %tptr22 = getelementptr inbounds { i64, [8 x i8] }, ptr %e1, i32 0, i32 0
  %tag23 = load i64, ptr %tptr22, align 8
  %match24 = icmp eq i64 %tag23, 5
  br i1 %match24, label %when_body21, label %when_next20

when_body5:                                       ; preds = %when_next
  %pptr9 = getelementptr inbounds { i64, [8 x i8] }, ptr %e1, i32 0, i32 1
  %pval10 = load i1, ptr %pptr9, align 1
  store i1 %pval10, ptr %b, align 1
  %b11 = load i1, ptr %b, align 1
  br i1 %b11, label %then, label %else

then:                                             ; preds = %when_body5
  %sdata = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.142, i64 1, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p, align 8
  store i64 1, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  %tmp12 = load ptr, ptr %e, align 8
  call void @lunite_release(ptr %tmp12)
  %tmp13 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp13)
  ret ptr %sstruct

else:                                             ; preds = %when_body5
  br label %cont

cont:                                             ; preds = %else
  %sdata14 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata14, ptr align 1 @slit.143, i64 1, i1 false)
  %sstruct15 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p16 = getelementptr inbounds { ptr, i64 }, ptr %sstruct15, i32 0, i32 0
  %l17 = getelementptr inbounds { ptr, i64 }, ptr %sstruct15, i32 0, i32 1
  store ptr %sdata14, ptr %p16, align 8
  store i64 1, ptr %l17, align 8
  call void @lunite_retain(ptr %sstruct15)
  %tmp18 = load ptr, ptr %e, align 8
  call void @lunite_release(ptr %tmp18)
  %tmp19 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp19)
  ret ptr %sstruct15

when_next20:                                      ; preds = %when_next4
  %tptr33 = getelementptr inbounds { i64, [8 x i8] }, ptr %e1, i32 0, i32 0
  %tag34 = load i64, ptr %tptr33, align 8
  %match35 = icmp eq i64 %tag34, 2
  br i1 %match35, label %when_body32, label %when_next31

when_body21:                                      ; preds = %when_next4
  %sdata25 = call ptr @lunite_alloc(i64 4, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata25, ptr align 1 @slit.144, i64 4, i1 false)
  %sstruct26 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p27 = getelementptr inbounds { ptr, i64 }, ptr %sstruct26, i32 0, i32 0
  %l28 = getelementptr inbounds { ptr, i64 }, ptr %sstruct26, i32 0, i32 1
  store ptr %sdata25, ptr %p27, align 8
  store i64 4, ptr %l28, align 8
  call void @lunite_retain(ptr %sstruct26)
  %tmp29 = load ptr, ptr %e, align 8
  call void @lunite_release(ptr %tmp29)
  %tmp30 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp30)
  ret ptr %sstruct26

when_next31:                                      ; preds = %when_next20
  %tptr54 = getelementptr inbounds { i64, [8 x i8] }, ptr %e1, i32 0, i32 0
  %tag55 = load i64, ptr %tptr54, align 8
  %match56 = icmp eq i64 %tag55, 3
  br i1 %match56, label %when_body53, label %when_next52

when_body32:                                      ; preds = %when_next20
  %pptr36 = getelementptr inbounds { i64, [8 x i8] }, ptr %e1, i32 0, i32 1
  %pval37 = load ptr, ptr %pptr36, align 8
  call void @lunite_retain(ptr %pval37)
  store ptr %pval37, ptr %s, align 8
  %sdata38 = call ptr @lunite_alloc(i64 19, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata38, ptr align 1 @slit.145, i64 19, i1 false)
  %sstruct39 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p40 = getelementptr inbounds { ptr, i64 }, ptr %sstruct39, i32 0, i32 0
  %l41 = getelementptr inbounds { ptr, i64 }, ptr %sstruct39, i32 0, i32 1
  store ptr %sdata38, ptr %p40, align 8
  store i64 19, ptr %l41, align 8
  call void @lunite_retain(ptr %sstruct39)
  %s42 = load ptr, ptr %s, align 8
  call void @lunite_retain(ptr %s42)
  %res43 = call ptr @string_concat(ptr %sstruct39, ptr %s42)
  call void @lunite_retain(ptr %res43)
  %sdata44 = call ptr @lunite_alloc(i64 2, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata44, ptr align 1 @slit.146, i64 2, i1 false)
  %sstruct45 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p46 = getelementptr inbounds { ptr, i64 }, ptr %sstruct45, i32 0, i32 0
  %l47 = getelementptr inbounds { ptr, i64 }, ptr %sstruct45, i32 0, i32 1
  store ptr %sdata44, ptr %p46, align 8
  store i64 2, ptr %l47, align 8
  call void @lunite_retain(ptr %sstruct45)
  %res48 = call ptr @string_concat(ptr %res43, ptr %sstruct45)
  call void @lunite_retain(ptr %res48)
  %tmp49 = load ptr, ptr %s, align 8
  call void @lunite_release(ptr %tmp49)
  %tmp50 = load ptr, ptr %e, align 8
  call void @lunite_release(ptr %tmp50)
  %tmp51 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp51)
  ret ptr %res48

when_next52:                                      ; preds = %when_next31
  %tptr65 = getelementptr inbounds { i64, [8 x i8] }, ptr %e1, i32 0, i32 0
  %tag66 = load i64, ptr %tptr65, align 8
  %match67 = icmp eq i64 %tag66, 8
  br i1 %match67, label %when_body64, label %when_next63

when_body53:                                      ; preds = %when_next31
  %pptr57 = getelementptr inbounds { i64, [8 x i8] }, ptr %e1, i32 0, i32 1
  %pval58 = load ptr, ptr %pptr57, align 8
  call void @lunite_retain(ptr %pval58)
  store ptr %pval58, ptr %name, align 8
  %name59 = load ptr, ptr %name, align 8
  call void @lunite_retain(ptr %name59)
  %tmp60 = load ptr, ptr %name, align 8
  call void @lunite_release(ptr %tmp60)
  %tmp61 = load ptr, ptr %e, align 8
  call void @lunite_release(ptr %tmp61)
  %tmp62 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp62)
  ret ptr %name59

when_next63:                                      ; preds = %when_next52
  %tptr104 = getelementptr inbounds { i64, [8 x i8] }, ptr %e1, i32 0, i32 0
  %tag105 = load i64, ptr %tptr104, align 8
  %match106 = icmp eq i64 %tag105, 9
  br i1 %match106, label %when_body103, label %when_next102

when_body64:                                      ; preds = %when_next52
  %pptr68 = getelementptr inbounds { i64, [8 x i8] }, ptr %e1, i32 0, i32 1
  %pval69 = load ptr, ptr %pptr68, align 8
  call void @lunite_retain(ptr %pval69)
  store ptr %pval69, ptr %payload, align 8
  %self70 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self70)
  %payload71 = load ptr, ptr %payload, align 8
  %fp = getelementptr inbounds %ast_BinaryExpressionPayload, ptr %payload71, i32 0, i32 0
  %left = load ptr, ptr %fp, align 8
  %deref = load ptr, ptr %left, align 8
  call void @lunite_retain(ptr %deref)
  %res72 = call ptr @codegen_c_CodegenC_gen_expr(ptr %self70, ptr %deref)
  call void @lunite_retain(ptr %res72)
  store ptr %res72, ptr %left73, align 8
  %self74 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self74)
  %payload75 = load ptr, ptr %payload, align 8
  %fp76 = getelementptr inbounds %ast_BinaryExpressionPayload, ptr %payload75, i32 0, i32 2
  %right = load ptr, ptr %fp76, align 8
  %deref77 = load ptr, ptr %right, align 8
  call void @lunite_retain(ptr %deref77)
  %res78 = call ptr @codegen_c_CodegenC_gen_expr(ptr %self74, ptr %deref77)
  call void @lunite_retain(ptr %res78)
  store ptr %res78, ptr %right79, align 8
  %payload80 = load ptr, ptr %payload, align 8
  %fp81 = getelementptr inbounds %ast_BinaryExpressionPayload, ptr %payload80, i32 0, i32 1
  %operator = load ptr, ptr %fp81, align 8
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 6, ptr %t, align 8
  %l_null = icmp eq ptr %operator, null
  %r_null = icmp eq ptr %eptr, null
  %both_null = and i1 %l_null, %r_null
  %either_null = or i1 %l_null, %r_null
  br i1 %either_null, label %enum_res, label %enum_load

enum_load:                                        ; preds = %when_body64
  %ltag = getelementptr inbounds { i64, [8 x i8] }, ptr %operator, i32 0, i32 0
  %rtag = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  %lt = load i64, ptr %ltag, align 8
  %rt = load i64, ptr %rtag, align 8
  %teq = icmp eq i64 %lt, %rt
  br label %enum_res

enum_res:                                         ; preds = %enum_load, %when_body64
  %eq = phi i1 [ %both_null, %when_body64 ], [ %teq, %enum_load ]
  br i1 %eq, label %then82, label %else83

then82:                                           ; preds = %enum_res
  br label %cont84

else83:                                           ; preds = %enum_res
  br label %cont84

cont84:                                           ; preds = %else83, %then82
  %self85 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self85)
  %payload86 = load ptr, ptr %payload, align 8
  %fp87 = getelementptr inbounds %ast_BinaryExpressionPayload, ptr %payload86, i32 0, i32 1
  %operator88 = load ptr, ptr %fp87, align 8
  call void @lunite_retain(ptr %operator88)
  %res89 = call ptr @codegen_c_CodegenC_gen_op(ptr %self85, ptr %operator88)
  call void @lunite_retain(ptr %res89)
  store ptr %res89, ptr %op, align 8
  %left90 = load ptr, ptr %left73, align 8
  call void @lunite_retain(ptr %left90)
  %op91 = load ptr, ptr %op, align 8
  call void @lunite_retain(ptr %op91)
  %res92 = call ptr @string_concat(ptr %left90, ptr %op91)
  call void @lunite_retain(ptr %res92)
  %right93 = load ptr, ptr %right79, align 8
  call void @lunite_retain(ptr %right93)
  %res94 = call ptr @string_concat(ptr %res92, ptr %right93)
  call void @lunite_retain(ptr %res94)
  %res95 = call ptr @string_concat(ptr %res94)
  call void @lunite_retain(ptr %res95)
  %tmp96 = load ptr, ptr %op, align 8
  call void @lunite_release(ptr %tmp96)
  %tmp97 = load ptr, ptr %right79, align 8
  call void @lunite_release(ptr %tmp97)
  %tmp98 = load ptr, ptr %left73, align 8
  call void @lunite_release(ptr %tmp98)
  %tmp99 = load ptr, ptr %payload, align 8
  call void @lunite_release(ptr %tmp99)
  %tmp100 = load ptr, ptr %e, align 8
  call void @lunite_release(ptr %tmp100)
  %tmp101 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp101)
  ret ptr %res95

when_next102:                                     ; preds = %when_next63
  %tptr263 = getelementptr inbounds { i64, [8 x i8] }, ptr %e1, i32 0, i32 0
  %tag264 = load i64, ptr %tptr263, align 8
  %match265 = icmp eq i64 %tag264, 14
  br i1 %match265, label %when_body262, label %when_next261

when_body103:                                     ; preds = %when_next63
  %pptr107 = getelementptr inbounds { i64, [8 x i8] }, ptr %e1, i32 0, i32 1
  %pval108 = load ptr, ptr %pptr107, align 8
  call void @lunite_retain(ptr %pval108)
  store ptr %pval108, ptr %payload109, align 8
  %sdata110 = call ptr @lunite_alloc(i64 0, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata110, ptr align 1 @slit.147, i64 0, i1 false)
  %sstruct111 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p112 = getelementptr inbounds { ptr, i64 }, ptr %sstruct111, i32 0, i32 0
  %l113 = getelementptr inbounds { ptr, i64 }, ptr %sstruct111, i32 0, i32 1
  store ptr %sdata110, ptr %p112, align 8
  store i64 0, ptr %l113, align 8
  call void @lunite_retain(ptr %sstruct111)
  store ptr %sstruct111, ptr %func_name, align 8
  %sdata114 = call ptr @lunite_alloc(i64 0, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata114, ptr align 1 @slit.148, i64 0, i1 false)
  %sstruct115 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p116 = getelementptr inbounds { ptr, i64 }, ptr %sstruct115, i32 0, i32 0
  %l117 = getelementptr inbounds { ptr, i64 }, ptr %sstruct115, i32 0, i32 1
  store ptr %sdata114, ptr %p116, align 8
  store i64 0, ptr %l117, align 8
  call void @lunite_retain(ptr %sstruct115)
  store ptr %sstruct115, ptr %first_arg, align 8
  %payload118 = load ptr, ptr %payload109, align 8
  %fp119 = getelementptr inbounds %ast_CallExpressionPayload, ptr %payload118, i32 0, i32 0
  %function = load ptr, ptr %fp119, align 8
  %deref120 = load ptr, ptr %function, align 8
  %tptr124 = getelementptr inbounds { i64, [8 x i8] }, ptr %deref120, i32 0, i32 0
  %tag125 = load i64, ptr %tptr124, align 8
  %match126 = icmp eq i64 %tag125, 14
  br i1 %match126, label %when_body123, label %when_next122

when_end121:                                      ; preds = %when_next205, %when_body206, %when_body196, %cont140
  %first_arg214 = load ptr, ptr %first_arg, align 8
  call void @lunite_retain(ptr %first_arg214)
  store ptr %first_arg214, ptr %args_str, align 8
  store i64 0, ptr %i, align 8
  br label %while_cond

when_next122:                                     ; preds = %when_body103
  %tptr197 = getelementptr inbounds { i64, [8 x i8] }, ptr %deref120, i32 0, i32 0
  %tag198 = load i64, ptr %tptr197, align 8
  %match199 = icmp eq i64 %tag198, 3
  br i1 %match199, label %when_body196, label %when_next195

when_body123:                                     ; preds = %when_body103
  %pptr127 = getelementptr inbounds { i64, [8 x i8] }, ptr %deref120, i32 0, i32 1
  %pval128 = load ptr, ptr %pptr127, align 8
  call void @lunite_retain(ptr %pval128)
  store ptr %pval128, ptr %ma, align 8
  %self129 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self129)
  %ma130 = load ptr, ptr %ma, align 8
  %fp131 = getelementptr inbounds %ast_MemberAccessExpressionPayload, ptr %ma130, i32 0, i32 0
  %object = load ptr, ptr %fp131, align 8
  %deref132 = load ptr, ptr %object, align 8
  call void @lunite_retain(ptr %deref132)
  %res133 = call ptr @codegen_c_CodegenC_gen_expr(ptr %self129, ptr %deref132)
  call void @lunite_retain(ptr %res133)
  store ptr %res133, ptr %obj_expr, align 8
  %self134 = load ptr, ptr %self, align 8
  %fp135 = getelementptr inbounds %codegen_c_CodegenC, ptr %self134, i32 0, i32 3
  %imports = load ptr, ptr %fp135, align 8
  call void @lunite_retain(ptr %imports)
  %obj_expr136 = load ptr, ptr %obj_expr, align 8
  call void @lunite_retain(ptr %obj_expr136)
  %res137 = call i1 @map_Map_string_string_contains(ptr %imports, ptr %obj_expr136)
  br i1 %res137, label %then138, label %else139

then138:                                          ; preds = %when_body123
  %obj_expr141 = load ptr, ptr %obj_expr, align 8
  call void @lunite_retain(ptr %obj_expr141)
  %sdata142 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata142, ptr align 1 @slit.149, i64 1, i1 false)
  %sstruct143 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p144 = getelementptr inbounds { ptr, i64 }, ptr %sstruct143, i32 0, i32 0
  %l145 = getelementptr inbounds { ptr, i64 }, ptr %sstruct143, i32 0, i32 1
  store ptr %sdata142, ptr %p144, align 8
  store i64 1, ptr %l145, align 8
  call void @lunite_retain(ptr %sstruct143)
  %ma146 = load ptr, ptr %ma, align 8
  %fp147 = getelementptr inbounds %ast_MemberAccessExpressionPayload, ptr %ma146, i32 0, i32 1
  %field = load ptr, ptr %fp147, align 8
  call void @lunite_retain(ptr %field)
  %res148 = call ptr @string_concat(ptr %sstruct143, ptr %field)
  call void @lunite_retain(ptr %res148)
  %res149 = call ptr @string_concat(ptr %obj_expr141, ptr %res148)
  %old = load ptr, ptr %func_name, align 8
  call void @lunite_retain(ptr %res149)
  store ptr %res149, ptr %func_name, align 8
  call void @lunite_release(ptr %old)
  br label %cont140

else139:                                          ; preds = %when_body123
  %ma150 = load ptr, ptr %ma, align 8
  %fp151 = getelementptr inbounds %ast_MemberAccessExpressionPayload, ptr %ma150, i32 0, i32 1
  %field152 = load ptr, ptr %fp151, align 8
  call void @lunite_retain(ptr %field152)
  store ptr %field152, ptr %method_name, align 8
  %self153 = load ptr, ptr %self, align 8
  %fp154 = getelementptr inbounds %codegen_c_CodegenC, ptr %self153, i32 0, i32 2
  %method_map = load ptr, ptr %fp154, align 8
  call void @lunite_retain(ptr %method_map)
  %method_name155 = load ptr, ptr %method_name, align 8
  call void @lunite_retain(ptr %method_name155)
  %res156 = call ptr @map_Map_string_string_get(ptr %method_map, ptr %method_name155)
  call void @lunite_retain(ptr %res156)
  store ptr %res156, ptr %struct_name, align 8
  %struct_name157 = load ptr, ptr %struct_name, align 8
  %seq = call i64 @lunite_str_eq(ptr %struct_name157, i64 0)
  %bool = icmp eq i64 %seq, 0
  br i1 %bool, label %then158, label %else159

cont140:                                          ; preds = %cont160, %then138
  %tmp193 = load ptr, ptr %obj_expr, align 8
  call void @lunite_release(ptr %tmp193)
  %tmp194 = load ptr, ptr %ma, align 8
  call void @lunite_release(ptr %tmp194)
  br label %when_end121

then158:                                          ; preds = %else139
  %struct_name161 = load ptr, ptr %struct_name, align 8
  call void @lunite_retain(ptr %struct_name161)
  %sdata162 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata162, ptr align 1 @slit.150, i64 1, i1 false)
  %sstruct163 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p164 = getelementptr inbounds { ptr, i64 }, ptr %sstruct163, i32 0, i32 0
  %l165 = getelementptr inbounds { ptr, i64 }, ptr %sstruct163, i32 0, i32 1
  store ptr %sdata162, ptr %p164, align 8
  store i64 1, ptr %l165, align 8
  call void @lunite_retain(ptr %sstruct163)
  %method_name166 = load ptr, ptr %method_name, align 8
  call void @lunite_retain(ptr %method_name166)
  %res167 = call ptr @string_concat(ptr %sstruct163, ptr %method_name166)
  call void @lunite_retain(ptr %res167)
  %res168 = call ptr @string_concat(ptr %struct_name161, ptr %res167)
  %old169 = load ptr, ptr %func_name, align 8
  call void @lunite_retain(ptr %res168)
  store ptr %res168, ptr %func_name, align 8
  call void @lunite_release(ptr %old169)
  %obj_expr170 = load ptr, ptr %obj_expr, align 8
  %old171 = load ptr, ptr %first_arg, align 8
  call void @lunite_retain(ptr %obj_expr170)
  store ptr %obj_expr170, ptr %first_arg, align 8
  call void @lunite_release(ptr %old171)
  br label %cont160

else159:                                          ; preds = %else139
  %obj_expr172 = load ptr, ptr %obj_expr, align 8
  call void @lunite_retain(ptr %obj_expr172)
  %sdata173 = call ptr @lunite_alloc(i64 2, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata173, ptr align 1 @slit.151, i64 2, i1 false)
  %sstruct174 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p175 = getelementptr inbounds { ptr, i64 }, ptr %sstruct174, i32 0, i32 0
  %l176 = getelementptr inbounds { ptr, i64 }, ptr %sstruct174, i32 0, i32 1
  store ptr %sdata173, ptr %p175, align 8
  store i64 2, ptr %l176, align 8
  call void @lunite_retain(ptr %sstruct174)
  %res177 = call ptr @string_concat(ptr %obj_expr172, ptr %sstruct174)
  call void @lunite_retain(ptr %res177)
  %ma178 = load ptr, ptr %ma, align 8
  %fp179 = getelementptr inbounds %ast_MemberAccessExpressionPayload, ptr %ma178, i32 0, i32 1
  %field180 = load ptr, ptr %fp179, align 8
  call void @lunite_retain(ptr %field180)
  %res181 = call ptr @string_concat(ptr %res177, ptr %field180)
  call void @lunite_retain(ptr %res181)
  %tmp182 = load ptr, ptr %struct_name, align 8
  call void @lunite_release(ptr %tmp182)
  %tmp183 = load ptr, ptr %method_name, align 8
  call void @lunite_release(ptr %tmp183)
  %tmp184 = load ptr, ptr %obj_expr, align 8
  call void @lunite_release(ptr %tmp184)
  %tmp185 = load ptr, ptr %ma, align 8
  call void @lunite_release(ptr %tmp185)
  %tmp186 = load ptr, ptr %first_arg, align 8
  call void @lunite_release(ptr %tmp186)
  %tmp187 = load ptr, ptr %func_name, align 8
  call void @lunite_release(ptr %tmp187)
  %tmp188 = load ptr, ptr %payload109, align 8
  call void @lunite_release(ptr %tmp188)
  %tmp189 = load ptr, ptr %e, align 8
  call void @lunite_release(ptr %tmp189)
  %tmp190 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp190)
  ret ptr %res181

cont160:                                          ; preds = %then158
  %tmp191 = load ptr, ptr %struct_name, align 8
  call void @lunite_release(ptr %tmp191)
  %tmp192 = load ptr, ptr %method_name, align 8
  call void @lunite_release(ptr %tmp192)
  br label %cont140

when_next195:                                     ; preds = %when_next122
  br label %when_body206

when_body196:                                     ; preds = %when_next122
  %pptr200 = getelementptr inbounds { i64, [8 x i8] }, ptr %deref120, i32 0, i32 1
  %pval201 = load ptr, ptr %pptr200, align 8
  call void @lunite_retain(ptr %pval201)
  store ptr %pval201, ptr %id, align 8
  %id202 = load ptr, ptr %id, align 8
  %old203 = load ptr, ptr %func_name, align 8
  call void @lunite_retain(ptr %id202)
  store ptr %id202, ptr %func_name, align 8
  call void @lunite_release(ptr %old203)
  %tmp204 = load ptr, ptr %id, align 8
  call void @lunite_release(ptr %tmp204)
  br label %when_end121

when_next205:                                     ; No predecessors!
  br label %when_end121

when_body206:                                     ; preds = %when_next195
  %self207 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self207)
  %payload208 = load ptr, ptr %payload109, align 8
  %fp209 = getelementptr inbounds %ast_CallExpressionPayload, ptr %payload208, i32 0, i32 0
  %function210 = load ptr, ptr %fp209, align 8
  %deref211 = load ptr, ptr %function210, align 8
  call void @lunite_retain(ptr %deref211)
  %res212 = call ptr @codegen_c_CodegenC_gen_expr(ptr %self207, ptr %deref211)
  %old213 = load ptr, ptr %func_name, align 8
  call void @lunite_retain(ptr %res212)
  store ptr %res212, ptr %func_name, align 8
  call void @lunite_release(ptr %old213)
  br label %when_end121

while_cond:                                       ; preds = %cont223, %when_end121
  %i215 = load i64, ptr %i, align 8
  %payload216 = load ptr, ptr %payload109, align 8
  %fp217 = getelementptr inbounds %ast_CallExpressionPayload, ptr %payload216, i32 0, i32 1
  %args = load ptr, ptr %fp217, align 8
  %fp218 = getelementptr inbounds %list_List, ptr %args, i32 0, i32 1
  %count = load i64, ptr %fp218, align 8
  %2 = icmp slt i64 %i215, %count
  br i1 %2, label %while_body, label %while_end

while_body:                                       ; preds = %while_cond
  %args_str219 = load ptr, ptr %args_str, align 8
  call void @lunite_retain(ptr %args_str219)
  %res220 = call i64 @string_length(ptr %args_str219)
  %3 = icmp sgt i64 %res220, 0
  br i1 %3, label %then221, label %else222

while_end:                                        ; preds = %while_cond
  %func_name242 = load ptr, ptr %func_name, align 8
  call void @lunite_retain(ptr %func_name242)
  %sdata243 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata243, ptr align 1 @slit.153, i64 1, i1 false)
  %sstruct244 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p245 = getelementptr inbounds { ptr, i64 }, ptr %sstruct244, i32 0, i32 0
  %l246 = getelementptr inbounds { ptr, i64 }, ptr %sstruct244, i32 0, i32 1
  store ptr %sdata243, ptr %p245, align 8
  store i64 1, ptr %l246, align 8
  call void @lunite_retain(ptr %sstruct244)
  %res247 = call ptr @string_concat(ptr %func_name242, ptr %sstruct244)
  call void @lunite_retain(ptr %res247)
  %args_str248 = load ptr, ptr %args_str, align 8
  call void @lunite_retain(ptr %args_str248)
  %res249 = call ptr @string_concat(ptr %res247, ptr %args_str248)
  call void @lunite_retain(ptr %res249)
  %sdata250 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata250, ptr align 1 @slit.154, i64 1, i1 false)
  %sstruct251 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p252 = getelementptr inbounds { ptr, i64 }, ptr %sstruct251, i32 0, i32 0
  %l253 = getelementptr inbounds { ptr, i64 }, ptr %sstruct251, i32 0, i32 1
  store ptr %sdata250, ptr %p252, align 8
  store i64 1, ptr %l253, align 8
  call void @lunite_retain(ptr %sstruct251)
  %res254 = call ptr @string_concat(ptr %res249, ptr %sstruct251)
  call void @lunite_retain(ptr %res254)
  %tmp255 = load ptr, ptr %args_str, align 8
  call void @lunite_release(ptr %tmp255)
  %tmp256 = load ptr, ptr %first_arg, align 8
  call void @lunite_release(ptr %tmp256)
  %tmp257 = load ptr, ptr %func_name, align 8
  call void @lunite_release(ptr %tmp257)
  %tmp258 = load ptr, ptr %payload109, align 8
  call void @lunite_release(ptr %tmp258)
  %tmp259 = load ptr, ptr %e, align 8
  call void @lunite_release(ptr %tmp259)
  %tmp260 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp260)
  ret ptr %res254

then221:                                          ; preds = %while_body
  %args_str224 = load ptr, ptr %args_str, align 8
  call void @lunite_retain(ptr %args_str224)
  %sdata225 = call ptr @lunite_alloc(i64 2, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata225, ptr align 1 @slit.152, i64 2, i1 false)
  %sstruct226 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p227 = getelementptr inbounds { ptr, i64 }, ptr %sstruct226, i32 0, i32 0
  %l228 = getelementptr inbounds { ptr, i64 }, ptr %sstruct226, i32 0, i32 1
  store ptr %sdata225, ptr %p227, align 8
  store i64 2, ptr %l228, align 8
  call void @lunite_retain(ptr %sstruct226)
  %res229 = call ptr @string_concat(ptr %args_str224, ptr %sstruct226)
  %old230 = load ptr, ptr %args_str, align 8
  call void @lunite_retain(ptr %res229)
  store ptr %res229, ptr %args_str, align 8
  call void @lunite_release(ptr %old230)
  br label %cont223

else222:                                          ; preds = %while_body
  br label %cont223

cont223:                                          ; preds = %else222, %then221
  %args_str231 = load ptr, ptr %args_str, align 8
  call void @lunite_retain(ptr %args_str231)
  %self232 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self232)
  %payload233 = load ptr, ptr %payload109, align 8
  %fp234 = getelementptr inbounds %ast_CallExpressionPayload, ptr %payload233, i32 0, i32 1
  %args235 = load ptr, ptr %fp234, align 8
  %fp236 = getelementptr inbounds %list_List, ptr %args235, i32 0, i32 0
  %data = load ptr, ptr %fp236, align 8
  %i237 = load i64, ptr %i, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %i237
  %val = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val)
  %res238 = call ptr @codegen_c_CodegenC_gen_expr(ptr %self232, ptr %val)
  call void @lunite_retain(ptr %res238)
  %res239 = call ptr @string_concat(ptr %args_str231, ptr %res238)
  %old240 = load ptr, ptr %args_str, align 8
  call void @lunite_retain(ptr %res239)
  store ptr %res239, ptr %args_str, align 8
  call void @lunite_release(ptr %old240)
  %i241 = load i64, ptr %i, align 8
  %4 = add i64 %i241, 1
  store i64 %4, ptr %i, align 8
  br label %while_cond

when_next261:                                     ; preds = %when_next102
  %tptr291 = getelementptr inbounds { i64, [8 x i8] }, ptr %e1, i32 0, i32 0
  %tag292 = load i64, ptr %tptr291, align 8
  %match293 = icmp eq i64 %tag292, 10
  br i1 %match293, label %when_body290, label %when_next289

when_body262:                                     ; preds = %when_next102
  %pptr266 = getelementptr inbounds { i64, [8 x i8] }, ptr %e1, i32 0, i32 1
  %pval267 = load ptr, ptr %pptr266, align 8
  call void @lunite_retain(ptr %pval267)
  store ptr %pval267, ptr %payload268, align 8
  %self269 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self269)
  %payload270 = load ptr, ptr %payload268, align 8
  %fp271 = getelementptr inbounds %ast_MemberAccessExpressionPayload, ptr %payload270, i32 0, i32 0
  %object272 = load ptr, ptr %fp271, align 8
  %deref273 = load ptr, ptr %object272, align 8
  call void @lunite_retain(ptr %deref273)
  %res274 = call ptr @codegen_c_CodegenC_gen_expr(ptr %self269, ptr %deref273)
  call void @lunite_retain(ptr %res274)
  store ptr %res274, ptr %obj, align 8
  %obj275 = load ptr, ptr %obj, align 8
  call void @lunite_retain(ptr %obj275)
  %sdata276 = call ptr @lunite_alloc(i64 2, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata276, ptr align 1 @slit.155, i64 2, i1 false)
  %sstruct277 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p278 = getelementptr inbounds { ptr, i64 }, ptr %sstruct277, i32 0, i32 0
  %l279 = getelementptr inbounds { ptr, i64 }, ptr %sstruct277, i32 0, i32 1
  store ptr %sdata276, ptr %p278, align 8
  store i64 2, ptr %l279, align 8
  call void @lunite_retain(ptr %sstruct277)
  %res280 = call ptr @string_concat(ptr %obj275, ptr %sstruct277)
  call void @lunite_retain(ptr %res280)
  %payload281 = load ptr, ptr %payload268, align 8
  %fp282 = getelementptr inbounds %ast_MemberAccessExpressionPayload, ptr %payload281, i32 0, i32 1
  %field283 = load ptr, ptr %fp282, align 8
  call void @lunite_retain(ptr %field283)
  %res284 = call ptr @string_concat(ptr %res280, ptr %field283)
  call void @lunite_retain(ptr %res284)
  %tmp285 = load ptr, ptr %obj, align 8
  call void @lunite_release(ptr %tmp285)
  %tmp286 = load ptr, ptr %payload268, align 8
  call void @lunite_release(ptr %tmp286)
  %tmp287 = load ptr, ptr %e, align 8
  call void @lunite_release(ptr %tmp287)
  %tmp288 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp288)
  ret ptr %res284

when_next289:                                     ; preds = %when_next261
  br label %when_body374

when_body290:                                     ; preds = %when_next261
  %pptr294 = getelementptr inbounds { i64, [8 x i8] }, ptr %e1, i32 0, i32 1
  %pval295 = load ptr, ptr %pptr294, align 8
  call void @lunite_retain(ptr %pval295)
  store ptr %pval295, ptr %payload296, align 8
  %sdata297 = call ptr @lunite_alloc(i64 8, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata297, ptr align 1 @slit.156, i64 8, i1 false)
  %sstruct298 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p299 = getelementptr inbounds { ptr, i64 }, ptr %sstruct298, i32 0, i32 0
  %l300 = getelementptr inbounds { ptr, i64 }, ptr %sstruct298, i32 0, i32 1
  store ptr %sdata297, ptr %p299, align 8
  store i64 8, ptr %l300, align 8
  call void @lunite_retain(ptr %sstruct298)
  %payload301 = load ptr, ptr %payload296, align 8
  %fp302 = getelementptr inbounds %ast_StructInitExpressionPayload, ptr %payload301, i32 0, i32 0
  %name303 = load ptr, ptr %fp302, align 8
  call void @lunite_retain(ptr %name303)
  %res304 = call ptr @string_concat(ptr %sstruct298, ptr %name303)
  call void @lunite_retain(ptr %res304)
  %sdata305 = call ptr @lunite_alloc(i64 3, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata305, ptr align 1 @slit.157, i64 3, i1 false)
  %sstruct306 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p307 = getelementptr inbounds { ptr, i64 }, ptr %sstruct306, i32 0, i32 0
  %l308 = getelementptr inbounds { ptr, i64 }, ptr %sstruct306, i32 0, i32 1
  store ptr %sdata305, ptr %p307, align 8
  store i64 3, ptr %l308, align 8
  call void @lunite_retain(ptr %sstruct306)
  %res309 = call ptr @string_concat(ptr %res304, ptr %sstruct306)
  call void @lunite_retain(ptr %res309)
  store ptr %res309, ptr %init, align 8
  store i64 0, ptr %i310, align 8
  br label %while_cond311

while_cond311:                                    ; preds = %cont330, %when_body290
  %i314 = load i64, ptr %i310, align 8
  %payload315 = load ptr, ptr %payload296, align 8
  %fp316 = getelementptr inbounds %ast_StructInitExpressionPayload, ptr %payload315, i32 0, i32 2
  %fields = load ptr, ptr %fp316, align 8
  %fp317 = getelementptr inbounds %list_List, ptr %fields, i32 0, i32 1
  %count318 = load i64, ptr %fp317, align 8
  %5 = icmp slt i64 %i314, %count318
  br i1 %5, label %while_body312, label %while_end313

while_body312:                                    ; preds = %while_cond311
  %payload319 = load ptr, ptr %payload296, align 8
  %fp320 = getelementptr inbounds %ast_StructInitExpressionPayload, ptr %payload319, i32 0, i32 2
  %fields321 = load ptr, ptr %fp320, align 8
  %fp322 = getelementptr inbounds %list_List, ptr %fields321, i32 0, i32 0
  %data323 = load ptr, ptr %fp322, align 8
  %i324 = load i64, ptr %i310, align 8
  %ptr325 = getelementptr ptr, ptr %data323, i64 %i324
  %val326 = load ptr, ptr %ptr325, align 8
  call void @lunite_retain(ptr %val326)
  store ptr %val326, ptr %f, align 8
  %i327 = load i64, ptr %i310, align 8
  %6 = icmp sgt i64 %i327, 0
  br i1 %6, label %then328, label %else329

while_end313:                                     ; preds = %while_cond311
  %init363 = load ptr, ptr %init, align 8
  call void @lunite_retain(ptr %init363)
  %sdata364 = call ptr @lunite_alloc(i64 2, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata364, ptr align 1 @slit.161, i64 2, i1 false)
  %sstruct365 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p366 = getelementptr inbounds { ptr, i64 }, ptr %sstruct365, i32 0, i32 0
  %l367 = getelementptr inbounds { ptr, i64 }, ptr %sstruct365, i32 0, i32 1
  store ptr %sdata364, ptr %p366, align 8
  store i64 2, ptr %l367, align 8
  call void @lunite_retain(ptr %sstruct365)
  %res368 = call ptr @string_concat(ptr %init363, ptr %sstruct365)
  call void @lunite_retain(ptr %res368)
  %tmp369 = load ptr, ptr %init, align 8
  call void @lunite_release(ptr %tmp369)
  %tmp370 = load ptr, ptr %payload296, align 8
  call void @lunite_release(ptr %tmp370)
  %tmp371 = load ptr, ptr %e, align 8
  call void @lunite_release(ptr %tmp371)
  %tmp372 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp372)
  ret ptr %res368

then328:                                          ; preds = %while_body312
  %init331 = load ptr, ptr %init, align 8
  call void @lunite_retain(ptr %init331)
  %sdata332 = call ptr @lunite_alloc(i64 2, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata332, ptr align 1 @slit.158, i64 2, i1 false)
  %sstruct333 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p334 = getelementptr inbounds { ptr, i64 }, ptr %sstruct333, i32 0, i32 0
  %l335 = getelementptr inbounds { ptr, i64 }, ptr %sstruct333, i32 0, i32 1
  store ptr %sdata332, ptr %p334, align 8
  store i64 2, ptr %l335, align 8
  call void @lunite_retain(ptr %sstruct333)
  %res336 = call ptr @string_concat(ptr %init331, ptr %sstruct333)
  %old337 = load ptr, ptr %init, align 8
  call void @lunite_retain(ptr %res336)
  store ptr %res336, ptr %init, align 8
  call void @lunite_release(ptr %old337)
  br label %cont330

else329:                                          ; preds = %while_body312
  br label %cont330

cont330:                                          ; preds = %else329, %then328
  %init338 = load ptr, ptr %init, align 8
  call void @lunite_retain(ptr %init338)
  %sdata339 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata339, ptr align 1 @slit.159, i64 1, i1 false)
  %sstruct340 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p341 = getelementptr inbounds { ptr, i64 }, ptr %sstruct340, i32 0, i32 0
  %l342 = getelementptr inbounds { ptr, i64 }, ptr %sstruct340, i32 0, i32 1
  store ptr %sdata339, ptr %p341, align 8
  store i64 1, ptr %l342, align 8
  call void @lunite_retain(ptr %sstruct340)
  %f343 = load ptr, ptr %f, align 8
  %fp344 = getelementptr inbounds %ast_NamedExpression, ptr %f343, i32 0, i32 0
  %name345 = load ptr, ptr %fp344, align 8
  call void @lunite_retain(ptr %name345)
  %res346 = call ptr @string_concat(ptr %sstruct340, ptr %name345)
  call void @lunite_retain(ptr %res346)
  %sdata347 = call ptr @lunite_alloc(i64 3, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata347, ptr align 1 @slit.160, i64 3, i1 false)
  %sstruct348 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p349 = getelementptr inbounds { ptr, i64 }, ptr %sstruct348, i32 0, i32 0
  %l350 = getelementptr inbounds { ptr, i64 }, ptr %sstruct348, i32 0, i32 1
  store ptr %sdata347, ptr %p349, align 8
  store i64 3, ptr %l350, align 8
  call void @lunite_retain(ptr %sstruct348)
  %res351 = call ptr @string_concat(ptr %res346, ptr %sstruct348)
  call void @lunite_retain(ptr %res351)
  %res352 = call ptr @string_concat(ptr %init338, ptr %res351)
  %old353 = load ptr, ptr %init, align 8
  call void @lunite_retain(ptr %res352)
  store ptr %res352, ptr %init, align 8
  call void @lunite_release(ptr %old353)
  %init354 = load ptr, ptr %init, align 8
  call void @lunite_retain(ptr %init354)
  %self355 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self355)
  %f356 = load ptr, ptr %f, align 8
  %fp357 = getelementptr inbounds %ast_NamedExpression, ptr %f356, i32 0, i32 1
  %expr = load ptr, ptr %fp357, align 8
  call void @lunite_retain(ptr %expr)
  %res358 = call ptr @codegen_c_CodegenC_gen_expr(ptr %self355, ptr %expr)
  call void @lunite_retain(ptr %res358)
  %res359 = call ptr @string_concat(ptr %init354, ptr %res358)
  %old360 = load ptr, ptr %init, align 8
  call void @lunite_retain(ptr %res359)
  store ptr %res359, ptr %init, align 8
  call void @lunite_release(ptr %old360)
  %i361 = load i64, ptr %i310, align 8
  %7 = add i64 %i361, 1
  store i64 %7, ptr %i310, align 8
  %tmp362 = load ptr, ptr %f, align 8
  call void @lunite_release(ptr %tmp362)
  br label %while_cond311

when_next373:                                     ; No predecessors!
  br label %when_end

when_body374:                                     ; preds = %when_next289
  %sdata375 = call ptr @lunite_alloc(i64 11, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata375, ptr align 1 @slit.162, i64 11, i1 false)
  %sstruct376 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p377 = getelementptr inbounds { ptr, i64 }, ptr %sstruct376, i32 0, i32 0
  %l378 = getelementptr inbounds { ptr, i64 }, ptr %sstruct376, i32 0, i32 1
  store ptr %sdata375, ptr %p377, align 8
  store i64 11, ptr %l378, align 8
  call void @lunite_retain(ptr %sstruct376)
  %tmp379 = load ptr, ptr %e, align 8
  call void @lunite_release(ptr %tmp379)
  %tmp380 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp380)
  ret ptr %sstruct376
}

define ptr @codegen_c_CodegenC_gen_op(ptr %0, ptr %1) {
entry:
  %op = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %op, align 8
  %op1 = load ptr, ptr %op, align 8
  %tptr = getelementptr inbounds { i64, [8 x i8] }, ptr %op1, i32 0, i32 0
  %tag = load i64, ptr %tptr, align 8
  %match = icmp eq i64 %tag, 6
  br i1 %match, label %when_body, label %when_next

when_end:                                         ; preds = %when_next36
  %tmp44 = load ptr, ptr %op, align 8
  call void @lunite_release(ptr %tmp44)
  %tmp45 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp45)
  ret ptr null

when_next:                                        ; preds = %body
  %tptr5 = getelementptr inbounds { i64, [8 x i8] }, ptr %op1, i32 0, i32 0
  %tag6 = load i64, ptr %tptr5, align 8
  %match7 = icmp eq i64 %tag6, 7
  br i1 %match7, label %when_body4, label %when_next3

when_body:                                        ; preds = %body
  %sdata = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.163, i64 1, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p, align 8
  store i64 1, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  %tmp = load ptr, ptr %op, align 8
  call void @lunite_release(ptr %tmp)
  %tmp2 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp2)
  ret ptr %sstruct

when_next3:                                       ; preds = %when_next
  %tptr16 = getelementptr inbounds { i64, [8 x i8] }, ptr %op1, i32 0, i32 0
  %tag17 = load i64, ptr %tptr16, align 8
  %match18 = icmp eq i64 %tag17, 12
  br i1 %match18, label %when_body15, label %when_next14

when_body4:                                       ; preds = %when_next
  %sdata8 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata8, ptr align 1 @slit.164, i64 1, i1 false)
  %sstruct9 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p10 = getelementptr inbounds { ptr, i64 }, ptr %sstruct9, i32 0, i32 0
  %l11 = getelementptr inbounds { ptr, i64 }, ptr %sstruct9, i32 0, i32 1
  store ptr %sdata8, ptr %p10, align 8
  store i64 1, ptr %l11, align 8
  call void @lunite_retain(ptr %sstruct9)
  %tmp12 = load ptr, ptr %op, align 8
  call void @lunite_release(ptr %tmp12)
  %tmp13 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp13)
  ret ptr %sstruct9

when_next14:                                      ; preds = %when_next3
  %tptr27 = getelementptr inbounds { i64, [8 x i8] }, ptr %op1, i32 0, i32 0
  %tag28 = load i64, ptr %tptr27, align 8
  %match29 = icmp eq i64 %tag28, 14
  br i1 %match29, label %when_body26, label %when_next25

when_body15:                                      ; preds = %when_next3
  %sdata19 = call ptr @lunite_alloc(i64 2, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata19, ptr align 1 @slit.165, i64 2, i1 false)
  %sstruct20 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p21 = getelementptr inbounds { ptr, i64 }, ptr %sstruct20, i32 0, i32 0
  %l22 = getelementptr inbounds { ptr, i64 }, ptr %sstruct20, i32 0, i32 1
  store ptr %sdata19, ptr %p21, align 8
  store i64 2, ptr %l22, align 8
  call void @lunite_retain(ptr %sstruct20)
  %tmp23 = load ptr, ptr %op, align 8
  call void @lunite_release(ptr %tmp23)
  %tmp24 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp24)
  ret ptr %sstruct20

when_next25:                                      ; preds = %when_next14
  br label %when_body37

when_body26:                                      ; preds = %when_next14
  %sdata30 = call ptr @lunite_alloc(i64 2, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata30, ptr align 1 @slit.166, i64 2, i1 false)
  %sstruct31 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p32 = getelementptr inbounds { ptr, i64 }, ptr %sstruct31, i32 0, i32 0
  %l33 = getelementptr inbounds { ptr, i64 }, ptr %sstruct31, i32 0, i32 1
  store ptr %sdata30, ptr %p32, align 8
  store i64 2, ptr %l33, align 8
  call void @lunite_retain(ptr %sstruct31)
  %tmp34 = load ptr, ptr %op, align 8
  call void @lunite_release(ptr %tmp34)
  %tmp35 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp35)
  ret ptr %sstruct31

when_next36:                                      ; No predecessors!
  br label %when_end

when_body37:                                      ; preds = %when_next25
  %sdata38 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata38, ptr align 1 @slit.167, i64 1, i1 false)
  %sstruct39 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p40 = getelementptr inbounds { ptr, i64 }, ptr %sstruct39, i32 0, i32 0
  %l41 = getelementptr inbounds { ptr, i64 }, ptr %sstruct39, i32 0, i32 1
  store ptr %sdata38, ptr %p40, align 8
  store i64 1, ptr %l41, align 8
  call void @lunite_retain(ptr %sstruct39)
  %tmp42 = load ptr, ptr %op, align 8
  call void @lunite_release(ptr %tmp42)
  %tmp43 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp43)
  ret ptr %sstruct39
}

define void @codegen_c_CodegenC_gen_stmt(ptr %0, ptr %1) {
entry:
  %bname = alloca ptr, align 8
  %access = alloca ptr, align 8
  %cast = alloca ptr, align 8
  %tag_const = alloca ptr, align 8
  %ev = alloca ptr, align 8
  %arm = alloca ptr, align 8
  %i = alloca i64, align 8
  %first = alloca i1, align 1
  %subject_var = alloca ptr, align 8
  %payload237 = alloca ptr, align 8
  %payload194 = alloca ptr, align 8
  %b = alloca ptr, align 8
  %payload124 = alloca ptr, align 8
  %e106 = alloca ptr, align 8
  %e = alloca ptr, align 8
  %opt = alloca ptr, align 8
  %v = alloca ptr, align 8
  %t = alloca ptr, align 8
  %type_str = alloca ptr, align 8
  %payload = alloca ptr, align 8
  %s = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %s, align 8
  %s1 = load ptr, ptr %s, align 8
  %tptr = getelementptr inbounds { i64, [8 x i8] }, ptr %s1, i32 0, i32 0
  %tag = load i64, ptr %tptr, align 8
  %match = icmp eq i64 %tag, 0
  br i1 %match, label %when_body, label %when_next

when_end:                                         ; preds = %when_next426, %when_body427, %while_end, %when_body188, %when_end153, %when_body100, %when_end69, %when_end31
  %tmp428 = load ptr, ptr %s, align 8
  call void @lunite_release(ptr %tmp428)
  %tmp429 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp429)
  ret void

when_next:                                        ; preds = %body
  %tptr63 = getelementptr inbounds { i64, [8 x i8] }, ptr %s1, i32 0, i32 0
  %tag64 = load i64, ptr %tptr63, align 8
  %match65 = icmp eq i64 %tag64, 2
  br i1 %match65, label %when_body62, label %when_next61

when_body:                                        ; preds = %body
  %pptr = getelementptr inbounds { i64, [8 x i8] }, ptr %s1, i32 0, i32 1
  %pval = load ptr, ptr %pptr, align 8
  call void @lunite_retain(ptr %pval)
  store ptr %pval, ptr %payload, align 8
  %sdata = call ptr @lunite_alloc(i64 5, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.168, i64 5, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p, align 8
  store i64 5, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  store ptr %sstruct, ptr %type_str, align 8
  %payload2 = load ptr, ptr %payload, align 8
  %fp = getelementptr inbounds %ast_LetStatementPayload, ptr %payload2, i32 0, i32 2
  %type_name = load ptr, ptr %fp, align 8
  %tptr6 = getelementptr inbounds { i64, [8 x i8] }, ptr %type_name, i32 0, i32 0
  %tag7 = load i64, ptr %tptr6, align 8
  %match8 = icmp eq i64 %tag7, 0
  br i1 %match8, label %when_body5, label %when_next4

when_end3:                                        ; preds = %when_next13, %when_body14, %when_body5
  %self15 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self15)
  %type_str16 = load ptr, ptr %type_str, align 8
  call void @lunite_retain(ptr %type_str16)
  %sdata17 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata17, ptr align 1 @slit.169, i64 1, i1 false)
  %sstruct18 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p19 = getelementptr inbounds { ptr, i64 }, ptr %sstruct18, i32 0, i32 0
  %l20 = getelementptr inbounds { ptr, i64 }, ptr %sstruct18, i32 0, i32 1
  store ptr %sdata17, ptr %p19, align 8
  store i64 1, ptr %l20, align 8
  call void @lunite_retain(ptr %sstruct18)
  %res21 = call ptr @string_concat(ptr %type_str16, ptr %sstruct18)
  call void @lunite_retain(ptr %res21)
  %payload22 = load ptr, ptr %payload, align 8
  %fp23 = getelementptr inbounds %ast_LetStatementPayload, ptr %payload22, i32 0, i32 0
  %name = load ptr, ptr %fp23, align 8
  call void @lunite_retain(ptr %name)
  %res24 = call ptr @string_concat(ptr %res21, ptr %name)
  call void @lunite_retain(ptr %res24)
  %sdata25 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata25, ptr align 1 @slit.170, i64 1, i1 false)
  %sstruct26 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p27 = getelementptr inbounds { ptr, i64 }, ptr %sstruct26, i32 0, i32 0
  %l28 = getelementptr inbounds { ptr, i64 }, ptr %sstruct26, i32 0, i32 1
  store ptr %sdata25, ptr %p27, align 8
  store i64 1, ptr %l28, align 8
  call void @lunite_retain(ptr %sstruct26)
  call void @codegen_c_CodegenC_emit_line(ptr %self15, ptr %res24, ptr %sstruct26)
  %payload29 = load ptr, ptr %payload, align 8
  %fp30 = getelementptr inbounds %ast_LetStatementPayload, ptr %payload29, i32 0, i32 3
  %value = load ptr, ptr %fp30, align 8
  %tptr34 = getelementptr inbounds { i64, [8 x i8] }, ptr %value, i32 0, i32 0
  %tag35 = load i64, ptr %tptr34, align 8
  %match36 = icmp eq i64 %tag35, 0
  br i1 %match36, label %when_body33, label %when_next32

when_next4:                                       ; preds = %when_body
  br label %when_body14

when_body5:                                       ; preds = %when_body
  %pptr9 = getelementptr inbounds { i64, [8 x i8] }, ptr %type_name, i32 0, i32 1
  %pval10 = load ptr, ptr %pptr9, align 8
  call void @lunite_retain(ptr %pval10)
  store ptr %pval10, ptr %t, align 8
  %self11 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self11)
  %t12 = load ptr, ptr %t, align 8
  call void @lunite_retain(ptr %t12)
  %res = call ptr @codegen_c_CodegenC_gen_type(ptr %self11, ptr %t12)
  %old = load ptr, ptr %type_str, align 8
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %type_str, align 8
  call void @lunite_release(ptr %old)
  %tmp = load ptr, ptr %t, align 8
  call void @lunite_release(ptr %tmp)
  br label %when_end3

when_next13:                                      ; No predecessors!
  br label %when_end3

when_body14:                                      ; preds = %when_next4
  br label %when_end3

when_end31:                                       ; preds = %when_next57, %when_body58, %when_body33
  %tmp59 = load ptr, ptr %type_str, align 8
  call void @lunite_release(ptr %tmp59)
  %tmp60 = load ptr, ptr %payload, align 8
  call void @lunite_release(ptr %tmp60)
  br label %when_end

when_next32:                                      ; preds = %when_end3
  br label %when_body58

when_body33:                                      ; preds = %when_end3
  %pptr37 = getelementptr inbounds { i64, [8 x i8] }, ptr %value, i32 0, i32 1
  %pval38 = load ptr, ptr %pptr37, align 8
  call void @lunite_retain(ptr %pval38)
  store ptr %pval38, ptr %v, align 8
  %self39 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self39)
  %payload40 = load ptr, ptr %payload, align 8
  %fp41 = getelementptr inbounds %ast_LetStatementPayload, ptr %payload40, i32 0, i32 0
  %name42 = load ptr, ptr %fp41, align 8
  call void @lunite_retain(ptr %name42)
  %sdata43 = call ptr @lunite_alloc(i64 3, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata43, ptr align 1 @slit.171, i64 3, i1 false)
  %sstruct44 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p45 = getelementptr inbounds { ptr, i64 }, ptr %sstruct44, i32 0, i32 0
  %l46 = getelementptr inbounds { ptr, i64 }, ptr %sstruct44, i32 0, i32 1
  store ptr %sdata43, ptr %p45, align 8
  store i64 3, ptr %l46, align 8
  call void @lunite_retain(ptr %sstruct44)
  %res47 = call ptr @string_concat(ptr %name42, ptr %sstruct44)
  call void @lunite_retain(ptr %res47)
  %self48 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self48)
  %v49 = load ptr, ptr %v, align 8
  call void @lunite_retain(ptr %v49)
  %res50 = call ptr @codegen_c_CodegenC_gen_expr(ptr %self48, ptr %v49)
  call void @lunite_retain(ptr %res50)
  %res51 = call ptr @string_concat(ptr %res47, ptr %res50)
  call void @lunite_retain(ptr %res51)
  %sdata52 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata52, ptr align 1 @slit.172, i64 1, i1 false)
  %sstruct53 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p54 = getelementptr inbounds { ptr, i64 }, ptr %sstruct53, i32 0, i32 0
  %l55 = getelementptr inbounds { ptr, i64 }, ptr %sstruct53, i32 0, i32 1
  store ptr %sdata52, ptr %p54, align 8
  store i64 1, ptr %l55, align 8
  call void @lunite_retain(ptr %sstruct53)
  call void @codegen_c_CodegenC_emit_line(ptr %self39, ptr %res51, ptr %sstruct53)
  %tmp56 = load ptr, ptr %v, align 8
  call void @lunite_release(ptr %tmp56)
  br label %when_end31

when_next57:                                      ; No predecessors!
  br label %when_end31

when_body58:                                      ; preds = %when_next32
  br label %when_end31

when_next61:                                      ; preds = %when_next
  %tptr101 = getelementptr inbounds { i64, [8 x i8] }, ptr %s1, i32 0, i32 0
  %tag102 = load i64, ptr %tptr101, align 8
  %match103 = icmp eq i64 %tag102, 11
  br i1 %match103, label %when_body100, label %when_next99

when_body62:                                      ; preds = %when_next
  %pptr66 = getelementptr inbounds { i64, [8 x i8] }, ptr %s1, i32 0, i32 1
  %pval67 = load ptr, ptr %pptr66, align 8
  call void @lunite_retain(ptr %pval67)
  store ptr %pval67, ptr %opt, align 8
  %opt68 = load ptr, ptr %opt, align 8
  %tptr72 = getelementptr inbounds { i64, [8 x i8] }, ptr %opt68, i32 0, i32 0
  %tag73 = load i64, ptr %tptr72, align 8
  %match74 = icmp eq i64 %tag73, 0
  br i1 %match74, label %when_body71, label %when_next70

when_end69:                                       ; preds = %when_next91, %when_body92, %when_body71
  %tmp98 = load ptr, ptr %opt, align 8
  call void @lunite_release(ptr %tmp98)
  br label %when_end

when_next70:                                      ; preds = %when_body62
  br label %when_body92

when_body71:                                      ; preds = %when_body62
  %pptr75 = getelementptr inbounds { i64, [8 x i8] }, ptr %opt68, i32 0, i32 1
  %pval76 = load ptr, ptr %pptr75, align 8
  call void @lunite_retain(ptr %pval76)
  store ptr %pval76, ptr %e, align 8
  %self77 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self77)
  %sdata78 = call ptr @lunite_alloc(i64 7, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata78, ptr align 1 @slit.173, i64 7, i1 false)
  %sstruct79 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p80 = getelementptr inbounds { ptr, i64 }, ptr %sstruct79, i32 0, i32 0
  %l81 = getelementptr inbounds { ptr, i64 }, ptr %sstruct79, i32 0, i32 1
  store ptr %sdata78, ptr %p80, align 8
  store i64 7, ptr %l81, align 8
  call void @lunite_retain(ptr %sstruct79)
  %self82 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self82)
  %e83 = load ptr, ptr %e, align 8
  call void @lunite_retain(ptr %e83)
  %res84 = call ptr @codegen_c_CodegenC_gen_expr(ptr %self82, ptr %e83)
  call void @lunite_retain(ptr %res84)
  %res85 = call ptr @string_concat(ptr %sstruct79, ptr %res84)
  call void @lunite_retain(ptr %res85)
  %sdata86 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata86, ptr align 1 @slit.174, i64 1, i1 false)
  %sstruct87 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p88 = getelementptr inbounds { ptr, i64 }, ptr %sstruct87, i32 0, i32 0
  %l89 = getelementptr inbounds { ptr, i64 }, ptr %sstruct87, i32 0, i32 1
  store ptr %sdata86, ptr %p88, align 8
  store i64 1, ptr %l89, align 8
  call void @lunite_retain(ptr %sstruct87)
  call void @codegen_c_CodegenC_emit_line(ptr %self77, ptr %res85, ptr %sstruct87)
  %tmp90 = load ptr, ptr %e, align 8
  call void @lunite_release(ptr %tmp90)
  br label %when_end69

when_next91:                                      ; No predecessors!
  br label %when_end69

when_body92:                                      ; preds = %when_next70
  %self93 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self93)
  %sdata94 = call ptr @lunite_alloc(i64 7, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata94, ptr align 1 @slit.175, i64 7, i1 false)
  %sstruct95 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p96 = getelementptr inbounds { ptr, i64 }, ptr %sstruct95, i32 0, i32 0
  %l97 = getelementptr inbounds { ptr, i64 }, ptr %sstruct95, i32 0, i32 1
  store ptr %sdata94, ptr %p96, align 8
  store i64 7, ptr %l97, align 8
  call void @lunite_retain(ptr %sstruct95)
  call void @codegen_c_CodegenC_emit_line(ptr %self93, ptr %sstruct95)
  br label %when_end69

when_next99:                                      ; preds = %when_next61
  %tptr119 = getelementptr inbounds { i64, [8 x i8] }, ptr %s1, i32 0, i32 0
  %tag120 = load i64, ptr %tptr119, align 8
  %match121 = icmp eq i64 %tag120, 3
  br i1 %match121, label %when_body118, label %when_next117

when_body100:                                     ; preds = %when_next61
  %pptr104 = getelementptr inbounds { i64, [8 x i8] }, ptr %s1, i32 0, i32 1
  %pval105 = load ptr, ptr %pptr104, align 8
  call void @lunite_retain(ptr %pval105)
  store ptr %pval105, ptr %e106, align 8
  %self107 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self107)
  %self108 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self108)
  %e109 = load ptr, ptr %e106, align 8
  call void @lunite_retain(ptr %e109)
  %res110 = call ptr @codegen_c_CodegenC_gen_expr(ptr %self108, ptr %e109)
  call void @lunite_retain(ptr %res110)
  %sdata111 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata111, ptr align 1 @slit.176, i64 1, i1 false)
  %sstruct112 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p113 = getelementptr inbounds { ptr, i64 }, ptr %sstruct112, i32 0, i32 0
  %l114 = getelementptr inbounds { ptr, i64 }, ptr %sstruct112, i32 0, i32 1
  store ptr %sdata111, ptr %p113, align 8
  store i64 1, ptr %l114, align 8
  call void @lunite_retain(ptr %sstruct112)
  %res115 = call ptr @string_concat(ptr %res110, ptr %sstruct112)
  call void @lunite_retain(ptr %res115)
  call void @codegen_c_CodegenC_emit_line(ptr %self107, ptr %res115)
  %tmp116 = load ptr, ptr %e106, align 8
  call void @lunite_release(ptr %tmp116)
  br label %when_end

when_next117:                                     ; preds = %when_next99
  %tptr189 = getelementptr inbounds { i64, [8 x i8] }, ptr %s1, i32 0, i32 0
  %tag190 = load i64, ptr %tptr189, align 8
  %match191 = icmp eq i64 %tag190, 4
  br i1 %match191, label %when_body188, label %when_next187

when_body118:                                     ; preds = %when_next99
  %pptr122 = getelementptr inbounds { i64, [8 x i8] }, ptr %s1, i32 0, i32 1
  %pval123 = load ptr, ptr %pptr122, align 8
  call void @lunite_retain(ptr %pval123)
  store ptr %pval123, ptr %payload124, align 8
  %self125 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self125)
  %sdata126 = call ptr @lunite_alloc(i64 4, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata126, ptr align 1 @slit.177, i64 4, i1 false)
  %sstruct127 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p128 = getelementptr inbounds { ptr, i64 }, ptr %sstruct127, i32 0, i32 0
  %l129 = getelementptr inbounds { ptr, i64 }, ptr %sstruct127, i32 0, i32 1
  store ptr %sdata126, ptr %p128, align 8
  store i64 4, ptr %l129, align 8
  call void @lunite_retain(ptr %sstruct127)
  %self130 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self130)
  %payload131 = load ptr, ptr %payload124, align 8
  %fp132 = getelementptr inbounds %ast_IfStatementPayload, ptr %payload131, i32 0, i32 0
  %condition = load ptr, ptr %fp132, align 8
  call void @lunite_retain(ptr %condition)
  %res133 = call ptr @codegen_c_CodegenC_gen_expr(ptr %self130, ptr %condition)
  call void @lunite_retain(ptr %res133)
  %res134 = call ptr @string_concat(ptr %sstruct127, ptr %res133)
  call void @lunite_retain(ptr %res134)
  %sdata135 = call ptr @lunite_alloc(i64 3, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata135, ptr align 1 @slit.178, i64 3, i1 false)
  %sstruct136 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p137 = getelementptr inbounds { ptr, i64 }, ptr %sstruct136, i32 0, i32 0
  %l138 = getelementptr inbounds { ptr, i64 }, ptr %sstruct136, i32 0, i32 1
  store ptr %sdata135, ptr %p137, align 8
  store i64 3, ptr %l138, align 8
  call void @lunite_retain(ptr %sstruct136)
  call void @codegen_c_CodegenC_emit_line(ptr %self125, ptr %res134, ptr %sstruct136)
  %self139 = load ptr, ptr %self, align 8
  %fp140 = getelementptr inbounds %codegen_c_CodegenC, ptr %self139, i32 0, i32 1
  %self141 = load ptr, ptr %self, align 8
  %fp142 = getelementptr inbounds %codegen_c_CodegenC, ptr %self141, i32 0, i32 1
  %indent = load i64, ptr %fp142, align 8
  %2 = add i64 %indent, 1
  store i64 %2, ptr %fp140, align 8
  %self143 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self143)
  %payload144 = load ptr, ptr %payload124, align 8
  %fp145 = getelementptr inbounds %ast_IfStatementPayload, ptr %payload144, i32 0, i32 1
  %then_branch = load ptr, ptr %fp145, align 8
  call void @lunite_retain(ptr %then_branch)
  call void @codegen_c_CodegenC_gen_block(ptr %self143, ptr %then_branch)
  %self146 = load ptr, ptr %self, align 8
  %fp147 = getelementptr inbounds %codegen_c_CodegenC, ptr %self146, i32 0, i32 1
  %self148 = load ptr, ptr %self, align 8
  %fp149 = getelementptr inbounds %codegen_c_CodegenC, ptr %self148, i32 0, i32 1
  %indent150 = load i64, ptr %fp149, align 8
  %3 = sub i64 %indent150, 1
  store i64 %3, ptr %fp147, align 8
  %payload151 = load ptr, ptr %payload124, align 8
  %fp152 = getelementptr inbounds %ast_IfStatementPayload, ptr %payload151, i32 0, i32 2
  %else_branch = load ptr, ptr %fp152, align 8
  %tptr156 = getelementptr inbounds { i64, [8 x i8] }, ptr %else_branch, i32 0, i32 0
  %tag157 = load i64, ptr %tptr156, align 8
  %match158 = icmp eq i64 %tag157, 0
  br i1 %match158, label %when_body155, label %when_next154

when_end153:                                      ; preds = %when_next179, %when_body180, %when_body155
  %self181 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self181)
  %sdata182 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata182, ptr align 1 @slit.180, i64 1, i1 false)
  %sstruct183 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p184 = getelementptr inbounds { ptr, i64 }, ptr %sstruct183, i32 0, i32 0
  %l185 = getelementptr inbounds { ptr, i64 }, ptr %sstruct183, i32 0, i32 1
  store ptr %sdata182, ptr %p184, align 8
  store i64 1, ptr %l185, align 8
  call void @lunite_retain(ptr %sstruct183)
  call void @codegen_c_CodegenC_emit_line(ptr %self181, ptr %sstruct183)
  %tmp186 = load ptr, ptr %payload124, align 8
  call void @lunite_release(ptr %tmp186)
  br label %when_end

when_next154:                                     ; preds = %when_body118
  br label %when_body180

when_body155:                                     ; preds = %when_body118
  %pptr159 = getelementptr inbounds { i64, [8 x i8] }, ptr %else_branch, i32 0, i32 1
  %pval160 = load ptr, ptr %pptr159, align 8
  call void @lunite_retain(ptr %pval160)
  store ptr %pval160, ptr %b, align 8
  %self161 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self161)
  %sdata162 = call ptr @lunite_alloc(i64 8, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata162, ptr align 1 @slit.179, i64 8, i1 false)
  %sstruct163 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p164 = getelementptr inbounds { ptr, i64 }, ptr %sstruct163, i32 0, i32 0
  %l165 = getelementptr inbounds { ptr, i64 }, ptr %sstruct163, i32 0, i32 1
  store ptr %sdata162, ptr %p164, align 8
  store i64 8, ptr %l165, align 8
  call void @lunite_retain(ptr %sstruct163)
  call void @codegen_c_CodegenC_emit_line(ptr %self161, ptr %sstruct163)
  %self166 = load ptr, ptr %self, align 8
  %fp167 = getelementptr inbounds %codegen_c_CodegenC, ptr %self166, i32 0, i32 1
  %self168 = load ptr, ptr %self, align 8
  %fp169 = getelementptr inbounds %codegen_c_CodegenC, ptr %self168, i32 0, i32 1
  %indent170 = load i64, ptr %fp169, align 8
  %4 = add i64 %indent170, 1
  store i64 %4, ptr %fp167, align 8
  %self171 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self171)
  %b172 = load ptr, ptr %b, align 8
  call void @lunite_retain(ptr %b172)
  call void @codegen_c_CodegenC_gen_block(ptr %self171, ptr %b172)
  %self173 = load ptr, ptr %self, align 8
  %fp174 = getelementptr inbounds %codegen_c_CodegenC, ptr %self173, i32 0, i32 1
  %self175 = load ptr, ptr %self, align 8
  %fp176 = getelementptr inbounds %codegen_c_CodegenC, ptr %self175, i32 0, i32 1
  %indent177 = load i64, ptr %fp176, align 8
  %5 = sub i64 %indent177, 1
  store i64 %5, ptr %fp174, align 8
  %tmp178 = load ptr, ptr %b, align 8
  call void @lunite_release(ptr %tmp178)
  br label %when_end153

when_next179:                                     ; No predecessors!
  br label %when_end153

when_body180:                                     ; preds = %when_next154
  br label %when_end153

when_next187:                                     ; preds = %when_next117
  %tptr232 = getelementptr inbounds { i64, [8 x i8] }, ptr %s1, i32 0, i32 0
  %tag233 = load i64, ptr %tptr232, align 8
  %match234 = icmp eq i64 %tag233, 8
  br i1 %match234, label %when_body231, label %when_next230

when_body188:                                     ; preds = %when_next117
  %pptr192 = getelementptr inbounds { i64, [8 x i8] }, ptr %s1, i32 0, i32 1
  %pval193 = load ptr, ptr %pptr192, align 8
  call void @lunite_retain(ptr %pval193)
  store ptr %pval193, ptr %payload194, align 8
  %self195 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self195)
  %sdata196 = call ptr @lunite_alloc(i64 7, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata196, ptr align 1 @slit.181, i64 7, i1 false)
  %sstruct197 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p198 = getelementptr inbounds { ptr, i64 }, ptr %sstruct197, i32 0, i32 0
  %l199 = getelementptr inbounds { ptr, i64 }, ptr %sstruct197, i32 0, i32 1
  store ptr %sdata196, ptr %p198, align 8
  store i64 7, ptr %l199, align 8
  call void @lunite_retain(ptr %sstruct197)
  %self200 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self200)
  %payload201 = load ptr, ptr %payload194, align 8
  %fp202 = getelementptr inbounds %ast_WhileStatementPayload, ptr %payload201, i32 0, i32 0
  %condition203 = load ptr, ptr %fp202, align 8
  call void @lunite_retain(ptr %condition203)
  %res204 = call ptr @codegen_c_CodegenC_gen_expr(ptr %self200, ptr %condition203)
  call void @lunite_retain(ptr %res204)
  %res205 = call ptr @string_concat(ptr %sstruct197, ptr %res204)
  call void @lunite_retain(ptr %res205)
  %sdata206 = call ptr @lunite_alloc(i64 3, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata206, ptr align 1 @slit.182, i64 3, i1 false)
  %sstruct207 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p208 = getelementptr inbounds { ptr, i64 }, ptr %sstruct207, i32 0, i32 0
  %l209 = getelementptr inbounds { ptr, i64 }, ptr %sstruct207, i32 0, i32 1
  store ptr %sdata206, ptr %p208, align 8
  store i64 3, ptr %l209, align 8
  call void @lunite_retain(ptr %sstruct207)
  call void @codegen_c_CodegenC_emit_line(ptr %self195, ptr %res205, ptr %sstruct207)
  %self210 = load ptr, ptr %self, align 8
  %fp211 = getelementptr inbounds %codegen_c_CodegenC, ptr %self210, i32 0, i32 1
  %self212 = load ptr, ptr %self, align 8
  %fp213 = getelementptr inbounds %codegen_c_CodegenC, ptr %self212, i32 0, i32 1
  %indent214 = load i64, ptr %fp213, align 8
  %6 = add i64 %indent214, 1
  store i64 %6, ptr %fp211, align 8
  %self215 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self215)
  %payload216 = load ptr, ptr %payload194, align 8
  %fp217 = getelementptr inbounds %ast_WhileStatementPayload, ptr %payload216, i32 0, i32 1
  %body218 = load ptr, ptr %fp217, align 8
  call void @lunite_retain(ptr %body218)
  call void @codegen_c_CodegenC_gen_block(ptr %self215, ptr %body218)
  %self219 = load ptr, ptr %self, align 8
  %fp220 = getelementptr inbounds %codegen_c_CodegenC, ptr %self219, i32 0, i32 1
  %self221 = load ptr, ptr %self, align 8
  %fp222 = getelementptr inbounds %codegen_c_CodegenC, ptr %self221, i32 0, i32 1
  %indent223 = load i64, ptr %fp222, align 8
  %7 = sub i64 %indent223, 1
  store i64 %7, ptr %fp220, align 8
  %self224 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self224)
  %sdata225 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata225, ptr align 1 @slit.183, i64 1, i1 false)
  %sstruct226 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p227 = getelementptr inbounds { ptr, i64 }, ptr %sstruct226, i32 0, i32 0
  %l228 = getelementptr inbounds { ptr, i64 }, ptr %sstruct226, i32 0, i32 1
  store ptr %sdata225, ptr %p227, align 8
  store i64 1, ptr %l228, align 8
  call void @lunite_retain(ptr %sstruct226)
  call void @codegen_c_CodegenC_emit_line(ptr %self224, ptr %sstruct226)
  %tmp229 = load ptr, ptr %payload194, align 8
  call void @lunite_release(ptr %tmp229)
  br label %when_end

when_next230:                                     ; preds = %when_next187
  br label %when_body427

when_body231:                                     ; preds = %when_next187
  %pptr235 = getelementptr inbounds { i64, [8 x i8] }, ptr %s1, i32 0, i32 1
  %pval236 = load ptr, ptr %pptr235, align 8
  call void @lunite_retain(ptr %pval236)
  store ptr %pval236, ptr %payload237, align 8
  %self238 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self238)
  %res239 = call ptr @codegen_c_CodegenC_next_temp(ptr %self238)
  call void @lunite_retain(ptr %res239)
  store ptr %res239, ptr %subject_var, align 8
  %self240 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self240)
  %sdata241 = call ptr @lunite_alloc(i64 6, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata241, ptr align 1 @slit.184, i64 6, i1 false)
  %sstruct242 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p243 = getelementptr inbounds { ptr, i64 }, ptr %sstruct242, i32 0, i32 0
  %l244 = getelementptr inbounds { ptr, i64 }, ptr %sstruct242, i32 0, i32 1
  store ptr %sdata241, ptr %p243, align 8
  store i64 6, ptr %l244, align 8
  call void @lunite_retain(ptr %sstruct242)
  %subject_var245 = load ptr, ptr %subject_var, align 8
  call void @lunite_retain(ptr %subject_var245)
  %res246 = call ptr @string_concat(ptr %sstruct242, ptr %subject_var245)
  call void @lunite_retain(ptr %res246)
  %sdata247 = call ptr @lunite_alloc(i64 3, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata247, ptr align 1 @slit.185, i64 3, i1 false)
  %sstruct248 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p249 = getelementptr inbounds { ptr, i64 }, ptr %sstruct248, i32 0, i32 0
  %l250 = getelementptr inbounds { ptr, i64 }, ptr %sstruct248, i32 0, i32 1
  store ptr %sdata247, ptr %p249, align 8
  store i64 3, ptr %l250, align 8
  call void @lunite_retain(ptr %sstruct248)
  %res251 = call ptr @string_concat(ptr %res246, ptr %sstruct248)
  call void @lunite_retain(ptr %res251)
  call void @codegen_c_CodegenC_emit_line(ptr %self240, ptr %res251)
  %self252 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self252)
  %self253 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self253)
  %payload254 = load ptr, ptr %payload237, align 8
  %fp255 = getelementptr inbounds %ast_WhenStatementPayload, ptr %payload254, i32 0, i32 0
  %subject = load ptr, ptr %fp255, align 8
  call void @lunite_retain(ptr %subject)
  %res256 = call ptr @codegen_c_CodegenC_gen_expr(ptr %self253, ptr %subject)
  call void @lunite_retain(ptr %res256)
  call void @codegen_c_CodegenC_emit(ptr %self252, ptr %res256)
  %self257 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self257)
  %sdata258 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata258, ptr align 1 @slit.186, i64 1, i1 false)
  %sstruct259 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p260 = getelementptr inbounds { ptr, i64 }, ptr %sstruct259, i32 0, i32 0
  %l261 = getelementptr inbounds { ptr, i64 }, ptr %sstruct259, i32 0, i32 1
  store ptr %sdata258, ptr %p260, align 8
  store i64 1, ptr %l261, align 8
  call void @lunite_retain(ptr %sstruct259)
  call void @codegen_c_CodegenC_emit(ptr %self257, ptr %sstruct259)
  store i1 true, ptr %first, align 1
  store i64 0, ptr %i, align 8
  br label %while_cond

while_cond:                                       ; preds = %when_end279, %when_body231
  %i262 = load i64, ptr %i, align 8
  %payload263 = load ptr, ptr %payload237, align 8
  %fp264 = getelementptr inbounds %ast_WhenStatementPayload, ptr %payload263, i32 0, i32 1
  %arms = load ptr, ptr %fp264, align 8
  %fp265 = getelementptr inbounds %list_List, ptr %arms, i32 0, i32 1
  %count = load i64, ptr %fp265, align 8
  %8 = icmp slt i64 %i262, %count
  br i1 %8, label %while_body, label %while_end

while_body:                                       ; preds = %while_cond
  %payload266 = load ptr, ptr %payload237, align 8
  %fp267 = getelementptr inbounds %ast_WhenStatementPayload, ptr %payload266, i32 0, i32 1
  %arms268 = load ptr, ptr %fp267, align 8
  %fp269 = getelementptr inbounds %list_List, ptr %arms268, i32 0, i32 0
  %data = load ptr, ptr %fp269, align 8
  %i270 = load i64, ptr %i, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %i270
  %val = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val)
  store ptr %val, ptr %arm, align 8
  %first271 = load i1, ptr %first, align 1
  %not = xor i1 %first271, true
  br i1 %not, label %then, label %else

while_end:                                        ; preds = %while_cond
  %tmp424 = load ptr, ptr %subject_var, align 8
  call void @lunite_release(ptr %tmp424)
  %tmp425 = load ptr, ptr %payload237, align 8
  call void @lunite_release(ptr %tmp425)
  br label %when_end

then:                                             ; preds = %while_body
  %self272 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self272)
  %sdata273 = call ptr @lunite_alloc(i64 6, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata273, ptr align 1 @slit.187, i64 6, i1 false)
  %sstruct274 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p275 = getelementptr inbounds { ptr, i64 }, ptr %sstruct274, i32 0, i32 0
  %l276 = getelementptr inbounds { ptr, i64 }, ptr %sstruct274, i32 0, i32 1
  store ptr %sdata273, ptr %p275, align 8
  store i64 6, ptr %l276, align 8
  call void @lunite_retain(ptr %sstruct274)
  call void @codegen_c_CodegenC_emit(ptr %self272, ptr %sstruct274)
  br label %cont

else:                                             ; preds = %while_body
  br label %cont

cont:                                             ; preds = %else, %then
  store i1 false, ptr %first, align 1
  %arm277 = load ptr, ptr %arm, align 8
  %fp278 = getelementptr inbounds %ast_WhenArm, ptr %arm277, i32 0, i32 0
  %pattern = load ptr, ptr %fp278, align 8
  %tptr282 = getelementptr inbounds { i64, [8 x i8] }, ptr %pattern, i32 0, i32 0
  %tag283 = load i64, ptr %tptr282, align 8
  %match284 = icmp eq i64 %tag283, 2
  br i1 %match284, label %when_body281, label %when_next280

when_end279:                                      ; preds = %when_next396, %when_body397, %when_body387, %when_end339
  %self403 = load ptr, ptr %self, align 8
  %fp404 = getelementptr inbounds %codegen_c_CodegenC, ptr %self403, i32 0, i32 1
  %self405 = load ptr, ptr %self, align 8
  %fp406 = getelementptr inbounds %codegen_c_CodegenC, ptr %self405, i32 0, i32 1
  %indent407 = load i64, ptr %fp406, align 8
  %9 = add i64 %indent407, 1
  store i64 %9, ptr %fp404, align 8
  %self408 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self408)
  %arm409 = load ptr, ptr %arm, align 8
  %fp410 = getelementptr inbounds %ast_WhenArm, ptr %arm409, i32 0, i32 1
  %body411 = load ptr, ptr %fp410, align 8
  call void @lunite_retain(ptr %body411)
  call void @codegen_c_CodegenC_gen_block(ptr %self408, ptr %body411)
  %self412 = load ptr, ptr %self, align 8
  %fp413 = getelementptr inbounds %codegen_c_CodegenC, ptr %self412, i32 0, i32 1
  %self414 = load ptr, ptr %self, align 8
  %fp415 = getelementptr inbounds %codegen_c_CodegenC, ptr %self414, i32 0, i32 1
  %indent416 = load i64, ptr %fp415, align 8
  %10 = sub i64 %indent416, 1
  store i64 %10, ptr %fp413, align 8
  %self417 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self417)
  %sdata418 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata418, ptr align 1 @slit.200, i64 1, i1 false)
  %sstruct419 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p420 = getelementptr inbounds { ptr, i64 }, ptr %sstruct419, i32 0, i32 0
  %l421 = getelementptr inbounds { ptr, i64 }, ptr %sstruct419, i32 0, i32 1
  store ptr %sdata418, ptr %p420, align 8
  store i64 1, ptr %l421, align 8
  call void @lunite_retain(ptr %sstruct419)
  call void @codegen_c_CodegenC_emit_line(ptr %self417, ptr %sstruct419)
  %i422 = load i64, ptr %i, align 8
  %11 = add i64 %i422, 1
  store i64 %11, ptr %i, align 8
  %tmp423 = load ptr, ptr %arm, align 8
  call void @lunite_release(ptr %tmp423)
  br label %while_cond

when_next280:                                     ; preds = %cont
  %tptr388 = getelementptr inbounds { i64, [8 x i8] }, ptr %pattern, i32 0, i32 0
  %tag389 = load i64, ptr %tptr388, align 8
  %match390 = icmp eq i64 %tag389, 3
  br i1 %match390, label %when_body387, label %when_next386

when_body281:                                     ; preds = %cont
  %pptr285 = getelementptr inbounds { i64, [8 x i8] }, ptr %pattern, i32 0, i32 1
  %pval286 = load ptr, ptr %pptr285, align 8
  call void @lunite_retain(ptr %pval286)
  store ptr %pval286, ptr %ev, align 8
  %ev287 = load ptr, ptr %ev, align 8
  %fp288 = getelementptr inbounds %ast_EnumVariantPatternPayload, ptr %ev287, i32 0, i32 0
  %enum_name = load ptr, ptr %fp288, align 8
  call void @lunite_retain(ptr %enum_name)
  %sdata289 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata289, ptr align 1 @slit.188, i64 1, i1 false)
  %sstruct290 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p291 = getelementptr inbounds { ptr, i64 }, ptr %sstruct290, i32 0, i32 0
  %l292 = getelementptr inbounds { ptr, i64 }, ptr %sstruct290, i32 0, i32 1
  store ptr %sdata289, ptr %p291, align 8
  store i64 1, ptr %l292, align 8
  call void @lunite_retain(ptr %sstruct290)
  %res293 = call ptr @string_concat(ptr %enum_name, ptr %sstruct290)
  call void @lunite_retain(ptr %res293)
  %ev294 = load ptr, ptr %ev, align 8
  %fp295 = getelementptr inbounds %ast_EnumVariantPatternPayload, ptr %ev294, i32 0, i32 1
  %variant_name = load ptr, ptr %fp295, align 8
  call void @lunite_retain(ptr %variant_name)
  %res296 = call ptr @string_concat(ptr %res293, ptr %variant_name)
  call void @lunite_retain(ptr %res296)
  store ptr %res296, ptr %tag_const, align 8
  %sdata297 = call ptr @lunite_alloc(i64 8, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata297, ptr align 1 @slit.189, i64 8, i1 false)
  %sstruct298 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p299 = getelementptr inbounds { ptr, i64 }, ptr %sstruct298, i32 0, i32 0
  %l300 = getelementptr inbounds { ptr, i64 }, ptr %sstruct298, i32 0, i32 1
  store ptr %sdata297, ptr %p299, align 8
  store i64 8, ptr %l300, align 8
  call void @lunite_retain(ptr %sstruct298)
  %ev301 = load ptr, ptr %ev, align 8
  %fp302 = getelementptr inbounds %ast_EnumVariantPatternPayload, ptr %ev301, i32 0, i32 0
  %enum_name303 = load ptr, ptr %fp302, align 8
  call void @lunite_retain(ptr %enum_name303)
  %res304 = call ptr @string_concat(ptr %sstruct298, ptr %enum_name303)
  call void @lunite_retain(ptr %res304)
  %sdata305 = call ptr @lunite_alloc(i64 2, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata305, ptr align 1 @slit.190, i64 2, i1 false)
  %sstruct306 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p307 = getelementptr inbounds { ptr, i64 }, ptr %sstruct306, i32 0, i32 0
  %l308 = getelementptr inbounds { ptr, i64 }, ptr %sstruct306, i32 0, i32 1
  store ptr %sdata305, ptr %p307, align 8
  store i64 2, ptr %l308, align 8
  call void @lunite_retain(ptr %sstruct306)
  %res309 = call ptr @string_concat(ptr %res304, ptr %sstruct306)
  call void @lunite_retain(ptr %res309)
  store ptr %res309, ptr %cast, align 8
  %cast310 = load ptr, ptr %cast, align 8
  call void @lunite_retain(ptr %cast310)
  %subject_var311 = load ptr, ptr %subject_var, align 8
  call void @lunite_retain(ptr %subject_var311)
  %res312 = call ptr @string_concat(ptr %cast310, ptr %subject_var311)
  call void @lunite_retain(ptr %res312)
  %sdata313 = call ptr @lunite_alloc(i64 4, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata313, ptr align 1 @slit.191, i64 4, i1 false)
  %sstruct314 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p315 = getelementptr inbounds { ptr, i64 }, ptr %sstruct314, i32 0, i32 0
  %l316 = getelementptr inbounds { ptr, i64 }, ptr %sstruct314, i32 0, i32 1
  store ptr %sdata313, ptr %p315, align 8
  store i64 4, ptr %l316, align 8
  call void @lunite_retain(ptr %sstruct314)
  %res317 = call ptr @string_concat(ptr %res312, ptr %sstruct314)
  call void @lunite_retain(ptr %res317)
  store ptr %res317, ptr %access, align 8
  %self318 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self318)
  %sdata319 = call ptr @lunite_alloc(i64 4, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata319, ptr align 1 @slit.192, i64 4, i1 false)
  %sstruct320 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p321 = getelementptr inbounds { ptr, i64 }, ptr %sstruct320, i32 0, i32 0
  %l322 = getelementptr inbounds { ptr, i64 }, ptr %sstruct320, i32 0, i32 1
  store ptr %sdata319, ptr %p321, align 8
  store i64 4, ptr %l322, align 8
  call void @lunite_retain(ptr %sstruct320)
  %access323 = load ptr, ptr %access, align 8
  call void @lunite_retain(ptr %access323)
  %res324 = call ptr @string_concat(ptr %sstruct320, ptr %access323)
  call void @lunite_retain(ptr %res324)
  %sdata325 = call ptr @lunite_alloc(i64 4, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata325, ptr align 1 @slit.193, i64 4, i1 false)
  %sstruct326 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p327 = getelementptr inbounds { ptr, i64 }, ptr %sstruct326, i32 0, i32 0
  %l328 = getelementptr inbounds { ptr, i64 }, ptr %sstruct326, i32 0, i32 1
  store ptr %sdata325, ptr %p327, align 8
  store i64 4, ptr %l328, align 8
  call void @lunite_retain(ptr %sstruct326)
  %res329 = call ptr @string_concat(ptr %res324, ptr %sstruct326)
  call void @lunite_retain(ptr %res329)
  call void @codegen_c_CodegenC_emit(ptr %self318, ptr %res329)
  %self330 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self330)
  %tag_const331 = load ptr, ptr %tag_const, align 8
  call void @lunite_retain(ptr %tag_const331)
  call void @codegen_c_CodegenC_emit(ptr %self330, ptr %tag_const331)
  %self332 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self332)
  %sdata333 = call ptr @lunite_alloc(i64 3, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata333, ptr align 1 @slit.194, i64 3, i1 false)
  %sstruct334 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p335 = getelementptr inbounds { ptr, i64 }, ptr %sstruct334, i32 0, i32 0
  %l336 = getelementptr inbounds { ptr, i64 }, ptr %sstruct334, i32 0, i32 1
  store ptr %sdata333, ptr %p335, align 8
  store i64 3, ptr %l336, align 8
  call void @lunite_retain(ptr %sstruct334)
  call void @codegen_c_CodegenC_emit(ptr %self332, ptr %sstruct334)
  %ev337 = load ptr, ptr %ev, align 8
  %fp338 = getelementptr inbounds %ast_EnumVariantPatternPayload, ptr %ev337, i32 0, i32 2
  %binding = load ptr, ptr %fp338, align 8
  %tptr342 = getelementptr inbounds { i64, [8 x i8] }, ptr %binding, i32 0, i32 0
  %tag343 = load i64, ptr %tptr342, align 8
  %match344 = icmp eq i64 %tag343, 0
  br i1 %match344, label %when_body341, label %when_next340

when_end339:                                      ; preds = %when_next380, %when_body381, %when_body341
  %tmp382 = load ptr, ptr %access, align 8
  call void @lunite_release(ptr %tmp382)
  %tmp383 = load ptr, ptr %cast, align 8
  call void @lunite_release(ptr %tmp383)
  %tmp384 = load ptr, ptr %tag_const, align 8
  call void @lunite_release(ptr %tmp384)
  %tmp385 = load ptr, ptr %ev, align 8
  call void @lunite_release(ptr %tmp385)
  br label %when_end279

when_next340:                                     ; preds = %when_body281
  br label %when_body381

when_body341:                                     ; preds = %when_body281
  %pptr345 = getelementptr inbounds { i64, [8 x i8] }, ptr %binding, i32 0, i32 1
  %pval346 = load ptr, ptr %pptr345, align 8
  call void @lunite_retain(ptr %pval346)
  store ptr %pval346, ptr %bname, align 8
  %self347 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self347)
  call void @codegen_c_CodegenC_emit_newline(ptr %self347)
  %self348 = load ptr, ptr %self, align 8
  %fp349 = getelementptr inbounds %codegen_c_CodegenC, ptr %self348, i32 0, i32 1
  %self350 = load ptr, ptr %self, align 8
  %fp351 = getelementptr inbounds %codegen_c_CodegenC, ptr %self350, i32 0, i32 1
  %indent352 = load i64, ptr %fp351, align 8
  %12 = add i64 %indent352, 1
  store i64 %12, ptr %fp349, align 8
  %self353 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self353)
  %sdata354 = call ptr @lunite_alloc(i64 6, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata354, ptr align 1 @slit.195, i64 6, i1 false)
  %sstruct355 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p356 = getelementptr inbounds { ptr, i64 }, ptr %sstruct355, i32 0, i32 0
  %l357 = getelementptr inbounds { ptr, i64 }, ptr %sstruct355, i32 0, i32 1
  store ptr %sdata354, ptr %p356, align 8
  store i64 6, ptr %l357, align 8
  call void @lunite_retain(ptr %sstruct355)
  %bname358 = load ptr, ptr %bname, align 8
  call void @lunite_retain(ptr %bname358)
  %res359 = call ptr @string_concat(ptr %sstruct355, ptr %bname358)
  call void @lunite_retain(ptr %res359)
  %sdata360 = call ptr @lunite_alloc(i64 12, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata360, ptr align 1 @slit.196, i64 12, i1 false)
  %sstruct361 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p362 = getelementptr inbounds { ptr, i64 }, ptr %sstruct361, i32 0, i32 0
  %l363 = getelementptr inbounds { ptr, i64 }, ptr %sstruct361, i32 0, i32 1
  store ptr %sdata360, ptr %p362, align 8
  store i64 12, ptr %l363, align 8
  call void @lunite_retain(ptr %sstruct361)
  %ev364 = load ptr, ptr %ev, align 8
  %fp365 = getelementptr inbounds %ast_EnumVariantPatternPayload, ptr %ev364, i32 0, i32 0
  %enum_name366 = load ptr, ptr %fp365, align 8
  call void @lunite_retain(ptr %enum_name366)
  %res367 = call ptr @string_concat(ptr %sstruct361, ptr %enum_name366)
  call void @lunite_retain(ptr %res367)
  %res368 = call ptr @string_concat(ptr %res359, ptr %res367)
  call void @lunite_retain(ptr %res368)
  %sdata369 = call ptr @lunite_alloc(i64 21, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata369, ptr align 1 @slit.197, i64 21, i1 false)
  %sstruct370 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p371 = getelementptr inbounds { ptr, i64 }, ptr %sstruct370, i32 0, i32 0
  %l372 = getelementptr inbounds { ptr, i64 }, ptr %sstruct370, i32 0, i32 1
  store ptr %sdata369, ptr %p371, align 8
  store i64 21, ptr %l372, align 8
  call void @lunite_retain(ptr %sstruct370)
  %res373 = call ptr @string_concat(ptr %res368, ptr %sstruct370)
  call void @lunite_retain(ptr %res373)
  call void @codegen_c_CodegenC_emit_line(ptr %self353, ptr %res373)
  %self374 = load ptr, ptr %self, align 8
  %fp375 = getelementptr inbounds %codegen_c_CodegenC, ptr %self374, i32 0, i32 1
  %self376 = load ptr, ptr %self, align 8
  %fp377 = getelementptr inbounds %codegen_c_CodegenC, ptr %self376, i32 0, i32 1
  %indent378 = load i64, ptr %fp377, align 8
  %13 = sub i64 %indent378, 1
  store i64 %13, ptr %fp375, align 8
  %tmp379 = load ptr, ptr %bname, align 8
  call void @lunite_release(ptr %tmp379)
  br label %when_end339

when_next380:                                     ; No predecessors!
  br label %when_end339

when_body381:                                     ; preds = %when_next340
  br label %when_end339

when_next386:                                     ; preds = %when_next280
  br label %when_body397

when_body387:                                     ; preds = %when_next280
  %self391 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self391)
  %sdata392 = call ptr @lunite_alloc(i64 8, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata392, ptr align 1 @slit.198, i64 8, i1 false)
  %sstruct393 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p394 = getelementptr inbounds { ptr, i64 }, ptr %sstruct393, i32 0, i32 0
  %l395 = getelementptr inbounds { ptr, i64 }, ptr %sstruct393, i32 0, i32 1
  store ptr %sdata392, ptr %p394, align 8
  store i64 8, ptr %l395, align 8
  call void @lunite_retain(ptr %sstruct393)
  call void @codegen_c_CodegenC_emit(ptr %self391, ptr %sstruct393)
  br label %when_end279

when_next396:                                     ; No predecessors!
  br label %when_end279

when_body397:                                     ; preds = %when_next386
  %self398 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self398)
  %sdata399 = call ptr @lunite_alloc(i64 24, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata399, ptr align 1 @slit.199, i64 24, i1 false)
  %sstruct400 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p401 = getelementptr inbounds { ptr, i64 }, ptr %sstruct400, i32 0, i32 0
  %l402 = getelementptr inbounds { ptr, i64 }, ptr %sstruct400, i32 0, i32 1
  store ptr %sdata399, ptr %p401, align 8
  store i64 24, ptr %l402, align 8
  call void @lunite_retain(ptr %sstruct400)
  call void @codegen_c_CodegenC_emit(ptr %self398, ptr %sstruct400)
  br label %when_end279

when_next426:                                     ; No predecessors!
  br label %when_end

when_body427:                                     ; preds = %when_next230
  br label %when_end
}

define void @codegen_c_CodegenC_gen_block(ptr %0, ptr %1) {
entry:
  %i = alloca i64, align 8
  %b = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %b, align 8
  store i64 0, ptr %i, align 8
  br label %while_cond

while_cond:                                       ; preds = %while_body, %body
  %i1 = load i64, ptr %i, align 8
  %b2 = load ptr, ptr %b, align 8
  %fp = getelementptr inbounds %ast_Block, ptr %b2, i32 0, i32 0
  %statements = load ptr, ptr %fp, align 8
  %fp3 = getelementptr inbounds %list_List, ptr %statements, i32 0, i32 1
  %count = load i64, ptr %fp3, align 8
  %2 = icmp slt i64 %i1, %count
  br i1 %2, label %while_body, label %while_end

while_body:                                       ; preds = %while_cond
  %self4 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self4)
  %b5 = load ptr, ptr %b, align 8
  %fp6 = getelementptr inbounds %ast_Block, ptr %b5, i32 0, i32 0
  %statements7 = load ptr, ptr %fp6, align 8
  %fp8 = getelementptr inbounds %list_List, ptr %statements7, i32 0, i32 0
  %data = load ptr, ptr %fp8, align 8
  %i9 = load i64, ptr %i, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %i9
  %val = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val)
  call void @codegen_c_CodegenC_gen_stmt(ptr %self4, ptr %val)
  %i10 = load i64, ptr %i, align 8
  %3 = add i64 %i10, 1
  store i64 %3, ptr %i, align 8
  br label %while_cond

while_end:                                        ; preds = %while_cond
  %tmp = load ptr, ptr %b, align 8
  call void @lunite_release(ptr %tmp)
  %tmp11 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp11)
  ret void
}

define ptr @codegen_c_CodegenC_generate(ptr %0, ptr %1) {
entry:
  %j128 = alloca i64, align 8
  %imp127 = alloca ptr, align 8
  %f112 = alloca ptr, align 8
  %j = alloca i64, align 8
  %imp = alloca ptr, align 8
  %f = alloca ptr, align 8
  %e = alloca ptr, align 8
  %s = alloca ptr, align 8
  %i = alloca i64, align 8
  %p = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %p, align 8
  %self1 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self1)
  %p2 = load ptr, ptr %p, align 8
  call void @lunite_retain(ptr %p2)
  call void @codegen_c_CodegenC_scan_program(ptr %self1, ptr %p2)
  %self3 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self3)
  call void @codegen_c_CodegenC_gen_header(ptr %self3)
  store i64 0, ptr %i, align 8
  br label %while_cond

while_cond:                                       ; preds = %when_end, %body
  %i4 = load i64, ptr %i, align 8
  %p5 = load ptr, ptr %p, align 8
  %fp = getelementptr inbounds %ast_Program, ptr %p5, i32 0, i32 0
  %items = load ptr, ptr %fp, align 8
  %fp6 = getelementptr inbounds %list_List, ptr %items, i32 0, i32 1
  %count = load i64, ptr %fp6, align 8
  %2 = icmp slt i64 %i4, %count
  br i1 %2, label %while_body, label %while_end

while_body:                                       ; preds = %while_cond
  %p7 = load ptr, ptr %p, align 8
  %fp8 = getelementptr inbounds %ast_Program, ptr %p7, i32 0, i32 0
  %items9 = load ptr, ptr %fp8, align 8
  %fp10 = getelementptr inbounds %list_List, ptr %items9, i32 0, i32 0
  %data = load ptr, ptr %fp10, align 8
  %i11 = load i64, ptr %i, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %i11
  %val = load ptr, ptr %ptr, align 8
  %tptr = getelementptr inbounds { i64, [8 x i8] }, ptr %val, i32 0, i32 0
  %tag = load i64, ptr %tptr, align 8
  %match = icmp eq i64 %tag, 4
  br i1 %match, label %when_body, label %when_next

while_end:                                        ; preds = %while_cond
  store i64 0, ptr %i, align 8
  br label %while_cond27

when_end:                                         ; preds = %when_next24, %when_body25, %when_body15, %when_body
  %i26 = load i64, ptr %i, align 8
  %3 = add i64 %i26, 1
  store i64 %3, ptr %i, align 8
  br label %while_cond

when_next:                                        ; preds = %while_body
  %tptr16 = getelementptr inbounds { i64, [8 x i8] }, ptr %val, i32 0, i32 0
  %tag17 = load i64, ptr %tptr16, align 8
  %match18 = icmp eq i64 %tag17, 5
  br i1 %match18, label %when_body15, label %when_next14

when_body:                                        ; preds = %while_body
  %pptr = getelementptr inbounds { i64, [8 x i8] }, ptr %val, i32 0, i32 1
  %pval = load ptr, ptr %pptr, align 8
  call void @lunite_retain(ptr %pval)
  store ptr %pval, ptr %s, align 8
  %self12 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self12)
  %s13 = load ptr, ptr %s, align 8
  call void @lunite_retain(ptr %s13)
  call void @codegen_c_CodegenC_gen_struct_decl(ptr %self12, ptr %s13)
  %tmp = load ptr, ptr %s, align 8
  call void @lunite_release(ptr %tmp)
  br label %when_end

when_next14:                                      ; preds = %when_next
  br label %when_body25

when_body15:                                      ; preds = %when_next
  %pptr19 = getelementptr inbounds { i64, [8 x i8] }, ptr %val, i32 0, i32 1
  %pval20 = load ptr, ptr %pptr19, align 8
  call void @lunite_retain(ptr %pval20)
  store ptr %pval20, ptr %e, align 8
  %self21 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self21)
  %e22 = load ptr, ptr %e, align 8
  call void @lunite_retain(ptr %e22)
  call void @codegen_c_CodegenC_gen_enum_decl(ptr %self21, ptr %e22)
  %tmp23 = load ptr, ptr %e, align 8
  call void @lunite_release(ptr %tmp23)
  br label %when_end

when_next24:                                      ; No predecessors!
  br label %when_end

when_body25:                                      ; preds = %when_next14
  br label %when_end

while_cond27:                                     ; preds = %when_end44, %while_end
  %i30 = load i64, ptr %i, align 8
  %p31 = load ptr, ptr %p, align 8
  %fp32 = getelementptr inbounds %ast_Program, ptr %p31, i32 0, i32 0
  %items33 = load ptr, ptr %fp32, align 8
  %fp34 = getelementptr inbounds %list_List, ptr %items33, i32 0, i32 1
  %count35 = load i64, ptr %fp34, align 8
  %4 = icmp slt i64 %i30, %count35
  br i1 %4, label %while_body28, label %while_end29

while_body28:                                     ; preds = %while_cond27
  %p36 = load ptr, ptr %p, align 8
  %fp37 = getelementptr inbounds %ast_Program, ptr %p36, i32 0, i32 0
  %items38 = load ptr, ptr %fp37, align 8
  %fp39 = getelementptr inbounds %list_List, ptr %items38, i32 0, i32 0
  %data40 = load ptr, ptr %fp39, align 8
  %i41 = load i64, ptr %i, align 8
  %ptr42 = getelementptr ptr, ptr %data40, i64 %i41
  %val43 = load ptr, ptr %ptr42, align 8
  %tptr47 = getelementptr inbounds { i64, [8 x i8] }, ptr %val43, i32 0, i32 0
  %tag48 = load i64, ptr %tptr47, align 8
  %match49 = icmp eq i64 %tag48, 1
  br i1 %match49, label %when_body46, label %when_next45

while_end29:                                      ; preds = %while_cond27
  store i64 0, ptr %i, align 8
  br label %while_cond87

when_end44:                                       ; preds = %when_next84, %when_body85, %while_end65, %when_body46
  %i86 = load i64, ptr %i, align 8
  %5 = add i64 %i86, 1
  store i64 %5, ptr %i, align 8
  br label %while_cond27

when_next45:                                      ; preds = %while_body28
  %tptr58 = getelementptr inbounds { i64, [8 x i8] }, ptr %val43, i32 0, i32 0
  %tag59 = load i64, ptr %tptr58, align 8
  %match60 = icmp eq i64 %tag59, 6
  br i1 %match60, label %when_body57, label %when_next56

when_body46:                                      ; preds = %while_body28
  %pptr50 = getelementptr inbounds { i64, [8 x i8] }, ptr %val43, i32 0, i32 1
  %pval51 = load ptr, ptr %pptr50, align 8
  call void @lunite_retain(ptr %pval51)
  store ptr %pval51, ptr %f, align 8
  %self52 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self52)
  %f53 = load ptr, ptr %f, align 8
  call void @lunite_retain(ptr %f53)
  %sdata = call ptr @lunite_alloc(i64 0, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.201, i64 0, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p54 = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p54, align 8
  store i64 0, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  call void @codegen_c_CodegenC_gen_function_proto(ptr %self52, ptr %f53, ptr %sstruct)
  %tmp55 = load ptr, ptr %f, align 8
  call void @lunite_release(ptr %tmp55)
  br label %when_end44

when_next56:                                      ; preds = %when_next45
  br label %when_body85

when_body57:                                      ; preds = %when_next45
  %pptr61 = getelementptr inbounds { i64, [8 x i8] }, ptr %val43, i32 0, i32 1
  %pval62 = load ptr, ptr %pptr61, align 8
  call void @lunite_retain(ptr %pval62)
  store ptr %pval62, ptr %imp, align 8
  store i64 0, ptr %j, align 8
  br label %while_cond63

while_cond63:                                     ; preds = %while_body64, %when_body57
  %j66 = load i64, ptr %j, align 8
  %imp67 = load ptr, ptr %imp, align 8
  %fp68 = getelementptr inbounds %ast_ImplDecl, ptr %imp67, i32 0, i32 2
  %methods = load ptr, ptr %fp68, align 8
  %fp69 = getelementptr inbounds %list_List, ptr %methods, i32 0, i32 1
  %count70 = load i64, ptr %fp69, align 8
  %6 = icmp slt i64 %j66, %count70
  br i1 %6, label %while_body64, label %while_end65

while_body64:                                     ; preds = %while_cond63
  %self71 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self71)
  %imp72 = load ptr, ptr %imp, align 8
  %fp73 = getelementptr inbounds %ast_ImplDecl, ptr %imp72, i32 0, i32 2
  %methods74 = load ptr, ptr %fp73, align 8
  %fp75 = getelementptr inbounds %list_List, ptr %methods74, i32 0, i32 0
  %data76 = load ptr, ptr %fp75, align 8
  %j77 = load i64, ptr %j, align 8
  %ptr78 = getelementptr ptr, ptr %data76, i64 %j77
  %val79 = load ptr, ptr %ptr78, align 8
  call void @lunite_retain(ptr %val79)
  %imp80 = load ptr, ptr %imp, align 8
  %fp81 = getelementptr inbounds %ast_ImplDecl, ptr %imp80, i32 0, i32 0
  %struct_name = load ptr, ptr %fp81, align 8
  call void @lunite_retain(ptr %struct_name)
  call void @codegen_c_CodegenC_gen_function_proto(ptr %self71, ptr %val79, ptr %struct_name)
  %j82 = load i64, ptr %j, align 8
  %7 = add i64 %j82, 1
  store i64 %7, ptr %j, align 8
  br label %while_cond63

while_end65:                                      ; preds = %while_cond63
  %tmp83 = load ptr, ptr %imp, align 8
  call void @lunite_release(ptr %tmp83)
  br label %when_end44

when_next84:                                      ; No predecessors!
  br label %when_end44

when_body85:                                      ; preds = %when_next56
  br label %when_end44

while_cond87:                                     ; preds = %when_end104, %while_end29
  %i90 = load i64, ptr %i, align 8
  %p91 = load ptr, ptr %p, align 8
  %fp92 = getelementptr inbounds %ast_Program, ptr %p91, i32 0, i32 0
  %items93 = load ptr, ptr %fp92, align 8
  %fp94 = getelementptr inbounds %list_List, ptr %items93, i32 0, i32 1
  %count95 = load i64, ptr %fp94, align 8
  %8 = icmp slt i64 %i90, %count95
  br i1 %8, label %while_body88, label %while_end89

while_body88:                                     ; preds = %while_cond87
  %p96 = load ptr, ptr %p, align 8
  %fp97 = getelementptr inbounds %ast_Program, ptr %p96, i32 0, i32 0
  %items98 = load ptr, ptr %fp97, align 8
  %fp99 = getelementptr inbounds %list_List, ptr %items98, i32 0, i32 0
  %data100 = load ptr, ptr %fp99, align 8
  %i101 = load i64, ptr %i, align 8
  %ptr102 = getelementptr ptr, ptr %data100, i64 %i101
  %val103 = load ptr, ptr %ptr102, align 8
  %tptr107 = getelementptr inbounds { i64, [8 x i8] }, ptr %val103, i32 0, i32 0
  %tag108 = load i64, ptr %tptr107, align 8
  %match109 = icmp eq i64 %tag108, 1
  br i1 %match109, label %when_body106, label %when_next105

while_end89:                                      ; preds = %while_cond87
  %self155 = load ptr, ptr %self, align 8
  %fp156 = getelementptr inbounds %codegen_c_CodegenC, ptr %self155, i32 0, i32 0
  %output = load ptr, ptr %fp156, align 8
  call void @lunite_retain(ptr %output)
  %tmp157 = load ptr, ptr %p, align 8
  call void @lunite_release(ptr %tmp157)
  %tmp158 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp158)
  ret ptr %output

when_end104:                                      ; preds = %when_next152, %when_body153, %while_end131, %when_body106
  %i154 = load i64, ptr %i, align 8
  %9 = add i64 %i154, 1
  store i64 %9, ptr %i, align 8
  br label %while_cond87

when_next105:                                     ; preds = %while_body88
  %tptr122 = getelementptr inbounds { i64, [8 x i8] }, ptr %val103, i32 0, i32 0
  %tag123 = load i64, ptr %tptr122, align 8
  %match124 = icmp eq i64 %tag123, 6
  br i1 %match124, label %when_body121, label %when_next120

when_body106:                                     ; preds = %while_body88
  %pptr110 = getelementptr inbounds { i64, [8 x i8] }, ptr %val103, i32 0, i32 1
  %pval111 = load ptr, ptr %pptr110, align 8
  call void @lunite_retain(ptr %pval111)
  store ptr %pval111, ptr %f112, align 8
  %self113 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self113)
  %f114 = load ptr, ptr %f112, align 8
  call void @lunite_retain(ptr %f114)
  %sdata115 = call ptr @lunite_alloc(i64 0, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata115, ptr align 1 @slit.202, i64 0, i1 false)
  %sstruct116 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p117 = getelementptr inbounds { ptr, i64 }, ptr %sstruct116, i32 0, i32 0
  %l118 = getelementptr inbounds { ptr, i64 }, ptr %sstruct116, i32 0, i32 1
  store ptr %sdata115, ptr %p117, align 8
  store i64 0, ptr %l118, align 8
  call void @lunite_retain(ptr %sstruct116)
  call void @codegen_c_CodegenC_gen_function_def(ptr %self113, ptr %f114, ptr %sstruct116)
  %tmp119 = load ptr, ptr %f112, align 8
  call void @lunite_release(ptr %tmp119)
  br label %when_end104

when_next120:                                     ; preds = %when_next105
  br label %when_body153

when_body121:                                     ; preds = %when_next105
  %pptr125 = getelementptr inbounds { i64, [8 x i8] }, ptr %val103, i32 0, i32 1
  %pval126 = load ptr, ptr %pptr125, align 8
  call void @lunite_retain(ptr %pval126)
  store ptr %pval126, ptr %imp127, align 8
  store i64 0, ptr %j128, align 8
  br label %while_cond129

while_cond129:                                    ; preds = %while_body130, %when_body121
  %j132 = load i64, ptr %j128, align 8
  %imp133 = load ptr, ptr %imp127, align 8
  %fp134 = getelementptr inbounds %ast_ImplDecl, ptr %imp133, i32 0, i32 2
  %methods135 = load ptr, ptr %fp134, align 8
  %fp136 = getelementptr inbounds %list_List, ptr %methods135, i32 0, i32 1
  %count137 = load i64, ptr %fp136, align 8
  %10 = icmp slt i64 %j132, %count137
  br i1 %10, label %while_body130, label %while_end131

while_body130:                                    ; preds = %while_cond129
  %self138 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self138)
  %imp139 = load ptr, ptr %imp127, align 8
  %fp140 = getelementptr inbounds %ast_ImplDecl, ptr %imp139, i32 0, i32 2
  %methods141 = load ptr, ptr %fp140, align 8
  %fp142 = getelementptr inbounds %list_List, ptr %methods141, i32 0, i32 0
  %data143 = load ptr, ptr %fp142, align 8
  %j144 = load i64, ptr %j128, align 8
  %ptr145 = getelementptr ptr, ptr %data143, i64 %j144
  %val146 = load ptr, ptr %ptr145, align 8
  call void @lunite_retain(ptr %val146)
  %imp147 = load ptr, ptr %imp127, align 8
  %fp148 = getelementptr inbounds %ast_ImplDecl, ptr %imp147, i32 0, i32 0
  %struct_name149 = load ptr, ptr %fp148, align 8
  call void @lunite_retain(ptr %struct_name149)
  call void @codegen_c_CodegenC_gen_function_def(ptr %self138, ptr %val146, ptr %struct_name149)
  %j150 = load i64, ptr %j128, align 8
  %11 = add i64 %j150, 1
  store i64 %11, ptr %j128, align 8
  br label %while_cond129

while_end131:                                     ; preds = %while_cond129
  %tmp151 = load ptr, ptr %imp127, align 8
  call void @lunite_release(ptr %tmp151)
  br label %when_end104

when_next152:                                     ; No predecessors!
  br label %when_end104

when_body153:                                     ; preds = %when_next120
  br label %when_end104
}

define void @codegen_c_CodegenC_gen_function_def(ptr %0, ptr %1, ptr %2) {
entry:
  %ends_with_star = alloca i1, align 1
  %len = alloca i64, align 8
  %p_type = alloca ptr, align 8
  %p38 = alloca ptr, align 8
  %i = alloca i64, align 8
  %params_str = alloca ptr, align 8
  %name5 = alloca ptr, align 8
  %ret_type = alloca ptr, align 8
  %struct_name = alloca ptr, align 8
  %f = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %f, align 8
  call void @lunite_retain(ptr %2)
  store ptr %2, ptr %struct_name, align 8
  %self1 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self1)
  %f2 = load ptr, ptr %f, align 8
  %fp = getelementptr inbounds %ast_FunctionDecl, ptr %f2, i32 0, i32 3
  %return_type = load ptr, ptr %fp, align 8
  call void @lunite_retain(ptr %return_type)
  %res = call ptr @codegen_c_CodegenC_gen_type(ptr %self1, ptr %return_type)
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %ret_type, align 8
  %f3 = load ptr, ptr %f, align 8
  %fp4 = getelementptr inbounds %ast_FunctionDecl, ptr %f3, i32 0, i32 0
  %name = load ptr, ptr %fp4, align 8
  call void @lunite_retain(ptr %name)
  store ptr %name, ptr %name5, align 8
  %struct_name6 = load ptr, ptr %struct_name, align 8
  call void @lunite_retain(ptr %struct_name6)
  %res7 = call i64 @string_length(ptr %struct_name6)
  %3 = icmp sgt i64 %res7, 0
  br i1 %3, label %then, label %else

then:                                             ; preds = %body
  %struct_name8 = load ptr, ptr %struct_name, align 8
  call void @lunite_retain(ptr %struct_name8)
  %sdata = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.203, i64 1, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p, align 8
  store i64 1, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  %f9 = load ptr, ptr %f, align 8
  %fp10 = getelementptr inbounds %ast_FunctionDecl, ptr %f9, i32 0, i32 0
  %name11 = load ptr, ptr %fp10, align 8
  call void @lunite_retain(ptr %name11)
  %res12 = call ptr @string_concat(ptr %sstruct, ptr %name11)
  call void @lunite_retain(ptr %res12)
  %res13 = call ptr @string_concat(ptr %struct_name8, ptr %res12)
  %old = load ptr, ptr %name5, align 8
  call void @lunite_retain(ptr %res13)
  store ptr %res13, ptr %name5, align 8
  call void @lunite_release(ptr %old)
  br label %cont

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else, %then
  %sdata14 = call ptr @lunite_alloc(i64 0, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata14, ptr align 1 @slit.204, i64 0, i1 false)
  %sstruct15 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p16 = getelementptr inbounds { ptr, i64 }, ptr %sstruct15, i32 0, i32 0
  %l17 = getelementptr inbounds { ptr, i64 }, ptr %sstruct15, i32 0, i32 1
  store ptr %sdata14, ptr %p16, align 8
  store i64 0, ptr %l17, align 8
  call void @lunite_retain(ptr %sstruct15)
  store ptr %sstruct15, ptr %params_str, align 8
  store i64 0, ptr %i, align 8
  br label %while_cond

while_cond:                                       ; preds = %cont47, %cont
  %i18 = load i64, ptr %i, align 8
  %f19 = load ptr, ptr %f, align 8
  %fp20 = getelementptr inbounds %ast_FunctionDecl, ptr %f19, i32 0, i32 2
  %params = load ptr, ptr %fp20, align 8
  %fp21 = getelementptr inbounds %list_List, ptr %params, i32 0, i32 1
  %count = load i64, ptr %fp21, align 8
  %4 = icmp slt i64 %i18, %count
  br i1 %4, label %while_body, label %while_end

while_body:                                       ; preds = %while_cond
  %i22 = load i64, ptr %i, align 8
  %5 = icmp sgt i64 %i22, 0
  br i1 %5, label %then23, label %else24

while_end:                                        ; preds = %while_cond
  %self86 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self86)
  %ret_type87 = load ptr, ptr %ret_type, align 8
  call void @lunite_retain(ptr %ret_type87)
  %sdata88 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata88, ptr align 1 @slit.208, i64 1, i1 false)
  %sstruct89 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p90 = getelementptr inbounds { ptr, i64 }, ptr %sstruct89, i32 0, i32 0
  %l91 = getelementptr inbounds { ptr, i64 }, ptr %sstruct89, i32 0, i32 1
  store ptr %sdata88, ptr %p90, align 8
  store i64 1, ptr %l91, align 8
  call void @lunite_retain(ptr %sstruct89)
  %res92 = call ptr @string_concat(ptr %ret_type87, ptr %sstruct89)
  call void @lunite_retain(ptr %res92)
  %name93 = load ptr, ptr %name5, align 8
  call void @lunite_retain(ptr %name93)
  %res94 = call ptr @string_concat(ptr %res92, ptr %name93)
  call void @lunite_retain(ptr %res94)
  %sdata95 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata95, ptr align 1 @slit.209, i64 1, i1 false)
  %sstruct96 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p97 = getelementptr inbounds { ptr, i64 }, ptr %sstruct96, i32 0, i32 0
  %l98 = getelementptr inbounds { ptr, i64 }, ptr %sstruct96, i32 0, i32 1
  store ptr %sdata95, ptr %p97, align 8
  store i64 1, ptr %l98, align 8
  call void @lunite_retain(ptr %sstruct96)
  %res99 = call ptr @string_concat(ptr %res94, ptr %sstruct96)
  call void @lunite_retain(ptr %res99)
  %params_str100 = load ptr, ptr %params_str, align 8
  call void @lunite_retain(ptr %params_str100)
  %sdata101 = call ptr @lunite_alloc(i64 3, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata101, ptr align 1 @slit.210, i64 3, i1 false)
  %sstruct102 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p103 = getelementptr inbounds { ptr, i64 }, ptr %sstruct102, i32 0, i32 0
  %l104 = getelementptr inbounds { ptr, i64 }, ptr %sstruct102, i32 0, i32 1
  store ptr %sdata101, ptr %p103, align 8
  store i64 3, ptr %l104, align 8
  call void @lunite_retain(ptr %sstruct102)
  %res105 = call ptr @string_concat(ptr %params_str100, ptr %sstruct102)
  call void @lunite_retain(ptr %res105)
  %res106 = call ptr @string_concat(ptr %res99, ptr %res105)
  call void @lunite_retain(ptr %res106)
  call void @codegen_c_CodegenC_emit_line(ptr %self86, ptr %res106)
  %self107 = load ptr, ptr %self, align 8
  %fp108 = getelementptr inbounds %codegen_c_CodegenC, ptr %self107, i32 0, i32 1
  %self109 = load ptr, ptr %self, align 8
  %fp110 = getelementptr inbounds %codegen_c_CodegenC, ptr %self109, i32 0, i32 1
  %indent = load i64, ptr %fp110, align 8
  %6 = add i64 %indent, 1
  store i64 %6, ptr %fp108, align 8
  %self111 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self111)
  %f112 = load ptr, ptr %f, align 8
  %fp113 = getelementptr inbounds %ast_FunctionDecl, ptr %f112, i32 0, i32 4
  %body114 = load ptr, ptr %fp113, align 8
  call void @lunite_retain(ptr %body114)
  call void @codegen_c_CodegenC_gen_block(ptr %self111, ptr %body114)
  %self115 = load ptr, ptr %self, align 8
  %fp116 = getelementptr inbounds %codegen_c_CodegenC, ptr %self115, i32 0, i32 1
  %self117 = load ptr, ptr %self, align 8
  %fp118 = getelementptr inbounds %codegen_c_CodegenC, ptr %self117, i32 0, i32 1
  %indent119 = load i64, ptr %fp118, align 8
  %7 = sub i64 %indent119, 1
  store i64 %7, ptr %fp116, align 8
  %self120 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self120)
  %sdata121 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata121, ptr align 1 @slit.211, i64 1, i1 false)
  %sstruct122 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p123 = getelementptr inbounds { ptr, i64 }, ptr %sstruct122, i32 0, i32 0
  %l124 = getelementptr inbounds { ptr, i64 }, ptr %sstruct122, i32 0, i32 1
  store ptr %sdata121, ptr %p123, align 8
  store i64 1, ptr %l124, align 8
  call void @lunite_retain(ptr %sstruct122)
  call void @codegen_c_CodegenC_emit_line(ptr %self120, ptr %sstruct122)
  %self125 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self125)
  call void @codegen_c_CodegenC_emit_newline(ptr %self125)
  %tmp126 = load ptr, ptr %params_str, align 8
  call void @lunite_release(ptr %tmp126)
  %tmp127 = load ptr, ptr %name5, align 8
  call void @lunite_release(ptr %tmp127)
  %tmp128 = load ptr, ptr %ret_type, align 8
  call void @lunite_release(ptr %tmp128)
  %tmp129 = load ptr, ptr %struct_name, align 8
  call void @lunite_release(ptr %tmp129)
  %tmp130 = load ptr, ptr %f, align 8
  call void @lunite_release(ptr %tmp130)
  %tmp131 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp131)
  ret void

then23:                                           ; preds = %while_body
  %params_str26 = load ptr, ptr %params_str, align 8
  call void @lunite_retain(ptr %params_str26)
  %sdata27 = call ptr @lunite_alloc(i64 2, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata27, ptr align 1 @slit.205, i64 2, i1 false)
  %sstruct28 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p29 = getelementptr inbounds { ptr, i64 }, ptr %sstruct28, i32 0, i32 0
  %l30 = getelementptr inbounds { ptr, i64 }, ptr %sstruct28, i32 0, i32 1
  store ptr %sdata27, ptr %p29, align 8
  store i64 2, ptr %l30, align 8
  call void @lunite_retain(ptr %sstruct28)
  %res31 = call ptr @string_concat(ptr %params_str26, ptr %sstruct28)
  %old32 = load ptr, ptr %params_str, align 8
  call void @lunite_retain(ptr %res31)
  store ptr %res31, ptr %params_str, align 8
  call void @lunite_release(ptr %old32)
  br label %cont25

else24:                                           ; preds = %while_body
  br label %cont25

cont25:                                           ; preds = %else24, %then23
  %f33 = load ptr, ptr %f, align 8
  %fp34 = getelementptr inbounds %ast_FunctionDecl, ptr %f33, i32 0, i32 2
  %params35 = load ptr, ptr %fp34, align 8
  %fp36 = getelementptr inbounds %list_List, ptr %params35, i32 0, i32 0
  %data = load ptr, ptr %fp36, align 8
  %i37 = load i64, ptr %i, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %i37
  %val = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val)
  store ptr %val, ptr %p38, align 8
  %self39 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self39)
  %p40 = load ptr, ptr %p38, align 8
  %fp41 = getelementptr inbounds %ast_Param, ptr %p40, i32 0, i32 1
  %typ = load ptr, ptr %fp41, align 8
  call void @lunite_retain(ptr %typ)
  %res42 = call ptr @codegen_c_CodegenC_gen_type(ptr %self39, ptr %typ)
  call void @lunite_retain(ptr %res42)
  store ptr %res42, ptr %p_type, align 8
  %p43 = load ptr, ptr %p38, align 8
  %fp44 = getelementptr inbounds %ast_Param, ptr %p43, i32 0, i32 2
  %is_mut = load i1, ptr %fp44, align 1
  br i1 %is_mut, label %then45, label %else46

then45:                                           ; preds = %cont25
  %p_type48 = load ptr, ptr %p_type, align 8
  call void @lunite_retain(ptr %p_type48)
  %res49 = call i64 @string_length(ptr %p_type48)
  store i64 %res49, ptr %len, align 8
  store i1 false, ptr %ends_with_star, align 1
  %len50 = load i64, ptr %len, align 8
  %8 = icmp sgt i64 %len50, 0
  br i1 %8, label %then51, label %else52

else46:                                           ; preds = %cont25
  br label %cont47

cont47:                                           ; preds = %else46, %cont63
  %params_str71 = load ptr, ptr %params_str, align 8
  call void @lunite_retain(ptr %params_str71)
  %p_type72 = load ptr, ptr %p_type, align 8
  call void @lunite_retain(ptr %p_type72)
  %sdata73 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata73, ptr align 1 @slit.207, i64 1, i1 false)
  %sstruct74 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p75 = getelementptr inbounds { ptr, i64 }, ptr %sstruct74, i32 0, i32 0
  %l76 = getelementptr inbounds { ptr, i64 }, ptr %sstruct74, i32 0, i32 1
  store ptr %sdata73, ptr %p75, align 8
  store i64 1, ptr %l76, align 8
  call void @lunite_retain(ptr %sstruct74)
  %res77 = call ptr @string_concat(ptr %p_type72, ptr %sstruct74)
  call void @lunite_retain(ptr %res77)
  %p78 = load ptr, ptr %p38, align 8
  %fp79 = getelementptr inbounds %ast_Param, ptr %p78, i32 0, i32 0
  %name80 = load ptr, ptr %fp79, align 8
  call void @lunite_retain(ptr %name80)
  %res81 = call ptr @string_concat(ptr %res77, ptr %name80)
  call void @lunite_retain(ptr %res81)
  %res82 = call ptr @string_concat(ptr %params_str71, ptr %res81)
  %old83 = load ptr, ptr %params_str, align 8
  call void @lunite_retain(ptr %res82)
  store ptr %res82, ptr %params_str, align 8
  call void @lunite_release(ptr %old83)
  %i84 = load i64, ptr %i, align 8
  %9 = add i64 %i84, 1
  store i64 %9, ptr %i, align 8
  %tmp = load ptr, ptr %p_type, align 8
  call void @lunite_release(ptr %tmp)
  %tmp85 = load ptr, ptr %p38, align 8
  call void @lunite_release(ptr %tmp85)
  br label %while_cond

then51:                                           ; preds = %then45
  %p_type54 = load ptr, ptr %p_type, align 8
  call void @lunite_retain(ptr %p_type54)
  %len55 = load i64, ptr %len, align 8
  %10 = sub i64 %len55, 1
  %res56 = call i64 @string_char_at(ptr %p_type54, i64 %10)
  %11 = icmp eq i64 %res56, 42
  br i1 %11, label %then57, label %else58

else52:                                           ; preds = %then45
  br label %cont53

cont53:                                           ; preds = %else52, %cont59
  %ends_with_star60 = load i1, ptr %ends_with_star, align 1
  %not = xor i1 %ends_with_star60, true
  br i1 %not, label %then61, label %else62

then57:                                           ; preds = %then51
  store i1 true, ptr %ends_with_star, align 1
  br label %cont59

else58:                                           ; preds = %then51
  br label %cont59

cont59:                                           ; preds = %else58, %then57
  br label %cont53

then61:                                           ; preds = %cont53
  %p_type64 = load ptr, ptr %p_type, align 8
  call void @lunite_retain(ptr %p_type64)
  %sdata65 = call ptr @lunite_alloc(i64 1, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata65, ptr align 1 @slit.206, i64 1, i1 false)
  %sstruct66 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p67 = getelementptr inbounds { ptr, i64 }, ptr %sstruct66, i32 0, i32 0
  %l68 = getelementptr inbounds { ptr, i64 }, ptr %sstruct66, i32 0, i32 1
  store ptr %sdata65, ptr %p67, align 8
  store i64 1, ptr %l68, align 8
  call void @lunite_retain(ptr %sstruct66)
  %res69 = call ptr @string_concat(ptr %p_type64, ptr %sstruct66)
  %old70 = load ptr, ptr %p_type, align 8
  call void @lunite_retain(ptr %res69)
  store ptr %res69, ptr %p_type, align 8
  call void @lunite_release(ptr %old70)
  br label %cont63

else62:                                           ; preds = %cont53
  br label %cont63

cont63:                                           ; preds = %else62, %then61
  br label %cont47
}

define { i64, i64 } @io_read_file(ptr %0) {
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

define i1 @io_write_file(ptr %0, ptr %1) {
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

declare ptr @lunite_io_read_file_str(ptr %0)

define ptr @io_read_file_text(ptr %0) {
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

define i1 @io_write_file_text(ptr %0, ptr %1) {
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

define i64 @io_level_to_int(ptr %0) {
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

define void @io_log(ptr %0, ptr %1) {
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

define void @sys_exit(i64 %0) {
entry:
  %code = alloca i64, align 8
  br label %body

body:                                             ; preds = %entry
  store i64 %0, ptr %code, align 8
  %code1 = load i64, ptr %code, align 8
  call void @lunite_sys_exit(i64 %code1)
  ret void
}

define i64 @sys_exec(ptr %0) {
entry:
  %cmd = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %cmd, align 8
  %cmd1 = load ptr, ptr %cmd, align 8
  call void @lunite_retain(ptr %cmd1)
  %res = call i64 @lunite_sys_system(ptr %cmd1)
  %tmp = load ptr, ptr %cmd, align 8
  call void @lunite_release(ptr %tmp)
  ret i64 0
}

define i64 @sys_get_argc() {
entry:
  br label %body

body:                                             ; preds = %entry
  %res = call i64 @lunite_sys_get_argc()
  ret i64 %res
}

define ptr @sys_get_arg(i64 %0) {
entry:
  %i = alloca i64, align 8
  br label %body

body:                                             ; preds = %entry
  store i64 %0, ptr %i, align 8
  %i1 = load i64, ptr %i, align 8
  %res = call ptr @lunite_sys_get_arg(i64 %i1)
  call void @lunite_retain(ptr %res)
  ret ptr %res
}

define i64 @main(i32 %0, ptr %1) {
entry:
  %argc = alloca i64, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_init_args(i32 %0, ptr %1)
  %sdata = call ptr @lunite_alloc(i64 5, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.212, i64 5, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p, align 8
  store i64 5, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  call void @string_println(ptr %sstruct)
  %res = call i64 @sys_get_argc()
  store i64 %res, ptr %argc, align 8
  %argc1 = load i64, ptr %argc, align 8
  %2 = icmp slt i64 %argc1, 2
  br i1 %2, label %then, label %else

then:                                             ; preds = %body
  call void @main_print_usage()
  br label %cont

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else, %then
  %argc2 = load i64, ptr %argc, align 8
  %3 = icmp sge i64 %argc2, 2
  br i1 %3, label %then3, label %else4

then3:                                            ; preds = %cont
  call void @main_dispatch_command()
  br label %cont5

else4:                                            ; preds = %cont
  br label %cont5

cont5:                                            ; preds = %else4, %then3
  ret i64 0
}

define void @main_print_usage() {
entry:
  br label %body

body:                                             ; preds = %entry
  %sdata = call ptr @lunite_alloc(i64 27, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.213, i64 27, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p, align 8
  store i64 27, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  call void @string_println(ptr %sstruct)
  %sdata1 = call ptr @lunite_alloc(i64 27, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata1, ptr align 1 @slit.214, i64 27, i1 false)
  %sstruct2 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p3 = getelementptr inbounds { ptr, i64 }, ptr %sstruct2, i32 0, i32 0
  %l4 = getelementptr inbounds { ptr, i64 }, ptr %sstruct2, i32 0, i32 1
  store ptr %sdata1, ptr %p3, align 8
  store i64 27, ptr %l4, align 8
  call void @lunite_retain(ptr %sstruct2)
  call void @string_println(ptr %sstruct2)
  %sdata5 = call ptr @lunite_alloc(i64 9, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata5, ptr align 1 @slit.215, i64 9, i1 false)
  %sstruct6 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p7 = getelementptr inbounds { ptr, i64 }, ptr %sstruct6, i32 0, i32 0
  %l8 = getelementptr inbounds { ptr, i64 }, ptr %sstruct6, i32 0, i32 1
  store ptr %sdata5, ptr %p7, align 8
  store i64 9, ptr %l8, align 8
  call void @lunite_retain(ptr %sstruct6)
  call void @string_println(ptr %sstruct6)
  %sdata9 = call ptr @lunite_alloc(i64 40, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata9, ptr align 1 @slit.216, i64 40, i1 false)
  %sstruct10 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p11 = getelementptr inbounds { ptr, i64 }, ptr %sstruct10, i32 0, i32 0
  %l12 = getelementptr inbounds { ptr, i64 }, ptr %sstruct10, i32 0, i32 1
  store ptr %sdata9, ptr %p11, align 8
  store i64 40, ptr %l12, align 8
  call void @lunite_retain(ptr %sstruct10)
  call void @string_println(ptr %sstruct10)
  %sdata13 = call ptr @lunite_alloc(i64 33, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata13, ptr align 1 @slit.217, i64 33, i1 false)
  %sstruct14 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p15 = getelementptr inbounds { ptr, i64 }, ptr %sstruct14, i32 0, i32 0
  %l16 = getelementptr inbounds { ptr, i64 }, ptr %sstruct14, i32 0, i32 1
  store ptr %sdata13, ptr %p15, align 8
  store i64 33, ptr %l16, align 8
  call void @lunite_retain(ptr %sstruct14)
  call void @string_println(ptr %sstruct14)
  ret void
}

define void @main_dispatch_command() {
entry:
  %argc = alloca i64, align 8
  %first_char = alloca i64, align 8
  %command = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  %res = call ptr @sys_get_arg(i64 1)
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %command, align 8
  %command1 = load ptr, ptr %command, align 8
  call void @lunite_retain(ptr %command1)
  %res2 = call i64 @string_char_at(ptr %command1, i64 0)
  store i64 %res2, ptr %first_char, align 8
  %res3 = call i64 @sys_get_argc()
  store i64 %res3, ptr %argc, align 8
  %first_char4 = load i64, ptr %first_char, align 8
  %0 = icmp eq i64 %first_char4, 99
  br i1 %0, label %then, label %else

then:                                             ; preds = %body
  %argc5 = load i64, ptr %argc, align 8
  call void @main_do_check(i64 %argc5)
  br label %cont

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else, %then
  %first_char6 = load i64, ptr %first_char, align 8
  %1 = icmp eq i64 %first_char6, 98
  br i1 %1, label %then7, label %else8

then7:                                            ; preds = %cont
  %argc10 = load i64, ptr %argc, align 8
  call void @main_do_build(i64 %argc10)
  br label %cont9

else8:                                            ; preds = %cont
  br label %cont9

cont9:                                            ; preds = %else8, %then7
  %tmp = load ptr, ptr %command, align 8
  call void @lunite_release(ptr %tmp)
  ret void
}

define void @main_do_check(i64 %0) {
entry:
  %argc = alloca i64, align 8
  br label %body

body:                                             ; preds = %entry
  store i64 %0, ptr %argc, align 8
  %argc1 = load i64, ptr %argc, align 8
  %1 = icmp slt i64 %argc1, 3
  br i1 %1, label %then, label %else

then:                                             ; preds = %body
  %sdata = call ptr @lunite_alloc(i64 23, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.218, i64 23, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p, align 8
  store i64 23, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  call void @string_println(ptr %sstruct)
  br label %cont

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else, %then
  %argc2 = load i64, ptr %argc, align 8
  %2 = icmp sge i64 %argc2, 3
  br i1 %2, label %then3, label %else4

then3:                                            ; preds = %cont
  %res = call ptr @sys_get_arg(i64 2)
  call void @lunite_retain(ptr %res)
  call void @main_run_check(ptr %res)
  br label %cont5

else4:                                            ; preds = %cont
  br label %cont5

cont5:                                            ; preds = %else4, %then3
  ret void
}

define void @main_do_build(i64 %0) {
entry:
  %argc = alloca i64, align 8
  br label %body

body:                                             ; preds = %entry
  store i64 %0, ptr %argc, align 8
  %argc1 = load i64, ptr %argc, align 8
  %1 = icmp slt i64 %argc1, 3
  br i1 %1, label %then, label %else

then:                                             ; preds = %body
  %sdata = call ptr @lunite_alloc(i64 23, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.219, i64 23, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p, align 8
  store i64 23, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  call void @string_println(ptr %sstruct)
  br label %cont

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else, %then
  %argc2 = load i64, ptr %argc, align 8
  %2 = icmp sge i64 %argc2, 3
  br i1 %2, label %then3, label %else4

then3:                                            ; preds = %cont
  %res = call ptr @sys_get_arg(i64 2)
  call void @lunite_retain(ptr %res)
  call void @main_run_build(ptr %res)
  br label %cont5

else4:                                            ; preds = %cont
  br label %cont5

cont5:                                            ; preds = %else4, %then3
  ret void
}

define void @main_run_check(ptr %0) {
entry:
  %typed_items = alloca ptr, align 8
  %analyzer = alloca ptr, align 8
  %program = alloca ptr, align 8
  %p16 = alloca ptr, align 8
  %l9 = alloca ptr, align 8
  %source = alloca ptr, align 8
  %filename = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %filename, align 8
  %sdata = call ptr @lunite_alloc(i64 10, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.220, i64 10, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p, align 8
  store i64 10, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  call void @string_print(ptr %sstruct)
  %filename1 = load ptr, ptr %filename, align 8
  call void @lunite_retain(ptr %filename1)
  call void @string_println(ptr %filename1)
  %filename2 = load ptr, ptr %filename, align 8
  call void @lunite_retain(ptr %filename2)
  %res = call ptr @io_read_file_text(ptr %filename2)
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %source, align 8
  %sdata3 = call ptr @lunite_alloc(i64 14, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata3, ptr align 1 @slit.221, i64 14, i1 false)
  %sstruct4 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p5 = getelementptr inbounds { ptr, i64 }, ptr %sstruct4, i32 0, i32 0
  %l6 = getelementptr inbounds { ptr, i64 }, ptr %sstruct4, i32 0, i32 1
  store ptr %sdata3, ptr %p5, align 8
  store i64 14, ptr %l6, align 8
  call void @lunite_retain(ptr %sstruct4)
  call void @string_println(ptr %sstruct4)
  %source7 = load ptr, ptr %source, align 8
  call void @lunite_retain(ptr %source7)
  %res8 = call ptr @lexer_Lexer_new(ptr %source7)
  call void @lunite_retain(ptr %res8)
  store ptr %res8, ptr %l9, align 8
  %sdata10 = call ptr @lunite_alloc(i64 15, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata10, ptr align 1 @slit.222, i64 15, i1 false)
  %sstruct11 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p12 = getelementptr inbounds { ptr, i64 }, ptr %sstruct11, i32 0, i32 0
  %l13 = getelementptr inbounds { ptr, i64 }, ptr %sstruct11, i32 0, i32 1
  store ptr %sdata10, ptr %p12, align 8
  store i64 15, ptr %l13, align 8
  call void @lunite_retain(ptr %sstruct11)
  call void @string_println(ptr %sstruct11)
  %l14 = load ptr, ptr %l9, align 8
  call void @lunite_retain(ptr %l14)
  %res15 = call ptr @parser_Parser_new(ptr %l14)
  call void @lunite_retain(ptr %res15)
  store ptr %res15, ptr %p16, align 8
  %p17 = load ptr, ptr %p16, align 8
  call void @lunite_retain(ptr %p17)
  %res18 = call ptr @parser_Parser_parse_program(ptr %p17)
  call void @lunite_retain(ptr %res18)
  store ptr %res18, ptr %program, align 8
  %sdata19 = call ptr @lunite_alloc(i64 25, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata19, ptr align 1 @slit.223, i64 25, i1 false)
  %sstruct20 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p21 = getelementptr inbounds { ptr, i64 }, ptr %sstruct20, i32 0, i32 0
  %l22 = getelementptr inbounds { ptr, i64 }, ptr %sstruct20, i32 0, i32 1
  store ptr %sdata19, ptr %p21, align 8
  store i64 25, ptr %l22, align 8
  call void @lunite_retain(ptr %sstruct20)
  call void @string_println(ptr %sstruct20)
  %res23 = call ptr @semantic_SemanticAnalyzer_new()
  call void @lunite_retain(ptr %res23)
  store ptr %res23, ptr %analyzer, align 8
  %analyzer24 = load ptr, ptr %analyzer, align 8
  call void @lunite_retain(ptr %analyzer24)
  %program25 = load ptr, ptr %program, align 8
  call void @lunite_retain(ptr %program25)
  %res26 = call ptr @semantic_SemanticAnalyzer_analyze_program(ptr %analyzer24, ptr %program25)
  call void @lunite_retain(ptr %res26)
  store ptr %res26, ptr %typed_items, align 8
  %sdata27 = call ptr @lunite_alloc(i64 32, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata27, ptr align 1 @slit.224, i64 32, i1 false)
  %sstruct28 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p29 = getelementptr inbounds { ptr, i64 }, ptr %sstruct28, i32 0, i32 0
  %l30 = getelementptr inbounds { ptr, i64 }, ptr %sstruct28, i32 0, i32 1
  store ptr %sdata27, ptr %p29, align 8
  store i64 32, ptr %l30, align 8
  call void @lunite_retain(ptr %sstruct28)
  call void @string_print(ptr %sstruct28)
  %typed_items31 = load ptr, ptr %typed_items, align 8
  call void @lunite_retain(ptr %typed_items31)
  %res32 = call i64 @list_List_semantic_TItem__len(ptr %typed_items31)
  %res33 = call ptr @string_int_to_string(i64 %res32)
  call void @lunite_retain(ptr %res33)
  call void @string_println(ptr %res33)
  %sdata34 = call ptr @lunite_alloc(i64 13, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata34, ptr align 1 @slit.225, i64 13, i1 false)
  %sstruct35 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p36 = getelementptr inbounds { ptr, i64 }, ptr %sstruct35, i32 0, i32 0
  %l37 = getelementptr inbounds { ptr, i64 }, ptr %sstruct35, i32 0, i32 1
  store ptr %sdata34, ptr %p36, align 8
  store i64 13, ptr %l37, align 8
  call void @lunite_retain(ptr %sstruct35)
  call void @string_println(ptr %sstruct35)
  %tmp = load ptr, ptr %typed_items, align 8
  call void @lunite_release(ptr %tmp)
  %tmp38 = load ptr, ptr %analyzer, align 8
  call void @lunite_release(ptr %tmp38)
  %tmp39 = load ptr, ptr %program, align 8
  call void @lunite_release(ptr %tmp39)
  %tmp40 = load ptr, ptr %p16, align 8
  call void @lunite_release(ptr %tmp40)
  %tmp41 = load ptr, ptr %l9, align 8
  call void @lunite_release(ptr %tmp41)
  %tmp42 = load ptr, ptr %source, align 8
  call void @lunite_release(ptr %tmp42)
  %tmp43 = load ptr, ptr %filename, align 8
  call void @lunite_release(ptr %tmp43)
  ret void
}

define void @main_run_build(ptr %0) {
entry:
  %out_name = alloca ptr, align 8
  %base_len = alloca i64, align 8
  %c_code = alloca ptr, align 8
  %gen = alloca ptr, align 8
  %typed_items = alloca ptr, align 8
  %analyzer = alloca ptr, align 8
  %program = alloca ptr, align 8
  %p16 = alloca ptr, align 8
  %l9 = alloca ptr, align 8
  %source = alloca ptr, align 8
  %filename = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %filename, align 8
  %sdata = call ptr @lunite_alloc(i64 10, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.226, i64 10, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p, align 8
  store i64 10, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  call void @string_print(ptr %sstruct)
  %filename1 = load ptr, ptr %filename, align 8
  call void @lunite_retain(ptr %filename1)
  call void @string_println(ptr %filename1)
  %filename2 = load ptr, ptr %filename, align 8
  call void @lunite_retain(ptr %filename2)
  %res = call ptr @io_read_file_text(ptr %filename2)
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %source, align 8
  %sdata3 = call ptr @lunite_alloc(i64 14, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata3, ptr align 1 @slit.227, i64 14, i1 false)
  %sstruct4 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p5 = getelementptr inbounds { ptr, i64 }, ptr %sstruct4, i32 0, i32 0
  %l6 = getelementptr inbounds { ptr, i64 }, ptr %sstruct4, i32 0, i32 1
  store ptr %sdata3, ptr %p5, align 8
  store i64 14, ptr %l6, align 8
  call void @lunite_retain(ptr %sstruct4)
  call void @string_println(ptr %sstruct4)
  %source7 = load ptr, ptr %source, align 8
  call void @lunite_retain(ptr %source7)
  %res8 = call ptr @lexer_Lexer_new(ptr %source7)
  call void @lunite_retain(ptr %res8)
  store ptr %res8, ptr %l9, align 8
  %sdata10 = call ptr @lunite_alloc(i64 15, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata10, ptr align 1 @slit.228, i64 15, i1 false)
  %sstruct11 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p12 = getelementptr inbounds { ptr, i64 }, ptr %sstruct11, i32 0, i32 0
  %l13 = getelementptr inbounds { ptr, i64 }, ptr %sstruct11, i32 0, i32 1
  store ptr %sdata10, ptr %p12, align 8
  store i64 15, ptr %l13, align 8
  call void @lunite_retain(ptr %sstruct11)
  call void @string_println(ptr %sstruct11)
  %l14 = load ptr, ptr %l9, align 8
  call void @lunite_retain(ptr %l14)
  %res15 = call ptr @parser_Parser_new(ptr %l14)
  call void @lunite_retain(ptr %res15)
  store ptr %res15, ptr %p16, align 8
  %p17 = load ptr, ptr %p16, align 8
  call void @lunite_retain(ptr %p17)
  %res18 = call ptr @parser_Parser_parse_program(ptr %p17)
  call void @lunite_retain(ptr %res18)
  store ptr %res18, ptr %program, align 8
  %sdata19 = call ptr @lunite_alloc(i64 25, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata19, ptr align 1 @slit.229, i64 25, i1 false)
  %sstruct20 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p21 = getelementptr inbounds { ptr, i64 }, ptr %sstruct20, i32 0, i32 0
  %l22 = getelementptr inbounds { ptr, i64 }, ptr %sstruct20, i32 0, i32 1
  store ptr %sdata19, ptr %p21, align 8
  store i64 25, ptr %l22, align 8
  call void @lunite_retain(ptr %sstruct20)
  call void @string_println(ptr %sstruct20)
  %res23 = call ptr @semantic_SemanticAnalyzer_new()
  call void @lunite_retain(ptr %res23)
  store ptr %res23, ptr %analyzer, align 8
  %analyzer24 = load ptr, ptr %analyzer, align 8
  call void @lunite_retain(ptr %analyzer24)
  %program25 = load ptr, ptr %program, align 8
  call void @lunite_retain(ptr %program25)
  %res26 = call ptr @semantic_SemanticAnalyzer_analyze_program(ptr %analyzer24, ptr %program25)
  call void @lunite_retain(ptr %res26)
  store ptr %res26, ptr %typed_items, align 8
  %sdata27 = call ptr @lunite_alloc(i64 23, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata27, ptr align 1 @slit.230, i64 23, i1 false)
  %sstruct28 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p29 = getelementptr inbounds { ptr, i64 }, ptr %sstruct28, i32 0, i32 0
  %l30 = getelementptr inbounds { ptr, i64 }, ptr %sstruct28, i32 0, i32 1
  store ptr %sdata27, ptr %p29, align 8
  store i64 23, ptr %l30, align 8
  call void @lunite_retain(ptr %sstruct28)
  call void @string_println(ptr %sstruct28)
  %res31 = call ptr @codegen_c_CodegenC_new()
  call void @lunite_retain(ptr %res31)
  store ptr %res31, ptr %gen, align 8
  %gen32 = load ptr, ptr %gen, align 8
  call void @lunite_retain(ptr %gen32)
  %program33 = load ptr, ptr %program, align 8
  call void @lunite_retain(ptr %program33)
  %res34 = call ptr @codegen_c_CodegenC_generate(ptr %gen32, ptr %program33)
  call void @lunite_retain(ptr %res34)
  store ptr %res34, ptr %c_code, align 8
  %filename35 = load ptr, ptr %filename, align 8
  call void @lunite_retain(ptr %filename35)
  %res36 = call i64 @string_length(ptr %filename35)
  %1 = sub i64 %res36, 4
  store i64 %1, ptr %base_len, align 8
  %filename37 = load ptr, ptr %filename, align 8
  call void @lunite_retain(ptr %filename37)
  %base_len38 = load i64, ptr %base_len, align 8
  %res39 = call ptr @string_sub(ptr %filename37, i64 0, i64 %base_len38)
  call void @lunite_retain(ptr %res39)
  %sdata40 = call ptr @lunite_alloc(i64 2, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata40, ptr align 1 @slit.231, i64 2, i1 false)
  %sstruct41 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p42 = getelementptr inbounds { ptr, i64 }, ptr %sstruct41, i32 0, i32 0
  %l43 = getelementptr inbounds { ptr, i64 }, ptr %sstruct41, i32 0, i32 1
  store ptr %sdata40, ptr %p42, align 8
  store i64 2, ptr %l43, align 8
  call void @lunite_retain(ptr %sstruct41)
  %res44 = call ptr @string_concat(ptr %res39, ptr %sstruct41)
  call void @lunite_retain(ptr %res44)
  store ptr %res44, ptr %out_name, align 8
  %out_name45 = load ptr, ptr %out_name, align 8
  call void @lunite_retain(ptr %out_name45)
  %c_code46 = load ptr, ptr %c_code, align 8
  call void @lunite_retain(ptr %c_code46)
  %res47 = call i1 @io_write_file_text(ptr %out_name45, ptr %c_code46)
  %sdata48 = call ptr @lunite_alloc(i64 11, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata48, ptr align 1 @slit.232, i64 11, i1 false)
  %sstruct49 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p50 = getelementptr inbounds { ptr, i64 }, ptr %sstruct49, i32 0, i32 0
  %l51 = getelementptr inbounds { ptr, i64 }, ptr %sstruct49, i32 0, i32 1
  store ptr %sdata48, ptr %p50, align 8
  store i64 11, ptr %l51, align 8
  call void @lunite_retain(ptr %sstruct49)
  call void @string_print(ptr %sstruct49)
  %out_name52 = load ptr, ptr %out_name, align 8
  call void @lunite_retain(ptr %out_name52)
  call void @string_println(ptr %out_name52)
  %sdata53 = call ptr @lunite_alloc(i64 15, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata53, ptr align 1 @slit.233, i64 15, i1 false)
  %sstruct54 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p55 = getelementptr inbounds { ptr, i64 }, ptr %sstruct54, i32 0, i32 0
  %l56 = getelementptr inbounds { ptr, i64 }, ptr %sstruct54, i32 0, i32 1
  store ptr %sdata53, ptr %p55, align 8
  store i64 15, ptr %l56, align 8
  call void @lunite_retain(ptr %sstruct54)
  call void @string_println(ptr %sstruct54)
  %tmp = load ptr, ptr %out_name, align 8
  call void @lunite_release(ptr %tmp)
  %tmp57 = load ptr, ptr %c_code, align 8
  call void @lunite_release(ptr %tmp57)
  %tmp58 = load ptr, ptr %gen, align 8
  call void @lunite_release(ptr %tmp58)
  %tmp59 = load ptr, ptr %typed_items, align 8
  call void @lunite_release(ptr %tmp59)
  %tmp60 = load ptr, ptr %analyzer, align 8
  call void @lunite_release(ptr %tmp60)
  %tmp61 = load ptr, ptr %program, align 8
  call void @lunite_release(ptr %tmp61)
  %tmp62 = load ptr, ptr %p16, align 8
  call void @lunite_release(ptr %tmp62)
  %tmp63 = load ptr, ptr %l9, align 8
  call void @lunite_release(ptr %tmp63)
  %tmp64 = load ptr, ptr %source, align 8
  call void @lunite_release(ptr %tmp64)
  %tmp65 = load ptr, ptr %filename, align 8
  call void @lunite_release(ptr %tmp65)
  ret void
}

define ptr @semantic_Scope_new(i64 %0) {
entry:
  %parent_index = alloca i64, align 8
  br label %body

body:                                             ; preds = %entry
  store i64 %0, ptr %parent_index, align 8
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%semantic_Scope, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %semantic_Scope, ptr %ptr, i32 0, i32 0
  %res = call ptr @map_Map_string_semantic_Symbol__new()
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %fp, align 8
  %fp1 = getelementptr inbounds %semantic_Scope, ptr %ptr, i32 0, i32 1
  %parent_index2 = load i64, ptr %parent_index, align 8
  store i64 %parent_index2, ptr %fp1, align 8
  call void @lunite_retain(ptr %ptr)
  ret ptr %ptr
}

define void @semantic_Scope_insert(ptr %0, ptr %1, ptr %2) {
entry:
  %sym = alloca ptr, align 8
  %name = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %name, align 8
  call void @lunite_retain(ptr %2)
  store ptr %2, ptr %sym, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %semantic_Scope, ptr %self1, i32 0, i32 0
  %symbols = load ptr, ptr %fp, align 8
  call void @lunite_retain(ptr %symbols)
  %name2 = load ptr, ptr %name, align 8
  call void @lunite_retain(ptr %name2)
  %sym3 = load ptr, ptr %sym, align 8
  call void @lunite_retain(ptr %sym3)
  call void @map_Map_string_semantic_Symbol__put(ptr %symbols, ptr %name2, ptr %sym3)
  %tmp = load ptr, ptr %sym, align 8
  call void @lunite_release(ptr %tmp)
  %tmp4 = load ptr, ptr %name, align 8
  call void @lunite_release(ptr %tmp4)
  %tmp5 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp5)
  ret void
}

define ptr @semantic_SemanticAnalyzer_new() {
entry:
  %scopes = alloca ptr, align 8
  %global_scope = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  %res = call ptr @semantic_Scope_new(i64 -1)
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %global_scope, align 8
  %res1 = call ptr @list_List_semantic_Scope__new()
  call void @lunite_retain(ptr %res1)
  store ptr %res1, ptr %scopes, align 8
  %scopes2 = load ptr, ptr %scopes, align 8
  call void @lunite_retain(ptr %scopes2)
  %global_scope3 = load ptr, ptr %global_scope, align 8
  call void @lunite_retain(ptr %global_scope3)
  call void @list_List_semantic_Scope__push(ptr %scopes2, ptr %global_scope3)
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%semantic_SemanticAnalyzer, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %semantic_SemanticAnalyzer, ptr %ptr, i32 0, i32 0
  %scopes4 = load ptr, ptr %scopes, align 8
  call void @lunite_retain(ptr %scopes4)
  store ptr %scopes4, ptr %fp, align 8
  %fp5 = getelementptr inbounds %semantic_SemanticAnalyzer, ptr %ptr, i32 0, i32 1
  store i64 0, ptr %fp5, align 8
  %fp6 = getelementptr inbounds %semantic_SemanticAnalyzer, ptr %ptr, i32 0, i32 2
  %res7 = call ptr @list_List_string_new()
  call void @lunite_retain(ptr %res7)
  store ptr %res7, ptr %fp6, align 8
  %fp8 = getelementptr inbounds %semantic_SemanticAnalyzer, ptr %ptr, i32 0, i32 3
  %res9 = call ptr @map_Map_string_string_new()
  call void @lunite_retain(ptr %res9)
  store ptr %res9, ptr %fp8, align 8
  call void @lunite_retain(ptr %ptr)
  %tmp = load ptr, ptr %scopes, align 8
  call void @lunite_release(ptr %tmp)
  %tmp10 = load ptr, ptr %global_scope, align 8
  call void @lunite_release(ptr %tmp10)
  ret ptr %ptr
}

define void @semantic_SemanticAnalyzer_push_scope(ptr %0) {
entry:
  %new_scope = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %semantic_SemanticAnalyzer, ptr %self1, i32 0, i32 1
  %current_scope_index = load i64, ptr %fp, align 8
  %res = call ptr @semantic_Scope_new(i64 %current_scope_index)
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %new_scope, align 8
  %self2 = load ptr, ptr %self, align 8
  %fp3 = getelementptr inbounds %semantic_SemanticAnalyzer, ptr %self2, i32 0, i32 0
  %scopes = load ptr, ptr %fp3, align 8
  call void @lunite_retain(ptr %scopes)
  %new_scope4 = load ptr, ptr %new_scope, align 8
  call void @lunite_retain(ptr %new_scope4)
  call void @list_List_semantic_Scope__push(ptr %scopes, ptr %new_scope4)
  %self5 = load ptr, ptr %self, align 8
  %fp6 = getelementptr inbounds %semantic_SemanticAnalyzer, ptr %self5, i32 0, i32 1
  %self7 = load ptr, ptr %self, align 8
  %fp8 = getelementptr inbounds %semantic_SemanticAnalyzer, ptr %self7, i32 0, i32 0
  %scopes9 = load ptr, ptr %fp8, align 8
  call void @lunite_retain(ptr %scopes9)
  %res10 = call i64 @list_List_semantic_Scope__len(ptr %scopes9)
  %1 = sub i64 %res10, 1
  store i64 %1, ptr %fp6, align 8
  %tmp = load ptr, ptr %new_scope, align 8
  call void @lunite_release(ptr %tmp)
  %tmp11 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp11)
  ret void
}

define void @semantic_SemanticAnalyzer_pop_scope(ptr %0) {
entry:
  %s = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %semantic_SemanticAnalyzer, ptr %self1, i32 0, i32 1
  %current_scope_index = load i64, ptr %fp, align 8
  %1 = icmp sge i64 %current_scope_index, 0
  br i1 %1, label %then, label %else

then:                                             ; preds = %body
  %self2 = load ptr, ptr %self, align 8
  %fp3 = getelementptr inbounds %semantic_SemanticAnalyzer, ptr %self2, i32 0, i32 0
  %scopes = load ptr, ptr %fp3, align 8
  call void @lunite_retain(ptr %scopes)
  %self4 = load ptr, ptr %self, align 8
  %fp5 = getelementptr inbounds %semantic_SemanticAnalyzer, ptr %self4, i32 0, i32 1
  %current_scope_index6 = load i64, ptr %fp5, align 8
  %res = call ptr @list_List_semantic_Scope__get(ptr %scopes, i64 %current_scope_index6)
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %s, align 8
  %self7 = load ptr, ptr %self, align 8
  %fp8 = getelementptr inbounds %semantic_SemanticAnalyzer, ptr %self7, i32 0, i32 1
  %s9 = load ptr, ptr %s, align 8
  %fp10 = getelementptr inbounds %semantic_Scope, ptr %s9, i32 0, i32 1
  %parent_index = load i64, ptr %fp10, align 8
  store i64 %parent_index, ptr %fp8, align 8
  %tmp = load ptr, ptr %s, align 8
  call void @lunite_release(ptr %tmp)
  br label %cont

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else, %then
  %tmp11 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp11)
  ret void
}

define ptr @semantic_SemanticAnalyzer_lookup_symbol(ptr %0, ptr %1) {
entry:
  %sym = alloca ptr, align 8
  %s = alloca ptr, align 8
  %idx = alloca i64, align 8
  %name = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %name, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %semantic_SemanticAnalyzer, ptr %self1, i32 0, i32 1
  %current_scope_index = load i64, ptr %fp, align 8
  store i64 %current_scope_index, ptr %idx, align 8
  br label %while_cond

while_cond:                                       ; preds = %cont, %body
  %idx2 = load i64, ptr %idx, align 8
  %2 = icmp sge i64 %idx2, 0
  br i1 %2, label %while_body, label %while_end

while_body:                                       ; preds = %while_cond
  %self3 = load ptr, ptr %self, align 8
  %fp4 = getelementptr inbounds %semantic_SemanticAnalyzer, ptr %self3, i32 0, i32 0
  %scopes = load ptr, ptr %fp4, align 8
  call void @lunite_retain(ptr %scopes)
  %idx5 = load i64, ptr %idx, align 8
  %res = call ptr @list_List_semantic_Scope__get(ptr %scopes, i64 %idx5)
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %s, align 8
  %s6 = load ptr, ptr %s, align 8
  %fp7 = getelementptr inbounds %semantic_Scope, ptr %s6, i32 0, i32 0
  %symbols = load ptr, ptr %fp7, align 8
  call void @lunite_retain(ptr %symbols)
  %name8 = load ptr, ptr %name, align 8
  call void @lunite_retain(ptr %name8)
  %res9 = call ptr @map_Map_string_semantic_Symbol__get(ptr %symbols, ptr %name8)
  call void @lunite_retain(ptr %res9)
  store ptr %res9, ptr %sym, align 8
  %sym10 = load ptr, ptr %sym, align 8
  %l_cast = ptrtoint ptr %sym10 to i64
  %3 = icmp ne i64 %l_cast, 0
  br i1 %3, label %then, label %else

while_end:                                        ; preds = %while_cond
  %eptr19 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t20 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr19, i32 0, i32 0
  store i64 1, ptr %t20, align 8
  call void @lunite_retain(ptr %eptr19)
  %tmp21 = load ptr, ptr %name, align 8
  call void @lunite_release(ptr %tmp21)
  %tmp22 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp22)
  ret ptr %eptr19

then:                                             ; preds = %while_body
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 0, ptr %t, align 8
  %sym11 = load ptr, ptr %sym, align 8
  call void @lunite_retain(ptr %sym11)
  %p = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 1
  store ptr %sym11, ptr %p, align 8
  call void @lunite_retain(ptr %eptr)
  %tmp = load ptr, ptr %sym, align 8
  call void @lunite_release(ptr %tmp)
  %tmp12 = load ptr, ptr %s, align 8
  call void @lunite_release(ptr %tmp12)
  %tmp13 = load ptr, ptr %name, align 8
  call void @lunite_release(ptr %tmp13)
  %tmp14 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp14)
  ret ptr %eptr

else:                                             ; preds = %while_body
  br label %cont

cont:                                             ; preds = %else
  %s15 = load ptr, ptr %s, align 8
  %fp16 = getelementptr inbounds %semantic_Scope, ptr %s15, i32 0, i32 1
  %parent_index = load i64, ptr %fp16, align 8
  store i64 %parent_index, ptr %idx, align 8
  %tmp17 = load ptr, ptr %sym, align 8
  call void @lunite_release(ptr %tmp17)
  %tmp18 = load ptr, ptr %s, align 8
  call void @lunite_release(ptr %tmp18)
  br label %while_cond
}

define ptr @semantic_SemanticAnalyzer_analyze_program(ptr %0, ptr %1) {
entry:
  %i = alloca i64, align 8
  %items = alloca ptr, align 8
  %prog = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %prog, align 8
  %res = call ptr @list_List_semantic_TItem__new()
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %items, align 8
  store i64 0, ptr %i, align 8
  br label %while_cond

while_cond:                                       ; preds = %while_body, %body
  %prog1 = load ptr, ptr %prog, align 8
  %fp = getelementptr inbounds %ast_Program, ptr %prog1, i32 0, i32 0
  %items2 = load ptr, ptr %fp, align 8
  call void @lunite_retain(ptr %items2)
  %res3 = call i64 @list_List_ast_Item__len(ptr %items2)
  %i4 = load i64, ptr %i, align 8
  %2 = icmp sgt i64 %res3, %i4
  br i1 %2, label %while_body, label %while_end

while_body:                                       ; preds = %while_cond
  %items5 = load ptr, ptr %items, align 8
  call void @lunite_retain(ptr %items5)
  %self6 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self6)
  %prog7 = load ptr, ptr %prog, align 8
  %fp8 = getelementptr inbounds %ast_Program, ptr %prog7, i32 0, i32 0
  %items9 = load ptr, ptr %fp8, align 8
  call void @lunite_retain(ptr %items9)
  %i10 = load i64, ptr %i, align 8
  %res11 = call ptr @list_List_ast_Item__get(ptr %items9, i64 %i10)
  call void @lunite_retain(ptr %res11)
  %res12 = call ptr @semantic_SemanticAnalyzer_analyze_item(ptr %self6, ptr %res11)
  call void @lunite_retain(ptr %res12)
  call void @list_List_semantic_TItem__push(ptr %items5, ptr %res12)
  %i13 = load i64, ptr %i, align 8
  %3 = add i64 %i13, 1
  store i64 %3, ptr %i, align 8
  br label %while_cond

while_end:                                        ; preds = %while_cond
  %items14 = load ptr, ptr %items, align 8
  call void @lunite_retain(ptr %items14)
  %tmp = load ptr, ptr %items, align 8
  call void @lunite_release(ptr %tmp)
  %tmp15 = load ptr, ptr %prog, align 8
  call void @lunite_release(ptr %tmp15)
  %tmp16 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp16)
  ret ptr %items14
}

define ptr @semantic_SemanticAnalyzer_analyze_item(ptr %0, ptr %1) {
entry:
  %a = alloca ptr, align 8
  %final_alias = alloca ptr, align 8
  %alias15 = alloca ptr, align 8
  %decl13 = alloca ptr, align 8
  %decl = alloca ptr, align 8
  %item = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %item, align 8
  %item1 = load ptr, ptr %item, align 8
  %tptr = getelementptr inbounds { i64, [8 x i8] }, ptr %item1, i32 0, i32 0
  %tag = load i64, ptr %tptr, align 8
  %match = icmp eq i64 %tag, 1
  br i1 %match, label %when_body, label %when_next

when_end:                                         ; preds = %when_next59
  %tmp83 = load ptr, ptr %item, align 8
  call void @lunite_release(ptr %tmp83)
  %tmp84 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp84)
  ret ptr null

when_next:                                        ; preds = %body
  %tptr8 = getelementptr inbounds { i64, [8 x i8] }, ptr %item1, i32 0, i32 0
  %tag9 = load i64, ptr %tptr8, align 8
  %match10 = icmp eq i64 %tag9, 0
  br i1 %match10, label %when_body7, label %when_next6

when_body:                                        ; preds = %body
  %pptr = getelementptr inbounds { i64, [8 x i8] }, ptr %item1, i32 0, i32 1
  %pval = load ptr, ptr %pptr, align 8
  call void @lunite_retain(ptr %pval)
  store ptr %pval, ptr %decl, align 8
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 0, ptr %t, align 8
  %self2 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self2)
  %decl3 = load ptr, ptr %decl, align 8
  call void @lunite_retain(ptr %decl3)
  %res = call ptr @semantic_SemanticAnalyzer_analyze_function(ptr %self2, ptr %decl3)
  call void @lunite_retain(ptr %res)
  %p = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 1
  store ptr %res, ptr %p, align 8
  call void @lunite_retain(ptr %eptr)
  %tmp = load ptr, ptr %decl, align 8
  call void @lunite_release(ptr %tmp)
  %tmp4 = load ptr, ptr %item, align 8
  call void @lunite_release(ptr %tmp4)
  %tmp5 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp5)
  ret ptr %eptr

when_next6:                                       ; preds = %when_next
  br label %when_body60

when_body7:                                       ; preds = %when_next
  %pptr11 = getelementptr inbounds { i64, [8 x i8] }, ptr %item1, i32 0, i32 1
  %pval12 = load ptr, ptr %pptr11, align 8
  call void @lunite_retain(ptr %pval12)
  store ptr %pval12, ptr %decl13, align 8
  %decl14 = load ptr, ptr %decl13, align 8
  %fp = getelementptr inbounds %ast_ImportDecl, ptr %decl14, i32 0, i32 1
  %alias = load ptr, ptr %fp, align 8
  call void @lunite_retain(ptr %alias)
  store ptr %alias, ptr %alias15, align 8
  %sdata = call ptr @lunite_alloc(i64 0, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.234, i64 0, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p16 = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p16, align 8
  store i64 0, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  store ptr %sstruct, ptr %final_alias, align 8
  %alias17 = load ptr, ptr %alias15, align 8
  %tptr21 = getelementptr inbounds { i64, [8 x i8] }, ptr %alias17, i32 0, i32 0
  %tag22 = load i64, ptr %tptr21, align 8
  %match23 = icmp eq i64 %tag22, 0
  br i1 %match23, label %when_body20, label %when_next19

when_end18:                                       ; preds = %when_next28, %when_body29, %when_body20
  %self33 = load ptr, ptr %self, align 8
  %fp34 = getelementptr inbounds %semantic_SemanticAnalyzer, ptr %self33, i32 0, i32 3
  %imports = load ptr, ptr %fp34, align 8
  call void @lunite_retain(ptr %imports)
  %final_alias35 = load ptr, ptr %final_alias, align 8
  call void @lunite_retain(ptr %final_alias35)
  %decl36 = load ptr, ptr %decl13, align 8
  %fp37 = getelementptr inbounds %ast_ImportDecl, ptr %decl36, i32 0, i32 0
  %path38 = load ptr, ptr %fp37, align 8
  call void @lunite_retain(ptr %path38)
  call void @map_Map_string_string_put(ptr %imports, ptr %final_alias35, ptr %path38)
  %eptr39 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t40 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr39, i32 0, i32 0
  store i64 4, ptr %t40, align 8
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%ast_EnumDecl, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp41 = getelementptr inbounds %ast_EnumDecl, ptr %ptr, i32 0, i32 0
  %sdata42 = call ptr @lunite_alloc(i64 6, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata42, ptr align 1 @slit.235, i64 6, i1 false)
  %sstruct43 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p44 = getelementptr inbounds { ptr, i64 }, ptr %sstruct43, i32 0, i32 0
  %l45 = getelementptr inbounds { ptr, i64 }, ptr %sstruct43, i32 0, i32 1
  store ptr %sdata42, ptr %p44, align 8
  store i64 6, ptr %l45, align 8
  call void @lunite_retain(ptr %sstruct43)
  store ptr %sstruct43, ptr %fp41, align 8
  %fp46 = getelementptr inbounds %ast_EnumDecl, ptr %ptr, i32 0, i32 1
  %res47 = call ptr @list_List_string_new()
  call void @lunite_retain(ptr %res47)
  store ptr %res47, ptr %fp46, align 8
  %fp48 = getelementptr inbounds %ast_EnumDecl, ptr %ptr, i32 0, i32 2
  %res49 = call ptr @list_List_ast_EnumVariant__new()
  call void @lunite_retain(ptr %res49)
  store ptr %res49, ptr %fp48, align 8
  %fp50 = getelementptr inbounds %ast_EnumDecl, ptr %ptr, i32 0, i32 3
  %eptr51 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t52 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr51, i32 0, i32 0
  store i64 1, ptr %t52, align 8
  call void @lunite_retain(ptr %eptr51)
  store ptr %eptr51, ptr %fp50, align 8
  call void @lunite_retain(ptr %ptr)
  %p53 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr39, i32 0, i32 1
  store ptr %ptr, ptr %p53, align 8
  call void @lunite_retain(ptr %eptr39)
  %tmp54 = load ptr, ptr %final_alias, align 8
  call void @lunite_release(ptr %tmp54)
  %tmp55 = load ptr, ptr %alias15, align 8
  call void @lunite_release(ptr %tmp55)
  %tmp56 = load ptr, ptr %decl13, align 8
  call void @lunite_release(ptr %tmp56)
  %tmp57 = load ptr, ptr %item, align 8
  call void @lunite_release(ptr %tmp57)
  %tmp58 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp58)
  ret ptr %eptr39

when_next19:                                      ; preds = %when_body7
  br label %when_body29

when_body20:                                      ; preds = %when_body7
  %pptr24 = getelementptr inbounds { i64, [8 x i8] }, ptr %alias17, i32 0, i32 1
  %pval25 = load ptr, ptr %pptr24, align 8
  call void @lunite_retain(ptr %pval25)
  store ptr %pval25, ptr %a, align 8
  %a26 = load ptr, ptr %a, align 8
  %old = load ptr, ptr %final_alias, align 8
  call void @lunite_retain(ptr %a26)
  store ptr %a26, ptr %final_alias, align 8
  call void @lunite_release(ptr %old)
  %tmp27 = load ptr, ptr %a, align 8
  call void @lunite_release(ptr %tmp27)
  br label %when_end18

when_next28:                                      ; No predecessors!
  br label %when_end18

when_body29:                                      ; preds = %when_next19
  %decl30 = load ptr, ptr %decl13, align 8
  %fp31 = getelementptr inbounds %ast_ImportDecl, ptr %decl30, i32 0, i32 0
  %path = load ptr, ptr %fp31, align 8
  %old32 = load ptr, ptr %final_alias, align 8
  call void @lunite_retain(ptr %path)
  store ptr %path, ptr %final_alias, align 8
  call void @lunite_release(ptr %old32)
  br label %when_end18

when_next59:                                      ; No predecessors!
  br label %when_end

when_body60:                                      ; preds = %when_next6
  %sdata61 = call ptr @lunite_alloc(i64 57, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata61, ptr align 1 @slit.236, i64 57, i1 false)
  %sstruct62 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p63 = getelementptr inbounds { ptr, i64 }, ptr %sstruct62, i32 0, i32 0
  %l64 = getelementptr inbounds { ptr, i64 }, ptr %sstruct62, i32 0, i32 1
  store ptr %sdata61, ptr %p63, align 8
  store i64 57, ptr %l64, align 8
  call void @lunite_retain(ptr %sstruct62)
  call void @string_print(ptr %sstruct62)
  %eptr65 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t66 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr65, i32 0, i32 0
  store i64 4, ptr %t66, align 8
  %ptr67 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%ast_EnumDecl, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp68 = getelementptr inbounds %ast_EnumDecl, ptr %ptr67, i32 0, i32 0
  %sdata69 = call ptr @lunite_alloc(i64 5, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata69, ptr align 1 @slit.237, i64 5, i1 false)
  %sstruct70 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p71 = getelementptr inbounds { ptr, i64 }, ptr %sstruct70, i32 0, i32 0
  %l72 = getelementptr inbounds { ptr, i64 }, ptr %sstruct70, i32 0, i32 1
  store ptr %sdata69, ptr %p71, align 8
  store i64 5, ptr %l72, align 8
  call void @lunite_retain(ptr %sstruct70)
  store ptr %sstruct70, ptr %fp68, align 8
  %fp73 = getelementptr inbounds %ast_EnumDecl, ptr %ptr67, i32 0, i32 1
  %res74 = call ptr @list_List_string_new()
  call void @lunite_retain(ptr %res74)
  store ptr %res74, ptr %fp73, align 8
  %fp75 = getelementptr inbounds %ast_EnumDecl, ptr %ptr67, i32 0, i32 2
  %res76 = call ptr @list_List_ast_EnumVariant__new()
  call void @lunite_retain(ptr %res76)
  store ptr %res76, ptr %fp75, align 8
  %fp77 = getelementptr inbounds %ast_EnumDecl, ptr %ptr67, i32 0, i32 3
  %eptr78 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t79 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr78, i32 0, i32 0
  store i64 1, ptr %t79, align 8
  call void @lunite_retain(ptr %eptr78)
  store ptr %eptr78, ptr %fp77, align 8
  call void @lunite_retain(ptr %ptr67)
  %p80 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr65, i32 0, i32 1
  store ptr %ptr67, ptr %p80, align 8
  call void @lunite_retain(ptr %eptr65)
  %tmp81 = load ptr, ptr %item, align 8
  call void @lunite_release(ptr %tmp81)
  %tmp82 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp82)
  ret ptr %eptr65
}

define ptr @semantic_SemanticAnalyzer_check_binary_op(ptr %0, ptr %1, ptr %2, ptr %3) {
entry:
  %right = alloca ptr, align 8
  %op = alloca ptr, align 8
  %left = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %left, align 8
  call void @lunite_retain(ptr %2)
  store ptr %2, ptr %op, align 8
  call void @lunite_retain(ptr %3)
  store ptr %3, ptr %right, align 8
  %op1 = load ptr, ptr %op, align 8
  %tptr = getelementptr inbounds { i64, [8 x i8] }, ptr %op1, i32 0, i32 0
  %tag = load i64, ptr %tptr, align 8
  %match = icmp eq i64 %tag, 12
  br i1 %match, label %when_body, label %when_next

when_end:                                         ; preds = %when_next60
  %tmp67 = load ptr, ptr %right, align 8
  call void @lunite_release(ptr %tmp67)
  %tmp68 = load ptr, ptr %op, align 8
  call void @lunite_release(ptr %tmp68)
  %tmp69 = load ptr, ptr %left, align 8
  call void @lunite_release(ptr %tmp69)
  %tmp70 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp70)
  ret ptr null

when_next:                                        ; preds = %body
  %tptr7 = getelementptr inbounds { i64, [8 x i8] }, ptr %op1, i32 0, i32 0
  %tag8 = load i64, ptr %tptr7, align 8
  %match9 = icmp eq i64 %tag8, 14
  br i1 %match9, label %when_body6, label %when_next5

when_body:                                        ; preds = %body
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 2, ptr %t, align 8
  call void @lunite_retain(ptr %eptr)
  %tmp = load ptr, ptr %right, align 8
  call void @lunite_release(ptr %tmp)
  %tmp2 = load ptr, ptr %op, align 8
  call void @lunite_release(ptr %tmp2)
  %tmp3 = load ptr, ptr %left, align 8
  call void @lunite_release(ptr %tmp3)
  %tmp4 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp4)
  ret ptr %eptr

when_next5:                                       ; preds = %when_next
  %tptr18 = getelementptr inbounds { i64, [8 x i8] }, ptr %op1, i32 0, i32 0
  %tag19 = load i64, ptr %tptr18, align 8
  %match20 = icmp eq i64 %tag19, 15
  br i1 %match20, label %when_body17, label %when_next16

when_body6:                                       ; preds = %when_next
  %eptr10 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t11 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr10, i32 0, i32 0
  store i64 2, ptr %t11, align 8
  call void @lunite_retain(ptr %eptr10)
  %tmp12 = load ptr, ptr %right, align 8
  call void @lunite_release(ptr %tmp12)
  %tmp13 = load ptr, ptr %op, align 8
  call void @lunite_release(ptr %tmp13)
  %tmp14 = load ptr, ptr %left, align 8
  call void @lunite_release(ptr %tmp14)
  %tmp15 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp15)
  ret ptr %eptr10

when_next16:                                      ; preds = %when_next5
  %tptr29 = getelementptr inbounds { i64, [8 x i8] }, ptr %op1, i32 0, i32 0
  %tag30 = load i64, ptr %tptr29, align 8
  %match31 = icmp eq i64 %tag30, 17
  br i1 %match31, label %when_body28, label %when_next27

when_body17:                                      ; preds = %when_next5
  %eptr21 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t22 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr21, i32 0, i32 0
  store i64 2, ptr %t22, align 8
  call void @lunite_retain(ptr %eptr21)
  %tmp23 = load ptr, ptr %right, align 8
  call void @lunite_release(ptr %tmp23)
  %tmp24 = load ptr, ptr %op, align 8
  call void @lunite_release(ptr %tmp24)
  %tmp25 = load ptr, ptr %left, align 8
  call void @lunite_release(ptr %tmp25)
  %tmp26 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp26)
  ret ptr %eptr21

when_next27:                                      ; preds = %when_next16
  %tptr40 = getelementptr inbounds { i64, [8 x i8] }, ptr %op1, i32 0, i32 0
  %tag41 = load i64, ptr %tptr40, align 8
  %match42 = icmp eq i64 %tag41, 16
  br i1 %match42, label %when_body39, label %when_next38

when_body28:                                      ; preds = %when_next16
  %eptr32 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t33 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr32, i32 0, i32 0
  store i64 2, ptr %t33, align 8
  call void @lunite_retain(ptr %eptr32)
  %tmp34 = load ptr, ptr %right, align 8
  call void @lunite_release(ptr %tmp34)
  %tmp35 = load ptr, ptr %op, align 8
  call void @lunite_release(ptr %tmp35)
  %tmp36 = load ptr, ptr %left, align 8
  call void @lunite_release(ptr %tmp36)
  %tmp37 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp37)
  ret ptr %eptr32

when_next38:                                      ; preds = %when_next27
  %tptr51 = getelementptr inbounds { i64, [8 x i8] }, ptr %op1, i32 0, i32 0
  %tag52 = load i64, ptr %tptr51, align 8
  %match53 = icmp eq i64 %tag52, 18
  br i1 %match53, label %when_body50, label %when_next49

when_body39:                                      ; preds = %when_next27
  %eptr43 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t44 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr43, i32 0, i32 0
  store i64 2, ptr %t44, align 8
  call void @lunite_retain(ptr %eptr43)
  %tmp45 = load ptr, ptr %right, align 8
  call void @lunite_release(ptr %tmp45)
  %tmp46 = load ptr, ptr %op, align 8
  call void @lunite_release(ptr %tmp46)
  %tmp47 = load ptr, ptr %left, align 8
  call void @lunite_release(ptr %tmp47)
  %tmp48 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp48)
  ret ptr %eptr43

when_next49:                                      ; preds = %when_next38
  br label %when_body61

when_body50:                                      ; preds = %when_next38
  %eptr54 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t55 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr54, i32 0, i32 0
  store i64 2, ptr %t55, align 8
  call void @lunite_retain(ptr %eptr54)
  %tmp56 = load ptr, ptr %right, align 8
  call void @lunite_release(ptr %tmp56)
  %tmp57 = load ptr, ptr %op, align 8
  call void @lunite_release(ptr %tmp57)
  %tmp58 = load ptr, ptr %left, align 8
  call void @lunite_release(ptr %tmp58)
  %tmp59 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp59)
  ret ptr %eptr54

when_next60:                                      ; No predecessors!
  br label %when_end

when_body61:                                      ; preds = %when_next49
  %left62 = load ptr, ptr %left, align 8
  call void @lunite_retain(ptr %left62)
  %tmp63 = load ptr, ptr %right, align 8
  call void @lunite_release(ptr %tmp63)
  %tmp64 = load ptr, ptr %op, align 8
  call void @lunite_release(ptr %tmp64)
  %tmp65 = load ptr, ptr %left, align 8
  call void @lunite_release(ptr %tmp65)
  %tmp66 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp66)
  ret ptr %left62
}

define ptr @semantic_SemanticAnalyzer_analyze_function(ptr %0, ptr %1) {
entry:
  %body82 = alloca ptr, align 8
  %p50 = alloca ptr, align 8
  %i36 = alloca i64, align 8
  %sym_obj = alloca ptr, align 8
  %i = alloca i64, align 8
  %params_types = alloca ptr, align 8
  %decl = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %decl, align 8
  %res = call ptr @list_List_ast_Type__new()
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %params_types, align 8
  store i64 0, ptr %i, align 8
  br label %while_cond

while_cond:                                       ; preds = %while_body, %body
  %decl1 = load ptr, ptr %decl, align 8
  %fp = getelementptr inbounds %ast_FunctionDecl, ptr %decl1, i32 0, i32 2
  %params = load ptr, ptr %fp, align 8
  call void @lunite_retain(ptr %params)
  %res2 = call i64 @list_List_ast_Param__len(ptr %params)
  %i3 = load i64, ptr %i, align 8
  %2 = icmp sgt i64 %res2, %i3
  br i1 %2, label %while_body, label %while_end

while_body:                                       ; preds = %while_cond
  %params_types4 = load ptr, ptr %params_types, align 8
  call void @lunite_retain(ptr %params_types4)
  %decl5 = load ptr, ptr %decl, align 8
  %fp6 = getelementptr inbounds %ast_FunctionDecl, ptr %decl5, i32 0, i32 2
  %params7 = load ptr, ptr %fp6, align 8
  call void @lunite_retain(ptr %params7)
  %i8 = load i64, ptr %i, align 8
  %res9 = call ptr @list_List_ast_Param__get(ptr %params7, i64 %i8)
  %fp10 = getelementptr inbounds %ast_Param, ptr %res9, i32 0, i32 1
  %typ = load ptr, ptr %fp10, align 8
  call void @lunite_retain(ptr %typ)
  call void @list_List_ast_Type__push(ptr %params_types4, ptr %typ)
  %i11 = load i64, ptr %i, align 8
  %3 = add i64 %i11, 1
  store i64 %3, ptr %i, align 8
  br label %while_cond

while_end:                                        ; preds = %while_cond
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%semantic_Symbol, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp12 = getelementptr inbounds %semantic_Symbol, ptr %ptr, i32 0, i32 0
  %decl13 = load ptr, ptr %decl, align 8
  %fp14 = getelementptr inbounds %ast_FunctionDecl, ptr %decl13, i32 0, i32 0
  %name = load ptr, ptr %fp14, align 8
  call void @lunite_retain(ptr %name)
  store ptr %name, ptr %fp12, align 8
  %fp15 = getelementptr inbounds %semantic_Symbol, ptr %ptr, i32 0, i32 1
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 9, ptr %t, align 8
  %ptr16 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%ast_FunctionTypePayload, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp17 = getelementptr inbounds %ast_FunctionTypePayload, ptr %ptr16, i32 0, i32 0
  %params_types18 = load ptr, ptr %params_types, align 8
  call void @lunite_retain(ptr %params_types18)
  store ptr %params_types18, ptr %fp17, align 8
  %fp19 = getelementptr inbounds %ast_FunctionTypePayload, ptr %ptr16, i32 0, i32 1
  %decl20 = load ptr, ptr %decl, align 8
  %fp21 = getelementptr inbounds %ast_FunctionDecl, ptr %decl20, i32 0, i32 3
  store ptr %fp21, ptr %fp19, align 8
  call void @lunite_retain(ptr %ptr16)
  %p = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 1
  store ptr %ptr16, ptr %p, align 8
  call void @lunite_retain(ptr %eptr)
  store ptr %eptr, ptr %fp15, align 8
  %fp22 = getelementptr inbounds %semantic_Symbol, ptr %ptr, i32 0, i32 2
  store i1 false, ptr %fp22, align 1
  %fp23 = getelementptr inbounds %semantic_Symbol, ptr %ptr, i32 0, i32 3
  %decl24 = load ptr, ptr %decl, align 8
  %fp25 = getelementptr inbounds %ast_FunctionDecl, ptr %decl24, i32 0, i32 5
  %visibility = load ptr, ptr %fp25, align 8
  call void @lunite_retain(ptr %visibility)
  store ptr %visibility, ptr %fp23, align 8
  call void @lunite_retain(ptr %ptr)
  store ptr %ptr, ptr %sym_obj, align 8
  %self26 = load ptr, ptr %self, align 8
  %fp27 = getelementptr inbounds %semantic_SemanticAnalyzer, ptr %self26, i32 0, i32 0
  %scopes = load ptr, ptr %fp27, align 8
  call void @lunite_retain(ptr %scopes)
  %self28 = load ptr, ptr %self, align 8
  %fp29 = getelementptr inbounds %semantic_SemanticAnalyzer, ptr %self28, i32 0, i32 1
  %current_scope_index = load i64, ptr %fp29, align 8
  %res30 = call ptr @list_List_semantic_Scope__get(ptr %scopes, i64 %current_scope_index)
  call void @lunite_retain(ptr %res30)
  %decl31 = load ptr, ptr %decl, align 8
  %fp32 = getelementptr inbounds %ast_FunctionDecl, ptr %decl31, i32 0, i32 0
  %name33 = load ptr, ptr %fp32, align 8
  call void @lunite_retain(ptr %name33)
  %sym_obj34 = load ptr, ptr %sym_obj, align 8
  call void @lunite_retain(ptr %sym_obj34)
  call void @semantic_Scope_insert(ptr %res30, ptr %name33, ptr %sym_obj34)
  %self35 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self35)
  call void @semantic_SemanticAnalyzer_push_scope(ptr %self35)
  store i64 0, ptr %i36, align 8
  br label %while_cond37

while_cond37:                                     ; preds = %while_body38, %while_end
  %decl40 = load ptr, ptr %decl, align 8
  %fp41 = getelementptr inbounds %ast_FunctionDecl, ptr %decl40, i32 0, i32 2
  %params42 = load ptr, ptr %fp41, align 8
  call void @lunite_retain(ptr %params42)
  %res43 = call i64 @list_List_ast_Param__len(ptr %params42)
  %i44 = load i64, ptr %i36, align 8
  %4 = icmp sgt i64 %res43, %i44
  br i1 %4, label %while_body38, label %while_end39

while_body38:                                     ; preds = %while_cond37
  %decl45 = load ptr, ptr %decl, align 8
  %fp46 = getelementptr inbounds %ast_FunctionDecl, ptr %decl45, i32 0, i32 2
  %params47 = load ptr, ptr %fp46, align 8
  call void @lunite_retain(ptr %params47)
  %i48 = load i64, ptr %i36, align 8
  %res49 = call ptr @list_List_ast_Param__get(ptr %params47, i64 %i48)
  call void @lunite_retain(ptr %res49)
  store ptr %res49, ptr %p50, align 8
  %self51 = load ptr, ptr %self, align 8
  %fp52 = getelementptr inbounds %semantic_SemanticAnalyzer, ptr %self51, i32 0, i32 0
  %scopes53 = load ptr, ptr %fp52, align 8
  call void @lunite_retain(ptr %scopes53)
  %self54 = load ptr, ptr %self, align 8
  %fp55 = getelementptr inbounds %semantic_SemanticAnalyzer, ptr %self54, i32 0, i32 1
  %current_scope_index56 = load i64, ptr %fp55, align 8
  %res57 = call ptr @list_List_semantic_Scope__get(ptr %scopes53, i64 %current_scope_index56)
  call void @lunite_retain(ptr %res57)
  %p58 = load ptr, ptr %p50, align 8
  %fp59 = getelementptr inbounds %ast_Param, ptr %p58, i32 0, i32 0
  %name60 = load ptr, ptr %fp59, align 8
  call void @lunite_retain(ptr %name60)
  %ptr61 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%semantic_Symbol, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp62 = getelementptr inbounds %semantic_Symbol, ptr %ptr61, i32 0, i32 0
  %p63 = load ptr, ptr %p50, align 8
  %fp64 = getelementptr inbounds %ast_Param, ptr %p63, i32 0, i32 0
  %name65 = load ptr, ptr %fp64, align 8
  call void @lunite_retain(ptr %name65)
  store ptr %name65, ptr %fp62, align 8
  %fp66 = getelementptr inbounds %semantic_Symbol, ptr %ptr61, i32 0, i32 1
  %p67 = load ptr, ptr %p50, align 8
  %fp68 = getelementptr inbounds %ast_Param, ptr %p67, i32 0, i32 1
  %typ69 = load ptr, ptr %fp68, align 8
  call void @lunite_retain(ptr %typ69)
  store ptr %typ69, ptr %fp66, align 8
  %fp70 = getelementptr inbounds %semantic_Symbol, ptr %ptr61, i32 0, i32 2
  %p71 = load ptr, ptr %p50, align 8
  %fp72 = getelementptr inbounds %ast_Param, ptr %p71, i32 0, i32 2
  %is_mut = load i1, ptr %fp72, align 1
  store i1 %is_mut, ptr %fp70, align 1
  %fp73 = getelementptr inbounds %semantic_Symbol, ptr %ptr61, i32 0, i32 3
  %eptr74 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t75 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr74, i32 0, i32 0
  store i64 1, ptr %t75, align 8
  call void @lunite_retain(ptr %eptr74)
  store ptr %eptr74, ptr %fp73, align 8
  call void @lunite_retain(ptr %ptr61)
  call void @semantic_Scope_insert(ptr %res57, ptr %name60, ptr %ptr61)
  %i76 = load i64, ptr %i36, align 8
  %5 = add i64 %i76, 1
  store i64 %5, ptr %i36, align 8
  %tmp = load ptr, ptr %p50, align 8
  call void @lunite_release(ptr %tmp)
  br label %while_cond37

while_end39:                                      ; preds = %while_cond37
  %self77 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self77)
  %decl78 = load ptr, ptr %decl, align 8
  %fp79 = getelementptr inbounds %ast_FunctionDecl, ptr %decl78, i32 0, i32 4
  %body80 = load ptr, ptr %fp79, align 8
  call void @lunite_retain(ptr %body80)
  %res81 = call ptr @semantic_SemanticAnalyzer_analyze_block(ptr %self77, ptr %body80)
  call void @lunite_retain(ptr %res81)
  store ptr %res81, ptr %body82, align 8
  %self83 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self83)
  call void @semantic_SemanticAnalyzer_pop_scope(ptr %self83)
  %ptr84 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%semantic_TFunctionDecl, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp85 = getelementptr inbounds %semantic_TFunctionDecl, ptr %ptr84, i32 0, i32 0
  %decl86 = load ptr, ptr %decl, align 8
  %fp87 = getelementptr inbounds %ast_FunctionDecl, ptr %decl86, i32 0, i32 0
  %name88 = load ptr, ptr %fp87, align 8
  call void @lunite_retain(ptr %name88)
  store ptr %name88, ptr %fp85, align 8
  %fp89 = getelementptr inbounds %semantic_TFunctionDecl, ptr %ptr84, i32 0, i32 1
  %decl90 = load ptr, ptr %decl, align 8
  %fp91 = getelementptr inbounds %ast_FunctionDecl, ptr %decl90, i32 0, i32 2
  %params92 = load ptr, ptr %fp91, align 8
  call void @lunite_retain(ptr %params92)
  store ptr %params92, ptr %fp89, align 8
  %fp93 = getelementptr inbounds %semantic_TFunctionDecl, ptr %ptr84, i32 0, i32 2
  %decl94 = load ptr, ptr %decl, align 8
  %fp95 = getelementptr inbounds %ast_FunctionDecl, ptr %decl94, i32 0, i32 3
  %return_type = load ptr, ptr %fp95, align 8
  call void @lunite_retain(ptr %return_type)
  store ptr %return_type, ptr %fp93, align 8
  %fp96 = getelementptr inbounds %semantic_TFunctionDecl, ptr %ptr84, i32 0, i32 3
  %body97 = load ptr, ptr %body82, align 8
  call void @lunite_retain(ptr %body97)
  store ptr %body97, ptr %fp96, align 8
  %fp98 = getelementptr inbounds %semantic_TFunctionDecl, ptr %ptr84, i32 0, i32 4
  %decl99 = load ptr, ptr %decl, align 8
  %fp100 = getelementptr inbounds %ast_FunctionDecl, ptr %decl99, i32 0, i32 5
  %visibility101 = load ptr, ptr %fp100, align 8
  call void @lunite_retain(ptr %visibility101)
  store ptr %visibility101, ptr %fp98, align 8
  %fp102 = getelementptr inbounds %semantic_TFunctionDecl, ptr %ptr84, i32 0, i32 5
  %decl103 = load ptr, ptr %decl, align 8
  %fp104 = getelementptr inbounds %ast_FunctionDecl, ptr %decl103, i32 0, i32 6
  %is_pure = load i1, ptr %fp104, align 1
  store i1 %is_pure, ptr %fp102, align 1
  call void @lunite_retain(ptr %ptr84)
  %tmp105 = load ptr, ptr %body82, align 8
  call void @lunite_release(ptr %tmp105)
  %tmp106 = load ptr, ptr %sym_obj, align 8
  call void @lunite_release(ptr %tmp106)
  %tmp107 = load ptr, ptr %params_types, align 8
  call void @lunite_release(ptr %tmp107)
  %tmp108 = load ptr, ptr %decl, align 8
  call void @lunite_release(ptr %tmp108)
  %tmp109 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp109)
  ret ptr %ptr84
}

define ptr @semantic_SemanticAnalyzer_analyze_block(ptr %0, ptr %1) {
entry:
  %i = alloca i64, align 8
  %stmts = alloca ptr, align 8
  %block = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %block, align 8
  %res = call ptr @list_List_semantic_TStatement__new()
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %stmts, align 8
  store i64 0, ptr %i, align 8
  br label %while_cond

while_cond:                                       ; preds = %while_body, %body
  %block1 = load ptr, ptr %block, align 8
  %fp = getelementptr inbounds %ast_Block, ptr %block1, i32 0, i32 0
  %statements = load ptr, ptr %fp, align 8
  call void @lunite_retain(ptr %statements)
  %res2 = call i64 @list_List_ast_Statement__len(ptr %statements)
  %i3 = load i64, ptr %i, align 8
  %2 = icmp sgt i64 %res2, %i3
  br i1 %2, label %while_body, label %while_end

while_body:                                       ; preds = %while_cond
  %stmts4 = load ptr, ptr %stmts, align 8
  call void @lunite_retain(ptr %stmts4)
  %self5 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self5)
  %block6 = load ptr, ptr %block, align 8
  %fp7 = getelementptr inbounds %ast_Block, ptr %block6, i32 0, i32 0
  %statements8 = load ptr, ptr %fp7, align 8
  call void @lunite_retain(ptr %statements8)
  %i9 = load i64, ptr %i, align 8
  %res10 = call ptr @list_List_ast_Statement__get(ptr %statements8, i64 %i9)
  call void @lunite_retain(ptr %res10)
  %res11 = call ptr @semantic_SemanticAnalyzer_analyze_statement(ptr %self5, ptr %res10)
  call void @lunite_retain(ptr %res11)
  call void @list_List_semantic_TStatement__push(ptr %stmts4, ptr %res11)
  %i12 = load i64, ptr %i, align 8
  %3 = add i64 %i12, 1
  store i64 %3, ptr %i, align 8
  br label %while_cond

while_end:                                        ; preds = %while_cond
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%semantic_TBlock, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp13 = getelementptr inbounds %semantic_TBlock, ptr %ptr, i32 0, i32 0
  %stmts14 = load ptr, ptr %stmts, align 8
  call void @lunite_retain(ptr %stmts14)
  store ptr %stmts14, ptr %fp13, align 8
  call void @lunite_retain(ptr %ptr)
  %tmp = load ptr, ptr %stmts, align 8
  call void @lunite_release(ptr %tmp)
  %tmp15 = load ptr, ptr %block, align 8
  call void @lunite_release(ptr %tmp15)
  %tmp16 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp16)
  ret ptr %ptr
}

define ptr @semantic_SemanticAnalyzer_analyze_statement(ptr %0, ptr %1) {
entry:
  %expr = alloca ptr, align 8
  %v102 = alloca ptr, align 8
  %t_val92 = alloca ptr, align 8
  %val = alloca ptr, align 8
  %sym = alloca ptr, align 8
  %t41 = alloca ptr, align 8
  %tv = alloca ptr, align 8
  %v = alloca ptr, align 8
  %var_typ = alloca ptr, align 8
  %t_val = alloca ptr, align 8
  %type_name9 = alloca ptr, align 8
  %value6 = alloca ptr, align 8
  %name3 = alloca ptr, align 8
  %payload = alloca ptr, align 8
  %stmt = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %stmt, align 8
  %stmt1 = load ptr, ptr %stmt, align 8
  %tptr = getelementptr inbounds { i64, [8 x i8] }, ptr %stmt1, i32 0, i32 0
  %tag = load i64, ptr %tptr, align 8
  %match = icmp eq i64 %tag, 0
  br i1 %match, label %when_body, label %when_next

when_end:                                         ; preds = %when_next137
  %tmp144 = load ptr, ptr %stmt, align 8
  call void @lunite_release(ptr %tmp144)
  %tmp145 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp145)
  ret ptr null

when_next:                                        ; preds = %body
  %tptr85 = getelementptr inbounds { i64, [8 x i8] }, ptr %stmt1, i32 0, i32 0
  %tag86 = load i64, ptr %tptr85, align 8
  %match87 = icmp eq i64 %tag86, 2
  br i1 %match87, label %when_body84, label %when_next83

when_body:                                        ; preds = %body
  %pptr = getelementptr inbounds { i64, [8 x i8] }, ptr %stmt1, i32 0, i32 1
  %pval = load ptr, ptr %pptr, align 8
  call void @lunite_retain(ptr %pval)
  store ptr %pval, ptr %payload, align 8
  %payload2 = load ptr, ptr %payload, align 8
  %fp = getelementptr inbounds %ast_LetStatementPayload, ptr %payload2, i32 0, i32 0
  %name = load ptr, ptr %fp, align 8
  call void @lunite_retain(ptr %name)
  store ptr %name, ptr %name3, align 8
  %payload4 = load ptr, ptr %payload, align 8
  %fp5 = getelementptr inbounds %ast_LetStatementPayload, ptr %payload4, i32 0, i32 3
  %value = load ptr, ptr %fp5, align 8
  call void @lunite_retain(ptr %value)
  store ptr %value, ptr %value6, align 8
  %payload7 = load ptr, ptr %payload, align 8
  %fp8 = getelementptr inbounds %ast_LetStatementPayload, ptr %payload7, i32 0, i32 2
  %type_name = load ptr, ptr %fp8, align 8
  call void @lunite_retain(ptr %type_name)
  store ptr %type_name, ptr %type_name9, align 8
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 1, ptr %t, align 8
  call void @lunite_retain(ptr %eptr)
  store ptr %eptr, ptr %t_val, align 8
  %eptr10 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t11 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr10, i32 0, i32 0
  store i64 4, ptr %t11, align 8
  call void @lunite_retain(ptr %eptr10)
  store ptr %eptr10, ptr %var_typ, align 8
  %value12 = load ptr, ptr %value6, align 8
  %tptr16 = getelementptr inbounds { i64, [8 x i8] }, ptr %value12, i32 0, i32 0
  %tag17 = load i64, ptr %tptr16, align 8
  %match18 = icmp eq i64 %tag17, 0
  br i1 %match18, label %when_body15, label %when_next14

when_end13:                                       ; preds = %when_next30, %when_body31, %when_body15
  %type_name32 = load ptr, ptr %type_name9, align 8
  %tptr36 = getelementptr inbounds { i64, [8 x i8] }, ptr %type_name32, i32 0, i32 0
  %tag37 = load i64, ptr %tptr36, align 8
  %match38 = icmp eq i64 %tag37, 0
  br i1 %match38, label %when_body35, label %when_next34

when_next14:                                      ; preds = %when_body
  br label %when_body31

when_body15:                                      ; preds = %when_body
  %pptr19 = getelementptr inbounds { i64, [8 x i8] }, ptr %value12, i32 0, i32 1
  %pval20 = load ptr, ptr %pptr19, align 8
  call void @lunite_retain(ptr %pval20)
  store ptr %pval20, ptr %v, align 8
  %self21 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self21)
  %v22 = load ptr, ptr %v, align 8
  call void @lunite_retain(ptr %v22)
  %res = call ptr @semantic_SemanticAnalyzer_analyze_expression(ptr %self21, ptr %v22)
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %tv, align 8
  %eptr23 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t24 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr23, i32 0, i32 0
  store i64 0, ptr %t24, align 8
  %tv25 = load ptr, ptr %tv, align 8
  call void @lunite_retain(ptr %tv25)
  %p = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr23, i32 0, i32 1
  store ptr %tv25, ptr %p, align 8
  %old = load ptr, ptr %t_val, align 8
  call void @lunite_retain(ptr %eptr23)
  store ptr %eptr23, ptr %t_val, align 8
  call void @lunite_release(ptr %old)
  %tv26 = load ptr, ptr %tv, align 8
  %fp27 = getelementptr inbounds %semantic_TExpression, ptr %tv26, i32 0, i32 1
  %typ = load ptr, ptr %fp27, align 8
  %old28 = load ptr, ptr %var_typ, align 8
  call void @lunite_retain(ptr %typ)
  store ptr %typ, ptr %var_typ, align 8
  call void @lunite_release(ptr %old28)
  %tmp = load ptr, ptr %tv, align 8
  call void @lunite_release(ptr %tmp)
  %tmp29 = load ptr, ptr %v, align 8
  call void @lunite_release(ptr %tmp29)
  br label %when_end13

when_next30:                                      ; No predecessors!
  br label %when_end13

when_body31:                                      ; preds = %when_next14
  br label %when_end13

when_end33:                                       ; preds = %when_next45, %when_body46, %when_body35
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%semantic_Symbol, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp47 = getelementptr inbounds %semantic_Symbol, ptr %ptr, i32 0, i32 0
  %name48 = load ptr, ptr %name3, align 8
  call void @lunite_retain(ptr %name48)
  store ptr %name48, ptr %fp47, align 8
  %fp49 = getelementptr inbounds %semantic_Symbol, ptr %ptr, i32 0, i32 1
  %var_typ50 = load ptr, ptr %var_typ, align 8
  call void @lunite_retain(ptr %var_typ50)
  store ptr %var_typ50, ptr %fp49, align 8
  %fp51 = getelementptr inbounds %semantic_Symbol, ptr %ptr, i32 0, i32 2
  %payload52 = load ptr, ptr %payload, align 8
  %fp53 = getelementptr inbounds %ast_LetStatementPayload, ptr %payload52, i32 0, i32 1
  %is_mutable = load i1, ptr %fp53, align 1
  store i1 %is_mutable, ptr %fp51, align 1
  %fp54 = getelementptr inbounds %semantic_Symbol, ptr %ptr, i32 0, i32 3
  %eptr55 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [1 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t56 = getelementptr inbounds { i64, [1 x i8] }, ptr %eptr55, i32 0, i32 0
  store i64 1, ptr %t56, align 8
  call void @lunite_retain(ptr %eptr55)
  store ptr %eptr55, ptr %fp54, align 8
  call void @lunite_retain(ptr %ptr)
  store ptr %ptr, ptr %sym, align 8
  %self57 = load ptr, ptr %self, align 8
  %fp58 = getelementptr inbounds %semantic_SemanticAnalyzer, ptr %self57, i32 0, i32 0
  %scopes = load ptr, ptr %fp58, align 8
  call void @lunite_retain(ptr %scopes)
  %self59 = load ptr, ptr %self, align 8
  %fp60 = getelementptr inbounds %semantic_SemanticAnalyzer, ptr %self59, i32 0, i32 1
  %current_scope_index = load i64, ptr %fp60, align 8
  %res61 = call ptr @list_List_semantic_Scope__get(ptr %scopes, i64 %current_scope_index)
  call void @lunite_retain(ptr %res61)
  %name62 = load ptr, ptr %name3, align 8
  call void @lunite_retain(ptr %name62)
  %sym63 = load ptr, ptr %sym, align 8
  call void @lunite_retain(ptr %sym63)
  call void @semantic_Scope_insert(ptr %res61, ptr %name62, ptr %sym63)
  %eptr64 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t65 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr64, i32 0, i32 0
  store i64 0, ptr %t65, align 8
  %ptr66 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%semantic_TLetStatementPayload, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp67 = getelementptr inbounds %semantic_TLetStatementPayload, ptr %ptr66, i32 0, i32 0
  %name68 = load ptr, ptr %name3, align 8
  call void @lunite_retain(ptr %name68)
  store ptr %name68, ptr %fp67, align 8
  %fp69 = getelementptr inbounds %semantic_TLetStatementPayload, ptr %ptr66, i32 0, i32 1
  %var_typ70 = load ptr, ptr %var_typ, align 8
  call void @lunite_retain(ptr %var_typ70)
  store ptr %var_typ70, ptr %fp69, align 8
  %fp71 = getelementptr inbounds %semantic_TLetStatementPayload, ptr %ptr66, i32 0, i32 2
  %t_val72 = load ptr, ptr %t_val, align 8
  call void @lunite_retain(ptr %t_val72)
  store ptr %t_val72, ptr %fp71, align 8
  call void @lunite_retain(ptr %ptr66)
  %p73 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr64, i32 0, i32 1
  store ptr %ptr66, ptr %p73, align 8
  call void @lunite_retain(ptr %eptr64)
  %tmp74 = load ptr, ptr %sym, align 8
  call void @lunite_release(ptr %tmp74)
  %tmp75 = load ptr, ptr %var_typ, align 8
  call void @lunite_release(ptr %tmp75)
  %tmp76 = load ptr, ptr %t_val, align 8
  call void @lunite_release(ptr %tmp76)
  %tmp77 = load ptr, ptr %type_name9, align 8
  call void @lunite_release(ptr %tmp77)
  %tmp78 = load ptr, ptr %value6, align 8
  call void @lunite_release(ptr %tmp78)
  %tmp79 = load ptr, ptr %name3, align 8
  call void @lunite_release(ptr %tmp79)
  %tmp80 = load ptr, ptr %payload, align 8
  call void @lunite_release(ptr %tmp80)
  %tmp81 = load ptr, ptr %stmt, align 8
  call void @lunite_release(ptr %tmp81)
  %tmp82 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp82)
  ret ptr %eptr64

when_next34:                                      ; preds = %when_end13
  br label %when_body46

when_body35:                                      ; preds = %when_end13
  %pptr39 = getelementptr inbounds { i64, [8 x i8] }, ptr %type_name32, i32 0, i32 1
  %pval40 = load ptr, ptr %pptr39, align 8
  call void @lunite_retain(ptr %pval40)
  store ptr %pval40, ptr %t41, align 8
  %t42 = load ptr, ptr %t41, align 8
  %old43 = load ptr, ptr %var_typ, align 8
  call void @lunite_retain(ptr %t42)
  store ptr %t42, ptr %var_typ, align 8
  call void @lunite_release(ptr %old43)
  %tmp44 = load ptr, ptr %t41, align 8
  call void @lunite_release(ptr %tmp44)
  br label %when_end33

when_next45:                                      ; No predecessors!
  br label %when_end33

when_body46:                                      ; preds = %when_next34
  br label %when_end33

when_next83:                                      ; preds = %when_next
  %tptr123 = getelementptr inbounds { i64, [8 x i8] }, ptr %stmt1, i32 0, i32 0
  %tag124 = load i64, ptr %tptr123, align 8
  %match125 = icmp eq i64 %tag124, 11
  br i1 %match125, label %when_body122, label %when_next121

when_body84:                                      ; preds = %when_next
  %pptr88 = getelementptr inbounds { i64, [8 x i8] }, ptr %stmt1, i32 0, i32 1
  %pval89 = load ptr, ptr %pptr88, align 8
  call void @lunite_retain(ptr %pval89)
  store ptr %pval89, ptr %val, align 8
  %eptr90 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t91 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr90, i32 0, i32 0
  store i64 1, ptr %t91, align 8
  call void @lunite_retain(ptr %eptr90)
  store ptr %eptr90, ptr %t_val92, align 8
  %val93 = load ptr, ptr %val, align 8
  %tptr97 = getelementptr inbounds { i64, [8 x i8] }, ptr %val93, i32 0, i32 0
  %tag98 = load i64, ptr %tptr97, align 8
  %match99 = icmp eq i64 %tag98, 0
  br i1 %match99, label %when_body96, label %when_next95

when_end94:                                       ; preds = %when_next111, %when_body112, %when_body96
  %eptr113 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t114 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr113, i32 0, i32 0
  store i64 1, ptr %t114, align 8
  %t_val115 = load ptr, ptr %t_val92, align 8
  call void @lunite_retain(ptr %t_val115)
  %p116 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr113, i32 0, i32 1
  store ptr %t_val115, ptr %p116, align 8
  call void @lunite_retain(ptr %eptr113)
  %tmp117 = load ptr, ptr %t_val92, align 8
  call void @lunite_release(ptr %tmp117)
  %tmp118 = load ptr, ptr %val, align 8
  call void @lunite_release(ptr %tmp118)
  %tmp119 = load ptr, ptr %stmt, align 8
  call void @lunite_release(ptr %tmp119)
  %tmp120 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp120)
  ret ptr %eptr113

when_next95:                                      ; preds = %when_body84
  br label %when_body112

when_body96:                                      ; preds = %when_body84
  %pptr100 = getelementptr inbounds { i64, [8 x i8] }, ptr %val93, i32 0, i32 1
  %pval101 = load ptr, ptr %pptr100, align 8
  call void @lunite_retain(ptr %pval101)
  store ptr %pval101, ptr %v102, align 8
  %eptr103 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t104 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr103, i32 0, i32 0
  store i64 0, ptr %t104, align 8
  %self105 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self105)
  %v106 = load ptr, ptr %v102, align 8
  call void @lunite_retain(ptr %v106)
  %res107 = call ptr @semantic_SemanticAnalyzer_analyze_expression(ptr %self105, ptr %v106)
  call void @lunite_retain(ptr %res107)
  %p108 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr103, i32 0, i32 1
  store ptr %res107, ptr %p108, align 8
  %old109 = load ptr, ptr %t_val92, align 8
  call void @lunite_retain(ptr %eptr103)
  store ptr %eptr103, ptr %t_val92, align 8
  call void @lunite_release(ptr %old109)
  %tmp110 = load ptr, ptr %v102, align 8
  call void @lunite_release(ptr %tmp110)
  br label %when_end94

when_next111:                                     ; No predecessors!
  br label %when_end94

when_body112:                                     ; preds = %when_next95
  br label %when_end94

when_next121:                                     ; preds = %when_next83
  br label %when_body138

when_body122:                                     ; preds = %when_next83
  %pptr126 = getelementptr inbounds { i64, [8 x i8] }, ptr %stmt1, i32 0, i32 1
  %pval127 = load ptr, ptr %pptr126, align 8
  call void @lunite_retain(ptr %pval127)
  store ptr %pval127, ptr %expr, align 8
  %eptr128 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t129 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr128, i32 0, i32 0
  store i64 2, ptr %t129, align 8
  %self130 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self130)
  %expr131 = load ptr, ptr %expr, align 8
  call void @lunite_retain(ptr %expr131)
  %res132 = call ptr @semantic_SemanticAnalyzer_analyze_expression(ptr %self130, ptr %expr131)
  call void @lunite_retain(ptr %res132)
  %p133 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr128, i32 0, i32 1
  store ptr %res132, ptr %p133, align 8
  call void @lunite_retain(ptr %eptr128)
  %tmp134 = load ptr, ptr %expr, align 8
  call void @lunite_release(ptr %tmp134)
  %tmp135 = load ptr, ptr %stmt, align 8
  call void @lunite_release(ptr %tmp135)
  %tmp136 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp136)
  ret ptr %eptr128

when_next137:                                     ; No predecessors!
  br label %when_end

when_body138:                                     ; preds = %when_next121
  %sdata = call ptr @lunite_alloc(i64 42, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.238, i64 42, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p139 = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p139, align 8
  store i64 42, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  call void @string_print(ptr %sstruct)
  %eptr140 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t141 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr140, i32 0, i32 0
  store i64 3, ptr %t141, align 8
  call void @lunite_retain(ptr %eptr140)
  %tmp142 = load ptr, ptr %stmt, align 8
  call void @lunite_release(ptr %tmp142)
  %tmp143 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp143)
  ret ptr %eptr140
}

define ptr @semantic_SemanticAnalyzer_analyze_expression(ptr %0, ptr %1) {
entry:
  %ret_str = alloca ptr, align 8
  %real_mod = alloca ptr, align 8
  %alias = alloca ptr, align 8
  %payload233 = alloca ptr, align 8
  %p195 = alloca ptr, align 8
  %name179 = alloca ptr, align 8
  %func_name = alloca ptr, align 8
  %ret_typ = alloca ptr, align 8
  %i = alloca i64, align 8
  %t_args = alloca ptr, align 8
  %callee = alloca ptr, align 8
  %payload146 = alloca ptr, align 8
  %tr = alloca ptr, align 8
  %tl = alloca ptr, align 8
  %payload = alloca ptr, align 8
  %sym = alloca ptr, align 8
  %opt = alloca ptr, align 8
  %name = alloca ptr, align 8
  %v34 = alloca i1, align 1
  %v14 = alloca ptr, align 8
  %v = alloca i64, align 8
  %expr = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %expr, align 8
  %expr1 = load ptr, ptr %expr, align 8
  %tptr = getelementptr inbounds { i64, [8 x i8] }, ptr %expr1, i32 0, i32 0
  %tag = load i64, ptr %tptr, align 8
  %match = icmp eq i64 %tag, 0
  br i1 %match, label %when_body, label %when_next

when_end:                                         ; preds = %when_next305, %when_end56
  %tmp320 = load ptr, ptr %expr, align 8
  call void @lunite_release(ptr %tmp320)
  %tmp321 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp321)
  ret ptr null

when_next:                                        ; preds = %body
  %tptr9 = getelementptr inbounds { i64, [8 x i8] }, ptr %expr1, i32 0, i32 0
  %tag10 = load i64, ptr %tptr9, align 8
  %match11 = icmp eq i64 %tag10, 2
  br i1 %match11, label %when_body8, label %when_next7

when_body:                                        ; preds = %body
  %pptr = getelementptr inbounds { i64, [8 x i8] }, ptr %expr1, i32 0, i32 1
  %pval = load i64, ptr %pptr, align 8
  store i64 %pval, ptr %v, align 8
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%semantic_TExpression, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %semantic_TExpression, ptr %ptr, i32 0, i32 0
  %eptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 0
  store i64 0, ptr %t, align 8
  %v2 = load i64, ptr %v, align 8
  %p = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr, i32 0, i32 1
  store i64 %v2, ptr %p, align 8
  call void @lunite_retain(ptr %eptr)
  store ptr %eptr, ptr %fp, align 8
  %fp3 = getelementptr inbounds %semantic_TExpression, ptr %ptr, i32 0, i32 1
  %eptr4 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t5 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr4, i32 0, i32 0
  store i64 0, ptr %t5, align 8
  call void @lunite_retain(ptr %eptr4)
  store ptr %eptr4, ptr %fp3, align 8
  call void @lunite_retain(ptr %ptr)
  %tmp = load ptr, ptr %expr, align 8
  call void @lunite_release(ptr %tmp)
  %tmp6 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp6)
  ret ptr %ptr

when_next7:                                       ; preds = %when_next
  %tptr29 = getelementptr inbounds { i64, [8 x i8] }, ptr %expr1, i32 0, i32 0
  %tag30 = load i64, ptr %tptr29, align 8
  %match31 = icmp eq i64 %tag30, 4
  br i1 %match31, label %when_body28, label %when_next27

when_body8:                                       ; preds = %when_next
  %pptr12 = getelementptr inbounds { i64, [8 x i8] }, ptr %expr1, i32 0, i32 1
  %pval13 = load ptr, ptr %pptr12, align 8
  call void @lunite_retain(ptr %pval13)
  store ptr %pval13, ptr %v14, align 8
  %ptr15 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%semantic_TExpression, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp16 = getelementptr inbounds %semantic_TExpression, ptr %ptr15, i32 0, i32 0
  %eptr17 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t18 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr17, i32 0, i32 0
  store i64 2, ptr %t18, align 8
  %v19 = load ptr, ptr %v14, align 8
  call void @lunite_retain(ptr %v19)
  %p20 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr17, i32 0, i32 1
  store ptr %v19, ptr %p20, align 8
  call void @lunite_retain(ptr %eptr17)
  store ptr %eptr17, ptr %fp16, align 8
  %fp21 = getelementptr inbounds %semantic_TExpression, ptr %ptr15, i32 0, i32 1
  %eptr22 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t23 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr22, i32 0, i32 0
  store i64 3, ptr %t23, align 8
  call void @lunite_retain(ptr %eptr22)
  store ptr %eptr22, ptr %fp21, align 8
  call void @lunite_retain(ptr %ptr15)
  %tmp24 = load ptr, ptr %v14, align 8
  call void @lunite_release(ptr %tmp24)
  %tmp25 = load ptr, ptr %expr, align 8
  call void @lunite_release(ptr %tmp25)
  %tmp26 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp26)
  ret ptr %ptr15

when_next27:                                      ; preds = %when_next7
  %tptr48 = getelementptr inbounds { i64, [8 x i8] }, ptr %expr1, i32 0, i32 0
  %tag49 = load i64, ptr %tptr48, align 8
  %match50 = icmp eq i64 %tag49, 3
  br i1 %match50, label %when_body47, label %when_next46

when_body28:                                      ; preds = %when_next7
  %pptr32 = getelementptr inbounds { i64, [8 x i8] }, ptr %expr1, i32 0, i32 1
  %pval33 = load i1, ptr %pptr32, align 1
  store i1 %pval33, ptr %v34, align 1
  %ptr35 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%semantic_TExpression, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp36 = getelementptr inbounds %semantic_TExpression, ptr %ptr35, i32 0, i32 0
  %eptr37 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t38 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr37, i32 0, i32 0
  store i64 4, ptr %t38, align 8
  %v39 = load i1, ptr %v34, align 1
  %p40 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr37, i32 0, i32 1
  store i1 %v39, ptr %p40, align 1
  call void @lunite_retain(ptr %eptr37)
  store ptr %eptr37, ptr %fp36, align 8
  %fp41 = getelementptr inbounds %semantic_TExpression, ptr %ptr35, i32 0, i32 1
  %eptr42 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t43 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr42, i32 0, i32 0
  store i64 2, ptr %t43, align 8
  call void @lunite_retain(ptr %eptr42)
  store ptr %eptr42, ptr %fp41, align 8
  call void @lunite_retain(ptr %ptr35)
  %tmp44 = load ptr, ptr %expr, align 8
  call void @lunite_release(ptr %tmp44)
  %tmp45 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp45)
  ret ptr %ptr35

when_next46:                                      ; preds = %when_next27
  %tptr95 = getelementptr inbounds { i64, [8 x i8] }, ptr %expr1, i32 0, i32 0
  %tag96 = load i64, ptr %tptr95, align 8
  %match97 = icmp eq i64 %tag96, 8
  br i1 %match97, label %when_body94, label %when_next93

when_body47:                                      ; preds = %when_next27
  %pptr51 = getelementptr inbounds { i64, [8 x i8] }, ptr %expr1, i32 0, i32 1
  %pval52 = load ptr, ptr %pptr51, align 8
  call void @lunite_retain(ptr %pval52)
  store ptr %pval52, ptr %name, align 8
  %self53 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self53)
  %name54 = load ptr, ptr %name, align 8
  call void @lunite_retain(ptr %name54)
  %res = call ptr @semantic_SemanticAnalyzer_lookup_symbol(ptr %self53, ptr %name54)
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %opt, align 8
  %opt55 = load ptr, ptr %opt, align 8
  %tptr59 = getelementptr inbounds { i64, [8 x i8] }, ptr %opt55, i32 0, i32 0
  %tag60 = load i64, ptr %tptr59, align 8
  %match61 = icmp eq i64 %tag60, 0
  br i1 %match61, label %when_body58, label %when_next57

when_end56:                                       ; preds = %when_next78
  %tmp91 = load ptr, ptr %opt, align 8
  call void @lunite_release(ptr %tmp91)
  %tmp92 = load ptr, ptr %name, align 8
  call void @lunite_release(ptr %tmp92)
  br label %when_end

when_next57:                                      ; preds = %when_body47
  br label %when_body79

when_body58:                                      ; preds = %when_body47
  %pptr62 = getelementptr inbounds { i64, [8 x i8] }, ptr %opt55, i32 0, i32 1
  %pval63 = load ptr, ptr %pptr62, align 8
  call void @lunite_retain(ptr %pval63)
  store ptr %pval63, ptr %sym, align 8
  %ptr64 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%semantic_TExpression, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp65 = getelementptr inbounds %semantic_TExpression, ptr %ptr64, i32 0, i32 0
  %eptr66 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t67 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr66, i32 0, i32 0
  store i64 3, ptr %t67, align 8
  %name68 = load ptr, ptr %name, align 8
  call void @lunite_retain(ptr %name68)
  %p69 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr66, i32 0, i32 1
  store ptr %name68, ptr %p69, align 8
  call void @lunite_retain(ptr %eptr66)
  store ptr %eptr66, ptr %fp65, align 8
  %fp70 = getelementptr inbounds %semantic_TExpression, ptr %ptr64, i32 0, i32 1
  %sym71 = load ptr, ptr %sym, align 8
  %fp72 = getelementptr inbounds %semantic_Symbol, ptr %sym71, i32 0, i32 1
  %typ = load ptr, ptr %fp72, align 8
  call void @lunite_retain(ptr %typ)
  store ptr %typ, ptr %fp70, align 8
  call void @lunite_retain(ptr %ptr64)
  %tmp73 = load ptr, ptr %sym, align 8
  call void @lunite_release(ptr %tmp73)
  %tmp74 = load ptr, ptr %opt, align 8
  call void @lunite_release(ptr %tmp74)
  %tmp75 = load ptr, ptr %name, align 8
  call void @lunite_release(ptr %tmp75)
  %tmp76 = load ptr, ptr %expr, align 8
  call void @lunite_release(ptr %tmp76)
  %tmp77 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp77)
  ret ptr %ptr64

when_next78:                                      ; No predecessors!
  br label %when_end56

when_body79:                                      ; preds = %when_next57
  %ptr80 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%semantic_TExpression, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp81 = getelementptr inbounds %semantic_TExpression, ptr %ptr80, i32 0, i32 0
  %eptr82 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t83 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr82, i32 0, i32 0
  store i64 7, ptr %t83, align 8
  call void @lunite_retain(ptr %eptr82)
  store ptr %eptr82, ptr %fp81, align 8
  %fp84 = getelementptr inbounds %semantic_TExpression, ptr %ptr80, i32 0, i32 1
  %eptr85 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t86 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr85, i32 0, i32 0
  store i64 4, ptr %t86, align 8
  call void @lunite_retain(ptr %eptr85)
  store ptr %eptr85, ptr %fp84, align 8
  call void @lunite_retain(ptr %ptr80)
  %tmp87 = load ptr, ptr %opt, align 8
  call void @lunite_release(ptr %tmp87)
  %tmp88 = load ptr, ptr %name, align 8
  call void @lunite_release(ptr %tmp88)
  %tmp89 = load ptr, ptr %expr, align 8
  call void @lunite_release(ptr %tmp89)
  %tmp90 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp90)
  ret ptr %ptr80

when_next93:                                      ; preds = %when_next46
  %tptr141 = getelementptr inbounds { i64, [8 x i8] }, ptr %expr1, i32 0, i32 0
  %tag142 = load i64, ptr %tptr141, align 8
  %match143 = icmp eq i64 %tag142, 9
  br i1 %match143, label %when_body140, label %when_next139

when_body94:                                      ; preds = %when_next46
  %pptr98 = getelementptr inbounds { i64, [8 x i8] }, ptr %expr1, i32 0, i32 1
  %pval99 = load ptr, ptr %pptr98, align 8
  call void @lunite_retain(ptr %pval99)
  store ptr %pval99, ptr %payload, align 8
  %self100 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self100)
  %payload101 = load ptr, ptr %payload, align 8
  %fp102 = getelementptr inbounds %ast_BinaryExpressionPayload, ptr %payload101, i32 0, i32 0
  %left = load ptr, ptr %fp102, align 8
  %deref = load ptr, ptr %left, align 8
  call void @lunite_retain(ptr %deref)
  %res103 = call ptr @semantic_SemanticAnalyzer_analyze_expression(ptr %self100, ptr %deref)
  call void @lunite_retain(ptr %res103)
  store ptr %res103, ptr %tl, align 8
  %self104 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self104)
  %payload105 = load ptr, ptr %payload, align 8
  %fp106 = getelementptr inbounds %ast_BinaryExpressionPayload, ptr %payload105, i32 0, i32 2
  %right = load ptr, ptr %fp106, align 8
  %deref107 = load ptr, ptr %right, align 8
  call void @lunite_retain(ptr %deref107)
  %res108 = call ptr @semantic_SemanticAnalyzer_analyze_expression(ptr %self104, ptr %deref107)
  call void @lunite_retain(ptr %res108)
  store ptr %res108, ptr %tr, align 8
  %ptr109 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%semantic_TExpression, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp110 = getelementptr inbounds %semantic_TExpression, ptr %ptr109, i32 0, i32 0
  %eptr111 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t112 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr111, i32 0, i32 0
  store i64 5, ptr %t112, align 8
  %ptr113 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%semantic_TBinaryExpressionPayload, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp114 = getelementptr inbounds %semantic_TBinaryExpressionPayload, ptr %ptr113, i32 0, i32 0
  %tl115 = load ptr, ptr %tl, align 8
  call void @lunite_retain(ptr %tl115)
  store ptr %tl115, ptr %fp114, align 8
  %fp116 = getelementptr inbounds %semantic_TBinaryExpressionPayload, ptr %ptr113, i32 0, i32 1
  %payload117 = load ptr, ptr %payload, align 8
  %fp118 = getelementptr inbounds %ast_BinaryExpressionPayload, ptr %payload117, i32 0, i32 1
  %operator = load ptr, ptr %fp118, align 8
  call void @lunite_retain(ptr %operator)
  store ptr %operator, ptr %fp116, align 8
  %fp119 = getelementptr inbounds %semantic_TBinaryExpressionPayload, ptr %ptr113, i32 0, i32 2
  %tr120 = load ptr, ptr %tr, align 8
  call void @lunite_retain(ptr %tr120)
  store ptr %tr120, ptr %fp119, align 8
  call void @lunite_retain(ptr %ptr113)
  %p121 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr111, i32 0, i32 1
  store ptr %ptr113, ptr %p121, align 8
  call void @lunite_retain(ptr %eptr111)
  store ptr %eptr111, ptr %fp110, align 8
  %fp122 = getelementptr inbounds %semantic_TExpression, ptr %ptr109, i32 0, i32 1
  %self123 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self123)
  %tl124 = load ptr, ptr %tl, align 8
  %fp125 = getelementptr inbounds %semantic_TExpression, ptr %tl124, i32 0, i32 1
  %typ126 = load ptr, ptr %fp125, align 8
  call void @lunite_retain(ptr %typ126)
  %payload127 = load ptr, ptr %payload, align 8
  %fp128 = getelementptr inbounds %ast_BinaryExpressionPayload, ptr %payload127, i32 0, i32 1
  %operator129 = load ptr, ptr %fp128, align 8
  call void @lunite_retain(ptr %operator129)
  %tr130 = load ptr, ptr %tr, align 8
  %fp131 = getelementptr inbounds %semantic_TExpression, ptr %tr130, i32 0, i32 1
  %typ132 = load ptr, ptr %fp131, align 8
  call void @lunite_retain(ptr %typ132)
  %res133 = call ptr @semantic_SemanticAnalyzer_check_binary_op(ptr %self123, ptr %typ126, ptr %operator129, ptr %typ132)
  call void @lunite_retain(ptr %res133)
  store ptr %res133, ptr %fp122, align 8
  call void @lunite_retain(ptr %ptr109)
  %tmp134 = load ptr, ptr %tr, align 8
  call void @lunite_release(ptr %tmp134)
  %tmp135 = load ptr, ptr %tl, align 8
  call void @lunite_release(ptr %tmp135)
  %tmp136 = load ptr, ptr %payload, align 8
  call void @lunite_release(ptr %tmp136)
  %tmp137 = load ptr, ptr %expr, align 8
  call void @lunite_release(ptr %tmp137)
  %tmp138 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp138)
  ret ptr %ptr109

when_next139:                                     ; preds = %when_next93
  %tptr228 = getelementptr inbounds { i64, [8 x i8] }, ptr %expr1, i32 0, i32 0
  %tag229 = load i64, ptr %tptr228, align 8
  %match230 = icmp eq i64 %tag229, 14
  br i1 %match230, label %when_body227, label %when_next226

when_body140:                                     ; preds = %when_next93
  %pptr144 = getelementptr inbounds { i64, [8 x i8] }, ptr %expr1, i32 0, i32 1
  %pval145 = load ptr, ptr %pptr144, align 8
  call void @lunite_retain(ptr %pval145)
  store ptr %pval145, ptr %payload146, align 8
  %self147 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self147)
  %payload148 = load ptr, ptr %payload146, align 8
  %fp149 = getelementptr inbounds %ast_CallExpressionPayload, ptr %payload148, i32 0, i32 0
  %function = load ptr, ptr %fp149, align 8
  %deref150 = load ptr, ptr %function, align 8
  call void @lunite_retain(ptr %deref150)
  %res151 = call ptr @semantic_SemanticAnalyzer_analyze_expression(ptr %self147, ptr %deref150)
  call void @lunite_retain(ptr %res151)
  store ptr %res151, ptr %callee, align 8
  %res152 = call ptr @list_List_semantic_TExpression__new()
  call void @lunite_retain(ptr %res152)
  store ptr %res152, ptr %t_args, align 8
  store i64 0, ptr %i, align 8
  br label %while_cond

while_cond:                                       ; preds = %while_body, %when_body140
  %payload153 = load ptr, ptr %payload146, align 8
  %fp154 = getelementptr inbounds %ast_CallExpressionPayload, ptr %payload153, i32 0, i32 1
  %args = load ptr, ptr %fp154, align 8
  call void @lunite_retain(ptr %args)
  %res155 = call i64 @list_List_ast_Expression__len(ptr %args)
  %i156 = load i64, ptr %i, align 8
  %2 = icmp sgt i64 %res155, %i156
  br i1 %2, label %while_body, label %while_end

while_body:                                       ; preds = %while_cond
  %t_args157 = load ptr, ptr %t_args, align 8
  call void @lunite_retain(ptr %t_args157)
  %self158 = load ptr, ptr %self, align 8
  call void @lunite_retain(ptr %self158)
  %payload159 = load ptr, ptr %payload146, align 8
  %fp160 = getelementptr inbounds %ast_CallExpressionPayload, ptr %payload159, i32 0, i32 1
  %args161 = load ptr, ptr %fp160, align 8
  call void @lunite_retain(ptr %args161)
  %i162 = load i64, ptr %i, align 8
  %res163 = call ptr @list_List_ast_Expression__get(ptr %args161, i64 %i162)
  call void @lunite_retain(ptr %res163)
  %res164 = call ptr @semantic_SemanticAnalyzer_analyze_expression(ptr %self158, ptr %res163)
  call void @lunite_retain(ptr %res164)
  call void @list_List_semantic_TExpression__push(ptr %t_args157, ptr %res164)
  %i165 = load i64, ptr %i, align 8
  %3 = add i64 %i165, 1
  store i64 %3, ptr %i, align 8
  br label %while_cond

while_end:                                        ; preds = %while_cond
  %eptr166 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t167 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr166, i32 0, i32 0
  store i64 4, ptr %t167, align 8
  call void @lunite_retain(ptr %eptr166)
  store ptr %eptr166, ptr %ret_typ, align 8
  %sdata = call ptr @lunite_alloc(i64 7, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata, ptr align 1 @slit.239, i64 7, i1 false)
  %sstruct = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p168 = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 0
  %l = getelementptr inbounds { ptr, i64 }, ptr %sstruct, i32 0, i32 1
  store ptr %sdata, ptr %p168, align 8
  store i64 7, ptr %l, align 8
  call void @lunite_retain(ptr %sstruct)
  store ptr %sstruct, ptr %func_name, align 8
  %callee169 = load ptr, ptr %callee, align 8
  %fp170 = getelementptr inbounds %semantic_TExpression, ptr %callee169, i32 0, i32 0
  %kind = load ptr, ptr %fp170, align 8
  %tptr174 = getelementptr inbounds { i64, [8 x i8] }, ptr %kind, i32 0, i32 0
  %tag175 = load i64, ptr %tptr174, align 8
  %match176 = icmp eq i64 %tag175, 3
  br i1 %match176, label %when_body173, label %when_next172

when_end171:                                      ; preds = %when_next182, %when_body183, %when_body173
  %callee184 = load ptr, ptr %callee, align 8
  %fp185 = getelementptr inbounds %semantic_TExpression, ptr %callee184, i32 0, i32 1
  %typ186 = load ptr, ptr %fp185, align 8
  %tptr190 = getelementptr inbounds { i64, [8 x i8] }, ptr %typ186, i32 0, i32 0
  %tag191 = load i64, ptr %tptr190, align 8
  %match192 = icmp eq i64 %tag191, 9
  br i1 %match192, label %when_body189, label %when_next188

when_next172:                                     ; preds = %while_end
  br label %when_body183

when_body173:                                     ; preds = %while_end
  %pptr177 = getelementptr inbounds { i64, [8 x i8] }, ptr %kind, i32 0, i32 1
  %pval178 = load ptr, ptr %pptr177, align 8
  call void @lunite_retain(ptr %pval178)
  store ptr %pval178, ptr %name179, align 8
  %name180 = load ptr, ptr %name179, align 8
  %old = load ptr, ptr %func_name, align 8
  call void @lunite_retain(ptr %name180)
  store ptr %name180, ptr %func_name, align 8
  call void @lunite_release(ptr %old)
  %tmp181 = load ptr, ptr %name179, align 8
  call void @lunite_release(ptr %tmp181)
  br label %when_end171

when_next182:                                     ; No predecessors!
  br label %when_end171

when_body183:                                     ; preds = %when_next172
  br label %when_end171

when_end187:                                      ; preds = %when_next201, %when_body202, %when_body189
  %ptr207 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%semantic_TExpression, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp208 = getelementptr inbounds %semantic_TExpression, ptr %ptr207, i32 0, i32 0
  %eptr209 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t210 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr209, i32 0, i32 0
  store i64 6, ptr %t210, align 8
  %ptr211 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%semantic_TCallExpressionPayload, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp212 = getelementptr inbounds %semantic_TCallExpressionPayload, ptr %ptr211, i32 0, i32 0
  %func_name213 = load ptr, ptr %func_name, align 8
  call void @lunite_retain(ptr %func_name213)
  store ptr %func_name213, ptr %fp212, align 8
  %fp214 = getelementptr inbounds %semantic_TCallExpressionPayload, ptr %ptr211, i32 0, i32 1
  %t_args215 = load ptr, ptr %t_args, align 8
  call void @lunite_retain(ptr %t_args215)
  store ptr %t_args215, ptr %fp214, align 8
  call void @lunite_retain(ptr %ptr211)
  %p216 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr209, i32 0, i32 1
  store ptr %ptr211, ptr %p216, align 8
  call void @lunite_retain(ptr %eptr209)
  store ptr %eptr209, ptr %fp208, align 8
  %fp217 = getelementptr inbounds %semantic_TExpression, ptr %ptr207, i32 0, i32 1
  %ret_typ218 = load ptr, ptr %ret_typ, align 8
  call void @lunite_retain(ptr %ret_typ218)
  store ptr %ret_typ218, ptr %fp217, align 8
  call void @lunite_retain(ptr %ptr207)
  %tmp219 = load ptr, ptr %func_name, align 8
  call void @lunite_release(ptr %tmp219)
  %tmp220 = load ptr, ptr %ret_typ, align 8
  call void @lunite_release(ptr %tmp220)
  %tmp221 = load ptr, ptr %t_args, align 8
  call void @lunite_release(ptr %tmp221)
  %tmp222 = load ptr, ptr %callee, align 8
  call void @lunite_release(ptr %tmp222)
  %tmp223 = load ptr, ptr %payload146, align 8
  call void @lunite_release(ptr %tmp223)
  %tmp224 = load ptr, ptr %expr, align 8
  call void @lunite_release(ptr %tmp224)
  %tmp225 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp225)
  ret ptr %ptr207

when_next188:                                     ; preds = %when_end171
  br label %when_body202

when_body189:                                     ; preds = %when_end171
  %pptr193 = getelementptr inbounds { i64, [8 x i8] }, ptr %typ186, i32 0, i32 1
  %pval194 = load ptr, ptr %pptr193, align 8
  call void @lunite_retain(ptr %pval194)
  store ptr %pval194, ptr %p195, align 8
  %p196 = load ptr, ptr %p195, align 8
  %fp197 = getelementptr inbounds %ast_FunctionTypePayload, ptr %p196, i32 0, i32 1
  %return_type = load ptr, ptr %fp197, align 8
  %deref198 = load ptr, ptr %return_type, align 8
  %old199 = load ptr, ptr %ret_typ, align 8
  call void @lunite_retain(ptr %deref198)
  store ptr %deref198, ptr %ret_typ, align 8
  call void @lunite_release(ptr %old199)
  %tmp200 = load ptr, ptr %p195, align 8
  call void @lunite_release(ptr %tmp200)
  br label %when_end187

when_next201:                                     ; No predecessors!
  br label %when_end187

when_body202:                                     ; preds = %when_next188
  %sdata203 = call ptr @lunite_alloc(i64 31, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata203, ptr align 1 @slit.240, i64 31, i1 false)
  %sstruct204 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p205 = getelementptr inbounds { ptr, i64 }, ptr %sstruct204, i32 0, i32 0
  %l206 = getelementptr inbounds { ptr, i64 }, ptr %sstruct204, i32 0, i32 1
  store ptr %sdata203, ptr %p205, align 8
  store i64 31, ptr %l206, align 8
  call void @lunite_retain(ptr %sstruct204)
  call void @string_println(ptr %sstruct204)
  br label %when_end187

when_next226:                                     ; preds = %when_next139
  br label %when_body306

when_body227:                                     ; preds = %when_next139
  %pptr231 = getelementptr inbounds { i64, [8 x i8] }, ptr %expr1, i32 0, i32 1
  %pval232 = load ptr, ptr %pptr231, align 8
  call void @lunite_retain(ptr %pval232)
  store ptr %pval232, ptr %payload233, align 8
  %payload234 = load ptr, ptr %payload233, align 8
  %fp235 = getelementptr inbounds %ast_MemberAccessExpressionPayload, ptr %payload234, i32 0, i32 0
  %object = load ptr, ptr %fp235, align 8
  %deref236 = load ptr, ptr %object, align 8
  %tptr240 = getelementptr inbounds { i64, [8 x i8] }, ptr %deref236, i32 0, i32 0
  %tag241 = load i64, ptr %tptr240, align 8
  %match242 = icmp eq i64 %tag241, 3
  br i1 %match242, label %when_body239, label %when_next238

when_end237:                                      ; preds = %when_next289, %when_body290, %cont
  %sdata291 = call ptr @lunite_alloc(i64 67, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata291, ptr align 1 @slit.243, i64 67, i1 false)
  %sstruct292 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p293 = getelementptr inbounds { ptr, i64 }, ptr %sstruct292, i32 0, i32 0
  %l294 = getelementptr inbounds { ptr, i64 }, ptr %sstruct292, i32 0, i32 1
  store ptr %sdata291, ptr %p293, align 8
  store i64 67, ptr %l294, align 8
  call void @lunite_retain(ptr %sstruct292)
  call void @string_println(ptr %sstruct292)
  %ptr295 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%semantic_TExpression, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp296 = getelementptr inbounds %semantic_TExpression, ptr %ptr295, i32 0, i32 0
  %eptr297 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t298 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr297, i32 0, i32 0
  store i64 7, ptr %t298, align 8
  call void @lunite_retain(ptr %eptr297)
  store ptr %eptr297, ptr %fp296, align 8
  %fp299 = getelementptr inbounds %semantic_TExpression, ptr %ptr295, i32 0, i32 1
  %eptr300 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t301 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr300, i32 0, i32 0
  store i64 4, ptr %t301, align 8
  call void @lunite_retain(ptr %eptr300)
  store ptr %eptr300, ptr %fp299, align 8
  call void @lunite_retain(ptr %ptr295)
  %tmp302 = load ptr, ptr %payload233, align 8
  call void @lunite_release(ptr %tmp302)
  %tmp303 = load ptr, ptr %expr, align 8
  call void @lunite_release(ptr %tmp303)
  %tmp304 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp304)
  ret ptr %ptr295

when_next238:                                     ; preds = %when_body227
  br label %when_body290

when_body239:                                     ; preds = %when_body227
  %pptr243 = getelementptr inbounds { i64, [8 x i8] }, ptr %deref236, i32 0, i32 1
  %pval244 = load ptr, ptr %pptr243, align 8
  call void @lunite_retain(ptr %pval244)
  store ptr %pval244, ptr %alias, align 8
  %self245 = load ptr, ptr %self, align 8
  %fp246 = getelementptr inbounds %semantic_SemanticAnalyzer, ptr %self245, i32 0, i32 3
  %imports = load ptr, ptr %fp246, align 8
  call void @lunite_retain(ptr %imports)
  %alias247 = load ptr, ptr %alias, align 8
  call void @lunite_retain(ptr %alias247)
  %res248 = call ptr @map_Map_string_string_get(ptr %imports, ptr %alias247)
  call void @lunite_retain(ptr %res248)
  store ptr %res248, ptr %real_mod, align 8
  %real_mod249 = load ptr, ptr %real_mod, align 8
  %seq = call i64 @lunite_str_eq(ptr %real_mod249, i64 0)
  %bool = icmp eq i64 %seq, 0
  br i1 %bool, label %then, label %else

then:                                             ; preds = %when_body239
  %alias250 = load ptr, ptr %alias, align 8
  %sdata251 = call ptr @lunite_alloc(i64 3, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata251, ptr align 1 @slit.241, i64 3, i1 false)
  %sstruct252 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p253 = getelementptr inbounds { ptr, i64 }, ptr %sstruct252, i32 0, i32 0
  %l254 = getelementptr inbounds { ptr, i64 }, ptr %sstruct252, i32 0, i32 1
  store ptr %sdata251, ptr %p253, align 8
  store i64 3, ptr %l254, align 8
  %seq255 = call i64 @lunite_str_eq(ptr %alias250, ptr %sstruct252)
  %bool256 = icmp ne i64 %seq255, 0
  br i1 %bool256, label %then257, label %else258

else:                                             ; preds = %when_body239
  br label %cont

cont:                                             ; preds = %else, %cont259
  %tmp287 = load ptr, ptr %real_mod, align 8
  call void @lunite_release(ptr %tmp287)
  %tmp288 = load ptr, ptr %alias, align 8
  call void @lunite_release(ptr %tmp288)
  br label %when_end237

then257:                                          ; preds = %then
  %eptr260 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t261 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr260, i32 0, i32 0
  store i64 3, ptr %t261, align 8
  call void @lunite_retain(ptr %eptr260)
  store ptr %eptr260, ptr %ret_str, align 8
  %ptr262 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%semantic_TExpression, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp263 = getelementptr inbounds %semantic_TExpression, ptr %ptr262, i32 0, i32 0
  %eptr264 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t265 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr264, i32 0, i32 0
  store i64 3, ptr %t265, align 8
  %sdata266 = call ptr @lunite_alloc(i64 4, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata266, ptr align 1 @slit.242, i64 4, i1 false)
  %sstruct267 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p268 = getelementptr inbounds { ptr, i64 }, ptr %sstruct267, i32 0, i32 0
  %l269 = getelementptr inbounds { ptr, i64 }, ptr %sstruct267, i32 0, i32 1
  store ptr %sdata266, ptr %p268, align 8
  store i64 4, ptr %l269, align 8
  %payload270 = load ptr, ptr %payload233, align 8
  %fp271 = getelementptr inbounds %ast_MemberAccessExpressionPayload, ptr %payload270, i32 0, i32 1
  %field = load ptr, ptr %fp271, align 8
  %sconcat = call ptr @lunite_str_concat(ptr %sstruct267, ptr %field)
  call void @lunite_retain(ptr %sconcat)
  %p272 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr264, i32 0, i32 1
  store ptr %sconcat, ptr %p272, align 8
  call void @lunite_retain(ptr %eptr264)
  store ptr %eptr264, ptr %fp263, align 8
  %fp273 = getelementptr inbounds %semantic_TExpression, ptr %ptr262, i32 0, i32 1
  %eptr274 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t275 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr274, i32 0, i32 0
  store i64 9, ptr %t275, align 8
  %ptr276 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%ast_FunctionTypePayload, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp277 = getelementptr inbounds %ast_FunctionTypePayload, ptr %ptr276, i32 0, i32 0
  %res278 = call ptr @list_List_ast_Type__new()
  call void @lunite_retain(ptr %res278)
  store ptr %res278, ptr %fp277, align 8
  %fp279 = getelementptr inbounds %ast_FunctionTypePayload, ptr %ptr276, i32 0, i32 1
  store ptr %ret_str, ptr %fp279, align 8
  call void @lunite_retain(ptr %ptr276)
  %p280 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr274, i32 0, i32 1
  store ptr %ptr276, ptr %p280, align 8
  call void @lunite_retain(ptr %eptr274)
  store ptr %eptr274, ptr %fp273, align 8
  call void @lunite_retain(ptr %ptr262)
  %tmp281 = load ptr, ptr %ret_str, align 8
  call void @lunite_release(ptr %tmp281)
  %tmp282 = load ptr, ptr %real_mod, align 8
  call void @lunite_release(ptr %tmp282)
  %tmp283 = load ptr, ptr %alias, align 8
  call void @lunite_release(ptr %tmp283)
  %tmp284 = load ptr, ptr %payload233, align 8
  call void @lunite_release(ptr %tmp284)
  %tmp285 = load ptr, ptr %expr, align 8
  call void @lunite_release(ptr %tmp285)
  %tmp286 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp286)
  ret ptr %ptr262

else258:                                          ; preds = %then
  br label %cont259

cont259:                                          ; preds = %else258
  br label %cont

when_next289:                                     ; No predecessors!
  br label %when_end237

when_body290:                                     ; preds = %when_next238
  br label %when_end237

when_next305:                                     ; No predecessors!
  br label %when_end

when_body306:                                     ; preds = %when_next226
  %sdata307 = call ptr @lunite_alloc(i64 64, ptr null, ptr null)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %sdata307, ptr align 1 @slit.244, i64 64, i1 false)
  %sstruct308 = call ptr @lunite_alloc(i64 16, ptr null, ptr null)
  %p309 = getelementptr inbounds { ptr, i64 }, ptr %sstruct308, i32 0, i32 0
  %l310 = getelementptr inbounds { ptr, i64 }, ptr %sstruct308, i32 0, i32 1
  store ptr %sdata307, ptr %p309, align 8
  store i64 64, ptr %l310, align 8
  call void @lunite_retain(ptr %sstruct308)
  call void @string_print(ptr %sstruct308)
  %ptr311 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%semantic_TExpression, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp312 = getelementptr inbounds %semantic_TExpression, ptr %ptr311, i32 0, i32 0
  %eptr313 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t314 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr313, i32 0, i32 0
  store i64 7, ptr %t314, align 8
  call void @lunite_retain(ptr %eptr313)
  store ptr %eptr313, ptr %fp312, align 8
  %fp315 = getelementptr inbounds %semantic_TExpression, ptr %ptr311, i32 0, i32 1
  %eptr316 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr ({ i64, [8 x i8] }, ptr null, i32 1) to i64), ptr null, ptr null)
  %t317 = getelementptr inbounds { i64, [8 x i8] }, ptr %eptr316, i32 0, i32 0
  store i64 4, ptr %t317, align 8
  call void @lunite_retain(ptr %eptr316)
  store ptr %eptr316, ptr %fp315, align 8
  call void @lunite_retain(ptr %ptr311)
  %tmp318 = load ptr, ptr %expr, align 8
  call void @lunite_release(ptr %tmp318)
  %tmp319 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp319)
  ret ptr %ptr311
}

define i64 @list_List_map_MapEntry_string_semantic_Symbol__len(ptr %0) {
entry:
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret i64 %count
}

define ptr @list_List_map_MapEntry_string_semantic_Symbol__get_ptr(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %ptr
}

define ptr @list_List_map_MapEntry_string_semantic_Symbol__get(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %val = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val)
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %val
}

define i64 @list_List_map_MapEntry_string_semantic_Symbol___len(ptr %0) {
entry:
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret i64 %count
}

define ptr @list_List_map_MapEntry_string_semantic_Symbol___get_ptr(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %ptr
}

define ptr @list_List_map_MapEntry_string_semantic_Symbol___get(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %val = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val)
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %val
}

define ptr @list_List_map_MapEntry_string_semantic_Symbol___new() {
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
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%list_List_map_MapEntry_string_semantic_Symbol__.3, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %ptr, i32 0, i32 0
  %p2 = load ptr, ptr %p, align 8
  store ptr %p2, ptr %fp, align 8
  %fp3 = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %ptr, i32 0, i32 1
  store i64 0, ptr %fp3, align 8
  %fp4 = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %ptr, i32 0, i32 2
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
  %ptr12 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%list_List_map_MapEntry_string_semantic_Symbol__.3, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp13 = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %ptr12, i32 0, i32 0
  %p14 = load ptr, ptr %p11, align 8
  store ptr %p14, ptr %fp13, align 8
  %fp15 = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %ptr12, i32 0, i32 1
  store i64 0, ptr %fp15, align 8
  %fp16 = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %ptr12, i32 0, i32 2
  %initial_cap17 = load i64, ptr %initial_cap8, align 8
  store i64 %initial_cap17, ptr %fp16, align 8
  call void @lunite_retain(ptr %ptr12)
  ret ptr %ptr12
}

define void @list_List_map_MapEntry_string_semantic_Symbol___push(ptr %0, ptr %1) {
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
  %fp = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  store i64 %count, ptr %c, align 8
  %c2 = load i64, ptr %c, align 8
  %self3 = load ptr, ptr %self, align 8
  %fp4 = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %self3, i32 0, i32 2
  %capacity = load i64, ptr %fp4, align 8
  %2 = icmp sge i64 %c2, %capacity
  br i1 %2, label %then, label %else

then:                                             ; preds = %body
  %self5 = load ptr, ptr %self, align 8
  %fp6 = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %self5, i32 0, i32 2
  %capacity7 = load i64, ptr %fp6, align 8
  store i64 %capacity7, ptr %old_cap, align 8
  %old_cap8 = load i64, ptr %old_cap, align 8
  %3 = mul i64 %old_cap8, 2
  store i64 %3, ptr %new_cap, align 8
  %self9 = load ptr, ptr %self, align 8
  %fp10 = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %self9, i32 0, i32 0
  %self11 = load ptr, ptr %self, align 8
  %fp12 = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %self11, i32 0, i32 0
  %data = load ptr, ptr %fp12, align 8
  %old_cap13 = load i64, ptr %old_cap, align 8
  %4 = mul i64 %old_cap13, 8
  %new_cap14 = load i64, ptr %new_cap, align 8
  %5 = mul i64 %new_cap14, 8
  %res = call ptr @lunite_realloc(ptr %data, i64 %4, i64 %5)
  store ptr %res, ptr %fp10, align 8
  %self15 = load ptr, ptr %self, align 8
  %fp16 = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %self15, i32 0, i32 2
  %new_cap17 = load i64, ptr %new_cap, align 8
  store i64 %new_cap17, ptr %fp16, align 8
  br label %cont

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else, %then
  %self18 = load ptr, ptr %self, align 8
  %fp19 = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %self18, i32 0, i32 0
  %data20 = load ptr, ptr %fp19, align 8
  %c21 = load i64, ptr %c, align 8
  %ptr = getelementptr ptr, ptr %data20, i64 %c21
  %val22 = load ptr, ptr %val, align 8
  %old = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val22)
  store ptr %val22, ptr %ptr, align 8
  call void @lunite_release(ptr %old)
  %self23 = load ptr, ptr %self, align 8
  %fp24 = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %self23, i32 0, i32 1
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
  %fp32 = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %self31, i32 0, i32 1
  %count33 = load i64, ptr %fp32, align 8
  store i64 %count33, ptr %c34, align 8
  %c35 = load i64, ptr %c34, align 8
  %self36 = load ptr, ptr %self29, align 8
  %fp37 = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %self36, i32 0, i32 2
  %capacity38 = load i64, ptr %fp37, align 8
  %7 = icmp sge i64 %c35, %capacity38
  br i1 %7, label %then39, label %else40

then39:                                           ; preds = %body28
  %self42 = load ptr, ptr %self29, align 8
  %fp43 = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %self42, i32 0, i32 2
  %capacity44 = load i64, ptr %fp43, align 8
  store i64 %capacity44, ptr %old_cap45, align 8
  %old_cap46 = load i64, ptr %old_cap45, align 8
  %8 = mul i64 %old_cap46, 2
  store i64 %8, ptr %new_cap47, align 8
  %self48 = load ptr, ptr %self29, align 8
  %fp49 = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %self48, i32 0, i32 0
  %self50 = load ptr, ptr %self29, align 8
  %fp51 = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %self50, i32 0, i32 0
  %data52 = load ptr, ptr %fp51, align 8
  %old_cap53 = load i64, ptr %old_cap45, align 8
  %9 = mul i64 %old_cap53, 8
  %new_cap54 = load i64, ptr %new_cap47, align 8
  %10 = mul i64 %new_cap54, 8
  %res55 = call ptr @lunite_realloc(ptr %data52, i64 %9, i64 %10)
  store ptr %res55, ptr %fp49, align 8
  %self56 = load ptr, ptr %self29, align 8
  %fp57 = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %self56, i32 0, i32 2
  %new_cap58 = load i64, ptr %new_cap47, align 8
  store i64 %new_cap58, ptr %fp57, align 8
  br label %cont41

else40:                                           ; preds = %body28
  br label %cont41

cont41:                                           ; preds = %else40, %then39
  %self59 = load ptr, ptr %self29, align 8
  %fp60 = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %self59, i32 0, i32 0
  %data61 = load ptr, ptr %fp60, align 8
  %c62 = load i64, ptr %c34, align 8
  %ptr63 = getelementptr ptr, ptr %data61, i64 %c62
  %val64 = load ptr, ptr %val30, align 8
  %old65 = load ptr, ptr %ptr63, align 8
  call void @lunite_retain(ptr %val64)
  store ptr %val64, ptr %ptr63, align 8
  call void @lunite_release(ptr %old65)
  %self66 = load ptr, ptr %self29, align 8
  %fp67 = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %self66, i32 0, i32 1
  %c68 = load i64, ptr %c34, align 8
  %11 = add i64 %c68, 1
  store i64 %11, ptr %fp67, align 8
  %tmp69 = load ptr, ptr %val30, align 8
  call void @lunite_release(ptr %tmp69)
  %tmp70 = load ptr, ptr %self29, align 8
  call void @lunite_release(ptr %tmp70)
  ret void
}

declare ptr @list_List_map_MapEntry_string_semantic_Symbol___new.3()

declare void @list_List_map_MapEntry_string_semantic_Symbol___push.4(ptr %0, ptr %1)

define ptr @list_List_map_MapEntry_string_semantic_Symbol__new() {
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
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%list_List_map_MapEntry_string_semantic_Symbol__.3, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %ptr, i32 0, i32 0
  %p2 = load ptr, ptr %p, align 8
  store ptr %p2, ptr %fp, align 8
  %fp3 = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %ptr, i32 0, i32 1
  store i64 0, ptr %fp3, align 8
  %fp4 = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %ptr, i32 0, i32 2
  %initial_cap5 = load i64, ptr %initial_cap, align 8
  store i64 %initial_cap5, ptr %fp4, align 8
  call void @lunite_retain(ptr %ptr)
  ret ptr %ptr
}

define void @list_List_map_MapEntry_string_semantic_Symbol__push(ptr %0, ptr %1) {
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
  %fp = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  store i64 %count, ptr %c, align 8
  %c2 = load i64, ptr %c, align 8
  %self3 = load ptr, ptr %self, align 8
  %fp4 = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %self3, i32 0, i32 2
  %capacity = load i64, ptr %fp4, align 8
  %2 = icmp sge i64 %c2, %capacity
  br i1 %2, label %then, label %else

then:                                             ; preds = %body
  %self5 = load ptr, ptr %self, align 8
  %fp6 = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %self5, i32 0, i32 2
  %capacity7 = load i64, ptr %fp6, align 8
  store i64 %capacity7, ptr %old_cap, align 8
  %old_cap8 = load i64, ptr %old_cap, align 8
  %3 = mul i64 %old_cap8, 2
  store i64 %3, ptr %new_cap, align 8
  %self9 = load ptr, ptr %self, align 8
  %fp10 = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %self9, i32 0, i32 0
  %self11 = load ptr, ptr %self, align 8
  %fp12 = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %self11, i32 0, i32 0
  %data = load ptr, ptr %fp12, align 8
  %old_cap13 = load i64, ptr %old_cap, align 8
  %4 = mul i64 %old_cap13, 8
  %new_cap14 = load i64, ptr %new_cap, align 8
  %5 = mul i64 %new_cap14, 8
  %res = call ptr @lunite_realloc(ptr %data, i64 %4, i64 %5)
  store ptr %res, ptr %fp10, align 8
  %self15 = load ptr, ptr %self, align 8
  %fp16 = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %self15, i32 0, i32 2
  %new_cap17 = load i64, ptr %new_cap, align 8
  store i64 %new_cap17, ptr %fp16, align 8
  br label %cont

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else, %then
  %self18 = load ptr, ptr %self, align 8
  %fp19 = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %self18, i32 0, i32 0
  %data20 = load ptr, ptr %fp19, align 8
  %c21 = load i64, ptr %c, align 8
  %ptr = getelementptr ptr, ptr %data20, i64 %c21
  %val22 = load ptr, ptr %val, align 8
  %old = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val22)
  store ptr %val22, ptr %ptr, align 8
  call void @lunite_release(ptr %old)
  %self23 = load ptr, ptr %self, align 8
  %fp24 = getelementptr inbounds %list_List_map_MapEntry_string_semantic_Symbol__.3, ptr %self23, i32 0, i32 1
  %c25 = load i64, ptr %c, align 8
  %6 = add i64 %c25, 1
  store i64 %6, ptr %fp24, align 8
  %tmp = load ptr, ptr %val, align 8
  call void @lunite_release(ptr %tmp)
  %tmp26 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp26)
  ret void
}

define i64 @list_List_map_MapEntry_K__V___len(ptr %0) {
entry:
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_map_MapEntry_K__V__.0, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret i64 %count
}

define ptr @list_List_map_MapEntry_K__V___get_ptr(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_map_MapEntry_K__V__.0, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %ptr
}

define ptr @list_List_map_MapEntry_K__V___get(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_map_MapEntry_K__V__.0, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %val = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val)
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %val
}

define ptr @list_List_map_MapEntry_K__V___new() {
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
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%list_List_map_MapEntry_K__V__.0, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %list_List_map_MapEntry_K__V__.0, ptr %ptr, i32 0, i32 0
  %p2 = load ptr, ptr %p, align 8
  store ptr %p2, ptr %fp, align 8
  %fp3 = getelementptr inbounds %list_List_map_MapEntry_K__V__.0, ptr %ptr, i32 0, i32 1
  store i64 0, ptr %fp3, align 8
  %fp4 = getelementptr inbounds %list_List_map_MapEntry_K__V__.0, ptr %ptr, i32 0, i32 2
  %initial_cap5 = load i64, ptr %initial_cap, align 8
  store i64 %initial_cap5, ptr %fp4, align 8
  call void @lunite_retain(ptr %ptr)
  ret ptr %ptr
}

define void @list_List_map_MapEntry_K__V___push(ptr %0, ptr %1) {
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
  %fp = getelementptr inbounds %list_List_map_MapEntry_K__V__.0, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  store i64 %count, ptr %c, align 8
  %c2 = load i64, ptr %c, align 8
  %self3 = load ptr, ptr %self, align 8
  %fp4 = getelementptr inbounds %list_List_map_MapEntry_K__V__.0, ptr %self3, i32 0, i32 2
  %capacity = load i64, ptr %fp4, align 8
  %2 = icmp sge i64 %c2, %capacity
  br i1 %2, label %then, label %else

then:                                             ; preds = %body
  %self5 = load ptr, ptr %self, align 8
  %fp6 = getelementptr inbounds %list_List_map_MapEntry_K__V__.0, ptr %self5, i32 0, i32 2
  %capacity7 = load i64, ptr %fp6, align 8
  store i64 %capacity7, ptr %old_cap, align 8
  %old_cap8 = load i64, ptr %old_cap, align 8
  %3 = mul i64 %old_cap8, 2
  store i64 %3, ptr %new_cap, align 8
  %self9 = load ptr, ptr %self, align 8
  %fp10 = getelementptr inbounds %list_List_map_MapEntry_K__V__.0, ptr %self9, i32 0, i32 0
  %self11 = load ptr, ptr %self, align 8
  %fp12 = getelementptr inbounds %list_List_map_MapEntry_K__V__.0, ptr %self11, i32 0, i32 0
  %data = load ptr, ptr %fp12, align 8
  %old_cap13 = load i64, ptr %old_cap, align 8
  %4 = mul i64 %old_cap13, 8
  %new_cap14 = load i64, ptr %new_cap, align 8
  %5 = mul i64 %new_cap14, 8
  %res = call ptr @lunite_realloc(ptr %data, i64 %4, i64 %5)
  store ptr %res, ptr %fp10, align 8
  %self15 = load ptr, ptr %self, align 8
  %fp16 = getelementptr inbounds %list_List_map_MapEntry_K__V__.0, ptr %self15, i32 0, i32 2
  %new_cap17 = load i64, ptr %new_cap, align 8
  store i64 %new_cap17, ptr %fp16, align 8
  br label %cont

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else, %then
  %self18 = load ptr, ptr %self, align 8
  %fp19 = getelementptr inbounds %list_List_map_MapEntry_K__V__.0, ptr %self18, i32 0, i32 0
  %data20 = load ptr, ptr %fp19, align 8
  %c21 = load i64, ptr %c, align 8
  %ptr = getelementptr ptr, ptr %data20, i64 %c21
  %val22 = load ptr, ptr %val, align 8
  %old = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val22)
  store ptr %val22, ptr %ptr, align 8
  call void @lunite_release(ptr %old)
  %self23 = load ptr, ptr %self, align 8
  %fp24 = getelementptr inbounds %list_List_map_MapEntry_K__V__.0, ptr %self23, i32 0, i32 1
  %c25 = load i64, ptr %c, align 8
  %6 = add i64 %c25, 1
  store i64 %6, ptr %fp24, align 8
  %tmp = load ptr, ptr %val, align 8
  call void @lunite_release(ptr %tmp)
  %tmp26 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp26)
  ret void
}

define ptr @map_Map_string_semantic_Symbol__new() {
entry:
  br label %body

body:                                             ; preds = %entry
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%map_Map_string_semantic_Symbol_, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %map_Map_string_semantic_Symbol_, ptr %ptr, i32 0, i32 0
  %res = call ptr @list_List_map_MapEntry_K__V___new()
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %fp, align 8
  call void @lunite_retain(ptr %ptr)
  ret ptr %ptr
}

define void @map_Map_string_semantic_Symbol__put(ptr %0, ptr %1, ptr %2) {
entry:
  %entry_ptr = alloca ptr, align 8
  %found = alloca i1, align 1
  %i = alloca i64, align 8
  %value = alloca ptr, align 8
  %key = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %key, align 8
  call void @lunite_retain(ptr %2)
  store ptr %2, ptr %value, align 8
  store i64 0, ptr %i, align 8
  store i1 false, ptr %found, align 1
  br label %while_cond

while_cond:                                       ; preds = %cont, %body
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %map_Map_string_semantic_Symbol_, ptr %self1, i32 0, i32 0
  %entries = load ptr, ptr %fp, align 8
  call void @lunite_retain(ptr %entries)
  %res = call i64 @list_List_map_MapEntry_string_semantic_Symbol__len(ptr %entries)
  %i2 = load i64, ptr %i, align 8
  %3 = icmp sgt i64 %res, %i2
  br i1 %3, label %while_body, label %while_end

while_body:                                       ; preds = %while_cond
  %self3 = load ptr, ptr %self, align 8
  %fp4 = getelementptr inbounds %map_Map_string_semantic_Symbol_, ptr %self3, i32 0, i32 0
  %entries5 = load ptr, ptr %fp4, align 8
  call void @lunite_retain(ptr %entries5)
  %i6 = load i64, ptr %i, align 8
  %res7 = call ptr @list_List_map_MapEntry_string_semantic_Symbol__get_ptr(ptr %entries5, i64 %i6)
  store ptr %res7, ptr %entry_ptr, align 8
  %entry_ptr8 = load ptr, ptr %entry_ptr, align 8
  %fp9 = getelementptr inbounds %map_MapEntry_string_semantic_Symbol_.1, ptr %entry_ptr8, i32 0, i32 0
  %key10 = load ptr, ptr %fp9, align 8
  %key11 = load ptr, ptr %key, align 8
  %seq = call i64 @lunite_str_eq(ptr %key10, ptr %key11)
  %bool = icmp ne i64 %seq, 0
  br i1 %bool, label %then, label %else

while_end:                                        ; preds = %while_cond
  %found16 = load i1, ptr %found, align 1
  %4 = icmp eq i1 %found16, false
  br i1 %4, label %then17, label %else18

then:                                             ; preds = %while_body
  %entry_ptr12 = load ptr, ptr %entry_ptr, align 8
  %fp13 = getelementptr inbounds %map_MapEntry_string_semantic_Symbol_.1, ptr %entry_ptr12, i32 0, i32 1
  %value14 = load ptr, ptr %value, align 8
  %old = load ptr, ptr %fp13, align 8
  call void @lunite_retain(ptr %value14)
  store ptr %value14, ptr %fp13, align 8
  call void @lunite_release(ptr %old)
  store i1 true, ptr %found, align 1
  br label %cont

else:                                             ; preds = %while_body
  br label %cont

cont:                                             ; preds = %else, %then
  %i15 = load i64, ptr %i, align 8
  %5 = add i64 %i15, 1
  store i64 %5, ptr %i, align 8
  br label %while_cond

then17:                                           ; preds = %while_end
  %self20 = load ptr, ptr %self, align 8
  %fp21 = getelementptr inbounds %map_Map_string_semantic_Symbol_, ptr %self20, i32 0, i32 0
  %entries22 = load ptr, ptr %fp21, align 8
  call void @lunite_retain(ptr %entries22)
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%map_MapEntry_string_semantic_Symbol_.1, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp23 = getelementptr inbounds %map_MapEntry_string_semantic_Symbol_.1, ptr %ptr, i32 0, i32 0
  %key24 = load ptr, ptr %key, align 8
  call void @lunite_retain(ptr %key24)
  store ptr %key24, ptr %fp23, align 8
  %fp25 = getelementptr inbounds %map_MapEntry_string_semantic_Symbol_.1, ptr %ptr, i32 0, i32 1
  %value26 = load ptr, ptr %value, align 8
  call void @lunite_retain(ptr %value26)
  store ptr %value26, ptr %fp25, align 8
  call void @lunite_retain(ptr %ptr)
  call void @list_List_map_MapEntry_string_semantic_Symbol__push(ptr %entries22, ptr %ptr)
  br label %cont19

else18:                                           ; preds = %while_end
  br label %cont19

cont19:                                           ; preds = %else18, %then17
  %tmp = load ptr, ptr %value, align 8
  call void @lunite_release(ptr %tmp)
  %tmp27 = load ptr, ptr %key, align 8
  call void @lunite_release(ptr %tmp27)
  %tmp28 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp28)
  ret void
}

define ptr @map_Map_string_semantic_Symbol__get(ptr %0, ptr %1) {
entry:
  %entry8 = alloca ptr, align 8
  %i = alloca i64, align 8
  %key = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %key, align 8
  store i64 0, ptr %i, align 8
  br label %while_cond

while_cond:                                       ; preds = %cont, %body
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %map_Map_string_semantic_Symbol_, ptr %self1, i32 0, i32 0
  %entries = load ptr, ptr %fp, align 8
  call void @lunite_retain(ptr %entries)
  %res = call i64 @list_List_map_MapEntry_string_semantic_Symbol__len(ptr %entries)
  %i2 = load i64, ptr %i, align 8
  %2 = icmp sgt i64 %res, %i2
  br i1 %2, label %while_body, label %while_end

while_body:                                       ; preds = %while_cond
  %self3 = load ptr, ptr %self, align 8
  %fp4 = getelementptr inbounds %map_Map_string_semantic_Symbol_, ptr %self3, i32 0, i32 0
  %entries5 = load ptr, ptr %fp4, align 8
  call void @lunite_retain(ptr %entries5)
  %i6 = load i64, ptr %i, align 8
  %res7 = call ptr @list_List_map_MapEntry_string_semantic_Symbol__get(ptr %entries5, i64 %i6)
  call void @lunite_retain(ptr %res7)
  store ptr %res7, ptr %entry8, align 8
  %entry9 = load ptr, ptr %entry8, align 8
  %fp10 = getelementptr inbounds %map_MapEntry_string_semantic_Symbol_.1, ptr %entry9, i32 0, i32 0
  %key11 = load ptr, ptr %fp10, align 8
  %key12 = load ptr, ptr %key, align 8
  %seq = call i64 @lunite_str_eq(ptr %key11, ptr %key12)
  %bool = icmp ne i64 %seq, 0
  br i1 %bool, label %then, label %else

while_end:                                        ; preds = %while_cond
  %tmp19 = load ptr, ptr %key, align 8
  call void @lunite_release(ptr %tmp19)
  %tmp20 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp20)
  ret i64 0

then:                                             ; preds = %while_body
  %entry13 = load ptr, ptr %entry8, align 8
  %fp14 = getelementptr inbounds %map_MapEntry_string_semantic_Symbol_.1, ptr %entry13, i32 0, i32 1
  %value = load ptr, ptr %fp14, align 8
  call void @lunite_retain(ptr %value)
  %tmp = load ptr, ptr %entry8, align 8
  call void @lunite_release(ptr %tmp)
  %tmp15 = load ptr, ptr %key, align 8
  call void @lunite_release(ptr %tmp15)
  %tmp16 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp16)
  ret ptr %value

else:                                             ; preds = %while_body
  br label %cont

cont:                                             ; preds = %else
  %i17 = load i64, ptr %i, align 8
  %3 = add i64 %i17, 1
  store i64 %3, ptr %i, align 8
  %tmp18 = load ptr, ptr %entry8, align 8
  call void @lunite_release(ptr %tmp18)
  br label %while_cond
}

define i1 @map_Map_string_semantic_Symbol__contains(ptr %0, ptr %1) {
entry:
  %i = alloca i64, align 8
  %key = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %key, align 8
  store i64 0, ptr %i, align 8
  br label %while_cond

while_cond:                                       ; preds = %cont, %body
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %map_Map_string_semantic_Symbol_, ptr %self1, i32 0, i32 0
  %entries = load ptr, ptr %fp, align 8
  call void @lunite_retain(ptr %entries)
  %res = call i64 @list_List_map_MapEntry_string_semantic_Symbol__len(ptr %entries)
  %i2 = load i64, ptr %i, align 8
  %2 = icmp sgt i64 %res, %i2
  br i1 %2, label %while_body, label %while_end

while_body:                                       ; preds = %while_cond
  %self3 = load ptr, ptr %self, align 8
  %fp4 = getelementptr inbounds %map_Map_string_semantic_Symbol_, ptr %self3, i32 0, i32 0
  %entries5 = load ptr, ptr %fp4, align 8
  call void @lunite_retain(ptr %entries5)
  %i6 = load i64, ptr %i, align 8
  %res7 = call ptr @list_List_map_MapEntry_string_semantic_Symbol__get(ptr %entries5, i64 %i6)
  %fp8 = getelementptr inbounds %map_MapEntry_string_semantic_Symbol_.1, ptr %res7, i32 0, i32 0
  %key9 = load ptr, ptr %fp8, align 8
  %key10 = load ptr, ptr %key, align 8
  %seq = call i64 @lunite_str_eq(ptr %key9, ptr %key10)
  %bool = icmp ne i64 %seq, 0
  br i1 %bool, label %then, label %else

while_end:                                        ; preds = %while_cond
  %tmp13 = load ptr, ptr %key, align 8
  call void @lunite_release(ptr %tmp13)
  %tmp14 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp14)
  ret i1 false

then:                                             ; preds = %while_body
  %tmp = load ptr, ptr %key, align 8
  call void @lunite_release(ptr %tmp)
  %tmp11 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp11)
  ret i1 true

else:                                             ; preds = %while_body
  br label %cont

cont:                                             ; preds = %else
  %i12 = load i64, ptr %i, align 8
  %3 = add i64 %i12, 1
  store i64 %3, ptr %i, align 8
  br label %while_cond
}

define i64 @list_List_semantic_Scope__len(ptr %0) {
entry:
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_semantic_Scope_, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret i64 %count
}

define ptr @list_List_semantic_Scope__get_ptr(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_semantic_Scope_, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %ptr
}

define ptr @list_List_semantic_Scope__get(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_semantic_Scope_, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %val = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val)
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %val
}

define ptr @list_List_semantic_Scope__new() {
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
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%list_List_semantic_Scope_, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %list_List_semantic_Scope_, ptr %ptr, i32 0, i32 0
  %p2 = load ptr, ptr %p, align 8
  store ptr %p2, ptr %fp, align 8
  %fp3 = getelementptr inbounds %list_List_semantic_Scope_, ptr %ptr, i32 0, i32 1
  store i64 0, ptr %fp3, align 8
  %fp4 = getelementptr inbounds %list_List_semantic_Scope_, ptr %ptr, i32 0, i32 2
  %initial_cap5 = load i64, ptr %initial_cap, align 8
  store i64 %initial_cap5, ptr %fp4, align 8
  call void @lunite_retain(ptr %ptr)
  ret ptr %ptr
}

define void @list_List_semantic_Scope__push(ptr %0, ptr %1) {
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
  %fp = getelementptr inbounds %list_List_semantic_Scope_, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  store i64 %count, ptr %c, align 8
  %c2 = load i64, ptr %c, align 8
  %self3 = load ptr, ptr %self, align 8
  %fp4 = getelementptr inbounds %list_List_semantic_Scope_, ptr %self3, i32 0, i32 2
  %capacity = load i64, ptr %fp4, align 8
  %2 = icmp sge i64 %c2, %capacity
  br i1 %2, label %then, label %else

then:                                             ; preds = %body
  %self5 = load ptr, ptr %self, align 8
  %fp6 = getelementptr inbounds %list_List_semantic_Scope_, ptr %self5, i32 0, i32 2
  %capacity7 = load i64, ptr %fp6, align 8
  store i64 %capacity7, ptr %old_cap, align 8
  %old_cap8 = load i64, ptr %old_cap, align 8
  %3 = mul i64 %old_cap8, 2
  store i64 %3, ptr %new_cap, align 8
  %self9 = load ptr, ptr %self, align 8
  %fp10 = getelementptr inbounds %list_List_semantic_Scope_, ptr %self9, i32 0, i32 0
  %self11 = load ptr, ptr %self, align 8
  %fp12 = getelementptr inbounds %list_List_semantic_Scope_, ptr %self11, i32 0, i32 0
  %data = load ptr, ptr %fp12, align 8
  %old_cap13 = load i64, ptr %old_cap, align 8
  %4 = mul i64 %old_cap13, 8
  %new_cap14 = load i64, ptr %new_cap, align 8
  %5 = mul i64 %new_cap14, 8
  %res = call ptr @lunite_realloc(ptr %data, i64 %4, i64 %5)
  store ptr %res, ptr %fp10, align 8
  %self15 = load ptr, ptr %self, align 8
  %fp16 = getelementptr inbounds %list_List_semantic_Scope_, ptr %self15, i32 0, i32 2
  %new_cap17 = load i64, ptr %new_cap, align 8
  store i64 %new_cap17, ptr %fp16, align 8
  br label %cont

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else, %then
  %self18 = load ptr, ptr %self, align 8
  %fp19 = getelementptr inbounds %list_List_semantic_Scope_, ptr %self18, i32 0, i32 0
  %data20 = load ptr, ptr %fp19, align 8
  %c21 = load i64, ptr %c, align 8
  %ptr = getelementptr ptr, ptr %data20, i64 %c21
  %val22 = load ptr, ptr %val, align 8
  %old = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val22)
  store ptr %val22, ptr %ptr, align 8
  call void @lunite_release(ptr %old)
  %self23 = load ptr, ptr %self, align 8
  %fp24 = getelementptr inbounds %list_List_semantic_Scope_, ptr %self23, i32 0, i32 1
  %c25 = load i64, ptr %c, align 8
  %6 = add i64 %c25, 1
  store i64 %6, ptr %fp24, align 8
  %tmp = load ptr, ptr %val, align 8
  call void @lunite_release(ptr %tmp)
  %tmp26 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp26)
  ret void
}

define i64 @list_List_map_MapEntry_string_string_len(ptr %0) {
entry:
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret i64 %count
}

define ptr @list_List_map_MapEntry_string_string_get_ptr(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %ptr
}

define ptr @list_List_map_MapEntry_string_string_get(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %val = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val)
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %val
}

define i64 @list_List_map_MapEntry_string_string__len(ptr %0) {
entry:
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret i64 %count
}

define ptr @list_List_map_MapEntry_string_string__get_ptr(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %ptr
}

define ptr @list_List_map_MapEntry_string_string__get(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %val = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val)
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %val
}

define ptr @list_List_map_MapEntry_string_string__new() {
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
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%list_List_map_MapEntry_string_string_.4, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %ptr, i32 0, i32 0
  %p2 = load ptr, ptr %p, align 8
  store ptr %p2, ptr %fp, align 8
  %fp3 = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %ptr, i32 0, i32 1
  store i64 0, ptr %fp3, align 8
  %fp4 = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %ptr, i32 0, i32 2
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
  %ptr12 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%list_List_map_MapEntry_string_string_.4, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp13 = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %ptr12, i32 0, i32 0
  %p14 = load ptr, ptr %p11, align 8
  store ptr %p14, ptr %fp13, align 8
  %fp15 = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %ptr12, i32 0, i32 1
  store i64 0, ptr %fp15, align 8
  %fp16 = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %ptr12, i32 0, i32 2
  %initial_cap17 = load i64, ptr %initial_cap8, align 8
  store i64 %initial_cap17, ptr %fp16, align 8
  call void @lunite_retain(ptr %ptr12)
  ret ptr %ptr12
}

define void @list_List_map_MapEntry_string_string__push(ptr %0, ptr %1) {
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
  %fp = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  store i64 %count, ptr %c, align 8
  %c2 = load i64, ptr %c, align 8
  %self3 = load ptr, ptr %self, align 8
  %fp4 = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %self3, i32 0, i32 2
  %capacity = load i64, ptr %fp4, align 8
  %2 = icmp sge i64 %c2, %capacity
  br i1 %2, label %then, label %else

then:                                             ; preds = %body
  %self5 = load ptr, ptr %self, align 8
  %fp6 = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %self5, i32 0, i32 2
  %capacity7 = load i64, ptr %fp6, align 8
  store i64 %capacity7, ptr %old_cap, align 8
  %old_cap8 = load i64, ptr %old_cap, align 8
  %3 = mul i64 %old_cap8, 2
  store i64 %3, ptr %new_cap, align 8
  %self9 = load ptr, ptr %self, align 8
  %fp10 = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %self9, i32 0, i32 0
  %self11 = load ptr, ptr %self, align 8
  %fp12 = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %self11, i32 0, i32 0
  %data = load ptr, ptr %fp12, align 8
  %old_cap13 = load i64, ptr %old_cap, align 8
  %4 = mul i64 %old_cap13, 8
  %new_cap14 = load i64, ptr %new_cap, align 8
  %5 = mul i64 %new_cap14, 8
  %res = call ptr @lunite_realloc(ptr %data, i64 %4, i64 %5)
  store ptr %res, ptr %fp10, align 8
  %self15 = load ptr, ptr %self, align 8
  %fp16 = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %self15, i32 0, i32 2
  %new_cap17 = load i64, ptr %new_cap, align 8
  store i64 %new_cap17, ptr %fp16, align 8
  br label %cont

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else, %then
  %self18 = load ptr, ptr %self, align 8
  %fp19 = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %self18, i32 0, i32 0
  %data20 = load ptr, ptr %fp19, align 8
  %c21 = load i64, ptr %c, align 8
  %ptr = getelementptr ptr, ptr %data20, i64 %c21
  %val22 = load ptr, ptr %val, align 8
  %old = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val22)
  store ptr %val22, ptr %ptr, align 8
  call void @lunite_release(ptr %old)
  %self23 = load ptr, ptr %self, align 8
  %fp24 = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %self23, i32 0, i32 1
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
  %fp32 = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %self31, i32 0, i32 1
  %count33 = load i64, ptr %fp32, align 8
  store i64 %count33, ptr %c34, align 8
  %c35 = load i64, ptr %c34, align 8
  %self36 = load ptr, ptr %self29, align 8
  %fp37 = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %self36, i32 0, i32 2
  %capacity38 = load i64, ptr %fp37, align 8
  %7 = icmp sge i64 %c35, %capacity38
  br i1 %7, label %then39, label %else40

then39:                                           ; preds = %body28
  %self42 = load ptr, ptr %self29, align 8
  %fp43 = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %self42, i32 0, i32 2
  %capacity44 = load i64, ptr %fp43, align 8
  store i64 %capacity44, ptr %old_cap45, align 8
  %old_cap46 = load i64, ptr %old_cap45, align 8
  %8 = mul i64 %old_cap46, 2
  store i64 %8, ptr %new_cap47, align 8
  %self48 = load ptr, ptr %self29, align 8
  %fp49 = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %self48, i32 0, i32 0
  %self50 = load ptr, ptr %self29, align 8
  %fp51 = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %self50, i32 0, i32 0
  %data52 = load ptr, ptr %fp51, align 8
  %old_cap53 = load i64, ptr %old_cap45, align 8
  %9 = mul i64 %old_cap53, 8
  %new_cap54 = load i64, ptr %new_cap47, align 8
  %10 = mul i64 %new_cap54, 8
  %res55 = call ptr @lunite_realloc(ptr %data52, i64 %9, i64 %10)
  store ptr %res55, ptr %fp49, align 8
  %self56 = load ptr, ptr %self29, align 8
  %fp57 = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %self56, i32 0, i32 2
  %new_cap58 = load i64, ptr %new_cap47, align 8
  store i64 %new_cap58, ptr %fp57, align 8
  br label %cont41

else40:                                           ; preds = %body28
  br label %cont41

cont41:                                           ; preds = %else40, %then39
  %self59 = load ptr, ptr %self29, align 8
  %fp60 = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %self59, i32 0, i32 0
  %data61 = load ptr, ptr %fp60, align 8
  %c62 = load i64, ptr %c34, align 8
  %ptr63 = getelementptr ptr, ptr %data61, i64 %c62
  %val64 = load ptr, ptr %val30, align 8
  %old65 = load ptr, ptr %ptr63, align 8
  call void @lunite_retain(ptr %val64)
  store ptr %val64, ptr %ptr63, align 8
  call void @lunite_release(ptr %old65)
  %self66 = load ptr, ptr %self29, align 8
  %fp67 = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %self66, i32 0, i32 1
  %c68 = load i64, ptr %c34, align 8
  %11 = add i64 %c68, 1
  store i64 %11, ptr %fp67, align 8
  %tmp69 = load ptr, ptr %val30, align 8
  call void @lunite_release(ptr %tmp69)
  %tmp70 = load ptr, ptr %self29, align 8
  call void @lunite_release(ptr %tmp70)
  ret void
}

declare ptr @list_List_map_MapEntry_string_string__new.5()

declare void @list_List_map_MapEntry_string_string__push.6(ptr %0, ptr %1)

define ptr @list_List_map_MapEntry_string_string_new() {
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
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%list_List_map_MapEntry_string_string_.4, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %ptr, i32 0, i32 0
  %p2 = load ptr, ptr %p, align 8
  store ptr %p2, ptr %fp, align 8
  %fp3 = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %ptr, i32 0, i32 1
  store i64 0, ptr %fp3, align 8
  %fp4 = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %ptr, i32 0, i32 2
  %initial_cap5 = load i64, ptr %initial_cap, align 8
  store i64 %initial_cap5, ptr %fp4, align 8
  call void @lunite_retain(ptr %ptr)
  ret ptr %ptr
}

define void @list_List_map_MapEntry_string_string_push(ptr %0, ptr %1) {
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
  %fp = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  store i64 %count, ptr %c, align 8
  %c2 = load i64, ptr %c, align 8
  %self3 = load ptr, ptr %self, align 8
  %fp4 = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %self3, i32 0, i32 2
  %capacity = load i64, ptr %fp4, align 8
  %2 = icmp sge i64 %c2, %capacity
  br i1 %2, label %then, label %else

then:                                             ; preds = %body
  %self5 = load ptr, ptr %self, align 8
  %fp6 = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %self5, i32 0, i32 2
  %capacity7 = load i64, ptr %fp6, align 8
  store i64 %capacity7, ptr %old_cap, align 8
  %old_cap8 = load i64, ptr %old_cap, align 8
  %3 = mul i64 %old_cap8, 2
  store i64 %3, ptr %new_cap, align 8
  %self9 = load ptr, ptr %self, align 8
  %fp10 = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %self9, i32 0, i32 0
  %self11 = load ptr, ptr %self, align 8
  %fp12 = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %self11, i32 0, i32 0
  %data = load ptr, ptr %fp12, align 8
  %old_cap13 = load i64, ptr %old_cap, align 8
  %4 = mul i64 %old_cap13, 8
  %new_cap14 = load i64, ptr %new_cap, align 8
  %5 = mul i64 %new_cap14, 8
  %res = call ptr @lunite_realloc(ptr %data, i64 %4, i64 %5)
  store ptr %res, ptr %fp10, align 8
  %self15 = load ptr, ptr %self, align 8
  %fp16 = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %self15, i32 0, i32 2
  %new_cap17 = load i64, ptr %new_cap, align 8
  store i64 %new_cap17, ptr %fp16, align 8
  br label %cont

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else, %then
  %self18 = load ptr, ptr %self, align 8
  %fp19 = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %self18, i32 0, i32 0
  %data20 = load ptr, ptr %fp19, align 8
  %c21 = load i64, ptr %c, align 8
  %ptr = getelementptr ptr, ptr %data20, i64 %c21
  %val22 = load ptr, ptr %val, align 8
  %old = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val22)
  store ptr %val22, ptr %ptr, align 8
  call void @lunite_release(ptr %old)
  %self23 = load ptr, ptr %self, align 8
  %fp24 = getelementptr inbounds %list_List_map_MapEntry_string_string_.4, ptr %self23, i32 0, i32 1
  %c25 = load i64, ptr %c, align 8
  %6 = add i64 %c25, 1
  store i64 %6, ptr %fp24, align 8
  %tmp = load ptr, ptr %val, align 8
  call void @lunite_release(ptr %tmp)
  %tmp26 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp26)
  ret void
}

define ptr @map_Map_string_string_new() {
entry:
  br label %body

body:                                             ; preds = %entry
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%map_Map_string_string, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %map_Map_string_string, ptr %ptr, i32 0, i32 0
  %res = call ptr @list_List_map_MapEntry_K__V___new()
  call void @lunite_retain(ptr %res)
  store ptr %res, ptr %fp, align 8
  call void @lunite_retain(ptr %ptr)
  ret ptr %ptr
}

define void @map_Map_string_string_put(ptr %0, ptr %1, ptr %2) {
entry:
  %entry_ptr = alloca ptr, align 8
  %found = alloca i1, align 1
  %i = alloca i64, align 8
  %value = alloca ptr, align 8
  %key = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %key, align 8
  call void @lunite_retain(ptr %2)
  store ptr %2, ptr %value, align 8
  store i64 0, ptr %i, align 8
  store i1 false, ptr %found, align 1
  br label %while_cond

while_cond:                                       ; preds = %cont, %body
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %map_Map_string_string, ptr %self1, i32 0, i32 0
  %entries = load ptr, ptr %fp, align 8
  call void @lunite_retain(ptr %entries)
  %res = call i64 @list_List_map_MapEntry_string_string_len(ptr %entries)
  %i2 = load i64, ptr %i, align 8
  %3 = icmp sgt i64 %res, %i2
  br i1 %3, label %while_body, label %while_end

while_body:                                       ; preds = %while_cond
  %self3 = load ptr, ptr %self, align 8
  %fp4 = getelementptr inbounds %map_Map_string_string, ptr %self3, i32 0, i32 0
  %entries5 = load ptr, ptr %fp4, align 8
  call void @lunite_retain(ptr %entries5)
  %i6 = load i64, ptr %i, align 8
  %res7 = call ptr @list_List_map_MapEntry_string_string_get_ptr(ptr %entries5, i64 %i6)
  store ptr %res7, ptr %entry_ptr, align 8
  %entry_ptr8 = load ptr, ptr %entry_ptr, align 8
  %fp9 = getelementptr inbounds %map_MapEntry_string_string.2, ptr %entry_ptr8, i32 0, i32 0
  %key10 = load ptr, ptr %fp9, align 8
  %key11 = load ptr, ptr %key, align 8
  %seq = call i64 @lunite_str_eq(ptr %key10, ptr %key11)
  %bool = icmp ne i64 %seq, 0
  br i1 %bool, label %then, label %else

while_end:                                        ; preds = %while_cond
  %found16 = load i1, ptr %found, align 1
  %4 = icmp eq i1 %found16, false
  br i1 %4, label %then17, label %else18

then:                                             ; preds = %while_body
  %entry_ptr12 = load ptr, ptr %entry_ptr, align 8
  %fp13 = getelementptr inbounds %map_MapEntry_string_string.2, ptr %entry_ptr12, i32 0, i32 1
  %value14 = load ptr, ptr %value, align 8
  %old = load ptr, ptr %fp13, align 8
  call void @lunite_retain(ptr %value14)
  store ptr %value14, ptr %fp13, align 8
  call void @lunite_release(ptr %old)
  store i1 true, ptr %found, align 1
  br label %cont

else:                                             ; preds = %while_body
  br label %cont

cont:                                             ; preds = %else, %then
  %i15 = load i64, ptr %i, align 8
  %5 = add i64 %i15, 1
  store i64 %5, ptr %i, align 8
  br label %while_cond

then17:                                           ; preds = %while_end
  %self20 = load ptr, ptr %self, align 8
  %fp21 = getelementptr inbounds %map_Map_string_string, ptr %self20, i32 0, i32 0
  %entries22 = load ptr, ptr %fp21, align 8
  call void @lunite_retain(ptr %entries22)
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%map_MapEntry_string_string.2, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp23 = getelementptr inbounds %map_MapEntry_string_string.2, ptr %ptr, i32 0, i32 0
  %key24 = load ptr, ptr %key, align 8
  call void @lunite_retain(ptr %key24)
  store ptr %key24, ptr %fp23, align 8
  %fp25 = getelementptr inbounds %map_MapEntry_string_string.2, ptr %ptr, i32 0, i32 1
  %value26 = load ptr, ptr %value, align 8
  call void @lunite_retain(ptr %value26)
  store ptr %value26, ptr %fp25, align 8
  call void @lunite_retain(ptr %ptr)
  call void @list_List_map_MapEntry_string_string_push(ptr %entries22, ptr %ptr)
  br label %cont19

else18:                                           ; preds = %while_end
  br label %cont19

cont19:                                           ; preds = %else18, %then17
  %tmp = load ptr, ptr %value, align 8
  call void @lunite_release(ptr %tmp)
  %tmp27 = load ptr, ptr %key, align 8
  call void @lunite_release(ptr %tmp27)
  %tmp28 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp28)
  ret void
}

define ptr @map_Map_string_string_get(ptr %0, ptr %1) {
entry:
  %entry8 = alloca ptr, align 8
  %i = alloca i64, align 8
  %key = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %key, align 8
  store i64 0, ptr %i, align 8
  br label %while_cond

while_cond:                                       ; preds = %cont, %body
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %map_Map_string_string, ptr %self1, i32 0, i32 0
  %entries = load ptr, ptr %fp, align 8
  call void @lunite_retain(ptr %entries)
  %res = call i64 @list_List_map_MapEntry_string_string_len(ptr %entries)
  %i2 = load i64, ptr %i, align 8
  %2 = icmp sgt i64 %res, %i2
  br i1 %2, label %while_body, label %while_end

while_body:                                       ; preds = %while_cond
  %self3 = load ptr, ptr %self, align 8
  %fp4 = getelementptr inbounds %map_Map_string_string, ptr %self3, i32 0, i32 0
  %entries5 = load ptr, ptr %fp4, align 8
  call void @lunite_retain(ptr %entries5)
  %i6 = load i64, ptr %i, align 8
  %res7 = call ptr @list_List_map_MapEntry_string_string_get(ptr %entries5, i64 %i6)
  call void @lunite_retain(ptr %res7)
  store ptr %res7, ptr %entry8, align 8
  %entry9 = load ptr, ptr %entry8, align 8
  %fp10 = getelementptr inbounds %map_MapEntry_string_string.2, ptr %entry9, i32 0, i32 0
  %key11 = load ptr, ptr %fp10, align 8
  %key12 = load ptr, ptr %key, align 8
  %seq = call i64 @lunite_str_eq(ptr %key11, ptr %key12)
  %bool = icmp ne i64 %seq, 0
  br i1 %bool, label %then, label %else

while_end:                                        ; preds = %while_cond
  %tmp19 = load ptr, ptr %key, align 8
  call void @lunite_release(ptr %tmp19)
  %tmp20 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp20)
  ret i64 0

then:                                             ; preds = %while_body
  %entry13 = load ptr, ptr %entry8, align 8
  %fp14 = getelementptr inbounds %map_MapEntry_string_string.2, ptr %entry13, i32 0, i32 1
  %value = load ptr, ptr %fp14, align 8
  call void @lunite_retain(ptr %value)
  %tmp = load ptr, ptr %entry8, align 8
  call void @lunite_release(ptr %tmp)
  %tmp15 = load ptr, ptr %key, align 8
  call void @lunite_release(ptr %tmp15)
  %tmp16 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp16)
  ret ptr %value

else:                                             ; preds = %while_body
  br label %cont

cont:                                             ; preds = %else
  %i17 = load i64, ptr %i, align 8
  %3 = add i64 %i17, 1
  store i64 %3, ptr %i, align 8
  %tmp18 = load ptr, ptr %entry8, align 8
  call void @lunite_release(ptr %tmp18)
  br label %while_cond
}

define i1 @map_Map_string_string_contains(ptr %0, ptr %1) {
entry:
  %i = alloca i64, align 8
  %key = alloca ptr, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  call void @lunite_retain(ptr %1)
  store ptr %1, ptr %key, align 8
  store i64 0, ptr %i, align 8
  br label %while_cond

while_cond:                                       ; preds = %cont, %body
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %map_Map_string_string, ptr %self1, i32 0, i32 0
  %entries = load ptr, ptr %fp, align 8
  call void @lunite_retain(ptr %entries)
  %res = call i64 @list_List_map_MapEntry_string_string_len(ptr %entries)
  %i2 = load i64, ptr %i, align 8
  %2 = icmp sgt i64 %res, %i2
  br i1 %2, label %while_body, label %while_end

while_body:                                       ; preds = %while_cond
  %self3 = load ptr, ptr %self, align 8
  %fp4 = getelementptr inbounds %map_Map_string_string, ptr %self3, i32 0, i32 0
  %entries5 = load ptr, ptr %fp4, align 8
  call void @lunite_retain(ptr %entries5)
  %i6 = load i64, ptr %i, align 8
  %res7 = call ptr @list_List_map_MapEntry_string_string_get(ptr %entries5, i64 %i6)
  %fp8 = getelementptr inbounds %map_MapEntry_string_string.2, ptr %res7, i32 0, i32 0
  %key9 = load ptr, ptr %fp8, align 8
  %key10 = load ptr, ptr %key, align 8
  %seq = call i64 @lunite_str_eq(ptr %key9, ptr %key10)
  %bool = icmp ne i64 %seq, 0
  br i1 %bool, label %then, label %else

while_end:                                        ; preds = %while_cond
  %tmp13 = load ptr, ptr %key, align 8
  call void @lunite_release(ptr %tmp13)
  %tmp14 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp14)
  ret i1 false

then:                                             ; preds = %while_body
  %tmp = load ptr, ptr %key, align 8
  call void @lunite_release(ptr %tmp)
  %tmp11 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp11)
  ret i1 true

else:                                             ; preds = %while_body
  br label %cont

cont:                                             ; preds = %else
  %i12 = load i64, ptr %i, align 8
  %3 = add i64 %i12, 1
  store i64 %3, ptr %i, align 8
  br label %while_cond
}

define i64 @list_List_TItem__len(ptr %0) {
entry:
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret i64 %count
}

define ptr @list_List_TItem__get_ptr(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %ptr
}

define ptr @list_List_TItem__get(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %val = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val)
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %val
}

define i64 @list_List_semantic_TItem__len(ptr %0) {
entry:
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret i64 %count
}

define ptr @list_List_semantic_TItem__get_ptr(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %ptr
}

define ptr @list_List_semantic_TItem__get(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %val = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val)
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %val
}

define ptr @list_List_semantic_TItem__new() {
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
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%list_List_semantic_TItem_.5, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %ptr, i32 0, i32 0
  %p2 = load ptr, ptr %p, align 8
  store ptr %p2, ptr %fp, align 8
  %fp3 = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %ptr, i32 0, i32 1
  store i64 0, ptr %fp3, align 8
  %fp4 = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %ptr, i32 0, i32 2
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
  %ptr12 = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%list_List_semantic_TItem_.5, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp13 = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %ptr12, i32 0, i32 0
  %p14 = load ptr, ptr %p11, align 8
  store ptr %p14, ptr %fp13, align 8
  %fp15 = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %ptr12, i32 0, i32 1
  store i64 0, ptr %fp15, align 8
  %fp16 = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %ptr12, i32 0, i32 2
  %initial_cap17 = load i64, ptr %initial_cap8, align 8
  store i64 %initial_cap17, ptr %fp16, align 8
  call void @lunite_retain(ptr %ptr12)
  ret ptr %ptr12
}

define void @list_List_semantic_TItem__push(ptr %0, ptr %1) {
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
  %fp = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  store i64 %count, ptr %c, align 8
  %c2 = load i64, ptr %c, align 8
  %self3 = load ptr, ptr %self, align 8
  %fp4 = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %self3, i32 0, i32 2
  %capacity = load i64, ptr %fp4, align 8
  %2 = icmp sge i64 %c2, %capacity
  br i1 %2, label %then, label %else

then:                                             ; preds = %body
  %self5 = load ptr, ptr %self, align 8
  %fp6 = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %self5, i32 0, i32 2
  %capacity7 = load i64, ptr %fp6, align 8
  store i64 %capacity7, ptr %old_cap, align 8
  %old_cap8 = load i64, ptr %old_cap, align 8
  %3 = mul i64 %old_cap8, 2
  store i64 %3, ptr %new_cap, align 8
  %self9 = load ptr, ptr %self, align 8
  %fp10 = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %self9, i32 0, i32 0
  %self11 = load ptr, ptr %self, align 8
  %fp12 = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %self11, i32 0, i32 0
  %data = load ptr, ptr %fp12, align 8
  %old_cap13 = load i64, ptr %old_cap, align 8
  %4 = mul i64 %old_cap13, 8
  %new_cap14 = load i64, ptr %new_cap, align 8
  %5 = mul i64 %new_cap14, 8
  %res = call ptr @lunite_realloc(ptr %data, i64 %4, i64 %5)
  store ptr %res, ptr %fp10, align 8
  %self15 = load ptr, ptr %self, align 8
  %fp16 = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %self15, i32 0, i32 2
  %new_cap17 = load i64, ptr %new_cap, align 8
  store i64 %new_cap17, ptr %fp16, align 8
  br label %cont

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else, %then
  %self18 = load ptr, ptr %self, align 8
  %fp19 = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %self18, i32 0, i32 0
  %data20 = load ptr, ptr %fp19, align 8
  %c21 = load i64, ptr %c, align 8
  %ptr = getelementptr ptr, ptr %data20, i64 %c21
  %val22 = load ptr, ptr %val, align 8
  %old = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val22)
  store ptr %val22, ptr %ptr, align 8
  call void @lunite_release(ptr %old)
  %self23 = load ptr, ptr %self, align 8
  %fp24 = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %self23, i32 0, i32 1
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
  %fp32 = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %self31, i32 0, i32 1
  %count33 = load i64, ptr %fp32, align 8
  store i64 %count33, ptr %c34, align 8
  %c35 = load i64, ptr %c34, align 8
  %self36 = load ptr, ptr %self29, align 8
  %fp37 = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %self36, i32 0, i32 2
  %capacity38 = load i64, ptr %fp37, align 8
  %7 = icmp sge i64 %c35, %capacity38
  br i1 %7, label %then39, label %else40

then39:                                           ; preds = %body28
  %self42 = load ptr, ptr %self29, align 8
  %fp43 = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %self42, i32 0, i32 2
  %capacity44 = load i64, ptr %fp43, align 8
  store i64 %capacity44, ptr %old_cap45, align 8
  %old_cap46 = load i64, ptr %old_cap45, align 8
  %8 = mul i64 %old_cap46, 2
  store i64 %8, ptr %new_cap47, align 8
  %self48 = load ptr, ptr %self29, align 8
  %fp49 = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %self48, i32 0, i32 0
  %self50 = load ptr, ptr %self29, align 8
  %fp51 = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %self50, i32 0, i32 0
  %data52 = load ptr, ptr %fp51, align 8
  %old_cap53 = load i64, ptr %old_cap45, align 8
  %9 = mul i64 %old_cap53, 8
  %new_cap54 = load i64, ptr %new_cap47, align 8
  %10 = mul i64 %new_cap54, 8
  %res55 = call ptr @lunite_realloc(ptr %data52, i64 %9, i64 %10)
  store ptr %res55, ptr %fp49, align 8
  %self56 = load ptr, ptr %self29, align 8
  %fp57 = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %self56, i32 0, i32 2
  %new_cap58 = load i64, ptr %new_cap47, align 8
  store i64 %new_cap58, ptr %fp57, align 8
  br label %cont41

else40:                                           ; preds = %body28
  br label %cont41

cont41:                                           ; preds = %else40, %then39
  %self59 = load ptr, ptr %self29, align 8
  %fp60 = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %self59, i32 0, i32 0
  %data61 = load ptr, ptr %fp60, align 8
  %c62 = load i64, ptr %c34, align 8
  %ptr63 = getelementptr ptr, ptr %data61, i64 %c62
  %val64 = load ptr, ptr %val30, align 8
  %old65 = load ptr, ptr %ptr63, align 8
  call void @lunite_retain(ptr %val64)
  store ptr %val64, ptr %ptr63, align 8
  call void @lunite_release(ptr %old65)
  %self66 = load ptr, ptr %self29, align 8
  %fp67 = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %self66, i32 0, i32 1
  %c68 = load i64, ptr %c34, align 8
  %11 = add i64 %c68, 1
  store i64 %11, ptr %fp67, align 8
  %tmp69 = load ptr, ptr %val30, align 8
  call void @lunite_release(ptr %tmp69)
  %tmp70 = load ptr, ptr %self29, align 8
  call void @lunite_release(ptr %tmp70)
  ret void
}

declare ptr @list_List_semantic_TItem__new.7()

declare void @list_List_semantic_TItem__push.8(ptr %0, ptr %1)

define ptr @list_List_TItem__new() {
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
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%list_List_semantic_TItem_.5, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %ptr, i32 0, i32 0
  %p2 = load ptr, ptr %p, align 8
  store ptr %p2, ptr %fp, align 8
  %fp3 = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %ptr, i32 0, i32 1
  store i64 0, ptr %fp3, align 8
  %fp4 = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %ptr, i32 0, i32 2
  %initial_cap5 = load i64, ptr %initial_cap, align 8
  store i64 %initial_cap5, ptr %fp4, align 8
  call void @lunite_retain(ptr %ptr)
  ret ptr %ptr
}

define void @list_List_TItem__push(ptr %0, ptr %1) {
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
  %fp = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  store i64 %count, ptr %c, align 8
  %c2 = load i64, ptr %c, align 8
  %self3 = load ptr, ptr %self, align 8
  %fp4 = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %self3, i32 0, i32 2
  %capacity = load i64, ptr %fp4, align 8
  %2 = icmp sge i64 %c2, %capacity
  br i1 %2, label %then, label %else

then:                                             ; preds = %body
  %self5 = load ptr, ptr %self, align 8
  %fp6 = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %self5, i32 0, i32 2
  %capacity7 = load i64, ptr %fp6, align 8
  store i64 %capacity7, ptr %old_cap, align 8
  %old_cap8 = load i64, ptr %old_cap, align 8
  %3 = mul i64 %old_cap8, 2
  store i64 %3, ptr %new_cap, align 8
  %self9 = load ptr, ptr %self, align 8
  %fp10 = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %self9, i32 0, i32 0
  %self11 = load ptr, ptr %self, align 8
  %fp12 = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %self11, i32 0, i32 0
  %data = load ptr, ptr %fp12, align 8
  %old_cap13 = load i64, ptr %old_cap, align 8
  %4 = mul i64 %old_cap13, 8
  %new_cap14 = load i64, ptr %new_cap, align 8
  %5 = mul i64 %new_cap14, 8
  %res = call ptr @lunite_realloc(ptr %data, i64 %4, i64 %5)
  store ptr %res, ptr %fp10, align 8
  %self15 = load ptr, ptr %self, align 8
  %fp16 = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %self15, i32 0, i32 2
  %new_cap17 = load i64, ptr %new_cap, align 8
  store i64 %new_cap17, ptr %fp16, align 8
  br label %cont

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else, %then
  %self18 = load ptr, ptr %self, align 8
  %fp19 = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %self18, i32 0, i32 0
  %data20 = load ptr, ptr %fp19, align 8
  %c21 = load i64, ptr %c, align 8
  %ptr = getelementptr ptr, ptr %data20, i64 %c21
  %val22 = load ptr, ptr %val, align 8
  %old = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val22)
  store ptr %val22, ptr %ptr, align 8
  call void @lunite_release(ptr %old)
  %self23 = load ptr, ptr %self, align 8
  %fp24 = getelementptr inbounds %list_List_semantic_TItem_.5, ptr %self23, i32 0, i32 1
  %c25 = load i64, ptr %c, align 8
  %6 = add i64 %c25, 1
  store i64 %6, ptr %fp24, align 8
  %tmp = load ptr, ptr %val, align 8
  call void @lunite_release(ptr %tmp)
  %tmp26 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp26)
  ret void
}

define i64 @list_List_ast_EnumVariant__len(ptr %0) {
entry:
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_ast_EnumVariant_, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret i64 %count
}

define ptr @list_List_ast_EnumVariant__get_ptr(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_ast_EnumVariant_, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %ptr
}

define ptr @list_List_ast_EnumVariant__get(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_ast_EnumVariant_, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %val = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val)
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %val
}

define ptr @list_List_ast_EnumVariant__new() {
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
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%list_List_ast_EnumVariant_, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %list_List_ast_EnumVariant_, ptr %ptr, i32 0, i32 0
  %p2 = load ptr, ptr %p, align 8
  store ptr %p2, ptr %fp, align 8
  %fp3 = getelementptr inbounds %list_List_ast_EnumVariant_, ptr %ptr, i32 0, i32 1
  store i64 0, ptr %fp3, align 8
  %fp4 = getelementptr inbounds %list_List_ast_EnumVariant_, ptr %ptr, i32 0, i32 2
  %initial_cap5 = load i64, ptr %initial_cap, align 8
  store i64 %initial_cap5, ptr %fp4, align 8
  call void @lunite_retain(ptr %ptr)
  ret ptr %ptr
}

define void @list_List_ast_EnumVariant__push(ptr %0, ptr %1) {
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
  %fp = getelementptr inbounds %list_List_ast_EnumVariant_, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  store i64 %count, ptr %c, align 8
  %c2 = load i64, ptr %c, align 8
  %self3 = load ptr, ptr %self, align 8
  %fp4 = getelementptr inbounds %list_List_ast_EnumVariant_, ptr %self3, i32 0, i32 2
  %capacity = load i64, ptr %fp4, align 8
  %2 = icmp sge i64 %c2, %capacity
  br i1 %2, label %then, label %else

then:                                             ; preds = %body
  %self5 = load ptr, ptr %self, align 8
  %fp6 = getelementptr inbounds %list_List_ast_EnumVariant_, ptr %self5, i32 0, i32 2
  %capacity7 = load i64, ptr %fp6, align 8
  store i64 %capacity7, ptr %old_cap, align 8
  %old_cap8 = load i64, ptr %old_cap, align 8
  %3 = mul i64 %old_cap8, 2
  store i64 %3, ptr %new_cap, align 8
  %self9 = load ptr, ptr %self, align 8
  %fp10 = getelementptr inbounds %list_List_ast_EnumVariant_, ptr %self9, i32 0, i32 0
  %self11 = load ptr, ptr %self, align 8
  %fp12 = getelementptr inbounds %list_List_ast_EnumVariant_, ptr %self11, i32 0, i32 0
  %data = load ptr, ptr %fp12, align 8
  %old_cap13 = load i64, ptr %old_cap, align 8
  %4 = mul i64 %old_cap13, 8
  %new_cap14 = load i64, ptr %new_cap, align 8
  %5 = mul i64 %new_cap14, 8
  %res = call ptr @lunite_realloc(ptr %data, i64 %4, i64 %5)
  store ptr %res, ptr %fp10, align 8
  %self15 = load ptr, ptr %self, align 8
  %fp16 = getelementptr inbounds %list_List_ast_EnumVariant_, ptr %self15, i32 0, i32 2
  %new_cap17 = load i64, ptr %new_cap, align 8
  store i64 %new_cap17, ptr %fp16, align 8
  br label %cont

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else, %then
  %self18 = load ptr, ptr %self, align 8
  %fp19 = getelementptr inbounds %list_List_ast_EnumVariant_, ptr %self18, i32 0, i32 0
  %data20 = load ptr, ptr %fp19, align 8
  %c21 = load i64, ptr %c, align 8
  %ptr = getelementptr ptr, ptr %data20, i64 %c21
  %val22 = load ptr, ptr %val, align 8
  %old = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val22)
  store ptr %val22, ptr %ptr, align 8
  call void @lunite_release(ptr %old)
  %self23 = load ptr, ptr %self, align 8
  %fp24 = getelementptr inbounds %list_List_ast_EnumVariant_, ptr %self23, i32 0, i32 1
  %c25 = load i64, ptr %c, align 8
  %6 = add i64 %c25, 1
  store i64 %6, ptr %fp24, align 8
  %tmp = load ptr, ptr %val, align 8
  call void @lunite_release(ptr %tmp)
  %tmp26 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp26)
  ret void
}

define i64 @list_List_semantic_TStatement__len(ptr %0) {
entry:
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_semantic_TStatement_, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret i64 %count
}

define ptr @list_List_semantic_TStatement__get_ptr(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_semantic_TStatement_, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %ptr
}

define ptr @list_List_semantic_TStatement__get(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_semantic_TStatement_, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %val = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val)
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %val
}

define ptr @list_List_semantic_TStatement__new() {
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
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%list_List_semantic_TStatement_, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %list_List_semantic_TStatement_, ptr %ptr, i32 0, i32 0
  %p2 = load ptr, ptr %p, align 8
  store ptr %p2, ptr %fp, align 8
  %fp3 = getelementptr inbounds %list_List_semantic_TStatement_, ptr %ptr, i32 0, i32 1
  store i64 0, ptr %fp3, align 8
  %fp4 = getelementptr inbounds %list_List_semantic_TStatement_, ptr %ptr, i32 0, i32 2
  %initial_cap5 = load i64, ptr %initial_cap, align 8
  store i64 %initial_cap5, ptr %fp4, align 8
  call void @lunite_retain(ptr %ptr)
  ret ptr %ptr
}

define void @list_List_semantic_TStatement__push(ptr %0, ptr %1) {
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
  %fp = getelementptr inbounds %list_List_semantic_TStatement_, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  store i64 %count, ptr %c, align 8
  %c2 = load i64, ptr %c, align 8
  %self3 = load ptr, ptr %self, align 8
  %fp4 = getelementptr inbounds %list_List_semantic_TStatement_, ptr %self3, i32 0, i32 2
  %capacity = load i64, ptr %fp4, align 8
  %2 = icmp sge i64 %c2, %capacity
  br i1 %2, label %then, label %else

then:                                             ; preds = %body
  %self5 = load ptr, ptr %self, align 8
  %fp6 = getelementptr inbounds %list_List_semantic_TStatement_, ptr %self5, i32 0, i32 2
  %capacity7 = load i64, ptr %fp6, align 8
  store i64 %capacity7, ptr %old_cap, align 8
  %old_cap8 = load i64, ptr %old_cap, align 8
  %3 = mul i64 %old_cap8, 2
  store i64 %3, ptr %new_cap, align 8
  %self9 = load ptr, ptr %self, align 8
  %fp10 = getelementptr inbounds %list_List_semantic_TStatement_, ptr %self9, i32 0, i32 0
  %self11 = load ptr, ptr %self, align 8
  %fp12 = getelementptr inbounds %list_List_semantic_TStatement_, ptr %self11, i32 0, i32 0
  %data = load ptr, ptr %fp12, align 8
  %old_cap13 = load i64, ptr %old_cap, align 8
  %4 = mul i64 %old_cap13, 8
  %new_cap14 = load i64, ptr %new_cap, align 8
  %5 = mul i64 %new_cap14, 8
  %res = call ptr @lunite_realloc(ptr %data, i64 %4, i64 %5)
  store ptr %res, ptr %fp10, align 8
  %self15 = load ptr, ptr %self, align 8
  %fp16 = getelementptr inbounds %list_List_semantic_TStatement_, ptr %self15, i32 0, i32 2
  %new_cap17 = load i64, ptr %new_cap, align 8
  store i64 %new_cap17, ptr %fp16, align 8
  br label %cont

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else, %then
  %self18 = load ptr, ptr %self, align 8
  %fp19 = getelementptr inbounds %list_List_semantic_TStatement_, ptr %self18, i32 0, i32 0
  %data20 = load ptr, ptr %fp19, align 8
  %c21 = load i64, ptr %c, align 8
  %ptr = getelementptr ptr, ptr %data20, i64 %c21
  %val22 = load ptr, ptr %val, align 8
  %old = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val22)
  store ptr %val22, ptr %ptr, align 8
  call void @lunite_release(ptr %old)
  %self23 = load ptr, ptr %self, align 8
  %fp24 = getelementptr inbounds %list_List_semantic_TStatement_, ptr %self23, i32 0, i32 1
  %c25 = load i64, ptr %c, align 8
  %6 = add i64 %c25, 1
  store i64 %6, ptr %fp24, align 8
  %tmp = load ptr, ptr %val, align 8
  call void @lunite_release(ptr %tmp)
  %tmp26 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp26)
  ret void
}

define i64 @list_List_semantic_TExpression__len(ptr %0) {
entry:
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_semantic_TExpression_, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret i64 %count
}

define ptr @list_List_semantic_TExpression__get_ptr(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_semantic_TExpression_, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %ptr
}

define ptr @list_List_semantic_TExpression__get(ptr %0, i64 %1) {
entry:
  %index = alloca i64, align 8
  %self = alloca ptr, align 8
  br label %body

body:                                             ; preds = %entry
  call void @lunite_retain(ptr %0)
  store ptr %0, ptr %self, align 8
  store i64 %1, ptr %index, align 8
  %self1 = load ptr, ptr %self, align 8
  %fp = getelementptr inbounds %list_List_semantic_TExpression_, ptr %self1, i32 0, i32 0
  %data = load ptr, ptr %fp, align 8
  %index2 = load i64, ptr %index, align 8
  %ptr = getelementptr ptr, ptr %data, i64 %index2
  %val = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val)
  %tmp = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp)
  ret ptr %val
}

define ptr @list_List_semantic_TExpression__new() {
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
  %ptr = call ptr @lunite_alloc(i64 ptrtoint (ptr getelementptr (%list_List_semantic_TExpression_, ptr null, i32 1) to i64), ptr null, ptr null)
  %fp = getelementptr inbounds %list_List_semantic_TExpression_, ptr %ptr, i32 0, i32 0
  %p2 = load ptr, ptr %p, align 8
  store ptr %p2, ptr %fp, align 8
  %fp3 = getelementptr inbounds %list_List_semantic_TExpression_, ptr %ptr, i32 0, i32 1
  store i64 0, ptr %fp3, align 8
  %fp4 = getelementptr inbounds %list_List_semantic_TExpression_, ptr %ptr, i32 0, i32 2
  %initial_cap5 = load i64, ptr %initial_cap, align 8
  store i64 %initial_cap5, ptr %fp4, align 8
  call void @lunite_retain(ptr %ptr)
  ret ptr %ptr
}

define void @list_List_semantic_TExpression__push(ptr %0, ptr %1) {
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
  %fp = getelementptr inbounds %list_List_semantic_TExpression_, ptr %self1, i32 0, i32 1
  %count = load i64, ptr %fp, align 8
  store i64 %count, ptr %c, align 8
  %c2 = load i64, ptr %c, align 8
  %self3 = load ptr, ptr %self, align 8
  %fp4 = getelementptr inbounds %list_List_semantic_TExpression_, ptr %self3, i32 0, i32 2
  %capacity = load i64, ptr %fp4, align 8
  %2 = icmp sge i64 %c2, %capacity
  br i1 %2, label %then, label %else

then:                                             ; preds = %body
  %self5 = load ptr, ptr %self, align 8
  %fp6 = getelementptr inbounds %list_List_semantic_TExpression_, ptr %self5, i32 0, i32 2
  %capacity7 = load i64, ptr %fp6, align 8
  store i64 %capacity7, ptr %old_cap, align 8
  %old_cap8 = load i64, ptr %old_cap, align 8
  %3 = mul i64 %old_cap8, 2
  store i64 %3, ptr %new_cap, align 8
  %self9 = load ptr, ptr %self, align 8
  %fp10 = getelementptr inbounds %list_List_semantic_TExpression_, ptr %self9, i32 0, i32 0
  %self11 = load ptr, ptr %self, align 8
  %fp12 = getelementptr inbounds %list_List_semantic_TExpression_, ptr %self11, i32 0, i32 0
  %data = load ptr, ptr %fp12, align 8
  %old_cap13 = load i64, ptr %old_cap, align 8
  %4 = mul i64 %old_cap13, 8
  %new_cap14 = load i64, ptr %new_cap, align 8
  %5 = mul i64 %new_cap14, 8
  %res = call ptr @lunite_realloc(ptr %data, i64 %4, i64 %5)
  store ptr %res, ptr %fp10, align 8
  %self15 = load ptr, ptr %self, align 8
  %fp16 = getelementptr inbounds %list_List_semantic_TExpression_, ptr %self15, i32 0, i32 2
  %new_cap17 = load i64, ptr %new_cap, align 8
  store i64 %new_cap17, ptr %fp16, align 8
  br label %cont

else:                                             ; preds = %body
  br label %cont

cont:                                             ; preds = %else, %then
  %self18 = load ptr, ptr %self, align 8
  %fp19 = getelementptr inbounds %list_List_semantic_TExpression_, ptr %self18, i32 0, i32 0
  %data20 = load ptr, ptr %fp19, align 8
  %c21 = load i64, ptr %c, align 8
  %ptr = getelementptr ptr, ptr %data20, i64 %c21
  %val22 = load ptr, ptr %val, align 8
  %old = load ptr, ptr %ptr, align 8
  call void @lunite_retain(ptr %val22)
  store ptr %val22, ptr %ptr, align 8
  call void @lunite_release(ptr %old)
  %self23 = load ptr, ptr %self, align 8
  %fp24 = getelementptr inbounds %list_List_semantic_TExpression_, ptr %self23, i32 0, i32 1
  %c25 = load i64, ptr %c, align 8
  %6 = add i64 %c25, 1
  store i64 %6, ptr %fp24, align 8
  %tmp = load ptr, ptr %val, align 8
  call void @lunite_release(ptr %tmp)
  %tmp26 = load ptr, ptr %self, align 8
  call void @lunite_release(ptr %tmp26)
  ret void
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly %0, ptr noalias nocapture readonly %1, i64 %2, i1 immarg %3) #0

attributes #0 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
