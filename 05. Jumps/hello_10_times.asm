	;; This is an assembly program that prints 'Hello!' 10 times
	;; using conditional jumps to create a loop

	segment .text
	global _start

_start:
    
loop_begin:

    ; moving the value of the count symbol to al.
    ; al is the 1/8 register of rax (8-bits).
    mov al, [count] 

    cmp al, 0xa ; compare with 0xa, 10 in hexadecimal.

    ; if al is greater or equal to 10, then
    ; jump to loop_end
    jge loop_end

    ;; if not, follow the normal flow
	
    ; increment al by 1
    inc al

    ; mov al back to count symbol
    mov [count], al

    ; prepare the print syscall
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, msg.sz

    ; Ask the kernel to print the string
    syscall

    ; Jump back to the loop to start
    ; over and over again until the counter reaches 10
    jmp loop_begin

loop_end:

    ; Exit the program
    mov rax, 60
    mov rdi, 0
    syscall

segment .rodata
    msg db 'Hello!', 0xa, 0x0
    msg.sz equ $- msg

segment .bss
    count resb 1
