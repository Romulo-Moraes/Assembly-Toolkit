# 3. Segmentations
A program inside the computer's memory has segments to organize how the things work. Each segment has a kind of data and your features, and us as good Assembly programmers must handle with care all of them, avoiding the possibility of a segmentation fault, such thing that normally happens in a low-level program whether you be careless.

The types of segments are the following:

```txt
Text
Stack
Bss
Rodata
Data
```

## 3.1 Explanation of the types of segments

### Text
The text segment is the piece of memory that the Operating System store the instructions of your program, from there that the CPU of your computer will start to read word by word and execute each instruction until reach the end of all of them.

### Stack
The stack segment is a fixed block of memory that the Operating System gives to your program to do anything with it, in this location you can create stack frames, variables, local variables and more...

### BSS
The BSS segment is a memory piece to create variables that until the compilation time there's no meaningful value inside it and will be filled in runtime.

### Rodata
The Rodata segment or also know as read-only data is a place to put anything that won't change in runtime, anything that is put there can't be changed, or a segmentation fault can happen.

### Data
The data segment is a place like the BSS segment, but to create with a meaningful value inside in compilation time. This value can be changed in runtime, however, you must respect the original size of it when put a new value inside.

## What's next
Now that we know about all segments of a program we will see in the next section what is System calls and how to use them, such section that we will build our first program and run in our own machine.