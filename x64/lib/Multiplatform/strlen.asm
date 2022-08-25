; Get string size in memory
;
; Input: String address in RSI
;
; Output: String size in RAX


strlen:
  push rsi

  ; Set zero to count
  xor rcx,rcx

strlen_step:

  ; Check if byte is not null
  cmp [rsi],byte 0

  ; If null, is the end of array, exit 
  jz strlen_exit

  ; If not, next char and increment count
  inc rsi
  inc rcx

  ; Go back to loop
  jmp strlen_step

strlen_exit:
  xor rsi,rsi
  pop rsi

  ; Move result to rax then return function call
  mov rax,rcx
  ret

