	.file	"add.c"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	registers  #全局符号 registers
	.bss
	.align	2
	.type	registers, @object
	.size	registers, 12
registers:
	.zero	12
	.text
	.align	2
	.globl	ADD
	.type	ADD, @function



ADD:
	# please start your code
    # r1:a0 r2:a1 rd:a3

	lui a6,%hi(registers)     #lui 只能够加载一个 20 位的立即数（高 20 位）
	addi a6,a6,%lo(registers) #addi 用来加载低 12 位的地址部分

	slli a0,a0,2 #将数组索引转为字节偏移量（乘以 4）， 注意在二进制中左移2位相当于乘以4
	slli a1,a1,2 
	slli a2,a2,2

	#a3 存储的是 registers 数组的起始地址
	add a0, a6, a0 #a0 现在保存的是 registers[a0] 的具体地址
	add a1, a6, a1 #registers[a1] 的地址
	add a2, a6, a2 #registers[a2] 的地址

	lw a0,0(a0) #从 地址 a0 指向的内存位置加载一个 4 字节（偏移量是0）的数据到寄存器 a0
	lw a1,0(a1) 

	add a6, a0, a1 

	sw a6, 0(a2) #将 a3 中的值存储到地址 registers[a2] 中

	li a0, 0   #optional
	jr ra      #jr 是跳转指令，ra 是返回地址寄存器（Return Address Register）

	.size	ADD, .-ADD
	.section	.rodata
	.align	2



.LC0:
	.string	"Test 1: ADD"
	.align	2
.LC1:
	.string	"Pass"
	.align	2
.LC2:
	.string	"Fail"
	.align	2
.LC3:
	.string	"Test 2: ADD"
	.align	2
.LC4:
	.string	"Test 3: ADD"
	.align	2
.LC5:
	.string	"Do not include overflow detection: ADD"
	.align	2
.LC6:
	.string	"You have included it, remove it!!!"
	.align	2
.LC7:
	.string	"You haven't included it, good job!!!"
	.align	2
.LC8:
	.string	"End of test"
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	lui	a5,%hi(registers)
	addi	a5,a5,%lo(registers)
	li	a4,1
	sw	a4,0(a5)
	lui	a5,%hi(registers)
	addi	a5,a5,%lo(registers)
	li	a4,2
	sw	a4,4(a5)
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	puts
	li	a2,2
	li	a1,1
	li	a0,0
	call	ADD
	mv	a5,a0
	bne	a5,zero,.L4
	lui	a5,%hi(registers)
	addi	a5,a5,%lo(registers)
	lw	a4,8(a5)
	li	a5,3
	bne	a4,a5,.L4
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	puts
	j	.L5
.L4:
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	puts
.L5:
	lui	a5,%hi(registers)
	addi	a5,a5,%lo(registers)
	li	a4,1001
	sw	a4,0(a5)
	lui	a5,%hi(registers)
	addi	a5,a5,%lo(registers)
	li	a4,-2
	sw	a4,4(a5)
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	puts
	li	a2,2
	li	a1,1
	li	a0,0
	call	ADD
	mv	a5,a0
	bne	a5,zero,.L6
	lui	a5,%hi(registers)
	addi	a5,a5,%lo(registers)
	lw	a4,8(a5)
	li	a5,999
	bne	a4,a5,.L6
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	puts
	j	.L7
.L6:
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	puts
.L7:
	lui	a5,%hi(registers)
	addi	a5,a5,%lo(registers)
	li	a4,-222
	sw	a4,0(a5)
	lui	a5,%hi(registers)
	addi	a5,a5,%lo(registers)
	li	a4,-98
	sw	a4,4(a5)
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	puts
	li	a2,2
	li	a1,1
	li	a0,0
	call	ADD
	mv	a5,a0
	bne	a5,zero,.L8
	lui	a5,%hi(registers)
	addi	a5,a5,%lo(registers)
	lw	a4,8(a5)
	li	a5,-320
	bne	a4,a5,.L8
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	puts
	j	.L9
.L8:
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	puts
.L9:
	lui	a5,%hi(registers)
	addi	a5,a5,%lo(registers)
	li	a4,-2147483648
	xori	a4,a4,-1
	sw	a4,0(a5)
	lui	a5,%hi(registers)
	addi	a5,a5,%lo(registers)
	li	a4,1
	sw	a4,4(a5)
	lui	a5,%hi(.LC5)
	addi	a0,a5,%lo(.LC5)
	call	puts
	li	a2,2
	li	a1,1
	li	a0,0
	call	ADD
	mv	a4,a0
	li	a5,1
	bne	a4,a5,.L10
	lui	a5,%hi(registers)
	addi	a5,a5,%lo(registers)
	lw	a4,8(a5)
	li	a5,-2147483648
	bne	a4,a5,.L10
	lui	a5,%hi(.LC6)
	addi	a0,a5,%lo(.LC6)
	call	puts
	j	.L11
.L10:
	lui	a5,%hi(.LC7)
	addi	a0,a5,%lo(.LC7)
	call	puts
.L11:
	lui	a5,%hi(.LC8)
	addi	a0,a5,%lo(.LC8)
	call	puts
	li	a5,0
	mv	a0,a5
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.ident	"GCC: (SiFive GCC 10.1.0-2020.08.2) 10.1.0"
