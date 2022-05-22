.globl my_ili_handler

.text
.align 4, 0x90
my_ili_handler:
	# Prolog #

	pushq %rbp
	movq %rsp, %rbp
	    
	# movq (%rbp), %rdi # keep rip, that saved on stack, in rdi.

	pushq %r8
	mov 8(%rsp), %r8 # keep rip, that saved on stack, in r8.
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
	pushq %rbp
	pushq %rsi
	# pushq %rsp
	pushq %rdi # ????? add

	movq (%r8), %rbx # rbx is the opcode low bit
	xorq %rdi, %rdi # Prepares the RDI to be the input of "what_to_do"
	# xorq %rdx, %rdx

	cmpb 0x0f, %bl
	je opcode_is_two_bytes

	opcode_is_one_byte:
	movb (%r8), %dil # ????? was %bl, %dl
	# ??? movq %rdx, %rdi # Prepares the RDI to be the input of "what_to_do"
	jmp call_what_to_do

	opcode_is_two_bytes:
	movb 1(%r8), %dil # ???? movb %bh, %dl
	# movq %rdx, %rdi # Prepares the RDI to be the input of "what_to_do"

	call_what_to_do:
	call what_to_do
	cmpq $0, %rax
	jne our_treatment_routine

	original_treatment_routine:
	# Epilog #
	popq %rdi
	# popq %rsp
	popq %rsi
	popq %rbp
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
	movq %rax, %rdi

	# Epilog #
	popq %rdi # ????	
	# popq %rsp
	popq %rsi	
	popq %rbp
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
