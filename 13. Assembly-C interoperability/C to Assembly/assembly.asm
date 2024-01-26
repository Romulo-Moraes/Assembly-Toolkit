global _start

; importing external procedures
extern fillArrayIncrementally, sumArray, intToString, strLen

; macros
%define SYS_WRITE 1
%define SYS_EXIT 60
%define STDOUT 1
%define EXIT_SUCCESS 0
%define SIZEOF_INTEGER 4
%define INTEGER_ARRAY_SIZE 10

%macro exit 1
    mov rax, SYS_EXIT
    mov rdi, %1
    syscall
%endmacro

%macro print 1
    mov rdi, %1
    call strLen

    mov rdx, rax
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, %1
    syscall
%endmacro

segment .text

_start:
    ; Allocating memory
    mov rbp, rsp
    sub rsp, SIZEOF_INTEGER * INTEGER_ARRAY_SIZE

    ; calling the fillArrayIncrementally C code function
    lea rdi, [rbp+-SIZEOF_INTEGER * INTEGER_ARRAY_SIZE]
    mov rsi, 4
    mov rdx, INTEGER_ARRAY_SIZE
    call fillArrayIncrementally

    ; calling the sumArray C code function
    mov rsi, INTEGER_ARRAY_SIZE
    call sumArray

    ; calling the intToString C code function
    mov rdi, rax
    mov rsi, numberAsString
    call intToString

    ; printing the result
    print msg
    print numberAsString
    print newLine

    exit EXIT_SUCCESS

segment .bss
    numberAsString resb 11

segment .rodata
    msg db "The sum of all elements of the array is: ", 0x0
    newLine db 0xa
