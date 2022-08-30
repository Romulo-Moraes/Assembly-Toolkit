; Copy a string from source address to destiny address

; Destiny address in EDI, source address in ESI

strcpy:
    ; Save some registers value
    push edi
    push esi

strcpy_while:
    ; If source address reach null byte, stop.
    cmp BYTE [esi], BYTE 0
    je strcpy_end

    ; If not, copy that value to destiny address
    mov al, BYTE [esi]
    mov [edi], al

    ; Increment both registers
    inc edi
    inc esi

    jmp strcpy_while
strcpy_end:
    ; If the source address reach the null byte, a null byte is put
    ; in the end of destiny string
    mov [edi], BYTE 0

    ; Restore both registers
    pop esi
    pop edi

    ; Return from segment
    ret
