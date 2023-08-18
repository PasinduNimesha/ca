.data
N:        .word        12           # Number of elements in the arrays
A:        .word        2, 3, 5, -7, 8, -4, 6, 13, -11, 2, 5, 1   # Array A
B:        .word        0, 1, 2, 7, -8, 4, 5, 12, 11, -2, 6, 3    # Array B
C:        .word        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0        # Array C to store results
newline:  .string      "\n"          # Newline string for printing

.text
.globl main

main:
    li a2, 2            # Load the divisor (2) for checking even numbers
    la t0, A            # Load address of array A into t0
    la t1, B            # Load address of array B into t1
    la t2, C            # Load address of array C into t2
    lw t3, N            # Load the number of elements into t3

loop:
    lw t4, 0(t0)        # Load the current element of array A into t4
    lw t5, 44(t1)       # Load the corresponding element of array B into t5 (offset 44 because each element is 4 bytes)

    add t6, t4, t5      # Calculate the sum of A[i] + B[i]
    sw t6, 0(t2)        # Store the result in array C

    j next_iteration     # Jump to next_iteration

next_iteration:
    addi t3, t3, -1     # Decrement the loop counter
    addi t0, t0, 4      # Move to the next element in array A
    addi t1, t1, -4     # Move to the previous element in array B
    addi t2, t2, 4      # Move to the next position in array C

    add a0, a0, t6      # Add the current result to a0 (for printing)
    li a7, 1            # System call number for printing an integer
    ecall               # Make the system call to print

    la a0, newline      # Load the newline string for printing
    li a7, 4            # System call number for printing a string
    ecall               # Make the system call to print

    li a0, 0            # Reset a0 for further iterations

    bnez t3, loop       # Branch to loop if t3 != 0
    j end               # Jump to the end

end:
    ret
