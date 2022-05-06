.global hamming_weight, negate_first_k, bring_balance_to_the_word, read_input

.section .bss
.lcomm path, 1024
.lcomm num_of_bytes_ascii , 16
#.lcomm content 

.section .text
read_input:
    ##calee convention -PROLOGUE##
    pushq %rbp
    movq %rsp, %rbp
    
    ## GET PATH ##
    pushq %rdi #saving parameter *codeword
    mov (path), %rdi #moving parameter to rdi
    call get_path
    
    ## OPEN THE FILE ##
    mov path,%rdi
    mov $2,%rax
    xor %rsi,%rsi #rsi = 0 for reading only
    syscall
    
    ## READ THE FILE - THE NUMBER ##
    mov %rax, %rdi #RDI now is the descriptor of the FILE
    mov $1, %rdx 
    mov num_of_bytes, %rsi
    mov $0, %r9 #r9 is the offset
    read_till_a: 
        mov $0, %rax
        add %r9, %rsi 
        syscall 
        inc %r9  
        cmp $0xa, (%rsi)
        jne read_till_a

    #finish_read_till_a#
    movb $0x00, (%rsi) #adding null termination
    ## CALLING ATAM_ATOL ##
    pushq %rdi  #caller convention
    mov num_of_bytes, %rdi #parameter
    call atam_atol #after the function - rax is the number of bytes to read - LONG type
    popq %rdi #caller convention - poping the descriptor

    ## GETTING THE NUMBER - BEGGINING OF FILE## 
    mov $1, %rdx 
    pop %rsi #retriving the *codeword - mov codeword, %rsi
    mov $0, %r9 #r9 is the offset
    mov %rax, %r8 # the number of bytes to read is now in r8
    read_to_codeword: 
        mov $0, %rax
        add %r9, %rsi #we read to rsi +r9
        syscall 
        inc %r9 # inc the index
        cmp %r9, %r8 
        jb read_to_codeword #while  r9<r8
    #finish_read_to_codeword#        
    
    
    ## CLOSING THE FILE ##
    mov $3,%rax 
    syscall
    
    
    ##calculating the num_of_buyes/8 ##
    shr %r8
    shr %r8
    shr %r8
    mov %r8,%rax
    
    ##EPILOGUE##
    movq %rbp,%rsp
    popq %rbp
    ret

hamming_weight:
  ret

negate_first_k:
  ret

bring_balance_to_the_word:
  ret
