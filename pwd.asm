; This segment will get the current working directory
;
; Input: Store place in RDI, store size in RSI
;
; Output: Nothing

get_cwd:
    mov rax,79
    syscall

    ret
    