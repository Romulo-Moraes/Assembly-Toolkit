; strcpy - function to copy a string from source to destiny
; 
; RDI register is used as destiny
; RSI register is used as source
; RAX is the return value (contains destiny addr)
;
; The function doesn't change the value of RDI and RSI
; The function doesn't use any registers beyond the specified ones


strcpy:
    ; save destiny 
    push rdi
    ; save source
    push rsi

_strcpy_loop:
    ; compare the current byte of 
    ; source with NULL
    mov al, [rsi]
    cmp al, 0

    ; if the byte is zero, jump to end
    jz _strcpy_end

    ; else, copy to destiny
    mov [rdi], al

    ; increment both address
    inc rdi
    inc rsi

    ; Jump to loop again
    jmp _strcpy_loop
_strcpy_end:
    mov BYTE [rdi], 0

    ; pop the values saved previously
    pop rsi
    pop rdi

    ; copy destiny to rax 
    ; as return value
    mov rax, rdi

    ; return from the function
    ret