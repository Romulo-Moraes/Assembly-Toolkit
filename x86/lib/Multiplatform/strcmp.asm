; This segment need strlen.asm file

; Compare two strings
;
; Input: first address string in ESI, second address string in EDI
;
; Output: if equal EAX = 1 else EAX = 0


strcmp:
    ; Save ebp register and allocate stack memory
    push ebp
    mov ebp, esp

    sub esp, 4

    ; Reset counter
    xor ecx, ecx

    ; Get string length
    call strlen

    ; Save string length in stack
    mov DWORD [ebp+0], eax

    ; Swap esi and edi between themselves
    push esi
    mov esi, edi
    pop edi

    ; Get length of the another string
    call strlen

    ; Compare if the length of them is equal
    cmp DWORD [ebp+0], eax

    ; If equal, start strcmp process
    je strcmp_step

    ; If not, return false. them are not the same
    mov eax, 0

    mov esp, ebp
    pop ebp

    ret

strcmp_step:
    ; Compare two bytes
    mov al, BYTE [esi]

    cmp al, BYTE [edi]

    ; Jump if them aren't equal
    jne strcmp_bad_step

    ; Jump if them are equal
    jmp strcmp_good_step

strcmp_good_step:

    ; Increment counter and address positions
    inc ecx
    inc esi
    inc edi

    ; Check if counter reached the string length
    cmp ecx, eax

    ; If not, jump
    jle strcmp_step

    ; If yes, no diff found, return true
    mov eax, 1

    mov esp, ebp
    pop ebp

    ret

strcmp_bad_step:
    ; If the code flow reached here, both strings 
    ; are not the same, return false
    mov eax, 0

    mov esp, ebp
    pop ebp

    ret
