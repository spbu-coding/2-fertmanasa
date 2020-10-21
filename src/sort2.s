	.file	"main.c"
	.text
	.p2align 4,,15
	.globl	swap
	.type	swap, @function
swap:
.LFB0:
	.cfi_startproc
	movl	(%rsi), %eax
	addl	(%rdi), %eax
	movl	%eax, (%rdi)
	subl	(%rsi), %eax
	movl	%eax, (%rsi)
	subl	%eax, (%rdi)
	ret
	.cfi_endproc
.LFE0:
	.size	swap, .-swap
	.p2align 4,,15
	.globl	bubblesort
	.type	bubblesort, @function
bubblesort:
.LFB1:
	.cfi_startproc
	testl	%esi, %esi
	jle	.L3
	leal	-1(%rsi), %r10d
	movq	%rdi, %r8
	xorl	%r9d, %r9d
	addq	$1, %r10
	.p2align 4,,10
	.p2align 3
.L7:
	movl	(%r8), %ecx
	movq	%r9, %rdx
	.p2align 4,,10
	.p2align 3
.L6:
	movl	(%rdi,%rdx,4), %eax
	cmpl	%ecx, %eax
	jle	.L5
	addl	%ecx, %eax
	movl	%eax, (%r8)
	subl	(%rdi,%rdx,4), %eax
	movl	%eax, (%rdi,%rdx,4)
	movl	(%r8), %ecx
	subl	%eax, %ecx
	movl	%ecx, (%r8)
.L5:
	addq	$1, %rdx
	cmpl	%edx, %esi
	jg	.L6
	addq	$1, %r9
	addq	$4, %r8
	cmpq	%r9, %r10
	jne	.L7
.L3:
	rep ret
	.cfi_endproc
.LFE1:
	.size	bubblesort, .-bubblesort
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
