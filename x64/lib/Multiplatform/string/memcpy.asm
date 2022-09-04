; Copy all bytes from source to destiny using a size
;
; Input: destiny address in RSI, source address in RDI, size in RAX


memcpy:
    xor rdx, rdx

    memcpy_while_1: 
        cmp rdx, rax
        jge memcpy_while_1_end

        mov cl, [rdi]
        mov [rsi], cl

        inc rsi
        inc rdi
        inc rdx

        jmp memcpy_while_1
    memcpy_while_1_end:

    ret
