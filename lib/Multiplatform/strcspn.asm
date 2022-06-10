; Remove the first '\n' from a string

; Input:  Address of string in RSI register


strcspn:
    cmp [rsi],byte 10
    je strcspn_end_or_newline

    cmp [rsi],byte 0
    je strcspn_end_or_newline

    add rsi,1

    jmp strcspn

strcspn_end_or_newline:
    mov [rsi], byte 0
    ret
    
