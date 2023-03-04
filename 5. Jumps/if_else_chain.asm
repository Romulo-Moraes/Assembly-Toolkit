	;; a program to create a chain of if/else
	
	;; The context of program is add different
	;; numbers to a base number depending of the
	;; defined macro

	;; If the input is 1 then 4 is added to the base number
	;; If the input is 2 then 3 is added to the base number
	;; if the input is 3 then 5 is added to the base number
	;; if anything else is passed to input then 1 is added to
	;; the base number

	;; We use %define to create a macro in nasm, like in C 
	;; language, but the difference is that here is with the
	;; symbol of percentage, and in C  is hashtag. 
	%define INPUT 10
	%define TO_ADD_WHEN_INPUT_IS_1 4
	%define TO_ADD_WHEN_INPUT_IS_2 3
	%define TO_ADD_WHEN_INPUT_IS_3 5
	%define TO_ADD_WHEN_INPUT_IS_ANYTHING_ELSE 1
	
	segment .text
	global _start

_start:
	;; bl contains the input
	mov bl, INPUT
	;; al contains the base number, that's 1
	mov al, 1

	;; cmp subtract 1 from bl
	cmp bl, 1

	;; Since cmp does a subtraction, jnz can be used to check
	;; if both values are equal. 2 - 1 != 0.
	
	jnz _not_1

	;; If the flow of the program reach here, then INPUT equals to 1
	add al, TO_ADD_WHEN_INPUT_IS_1
	
	jmp _END_OF_IF_ELSE_CHAIN

_not_1:

	cmp bl, 2

	jnz _not_2

	;; If the flow of the program reach here, then INPUT equals to 2
	add al, TO_ADD_WHEN_INPUT_IS_2
	
	jmp _END_OF_IF_ELSE_CHAIN
	
_not_2:
	cmp bl, 3

	
	jnz _INPUT_IS_ANYTHING_ELSE

	add al, TO_ADD_WHEN_INPUT_IS_3
	
	jmp _END_OF_IF_ELSE_CHAIN

_INPUT_IS_ANYTHING_ELSE:
	add al, TO_ADD_WHEN_INPUT_IS_ANYTHING_ELSE
	

_END_OF_IF_ELSE_CHAIN:	

	;; Now we need to print the number, but there's a problem
	;; we can't just print the number, because according to the ascii
	;; table, only numbers between the ascii codes 48 and 57 are
	;; printable, now we are working with literal numbers, so we
	;; must convert it to show in the terminal, otherwise, junk
	;; data would be showed to us.

	;; Now a trick, we just need add the CHARACTER '0' to the number,
	;; doing a simple math behind the ascii encoding.

	add al, '0'

	;; Explanation:
	;; If we have the number 5 in the al register and we add the
	;; character '0' that has the ascii value 48, we just added
	;; 48 to 5, resulting in 53. If we look in the ascii table,
	;; then we will see that 53 represents the character '5', that
	;; is the exactly thing we wan't.

	;; Moving the data to a address in .bss
	mov [final_answer], al
	;; Adding a new line at the end
	mov [final_answer+1], BYTE 0xa

	;; Printing the answer
	mov rax, 1
	mov rdi, 1
	mov rsi, final_answer
	mov rdx, 2
	syscall

	;; Exiting the program
	mov rax, 60
	mov rdi, 1
	syscall
	
	segment .bss
	final_answer resb 3
	


