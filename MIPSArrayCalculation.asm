.data
MYARRAY:         .word 3, 5, 5, 3
INPUT_A1_START: .word 0
INPUT_A2_END:   .word 4

Prompt: .asciiz "\n$a2 contains: "
Return: .asciiz "\n"

.text
la $a3, MYARRAY
la $a1, INPUT_A1_START
lw $a1, 0($a1)
la $a2, INPUT_A2_END

# sum the elements a[i] for which i is odd and a[i] is congruent to 1 mod 4
# Leaves a remainder of 1 when divided by 4


#Initialise registers



li $s1, 1       # saves the constant 1 for remainder comparison
li $s2, 2       # saves the constant 2 for division by 2
li $s4, 4       # saves the constant 4 for division / incrementing to the next element

li $t0, 0       # $t0 = 0 = temporary sum register
li $t1, 0       # $t1 = 0 = temporary register that holds the element we are looking at in the array
li $t2, 0       # $t2 = 0 = temporary register that holds the remainder for dividing by 2
li $t3, 0       # $t3 = 0 = temporary register that holds the remainder for dividing by 4


la $t7, 0($a1)  # $t7 = $a1 = first element of the segment
la $t8, 0($a2)  # $t8 = $a2 = index of the last element + 1 but also result end register
la $t9, 0($a3)  # $t9 = $a3 = input to the program = address to first element = 0






loop:
    bge $t9, $t8, end_loop      # End the loop if the current index is greater or equal to last index
    lw $t1, 0($t9)              # Load the element of the array in $t1
    add $t9, $t9, $s4           # increment the index to the next element before branching
    j check_odd


check_odd:
    div $t1, $s2                # divide $a3 by 2
    mfhi $t2                    # load the remainder into register $t2
    bne $s1, $t2 loop
    j check_congruency

check_congruency:
    div $t1, $s4                # divide $a3 by 2
    mfhi $t3                    # load the remainder into register $t3
    bne $s1, $t3 loop
    j add_sum

add_sum:
    add $t0, $t0, $t1       # add $t1to the $t0 register
    j loop


end_loop:
    move $a2, $t0              # load the $t0 temp sum register into $a2
    li $v0, 1       # System call for print_integer
    move $a0, $a2   # Move the value in $a2 to $a0
    syscall





