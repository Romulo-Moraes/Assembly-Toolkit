segment .text
global hello_msg ; export the procedure

hello_msg:
    push rbp
    mov rbp, rsp
    sub rsp, 15

    mov rax, 'Hello, C'
    mov [rbp+-15], rax
    mov rax, ' lang!'
    mov [rbp+-7], rax
    mov BYTE [rbp+-1], 0xa

    mov rax, 1
    mov rdi, 1
    lea rsi, [rbp+-15]
    mov rdx, 15
    syscall

    mov rsp, rbp
    
    pop rbp
    ret
