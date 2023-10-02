segment .text
; Import anything you wan't from the Glibc
extern exit
extern puts
extern fgets
extern stdin
extern fflush
extern printf
global _start

_start: 
    mov rbp, rsp
    sub rsp, 50

    ; Glibc puts function
    mov rdi, message1
    call puts

    ; Glibc fgets
    lea rdi, [rbp+-50]
    mov rsi, 49
    mov rdx, [stdin]
    call fgets

    ; Glibc printf
    xor rax, rax ; printf requires to rax be 0
    mov rdi, message2
    call printf

    ; Glibc fflush
    mov rdi, [stdin]
    call fflush

    lea rdi, [rbp+-50]
    call puts

    ; Exiting the program calling the glibc exit function
    mov rdi, 0
    call exit

segment .rodata
    message1 db 'Hey! type a message: ', 0x0
    message2 db 'You typed: ', 0x0