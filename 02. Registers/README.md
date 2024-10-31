# 2. Registers section
Registers are a type of memory that resides inside the CPU. These components are designed to be extremely fast in their operations, even faster than RAM or SSD. Registers are responsible for managing data, making system calls, storing flags, and more.

## 2.1 Register types
There is a set of register types, and each type is responsible for performing a specific kind of operation:

```txt
Data: It is useful for managing data inside the CPU.

Pointer: It is useful for working with the stack segment (Will be covered later).

Index: It is useful for indexing something in memory, behaving similarly to a pointer in the C language.
```
The registers follow the size of the word. However, it is possible to access only a part of these registers, such as 1/2, 1/4, and so on.

## 2.2 Register names

Now that you know all types of registers, it is the time of reveal their names, it can be tough at the beginning because a great part of them has just 3 characters and seems like they dont mean anything, but this is not impossible to understand.

### Data
<ul>
    <li>RAX</li>
    <li>RBX</li>
    <li>RCX</li>
    <li>RDX</li>
    <li>R8-R15 (R8, R9, R10...)</li>
</ul>


### Pointer
<ul>
    <li>RBP</li>
    <li>RSP</li>
</ul>

### Index
<ul>
    <li>RSI (source)</li>
    <li>RDI (destiny)</li>
</ul>


```
The above registers are from x86-64 architecture and may be different for other architectures.

```asm
; First assembly snippet
mov rax, 0x4 ; move the value 0x4 to register rax
add rax, 0x2 ; add 0x2 to rax, total: 0x6
mov rbx, rax ; move the value of rax to rbx (rax still holding 0x6).
sub rbx, 0x3 ; subtract 0x3 from rbx, total: 0x3

; In the end, the register `rax` retains the value 0x6, and `rbx` has the value 0x3.
```

It is often normal for Assembly programmers to write numbers in hexadecimal. However, you could write them in decimal with no problem.

In Assembly language, comments are made with a semicolon and can be placed anywhere in the code, useful to provide explanations (recommendable, since assembly is a low-level language and is hard to tell what a snippet of code is doing) or notes.

The two remaining types of registers will be discussed in another section; here, the goal is to provide an understanding of what they are.

## 2.3 Older versions of nowadays registers
The x86-64 architecture has a word size of 64 bits, which is equivalent to 8 bytes. Therefore, in theory, we can only process data in chunks of 8 bytes at a time, is that correct?

In the early days of computing, memory was very expensive, making it impractical to implement 64-bit registers. As result, we began with simpler registers, starting with 8 bits and gradually increasing to 16 and beyond. This progression continued until we arrived at the most prevalent register size, which is now 64 bits.

What do we do if we encounter a problem that requires us to manage one byte at a time?

It still possible to access these smaller register. However, they are not a distinct set of registers; they represent fractions of the 64-bits registers.

### Here is the list of the 1/2 registers (also known as 32-bits registers)
#### Data
<ul>
    <li>EAX (RAX 1/2)</li>
    <li>EBX (RBX 1/2)</li>
    <li>ECX (RCX 1/2)</li>
    <li>EDX (RDX 1/2)</li>
    <li>R8D-R15D(R8-R15 1/2)</li>
</ul>


#### Pointer
<ul>
    <li>EBP (RBP 1/2)</li>
    <li>ESP (RSP 1/2)</li>
</ul>

#### Index
<ul>
    <li>ESI (RSI 1/2)</li>
    <li>EDI (RDI 1/2)</li>
</ul>

<br/>

### Here is the list of the 1/4 registers (also known as 16-bits registers)

#### Data
<ul>
    <li>AX (EAX 1/2) (RAX 1/4)</li>
    <li>BX (EBX 1/2) (RBX 1/4)</li>
    <li>CX (ECX 1/2) (RCX 1/4)</li>
    <li>DX (EDX 1/2) (RDX 1/4)</li>
    <li>R8W-R15W (R8D-R15D 1/2) (R8-R15 1/4)</li>
</ul>


#### Pointer
<ul>
    <li>BP (EBP 1/2) (RBP 1/4)</li>
    <li>SP (ESP 1/2) (RSP 1/4)</li>
</ul>

#### Index
<ul>
    <li>SI (ESI 1/2) (RSI 1/4)</li>
    <li>DI (EDI 1/2) (RDI 1/4)</li>
</ul>

<br/>

### Here is the list of the 1/8 registers (also known as 8-bits registers)
The 8-bits registers are a little more special, it is possible to access the HIGH and LOW values of a 16-bits register as 8-bits registers.

#### Data
The LOW 8-bits registers (0-7)
<ul>
    <li>AL (AX 1/2) (EAX 1/4) (RAX 1/8)</li>
    <li>BL (BX 1/2) (EBX 1/4) (RBX 1/8)</li>
    <li>CL (CX 1/2) (ECX 1/4) (RCX 1/8)</li>
    <li>DL (DX 1/2) (EDX 1/4) (RDX 1/8)</li>
</ul>

The HIGH 8-bits registers (8-15)
<ul>
    <li>AH (AX 1/2) (EAX 1/4) (RAX 1/8)</li>
    <li>BH (BX 1/2) (EBX 1/4) (RBX 1/8)</li>
    <li>CH (CX 1/2) (ECX 1/4) (RCX 1/8)</li>
    <li>DH (DX 1/2) (EDX 1/4) (RDX 1/8)</li>
</ul>


#### Pointer
<ul>
    <li>BPL (BP 1/2) (EBP 1/4) (RBP 1/8)</li>
    <li>SPL (SP 1/2) (ESP 1/4) (RSP 1/8)</li>
</ul>

#### Index
<ul>
    <li>SIL (SI 1/2) (ESI 1/4) (RSI 1/8)</li>
    <li>DIL (DI 1/2) (EDI 1/4) (RDI 1/8)</li>
</ul>


## 2.4 State register
The CPU has a special register called RFLAGS. It is a 64-bit register that stores different flags on each bit. These flags are set based on the operations performed by the program and provide information about events, such as an arithmetic operation resulting in an overflow or whether a value is greater than or equal to another value.

The following code snippet sets a bit in the RFLAGS register called OF (Overflow flag)

```asm
mov al, 255
add al, 1
```
An overflow occurs in this code because the `al` register can only hold 8 bits, and 255 is the maximum value that 8 bits can represent.

We can perform jumps based on the bits stored inside the RFLAGS registers, useful for executing different pieces of code depending on the result of an operation.



### 2.4.1 Flag names
Here is a list of flag names and what they represent:
```txt
OF (Overflow flag) - Set when an arithmetic operation causes overflow.

ZF (Zero flag) - Set when an arithmetic operation results in zero, or most commonly, when two equal values are compared using the 'cmp' opcode.

CF (Carry flag) - Set when there is an overflow or when the shifted value of shift operations is 1.

SF (Sign Flag) - Set when arithmetic operation results in a negative value.

PF (Parity flag) - Set when an operation results in a value with an even number of set bits (bit 1).
```
The flags above are the main ones that we can interact with when writing Assembly programs. There are more flags available in the RFLAGS register. However, those flags don't hold considerable meaning for us.

The interaction with these flags is done mainly with conditional `jumps` (a section of this repository), where we can perform operations based on previous events.
