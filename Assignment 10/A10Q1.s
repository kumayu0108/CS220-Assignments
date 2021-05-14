.data
array:  .space 48
msg1:   .asciiz "Enter n\n"
msg2:   .asciiz "Enter n values in non-descending order:\n"     
msg3:   .asciiz "All Values Taken\n"
msg4:   .asciiz "Element was not found\n"
msg5:   .asciiz "Found element at index "
msg6:   .asciiz " (Considering 0-indexing)\n"
msg7:   .asciiz "Enter element to find\n"

.text
.globl main
main:
    li $v0, 4
    la $a0, msg1
    syscall

    li $v0, 5
    syscall

    add $s0, $v0, $0        # $s0 has "n"

    li $v0, 4
    la $a0, msg2
    syscall

    add $t0, $s0, $0        # $t0 has "n" which would change
    la $t1, array           # t1 has array address which would change on taking inputs
    beq $t0, $0, exit

    loop:                   # reading array
        li $v0, 5           # read int 
        syscall
        sw $v0, 0($t1)
        addi $t1, $t1, 4
        addi $t0, $t0, -1
        bne $t0, $0, loop
    exit:
        li $v0, 4
        la $a0, msg3
        syscall

    li $v0, 4
    la $a0, msg7            #Print enter element string 
    syscall

    li $v0, 5
    syscall                 # element "k" to search in the array
    add $s1, $v0, $0        # s1 has "k"

    add $t0, $0, $0         # t0 is like "left"
    add $t1, $s0, $0        # t1 is like "right"
    la $t2, array           # t2 has array address

    b_search:
        add $t4, $t0, $t1
        sra $t4, $t4, 1     # t4 has index of array[i], i.e. "i"
        sll $t5, $t4, 2     # t5 temporarily contains "4*i"
        add $t6, $t5, $t2   # t6 has address of array[i], i.e. &array[i]
        lw $t5, 0($t6)      # Now, t5 contains array[i]
        beq $t5, $s1, ele_found

        slt $t7, $s1, $t5   # k < array[i]
        bne $t7, $0, decrease_right
        addi $t0, $t4, 1    # Increase "left"
        j check_condition
        decrease_right:     # Decrease "Right"
            add $t1, $t4, $0
        check_condition:
            slt $t3, $t0, $t1
            beq $t3, $0, not_found
            j b_search
    ele_found:
        li $v0, 4
        la $a0, msg5
        syscall

        li $v0, 1           #treating the array 0-indexed 
        add $a0, $t4, $0
        syscall

        li $v0, 4
        la $a0, msg6
        syscall
        j done

    not_found:
        li $v0, 4
        la $a0, msg4
        syscall
    done:
        jr $31