; This segment depends "linux-syscalls-cheatsheet" file

; Read text from standart input
;
; Input: Store address in RSI, Read size in RDX

readline:
    mov rax,SYS_READ_X64
    mov rdi,STDIN
    syscall

    ret