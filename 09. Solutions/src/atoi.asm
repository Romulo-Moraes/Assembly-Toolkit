;; atoi - function that receives a string and return the contents as integer 
;; 
;; RDI register receive the address of the string
;; RAX is the return value (contains the integer)
;;
;; The function doesn't change the value of RDI
;; This function uses rdx, rcx and rbx, or its fraction
;; This function restore the original value of rdx, rcx and rbx registers
	
atoi:
	;; Save some registers that
	;; will be used in the function
	push rbp
	push rdx
	push rcx
	push rbx
	push rdi

	;; Update rbp
	mov rbp, rsp

	;; Allocate memory in stack
	sub rsp, 0xb
	
	;; Clear region
	mov BYTE [rbp+-1], 0x0
	mov QWORD [rbp+-11], 0x0

	;; Checking if the number is negative
	cmp BYTE [rdi], '-'
	jne _atoi_negative_number_end

_atoi_negative_number:
	;; Set negative number flag
	mov BYTE [rbp+-1], 0x1
	inc rdi

	;; Jump straight to loop because
	;; if the first byte is '-'
	;; there's no point in check if
	;; it's number in the next
	;; instructions
	jmp _atoi_conversion_loop
_atoi_negative_number_end:
	;; Copy first byte
	mov BYTE bl, [rdi]

	;; Check if is number, bl as argument
	call _atoi_check_is_number
	cmp rax, 1

	;; Jump to end if this isn't number
	jne _atoi_conversion_loop_end
	
_atoi_conversion_loop:
	;; Get current byte
	mov BYTE bl, [rdi]

	;; Check if it's null
	cmp bl, 0x0
	;; Jump to end if this is null
	je _atoi_conversion_loop_end

	;; Check if it's numeric
	call _atoi_check_is_number
	cmp rax, 0x1

	je _atoi_is_a_number

	;; Jump to end if this isn't number
	jmp _atoi_conversion_loop_end
_atoi_is_a_number:
	;; It's a number!

	;; Transform to number
 	sub bl, '0'

	;; Multiply the current value in
	;; memory by 10
	mov rax, [rbp+-11]
	mov rcx, 10
	mul rcx

	;; Put value back
	mov [rbp+-11], rax
	;; Pass current value to al. aka rax
	mov al, bl

	;; Add the value
	add [rbp+-11], rax

	;; Increment the address
	inc rdi
	;; Jump back to loop
	jmp _atoi_conversion_loop

_atoi_conversion_loop_end:
	;; Move value to rax as return value
	mov rax, [rbp+-11]

	;; Checking if the number must be negative
	cmp BYTE [rbp+-1], 0x1
	;; Ignore sign addition if flag not active
	jne _atoi_add_negative_sign_end
	
_atoi_add_negative_sign:
	;; Negate number
	neg rax			
_atoi_add_negative_sign_end:	
	;; Free stack memory
	add rsp, 0xb

	;; Restore registers previously
	;; pushed into stack
	pop rdi
	pop rbx
	pop rcx
	pop rdx
	pop rbp

	;; Return function
	ret

;; Private atoi function, check if character
;; in bl register is numeric returning 1 as TRUE
;; and 0 as FALSE
_atoi_check_is_number:
	cmp bl, 0x30
	jge _atoi_ge_than_0

	mov rax, 0
	ret
_atoi_ge_than_0:	
	cmp bl, 0x39
	jle _atoi_le_than_9

	mov rax, 0
	ret

_atoi_le_than_9:
	mov rax, 1
	ret
