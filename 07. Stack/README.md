# 7. Stack
The stack is a segment of memory that is very useful for storing various types of data. Although we already have the .data, .bss, and .rodata segments, the stack is particularly useful for many other things, such as stack frames, providing a more dynamic way to store data, etc. To operate in this segment, I will introduce you to two more registers: the Base Pointer and the Stack Pointer.

## 7.1. The new registers
Only these two new registers are necessary to manipulate the stack segment, the RBP (Base Pointer) and RSP (Stack Pointer). The Base Pointer (RBP) always points to the beginning of a block of memory that is important at the current time of your program logic. The Stack Pointer (RSP) always points to the current limit of allocated memory and is also useful for pushing values onto the stack, similar to a real stack data structure. You must be careful when dealing with these two aspects because you are getting closer to the risk of segmentation faults. If you aren't careful, your program may crash.


## 7.2. Allocating memory in Stack segment
We must always allocate memory in the stack before using it. The amount of allocated memory is defined by the difference between the Base Pointer and the Stack Pointer.

```asm
; Is always needed, here we're pointing rsp and rbp to the same location.
; (passing value of rsp to rbp)
mov rbp, rsp

; Allocating 4 bytes in Stack Memory. (aka x64 integer)
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
	
0
It's important to note that the stack always grows down. This may be a bit confusing initially, but you'll understand it soon.

After allocating space inside the stack, we can store values there. For instance, here is a code that puts a single character into the allocated space and then prints it using a simple syscall.
```asm
	;; We can use a macro to easily understand the code
	%define CHAR_VARIABLE -1
	
	segment .text
	global _start

_start:
	;; Allocating memory
	mov rbp, rsp
	sub rsp, 1

	;; Moving the char 'R' to the CHAR_VARIABLE location
	mov BYTE [rbp+CHAR_VARIABLE], 'R'

	;; Printing the value that is inside the stack
	mov rax, 1
	mov rdi, 1

	; Note that here we use a new opcode named 'lea', which
	; stands for "load effective address." Since we've started
	; doing print syscalls, we always used a symbol that lies 
	; in any of those segments (.rodata, .bss, or .data). 
	; However, those symbols don't represent values; they
	; represent addresses (the address of that value in 
	; those segments). The kernel needs an address to 
	; print the contents, so we use 'lea' for this reason.
	lea rsi, [rbp+CHAR_VARIABLE]
	mov rdx, 1
	syscall
	
	mov rax, 60
	mov rdi, 0
	syscall


```

## 7.3. A common mistake
Let's consider this situation: as programmers, we need to write a chain of characters inside an allocated space in the stack. The first approach that may come to mind is the following:

```asm
mov rbp, rsp
sub rsp, 4

mov eax, "abcd"

mov DWORD [rbp+MY_STRING], eax ; MY_STRING equals to -1

; ------------------------------------------------

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
; the correct approach would be set MY_STRING to -4,
; in this way, "abcd" would be written from rsp to rbp+-1.
```

## 7.4. Sizes
You probably noticed that a command named "DWORD" was used in the example above. The sizes of operations are crucial in assembly language, and if omitted, some exceptions can occur at assembly time. A built-in feature of the `mov` opcode is that if some bits aren't used in a move, they are set to zeros. For instance:

Let's consider a 8bit register, so we will assign the number 2 to it.

```asm
mov al, 2

; Now, the register 'al' contains the binary 00000010. 
; Even if the old value of the 'al' register had 1 in 
; the most significant bit, it would be set to 0. 
; Thinking about a larger number, if we set a number for
; the 'al' version of 'rax', the entire 'rax' register 
; would be set to zero, except for the used bits.
```

For that reason that `DWORD` was used, to avoid delete more data than expected in memory

Here are the possibles sizes that you can use with the x86_64:
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

	mov [rbp+-8], rax
	

	; If we use the 'BYTE' here, nothing unexpected 
	; happens in the print command below. However, if we 
	; put QWORD in its place, only the last 'r' of 
	; "foobarrr" will be printed. That's because the first
	; 8 bytes from rbp-9 to above were overwritten by 
	; this command, resulting in unexpected behavior if not careful.
	mov BYTE [rbp+-9], "E"
	
	mov rax, 1
	mov rdi, 1
	lea rsi, [rbp+-8]
	mov rdx, 8
	syscall

    mov rax, 60
    mov rdi, 0
    syscall
```

## 7.5. Stack Segment as Data Structure
As mentioned earlier, we can use the stack segment as a data structure, similar to C or C++. A stack follows the Last In, First Out (LIFO) principle, and with two new opcodes, we can take complete control over the stack segment. The new opcodes are `push` and `pop`.

### 7.5.1. push opcode
`push` opcode pushes a value from a register into memory. This new value will be placed where the `rsp` is pointing, then an implicit "sub rsp, 8" will be performed. This opcode can only be used with 64-bit registers.

### 7.5.2. pop opcode
`pop` opcode does the reverse process, removing the value from the stack. The value is now in the register that was used with the *pop* opcode, then an implicit "add rsp, 8" will be performed. This opcode can only be used with 64-bit registers.

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

## 7.6. Function call preview
In Assembly language, it's possible to call methods, but in a very low-level format. We will cover more about functions in the next section. What you currently need to know is that if you use a positive number with the `RBP`, the CPU will fetch a value from above the pointer in memory. In short, `[rbp-8]` will fetch a value that is on the way to the `RSP`, and `[rbp+8]` will fetch a value to the opposite side in the stack.
