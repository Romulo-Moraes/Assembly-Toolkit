%include "headers.asm"

segment .data
  message db "Hello world!",0xa,0
  message_sz equ $-message
segment .bss
  count resw 1
segment .text
  global _start

_start:
  ; Set 0 to count register
  xor rcx,rcx
  
  ; Jump to while loop
  jmp while_loop
  

while_loop:

  ; Save the count number in an variable
  mov [count],rcx

  ; Syscall to print hello world in terminal
  mov rax,SYS_WRITE
  mov rdi,STDOUT
  mov rsi,message
  mov rdx,message_sz
  syscall
  
  ; Set 0 to counter register again
  xor rcx,rcx

  ; Move the saved count number to rcx
  mov rcx,[count]

  ; increment a number in rcx counter
  inc rcx

  ; compare to check if is less than 4
  cmp rcx,4
  
  ; if yes just do it again
  jl while_loop

  ; if not just syscall to exit
  mov rax,SYS_EXIT
  mov rdi,0
  syscall

  
