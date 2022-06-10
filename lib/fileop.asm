; These segments need strlen.asm to work


; Create a file with the given name and access mode
;
; Input : File name in RDI, access mode in RSI
;
; Output : Pop the file decriptor in RAX

create_file:
    mov rax,85
    syscall

    ret


; Open a file
;
; Input: file name in RDI
;
; Output: nothing

open_file:
    mov rax,2
    mov rsi,0
    mov rdx,0777q
    syscall

    ret 

; Write into a file
;
; Input: File decriptor in RDI, text in RSI
;
; Output: nothing

write_file:
    call strlen

    mov rdx,rax
    mov rax,1

    syscall

    ret
    
; Read from a file
;
; Input: Put file decriptor in RDI, Store place in RSI and size to read in RDX
;
; Output: nothing

read_file:
    mov rax,0

    syscall

    ret


; Close a file
;
; Input: Put file decriptor in RDI
;
; Output: nothing

close_file:
    mov rax,3
    syscall

    ret 