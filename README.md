<div align="center">
    <img src="./assets/Project image.png">
    <h1></h1>
    <h3>A repository to support the learning on Low-level programming using the Assembly language</h3>
    <img src="./assets/Assembly toolkit example.png">
The Assembly Toolkit is a compilation of knowledge and ideas related to Assembly language, designed to help anyone to learn the fundamentals of this low-level technology. This repository covers various topics, including opcodes, memory segments, Assembly-C interoperability, and much more.
</div>

# Topics
[Repository structure](#repository-structure)

[Opcodes](#opcodes)

[Registers](#registers)

[Memory segments](#memory-segments)

[System calls](#system-calls)

[Jumps](#jumps)

[Arithmetic](#arithmetic)

[Stack](#stack)

[Functions](#functions)

[Arrays](#arrays)

[Macros](#macros)

[Solutions](#solutions)

[Useful opcodes](#useful-opcodes)

[Assembly-C interoperability](#assembly-c-interoperability)

[PIC](#pic)

[Callbacks](#callbacks)


## Repository structure
The contents of this repository are divided into topics about the Assembly language, every topic has a number and a name on the source tree. There are description of each topic below, every description has its own button that redirects you to its contents.

## Opcodes
In the opcode section, we discuss the smallest unit of a computer program, which, when combined with other units, forms a complete program that can be executed directly by the CPU of our computer.

<br/>

You can click here to be redirected to the Opcodes section.

<a href="https://github.com/Romulo-Moraes/Assembly-Toolkit/tree/main/01.%20Opcodes">
    <img src="./assets/Opcodes dir.png"/>
</a>

## Registers
Here, we will explore in detail what registers are and how they work. The register bank is a key component in modern CPU designs, enabling us to manage data, make system calls, operate in memory segments, and more.

<br/>

You can click here to be redirected to the Registers section.

<a href="https://github.com/Romulo-Moraes/Assembly-Toolkit/tree/main/02.%20Registers">
    <img src="./assets/Registers dir.png"/>
</a>

## Memory segments
The memory segments are a virtual division that every program running on a machine must have. The segments have their own roles, such as storing read-only data, storing uninitialized data, storing the program instructions and so on.

<br/>

You can click here to be redirected to the Memory segments section.

<a href="https://github.com/Romulo-Moraes/Assembly-Toolkit/tree/main/03.%20Memory%20segments">
    <img src="./assets/Memory segments dir.png"/>
</a>

## System calls
System calls are interfaces established by the operating system that enable user-space programs to request and manipulate resources that are exclusively accessible by the kernel. In this section, we will explore how these calls work and how to execute them using registers.
<br/>

You can click here to be redirected to the System calls section.

<a href="https://github.com/Romulo-Moraes/Assembly-Toolkit/tree/main/04.%20System%20calls">
    <img src="./assets/System calls dir.png"/>
</a>

## Jumps
Jumps are essential components of modern computers. Instructions that perform jumps enable programs to create conditional structures, such as loops, if/else statements, and switches. These jumps are typically based on the values of the RFLAGS register. This section will explain everything you need to know about this important register and how to execute jumps effectively.

<br/>

You can click here to be redirected to the Jumps section.

<a href="https://github.com/Romulo-Moraes/Assembly-Toolkit/tree/main/05.%20Jumps">
    <img src="./assets/Jumps dir.png"/>
</a>

## Arithmetic
The primary function of a computer is to perform calculations. This section will cover the basics of arithmetic operations in low-level programming, including addition, multiplication, division, and subtraction.

<br/>

You can click here to be redirected to the Arithmetic section.

<a href="https://github.com/Romulo-Moraes/Assembly-Toolkit/tree/main/06.%20Arithmetic">
    <img src="./assets/Arithmetic dir.png"/>
</a>

## Stack
The stack is the most frequently used memory segment during program execution. In languages such as C, all variables declared within a function are stored in this segment. Additionally, the stack manages function calls, arguments, and other related operations.

<br/>

You can click here to be redirected to the Stack section.

<a href="https://github.com/Romulo-Moraes/Assembly-Toolkit/tree/main/07.%20Stack">
<img src="./assets/Stack dir.png"/>
</a>

## Functions
In this section, we will explore how to create and utilize functions and procedures in low-level programming. By mastering these concepts, you will gain a deeper understanding of their implementation in languages like C and other compiled languages.

<br/>

You can click here to be redirected to the Functions section.

<a href="https://github.com/Romulo-Moraes/Assembly-Toolkit/tree/main/08.%20Functions">
    <img src="./assets/Functions dir.png"/>
</a>

## Arrays
The arrays section provides information on creating and manipulating arrays in low-level programming. It explains memory allocation and the calculations required to access array indices. As fundamental data structures, arrays are essential for software development.

<br/>

You can click here to be redirected to the Arrays section.

<a href="https://github.com/Romulo-Moraes/Assembly-Toolkit/tree/main/09.%20Arrays">
    <img src="./assets/Arrays dir.png"/>
</a>

## Macros
Macros are a set of instructions that affect the assembler's preprocessor. With macros, you can assign values to symbols, create blocks of instructions, and invoke them like functions in C, among other capabilities.

<br/>

You can click here to be redirected to the Macros section.

<a href="https://github.com/Romulo-Moraes/Assembly-Toolkit/tree/main/10.%20Macros">
    <img src="./assets/Macros dir.png"/>
</a>

## Solutions
The solutions section consists of assembly source code files for the NASM assembler, which replicate functionalities from C programming language functions. This provides insight into how software is constructed from a low-level perspective. Examples of functions created include strlen(), strcmp(), and atoi(), among others.

<br/>

You can click here to be redirected to the Solutions section.

<a href="https://github.com/Romulo-Moraes/Assembly-Toolkit/tree/main/11.%20Solutions">
    <img src="./assets/Solutions dir.png"/>
</a>

## Useful opcodes
This section is basically a list of opcodes that have not been introduced by any section of the repository, however, they can make a difference while we are writing some bits.

This section lists opcodes that have not been introduced elsewhere in the repository, yet they can significantly impact our bit writing process.

<br/>

You can click here to be redirected to the Useful opcodes section.

<a href="https://github.com/Romulo-Moraes/Assembly-Toolkit/tree/main/12.%20Useful%20opcodes">
    <img src="./assets/Useful opcodes dir.png"/>
</a>

## Assembly-C interoperability
Despite being two distinct languages, Assembly and C can collaborate effectively, leveraging their unique strengths to address tasks that benefit from both technologies.

<br/>

You can click here to be redirected to the Assembly-C interoperability section.

<a href="https://github.com/Romulo-Moraes/Assembly-Toolkit/tree/main/13.%20Assembly-C%20interoperability">
    <img src="./assets/Assembly-C interoperability dir.png"/>
</a>

## PIC
Position Independent Code (PIC) is advantageous because it does not rely on fixed memory addresses for reading, writing data, or jumping to procedures. In contrast, Position Dependent software can cause issues during loading or linking with a C program.

<br/>

You can click here to be redirected to the PIC section.

<a href="https://github.com/Romulo-Moraes/Assembly-Toolkit/tree/main/14.%20PIC">
    <img src="./assets/PIC dir.png"/>
</a>

## Callbacks
Like C, JavaScript, and Python, Assembly language also supports a form of callbacks that can help create more flexible programs. By moving a memory address into a register, this address can be used for jumping to or calling its associated function.

<br/>

You can click here to be redirected to the Callbacks section.

<a href="https://github.com/Romulo-Moraes/Assembly-Toolkit/tree/main/15.%20Callbacks">
    <img src="./assets/Callbacks dir.png"/>
</a>
