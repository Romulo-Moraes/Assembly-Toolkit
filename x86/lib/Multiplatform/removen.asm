; Remove the first '\n' from a string

; Input:  Address of string in ESI register


strcspn:
    cmp [ESI], byte 10
    je strcspn_end_or_newline

    cmp [ESI],byte 0

    je strcspn_end_or_newline

    add ESI,1

    jmp strcspn

strcspn_end_or_newline:
    mov [ESI], byte 0
    ret
    
