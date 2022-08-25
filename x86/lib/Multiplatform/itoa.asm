; Transform a number to string

; Number in EAX
; Output address in ESI


%define NUMBER_OF_CHARS_PUSHED_OFFSET 0
%define NEGATIVE_NUMBER_FLAG_OFFSET 4

itoa:
    push esi
    push ebp
    mov ebp, esp

    sub esp, 5

    mov DWORD [ebp+NUMBER_OF_CHARS_PUSHED_OFFSET], 0

    cmp eax, 0
    jl Negative_number

    ; If it reach here, the number ins't negative, flag to false
    mov BYTE [ebp+NEGATIVE_NUMBER_FLAG_OFFSET], BYTE 0

    je Number_zero
    jmp Loop

Number_zero:
    ; If the number is zero, it has nothing todo, heading to end process
    add eax, '0'
    push eax

    inc DWORD [ebp+NUMBER_OF_CHARS_PUSHED_OFFSET]

    jmp Write_in_output

Negative_number:
    ; Set negative flag, will be handled after
    mov BYTE [ebp+NEGATIVE_NUMBER_FLAG_OFFSET], BYTE 1

    ; Transform number to positive
    mov edi, -1
    imul edi

Loop:
    ; Always compare if the number is lower than 10
    ; Numbers lower than 10 don't need to be divided
    cmp eax, 10

    jl Last_number

    xor edi, edi
    xor edx, edx

    ; Get rest of division and save in stack
    mov edi, 10
    div edi

    add edx, '0'
    push edx

    inc DWORD [ebp+NUMBER_OF_CHARS_PUSHED_OFFSET]

    jmp Loop

Last_number:

    ; If only has one number, just transform to string and save in stack
    add eax, '0'
    push eax

    inc DWORD [ebp+NUMBER_OF_CHARS_PUSHED_OFFSET]

    jmp Handle_negative_number

Handle_negative_number:
    ; Check the flag previous setted to see if a signal need be added
    cmp BYTE [ebp+NEGATIVE_NUMBER_FLAG_OFFSET], BYTE 1

    jne Write_in_output


    mov eax, "-"
    push eax

    inc DWORD [ebp+NUMBER_OF_CHARS_PUSHED_OFFSET]


Write_in_output:

Write_in_output_loop:
    ; Loading all numbers from memory and writing in output address
    pop eax
    mov [esi], eax

    inc esi

    dec DWORD [ebp+NUMBER_OF_CHARS_PUSHED_OFFSET]

    cmp DWORD [ebp+NUMBER_OF_CHARS_PUSHED_OFFSET], 0

    jge Write_in_output_loop

    mov esp, ebp

    pop ebp
    pop esi

    ret