.data
msg:    .asciiz "Enter integer n:"

        .text
        .globl main

fib:    bne $a0, $0, l1         #  return if n==0
        jr $ra

l1:     move $t0, $a0
        move $a0, $a2
        li $v0, 1
        syscall                 # prints integer f1

        li $a0, 32
        li $v0, 11
        syscall                 # prints space

        addi $a0, $t0, -1       # a0 = n-1
        move $t0, $a1
        move $a1, $a2           # a1 = f1
        add $a2, $a1, $t0       # a2 = f0+f1

        addi $sp, $sp, -4
        sw $ra, 0($sp)
        jal fib                 # fib(n-1,f1,f0+f1)

        lw $ra, 0($sp)
        addiu $sp, $sp, 4
        jr $ra                  # return

main:   li $v0, 4
        la $a0, msg
        syscall         	# Prints msg

        li $v0, 5
        syscall                 # Takes input n

        addi $sp, $sp, -4
        addiu $a0, $v0, 0
        li $a1, 0
        li $a2, 1
        sw $ra, 0($sp)
        jal fib                 # fib(n,0,1)

        lw $ra, 0($sp)
        addiu $sp, $sp, 4
        jr $ra                  # ends main