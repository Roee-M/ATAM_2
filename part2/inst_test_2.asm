.global _start

.section .data
msg1: .ascii "start\n"
endmsg:

.section .text

_start:
  movq $1, %rax
  movq $1, %rdi
  leaq msg1, %rsi
  movq $endmsg-msg1, %rdx
  syscall

  .short 0x040f #ILLEGAL (and remember little endian when you read it)

  movq $60, %rax
  syscall
