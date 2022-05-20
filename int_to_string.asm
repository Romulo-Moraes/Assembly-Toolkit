; Convert integer to string
;  
; Input: number in rax, output address in RSI
;
; Output Number as string in address given by RSI

int_to_string:
    xor r11,11
    xor rcx,rcx

    cmp rax,0
    jl IF_NEGATIVE_NUMBER

    jmp begin

IF_NEGATIVE_NUMBER:
    mov r11,1
    mov r10,-1
    imul r10

begin:

    cmp rax,0
    jne run_process

    cmp rcx,0
    je FIRST_AND_ZERO

    jmp FIRST_AND_ZERO_END

FIRST_AND_ZERO:
    mov rax,'0'
    push rax
    inc rcx
FIRST_AND_ZERO_END:

    cmp r11,1
    je APPLY_NUMBER_SIGN

    jmp APPLY_NUMBER_SIGN_END

APPLY_NUMBER_SIGN:
    mov rax,'-'
    push rax
    inc rcx
APPLY_NUMBER_SIGN_END:

    jmp reverse_sequence

run_process:
    cmp rax,10
    jge IF_10

    mov rdx,rax
    mov rax,0
    jmp IF_NOT_10

IF_10:
    mov r9,10
    div r9
IF_NOT_10:

    add rdx,'0'
    push rdx

    inc rcx

    jmp begin

reverse_sequence:
    cmp rcx,0
    jne IF_NOT_0

    ret

IF_NOT_0:
    pop rax
    mov [rsi],rax
    inc rsi
    dec rcx
    jmp reverse_sequence