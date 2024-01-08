<div align="center">
    <img src="./assets/Project image.png">
    <h1></h1>
    <h3>A repository to support the learning on Low-level programming using the Assembly language</h3>
    <img src="./assets/Assembly toolkit example.png">
Assembly Toolkit is a compiled of knowledgments and ideas about the Assembly language, useful to learn the basics about this Low-level technology. This repository contains topics such as Opcodes, Memory segments, Assembly-C interoperability and much more...
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
Inside the opcode section we talk about the smallest part of a computer program, such part that when joined with other parts we have a complete program that can be run directly in the CPU of our computer.

<br/>

You can click here to be redirected to the Opcodes section.

<a href="https://github.com/Romulo-Moraes/Assembly-Toolkit/tree/2f6d611aff243b86c324ca4d0b3eee6f89e00d0c/01.%20Opcodes">
    <img src="./assets/Opcodes dir.png"/>
</a>

## Registers
Here we will cover in details what are registers and how they work. The register bank is a crucial component of the modern CPU designs, that make us able to manage data, make system calls, operate in memory segments and more...

<br/>

You can click here to be redirected to the Registers section.

<a href="https://github.com/Romulo-Moraes/Assembly-Toolkit/tree/2f6d611aff243b86c324ca4d0b3eee6f89e00d0c/02.%20Registers">
    <img src="./assets/Registers dir.png"/>
</a>

## Memory segments
The memory segments are a virtual division that every program running on a machine must have. The segments have their own roles, such as storing read-only data, storing uninitialized data, storing the program instructions and so on...

<br/>

You can click here to be redirected to the Memory segments section.

<a href="https://github.com/Romulo-Moraes/Assembly-Toolkit/tree/1c6ae164597afd891fb121344660f92ec9657c28/03.%20Memory%20segments">
    <img src="./assets/Memory segments dir.png"/>
</a>

## System calls
In this section we discuss about how our executables are lazy binaries that only know how to ask for their interests. Here we will cover in details the fact that: all interesting functionalies that a program may have is the Operating System that does everything.

<br/>

You can click here to be redirected to the System calls section.

<a href="https://github.com/Romulo-Moraes/Assembly-Toolkit/tree/2f6d611aff243b86c324ca4d0b3eee6f89e00d0c/04.%20System%20calls">
    <img src="./assets/System calls dir.png"/>
</a>

## Jumps
In the Jumps section we discuss about the one of the most important features that a computer has. Without jumps, function calls, loops and conditional statements could not be reality. 

<br/>

You can click here to be redirected to the Jumps section.

<a href="https://github.com/Romulo-Moraes/Assembly-Toolkit/tree/2f6d611aff243b86c324ca4d0b3eee6f89e00d0c/05.%20Jumps">
    <img src="./assets/Jumps dir.png"/>
</a>

## Arithmetic
In the Arithmetic section we discuss about... guess what... arithmetic. This section explains how to do the basic arithmetic operations in Low-level programming, such thing that is very important for nowadays computers for many reasons.

<br/>

You can click here to be redirected to the Arithmetic section.

<a href="https://github.com/Romulo-Moraes/Assembly-Toolkit/tree/2f6d611aff243b86c324ca4d0b3eee6f89e00d0c/06.%20Arithmetic">
    <img src="./assets/Arithmetic dir.png"/>
</a>

## Stack
The Stack is the most used memory segment during program execution. In languages like C, all variables declared within a procedure are stored within the stack segment. In addition to variable declarations, this segment is also responsible for function calls, function arguments and more...

<br/>

You can click here to be redirected to the Stack section.

<a href="https://github.com/Romulo-Moraes/Assembly-Toolkit/tree/2f6d611aff243b86c324ca4d0b3eee6f89e00d0c/07.%20Stack">
<img src="./assets/Stack dir.png"/>
</a>

## Functions
In this section we discuss how to create functions/procedures and how they work in Low-Level programming. Once you understand how functions work in Low-Level, you will be able to understand how they work on programming languages like C or another compiled language.

<br/>

You can click here to be redirected to the Functions section.

<a href="https://github.com/Romulo-Moraes/Assembly-Toolkit/tree/2f6d611aff243b86c324ca4d0b3eee6f89e00d0c/08.%20Functions">
    <img src="./assets/Functions dir.png"/>
</a>

## Arrays
The arrays section contains information about creating and manipulate arrays in the Low-Level programming. The memory allocation and the required calculation to access an array index are explained in this section. Data structures are important for software development, and the array is the most basic structure that we can have here.

<br/>

You can click here to be redirected to the Arrays section.

<a href="https://github.com/Romulo-Moraes/Assembly-Toolkit/tree/2f6d611aff243b86c324ca4d0b3eee6f89e00d0c/09.%20Arrays">
    <img src="./assets/Arrays dir.png"/>
</a>

## Macros
The macros are a group of instructions that will take effect on the preprocessor of the assembler. With macros is possible assign a value to a symbol, create blocks of instructions and call them like a C function and more...

<br/>

You can click here to be redirected to the Macros section.

<a href="https://github.com/Romulo-Moraes/Assembly-Toolkit/tree/2f6d611aff243b86c324ca4d0b3eee6f89e00d0c/10.%20Macros">
    <img src="./assets/Macros dir.png"/>
</a>

## Solutions
The solutions section is a compiled of assembly source code files for the Nasm assembler that copy functionalities from the C programming language functions. This give us an ideia of how a software is built looking from the Low-Level perspective. Example of created functions: strlen(), strcmp(), atoi(), etc...

<br/>

You can click here to be redirected to the Solutions section.

<a href="https://github.com/Romulo-Moraes/Assembly-Toolkit/tree/2f6d611aff243b86c324ca4d0b3eee6f89e00d0c/11.%20Solutions">
    <img src="./assets/Solutions dir.png"/>
</a>

## Useful opcodes
This section is basically a list of opcodes that have not been introduced by any section of the repository, however, they can make a difference while we are writing some bits.

<br/>

You can click here to be redirected to the Useful opcodes section.

<a href="https://github.com/Romulo-Moraes/Assembly-Toolkit/tree/2f6d611aff243b86c324ca4d0b3eee6f89e00d0c/12.%20Useful%20opcodes">
    <img src="./assets/Useful opcodes dir.png"/>
</a>

## Assembly-C interoperability
Even being two different languages, Assembly and C can work together to perform tasks that require features from both technologies, each one doing the best in its field.

<br/>

You can click here to be redirected to the Assembly-C interoperability section.

<a href="https://github.com/Romulo-Moraes/Assembly-Toolkit/tree/2f6d611aff243b86c324ca4d0b3eee6f89e00d0c/13.%20Assembly-C%20interoperability">
    <img src="./assets/Assembly-C interoperability dir.png"/>
</a>

## PIC
A Position Independent Code is useful because it doesn't depends of a fixed address on memory to read/write data or even jump to a procedure to perform a task. A Position Dependent software may cause some issues while being loaded into memory or even while being linked with a C program.

<br/>

You can click here to be redirected to the PIC section.

<a href="https://github.com/Romulo-Moraes/Assembly-Toolkit/tree/2f6d611aff243b86c324ca4d0b3eee6f89e00d0c/14.%20PIC">
    <img src="./assets/PIC dir.png"/>
</a>

## Callbacks
Such as in C, Javascript or Python, Assembly also supports a kind of callbacks that may be useful to make most flexible programs. Moving a memory address to a register, this can be used for jumping to or calling this address.

<br/>

You can click here to be redirected to the Callbacks section.

<a href="https://github.com/Romulo-Moraes/Assembly-Toolkit/tree/2f6d611aff243b86c324ca4d0b3eee6f89e00d0c/15.%20Callbacks">
    <img src="./assets/Callbacks dir.png"/>
</a>
