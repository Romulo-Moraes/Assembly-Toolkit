# 1. Opcodes

Opcodes are the smallest part that a program contain and often the program has many of them, they can be recognized as functions in high-level languages, that you call it and pass some arguments (operands). There's a variety of opcodes and each one of them do a specific thing inside the CPU of your computer.

Here's some examples of opcodes and what they do:
```asm
mov ; Move a value from a location to another
add ; Arithmetic opcode that add a number
inc ; Arithmetic opcode that increment 1
jmp ; Opcode of jumps
dec ; Arithmetic opcode that decrement 1
mul ; Arithmetic opcode that multiply
```

Along this journey more opcodes will be showed for you, and you will learn how to use.

## 1.1 Building a machine instruction
In this section i'll show you how these codes work in the machine level, between the transistors so let's go.

We must have in mind that for each CPU that exists it has an architecture and in that architecture exists some details that make the difference when playing in the low-level, and one of them is the 'word'. Word mean the size of data that the CPU can operate at a time and it makes the difference when is necessary build a CPU.

The most known architectures are x86, x64 and x86-64, containing the Words: 86 bits, 64 bits and 64 bits respectively. But here we'll only work with x86-64 that is 64 bits and has compatibility with the x86.

Knowing that our CPU can only operate with 64 bits, or in other words, 8 bytes, these bits must be divided carefully to fit perfectly for each opcode/operands, here's an example:

Imagine that a CPU that we will build has two opcodes and 8 bits in the word, in that CPU we need create three opcodes, the add, sub and mul. Using binary, these three opcodes can be translated to 00, 01 and 10, in other words, we need at least 2 bits to represent our opcodes, knowing that each opcode receive two operands, the remaining bits can be divided to them, and in the end our instruction is exactly the following:

<img src='./../assets/Bits split.png'/>

In this moment is clear that the assembler (Nasm) just need to replace the words that is in plain text like mov, sub or mul to the respective binary, from there comes the name Assembler, that just assemble things. It isn't the same thing about a compiler, that does a lot of things like syntax analyses, semantic analyses and more...

## The job of an instruction

After the build of instruction has completed, now it can pass through the CPU, be decoded and follow the circuit that the architecture has for each opcode.

## What's next

For now the Opcodes section is completed, the next phase of the journey is the Registers, where we will see a bit about what is that and how it works.