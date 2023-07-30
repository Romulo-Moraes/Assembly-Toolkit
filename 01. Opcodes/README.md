# 1. Opcodes

Opcodes are the smallest part that a program contains and often the program has many of them, they can be recognized as functions in high-level languages, that you call it and pass some arguments (operands). There's a variety of opcodes and each one of them do a specific thing inside the CPU of your computer.

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
In this section i'll show you how these codes work in the machine level, between the transistors, so let's go.

We must have in mind that for each CPU that exists, it has an architecture and in that architecture exists some details that make the difference when playing in the low-level, and one of them is the 'word'. Word mean the size of data that the CPU can operate at a time and it makes the difference when is necessary build a CPU.

The most known architectures are x86, x64 and x86-64, containing the Words: 86 bits, 64 bits and 64 bits respectively. But here we'll only work with x86-64 that is 64 bits and has compatibility with the x86.

Knowing that our CPU can only operate with 64 bits, or in other words, 8 bytes, these bits must be divided carefully to fit perfectly for each opcode/operands, here's an example:

Imagine a CPU that we will build has three opcodes and 8 bits in the word, the implemented opcodes will be the add, sub and mul. Using binary, these three opcodes can be translated to 00, 01 and 10, in other words, we need at least 2 bits to represent our opcodes, knowing that each opcode receive two operands, the remaining bits can be divided to them, and in the end, our instruction is exactly the following:

<img src='./../assets/Bits split.png'/>

In a real example we could use the add to represent the ideas behind it, take a look:
```txt
; Each part of this line will
; be replace by a binary value,
; in our example, the cyan field
; will be filled with the 'add' 
; opcode binary representation (i.e. 00).
; The 'al' represents a Register, this 
; will be introduced to you later on, but
; it's basically a very fast kind o memory
; that lies inside the CPU. We will give
; a binary value representation to this too,
; that is 101, and will be placed at the
; green field. Now, the 6 is known as a 
; constant, there's no secret here, the 
; purple field will be filled with the 
; binary representation of the decimal 6,
; that is '110'.
add al, 6
```
After we filled all the fields with binary (00101110) content (that's the only kind of data that a computer can read), we can send this to the CPU of our machine, reaching there, the CPU will decode the binary sequence splitting in fields of (2, 3, 3) bits and will see that we ordered it to do the CYAN operation over the GREEN element using the value PURPLE, in other words, add 6 to the register 'al'. If for any reason the al register had the value 1 inside, now the value of al is 7!

The example above is really simple, it's just to show the idea of how the things work, the nowaday computers has 64 bits in the word size, allowing a bunch of different opcodes and more space for operands (If you didn't notice, 7 is the max value that the purple field can hold (111 in binary), any larger value than this, if put there, would cause an overflow).



In this moment is clear that the assembler just need to replace the words that is in plain text like mov, sub or mul to the respective binary, from there comes the name Assembler, that just assemble things. It isn't the same thing about a compiler, that does a lot of things like syntax analyses, semantic analyses and more...


## What's next

For now the Opcodes section is completed, the next phase of the journey is the Registers, where we will see a bit about what is that and how it works.
