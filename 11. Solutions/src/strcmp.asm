	;; strcmp - function that compares two strings to test equality
	;; 
	;; RDI register is used as the first string
	;; RSI register is used as the second string
	;; RAX is the return value. -1 whether first
	;; string is less, 0 whether both are equal
	;; and 1 whether first string is greater than second
	;;
	;; The function doesn't change the value of RDI and RSI
	;; The function doesn't use any registers beyond the known

	
strcmpp:
	;; Save rbp
	push rbp

	;; Align stack pointers
	;; and save rdi and rsi
	mov rbp, rsp
	push rdi
	push rsi

	jmp strcmp_loop_begin

strcmp_increment_pointers_procedure:
	;; Increment both pointers
	;; if there's more loop iterations
 	inc rdi			
 	inc rsi
	
strcmp_loop_begin:
	
	;; Verify whether the first string
	;; reached NULL
	cmp BYTE [rdi], BYTE 0
	je strcmp_loop_end

	;; Verify whether the second string
	;; reached NULL
	cmp BYTE [rsi], BYTE 0
	je strcmp_loop_end

	;; If the code flow reached here,
	;; both still not reached NULL byte

	mov al, BYTE [rsi]
	
	;; Compare both bytes
	cmp BYTE [rdi], al

	;; If the first string is greater or equal
	;; than the second, jump to...
	jge strcmp_first_string_greater_eq

	;; If not, return -1, the first string
	;; is less than the second
	mov rax, -1

	jmp strcmp_return_procedure
	
strcmp_first_string_greater_eq:
	
	mov al, BYTE [rsi]
	
	;; Compare both bytes
	cmp BYTE [rdi], al

	;; Jump back to the loop
	;; whether both are equal
	je strcmp_increment_pointers_procedure

	;; reached here !?
	
	;; If it's really greater
	;; return value is 1
	mov rax, 1

	;; Jump to exit
	jmp strcmp_return_procedure
	
strcmp_loop_end:
	;; Here's the moment where one of the
	;; strings reached the NULL byte, we
	;; must identify which one did it to
	;; return the correct value

	mov al, BYTE [rsi]
	
	;; Verify whether both are equal
	cmp BYTE [rdi], al
	jne strcmp_both_ending_not_equal

	;; Return confirmed equality only whether
	;; both are equals, in other words, both
	;; end with NULL byten
	mov rax, 0

	jmp strcmp_return_procedure

strcmp_both_ending_not_equal:
	;; Verify whether the first string reached
	;; the NULL byte
	cmp BYTE [rdi], BYTE 0
	jne strcmp_first_string_is_greater

	;; Here we know that the first string is less
	mov rax, -1

	jmp strcmp_return_procedure
strcmp_first_string_is_greater:
	;; Here we know that the first string is greater
	mov rax, 1
	
strcmp_return_procedure:
	;; Restore everything from stack
	;; and return the result that is
	;; inside rax register
	pop rsi
	pop rdi
	pop rbp

	ret
