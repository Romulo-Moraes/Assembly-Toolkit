# 8. Functions
Functions or procedures are blocks of code that are reusable in your software, taking arguments and returning values based on such arguments. Understanding how functions work in Assembly will allow you to understand how functions work in C and, essentially, in any programming language.

## 8.1 The return address
Every time you call a function, the address of the next instruction in the current context is pushed onto the stack, and your CPU is instructed to start executing the instructions that exist in the body of that function. When the job is done, a new opcode called `RET` is used to pop the address previously pushed onto the stack, sending it to the CPU and allowing it to resume execution from where it stopped. This is the basic concept of a function in computing.

## 8.2 Stack frame
A stack frame is a block of memory, starting from the return address and delimited by the `RSP`, that is useful for declaring local variables and storing any kind of data. By default, the size of the stack frame is 0, and it is the job of the programmer to allocate memory inside this frame for use, avoiding segmentation faults or other kinds of exceptions.

## 8.3 Functions arguments
Function arguments are crucial when creating dynamic functions, and it's rare to encounter a function that doesn't receive any arguments. In low-level programming, there are two ways to pass arguments to functions. The first way involves passing the values or even the addresses to such values through registers, allowing easy access within the scope of the function. The second way is passing arguments through the stack, pushing values onto the stack and fetching them inside the function.

## 8.4 The CALL opcode
The `CALL` opcode is used to call a function or procedure in Assembly. It is essentially a jump but with a special feature that allows returning to the next instruction relative to the `CALL` command. This opcode accepts only one operand, which is the address of the function or procedure, typically identified by a symbol in the .text segment.

```asm
; ...
; ...
mov rax, 1
mov rdx, 5

call DO_SOMETHING

mov rsi, [rbp+-10] ; <- The execution flow returns to here
```

## 8.5 The RET opcode
The `RET` opcode pops the last value from the stack and sends it to the CPU for a jump. The pop is relative to `RSP`, so if you allocated memory inside the stack frame, you must deallocate it to avoid the processor jumping to a random location in memory and crashing. This opcode doesn't accept any operands.

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

The answer is simple to understand. To a computer, instructions are like a large string of bits without a clear beginning or end. So, if your procedure starts exactly before the `_start` symbol, your program will just "start over" because the next instruction after the last instruction of your function is the first instruction of the `_start` symbol.

## 8.7 Fetching stack arguments
Fetching function arguments through the stack is one of the mentioned ways to pass arguments to a function. Keeping in mind that the stack grows down, the allocation of memory also works in the same way. As mentioned earlier, you can choose where the CPU will look as it is fetching a value using `RBP`; `[rbp-1]` will look to one byte below the `RBP` pointer, and `[rbp+1]` will look to one byte above.

```txt
     +---+
0x0  | 5 | <- value pushed on stack before calling the function
     +---+    
0x8  | x | <- return address
     +---+
0x10 |rbp| <- usual rbp push
     +---+
0x18 | y | <- rbp and rsp points to here in
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

Other possible question is: Visually, rbp is 24 bytes away from the value 5, so why [rbp+16] ?

In such cases, it's important to keep in mind that the end of the value 5 is at address 0x0. However, the end of a value is not useful. You must fetch the arguments by "thinking about the end of the previous argument," or in other words, considering the difference between `rbp` and the target. In the visual example given above, the difference between `rbp` and the target (i.e., 5) is indeed 16 bytes.

## 8.8 Calling conventions
A few minutes ago, it was introduced that you can pass function arguments in two different ways: through registers and the stack segment. However, function calls have conventions depending on the environment, such as operating systems and architecture. The focus here is on the Linux OS, so we will cover the conventions specific to this environment.

```txt
rdi - Contains the 1st argument
rsi - Contains the 2nd argument
rdx - Contains the 3nd argument
rcx - Contains the 4th argument
r8  - Contains the 5th argument
r9  - Contains the 6th argument
stack - The rest of arguments
```
If your function have to return a value to the previous procedure, you can use the `RAX` to return such value.

## 8.9 A working example of a function call
A file named 'hello_x_times.asm' is located in the same directory as this markdown file. It contains an example of using function calls, stack frame allocation, and more. The program's objective is to print 'Hello, world!' x times, where x is chosen by the user (only single-digit numbers are allowed).