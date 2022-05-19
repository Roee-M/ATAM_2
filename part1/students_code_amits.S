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
	call get_path
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
    and %rdi, %r8
    and %rdi, %r9
    not %r9
    add %r8, %r9
    mov %r9, %rax
    
    ##EPILOGUE##
    movq %rbp, %rsp
    popq %rbp  
    ret

# parameters: rdi = unsigned long* codeword ; rsi = unsigned long len #
bring_balance_to_the_word:
    # calee convention -PROLOGUE #
    pushq %rbp
    movq %rsp, %rbp
    pushq %r12
    pushq %r13
    pushq %r14
    pushq %r15
    pushq %rbx

    movq %rdi, %r11 # r11 keep the address of codeword

    movq %rsi, %r14
    shr %r14 # r14 is len/2
    
    # check if the word is alrady balanced #
    movq $0, %r12 
    call hamming_weight
    cmp %rax, %r14
    je finish_balance     

    
    inc %r12 # r12 is the loop index "i"
    balance_loop:
        # do not on the first i bits #
        pushq %rsi
        mov %r12, %r13 # r13 is the index of not_on_8_bytes_loop
        xor %rbx, %rbx # rbx is the offset relative to codeword*
        not_on_8_bytes:
            cmp $0, %r13
            jbe out_not_loop # jump r13 <= 0

            # r15 is the minimum of 64,r13 #
                cmp $64, %r13 
                jb r13_smaller_then_64 # jump r13 < 64
                jmp r13_bigger_then_64 # jump r13 >= 64
                
                r13_smaller_then_64:
                mov %r13, %r15
                jmp after_min_opration
                r13_bigger_then_64:
                mov $64, %r15

            after_min_opration:
            mov %r15, %rsi # param k = i
            mov (%r11,%rbx, 8), %rdi
            pushq %r11
            call negate_first_k
            popq %r11
            movq %rax, (%r11,%rbx, 8)

            inc %rbx
            sub $64, %r13
            jmp not_on_8_bytes

        out_not_loop: 
        pop %rsi
        
        # check if the word is balanced #
        call hamming_weight
        cmp %rax, %r14
        je finish_balance 

        inc %r12
        jmp balance_loop

    finish_balance:
    mov %r12, %rax

    # EPILOGUE #
    popq %r12
    popq %r13
    popq %r14
    popq %r15
    popq %rbx
    movq %rbp, %rsp
    popq %rbp  
    ret

