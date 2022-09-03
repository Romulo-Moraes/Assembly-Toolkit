; Remove the first '\n' from a string

; Input:  Address of string in RSI register


removen:
    cmp [rsi], BYTE 10
    je removen_end_or_newline

    cmp [rsi], BYTE 0
    je removen_end_or_newline

    inc rsi

    jmp removen

removen_end_or_newline:
    mov [rsi], BYTE 0
    ret
    
