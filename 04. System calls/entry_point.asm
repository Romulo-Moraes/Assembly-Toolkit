segment .text
global customized_program_entry_point

customized_program_entry_point:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, msg.sz
    syscall

    mov rax, 60
    mov rdi, 0
    syscall

segment .rodata
    msg db 'Hello, world!', 0xa, 0x0
    msg.sz equ $-msg