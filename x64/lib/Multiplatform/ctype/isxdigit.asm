; Check if a character is a hexadecimal digit
;
; Input: character in AL register
; Output: if yes, RAX = 1, else RAX = 0


isxdigit:
isxdigit_check_lowercase_range:
    cmp al, 'a'

    jge isxdigit_check_lowercase_range2
    jmp isxdigit_check_uppercase_range

isxdigit_check_lowercase_range2:
    cmp al, 'f'

    jle isxdigit_is_xdigit 
    jmp isxdigit_check_uppercase_range

isxdigit_check_uppercase_range:
    cmp al, 'A'

    jge isxdigit_check_uppercase_range2
    jmp isxdigit_check_numeric_range

isxdigit_check_uppercase_range2:
    cmp al, 'F'

    jle isxdigit_is_xdigit
    jmp isxdigit_check_numeric_range

isxdigit_check_numeric_range:
    cmp al, '0'

    jge isxdigit_check_numeric_range2
    jmp isxdigit_not_xdigit

isxdigit_check_numeric_range2:
    cmp al, '9'

    jle isxdigit_is_xdigit
    jmp isxdigit_not_xdigit

isxdigit_is_xdigit:
    mov rax, 1
    ret

isxdigit_not_xdigit:
    mov rax, 0
    ret