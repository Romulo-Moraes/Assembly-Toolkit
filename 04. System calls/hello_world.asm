; As mentioned before, the text segment is used to
; store the program instructions, so is within this 
; segment that we are going to write the Assembly code

; The global keyword is used to make
; a label available across all object
; files. The linker requires the
; main text label to be available using
; this keyword.
global _start

segment .text

; By default, the _start label is 
; the entry point of the program.
_start:

    ; The following block of 
    ; code will print a
    ; message on terminal.
    ;
    ; The rax register means the 
    ; operation to be performed, 
    ; the programmers that built
    ; the linux made the value 1
    ; represent "print something...".
    ;
    ; The rdi register is the file
    ; descriptor to where the print
    ; shall be redirected, '0' 
    ; represents the STDIN,'1' the
    ; STDOUT, and '2' the STDERR.
    ;
    ; The rsi register is the pointer to the 
    ; message.
    ;
    ; The rdx register is the message length

    mov rax, 1
    mov rdi, 1
    mov rsi, message
    mov rdx, message_size

    ; After setting the registers with the
    ; correct values, ask the OS to perform the
    ; task
    syscall

    ; Our program finished all its instructions,
    ; so we need to ask the OS to unload the
    ; program from memory    
    ;
    ; 60 is the exit syscall
    ; 0 is the exit status

    mov rax, 60
    mov rdi, 0

    ; Asking the OS to perform the task
    syscall

; The read-only data segment is the place
; where we define the 'Hello, world!' message.
segment .rodata

    ; We use 'db' to Define a Byte or a chain of bytes.
    ; Every comma outside the quotes is a 
    ; concatenation, so the value 0xa, that means '\n'
    ; is appended to the string.
    ;
    ; The 0x0 represents the null 
    ; character, that is always necessary when we
    ; are handling with strings

    message db 'Hello, world!', 0xa, 0x0

    ; 'equ $-' is useful to get the size of something on 
    ; memory, so message_size = sizeof(message)
    message_size equ $- message