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
			
	cmpb $0xF ,(%r8)
	je opcode_is_two_bytes
	
	xor %rdi,%rdi
	movb (%r8), %dil
	jmp calling_what_to_do

opcode_is_two_bytes:
	xor %rdi , %rdi
	movb 1(%r8), %dil

calling_what_to_do:
	call what_to_do
	cmp $0,%rax
	je GOT_ZERO_HW2
	jmp GOT_NOT_ZERO_HW2
	# ########### jne our_treatment_routine

# ########### original_treatment_routine:
GOT_ZERO_HW2:
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

# ########### our_treatment_routine:
GOT_NOT_ZERO_HW2:
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
	
	cmpb $0xF ,(%r8)
	jne ONE_BYTE_OFFSET_HW2
	
	popq %r8
	popq %rbp
	addq $2,(%rsp)
	jmp RET_HW2

ONE_BYTE_OFFSET_HW2:
	popq %r8
	popq %rbp
	addq $1,(%rsp)


end_HW2:
	iretq




# 	je two_b_offset
# 
# one_b_offset:
# 	popq %r8
#	popq %rbp
#	addq $1,(%rsp)
#	jmp RET_HW2

# two_b_offset:
# 	popq %r8
# 	popq %rbp
#	addq $2,(%rsp)
