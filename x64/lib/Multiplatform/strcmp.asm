; This segment need strlen.asm file

; Compare two strings
;
; Input: first address string in RSI, seconds address string in RDI
;
; Output: if equal RAX = 1 else RAX = 0

strcmp:
    ; Save rbp register and allocate stack memory
    push rbp
    mov rbp,rsp

    sub rsp, 8

    ; Reset counter
    xor rcx,rcx

    ; Get string length
    call strlen 

    ; Save string length in stack
    mov QWORD [rbp+0], rax

    ; Swap rsi and rdi between themselves
    push rsi
    mov rsi,rdi
    pop rdi

    ; Get length of the another string
    call strlen
	
    ; Compare if the length of them is equal
    cmp QWORD [rbp+0],rax
    
    ; If equal, start strcmp process
    je strcmp_step

    ; If not, return false. them are not the same
    mov rax,0
    
    mov rsp, rbp
    pop rbp

    ret

strcmp_step:
    ; Compare two bytes
    mov al, BYTE [rsi]
    ;mov bl,[rdi]

    cmp al, BYTE [rdi]

    ; Jump if them aren't equal
    jne strcmp_bad_step

    ; Jump if them are equal
    jmp strcmp_good_step

strcmp_good_step:
    ; Increment counter and address positions
    inc rcx
    inc rsi
    inc rdi

    ; Check if counter reached the string length
    cmp rcx,rax

    ; If not, jump
    jle strcmp_step


    ; If yes, no diff found, return true

    mov rax,1

    mov rsp,rbp
    pop rbp

    ret

strcmp_bad_step:
    ; If the code flow reached here, both strings 
    ; are not the same, return false
    mov rax,0

    mov rsp,rbp
    pop rbp

    ret



    
