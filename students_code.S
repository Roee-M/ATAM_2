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
    
    # GET PATH #
    pushq %rdi # saving parameter *codeword
    mov path(%rip), %rdi # moving parameter to rdi
    call get_path
    
    # OPEN THE FILE #
    mov path(%rip), %rdi
    mov $2,%rax
    xor %rsi,%rsi # rsi = 0 for reading only
    syscall
    
    # READ THE FILE - THE NUMBER #
    mov %rax, %rdi # RDI now is the descriptor of the FILE
    mov $1, %rdx 
    mov path(%rip), %rsi
    mov $0, %r9 # r9 is the offset
    read_till_a: 
        mov $0, %rax
        add %r9, %rsi 
        syscall 
        inc %r9  
        cmp $0xa, (%rsi)
        jne read_till_a

    # finish_read_till_a #
    movb $0x00, (%rsi) # adding null termination
    
    # CALLING ATAM_ATOL #
    pushq %rdi  # caller convention - rdi is the descriptor of the FILE
    mov path(%rip), %rdi # parameter
    call atam_atol # after the function - rax is the number of bytes to read - LONG type
    popq %rdi # caller convention - poping the descriptor

    # READ THE FILE - THE codword content #
    mov $1, %rdx 
    popq %rsi # retriving the *codeword - mov codeword, %rsi
    mov $0, %r9 # r9 is the offset
    mov %rax, %r8 # the number of bytes to read is now in r8
    read_to_codeword: 
        mov $0, %rax
        add %r9, %rsi # we read to rsi + r9
        syscall 
        inc %r9 # inc the index
        cmp %r9, %r8 
        ja read_to_codeword # while  r9 < r8
    # finish_read_to_codeword #        
    
    # CLOSING THE FILE #
    mov $3, %rax 
    syscall
    
    # calculating the num_of_buyes/8 #
    shr %r8
    shr %r8
    shr %r8
    mov %r8, %rax
    
    ##EPILOGUE##
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
