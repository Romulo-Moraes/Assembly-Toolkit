; Program that greets the user using conditional jumps

segment .text
    global _start

_start:
    ; the number set to the rax register defines the flow of
    ; the program, if it's 1, the printed 
    ; message will be 'Nice to meet you, John!',
    ; otherwise 'Nice to meet you, someone else!' will be printed
    mov rax, 1

    ; compare to verify if is John running
    ; the program
    cmp rax, 1

    ; If the user isn't John, jump to the 'else'
    ; of our 'if/else' statement
    jnz else

    ; If is John running the program,
    ; just follow the normal flow of the program

if_john_then:
    ; Print the message: 'Nice to meet you, John!'
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, msg.sz
    syscall

    ; This is a if/else statement, we don't want
    ; execute the else because is John that is using
    ; the program
    jmp end

if_john_end:

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
