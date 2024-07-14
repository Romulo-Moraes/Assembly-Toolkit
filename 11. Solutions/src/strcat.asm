;; strcat - function that concatenates the source str to destiny str
;; 
;; RDI register is used as destiny
;; RSI register is used as source
;; RAX is the return value (contains destiny addr)
;;
;; The function doesn't change the value of RDI and RSI
;; This function uses the dl register to work
;; This function saves and restore the original value of the complete part of dl register


strcat:
	;; save and update rbp
	push rbp
	mov rbp, rsp

	;; save rdi, rsi and rdx
	push rdi
	push rsi
	push rdx

_strcat_loop:
	;; searching for null byte in destiny
	cmp BYTE [rdi], 0
	je _strcat_loop_end

	;; if not found, inc pointer
	inc rdi

	;; jump back to loop
	jmp _strcat_loop
_strcat_loop_end:

	;; loop to copy bytes
	;; from source to destiny
_strcat_loop2:
	;; checking if reached the
	;; end in source
	cmp BYTE [rsi], 0
	je _strcat_loop2_end

	;; if not reached, copy
	;; the byte
	mov dl, [rsi]
	mov [rdi], dl

	;; increment both addresses
	inc rsi
	inc rdi

	;; jump back to loop
	jmp _strcat_loop2
_strcat_loop2_end:
	;; add null byte to the end
	;; of destiny address
	mov BYTE [rdi], 0

	;; restore registers
	pop rdx
	pop rsi
	pop rdi

	;; move destiny address
	;; to rax as return value
	mov rax, rdi

	;; restore rbp
	pop rbp

	;; return from function
	ret
	
