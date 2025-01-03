# 3. Memory segments
A program inside the computer's memory has segments to organize how the things work. Each segment has a type of data and its features, and we, as good Assembly programmers, must handle all of them with care, avoiding the possibility of a segmentation fault, which normally happens in a low-level program if you be careless.

The types of segments are the following:

```txt
Text
Stack
Bss
Rodata
Data
```

## 3.1 Explaining every kind of memory segment

### Text
The text segment is the portion of memory where the Operating System stores the instructions of your program. It is the area of memory that the CPU of your computer will begin to read word by word, executing each instruction until it reaches the end of the program.

### Stack
The stack segment is a designated area of memory allocated by the operating system for your program to manage data, function calls, and more. All variables declared within your functions are stored in this segment.

#### Stack frame
A stack frame is a reserved portion of memory within the stack segment allocated by you for working with values. These values are also known as local variables and may also be used to store function arguments.

### BSS
The BSS segment is a section of memory allocated when your program is loaded into memory by the operating system. This segment contains no meaningful values, so all values are initialized to zero. The size of the BSS segment is determined by the programmer.

### Rodata
The Rodata segment, also known as read-only data, is a portion of memory which values are set during the program startup, and new assignments are not allowed at runtime.

### Data
Like the BSS segment, the Data segment is a portion of memory allocated when your program is loaded by the operating system; however, this segment contains meaningful values defined by the programmer.
