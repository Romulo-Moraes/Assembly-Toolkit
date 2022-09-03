; Check if the passed character is in uppercase
;
; Input: character in AL register
; Output: if yes, RAX = 1, else RAX = 0

isupper:
    cmp al, 'A'

    jge isupper_greater_eq_than_A
    jmp isupper_not_upper



isupper_greater_eq_than_A:
    cmp al, 'Z'

    jle isupper_is_upper
    jmp isupper_not_upper


isupper_is_upper:
    mov rax, 1
    ret


isupper_not_upper:
    mov rax, 0
    ret