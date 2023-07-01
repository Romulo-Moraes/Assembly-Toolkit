# 2. Registers section
Register bank or also know as registers is a kind of memory that lies inside the CPU, and it's speed is much better than a normal RAM or SSD. This component of a CPU is responsible for manage data, make system calls, store flags and more...

## 2.1 Registers types
There's some types of registers, each type is useful to accomplish a logical problem, here is the most important types of registers that exist:

```txt
Data: Is useful to manage data inside the CPU.

Pointer: Is useful to work with the stack segment (Will be covered later).

Index: Is useful to index something in the memory, acting like a pointer in C language.
```

Is important to say that the size of the registers respect the word's size of the CPU's architecture, but is possible access just a part of a data register for example, like the first half or the first 1/4, etc...


Now that you know all types of registers is the time of reveal their names, it can be tough at the begin because a great part of them has just 3 characters and some of them don't refer to anything, but you'll get it soon.

```txt
Data: {
    RAX
    RBX
    RCX
    RDX
    R8-R15 (R8, R9, R10...)
}
Pointer: {
    RBP
    RSP
}
Index: {
    RSI
    RDI
}
```

These registers are from x86-64 and can be different in another architecture that doesn't follow this feature.

It's time to work a bit with these registers and those opcodes that we learnt before, so here is some codes and what they do.

```asm
; First program
mov rax, 0x4 ; move the value 0x4 to register rax
add rax, 0x2 ; add 0x2 to rax, total: 0x6
mov rbx, rax ; mov value of rax to rbx (rax still having 0x6)
sub rbx, 0x3 ; subtract 0x3 from rbx, total: 0x3

; In the end, the register rax has the value 0x6 and rbx has the value 0x3.
```

It's often normal to Assembly programmers write the numbers in hexadecimal, However, you could write just decimal numbers without any problem, of course removing the '0x' before the number.

In Assembly language, the comments are made with a semicolon and can be put in any place that you wan't comment.

The two remaining kinds of registers will be covered in another section, here is just to see what they are.

## 2.2 Older versions of nowaday registers
The word of the architecture x86-64 is exactly 64 bits, in other words, 8 bytes, so in teory we can only manage data by 8 bytes at a time, correct ?

At the begin of computing, the memory was very expensive and wasn't possible to make a register of 64 bits, so we started with basic examples of register, being it 8 bits, after 16 and so on... until reach at the most common among the registers that is 64 bits.

But if we face a problem that require we manage one byte at a time, what we do ? We still can access these kinds of registers, however, that is not differents registers, this is a part of the main register of 64 bits, we just access a percentage of it.

Here is the first half with 32 bits:
```txt
32 bits registers: {
    Data: {
        EAX
        EBX
        ECX
        EDX
        R8D-R15D(32)
    }
    Pointer: {
        EBP
        ESP
    }
    Index: {
        ESI
        EDI
    }
```
Here is the 1/4 from the full register:
```txt
16 bits registers: {
    Data: {
        AX
        BX
        CX
        DX
        R8W-R15W(16)
    }
    Pointer: {
        BP
        SP
    }
    Index: {
        SI
        DI
    }
}
```
And the 8 bits registers:
```txt
8 bits registers: {
    Data: {
        AL
        BL
        CL
        DL
        R8B-R15B(8)
    }
    Pointer: {
        BPL
        SPL
    }
    Index: {
        SIL
        DIL
    }
}
```

## What's next
Here we covered a bit about what are the registers and what they do, but the playground with them isn't over, because they are important and you will ever use them in your programs. In the next section we will see about the segmentations that a program has inside the memory.
