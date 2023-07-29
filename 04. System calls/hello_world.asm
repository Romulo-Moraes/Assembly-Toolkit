segment .text
    global _start

_start:

    mov rax, 1
    mov rdi, 1
    mov rsi, message
    mov rdx, message_size
    syscall

    mov rax, 60
    mov rdi, 0
    syscall

segment .rodata
    message db 'Hello, world!', 0xa, 0x0
    message_size equ $- message