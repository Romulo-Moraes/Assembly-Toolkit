# 8. Functions
Functions/procedures are blocks of code that are reusable in your software, receiving arguments and returning values based on these arguments. Understanding how functions work in Assembly, will allow you understand how functions work in C, and in any language basically.

## 8.1 The return address
Every time that you call a function, the address of the next instruction in the current context is pushed into the stack, and your CPU is ordered to start executing the instructions that exist in the body of that function. When the job is done, a new opcode called RET is used to pop the address previously pushed into the stack, to send this to the CPU, allowing it to start again from where it stopped. This is the base concept of a function in computing.

## 8.2 Stack frame
A stack frame is a block of memory, starting from the return address and delimited by the RSP, that is useful to declare local variables and store any kind of data. By default, the size of the stack frame is 0, and is job of the programmer allocate memory inside this frame to use, avoiding segmentations faults or another kind of exception.

## 8.3 Functions arguments
Functions arguments are important when we wan't make a dynamic function, and rarely we face with a function that just doesn't receive any argument. Here in low-level, there're two ways of pass arguments to functions, the first is passing the values or even the address to values through registers, with a easy access inside the scope of the function, and the second is passing through the stack, pushing values and fetch them inside the function. The two ways will be shown to you soon.

## 8.4 The CALL opcode
The CALL opcode is used to call a function/procedure in Assembly, this is basically a jump, but with a special feature of return to the next instruction relative to the call command. This opcode accepts only one operand, that is the address of the function/procedure, usually identified by a symbol in .text segment. Here's an example: 

```asm
; Code stuff here...
mov rax, 1
mov rdx, 5
; ...
; ...
call DO_SOMETHING
; Code stuff here...
mov rsi, [rbp+-10] ; <- The execution flow backs to here
```

## 8.5 The RET opcode
The RET opcode pops the last value in stack and send it to the CPU for a jump. The pop is relative to RSP, so if you allocated memory inside the stack frame you must deallocate it to avoid let the processor jump to a random location in memory and a crash occur. This opcode doesn't accepts any operand. Here's a instance of a procedure and the RET opcode:

```asm
do_something: 
    push rbp ; saving rbp
    mov rbp, rsp

    sub rsp, 20 ; allocating memory for operations...

    ; Do something here...
    ; ...
    ; ...

    add rsp, 20 ; deallocate memory
    ret ; return to the next instruction relative to call opcode
```
A common question that usually appears is: what happens whether i don't put a RET opcode at the end of my functions/procedures?

The answer is usually simple, however, is good to remember that, to the computer, the instructions is like a huge string of bits, without begin and without end, so if your procedure starts exactly before the _start symbol, your program will just "start over", because the next instruction of the last in your function is the first of the _start.

## 8.7 Fetching stack arguments
As said previously in a preview (7. Stack), you can choose to where the CPU will look when fetching a value using RBP. Having in mind that the stack growns down, and the allocation of memory also works in the same way, [rbp+-1] will look to one byte below the RBP pointer, and [rbp+1] will look to one byte above. Here's a visual example.

```txt
     +---+
0x0  | 5 | <- value pushed in stack before call 
     +---+    
0x8  | x | <- return address
     +---+
0x10 |rbp| <- usual rbp push
     +---+
0x18 | y | <- rbp and rsp points here in
     +---+    mov rbp, rsp
0x20 |   |
     +---+

; rax filled with 5
mov rax, [rbp+16]

; al filled with a local variable
; with 1 byte of size
mov al, [rbp+-1]
```
In short, [rbp+number] are function arguments, and [rbp+-number] are local variables.

Another common question is: Visually, rbp is 24 bytes away from the value 5, so why [rbp+16] ?

The answer is: In cases like that, you need have in mind that the **end** of the value 5 is at 0x0, however, the end of the value isn't useful usually. You must fetch the arguments "thinking about the end of the previous argument", or in other words, the difference between rbp and the target. In the visual example given above, the difference between rbp and the target (i.e. 5), is really 16 bytes.

## 8.8 Calling conventions
It is right that was presented that you can pass function arguments through stack and registers, however, functions calls have conventions depending of the operating system and archtecture. The focus here is in Linux O.S, so here are how the arguments are usually passed to the functions:

```txt
rdi - Contains the 1st argument
rsi - Contains the 2nd argument
rdx - Contains the 3nd argument
rcx - Contains the 4th argument
r8  - Contains the 5th argument
r9  - Contains the 6th argument
stack - The rest of arguments
```
If in any moment your function needs return a value to the superior context, you use the RAX register to pass the value.

## 8.9 A working example of function call
A file named as "hello_x_times.asm" is in the same directory of this markdown file, there's an example inside, using function calls, stack frame allocation and more. The program goal is print "Hello, world!" x times, where x is the user that choose (only one digit numbers allowed).

## What's next
The functions subject is done! and the process of know the basics of the Assembly language is also complete, really nice! there'll be more topics, but all of them are talking more about solutions that can be useful when working with this language, like strings operations, memory management and more...
