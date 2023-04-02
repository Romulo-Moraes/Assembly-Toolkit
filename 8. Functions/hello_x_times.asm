    segment .text
    global _start

_start:
    ; Allocate space in stack for answer
    mov rbp,rsp
    sub rsp,1

    ; Do the question
    mov rax, 1
    mov rdi, 1
    mov rsi, question
    mov rdx, question.sz
    syscall

    ; Receive the answer
    mov rax, 0
    mov rdi, 0
    lea rsi, [rbp+-1]
    mov rdx, 1
    syscall

    sub BYTE [rbp+-1], '0'

    ; al is the 8bit register of rax
    mov al, [rbp+-1]

    ; rax has the same value of al
    push rax

    ; print the "Hello, world" sequence
    call print_hello_word

    mov rax, 1 ; <- the return address is exactly here
    mov rdi, 1
    mov rsi, final_message
    mov rdx, final_message.sz
    syscall
    ; Final message displayed above

    ; Program exit
    mov rax, 60
    mov rdi, 0
    syscall

print_hello_word:
    ; pass function arguments through 
    ; registers seems obvious, so here will
    ; be shown passing through stack segment
    push rbp
    mov rbp, rsp

    ; Allocating memory in stack frame
    sub rsp, 20

    ; rbx now have rax value
    mov rbx, [rbp+16]
    
    ; Counter in rbp+-1, occupying 1 byte
    mov BYTE [rbp+-1], 0

    ; Moving the message "Hello, world!\n",
    ; this of course could be put in .rodata
    ; segment, however, i put here to give a 
    ; utility to the memory allocation in stack
    ; frame.
    mov rax, "Hello, w"
    mov QWORD [rbp+-17], rax
    mov rax, "orld!"
    mov QWORD [rbp+-9], rax
    mov al, 0xa
    mov BYTE [rbp+-4], al

; Loop to print the message
PRINT_LOOP:
    ; dl is the 8bits register from rdx
    mov dl, [rbp+-1]
    
    ; rdx has the value of dl
    cmp rdx, rbx

    ; If the counter still less than
    ; the number that the user typed,
    ; then we can print more one time
    jl COUNTER_IS_OK

    ; If not, then jl is ignored
    ; and a jump to print_hello_world_end
    ; occur
    jmp print_hello_word_end

; Begin of print instructions
COUNTER_IS_OK:
    ; We must increment dl to 
    ; control the program
    inc dl

    ; Saving dl inside the stack.
    ; this is necessary because all
    ; data registers are reseted when a 
    ; syscall is called
    mov [rbp+-1], dl

    ; requesting the O.S to print our message
    mov rax, 1
    mov rdi, 1
    lea rsi, [rbp+-17] ; <- located here
    mov rdx, 14 ; <- size of the entire message (with \n)
    syscall

    jmp PRINT_LOOP ; <- start over and over again...

; When the procedure reach the end a jump will 
; occur to here
print_hello_word_end:
    ; deallocate memory from stack frame
    add rsp, 20
    ; pop the rbp that we pushed previously
    pop rbp

    ; pop return address from stack and send it to CPU
    ret

segment .rodata
    question db "How many times do you wan't hear a Hello, world?", 0xa,"->" , 0x0
    question.sz equ $- question

    final_message db "Here you are. :)", 0xa, 0x0
    final_message.sz equ $- final_message