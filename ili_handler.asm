.globl my_ili_handler

.text
.align 4, 0x90
my_ili_handler:
    ####### Some smart student's code here #######
    # Prolog #
    push %r8
    push %r9
    push %r10
    push %r11
    push %r12
    push %r13
    push %r14
    push %r15
    push %rax
    push %rbx
    push %rcx
    push %rdx
    push %rbp
    push %rsi
    push %rsp

    # rip of the user is in rcx
    mov (%rcx) %rbx
    xor %rdi,%rdi
    cmp 0x0f, %bl
    je opcode_is_two_bytes

    opcode_is_one_byte:
    movb %bl,%dil
    jmp call_what_to_do
    opcode_is_two_bytes:
    movb %bh,%dil
    
    call_what_to_do:
    call what_to_do
    test %rax, %rax
    jnz our_treatment_routine

    original_treatment_routine:
    # Epilog #
	pop %rsp
    pop %rsi
    pop %rbp
    pop %rdx
    pop %rcx
    pop %rbx
    pop %rax
    pop %r15
    pop %r14
    pop %r13
    pop %r12
    pop %r11
    pop %r10
    pop %r9
    pop %r8
    
    
    jmp * old_ili_handler
    iretq

    our_treatment_routine:
    mov %rax, %rdi

    # Epilog #
	pop %rsp
    pop %rsi
    pop %rbp
    pop %rdx
    pop %rcx
    pop %rbx
    pop %rax
    pop %r15
    pop %r14
    pop %r13
    pop %r12
    pop %r11
    pop %r10
    pop %r9
    pop %r8

    iretq
