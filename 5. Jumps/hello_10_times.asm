segment .text
    global _start

_start:
    
loop_begin:

    ; moving value of symbol count to al
    ; al is the register of 8 bits from rax
    mov al, [count] 

    cmp al, 0xa ; compare with 0xa, aka 10.

    ; if al is greater or equal to 10, then
    ; jump to loop_end
    jge loop_end

    ; increment al by 1
    inc al

    ; mov al back to symbol count
    mov [count], al

    ; print the message
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, msg.sz

    ; Ask the favor
    syscall

    ; Jump back to the begin of loop to start
    ; over and over again until count reach 10
    jmp loop_begin

loop_end:

    ; Exit the program
    mov rax, 60
    mov rdi, 1
    syscall

segment .rodata
    msg db 'Hello!', 0xa, 0x0
    msg.sz equ $- msg

segment .bss
    count resb 1