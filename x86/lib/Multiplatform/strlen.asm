; Get string size in memory
;
; Input: String address in ESI
;
; Output: String size in EAX


strlen:
    push esi

    ; Set zero to count
    xor ecx, ecx

strlen_step:
    ; Check if byte is not null
    cmp [esi], BYTE 0

    ; If null, is the end of array, exit 
    jz strlen_exit

    ; If not, next char and increment count
    inc esi
    inc ecx

    ; Go back to loop
    jmp strlen_step

strlen_exit:
    xor esi, esi
    pop esi

    ; Move result to rax then return function call
    mov eax, ecx
    ret





