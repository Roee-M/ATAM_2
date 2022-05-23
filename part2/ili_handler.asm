.globl my_ili_handler

.text
.align 4, 0x90
my_ili_handler:
	# Prolog #
	
	pushq %rbp
	movq %rsp, %rbp

	pushq %r8	
	movq 8(%rbp), %r8 # keep rip, that saved on stack, in r8.

	pushq %r9
	pushq %r10
	pushq %r11
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	pushq %rax
	pushq %rbx
	pushq %rcx
	pushq %rdx	
	pushq %rdi
	pushq %rsi
	
	xor %rdi, %rdi	
	cmpb $0xf, (%r8)
	je opcode_is_two_bytes

opcode_is_one_byte:
	movb (%r8), %dil
	jmp calling_what_to_do

opcode_is_two_bytes:
	movb 1(%r8), %dil

calling_what_to_do:
	call what_to_do
	cmp $0,%rax
	jne our_treatment_routine

original_treatment_routine:
	# Epilog #
	popq %rsi
	popq %rdi
	popq %rdx
	popq %rcx
	popq %rbx	
	popq %rax
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %r11
	popq %r10
	popq %r9
	popq %r8
	popq %rbp

	jmp *old_ili_handler
	jmp end_HW2

our_treatment_routine:
	# Epilog #
	popq %rsi
	popq %rdi
	popq %rdx
	popq %rcx	
	popq %rbx	
	movq %rax, %rdi
	popq %rax
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %r11
	popq %r10
	popq %r9

 	cmpb $0xf, (%r8)
 	je two_b_offset

one_b_offset:
 	popq %r8
  	popq %rbp
 	addq $1, (%rsp)
 	jmp end_HW2
	
two_b_offset:
	popq %r8
	popq %rbp
	addq $2, (%rsp)

end_HW2:
iretq
