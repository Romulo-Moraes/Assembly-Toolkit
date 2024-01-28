# 14. Position-independent code
Position-independent code is an addressing strategy for programs that may not always load into a specific address in memory.

For example, whenever an address in `.rodata` has to be accessed, a Position-Independent Code (PIC) program will use the value of the `RIP` register to get the correct address.

The `RIP` address is a special register that always points to the next instruction that will be executed. The calculation is performed by obtaining the difference between the symbol in `.rodata` and the current `RIP` value.

The `lea` opcode is commonly used with relative addresses in order to obtain the real address pointed by the difference.
```asm
segment .text
global _start

_start:

    mov rax, 1
    mov rdi, 1
    ; Passing the address of
    ; msg relative to RIP
    lea rsi, [rel msg]
    ; This is not necessary with msg.sz
    ; because this is a macro, 
    ; not an address, so 
    ; it is resolved in assembly time
    mov rdx, msg.sz
    syscall

    mov rax, 60
    mov rdi, 0
    syscall

segment .data
    msg db 'Hello, people.', 0xa, 0x0
    msg.sz equ $-msg
```
Without relative addresses, the linker may encounter issues when linking the Assembly object file against a C object file.

There are C and Assembly files inside the `PIC` directory. They provide an example of how the linker behaves when linking assembly files against the C driver using both approaches, absolute and relative addressing.
```txt
gcc driver.c hello_world.o -o driver

/usr/bin/ld: hello_world.o: warning: relocation in read-only section `.text'
/usr/bin/ld: warning: creating DT_TEXTREL in a PIE
```

```txt
gcc driver.c relative_hello_world.o -o driver
```
