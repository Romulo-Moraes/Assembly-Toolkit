
# 4. System calls
System calls are an important thing when we are building programs in userland, with this we can interact with the Operating System and just ask favors like read a file, print something in the screen, get current working directory and so on...

Having it in mind, great part of everything that the C language does isn't really it that does. Our program in userland doesn't has the privileges to access the HD to read a file or even access to the network card to create a socket and send data through the internet, it barely know how to do it, even because our program usually has few instructions and can't control an entire device. In this moment comes the Operating System, that is a huge software and with it's drivers can do the dirty job, in short, our program just ask for favors to the Operating System and the OS does whether it is in a good day.

A system call uses registers to communicate with the OS and also uses a new opcode, called 'syscall'.

The following code is a program that prints the first message that every programmer must make when learning a new language:

```asm
; Below the text segment is where we will put 
; the instructions of our software.
; the 'global' keyword is used to tell the 
; linker what procedures you want to make
; available across object files, and is also
; used to tell the linker where our program
; starts

segment .text
    ; 'global _start' is always required
    ; whether you want to make this file
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
    ; finished all its instructions and want to
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
```

But you may ask: "It's really necessary remember every single system call's numbers when make one ?", and the answer is no. The Linux kernel developers already give you a list of all of them and can be found in any place at the internet, but i would recommend this one: https://hackeradam.com/x86-64-linux-syscalls/.

## 1.1. Warnings
It's important to say that every time that you do a system call, a great part of the registers are reseted, so you must save their values in memory if you want to use them for another reason.

## 1.2. Running the code

To try this code in your own machine you will need the Nasm assembler, and i have to remind you that this block of code only works on Linux machines, however, Nasm already exists for Windows but the system calls used in this example only work for Linux.

Assuming that your file name is hello_world.asm do the following command to assemble:
```sh
nasm -f elf64 hello_world.asm
```
and to link it just do:
```sh
ld hello_world.o -o hello_world
```
and then simply call the program:
```sh
./hello_world
```

## 1.3. Changing the entry point name
As said in the comments of the previous code, the linker always waits for the procedure _start to be the entry point, and gives us some alerts case don't find it, however, it's possible to tell him to start from another point that we can define. The only necessary thing is to pass the flag '-e' to it, specifying the name of the procedure.
```asm
segment .text
global customized_program_entry_point

customized_program_entry_point:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, msg.sz
    syscall

    mov rax, 60
    mov rdi, 0
    syscall

segment .rodata
    msg db 'Hello, world!', 0xa, 0x0
    msg.sz equ $-msg
```
And the commands to assemble and link the file:
```sh
nasm -f elf64 entry_point.asm
ld -e customized_program_entry_point entry_point.o -o entry_point
```
Running the program should give us the expected result:
```txt
sh-5.1$ ./entry_point 
Hello, world!
```

## 1.4. What's next
We finally made our first program and put it to run on our own machine, great! In the next section of our journey we will talk a bit about jumps and conditional jumps, that is a important thing to the nowaday computers.
