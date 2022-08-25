; concat two strings

; Destiny address in RDI, source address in RSI

strcat:
    ; Save some registers
    push rdi
    push rsi

strcat_while1: ; Loop to find which position the 
               ; concat should start in destiny address,
               ; the value that mark it is a null byte
                
    ; Compare to check if reached the null byte
    cmp [rdi], BYTE 0

    ; If reached, jump to next phase of strcat process
    jz strcat_while2

    ; If not, increment rdi position and try again
    inc rdi
    jmp strcat_while1

strcat_while2: ; From this point all value of source address
               ; will be copied to destiny, right in the found
               ; null byte foward

    ; Check if source address reached the end,
    ; if yes, jump to the end
    cmp [rsi], BYTE 0
    je strcat_end

    ; If not, copy each byte from source to destiny destination
    mov r8b, BYTE [rsi]
    mov [rdi], r8b

    ; Increment both address
    inc rsi
    inc rdi

    ; Do the process again
    jmp strcat_while2
strcat_end:
    ; At the end, the destiny string receive a null
    ; byte in the end of string.
    mov [rdi], byte 0

    ; Restore all registers saved before
    pop rsi
    pop rdi

    ; Return from function call
    ret
