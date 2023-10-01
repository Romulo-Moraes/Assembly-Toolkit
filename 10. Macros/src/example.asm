%include 'strlen.asm'

%macro exit 1
    mov rax, 60
    mov rdi, %1
    syscall
%endmacro

%macro print 2
    mov rax, 1
    mov rdi, 1
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

%macro _strlen 1
    mov rdi, %1
    call strlen
%endmacro
global _start
segment .text

_start:
    ; Print the first message
    print msg, msg_len

    ; Get length of the word 'length'
    _strlen length_word

    ; The result value is in rax
    ; adding '0' to transform to
    ; a printable number
    add rax, '0'
    ; Moving to a address to be printed
    mov [words_length], rax

    ; Print the length, in this case
    ; i know that the length won't be more
    ; than 1 character.
    print words_length, 1

    exit 0

segment .bss
    words_length resb 10

segment .rodata
    msg db "The length of the word 'length' is: ", 0x0
    msg_len equ $-msg
    length_word db 'length', 0x0