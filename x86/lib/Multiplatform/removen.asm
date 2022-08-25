; Remove the first '\n' from a string

; Input:  Address of string in ESI register

removen:
    cmp [esi], BYTE 10
    je removen_end_or_newline

    cmp [esi], BYTE 0
    je removen_end_or_newline

    inc esi

    jmp removen


removen_end_or_newline:
    mov [esi], BYTE 0
    ret