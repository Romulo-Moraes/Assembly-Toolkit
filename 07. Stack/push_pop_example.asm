	segment .text
	global _start

_start:
    mov rax, 7
    mov rbx, 8
    mov rdx, 9

	; pushing values onto the stack
    push rax
    push rbx
    push rdx

    ; while loop to pop all values
loop:

    ; runs 3 times
    mov al, [counter]
    cmp al, 3

    jge loop_end

    ; pop into rax
    pop rax
    ; transform into string
    add rax, '0'
    ; mov to an address in .data
    mov [numberAsString], al

    ; print the number
    mov rax, 1
    mov rdi, 1
    mov rsi, numberAsString
    mov rdx, 2
    syscall

    ; increment counter
    inc BYTE [counter]

    ; jump back to loop
    jmp loop

loop_end:

    mov rax, 60
    mov rdi, 0
    syscall

segment .bss
    counter resb 1

segment .data
    ; A symbol that represents a null byte
    ; and a new line (\n).
    ; The null byte will be replaced
    ; by a number on each loop
    numberAsString db 0x0, 0xa