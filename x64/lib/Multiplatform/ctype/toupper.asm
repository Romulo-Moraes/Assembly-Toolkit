; Transform a lowercase character to uppercase
;
; Input: character in AL register
; Output: transformed character in AL register

toupper:
    cmp al, 'a'
    
    jge toupper_greater_eq_than_a
    jmp toupper_fail

toupper_greater_eq_than_a:
    cmp al, 'z'

    jle toupper_is_lowercase
    jmp toupper_fail

toupper_is_lowercase:
    sub al, ' '
    ret

toupper_fail:
    ret
