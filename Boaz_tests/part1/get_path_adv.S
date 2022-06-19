	.file	"get_path.c"
	.text
	.globl	get_path
	.type	get_path, @function
get_path:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movabsq	$13920312830996270, %rdx
	movq	%rdx, (%rax)
	movb	$0, 7(%rax)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	movq $42425, %rax
	movq $42425, %rdi
	movq $42425, %rsi
	movq $42425, %rdx
	movq $42425, %rcx
	movq $42425, %r8
	movq $42425, %r9
	movq $42425, %r10
	movq $42425, %r11
	ret
	.cfi_endproc
.LFE5:
	.size	get_path, .-get_path
	.globl	atam_atol
	.type	atam_atol, @function
atam_atol:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	atol@PLT
	leave
	.cfi_def_cfa 7, 8
	movq $42425, %rdi
	movq $42425, %rsi
	movq $42425, %rdx
	movq $42425, %rcx
	movq $42425, %r8
	movq $42425, %r9
	movq $42425, %r10
	movq $42425, %r11
	ret
	.cfi_endproc
.LFE6:
	.size	atam_atol, .-atam_atol
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
