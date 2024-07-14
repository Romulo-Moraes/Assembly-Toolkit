;; atoi - function that receives a string and return the contents as integer 
;; 
;; RDI register receives the address of the string
;; RAX is the return value (contains the integer)

%define _ATOI_NEGATIVE_FLAG 1
%define _DIGIT_COUNTER 9
%define _FINAL_NUMBER 17
%define _RATIO 18

atoi:
    ; saving registers 
    push rbp
    push rbx
    push rdx

    ; aligning stack registers
    ; and allocating memory
    mov rbp, rsp
    sub rsp, 18

    ; setting default values for each variable
    mov QWORD [rbp-_DIGIT_COUNTER], 0
    mov QWORD [rbp-_FINAL_NUMBER], 0
    mov BYTE [rbp-_RATIO], 10

    ; checking if the given number positive
    cmp BYTE [rdi], '-'
    
    jne _atoi_number_is_positive

    ; set negative flag and increment pointer
    mov BYTE [rbp-_ATOI_NEGATIVE_FLAG], 1
    inc rdi

_atoi_number_is_positive:
_atoi_loop:
    ; checking if the loop reached the
    ; end of the string
    cmp BYTE [rdi], 0
    je _atoi_loop_end

    ; calling a private function that
    ; checks if a character is numeric
    call check_if_character_is_numeric

    ; checking the result
    cmp rax, 1
    jne _atoi_loop_end

    ; moving the numeric character to dl
    mov dl, [rdi]

    ; pushing rdx (dl)
    push rdx

    ; incrementing the digit counter
    ; useful to fetch the pushed values
    inc QWORD [rbp-_DIGIT_COUNTER]

    ; incrementing the numeric string pointer
    inc rdi

    ; jumping back to the loop
    jmp _atoi_loop

_atoi_loop_end:
    ; zeroing rbx to be used as counter
    xor rbx, rbx
    ; rdx will be used as multiplier
    ; for multiplication operations
    mov rdx, 1

_atoi_transformation_loop:
    ; checking if we've already poped
    ; all values from stack
    cmp rbx, [rbp-_DIGIT_COUNTER]

    jge _atoi_transformation_loop_end

    ; pops the next value from stack
    pop rax

    ; pushing rdx to be available after
    ; the multiplication operation
    push rdx

    ; sub '0' from rax to get the numeric
    ; representation of the character
    sub rax, '0'
    mul rdx

    ; restore rdx
    pop rdx

    ; add the multiplication result to 
    ; the final number variable
    add [rbp-_FINAL_NUMBER], rax
    
    ; (multiplies the rdx by 10)
    mov rax, rdx
    mul BYTE [rbp-_RATIO]
    mov rdx, rax

    ; increment the counter
    inc rbx

    ; jumps back to the loop
    jmp _atoi_transformation_loop

_atoi_transformation_loop_end:
    ; move the final number variable to rax
    mov rax, [rbp-_FINAL_NUMBER]

    ; checks if the native flag is set
    ; to negate rax if necessary
    cmp BYTE [rbp-_ATOI_NEGATIVE_FLAG], 1
    jne _atoi_end

    neg rax

_atoi_end:
    ; deallocating the stack frame
    ; and restoring the previous
    ; pushed registers
    mov rsp, rbp
    pop rdx
    pop rbx
    pop rbp

    ; returns from the function
    ret

; private functions that checks if
; if the given character is numeric
;
; RDI receives the character that needs to be verified
; RAX holds the return value (boolean)
check_if_character_is_numeric:
    ; saving registers
    push rbp
    push rdi
    push rbx

    ; aligning and allocating 
    ; stack frame memory    
    mov rbp, rsp
    sub rsp, 1

    mov bl, [rdi]
    sub rbx, '0'

    ; checking if the character is 
    ; greater than or equal the character '0'
    cmp rbx, 0
    setge BYTE [rbp-1]

    ; checking if the character is 
    ; lower than or equal then the character '9'
    cmp rbx, 9
    setle BYTE dil

    ; performing a bitwise 'and' on the result
    ; of the previous operations
    and dil, [rbp-1]
    
    ; checking if the character is numeric
    cmp dil, 1
    je _numeric

_not_numeric:
    mov rax, 0

    jmp check_if_character_is_numeric_end

_numeric:
    mov rax, 1

check_if_character_is_numeric_end:
    ; deallocating the stack frame 
    ; and restoring the pushed registers
    mov rsp, rbp
    pop rbx
    pop rdi
    pop rbp

    ; returning from the function
    ret

