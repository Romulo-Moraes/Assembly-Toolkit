; This segment need strlen.asm file

; Compare two strings
;
; Input: first address string in RSI, seconds address string in RDI
;
; Output: if equal RAX = 1 else RAX = 0

strcmp:
    xor rcx,rcx

    call strlen 


    mov r8,rax

    push rsi


    mov rsi,rdi

    pop rdi

    call strlen

    cmp r8,rax

    je strcmp_step

    mov rax,0

    ret

strcmp_step:

    mov al,[rsi]
    mov bl,[rdi]

    cmp al,bl


    jne strcmp_bad_step

    jmp strcmp_good_step

strcmp_good_step:
    inc rcx
    inc rsi
    inc rdi


    cmp rcx,rax

    jle strcmp_step


    mov rax,1
    ret

strcmp_bad_step:
    mov rax,0
    ret



    