; memset - Function that fill an area in memory with a byte
;
; RDI register is used as address to be filled
; RSI register is used as the byte to fill the area
; RDX register is used as the number of bytes to fill
; RAX is the return value (contains the address of the filled area)
;
; The function doesn't change the value of RDI, RSI and RDX
; The function doesn't use any register beyond the known

%define __MEMSET_COPY_COUNTER -9

memset:
    ; Save some registers into stack
    push rbp
    push rdi

    ; Allocate memory in stack frame
    mov rbp, rsp
    sub rsp, 9

    ; Put zero inside the counter variable
    mov QWORD [rbp+__MEMSET_COPY_COUNTER], 0
memset_loop:
    ; Compare whether the counter still
    ; less than the value specified by 
    ; the programmer
    cmp [rbp+__MEMSET_COPY_COUNTER], rdx

    ; If not, jump to end
    jge memset_end

    ; If yes, copy the byte to the address
    mov [rdi], sil

    ; Increment counter and the address
    inc QWORD [rbp+__MEMSET_COPY_COUNTER]
    inc rdi

    ; Jump to the loop again
    jmp memset_loop
memset_end:
    ; Deallocate memory in stack rame
    add rsp, 8

    ; Restore registers previously
    ; pushed into stack
    pop rdi
    pop rbp

    ; Copy address of the filled area
    ; to return value register
    mov rax, rdi
    ret