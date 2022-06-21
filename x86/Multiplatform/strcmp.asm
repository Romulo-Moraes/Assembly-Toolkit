; This segment need strlen.asm file

; Compare two strings
;
; Input: first address string in ESI, seconds address string in EDI
;
; Output: if equal EAX = 1 else EAX = 0

strcmp:
    xor ecx,ecx
    call strlen

    mov ebx,eax

    push esi
    mov esi,edi

    pop edi

    call strlen

    cmp ebx,eax

    je strcmp_step

    mov eax,0

    ret

strcmp_step:
    mov al,[esi]
    mov bl,[edi]

    cmp al,bl

    jne strcmp_bad_step

    jmp strcmp_good_step

strcmp_good_step:
    inc ecx
    inc esi
    inc edi

    cmp ecx,eax

    jle strcmp_step

    mov eax,1
    ret

strcmp_bad_step:
    mov eax,0
    ret