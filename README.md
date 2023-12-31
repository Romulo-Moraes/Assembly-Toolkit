<div align="center">
    <h1>Assembly toolkit</h1>
    <img width="400px" src="./assets/AssemblyImage.png">
    <p>Written by Cypher (Rômulo Peres de Moraes)</p>
</div>

<br/>
<img height="8px" width="100%" src="./assets/Split.png"/>
<br/>

## What's that
Assembly Toolkit Framework is a compiled of knowledgments and ideas about the Assembly language, useful to learn and always come here to remember how a basic assembly feature works. This repository give the focus to the **Nasm** assembler, therefore, things from this repository may not work with another assembler.

## Repository sections
This repository has sections that divide the topics about the Assembly language, each one has a number and its name on the source tree, the sections talk about opcodes, registers, memory segmentations, system calls, jumps, arithmetic operations, the stack segment, functions, arrays, macros, solutions, Useful opcodes, Assembly-C interoperability, PIC and Callbacks. A bookmark on the section that you have more difficult may be useful.

## Opcode section
The opcode section is a place that we talk about the smallest part of a computer program, such part that together with its siblings can make the magic happens inside the CPU of any machine. Give a look at it, and if this section made you more curious about how machine works, i encourage you to do a deep search about this subject on the internet.

## Registers section
The registers section talk about of a component of every modern CPU, the registers bank are useful to manage data, make system calls, operate in memory segments and more, beyond of course, be the fastest memory in the memory hierarchy.

## Segmentations section
The segmentation section tells you about the memory segmentations that every computer program contains, example of that can be stack itself, but there're more segments than just that one, give a look, without this section the things becomes tough to understand in the future sections.

## System calls section
The system calls section is a interesting section that talk about how our program can make things about write something on console, open files, use sockets, etc... looking with care to this section is possible notice the importance of the operating system.

## Jumps section
The jumps section tells you about maybe the most important feature of a computer: do a jump. With jumps is possible to stop following a flow of instructions and start another flow in another region of the memory, beyond of course, make conditional structures like if/else, switch and loops, like for and while.

## Arithmetic section
The arithmetic section talks about how to do math using the smallest instructions that the CPU can read, math is very important for any program, and here is possible to see on to use the basic arithmetic operations, like add, subtract, multiply and division.

## Stack section
The stack section talks about the fixed amount of memory that every program receive at the moment that its life starts, this memory is useful to declare variables, make function calls, pass parameters and more, absorbing everything from this section makes the Assembly language begin to be funny to work.

## Functions section
The functions section tells you about how to create procedures and functions in the lowest level of the machine and how it works, learning how functions works in assembly allows you to understand how they even works on languages like C or another compiled language. Here will also be covered about how to pass and receive parameters from inside the function.

## Arrays section
The arrays section contains information of how to create and operate with arrays at the low-level, the necessary calculation to access an array index and the memory allocation is also covered in this section. Data structures are important, and the array is the most basic structure that we can have here.

## Macros section
The macros are a group of instructions that will take effect on the preprocessor of the assembler. With this is possible assign a value to a name, create blocks of codes and call them like a C function, conditional blocks of instructions and more...

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
I could lie and tell you that Assembly is an easy language and can be learned within some days, but that isn't the really truth, therefore, if you found something wrong with any information in this repository, i encourage you to create an issue and report what's wrong, every help is appreciated.
