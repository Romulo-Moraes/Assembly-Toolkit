	%include 'strcmp.asm'

	
	segment .text
	global _start

_start:
	mov rdi, first_string
	mov rsi, second_string

	call strcmp
	
	
	
	mov rax, 60
	mov rdi, 0
	syscall

	segment .rodata
	first_string db 'romulo', 0x0
	second_string db 'romulo', 0x0
