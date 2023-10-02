# 15. Callbacks
There's the possibility of callbacks, even being in the low-level. We can move the address of a symbol from the .text to a register and then call it any time we want to, or do anything with it, like store this address on the stack or in any other memory segment. Here's a example of callbacks, this source code is also available inside the directory ./Callbacks.
```asm
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
```
Callbacks is a really interessant concept, there's not the necessity of passing a argument to the 'chooser_procedure', in usual cases the 'chooser_procedure' generate the data and give to your function to handle with it.


# The syscall 60
After sections and more sections, this reached to the end, was left a good content here, and will be really good for any basic doubt about the Assembly language of anyone, even being just a documentation about my journey learning it. Thanks :)
```asm
mov rax, 60
mov rdi, GOODBYE ; macro representing 0
syscall
```