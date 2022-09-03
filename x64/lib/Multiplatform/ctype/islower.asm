; Check if character is in lower case
;
; Input: character in AL register
; Output: if yes, RAX = 1, else RAX = 0


islower:
    cmp al, 'a'

    jge islower_greater_eq_than_a
    jmp islower_not_lower


islower_greater_eq_than_a:
    cmp al, 'z'

    jle islower_is_lower
    jmp islower_not_lower

islower_is_lower:
    mov rax, 1
    ret

islower_not_lower:
    mov rax, 0
    ret
