<div align="center">
    <h1>Assembly toolkit framework</h1>    
    <img width="400px" src="./assets/AssemblyImage.png">
    <p>Created by Rômulo Moraes</p>
</div>

#

# What is that
Assembly toolkit is a compiled of assembly files to do operations like string comparation, file operations, memory set and another things. This project is based on Netwide assembler to linux, but some code segment work on Windows too, if don't need do a linux syscall, like memory operations for example.

# Text files
The project has some text files that is some hints on work with assembly, like conditional jumps, arithmetic operations, etc...

# Multiplatform code segments

### strlen.asm
Like in C programming language, the strlen will return the size of a chain of characters, the value returned is based on the null byte found usually in the end of a valid string.

To use just import the file and pass some arguments to registers before call the function.

Pass the string address to RDI register

The output size will be returned in RAX register

### strcspn.asm
Like in C programming language, this code segment will replace the '\n' character of a string to the NULL char, if not found, then will set the char '\0' to the first NULL byte that it find

To use just import the file and pass some arguments to registers before call the function.

Pass the string address to RSI register

### strcmp.asm
This code segment is based on strcmp from C programming language, this will compare two chain of characters and return a value saying if the values is equal or not

To use just import the file and pass some arguments to registers before call the function.

Pass the address of the first string to RSI and the second string's address to RDI registers. If value equal to each other then the RAX register will be filled with 1, else 0

### itoa.asm
This code segment is based on itoa from C programming language, this will transform a integer value to a chain of characters, that is printable.

To use just import the file and pass some arguments to registers before call the function.

Pass the number to RAX register (can be signed or unsigned), and output address in RSI. in the end of execution the passed address will be filled with the number in string format.

### memset.asm
Like in C programming language, this code segment will set a specified value into each memory cell of a specified range.

To use just import the file and pass some arguments to registers before call the function.

Pass the address to RSI, the range value to RAX, and the value to be set in RDX registers

# Unix-like code segments

### puts.asm
Like in C programming language, this code segment will print a string until reach the NULL character. This segment depends of another file called strlen.asm

To use just import the file and pass some arguments to registers before call the function.

Pass the string address to rsi

### read_input.asm
This file will read a file from stdin of the program, and put the result in passed address of the memory.

To use just import the file and pass some arguments to registers before call the function.

Pass store address to RSI and the size to read to RDX registers.

### fileop.asm
This code segments will do file operations in Unix-like platforms, like open, read, write files, etc..

To use just import the file and pass some arguments to registers before call the create_file segment.

to create a file pass the file name to RDI, access mode in RSI. the file decriptor is returned in RAX register.

to open a file pass the name to RDI register and call the segment open_file 

to write a file pass the file decriptor in RDI register, the text in RSI register and call the segment write_file

to read a file pass the file decriptor in RDI, the address to be written the file text in RSI, the size to read in RDX and call the segment read_file

to close a file pass the file decriptor in RDI and call the segment close_file

## The linux-syscalls-cheatsheet and windows-constants files
This special file contains a good number of constants that can help in system interaction in Unix-lik and Windows platform, just include this to your code file then you can use them.
