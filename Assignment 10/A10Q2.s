.data
array:  .space 60
msg1:   .asciiz "Enter n\n"
msg2:   .asciiz "Enter n values:\n"
msg3:   .asciiz "All Values Taken\n"
msg4:   .asciiz "Required Value "

.text
.globl main
main:
    li $v0, 4
    la $a0, msg1            # print msg1
    syscall

    li $v0, 5               # read n 
    syscall

    add $s0, $v0, $0        # store n in s0 
    add $t0, $v0, $0        # store n in t0 

    beq $s0, $0, exit

    li $v0, 4
    la $a0, msg2
    syscall

    sub.s $f2, $f2, $f2
    add $t1, $0, $0
    loop:
        li $v0, 6
        syscall

        beq $t1, $0, _add
        
        add $t1, $0, $0         # this block will run when element has to be subtracted
        sub.s $f2, $f2, $f0
        addi $t0, $t0, -1
        j done

        _add:                    # this block will run when element has to be added
            addi $t1, $t1, 1
            add.s $f2, $f2, $f0
            addi $t0, $t0, -1
        
        done:
            bne $t0, $0, loop
    exit:
        li $v0, 4
        la $a0, msg3
        syscall

    li $v0, 4
    la $a0, msg4
    syscall

    li $v0, 2
    mov.s $f12, $f2     
    syscall

    jr $31