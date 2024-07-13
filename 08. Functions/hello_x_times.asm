%define SYS_WRITE 1
%define SYS_READ 0
%define SYS_EXIT 60
%define STDOUT 1
%define STDIN 0

global _start

segment .text

_start:
    ; Aligning both stack register
    mov rbp, rsp
    
    ; Asking the number of messages to the user
    call get_number_from_user
    mov [total_hello_world_count], al

loop:
    ; Verifying if the count still within the range
    mov al, [count]
    cmp al, [total_hello_world_count]
    jge loop_end

    ; Print hello world
    call print_hello_world

    ; Increment the counter
    inc BYTE [count]

    ; Jump back to the loop
    jmp loop
loop_end:

    ; Exit the program
    mov rax, SYS_EXIT
    mov rdi, 0
    syscall    


; Procedure that prints 'Hello, world!'
print_hello_world:
    mov rax, SYS_WRITE
    mov rdi, 1
    mov rsi, hello_world
    mov rdx, hello_world.sz
    syscall

    ret

; Function that asks a number to the user    
get_number_from_user:
    ; save rbp and allocate memory
    push rbp
    mov rbp, rsp
    sub rsp, 1

    ; Ask the question
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, number_question
    mov rdx, number_question.sz
    syscall

    ; Receive the number
    mov rax, SYS_READ
    mov rdi, STDIN
    lea rsi, [rbp-1]
    mov rdx, 1
    syscall

    ; Move the received value to the 1/8 part of rax
    mov al, [rbp+-1]
    sub al, '0'

    ; Deallocate memory and pop rbp
    inc rsp
    pop rbp

    ; Return from function
    ret

segment .rodata
    number_question db "How many times do you want to see 'Hello, world' ?", 0xa, 0x0
    number_question.sz equ $-number_question
    hello_world db "Hello, world!", 0xa, 0x0
    hello_world.sz equ $-hello_world


segment .bss
    total_hello_world_count resb 1
    count resb 1
