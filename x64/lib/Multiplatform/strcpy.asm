; Copy a string from source address to destiny address

; Destiny address in RDI, source address in RSI

strcpy:
    ; Save some registers value
    push rdi
    push rsi

strcpy_while:
    ; If source address reach null byte, stop.
    cmp BYTE [rsi], BYTE 0
    je strcpy_end

    ; If not, copy that value to destiny address
    mov r8b, BYTE [rsi]
    mov [rdi], r8b

    ; Increment both registers
    inc rdi
    inc rsi

    jmp strcpy_while
strcpy_end:
    ; If the source address reach the null byte, a null byte is put
    ; in the end of destiny string
    mov [rdi], BYTE 0

    ; Restore both registers
    pop rsi
    pop rdi

    ; Return from segment
    ret
