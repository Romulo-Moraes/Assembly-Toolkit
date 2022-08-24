; This segment need strlen.asm file

; Compare two strings
;
; Input: first address string in RSI, seconds address string in RDI
;
; Output: if equal RAX = 1 else RAX = 0

strcmp:
    push rbp
    mov rbp,rsp
    sub rsp, 8
    xor rcx,rcx

    call strlen 



    mov QWORD [rbp+0], rax


    push rsi


    mov rsi,rdi

    pop rdi

    call strlen
	

    cmp QWORD [rbp+0],rax

    je strcmp_step

    mov rax,0
    
    mov rsp, rbp
    pop rbp

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

    mov rsp,rbp
    pop rbp

    ret

strcmp_bad_step:
    mov rax,0

    mov rsp,rbp
    pop rbp

    ret



    
