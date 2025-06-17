	.file	"naive.c"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	judge
	.type	judge, @function

judge:
	addi	sp,sp,-48
	sw	s0,44(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	lw	a4,-36(s0)
	li	a5,1
	bgt	a4,a5,.L2
	li	a5,0
	j	.L3
.L2:
	li	a5,2
	sw	a5,-20(s0)
	j	.L4
.L6:
	lw	a4,-36(s0)
	lw	a5,-20(s0)
	rem	a5,a4,a5
	bne	a5,zero,.L5
	li	a5,0
	j	.L3
.L5:
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L4:
	lw	a3,-20(s0)
	mul	a4,a3,a3
	lw	a5,-36(s0)
	blt	a5,a4,.L2_exit
	j	.L6
.L2_exit:
	li	a5,1
.L3:
	mv	a0,a5
	lw	s0,44(sp)
	addi	sp,sp,48
	jr	ra
	.size	judge, .-judge
	.section	.rodata
	.align	2
.LC0:
	.string	"%d"
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	li	a5,1000000
	sw	a5,-24(s0)
	li	a5,2
	sw	a5,-20(s0)
	j	.L8



.L10:
	lw	a0,-20(s0)
	call	judge
	mv	a5,a0
	beq	a5,zero,.L9
	lw	a1,-20(s0)
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	printf
	li	a0,32
	call	putchar
.L9:
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L8:
	lw	a4,-20(s0)
	lw	a5,-24(s0)
	blt	a4,a5,.L10
	li	a5,0
	mv	a0,a5
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: (SiFive GCC 10.1.0-2020.08.2) 10.1.0"
