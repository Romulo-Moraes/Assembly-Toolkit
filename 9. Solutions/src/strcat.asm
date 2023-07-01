;; strcat - function that concatenate the source str to destiny str
;; 
;; RDI register is used as destiny
;; RSI register is used as source
;; RAX is the return value (contains destiny addr)
;;
;; The function doesn't change the value of RDI and RSI
;; This function uses the dl register to work
;; This function saves and restore the original value of the complete part of dl register


strcat:
	;; Save and update rbp
	push rbp
	mov rbp, rsp

	;; save rdi, rsi and rdx
	push rdi
	push rsi
	push rdx

_strcat_loop:
	;; Searching for null byte in destiny
	cmp BYTE [rdi], 0
	je _strcat_loop_end

	;; If not found, inc pointer
	inc rdi

	;; Jump back to loop
	jmp _strcat_loop
_strcat_loop_end:

	;; Loop to copy bytes
	;; from source to destiny
_strcat_loop2:
	;; Checking if reached the
	;; end in source
	cmp BYTE [rsi], 0
	je _strcat_loop2_end

	;; If not reached, copy
	;; the byte
	mov BYTE dl, [rsi]
	mov BYTE [rdi], dl

	;; Increment both address'
	inc rsi
	inc rdi

	;; Jump back to loop
	jmp _strcat_loop2
_strcat_loop2_end:
	;; Add null byte to the end
	;; in destiny address
	mov BYTE [rdi], 0

	;; Restore registers
	pop rdx
	pop rsi
	pop rdi

	;; Move destiny address
	;; to rax as return value
	mov rax, rdi

	;; Restore rbp
	pop rbp

	;; Return from function
	ret
	
