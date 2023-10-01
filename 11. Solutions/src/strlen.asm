				;; strlen - Funtion to calculate the size of a string
				;;
				;; RDI register is used to receive the string address
				;; RAX is the return value (contains the size)
				;;
				;; The function doesn't change the value of RDI

strlen:
				;; Save some registers
	push rbp
	push rdi
	push rdx

				;; Update rbp
	mov rbp, rsp

	xor rdx, rdx
strlen_loop:
				;; Verify whether the address
				;; points to NULL byte	
	mov al, [rdi]
	cmp al, 0

				;; If it's NULL byte,
				;; jump to end
	jz strlen_end

				;; If not, increment size count
	inc rdx

				;; Increment string address
	inc rdi
	
				;; Jump to loop again
	jmp strlen_loop

strlen_end:
	
				;; Move value to rax as return value
	mov rax, rdx
	
				;; Restore the registers previously
				;; pushed into stack
	pop rdx
	pop rdi
	pop rbp

	ret 

