; Below the text segment is where we will put 
; the instructions of our software.
; the 'global' keyword is used to tell the 
; linker what procedures you wan't to make
; available across object files, and is also
; used to tell the linker where our program
; starts

segment .text
    ; 'global _start' is always required
    ; whether you wan't make this file
    ; executable
    global _start

; Entry point of our program. The linker
; always waits for the procedure name _start
; as entry point by default.
_start:

    ; The following block of code will print a
    ; message on terminal and each register
    ; has a meaning. the rax represent the 
    ; operation to do, the programmers that   
    ; built the linux made 1 represents 
    ; print on terminal, rdi is the file 
    ; descriptor to do it, being '0' the 
    ; STDIN, '1' the STDOUT, and '2' the 
    ; STDERR, rsi is the pointer to the 
    ; message and rdx is the size of the 
    ; message to be printed.

    mov rax, 1
    mov rdi, 1
    mov rsi, message
    mov rdx, message_size

    ; After filling the registers with the 
    ; correct values, just send a message to 
    ; the OS asking for a favor
    syscall

    ; Other favor asking, but this time is 
    ; saying to the OS that our program 
    ; finished all its instructions and wan't 
    ; be unloaded from memory. the rdi 
    ; register is the status that will be sent 
    ; to the OS on program exit

    mov rax, 60
    mov rdi, 0

    ; Asking the favor
    syscall

; The read-only data segment is the place
; where we put the 'Hello, world!' message.
segment .rodata

    ; We use 'db' that means define byte to 
    ; define a byte or a chain of bytes.
    ; each comma outside the quotes is a 
    ; concatenation, then there was added
    ; 0xa that is the decimal character 10,
    ; representing '\n' and finally the null 
    ; byte that is always necessary when we
    ; are handling with strings

    message db 'Hello, world!', 0xa, 0x0

    ; 'equ $-' here means to get the size of a 
    ; constant, then message_size = sizeof(message)
    message_size equ $- message