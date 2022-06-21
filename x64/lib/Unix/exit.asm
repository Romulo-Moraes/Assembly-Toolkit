; Ask for OS to terminate the program
;
; Input: exit code in RDI

exit:
    mov rax,60
    syscall