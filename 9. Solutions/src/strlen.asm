; strlen - Funtion to calculate the size of a string
;
; RDI register is used to receive the string address
; RAX is the return value (contains the size)
;
; The function doesn't change the value of RDI

%define __STRLEN_SIZE_COUNT -9

strlen:
    ; Save some registers
    push rbp
    push rdi

    ; Allocate memory for local variables
    mov rbp, rsp
    sub rsp, 9

    
    mov QWORD [rbp+__STRLEN_SIZE_COUNT], 0

strlen_loop:
    ; Verify whether the address
    ; points to NULL byte
    mov al, [rdi]
    cmp al, 0

    ; If it's NULL byte,
    ; jump to end
    jz strlen_end

    ; If not, increment size count
    inc QWORD [rbp+__STRLEN_SIZE_COUNT]

    ; Increment string address
    inc rdi

    ; Jump to loop again
    jmp strlen_loop

strlen_end:
    ; Move size to return value register
    mov rax, [rbp+__STRLEN_SIZE_COUNT]

    ; Deallocate memory
    add rsp, 9

    ; Restore the registers previously
    ; pushed into stack
    pop rdi
    pop rbp

    ret 

