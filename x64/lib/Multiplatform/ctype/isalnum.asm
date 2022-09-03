; Check if the character is alpha or numeric
;
; Input: character in AL register
; Output: if yes, RAX = 1, else RAX = 0


isalnum:
isalnum_check_lowercase:
    cmp al, 'a'

    jge isalnum_check_lowercase2
    jmp isalnum_check_uppercase

isalnum_check_lowercase2:
    cmp al, 'z'

    jle isalnum_is_alnum
    jmp isalnum_check_uppercase




isalnum_check_uppercase:
    cmp al, 'A'

    jge isalnum_check_uppercase2
    jmp isalnum_check_numeric

isalnum_check_uppercase2:
    cmp al, 'Z'

    jle isalnum_is_alnum
    jmp isalnum_check_numeric


isalnum_check_numeric:
    cmp al, '0'

    jge isalnum_check_numeric2
    jmp isalnum_not_alnum


isalnum_check_numeric2:
    cmp al, '9'

    jle isalnum_is_alnum
    jmp isalnum_not_alnum

isalnum_is_alnum:
    mov rax, 1
    ret

isalnum_not_alnum:
    mov rax, 0
    ret