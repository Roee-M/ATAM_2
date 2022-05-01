.global hamming_weight, negate_first_k, bring_balance_to_the_word, read_input

.section .bss
.lcomm path, 1024
.lcomm # write the loop for reading the NUMBER at the begining of the FILE
.lcomm content 

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
    
    
    
    
    
    
    
    

    
    
    ## GETTING THE NUMBER - BEGGINING OF FILE##
loop:       
    
    
    
    ## CLOSING THE FILE ##
    mov $3,%rax 
    syscall
    
    pop %rdi #retriving the *codeword
    
    
   
    
    
    
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
