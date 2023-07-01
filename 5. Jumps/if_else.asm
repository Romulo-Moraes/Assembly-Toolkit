; Program that greets a person using conditional jumps

segment .text
    global _start

_start:
    ; the number put in rax define the flow of
    ; the program, if it's 1 then the printed 
    ; message will be 'Nice to meet you, John!'
    ; otherwise it will be 'Nice to meet you, someone else!'
    mov rax, 1

    ; compare to verify if it's John running
    ; the program
    cmp rax, 1

    ; If it isn't, then jump to the 'else' of
    ; our 'if/else' statement
    jnz else

    ; If is John running the program, then
    ; just follow the normal flow of the program
    ; for now

if_1_then:
    ; Print the message: 'Nice to meet you, John!'
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, msg.sz
    syscall

    ; This is a if/else statement, we don't wan't
    ; execute the else whether the 'if' was executed
    ; so jump to end
    jmp end
if_1_end:

else:
    ; print the message: 'Nice to meet you, someone else!'
    mov rax, 1
    mov rdi, 1
    mov rsi, msg2
    mov rdx, msg2.sz
    syscall
end:

    ; exit the program
    mov rax, 60
    mov rdi, 0
    syscall


segment .rodata
    msg db 'Nice to meet you, John!', 0xa, 0x0
    msg.sz equ $- msg

    msg2 db 'Nice to meet you, someone else!', 0xa, 0x0
    msg2.sz equ $- msg2
