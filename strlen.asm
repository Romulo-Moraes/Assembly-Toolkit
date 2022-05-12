; Get string size in stack memory
;
; Input: String address in RDI
;
; Output: String size in RAX


strlen:
  push rdi

  ; Set zero to count
  xor rcx,rcx

strlen_step:

  ; Check if byte is not null
  cmp [rdi],byte 0

  ; If null, is the end of array, exit 
  jz strlen_exit

  ; If not next char and increment count
  inc rdi
  inc rcx

  ; Go back to loop
  jmp strlen_step

strlen_exit:
  xor rdi,rdi
  pop rdi

  ; Move result to rax then exit
  mov rax,rcx
  ret

