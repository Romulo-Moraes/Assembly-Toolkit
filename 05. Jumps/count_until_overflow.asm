;; this program will print 'Not overflow yet!' until 
;; a 8-bits register overflows

global _start

segment .text

_start:

mov al, 249

loop_begin:
    mov al, [value]

    add al, 1

    ;; jump on overflow (unsigned)
    jc loop_end

    mov [value], al

    ;; print not overflow message
    mov rax, 1
    mov rdi, 1
    mov rsi, not_overflow
    mov rdx, not_overflow.sz
    syscall

    jmp loop_begin

loop_end:

    ;; print overflow message
    mov rax, 1
    mov rdi, 1
    mov rsi, overflow
    mov rdx, overflow.sz
    syscall

    ;; exit program
    mov rax, 60
    mov rdi, 0
    syscall

segment .rodata
    not_overflow db 'Not overflow yet!', 0xa, 0x0
    not_overflow.sz equ $-not_overflow
    overflow db 'Overflow!!', 0xa, 0x0
    overflow.sz equ $-overflow

segment .data
    ;; [value] contains 249 at the beginning of the program
    value db 249