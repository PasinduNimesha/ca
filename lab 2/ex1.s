.data
N:        .word        12           # Number of elements in array A
A:        .word        0, 1, 2, 7, -8, 4, 5, 12, 11, -2, 6, 3   # Array A
B:        .word        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0       # Array B to store even positive numbers
newline:  .string      "\n"          # Newline string for printing

.text
.globl main

main:
    li a2, 2            # Load the divisor (2) for checking even numbers
    la t0, A            # Load address of array A into t0
    la t1, B            # Load address of array B into t1
    lw t2, N            # Load the number of elements into t2

loop:
    lw t3, 0(t0)        # Load the current element of A into t3
    bgtz t3, check_positive  # Branch to check_positive if t3 > 0

next_iteration:
    addi t2, t2, -1     # Decrement the loop counter
    addi t0, t0, 4      # Move to the next element in A
    bnez t2, loop       # Branch to loop if t2 != 0
    j end               # Jump to the end

check_positive:
    rem t4, t3, a2      # Calculate the remainder of t3 divided by 2
    bnez t4, next_iteration  # If remainder is not zero, skip to next iteration
    
    add a0, a0, t3      # Add the even positive number to a0 (for printing)
    li a7, 1            # System call number for printing an integer
    ecall               # Make the system call to print
    
    la a0, newline      # Load the newline string for printing
    li a7, 4            # System call number for printing a string
    ecall               # Make the system call to print
    
    li a0, 0            # Reset a0 for further iterations
    
    sw t3, 0(t1)         # Store the even positive number into array B
    addi t1, t1, 4      # Move to the next position in B
    j next_iteration     # Continue with the next iteration

end:
    j end               # Jump to the end


