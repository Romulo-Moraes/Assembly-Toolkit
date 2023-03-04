



# 6. Arithmetic
Arithmetic is really important in software, even more in complex programs, like AI, games, etc... However, here in the low-level it's important too. There're four basic arithmetic operations that the CPU can do, being them add, subtract, multiply and divide, and we'll see how each one work now.

## 6.1 Flags
Before start talking about the methods to do arithmetic in assembly is important talk about CPU flags. A CPU flag is used for store a information representing something that have just happened, and this "something" could be a overflow or even representing that the result of a arithmetic operation resulted in zero. This can be used to decide what to do, mainly in jumps, after the cmp opcode, that is what usually create flags.

## 6.1 Add
There're two ways of add something in Assembly language, one more sophisticated and a simple one, we already saw them before and they are the *add* and *inc*.
```txt
add - Accepts two operands, the left operand will be incremented by the value of the second operand.

inc - Accepts only one operand, and will be incremented by one. 

```

## 6.2 Subtract
There're also two ways of subract something in Assembly, and is the exact opposite side of the section, the commands are *sub* and *dec*.
```txt
sub - Accepts two operands, the left will be decremented by the value of the second operand.

dec - Accepts only one operand, and will be decremented by one.
```

## 6.3 Multiply
Multiplication here is a bit more complicated than the expected, because we have to deal with quotient, rest and three or more registers for the process be a success.

<ul>
	<li>rax: Put the number to be multiplied here</li>
	<li>[register or operand in memory]: Put the multiplier in one of them</li>
</ul>

Commands to do multiplication
<ul>
	<li>mul: multiplication for unsigned numbers</li>
	<li>imul: multiplication for signed numbers</li>
</ul>

Note: the *mul* and *imul* opcode must be used with the multiplier

Note 2: the rax register will be filled up with the result of the operation


### example:

```asm
mov rax, 10
mov rbx, 2
mul rbx
	
; now rax contains 20 as it's value
```

### 6.3.1 Using jumps in multiplication
The *mul* and *imul* trigger some flags when a overflow happens and can be handled by some jumps that we've seen before, let's look some examples.

```asm
; imul is used for signed operations,
; the following code results in -4.
; there's no problem here about overflow
; because al support -128 until 127,
; so flag of overflow isn't triggered
mov al, 2
mov bl, -2
imul BYTE bl

; mul is used for unsigned operations,
; the following code results in -4.
; a unsigned byte can support 0 until 255
; -4 doesn't fit in that range, so overflow
; flag is triggered
mov al, 2
mov bl, -2
mul BYTE bl
```
A more significant moment that an overflow jump becomes useful is in the following example
```asm
	; An unsigned byte can support values between
	; 0 and 255.
	; In this code, if al is 128, then the content of
	; the symbol msg will be printed, with any number that
	; doesn't result in an overflow at the end (aka 0 - 127)
	; nothing happens,
	; this simply happens because 128 * 2 equals to 256, that
	; means a overflow
	mov al, 128
	mov bl, 2
	mul bl

	; If an overflow NOT occurred, then jump to...
	jnc jump_on_overflow

	; If the flow of code reaches here, then it means
	; that an overflow occurred.

	; Print something just to know whether the flow of
	; code reached here
	mov rax, 1
	mov rdi, 1
	mov rsi, msg
	mov rdx, msg.sz
	syscall
	
	
jump_on_overflow:
	; Further code here, probably a syscall to exit the
	; program
```

In short, overflow is when a value doesn't fit inside the register, when two positives values are added with each other and the result is negative or even when the result is just impossible for that operation, that means an overflow occurred.

### 6.3.2 Possible jumps for multiplication
The following jumps are useful to handle overflow in multiplication and for addition/subtraction too.
```txt
JO - Jump on overflow (signed operation)
JNO - Jump on not overflow (signed operation)

JC - Jump on overflow (unsigned operation)
JNC - Jump on not overflow (unsigned operation)
```

## 6.4 Divide 
Division is also a bit more complex than add and subtract, and follow the  same principle of multiplication but with some more details, here's how to use.

<ul>
	<li>rax: Put the dividend here</li>
	<li>[register or operand in memory]: Put the divisor here</li>
</ul>

Commands to do division:
<ul>
	<li>div: division for unsigned numbers</li>
	<li>idiv: division for signed numbers</li>
</ul>

Note: *div* and *idiv* must be used with the divisor

<ul>
	<li>rax: Filled up with the quotient</li>
	<li>rdx: Fillep up with the rest</li>
</ul>

### Example:

```asm
mov rax, 10
; the div command always look to rax and rdx to do the
; calculations, if the division is unsigned, then you must do
; a xor in rdx, this will put zero in each bit of the rdx register
xor rdx, rdx
mov rbx, 2
div rbx

; rax has the quotient value 5
; rdx has the rest value 0
```

### Example with negatives numbers
As said previously, when we know that there's a possibility of our program need handle a division with negatives numbers, we must use the idiv opcode, so let's see a example of a program with that.
```asm
segment .text
	global _start
	
_start:
	mov rax, -10
	; the div opcode always look to rax and rdx to do the
	; calculations, if the division is signed, then you must
	; use the cqo opcode, this will put 1 in each bit of rdx if
	; the value of dividend is negative, otherwise 0 is used.
	cqo
	mov rbx, 2
	idiv rbx
	
	; now rax contains -5 and rdx contains 0
	
	; here we could theoretically put a procedure to 
	; transform -5 to a printable version and print
	; the value after, but we'll cover it later.
	; It's important to remember that we can't just
	; add '0' to -5 with the goal of transform in a printable
	; version, because the binary content of -5 and 5
	; is completely different.
	
	; since we can't print a negative number, a new trick will be introduced to you.
	
	; the neg opcode will negate the value of rax, if this had
	; the number -5 in it's contents, now it has 5
	neg rax
	
	; transform to a printable version
	add rax, '0'
	
	; save in .bss
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

## What's next
In this moment we can already do more sophiticated programs, that do math calculations, system calls, jumps, etc... But we are so far from the end, in the next section we'll see about the stack segment and why this is so important in any programming language.
