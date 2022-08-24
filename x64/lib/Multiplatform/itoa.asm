; Transform a number to string

; Number in RAX
; Output address in RSI

%define NUMBER_OF_CHARS_PUSHED_OFFSET 0
%define NEGATIVE_NUMBER_FLAG_OFFSET 4


itoa:
	push rsi
	push rbp
	mov rbp, rsp
	
	sub rsp, 5

	mov DWORD [rbp+NUMBER_OF_CHARS_PUSHED_OFFSET], 0

	cmp rax, 0
	jl Negative_number


	; If it reach here, the number ins't negative, flag to false
	mov BYTE [rbp+NEGATIVE_NUMBER_FLAG_OFFSET], BYTE 0


	je Number_zero
	jmp Loop



Number_zero:
	; If the number is zero, it has nothing todo, heading to end process
	add rax, '0'
	push rax
	
	inc DWORD [rbp+NUMBER_OF_CHARS_PUSHED_OFFSET]
	
	jmp Write_in_output
Negative_number:
	; Set negative flag, will be handled after
	mov BYTE [rbp+NEGATIVE_NUMBER_FLAG_OFFSET], BYTE 1

	; Transform number to positive
	mov rdi, -1
	imul rdi

Loop:

	; Always compare if the number is lower than 10
	; Numbers lower than 10 don't need to be divided
	cmp rax, 10

	jl Last_number

	xor rdi,rdi
	xor rdx,rdx

	; Get rest of division and save in stack
	mov rdi, 10
	div rdi

	add rdx, '0'
	push rdx

	inc DWORD [rbp+NUMBER_OF_CHARS_PUSHED_OFFSET]


	jmp Loop	

Last_number:

	; If only has one number, just transform to string and save in stack
	add rax, '0'
	push rax

	inc DWORD [rbp+NUMBER_OF_CHARS_PUSHED_OFFSET]

	jmp Handle_negative_number

Handle_negative_number:
	; Check the flag previous setted to see if a signal need be added
	cmp BYTE [rbp+NEGATIVE_NUMBER_FLAG_OFFSET], BYTE 1

	jne Write_in_output

	mov rax, "-"
	push rax

	inc DWORD [rbp+NUMBER_OF_CHARS_PUSHED_OFFSET]



Write_in_output:

Write_in_output_loop:
	; Loading all numbers from memory and writing in output address
	pop rax
	mov [rsi], rax

	inc rsi
	dec DWORD [rbp+NUMBER_OF_CHARS_PUSHED_OFFSET]

	cmp DWORD [rbp+NUMBER_OF_CHARS_PUSHED_OFFSET], 0


	jge Write_in_output_loop

	mov rsp, rbp
	
	pop rbp
	pop rsi

	ret
