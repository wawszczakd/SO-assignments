	.file	"inverse_permutation.c"
	.text
	.p2align 4
	.globl	inverse_permutation
	.type	inverse_permutation, @function
inverse_permutation:
.LFB0:
	.cfi_startproc
	leaq	-1(%rdi), %rax
	cmpq	$2147483647, %rax
	ja	.L4
	movq	%rsi, %r10
	leaq	(%rsi,%rdi,4), %r8
	movq	%rsi, %rdx
	.p2align 4,,10
	.p2align 3
.L5:
	movslq	(%rdx), %rax
	testl	%eax, %eax
	js	.L4
	cmpq	%rdi, %rax
	jnb	.L4
	addq	$4, %rdx
	cmpq	%rdx, %r8
	jne	.L5
	xorl	%r9d, %r9d
	movl	(%rsi,%r9,4), %eax
	testl	%eax, %eax
	jns	.L25
	.p2align 4,,10
	.p2align 3
.L6:
	leaq	1(%r9), %rax
	cmpq	%rax, %rdi
	je	.L26
	movq	%rax, %r9
	movl	(%rsi,%r9,4), %eax
	testl	%eax, %eax
	js	.L6
.L25:
	movslq	%eax, %rdx
	cmpq	%r9, %rdx
	jne	.L11
	jmp	.L7
	.p2align 4,,10
	.p2align 3
.L8:
	movslq	%eax, %rdx
	addl	$-2147483648, %eax
	movl	%eax, (%rcx)
	cmpq	%r9, %rdx
	je	.L27
.L11:
	leaq	(%rsi,%rdx,4), %rcx
	movl	(%rcx), %eax
	testl	%eax, %eax
	jns	.L8
	.p2align 4,,10
	.p2align 3
.L10:
	movl	(%r10), %eax
	testl	%eax, %eax
	jns	.L9
	addl	$-2147483648, %eax
	movl	%eax, (%r10)
.L9:
	addq	$4, %r10
	cmpq	%r10, %r8
	jne	.L10
.L4:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L27:
	movl	(%rsi,%r9,4), %eax
.L7:
	addl	$-2147483648, %eax
	movl	%eax, (%rsi,%r9,4)
	jmp	.L6
.L26:
	xorl	%edx, %edx
	jmp	.L16
	.p2align 4,,10
	.p2align 3
.L13:
	leaq	1(%rdx), %rax
	cmpq	%rdx, %r9
	je	.L28
	movq	%rax, %rdx
.L16:
	movl	(%rsi,%rdx,4), %eax
	testl	%eax, %eax
	jns	.L13
	addl	$-2147483648, %eax
	movl	%eax, (%rsi,%rdx,4)
	cmpq	%rdx, %rax
	je	.L18
	movq	%rdx, %r8
	.p2align 4,,10
	.p2align 3
.L15:
	leaq	(%rsi,%rax,4), %rcx
	movq	%rax, %rdi
	movl	(%rcx), %eax
	movl	%r8d, (%rcx)
	movq	%rdi, %r8
	addl	$-2147483648, %eax
	cmpq	%rdx, %rax
	jne	.L15
.L14:
	movl	%edi, (%rsi,%rdx,4)
	jmp	.L13
.L28:
	movl	$1, %eax
	ret
.L18:
	movq	%rdx, %rdi
	jmp	.L14
	.cfi_endproc
.LFE0:
	.size	inverse_permutation, .-inverse_permutation
	.ident	"GCC: (Debian 10.2.1-6) 10.2.1 20210110"
	.section	.note.GNU-stack,"",@progbits
