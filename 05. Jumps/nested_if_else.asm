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
%define INPUT 1
%define TO_ADD_IF_INPUT_IS_1 4
%define TO_ADD_IF_INPUT_IS_2 3
%define TO_ADD_IF_INPUT_IS_3 5
%define TO_ADD_IF_INPUT_IS_ANYTHING_ELSE 1
%define BASE_NUMBER 2
	
segment .text

_start:
	;; bl contains the input
	mov bl, INPUT
	;; al contains the base number
	mov al, BASE_NUMBER

	;; checking if bl equals to 1
	cmp bl, 1

	;; Due to cmp does a subtraction, jnz can be used to check
	;; if both values are equal. 2 - 1 != 0.
	jnz input_isnt_1

if_input_1:
	; The value is 1! 
	; Add the correct value to the base number
	add al, TO_ADD_IF_INPUT_IS_1
	
	jmp _END_OF_IF_ELSE_CHAIN

input_isnt_1:

	;; checking if bl equals to 2
	cmp bl, 2

	; Jump to the else if the result isn't 0
	jnz input_isnt_2

if_input_2:
	; The value is 2!
	; Add the correct value to the base number
	add al, TO_ADD_IF_INPUT_IS_2
	
	jmp _END_OF_IF_ELSE_CHAIN
	
input_isnt_2:
	;; checking if bl equals to 3
	cmp bl, 3

	jnz input_is_anything_else

if_input_3:
	add al, TO_ADD_IF_INPUT_IS_3
	
	jmp _END_OF_IF_ELSE_CHAIN

input_is_anything_else:
	add al, TO_ADD_IF_INPUT_IS_ANYTHING_ELSE
	

_END_OF_IF_ELSE_CHAIN:	

	;; In order to print the result, we need to perform a small conversion
	;; from the number to its character representation.

	;; The trick is add the character '0' to the number we want to convert,
	;; doing a simple math using the ascii enconding.

	add al, '0'

	;; Explanation:
	;; If we have the number 5 in the al register and we add the
	;; character '0' that means 48 in decimal, the final result 53.
	;; If we look in the ascii table, we will see that 53 represents
	;; the character '5', that is exactly what we want.

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
	


