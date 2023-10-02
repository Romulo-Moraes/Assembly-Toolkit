segment .text
global _start

function2:
    push rbp
    mov rbp, rsp

    ; Insert the number into the string
    add rdi, '0'
    mov [rel function2_msg+function2_msg.sz-3], dil

    ; Print it
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel function2_msg]
    mov rdx, function2_msg.sz
    syscall

    pop rbp

    ret

function1:
    push rbp
    mov rbp, rsp

    ; Insert the number into the string
    add rdi, '0'
    mov [rel function1_msg+function1_msg.sz-3], dil

    ; Print it
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel function1_msg]
    mov rdx, function1_msg.sz
    syscall

    pop rbp

    ret

; chooser_procedure(int, fpointer, fpointer, int)
chooser_procedure:
    push rbp
    mov rbp, rsp

    ; Comparing the rdi to decide which function
    ; pointer will be called
    cmp rdi, 1

    ; Move the content of rcx to rdi,
    ; this will be the value printed from 
    ; any called function
    mov rdi, rcx

    ; Ignore 'call rsi' and jump to call the function2
    ; if the value of rdi is not 1
    jne not_1

    ; Calls the function1
    call rsi
    jmp chooser_procedure_end
not_1:
    ; Calls the function2
    call rdx
chooser_procedure_end:
    pop rbp
    ret

_start:
    ; This function call will call the function1
    ; in the end
    mov rdi, 1
    ; Both rsi and rdx are callbacks
    lea rsi, [rel function1]
    lea rdx, [rel function2]
    mov rcx, 5
    call chooser_procedure

    ; This function call will call the function2
    ; in the end
    mov rdi, 2
    ; Both rsi and rdx are callbacks
    lea rsi, [rel function1]
    lea rdx, [rel function2]
    mov rcx, 5
    call chooser_procedure

    ; Exit the program
    mov rax, 60
    mov rdi, 0
    syscall

segment .data
    function1_msg db 'The FIRST function option printing the number: ', 0x1, 0xa, 0x0
    function1_msg.sz equ $-function1_msg

    function2_msg db 'The SECOND function option printing the number: ', 0x1, 0xa, 0x0
    function2_msg.sz equ $-function2_msg