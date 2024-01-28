segment .text
	global _start
	
_start:
	mov rax, -10
	; The 'idiv' opcode always looks
    ; into 'rax' and 'rdx' to perform
    ; divisions. If the division
    ; is signed, you must use the
    ; 'cqo' opcode. This will set
    ; each bit of 'rdx' to 1 if
    ; the value of the dividend
    ; is negative; otherwise, 0 is used.
	cqo
	mov rbx, 2
	idiv rbx
	
	; rax = -5
	; rdx = 0
	
	; Here, we could theoretically
	; implement a procedure to 
	; transform -5
	; into a printable version and
	; then print the value. However,
	; we'll cover that later. It is
	; crucial to remember that we 
	; can't simply add '0' to -5 with
	; the goal of transforming it
	; into a printable version 
	; because the binary content of
	; -5 and 5 are completely different.
	
	; Due to it being impossible to
	; directly print a negative number,
	; you will learn a new trick.
	
	; The 'neg' opcode negates the 
	; value of 'rax'. If 'rax'
	; originally held the number -5,
	; its contents will now be 5.
	neg rax
	
	; transform it to a printable version
	add rax, '0'
	
	; save it in .bss
	mov [number], rax
	
	; print the value
	mov rax, 1
	mov rdi, 1
	mov rsi, number
	mov rdx, 8
	syscall
	
	; exit the program
	mov rax, 60
	mov rdi, 1
	syscall
	
segment .bss
	number resb 8