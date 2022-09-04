; Return the length of the initial segment of RSI which consists entirely of 
; characters not in RDI.
;
; Input: string address in RSI, limits in RDI
; Output: length in RAX

strcspn:
    ; I variable
    xor rdx, rdx

    strcspn_while_1:
        ; Loop controller, run until
        ; reach null byte of string
        cmp BYTE [rsi], BYTE 0
        je strcspn_while_1_end

        ; Save rdi for next loop
        push rdi
        strcspn_while_2:
            ; Loop controller, run until
            ; reach null byte of string
            cmp BYTE [rdi], BYTE 0
            je strcspn_while_2_end

            ; Compare if char of string and
            ; limits match
            mov al, BYTE [rdi]
            cmp BYTE [rsi], al

            ; If not match, jump the next step
            jne strcspn_character_found_end

            strcspn_character_found:
                ; Unload rdi from memory
                pop rdi

                ; Pass i variable to rax
                ; and then return
                mov rax, rdx
                ret
            strcspn_character_found_end:

            ; If the execution flow reach
            ; here is because the chars
            ; didn't match

            ; Increment limits to next
            ; character and jump to loop
            ; again
            inc rdi
            jmp strcspn_while_2
        strcspn_while_2_end:

        ; Load rdi to next loop
        pop rdi
        
        ; Increment i variable
        inc rdx
        ; The current char wasn't found
        ; in current loop, then increment
        ; and try the next one
        inc rsi

        jmp strcspn_while_1
    strcspn_while_1_end:

    ; If the code reach here, no one 
    ; limits was found in string, then
    ; will return the position of first
    ; null byte found
    mov rax, rdx
    ret
