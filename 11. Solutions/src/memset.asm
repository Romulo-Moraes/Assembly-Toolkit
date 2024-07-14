; memset - Function that fiils the first x bytes of the given memory area using the given byte
;
; RDI register is used as address to be filled
; RSI register is used as the byte to fill the area
; RDX register is used as the number of bytes to fill
; RAX is the return value (contains the address of the filled area)
;
; the function doesn't change the value of RDI, RSI and RDX
; the function doesn't use any register beyond the specified ones

	%define __MEMSET_COPY_COUNTER 8

memset:
	; save some registers into stack
	push rbp
	push rdi

	; allocate memory in stack frame
	mov rbp, rsp
	sub rsp, 8

	; put zero inside the counter variable
	mov QWORD [rbp-__MEMSET_COPY_COUNTER], 0
memset_loop:
	; compare to check if the counter still
	; less than the value specified by 
	; the function caller
	cmp [rbp-__MEMSET_COPY_COUNTER], rdx

	; if not, jump to end
	jge memset_end

	; if yes, copy the byte to the address
	mov [rdi], sil

	; increment counter and the address
	inc QWORD [rbp-__MEMSET_COPY_COUNTER]
	inc rdi

	; jump to the loop again
	jmp memset_loop
memset_end:
	; deallocate memory in stack frame
	mov rsp, rbp

	; restore registers previously
	; pushed into stack
	pop rdi
	pop rbp

	; copy address of the filled area
    ; to rax as return value
	mov rax, rdi

    ; return from function
	ret
