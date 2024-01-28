# 1. Opcodes

Opcodes are the smallest units that a program contains, and a program often consists of many of them. They can be likened to functions in high-level languages, where you call them and pass some arguments (operands). There is a variety of opcodes, and each one of them performs a specific operation inside the CPU of your computer.

Here are some examples of opcodes and their functionalities:
```asm
mov ; Moves a value from one location to another.
add ; Arithmetic opcode that adds a number
inc ; Arithmetic opcode that increments by 1
jmp ; Opcode of jumps
dec ; Arithmetic opcode that decrements by 1
mul ; Arithmetic opcode that performs multiplication
```

## 1.1 Building a machine instruction
Here is an introduction and examples of how a program is executed on a machine.

Every CPU has something called a `word`." The term `word` refers to the amount of data that the CPU can handle in each operation.

The most well-known architectures are x86, x64, and x86-64, containing word sizes of 32 bits, 64 bits, and 64 bits respectively. However, in this context, we'll specifically work with x86-64, which is a 64-bit architecture with compatibility with x86.

Keeping in mind that our CPU can only operate with a maximum of 64 bits, or in other words, 8 bytes, these bits must be divided carefully to fit perfectly for each opcode/operands. Here is an example:

Imagine a CPU that we are going to build has three opcodes and 8 bits in the word. The implemented opcodes will be `add`, `sub`, and `mul`. Using binary, these three opcodes can be represented as 00, 01, and 10. In other words, we need at least 2 bits to represent our opcodes. Keeping in mind that each opcode receives two operands, the remaining bits can be divided among them. In the end, our instruction is exactly the following:

<img src='./../assets/Bits split.png'/>

An example using the `add` opcode:

```asm
; Each part of this line will be 
; replaced by a binary value. 
;
; In our example, the cyan field 
; will be filled with the 'add' 
; opcode binary representation (i.e. 00).
;
; The 'al' represents a register; 
; this will be introduced to you 
; later on, but it's basically a 
; very fast kind of memory that lies
; inside the CPU. We will also give it a
; binary representation, which is 101,
; and will be placed in the green field.
;
; Now, the 6 is known as a constant.
; There's no secret here; the purple 
; field will be filled with the binary 
; representation of the decimal 6, 
; which is '110'.

add al, 6
```
After replacing all fields with their binary values, resulting in the sequence `00101110`, the machine's CPU can decode this binary. It splits this sequence into fields of (2, 3, 3) bits and understands that it has to perform the `CYAN` operation over the `GREEN` register using the `PURPLE` value.

The above example is quite simple. Nowadays, computers have a word size of 64 bits, making it possible to create a larger set of instructions.

At this point, it is clear that the assembler only needs to replace the opcodes and their operands with their binary representations, making it possible for the computer to understand.