# 7. Stack
The Stack is a segment of memory very useful to store any kind of data, although we already have the .data, .bss and .rodata, this segment is very useful for many another things, like stack frames, a more dynamic way to store data, etc... To operate in this segment will be introduced to you more two registers, the Base Pointer and the Stack Pointer.

## 7.1 The new registers
Only these two new registers are necessary to do anything in the stack segment, being them RBP and RSP, that are also know as Base Pointer and Stack Pointer respectively. The Base Pointer always points to the begin of a block of memory that is important at the current time of your program logic. The Stack Pointer always points where is the current limit of allocated memory and is also useful for push values into stack, like a real stack data structure, these two aspects you must be careful to deal, because we are always more and more closer of the risk of segmentations faults, if you aren't careful, then your program will crash.


## 7.2 Allocating memory in Stack segment
We always must allocate memory in Stack to use it, the amount of allocated memory is defined by the difference between the Base Pointer and Stack pointer. The following example shows how to allocate memory in Stack segment.

```asm
; Is always needed, here we're pointing rsp and rbp to the same location.
; (passing value of rsp to rbp)
mov rbp, rsp

; Allocating 4 bytes in Stack Memory. (aka 64bits integer)
; We use sub to allocate memory in Stack
; and add to deallocate.
sub rsp, 4
```

Visual explanation of the above code
```txt
  +--------+
  |        | <- in the first line rbp and rsp points to here
  +--------+
  |        | <- allocated space
  +--------+
  |        | <- allocated space
  +--------+
  |        | <- allocated space
  +--------+
  |        | <- in the second line, rsp points to here. (allocated space)
  +--------+
```

It's important to say that the stack always grows down, this can be confusing but you'll get it soon.

After allocating a space inside the stack we can put values there, for instance, here is a code that put a single character there and then print it using a simple syscall.
```asm
	;; We can use a macro to be easier to understand the code
	%define CHAR_VARIABLE -1
	
	segment .text
	global _start

_start:
	;; Allocating memory
	mov rbp, rsp
	sub rsp, 1

	;; Moving the char 'R' to the CHAR_VARIABLE location
	mov BYTE [rbp+CHAR_VARIABLE], 'R'

	;; Printing the value what is inside the stack
	mov rax, 1
	mov rdi, 1
	;; Note that here we use a new opcode named lea.
	;; lea stands for load effective address.
	;; since we've started doing print syscalls
	;; we always used a symbol that lies in any of those
	;; segments (.rodata, .bss or .data), but those symbols
	;; don't represent values, they represent addresses
	;; (the address of that value in those segments)
	;; the kernel needs an address to print it's contents, so
	;; we use lea for this reason.
	lea rsi, [rbp+CHAR_VARIABLE]
	mov rdx, 1
	syscall
	
	mov rax, 60
	mov rdi, 0
	syscall


```

## 7.3 A common mistake
Let's look a situation that we're facing the following problem: Us, as programmers, we need to put a chain of chars inside of an allocated space into the stack, the first approach that we could think is the following

```asm
mov rbp, rsp
sub rsp, 4

mov eax, "abcd"

mov DWORD [rbp+MY_STRING], eax ; MY_STRING equals to -1

------------------------------------------------

; The above approach makes sense whether we think that 
; all chars will be written in order, from rbp+-1 to rbp+-4,
; but it isn't really true. The following visual explanation
; shows how the above code will behave.
;
; +----+
; | d  |
; +----+
; | c  | The "abcd" will be written from rbp+-1 to above
; +----+
; | b  | <- rbp
; +----+
; | a  | <- rbp+-1
; +----+
; |    | <- rbp+-2
; +----+
; |    | <- rbp+-3
; +----+
; |    | <- rsp (rbp+-4)
; +----+
;
; the correct approach would be set MY_STRING to -4
; in this way, "abcd" would be written from rsp to rbp+-1.
```

## 7.4 Sizes
You probably have seen that was used a command named "DWORD" in the example above, the sizes of operations are really important in assembly language, and if omitted, then some exceptions can occur in assembly time. A built-in feature that the mov opcode has is that if some bits weren't used in a move, then they are set to zeros, for instance:

Let's think about a 8bit register, so we'll move the number 2 to it.

```asm
mov al, 2

; now the register al contains the binary 00000010.
; even if the old value of the al register had 1 in the most significant bit,
; it is reseted to 0.
; thinking about bigger registers, if we set a number for the al version of rax,
; then the entire rax register will be reseted to zero, except the used bits.
```

For that reason this DWORD was used, to avoid we delete more data than expected in memory

Here's the possibles sizes that you can use with the x86_64:
```txt
BYTE - 8bits.
WORD - 16bits.
DWORD - Stands for double WORD. 32bits.
QWORD - Stands for quad WORD. 64bits.
```

In the following example these commands make real difference:

```asm
	mov rbp, rsp
	sub rsp, 20

	mov rax, "foobarrr"
	mov rbx, "E"

	mov [rbp+-8], rax
	; If we put the BYTE command here
	; nothing unexpected happens in the
	; print command bellow, but if we put
	; QWORD in it's place, then only the last
	; r of "foobarrr" will be printed.
	; That's because the first 8 bytes
	; from rbp+-9 to above were overwritten
	; by this command, resulting in an unexpected
	; behavior whether you not pay attention
	mov BYTE [rbp+-9], "E"
	
	mov rax, 1
	mov rdi, 1
	lea rsi, [rbp+-8]
	mov rdx, 8
	syscall
```

## 7.5 Stack Segment as Stack Data Structure
As said previously, we can use the Stack segment as a Data structure, like in C or C++. A Stack follow the Last in, First out principle, and with two new opcodes we can take the whole control over the Stack segment. The new opcodes are *push* and *pop*.

```txt
push: {
	Pushes a value from a register into memory, this new value
	will be placed where the rsp is pointing. Then
	an implicit "sub rsp, 8" occur. This opcode can
	only be used with 64bits registers.
}

pop:{
	Does the reverse process, removing the value from
	the stack. The value is now in the register that was
	used with the pop opcode. Then an implicit "add rsp, 8"
	occur. This opcode can only be used with 64bits registers.
}

The implicit actions from both opcodes use 8 as operand because
64bits registers use 8 bytes in total.
```

## 7.6 Function call preview
In Assembly language, is possible call methods, but in a very low-level format, we will cover more about functions in the next section. What you currently need to know is that if you use a positive number with the RBP, the CPU will fetch a value from above the pointer in memory. In short, [rbp+-8] will fetch a value that is in the way to the RSP, and [rbp+8] will fetch a value to the opposite side in the stack.

## What's next
The stack section is finished here, however, you'll keep reading this name for many times in this project, that's because the stack is the main segment when we talk about places to store program data. In the next section we'll keep reading more about functions and functions calls