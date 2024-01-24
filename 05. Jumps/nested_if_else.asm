;; a program to create nested if/else statements
	
;; The context of program is add different
;; numbers to a base number depending of the
;; defined macro

;; If the input is 1, 4 is added to the base number
;; If the input is 2, 3 is added to the base number
;; if the input is 3, 5 is added to the base number
;; if the input is anything else, 1 is added to
;; the base number

global _start

;; Similar to C programming language, we use %define 
;; to create a macro in Nasm.
%define INPUT 10
%define TO_ADD_IF_INPUT_IS_1 4
%define TO_ADD_IF_INPUT_IS_2 3
%define TO_ADD_IF_INPUT_IS_3 5
%define TO_ADD_IF_INPUT_IS_ANYTHING_ELSE 1
%define BASE_NUMBER
	
segment .text

_start:
	;; bl contains the input
	mov bl, INPUT
	;; al contains the base number
	mov al, BASE_NUMBER

	;; cmp subtracts 1 from bl
	cmp bl, 1

	;; Due to cmp does a subtraction, jnz can be used to check
	;; if both values are equal. 2 - 1 != 0.
	jnz input_isnt_1

if_input_1:
	; The value is 1! 
	; Add the correct value to the base number
	add al, TO_ADD_WHEN_INPUT_IS_1
	
	jmp _END_OF_IF_ELSE_CHAIN

input_isnt_1:

	; Subtract the input by 2
	cmp bl, 2

	; Jump to the else if the result isn't 0
	jnz input_isnt_2

if_input_2:
	; The value is 2!
	; Add the correct value to the base number
	add al, TO_ADD_WHEN_INPUT_IS_2
	
	jmp _END_OF_IF_ELSE_CHAIN
	
input_isnt_2:
	cmp bl, 3

	jnz input_is_anything_else

if_input_3:
	add al, TO_ADD_WHEN_INPUT_IS_3
	
	jmp _END_OF_IF_ELSE_CHAIN

input_is_anything_else:
	add al, TO_ADD_WHEN_INPUT_IS_ANYTHING_ELSE
	

_END_OF_IF_ELSE_CHAIN:	

	;; Now we need to print the number, but there's a problem,
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
	;; is the exact thing we wan't.

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
	mov rdi, 0
	syscall
	
	segment .bss
	final_answer resb 3
	


