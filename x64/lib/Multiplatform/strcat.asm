; concat two strings

; Destiny address in RDI, source address in RSI

strcat:
    push rdi
    push rsi

strcat_while1: ; while destiny address isn't 0
    cmp [rdi], byte 0
    jz strcat_while2; strcat_while2

    inc rdi
    jmp strcat_while1

strcat_while2: ; strcat properly
    cmp [rsi], byte 0
    je strcat_end

    mov r8b, [rsi]
    mov [rdi], r8b

    inc rsi
    inc rdi

    jmp strcat_while2
strcat_end:
    mov [rdi], byte 0
    pop rsi
    pop rdi

    ret
