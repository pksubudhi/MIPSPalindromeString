# read a line and print whether it is a palindrom

main:
    la   $a0, str0       # printf("Enter a line of input: ");
    li   $v0, 4
    syscall

    la   $a0, line
    la   $a1, 256
    li   $v0, 8         # fgets(buffer, 256, stdin)
    syscall             #

	move $a1, $a0
	
	li $t0, 0			# Initialising counter to 0
	
do_loop:				# Finding String length in $t0
	lb $t1, 0($a0)
	beq $t1, $zero, next_part 	# terminates if string ending character reached
	
	addi $t0, $t0, 1	# Incrementing counter
	addi $a0, $a0, 1	# Incrementing address
	b do_loop
	
next_part:
	li $t1, 0			# j=0
	sub $t2, $t0, 2		# k=i-2
	
palin_loop:
	ble $t2, $t1, final_op
	move $t3, $a1
	move $t4, $a1
	add  $t3, $t3, $t1
	add  $t4, $t4, $t2 
	lb $t5, 0($t3)
	lb $t6, 0($t4)
	bne $t5, $t6, no_pal
	addi $t1, $t1, 1
	addi $t2, $t2, -1
	b palin_loop
	
no_pal:
    la   $a0, not_palindrome
    li   $v0, 4
    syscall
    li   $v0, 0          # return 0
    jr   $ra
    
final_op:
    la   $a0, palindrome
    li   $v0, 4
    syscall

    li   $v0, 0          # return 0
    jr   $ra


.data
str0:
    .asciiz "Enter a line of input: "
palindrome:
    .asciiz "palindrome\n"
not_palindrome:
    .asciiz "not palindrome\n"


# line of input stored here
line:
    .space 256
