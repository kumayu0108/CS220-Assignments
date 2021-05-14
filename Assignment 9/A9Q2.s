 .data
v1:		.space 60
v2:		.space 60
m1:   	.asciiz "Give an integer as size of array of floats (n):\n"
m2:		.asciiz "Give n floating point numbers each on separate line:\n"
m3: 	.asciiz "Result:\n"

        .text
        .globl main
main:   li $v0, 4       		# Syscall 4 (print_str)
        la $a0, m1     			# Argument: string m1
        syscall         		# Print the string to input n

        addiu $s3, $ra, 0		# Saving $ra  

        li $v0, 5 				# Syscall 5 (read int) 
        syscall					# Read input n

        addiu $s0, $v0, 0 		# Copy integer n to $s0
        addiu $s1, $v0, 0		# Copy integer n to $s1

        addiu $a1, $s1, 0 		# Argument: n


        li $v0, 4       		# Syscall 4 (print_str)
        la $a0, m2     			# Argument: string m2
        syscall         		# Print the string to give floats

        addiu $t3, $0, 0		# Counter for number of floats
        la $t0, v1				# Load address of first array
        addiu $a0, $t0, 0 		# Argument: address of first array
       	jal gf					# read first array of floats

       	li $v0, 4       		# Syscall 4 (print_str)
        la $a0, m2     			# Argument: string m2
        syscall         		# Print the string to give floats

       	addiu $t3, $0, 0		# Counter for for number of floats
       	la $t0, v2				# Load address of second array
       	addiu $a0, $t0, 0		# Argument: address of second array
       	jal gf					# read second array of floats

       	mtc1 $zero, $f12 		# Set $f12 to zero which is the output register
       	addiu $t3, $0, 0		# Counter for number of products 
		addiu $a0, $s1, 0		# Argument: integer n       	
		la $a1, v1				# Argument: address of first array
		la $a2, v2				# Argument: address of second array
		jal dotp

		li $v0, 4       		# Syscall 4 (print_str)
        la $a0, m3     			# Argument: string m3
        syscall         		# Print the string result

		li $v0, 2				# Print resultant float
		syscall				

		addiu $ra, $s3, 0		# Restoring $ra
			
        jr $ra     				# End main call

gf: 	bne $t3, $a1, readf 	# Check termination of for loop
		jr $ra
readf:	li $v0, 6				# Read a float
		syscall 
		s.s $f0, 0($a0)			# Store it in the array
		addiu $a0, $a0, 4		# Increment the pointer in the array
		addiu $t3, $t3, 1		# Increment the counter
		j gf					# Jump back to start of loop gf

dotp: 	bne $t3, $a0, addf		# Check termination of for loop
		jr $ra
addf:	l.s $f0, 0($a1)			# Load float from first array
		l.s $f1, 0($a2)			# Load float from second array
		mul.s $f2, $f0, $f1 	# Multiply 2 floats
		add.s $f12, $f12, $f2 	# Accumulate the product
		addiu $a1, $a1, 4		# Increment the pointer to data in first array
		addiu $a2, $a2, 4		# Increment the pointer to data in second array
		addiu $t3, $t3, 1		# Increment the counter
		j dotp					# Jump back to start of loop dotp