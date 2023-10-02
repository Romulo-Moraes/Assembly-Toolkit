# 14. Position-independent code
Position-independent code, or just PIC, is a program that doesn't uses absolute addresses on its execution, this usually happens when you use an address from segments like .rodata or .data. What happens is that when you refer to symbols that lies in those segment you are calling a fixed address that the linker addressed to you, however, when the program is loaded into the memory for execution, these fixed addresses doesn't hold meaning anymore, even because the program may be loaded in a random location in memory,  requiring that the OS loader update these addresses at the loading time to the executable be able to access the correct data in run-time. With the PIC, we can access RIP relative addresses, giving more flexibility. RIP is a special register from the CPU that points to the next instruction to be executed in memory, when the CPU finish of executing the current instruction, it will fetch from that address, and then, update the RIP again. With the RIP pointing to the next instruction (That's very close) we can just order to the CPU use the RIP address plus a offset to make a jump, read/write an address or even a procedure call.
```asm
segment .text
global _start

_start:

    mov rax, 1
    mov rdi, 1
    ; Passing the address of msg relative to the RIP
    lea rsi, [rel msg]
    ; It isn't necessary with msg.sz
    ; this is a macro, not an address, so
    ; it is resolved at Assemble time
    mov rdx, msg.sz
    syscall

    mov rax, 60
    mov rdi, 0
    syscall

segment .data
    msg db 'Hello, people.', 0xa, 0x0
    msg.sz equ $-msg
```
Without this, some problems would be found when moving a Assembly code to execute alongside a C lang code. A example of this is the following:
```txt
sh-5.1$ gcc main.c rel_hello_world.o -o main
/usr/bin/ld: rel_hello_world.o: relocation R_X86_64_32S against `.data' can not be used when making a PIE object; recompile with -fPIE
/usr/bin/ld: failed to set dynamic section sizes: bad value
collect2: error: ld returned 1 exit status
```
This is a try of print the msg symbol using absolute address, like we have been doing until now (In this example, the global entry and the name of the procedure '_start' was changed to printtt). There's no possibility of link a object file that contain the _start procedure using the GCC, that's because a conflict will happen when the compiler try to link the files. The GCC compiler when building the program will try implement its own _start procedure (which one that call the programmable procedure main)).

## What's next
After resolving this problem related with the C and PIC programs, we can now keep going to the next section that is the callbacks in the Assembly language.

