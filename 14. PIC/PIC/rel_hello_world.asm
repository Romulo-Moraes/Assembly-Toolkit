segment .text
global _start

_start:

    mov rax, 1
    mov rdi, 1
    ; Passing the address of msg relative to the RIP
    lea rsi, [rel msg]
    ; It isn't necessary with msg.sz
    ; this is a macro, not an address, so
    ; it is resolved at Assemble time
    mov rdx, msg.sz
    syscall

    mov rax, 60
    mov rdi, 0
    syscall

segment .data
    msg db 'Hello, people.', 0xa, 0x0
    msg.sz equ $-msg