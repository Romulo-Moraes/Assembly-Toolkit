; Check if character is a digit
;
; Input: Character in al register
; Output: if digit RAX = 1, else RAX = 0

isdigit:
    cmp al, BYTE '0'

    jge isdigit_greater_eq_than_zero
    jmp isdigit_not_digit

isdigit_greater_eq_than_zero:
    cmp al , BYTE '9'

    jle isdigit_is_digit
    jmp isdigit_not_digit

isdigit_is_digit:
    mov rax, 1
    ret

isdigit_not_digit:
    mov rax, 0
    ret