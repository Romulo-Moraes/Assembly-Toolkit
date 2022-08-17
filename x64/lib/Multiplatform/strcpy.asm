; Copy a string from source address to destiny address

; Destiny address in RDI, source address in RSI

strcpy:
    push rdi
    push rsi

while:
    cmp [rsi], byte 0
    je end

    mov r8b, [rsi]
    mov [rdi], r8b
    inc rdi
    inc rsi

    jmp while
end:
    mov [rdi], byte 0

    pop rsi
    pop rdi

    ret
