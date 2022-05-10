;
; This function requires strlen.asm
;


puts:
    mov rdi,rsi
    call strlen

    mov rsi,rdi

    mov rdx,rax

    mov rax, 1
    mov rdi,1
    syscall 
    
    ret
    