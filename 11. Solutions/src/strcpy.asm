; strcpy - function to copy a string from source to destiny
; 
; RDI register is used as destiny
; RSI register is used as source
; RAX is the return value (contains destiny addr)
;
; The function doesn't change the value of RDI and RSI
; The function doesn't use any registers beyond the known


strcpy:
    ; Save destiny 
    push rdi
    push rsi

_strcpy_loop:
    ; Compare the current byte of 
    ; source with NULL
    mov al, [rsi]
    cmp al, 0

    ; If is equal, jump to end
    jz _strcpy_end

    ; else, copy to destiny
    mov [rdi], al

    ; Increment both address
    inc rdi
    inc rsi

    ; Jump to loop again
    jmp _strcpy_loop
_strcpy_end:
    mov BYTE [rdi], 0

    ; Pop the values saved previously
    pop rsi
    pop rdi

    ; Copy destiny to return value
    ; register
    mov rax, rdi

    ; Return the function
    ret