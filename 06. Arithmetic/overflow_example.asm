	segment .text
	global _start

_start:
	; an unsigned byte can support values between
	; 0 and 255.
	; In this code, if al is 128, the message 'Overflow!!'
	; will be printed.
	; Using any number that doesn't result in an overflow
	; at the end (i.e 0 - 127), the message 'Not overflow!'
	; will be printed
	mov al, 128
	mov bl, 2
	mul bl

	; if an overflow didn't occur, jump to...
	jnc jump_not_overflow

	; if the program reaches here, then
	; an overflow happened.

	; print a message saying it
	mov rax, 1
	mov rdi, 1
	mov rsi, msg
	mov rdx, msg.sz
	syscall

	; Jump to end because we don't want to
	; print two messages
	jmp end
jump_not_overflow:
	; If the program reaches here, a overflow
	; didn't happen

	; Print a message saying it
	mov rax, 1
	mov rdi, 1
	mov rsi, msg2
	mov rdx, msg2.sz

	syscall

end:

	;; Exit the program
	mov rax, 60
	mov rdi, 0

	syscall
	
	segment .rodata
	msg db 'Overflow!!', 0xa, 0x0
	msg.sz equ $-msg
	msg2 db 'Not overflow!', 0xa, 0x0
	msg2.sz equ $-msg2