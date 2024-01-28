global helloWorld

%define SYS_WRITE 1
%define STDOUT 1

segment .text


helloWorld:
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, msg
    mov rdx, msg.size
    syscall

    ret


segment .rodata
    msg db "Hello, world!", 0xa, 0x0
    msg.size equ $-msg