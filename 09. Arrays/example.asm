global _start

; macros
%define SYS_EXIT 60
%define SYS_WRITE 1
%define STDOUT 1
%define EXIT_SUCCESS 0
%define SIZEOF_INTEGER 4
%define ARRAY_SIZE 4
%define COUNTER 1
%define ARRAY_BASE_ADDRESS 9

segment .text

_start:
    ; allocating memory
    mov rbp, rsp
    sub rsp, SIZEOF_INTEGER * ARRAY_SIZE

    ; loading array's base address
    lea rdi, [rbp+-SIZEOF_INTEGER * ARRAY_SIZE]
    call populate_array

    call print_array

    ; exit the program
    mov rax, SYS_EXIT
    mov rdi, EXIT_SUCCESS
    syscall

; receive and print a number
; rdi = number to print
print_number:
    ; save rbp
    push rbp

    ; allocate memory
    mov rbp, rsp
    sub rsp, 2

    ; move the number and a new line to
    ; the allocated buffer
    mov BYTE [rbp+-1], 0xa
    mov [rbp+-2], dil

    ; print the number
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    lea rsi, [rbp+-2]
    mov rdx, 2
    syscall

    ; deallocate and pop rbp
    add rsp, 2
    pop rbp

    ret

; fill the array with constants
; rdi = array base address
populate_array:
    mov DWORD [rdi], 5
    mov DWORD [rdi+SIZEOF_INTEGER], 2
    mov DWORD [rdi+SIZEOF_INTEGER * 2], 8
    mov DWORD [rdi+SIZEOF_INTEGER * 3], 4

    ret

; print all array elements
; rdi = array address
print_array:
    ; save rbp and allocate memory
    ; for the counter and the base address
    push rbp
    mov rbp, rsp
    sub rsp, 9

    ; initialize the counter with 0.
    ; save the base address.
    mov BYTE [rbp+-COUNTER], 0
    mov [rbp+-ARRAY_BASE_ADDRESS], rdi


print_loop:
    ; load base address
    mov rdx, [rbp+-ARRAY_BASE_ADDRESS]

    ; compare the counter with the array size
    mov al, [rbp+-COUNTER]
    cmp al, ARRAY_SIZE

    jge print_loop_end

    ; load an array element into edi
    ; and transform it to a character
    mov edi, [rdx+rax*SIZEOF_INTEGER]
    add edi, '0'
    
    call print_number

    ; increment the counter
    inc BYTE [rbp+-COUNTER]

    ; jump back to the loop
    jmp print_loop

print_loop_end:
    ; deallocate memory and pop rbp
    add rsp, 9
    pop rbp

    ret