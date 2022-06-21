; Get string size in stack memory
;
; Input: String address in ESI
;
; Output: String size in EAX

strlen:
    push ESI

    xor EDX,EDX

strlen_step:
    cmp [ESI], byte 0

    jz strlen_exit


    inc ESI
    INC EDX

    jmp strlen_step

strlen_exit:
    xor ESI,ESI
    pop ESI

    mov EAX,EDX
    ret