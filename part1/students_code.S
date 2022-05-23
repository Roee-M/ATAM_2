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
    
    ##EPILOGUE##
    movq %rbp, %rsp
    popq %rbp  
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


