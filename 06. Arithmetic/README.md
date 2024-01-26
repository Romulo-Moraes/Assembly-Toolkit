



# 6. Arithmetic
Arithmetic is crucial in software, especially in complex programs like AI, games, etc. However, it's also significant at the low level. There are four basic arithmetic operations that the CPU can perform: addition, subtraction, multiplication, and division.

## 6.1 Flags
Before we begin discussing methods for arithmetic in assembly, it's important to address CPU flags. A CPU flag is utilized to store information representing an event that has just occurred. This event could be an overflow or indicate that the result of an arithmetic operation is zero. These flags are crucial for making decisions, especially in jumps after the cmp opcode, which typically sets flags.

## 6.1 Addition
There are two ways to perform addition in Assembly language, one more sophisticated and one simpler. We have already encountered them before, and they are the add and inc instructions.
```txt
add - Takes two operands, the left operand will be incremented by the value of the second operand.

inc - Takes only one operand, and will be incremented by one. 

```

## 6.2 Subtraction
Similarly, there are two ways to subtract in Assembly. The commands for subtraction are sub and dec.
```txt
sub - Takes two operands, the left will be decremented by the value of the second operand.

dec - Takes only one operand, and will be decremented by one.
```

## 6.3 Multiplication
Multiplication in Assembly can be a bit more complex than expected because it involves introducing an additional register or even a value in memory into the process.

<ul>
	<li>rax: multiplicand</li>
	<li>[register or operand in memory]: multiplier</li>
</ul>

Instructions: 
<ul>
	<li>mul: multiplication for unsigned numbers</li>
	<li>imul: multiplication for signed numbers</li>
</ul>

Note 1: The *mul* and *imul* opcodes must be used with the multiplier to perform multiplication in Assembly.

Note 2: the rax register will be filled up with the result of the operation


### example:

```asm
mov rax, 10
mov rbx, 2
mul rbx
	
; now rax stores 20 as its value
```

### 6.3.1 Using jumps in multiplication
The *mul* and *imul* instructions trigger certain flags when an overflow occurs, and these can be managed using the jumps we've discussed earlier. Let's take a look at some examples.

```asm
; imul is used for signed operations,
; the following code results in -4.
; there is no problem about overflow,
; because al supports from -128 to 127,
; so the overflow flag isn't triggered
mov al, 2
mov bl, -2
imul BYTE bl

; mul is used for unsigned operations,
; the following code results in -4.
; a unsigned byte can support from 0 to 255
; -4 doesn't fit in that range, so overflow
; flag is triggered
mov al, 2
mov bl, -2
mul BYTE bl
```
A more significant scenario where an overflow jump becomes useful is illustrated in the following example:
```asm
	segment .text
	global _start

_start:
	; An unsigned byte can support values between
	; 0 and 255.
	; In this code, if al is 128, the message 'Overflow!!'
	; will be printed.
	; Using any number that doesn't result in an overflow
	; at the end (i.e 0 - 127),
	; the message 'Not overflow!' will be printed,
	; this happens because 128 * 2 equals to 256, that
	; means a overflow
	mov al, 128
	mov bl, 2
	mul bl

	; If an overflow NOT occurred, then jump to...
	jnc jump_not_overflow

	; If the flow of code reaches here, then
	; an overflow happened.

	;; Print a message saying it
	mov rax, 1
	mov rdi, 1
	mov rsi, msg
	mov rdx, msg.sz
	syscall

	;; Jump to end because we don't want to
	;; print two messages
	jmp end
jump_not_overflow:
	;; If the flow of code reaches here, a overflow
	;; didn't happen

	;; Print a message saying it
	mov rax, 1
	mov rdi, 1
	mov rsi, msg2
	mov rdx, msg2.sz

	syscall

end:

	;; Exit the program
	mov rax, 60
	mov rdi, 0

	syscall
	
	segment .rodata
	msg db 'Overflow!!', 0xa, 0x0
	msg.sz equ $-msg
	msg2 db 'Not overflow!', 0xa, 0x0
	msg2.sz equ $-msg2
```

In short, overflow occurs when a value doesn't fit inside the register. This can happen when two positive values are added together, resulting in a negative value, or when the result is otherwise impossible for that specific operation, indicating an overflow.

### 6.3.2 Possible jumps for multiplication
The following jumps are useful to handle overflows in multiplication and also for addition/subtraction.
```txt
JO - Jump on overflow (signed operation)
JNO - Jump on not overflow (signed operation)

JC - Jump on overflow (unsigned operation)
JNC - Jump on not overflow (unsigned operation)
```

## 6.4 Division
Division is also a bit more complex than addition and subtraction, following the same principles as multiplication but with some additional details.

<ul>
	<li>rax: dividend</li>
	<li>[register or operand in memory]: divisor</li>
</ul>

Instructions:
<ul>
	<li>div: division for unsigned numbers</li>
	<li>idiv: division for signed numbers</li>
</ul>

Note: *div* and *idiv* must be used with the divisor

<ul>
	<li>rax: receives the quotient</li>
	<li>rdx: receives the rest</li>
</ul>

### Example:

```asm
mov rax, 10
; The `div` command always looks to `rax` and `rdx`
; to perform calculations. If the division is unsigned,
; you must perform a XOR operation on `rdx`. This will 
; set each bit of the `rdx` register to zero.
xor rdx, rdx
mov rbx, 2
div rbx

; rax has the quotient 5
; rdx has the rest 0
```

### Example with negatives numbers
As mentioned earlier, when there's a possibility that our program needs to handle division with negative numbers, we must use the `idiv` opcode.
```asm
segment .text
	global _start
	
_start:
	mov rax, -10
	; The 'idiv' opcode always looks to 'rax' and 'rdx' for 
	; calculations. If the division is signed, you must 
	; use the 'cqo' opcode. This will set each bit of 
	; 'rdx' to 1 if the value of the dividend is negative; 
	; otherwise, 0 is used.
	cqo
	mov rbx, 2
	idiv rbx
	
	; rax = -5
	; rdx = 0
	
	; Here, we could theoretically implement a procedure to transform -5
	; into a printable version and then print the value. However, we'll
	; cover that later. It's crucial to remember that we can't simply add 
	; '0' to -5 with the goal of transforming it into a printable version 
	; because the binary content of -5 and 5 is completely different.
	
	; Since we can't directly print a negative number, a new trick will
	; be introduced to you.
	
	; The 'neg' opcode negates the value of 'rax'. If 'rax' originally 
	; held the number -5, its contents will now be 5.
	neg rax
	
	; transform to a printable version
	add rax, '0'
	
	; save it in .bss
	mov [number], rax
	
	; print value
	mov rax, 1
	mov rdi, 1
	mov rsi, number
	mov rdx, 8
	syscall
	
	; exit the program
	mov rax, 60
	mov rdi, 1
	syscall
	
	segment .bss
		number resb 8

```