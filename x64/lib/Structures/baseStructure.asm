segment .rodata

segment .data

segment .bss

segment .text
  global _start

_start:
  mov rax,60
  mov rdi,0
  syscall
