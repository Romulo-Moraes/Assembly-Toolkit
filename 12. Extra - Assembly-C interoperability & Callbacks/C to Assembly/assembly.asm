segment .text
; Extern keyword, like in C, ask to the linker
; to give us a reference of an external function
extern integer_to_string
global _start

_start:
    mov rbp, rsp
    sub rsp, 8
    mov QWORD [rbp+-8], 0x0 ; Cleaning stack

    ; Prepare function arguments
    mov rdi, 51423;
    lea rsi, [rbp+-8]
    ; Function call
    call integer_to_string

    ;; Preparing print to show the string
    mov rax, 1
    mov rdi, 1
    lea rsi, [rbp+-8]
    ; I know how many characters will
    ; back from the function... it's a cheat.
    ; The correct would be a strlen function to get
    ; the length of this string
    mov rdx, 6; +1 for '\n' set in C code
    syscall


    mov rax, 60
    mov rdi, 0
    syscall