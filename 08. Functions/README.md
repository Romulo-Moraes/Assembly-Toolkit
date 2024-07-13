# 8. Functions
Functions and procedures are blocks of code that are written to be reusable in your software, taking arguments and returning values based on such arguments. Understanding how functions work in Assembly will allow you to understand how functions work in C and, essentially, in any programming language.

## 8.1 The return address
Every time you call a function, the address of the next instruction after the call is pushed onto the stack, and your CPU is instructed to start executing the instructions that exist in the body of that function. When the job is done, a new opcode called `RET` is used to pop the address previously pushed onto the stack, sending it to the CPU and allowing it to resume the execution from where it stopped. This is the basic concept of a function in computing.

## 8.2 Stack frame
A stack frame is a block of memory starting from the return address and delimited by the `RSP`. This block of memory is useful for declaring local variables and storing any type of data. By default, the size of the stack frame is 0, and it is the programmer's responsability to allocate memory within this frame to use it, avoiding segmentation faults or other types of exceptions.

## 8.3 Functions arguments
Function arguments are crucial when creating dynamic functions, and it is rare to encounter a function that does not receive any arguments. In low-level programming, there are two ways to pass arguments to functions. The first way involves passing the values or even the addresses of such values through registers, allowing easy access within the scope of the function. The second way is passing arguments through the stack segment, pushing values onto the stack and fetching them inside the function.

## 8.4 The CALL opcode
The `CALL` opcode is used to call a function or procedure in Assembly. It is essentially a jump but with a special feature that allows returning to the next instruction relative to the `CALL` instruction. This opcode accepts only one operand, which is the address of the function or procedure, typically identified by a label in the .text segment.

```asm
mov rax, 1
mov rdx, 5

call DO_SOMETHING

mov rsi, [rbp-10] ; <- The execution flow returns here
```

## 8.5 The RET opcode
The `RET` opcode pops the last value from the stack and sends it to the CPU for a jump. The pop is relative to `RSP`, so if you allocated memory inside the stack frame, you must deallocate it to avoid the processor jumping to a random location in memory and crashing. This opcode doesn't accept any operands.

```asm
do_something: 
    push rbp ; saving rbp
    mov rbp, rsp

    sub rsp, 20 ; allocating memory for operations...

    ; Do something here...
    ; Do something here...
    ; Do something here...

    add rsp, 20 ; deallocate memory
    pop rbp ; pops rbp from stack
    
    ret ; return to the next instruction relative to the call opcode
```
So, what would happen if you forget to put the `ret` opcode at the end of your functions?

The answer is simple to understand, to the computer, instructions are like a large string of bits without a clear beginning or end. So if your procedure starts exactly before the `_start` label, your program will just "start over", because the next instruction after the last instruction of your function is the first of the `_start` label.

## 8.6 Fetching stack arguments
Fetching function arguments through the stack is one of the mentioned ways to pass arguments to a function. Keeping in mind that the stack grows down, the memory allocation also works in the same way for functions.

The `RBP` pointer can be used for fetching arguments passed through stack and accessing local variables within the function scope, the one thing that changes is the arithmetic performed to reach such values.

```txt
     +---+
0x0  |   | 
     +---+    
0x8  |   | 
     +---+    
0x10 |rbp| <- usual rbp push. rsp and rbp points to here
     +---+    after mov rbp, rsp
0x18 | x | <- return address
     +---+    
0x20 | 5 | <- value pushed on stack before calling the function
     +---+

; rax filled with 5
mov rax, [rbp+16]

; al filled with a local variable
; with 1 byte of size
mov al, [rbp+-1]
```
In short, `[rbp+number]` are function arguments, and `[rbp-number]` are local variables.

## 8.7 Calling conventions
It was shown that you can pass function arguments in two different ways, through registers and the stack segment; however, function calls have conventions depending on the environment, such as operating systems and architecture. The focus here is the Linux OS, so we will cover the conventions specific to this environment.

```txt
rdi - Contains the 1st argument
rsi - Contains the 2nd argument
rdx - Contains the 3nd argument
rcx - Contains the 4th argument
r8  - Contains the 5th argument
r9  - Contains the 6th argument
stack - The rest of arguments
```
If your function must return a value, you can use the `RAX` register to meet this requirement.

## 8.8 A working example of a function call
A file named 'hello_x_times.asm' is located in the same directory as this markdown file. It contains an example of using function calls, stack frame and more. The program's objective is to print 'Hello, world!' x times, where x is chosen by the user (only single-digit numbers are allowed).