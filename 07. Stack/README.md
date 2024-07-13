# 7. Stack
The stack segment is a memory region where you can store a large number of data types, including stack frames/local variables, function parameters and more. Although we already have the .data, .bss and .rodata segments, the stack is a more dynamic way to store data, since you can allocate and deallocate memory at any time. In order to operate on this segment, you will have to manipulate two new registers, the `RBP` and `RSP`.

## 7.1. The new registers
Only these two new registers are necessary to manipulate the stack segment, the RBP (Base Pointer) and RSP (Stack Pointer). The Base Pointer always points to the beginning of a block of memory that is important at the current time of your program logic. The Stack Pointer always points to the current limit of allocated memory, and is also useful for pushing values onto the stack, similar to a real stack data structure. Both pointers have to be handled with care, because they always point to memory locations where you are going to write or read something from there, if you try to use them in a memory region where your program cannot access, the program will crash.

## 7.2. Allocating memory in Stack segment
We must always allocate memory in the stack before using it. The amount of allocated memory is defined by the difference between the Base Pointer and the Stack Pointer.

At the beginning of the program, you always have to align both pointers, from the alignment onwards you can allocate and deallocate memory as much as you need. The base pointer is the base of your stack, and you should not mess with its value at any moment.

We can use the `sub` instruction to allocate memory on stack, and the `add` instruction to deallocate memory from there.

```asm
; aligning the pointers by copying the
; value of rsp to brp
mov rbp, rsp

; allocating 4 bytes in Stack Memory. (aka x64 integer)
sub rsp, 4
```

Visual explanation of the above code
```txt
  +--------+
  |        | <- in the second line, rsp points to here.
  +--------+    
  |        | <- allocated space
  +--------+
  |        | <- allocated space
  +--------+
  |        | <- allocated space
  +--------+
  |        | <- in the first line rbp and rsp points to here
  +--------+    
```

It is important to note that the memory grows down, so if we see the entire memory as a great stack data structure, the address 0x0 is the top of this stack, and the address 0xFFFFFF is the bottom of it. Because of this you have to subtract from the stack pointer in order to allocate space on stack, and add to the same pointer in order to deallocate memory.

After allocating space inside the stack, we can now store values there. For instance, here is a code that puts a single character into the allocated space and then prints it using a simple syscall.
```asm
    ; We can use a macro to easily understand the code
	%define CHAR_VARIABLE 1
	
	segment .text
	global _start

_start:
	; Allocating memory
	mov rbp, rsp
	sub rsp, 1

	; Moving the char 'R' to the CHAR_VARIABLE location
	mov BYTE [rbp-CHAR_VARIABLE], 'R'

	; Printing the value that is inside the stack
	mov rax, 1
	mov rdi, 1
	lea rsi, [rbp-CHAR_VARIABLE]
	mov rdx, 1
	syscall
	
	mov rax, 60
	mov rdi, 0
	syscall


```
Note that in the code above was used a new opcode called `lea`, this opcode stands for 'load effective address'. Since we've started doing print syscalls, we always used symbols that were located inside of segments like .bss, .rodata and .data; however, those symbols don't represent values, they represent addresses (the address of that value in those segments).

The `lea` instruction is useful for calculating the correct address if that address is composed of more than one value. For example, you can use this instruction to add an offset to a base address and then access the data you want.

In the above situation, the variable char is located at the base address `rbp` using the offset CHAR_VARIABLE(1). In the end, it is just a subtraction operation being performed between both operands.


## 7.3. The way how the data is read and written in memory
When you write data to memory, that data will ocupy the destination address you specified, if the data is larger than 1 byte, the remaining bytes will be written to larger memory addresses sequentially. Here is a visual explanation:

```asm
mov rbp, rsp
sub rsp, 4

mov eax, "abcd"

mov [rbp-4], eax

; ------------------------------------------------

; +----+
; |    |
; +----+
; |    | 
; +----+
; | a  | <- rsp
; +----+
; | b  | <- rbp-3
; +----+
; | c  | <- rbp-2
; +----+
; | d  | <- rbp-1
; +----+
; |    | <- rbp
; +----+

```
This behavior can be seen in practice if you print the memory address of `rsp`.

## 7.4. Operation sizes
As seen in previous topics, you can dump the values of registers to memory using a simple `mov` instruction, it is very useful to save registers' data across system calls, such actions that usually wipe out the data of those registers; however, you may also write immediates to memory without any further problem, the only thing that you have to be aware is the operation size.


Here are the possible sizes that you can use in x86-64:
```txt
BYTE - 8bits.
WORD - 16bits.
DWORD - Stands for double WORD. 32bits.
QWORD - Stands for quad WORD. 64bits.
```

When you write an immediate to memory, like in the example below, you have to specify the amount of memory that will be affected by the operation.

```asm
mov DWORD [rbp-4], "abcd"
```
The specified size have to be greater than or equal to the data that will actually be written to memory.

In the following example, the operation size makes all the difference:

```asm
    mov rbp, rsp
	sub rsp, 20

	mov rax, "foobarrr"

	mov [rbp-8], rax
	

    ; using BYTE or QWORD changes the resulting printed value
	mov BYTE [rbp+-9], "E"
	
	mov rax, 1
	mov rdi, 1
	lea rsi, [rbp-8]
	mov rdx, 8
	syscall

    mov rax, 60
    mov rdi, 0
    syscall
```
The value 'foobarr' is completely overwritten by a `mov` that uses a QWORD as operation size, resulting only in a lone 'r'.

## 7.5. Stack Segment as Data Structure
As mentioned earlier, we can use the stack segment as a data structure, similar to C or C++. A stack follows the Last In, First Out (LIFO) principle, and with two new opcodes, we can take the complete control over the stack segment. The new opcodes are `push` and `pop`.

### 7.5.1. The push opcode
The `push` opcode pushes a value from a register into memory. When the push operation is executed, an implicit `sub rsp, 8` is performed, then the value inside the register used on this operation is written where the `rsp` is pointing in memory. This opcode can only be used with 64-bit registers.

### 7.5.2. The pop opcode
The `pop` opcode does the reverse process, removing the value from the stack. When a pop operation is executed, the value that was in the top of the stack is now in the register that was used with the `pop` opcode, then an implicit `add rsp, 8` is performed. This opcode can only be used with 64-bit registers.

### 7.5.3. Push and pop example

```asm
	segment .text
	global _start

_start:
    mov rax, 7
    mov rbx, 8
    mov rdx, 9

	; pushing values onto the stack
    push rax
    push rbx
    push rdx

    ; while loop to pop all values
loop:

    ; runs 3 times
    mov al, [counter]
    cmp al, 3

    jge loop_end

    ; pop into rax
    pop rax
    ; transform into string
    add rax, '0'
    ; mov to an address in .data
    mov [numberAsString], al

    ; print the number
    mov rax, 1
    mov rdi, 1
    mov rsi, numberAsString
    mov rdx, 2
    syscall

    ; increment counter
    inc BYTE [counter]

    ; jump back to loop
    jmp loop

loop_end:

    mov rax, 60
    mov rdi, 0
    syscall

segment .bss
    counter resb 1

segment .data
    ; A symbol that represents a null byte
    ; and a new line (\n).
    ; The null byte will be replaced
    ; by a number on each loop
    numberAsString db 0x0, 0xa
```
Expected result: 
```txt
9
8
7
```