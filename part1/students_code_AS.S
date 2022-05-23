.global hamming_weight, negate_first_k, bring_balance_to_the_word, read_input

.section .bss
.lcomm path, 1024

.section .text
read_input:
        pushq %rbp
        movq %rsp,%rbp
        pushq %rbx
        pushq %r12
        pushq %r13
	subq $16, %rsp

        xor %rbx , %rbx
        xor %r10 , %r10
        xor %r12 , %r12
        xor %r13 , %r13
        xor %rbx , %rbx
        
	movq %rdi , %r9  #r9 -> codeword
	leaq path(%rip), %rdi
	push %rdi
	push %r9
	call get_path
	pop %r9
	pop %rdi
	xor %rsi,%rsi
	movq $0x2,%rax
	syscall

        movq %rax, %rbx #rbx contains the descriptor
	movq %rax,%rdi
	movq $0x1,%rdx
	xor %r10,%r10

        #reading the num
Loop_HW2:
	xor %rax,%rax
	leaq (%rsp,%r10),%rsi
	syscall
	movb (%rsp,%r10), %r12b
	inc %r10	
	cmp $0xa,%r12b
	jne Loop_HW2
	dec %r10
	movb $0,(%rsp,%r10)
	movq %rsp,%rdi
	pushq %r9
	call atam_atol
	popq %r9
	
        #reading and writing to codeword
        movq %rax , %r13  #r13 has the num "n"
        movq %r9,%rsi 
        movq %r13,%rdx
        movq %rbx,%rdi
        xor %rax,%rax
        syscall
       
       #closing the file
        movq $3,%rax
        movq %rbx,%rdi
        syscall
        
        shrq $0x3,%r13
        movq %r13,%rax
        
        addq $16 , %rsp
        popq %r13
        popq %r12
        popq %rbx
        popq %rbp

  ret

hamming_weight:

	xor %r9,%r9 #counter
	xor %r11, %r11
	pushq %rbp
	movq %rsp , %rbp
	pushq %r12

BaseCounting_HW2:
	cmp %r11,%rsi
	jz end_HW2 
	xor %r10,%r10
	mov $64,%r10
	leaq (%rdi,%r11,8), %r12
	movq (%r12),%r12		
InnerCounting_HW2:
	test %r10,%r10
	jz IncreaseBaseCounting_HW2 
	dec %r10	
	shr %r12
	jc Carry_HW2
	jmp InnerCounting_HW2
Carry_HW2:
	inc %r9
	jmp InnerCounting_HW2

IncreaseBaseCounting_HW2:
	inc %r11
	jmp BaseCounting_HW2
	
end_HW2:
	popq %r12
	popq %rbp
	movq %r9 , %rax
  ret

negate_first_k:	
	xor %r9 , %r9
	inc %r9
ShiftLoop_HW2:
	test %rsi , %rsi
	jz endNegate_HW2	
	shl %r9
	dec %rsi
	jmp ShiftLoop_HW2
endNegate_HW2:
	dec %r9
	xor %r9 , %rdi
	mov %rdi , %rax
  ret

bring_balance_to_the_word:
	pushq %rbp
	movq %rsp , %rbp
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	xor %r9, %r9 #result
	xor %r10, %r10 #n/8 holds value
	xor %r12, %r12 #length / 2
	xor %r13, %r13 #base address
	xor %r14, %r14 #k counter
	xor %r15, %r15 # counts until %r10
	mov %rsi, %r12
	sal $5, %r12
	inc %r14
	mov %rdi, %r13
	mov %rsi, %r10

balanceLoop_HW2:
	movq (%r13, %r15, 8), %rdi
check_balance_HW2:
	pushq %r9
	pushq %r10
	pushq %rdi
	mov %r13, %rdi
	mov %r10, %rsi	
	call hamming_weight
	popq %rdi #hozer
	popq %r10
	popq %r9
	cmp %rax, %r12
	je end_balance_HW2

	
inner_balance_loop_HW2:
	cmp $65, %r14
	je skip_inner_loop_HW2
	movq %r14, %rsi
	pushq %rdi
	pushq %r10
	pushq %r9
	call negate_first_k
	popq %r9
	popq %r10
	popq %rdi #hozer
	movq %rax, (%r13, %r15, 8)
	inc %r14
	inc %r9
	jmp check_balance_HW2
	
skip_inner_loop_HW2:
	movq $1, %r14
	inc %r15
	jmp balanceLoop_HW2	


end_balance_HW2:
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbp
	mov %r9, %rax
	
	
  ret
