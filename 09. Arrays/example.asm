segment .text
global _start

%define INT_SIZE 4
%define INT_POINTER_LOCATION -11
%define LOOP_COUNTER_LOCATION -1

print_int_array:

    push rbp
    mov rbp, rsp
    sub rsp, 11

    ; LOOP_COUNTER_LOCATION = -1
    mov BYTE [rbp+LOOP_COUNTER_LOCATION], 0
    ; A new line is being put in the position -2, but a print 
    ; syscall will be made pointing to -3. This is just to
    ; make the print prettier.
    mov BYTE [rbp+-2], 0xa
    ; Saving the array pointer, each syscall clean everything
    ; from the rdi register
    ; INT_POINTER_LOCATION = -11
    mov [rbp+INT_POINTER_LOCATION], rdi

print_loop:
    ; Compare the counter to check we reached at
    ; the end of the array
    cmp BYTE [rbp+LOOP_COUNTER_LOCATION], 10
    jge print_loop_end

    ; Move counter to dl register
    mov dl, [rbp+LOOP_COUNTER_LOCATION]
    ; Loading the element from the array using rdx register
    ; (dl is the 8bit part of rdx).
    mov eax, [rdi+rdx * INT_SIZE] ; INT_SIZE = 4

    ; Here we know that the value inside is smaller than a byte
    ; so will be used the 8bit part of eax to transform the number
    ; to string.
    add al, '0'

    ; Move the number character to the position
    ; to be finally printed.
    mov [rbp+-3], al

    ; Syscall print to the -3 position
    mov rax, 1
    mov rdi, 1
    lea rsi, [rbp+-3]
    mov rdx, 2
    syscall

    ; Increment counter to the next iteration
    inc BYTE [rbp+LOOP_COUNTER_LOCATION]

    ; Reload array pointer from RAM, this is because
    ; the syscall wiped out everything inside the rdi
    ; register
    mov rdi, [rbp+INT_POINTER_LOCATION]

    ; Jump to the loop again to print the next position
    jmp print_loop

print_loop_end:
    ; End of the procedure
    mov rsp, rbp
    pop rbp

    ret

_start:
    mov rbp, rsp
    sub rsp, INT_SIZE * 10

    lea rdi, [rbp+-INT_SIZE * 10]

    mov DWORD [rdi+INT_SIZE * 0], 1
    mov DWORD [rdi+INT_SIZE * 1], 2
    mov DWORD [rdi+INT_SIZE * 2], 4
    mov DWORD [rdi+INT_SIZE * 3], 8
    mov DWORD [rdi+INT_SIZE * 4], 4
    mov DWORD [rdi+INT_SIZE * 5], 2
    mov DWORD [rdi+INT_SIZE * 6], 1
    mov DWORD [rdi+INT_SIZE * 7], 2
    mov DWORD [rdi+INT_SIZE * 8], 4
    mov DWORD [rdi+INT_SIZE * 9], 8

    lea rdi, [rbp+-INT_SIZE * 10]
    call print_int_array

    mov rax, 60
    mov rdi, 0
    syscall