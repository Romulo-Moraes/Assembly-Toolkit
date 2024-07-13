%define SYS_WRITE 1
%define SYS_EXIT 60
%define EXIT_SUCCESS 0
%define STDOUT 1

global _start

%define SIZEOF_INT 4
%define ARRAY_SIZE 5
segment .text

_start:
    mov rbp, rsp
    sub rsp, SIZEOF_INT * ARRAY_SIZE

    ; (note) RSP and RDI points to the same address
    lea rdi, [rbp - SIZEOF_INT * ARRAY_SIZE]

    mov DWORD [rdi + SIZEOF_INT * 0], 5
    mov DWORD [rdi + SIZEOF_INT * 1], 2
    mov DWORD [rdi + SIZEOF_INT * 2], 9
    mov DWORD [rdi + SIZEOF_INT * 3], 3
    mov DWORD [rdi + SIZEOF_INT * 4], 7

    ; save the array base address to be accessible across syscalls
    mov [array_base_address], rdi

loop:
    ; load array base address
    mov rdi, [array_base_address]

    ; load the index and check if it is greater than 4
    mov rbx, [index]
    cmp rbx, 4

    jg loop_end

    ; using the loaded index to fetch the array value
    mov eax, [rdi + SIZEOF_INT * rbx]

    ; transform the number to its character representation
    ; and save it on .data segment
    add eax, '0'
    mov [value_to_print], al

    ; print the number
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, value_to_print
    mov rdx, 2
    syscall

    ; increment the index
    inc BYTE [index]

    ; go back to the loop
    jmp loop

loop_end:

    ; exit the program
    mov rax, SYS_EXIT
    mov rdi, EXIT_SUCCESS
    syscall

segment .data

    ; defines a qword
    index dq 0

    ; defines the address that will be used
    ; to print the result
    value_to_print db 0, 0xa ; 0xa in the end to break a line

segment .bss
    array_base_address resb 8