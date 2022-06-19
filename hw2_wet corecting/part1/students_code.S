.global hamming_weight, negate_first_k, bring_balance_to_the_word, read_input
.section .bss
.lcomm path, 1024
# .lcomm num_of_bytes_ascii , 16
# .lcomm content 

.section .text
read_input:
    # calee convention -PROLOGUE #
    pushq %rbp
    movq %rsp, %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    pushq %r15
    subq $16, %rsp # allocating memory on the stack
    

    /* not to use: rax, rdi, rsi, rdx, rcx, r8, r9, r10, r11 */
    
    # GET PATH #
    movq %rdi, %rbx # saving parameter *codeword
    leaq path(%rip), %rdi # moving parameter to rdi
    pushq %rdi # saving the start of path
    call get_path
    
    # OPEN THE FILE #
    # movq path(%rip), %rdi
    pop %rdi
    movq $2,%rax
    xor %rsi,%rsi # rsi = 0 for reading only
    syscall
    
    # READ THE FILE - THE NUMBER #
    movq %rax, %r12 # r12 now is the descriptor of the FILE
    movq $0, %r13 # r13 is the offset
  
    read_till_a: 
        movq $0, %rax   
        movq %r12, %rdi
        movq $1, %rdx # number of bytes to read 
        leaq (%rsp, %r13, 1), %rsi
        syscall 
        leaq (%rsp, %r13), %r9
        movb (%r9), %r8b
        cmp $0x0a, %r8b
        je out_read_till_a 
        inc %r13  
        jmp read_till_a

    # finish_read_till_a #
    out_read_till_a:
    lea (%rsp, %r13, 1), %rsi
    movb $0x00, (%rsi) # adding null termination at the end
    
    # CALLING ATAM_ATOL #
    movq %rsp, %rdi # parameter
    call atam_atol # after the function - rax is the number of bytes to read - LONG type

    # READ THE FILE - THE codword content #
    /* mov $0, %r13 # r13 is the offset
    mov %rax, %r15 # the number of bytes to read is now in r8
    read_to_codeword: 
        mov $0, %rax
        movq %r12, %rdi
        movq $1, %rdx # number of bytes to read 
        lea (%rbx, %r13, 1), %rsi 
        syscall 
        inc %r13 # inc the index
        cmp %r13, %r15
        ja read_to_codeword # while  r9 < r8 */
    movq %rax, %r15
    movq %rax, %rdx # number of bytes to read 
    mov $0, %rax
    movq %r12, %rdi
    movq %rbx, %rsi 
    syscall 
    
    # CLOSING THE FILE #
    mov $3, %rax
    movq %r12, %rdi 
    syscall
    
    # calculating the num_of_buyes/8 #
    shr %r15
    shr %r15
    shr %r15
    mov %r15, %rax
    
    ##EPILOGUE##
    popq %rbx
    popq %r12
    popq %r13
    popq %r14
    popq %r15
    movq %rbp, %rsp
    popq %rbp
    ret


# parameters: rdi = unsigned long* codeword ; rsi = unsigned long len #
hamming_weight:
    # calee convention -PROLOGUE #
    pushq %rbp
    movq %rsp, %rbp
    
    xor %r8, %r8 # r8 is the loop index
    xor %rax, %rax # 1-bit counter
    memory_to_register_loop:
        cmp %rsi, %r8
        je finish
        movq (%rdi, %r8, 8), %r9 # r9 is 8 byte section of codeword
        count_1_bits_loop:
            cmp $0, %r9
            je outer_counter
            shr $1, %r9 # the bit is now in the carry flag
            jnc skip_add
            inc %rax
            skip_add: jmp count_1_bits_loop
        outer_counter:
        inc %r8
        jmp memory_to_register_loop
               
    finish:
    # EPILOGUE #
    movq %rbp, %rsp
    popq %rbp
    ret

# rdi = 8 byte codeword ; rsi = k #
negate_first_k:
    # calee convention -PROLOGUE #
    pushq %rbp
    movq %rsp, %rbp
    
    xor %r8, %r8 
    not %r8 # r8 = 111...1
    xor %r9, %r9 # r9 is the counter of the loop 
    fill_k_1s:
        cmp %rsi, %r9
        je out_of_fill_k_1s
        shl %r8
        inc %r9
        jmp fill_k_1s
    out_of_fill_k_1s:
    mov %r8, %r9
    not %r9 
    # r9 is the k-low mask, r8 is the (64-k)-high mask #   
    movq %r9, %r10 # has k bits k-low mask
    and %rdi, %r8
    and %rdi, %r9
    not %r9
    and %r10, %r9 # not for k LSB bits 
    add %r8, %r9
    mov %r9, %rax
    
    # EPILOGUE #
    movq %rbp, %rsp
    popq %rbp  
    ret


# parameters: rdi = unsigned long* codeword ; rsi = unsigned long len #
bring_balance_to_the_word:
	# PROLOGUE #
	pushq %rbp
    movq %rsp, %rbp
	pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    pushq %r15
	
	
	# initialization paremeters #
	xor %r15, %r15
	movq %rdi, %r15 # r15 keep the address of codeword
	
	xor %r14, %r14
	movq %rsi, %r14
	# shr %r14 # r14 is len/2
	sal $5, %r14	

	xor %r13, %r13 # count 8 bits sections
	
	xor %r12, %r12 
	inc %r12 # the loop index "k" for calling negate_first_k
	
	movq %rsi, %r10 # n/8 for calling hamming_weight
	
	xor %r8, %r8 # holds the result
	
	balance_loop:
		movq (%r15,%r13, 8), %rdi
		
		check_if_the_word_is_balanced:
			pushq %rdi
			pushq %r10
			pushq %r8
		    	movq %r15, %rdi
			movq %r10, %rsi
			call hamming_weight
			popq %r8
			popq %r10
			popq %rdi
			cmp %rax, %r14
			je finish_balance 
			
		nagate:
			cmp $65, %r12
			je setup_next_section
			pushq %rdi
			pushq %r10
			pushq %r8
			movq %r12, %rsi
			call negate_first_k
			popq %r8
			popq %r10
			popq %rdi
			inc %r8
			inc %r12
			movq %rax, (%r15, %r13 ,8)
			jmp check_if_the_word_is_balanced
			
		setup_next_section:
			inc %r13
			xor %r12, %r12
			inc %r12
			jmp balance_loop
			
		
	finish_balance:
	mov %r8, %rax
	
	# EPILOGUE #
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	movq %rbp, %rsp
    popq %rbp 
	ret


