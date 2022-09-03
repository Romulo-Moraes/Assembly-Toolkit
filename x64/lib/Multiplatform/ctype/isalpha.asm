; Check if passed character is in alphabet
;
; Input: character in al register
; Output: if yes, RAX = 1, else RAX = 0


isalpha:
    cmp al, BYTE 'a'
    jge isalpha_greater_than_a

    cmp al, BYTE 'A'
    jge isalpha_greater_than_A


    jmp isalpha_not_alpha

isalpha_greater_than_a:
    cmp al, 'z'
    jle isalpha_is_alpha

    jmp isalpha_not_alpha

isalpha_greater_than_A:
    cmp al, 'Z'
    jle isalpha_is_alpha

    jmp isalpha_not_alpha


isalpha_is_alpha:
    mov rax, 1
    ret

isalpha_not_alpha:
    mov rax, 0
    ret
