# 2. Registers section
Register bank or also know as registers is a kind of memory that lies inside the CPU, and it's speed is much better than a normal RAM or SSD. This component of a CPU is responsible for manage data, make system calls, store flags and more...

## 2.1 Register types
There's some types of registers, each type is useful to accomplish a logical problem, here is the most important types of registers that exist:

```txt
Data: Is useful to manage data inside the CPU.

Pointer: Is useful to work with the stack segment (Will be covered later).

Index: Is useful to index something in the memory, acting like a pointer in C language.
```

Is important to say that the size of the registers respect the word's size of the CPU's architecture, but is also possible access just a part of the cotent of a register for example, like the first half or the first 1/4, etc...

## 2.2 Register names

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

In Assembly language, the comments are made with a semicolon and can be put in any place that you want to comment.

The two remaining kinds of registers will be covered in another section, here is just to see what they are.

## 2.3 Older versions of nowaday registers
The word of the architecture x86-64 is exactly 64 bits, in other words, 8 bytes, so in teory we can only manage data by 8 bytes at a time, correct ?

At the begin of computing, the memory was very expensive and wasn't possible to make a register of 64 bits, so we started with basic examples of register, being it 8 bits, after 16 and so on... until reach at the most common among the registers that is 64 bits.

But if we face a problem that require we manage one byte at a time, what we do ? We still can access these kinds of registers, however, that isn't different registers, this is a part of the main register of 64 bits, we just access a percentage of it.

Here is the first half with 32 bits:
```txt
32 bits registers: {
    Data: {
        EAX (RAX 1/2)
        EBX (RBX 1/2)
        ECX (RCX 1/2)
        EDX (RDX 1/2)
        R8D-R15D(R8-R15 1/2)
    }
    Pointer: {
        EBP (RBP 1/2)
        ESP (RSP 1/2)
    }
    Index: {
        ESI (RSI 1/2)
        EDI (RDI 1/2)
    }
```
Here is the 1/4 from the full register:
```txt
16 bits registers: {
    Data: {
        AX (EAX 1/2) (RAX 1/4)
        BX (EBX 1/2) (RBX 1/4)
        CX (ECX 1/2) (RCX 1/4)
        DX (EDX 1/2) (RDX 1/4)
        R8W-R15W (R8D-R15D 1/2) (R8-R15 1/4)
    }
    Pointer: {
        BP (EBP 1/2) (RBP 1/4)
        SP (ESP 1/2) (RSP 1/4)
    }
    Index: {
        SI (ESI 1/2) (RSI 1/4)
        DI (EDI 1/2) (RDI 1/4)
    }
}
```
And the 8 bits registers:
```txt
8 bits registers: {
    Data: {
        AL (AX 1/2) (EAX 1/4) (RAX 1/8)
        BL (BX 1/2) (EBX 1/4) (RBX 1/8)
        CL (CX 1/2) (ECX 1/4) (RCX 1/8)
        DL (DX 1/2) (EDX 1/4) (RDX 1/8)
        R8B-R15B (R8W-R15W 1/2) (R8D-R15D 1/4) (R8-R15 1/8)
    }
    Pointer: {
        BPL (BP 1/2) (EBP 1/4) (RBP 1/8)
        SPL (SP 1/2) (ESP 1/4) (RSP 1/8)
    }
    Index: {
        SIL (SI 1/2) (ESI 1/4) (RSI 1/8)
        DIL (DI 1/2) (EDI 1/4) (RDI 1/8)
    }
}
```

## 2.4 State register
The CPU has a special register that store the current state
of your code's logic, its name is RFLAGS, this is a 64 bits flags which one store a flag on each bit. These flags mean a lot of things, and is possible interact with them, for instance, we can do something if a arithmetic operation caused an overflow, or do nothing otherwise.
```asm
; This set a bit into the RFLAGSG register
; called OF
mov al, 255
add al, 1

; We can do jumps after the operation
; to check if the OF flag is set.

; ...
; ...
; ...
```
An overflow occur in this code because the 'al' register only hold 8 bits, and 255 is max the value that 8 bits can represent.

### 2.4.1 Flag names
Here is a list of the flag names and what they represent:
```txt
OF (Overflow flag) - Set when arithmetic operation caused overflow.

ZF (Zero flag) - Set when arithmetic operation resulted in zero, or most commonly, two equal values in 'cmp' opcode.

CF (Carry flag) - Set when there's a overflow or when the shifted value of shift operations is 1.

SF (Sign Flag) - Set when arithmetic operation resulted in a negative value.

PF (Parity flag) - Set when a operation resulted in a value with a even number of set bits (bit 1).
```
These are the main flags that we can interact in our code logic, there're more many of them, but they hold no much meaning for us. The interaction with theses flags is did mainly with conditional jumps, such thing that we will cover later on.

## What's next
Here we covered a bit about what are the registers and what they do, but the playground with them isn't over, because they are important and you will ever use them in your programs. In the next section we will see about the segmentations that a program has inside the memory.
