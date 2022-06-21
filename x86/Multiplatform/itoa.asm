; Convert integer to string
;  
; Input: number in eax, output address in ESI
;
; Output: Number as string in address given by ESI

int_to_string:
    xor ebx,ebx
    xor ecx,ecx

    cmp eax,0
    jl IF_NEGATIVE_NUMBER

    jmp begin

IF_NEGATIVE_NUMBER:
    mov ebx,1
    mov edx,-1
    imul edx

begin:
    cmp eax,0

    jne run_process

    cmp ecx,0
    je FIRST_AND_ZERO

    jmp FIRST_AND_ZERO_END

FIRST_AND_ZERO:
    mov eax,'0'
    push eax
    inc ecx

FIRST_AND_ZERO_END:
    cmp ebx,1
    je APPLY_NUMBER_SIGN
    jmp APPLY_NUMBER_SIGN_END

APPLY_NUMBER_SIGN
    mov eax,'-'
    push eax
    inc ecx

APPLY_NUMBER_SIGN_END:
    jmp reverse_sequence

run_process:
    cmp eax,10
    jge IF_10

    mov edi,eax

    mov eax,0
    jmp IF_NOT_10

IF_10
    
