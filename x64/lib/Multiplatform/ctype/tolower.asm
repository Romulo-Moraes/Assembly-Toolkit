; Transform a uppercase character to lowercase
;
; Input: character in AL register
; Output: transformed character in AL register


tolower:
    cmp al, 'A'

    jge tolower_greater_eq_than_A
    jmp tolower_fail


tolower_greater_eq_than_A:
    cmp al, 'Z'

    jle tolower_is_uppercase
    jmp tolower_fail


tolower_is_uppercase:
    add al, BYTE ' '

    ret 

tolower_fail:
    ret