<div align="center">
    <h1>Assembly Toolkit</h1>
    <img width="400px" src="./assets/AssemblyImage.png">
    <p>Written by Cypher (Rômulo Peres de Moraes)</p>
</div>

<br/>
<img height="8px" width="100%" src="./assets/Split.png"/>
<br/>

## What is this?
Assembly Toolkit is a compiled of knowledgments and ideas about the Assembly language, useful to learn the basics about this Low-level technology. This repository focus on the **Nasm** assembler, therefore, things from this repository may not work with another assembler.

## Repository sections
The contents of this repository is divided into topics about the Assembly language, each one has a number and its name on the source tree, the sections cover about opcodes, registers, memory segments, system calls, jumps, arithmetic operations, the stack segment, functions, arrays, macros, solutions, Useful opcodes, Assembly-C interoperability, PIC and Callbacks.

## Opcode section
Inside the opcode section we talk about the smallest part of a computer program, such part that when joined with other parts we have a complete program that can be run directly in the CPU of our computer.

## Registers section
Here we will cover in details what are registers and how they work. The register bank is a crucial component of the modern CPU designs, that make us able to manage data, make system calls, operate in memory segments and more...

## Segments section
The memory segments are a virtual division that every program running on a machine must have. The segments have their own roles, such as storing read-only data, storing uninitialized data, storing the program instructions and so on...

## System calls section
In this section we discuss about how our executables are lazy binaries that only know how to ask for their interests. Here we will cover in details the fact that: all interesting functionalies that a program may have is the Operating System that does everything.

## Jumps section
In the Jumps section we discuss about the one of the most important features that a computer has. Without jumps, function calls, loops and conditional statements could not be reality. 

## Arithmetic section
In the Arithmetic section we discuss about... guess what... arithmetic. This section explains how to do the basic arithmetic operations in Low-level programming, such thing that is very important for nowadays computers for many reasons.

## Stack section
The Stack is the most used memory segment during program execution. In languages like C, all variables declared within a procedure are stored within the stack segment. In addition to variable declarations, this segment is also responsible for function calls, function arguments and more...

## Functions section
In this section we discuss how to create functions/procedures and how they work in Low-Level programming. Once you understand how functions work in Low-Level, you will be able to understand how they work on programming languages like C or another compiled language.

## Arrays section
The arrays section contains information about creating and manipulate arrays in the Low-Level programming. The memory allocation and the required calculation to access an array index are explained in this section. Data structures are important for software development, and the array is the most basic structure that we can have here.

## Macros section
The macros are a group of instructions that will take effect on the preprocessor of the assembler. With macros is possible assign a value to a symbol, create blocks of instructions and call them like a C function and more...

## Solutions section
The solutions section is a compiled of assembly source files to Nasm assembler that copy functionalities of functions from the C programming language to give you a vision of how to build a little program with Assembly or even to use in larger programs. Examples of functions copied from C are: strlen(), strcmp(), atoi(), etc...

## Useful opcodes
This section is basically a list of opcodes that weren't covered during the entire path of the repository, however, they can make the difference while writing some bits.

## Assembly-C interoperability
Even being two different languages, Assembly and C can be joined to work together to accomplish a task, each one doing the best on its field.

## PIC
A Position Independent Code is useful because it doesn't depends of a fixed address on memory to reach a data or even jump to a procedure to do something. A Position Dependent software may cause some issues while being loaded into memory or even while being linked with a C program.

## Callbacks
Like in C, Javascript or Python, Assembly also supports a kind of callbacks that may be useful to make most flexible programs. With the feature of move a memory address to a register, this can be easily done by jumping to or calling this address.

## Assembly is psycho
I could lie and tell you that Assembly is an easy language and can be learned within a couple of days, but it's not the truth, therefore, if you found something wrong with any information in this repository, i encourage you to create an issue and report what is wrong, every help is appreciated.
