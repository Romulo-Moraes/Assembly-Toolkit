; This function requires strlen.asm

; Write something in standard output
;
; Input: string address in RSI


puts:
    mov rdi,rsi
    call strlen

    mov rsi,rdi

    mov rdx,rax

    mov rax, 1
    mov rdi,1
    syscall 
    
    ret
    