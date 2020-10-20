	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 10, 15	sdk_version 10, 15, 6
	.globl	_swap                   ## -- Begin function swap
	.p2align	4, 0x90
_swap:                                  ## @swap
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	(%rsi), %eax
	addl	(%rdi), %eax
	movl	%eax, (%rdi)
	subl	(%rsi), %eax
	movl	%eax, (%rsi)
	subl	%eax, (%rdi)
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	_bubblesort             ## -- Begin function bubblesort
	.p2align	4, 0x90
_bubblesort:                            ## @bubblesort
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	testl	%esi, %esi
	jle	LBB1_7
## %bb.1:
	movl	%esi, %r8d
	leaq	-1(%r8), %r9
	xorl	%r10d, %r10d
	movq	%rdi, %rsi
	jmp	LBB1_2
	.p2align	4, 0x90
LBB1_6:                                 ##   in Loop: Header=BB1_2 Depth=1
	incq	%r10
	addq	$4, %rsi
	decq	%r9
	cmpq	%r8, %r10
	je	LBB1_7
LBB1_2:                                 ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB1_5 Depth 2
	movl	(%rdi,%r10,4), %ecx
	xorl	%eax, %eax
	movl	%ecx, %edx
	cmpl	%ecx, %edx
	jge	LBB1_5
	.p2align	4, 0x90
LBB1_4:                                 ##   in Loop: Header=BB1_2 Depth=1
	addl	%edx, %ecx
	movl	%ecx, (%rdi,%r10,4)
	subl	(%rsi,%rax,4), %ecx
	movl	%ecx, (%rsi,%rax,4)
	movl	(%rdi,%r10,4), %edx
	subl	%ecx, %edx
	movl	%edx, (%rdi,%r10,4)
LBB1_5:                                 ##   Parent Loop BB1_2 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	cmpq	%rax, %r9
	je	LBB1_6
## %bb.8:                               ##   in Loop: Header=BB1_5 Depth=2
	movl	4(%rsi,%rax,4), %ecx
	incq	%rax
	cmpl	%ecx, %edx
	jl	LBB1_4
	jmp	LBB1_5
LBB1_7:
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
.subsections_via_symbols
