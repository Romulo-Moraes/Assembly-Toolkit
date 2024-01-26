global helloMsg ; making the procedure globally 
                ; visible to the linker

%define SYS_WRITE 1
%define STDOUT 1

segment .text

helloMsg:
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    lea rsi, [rel message]
    mov rdx, message.sz
    syscall

    ret
    

segment .rodata
    message db "Hello, C lang!", 0xa
    message.sz equ $-message