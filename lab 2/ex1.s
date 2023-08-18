.data
N:        .word        12
A:        .word        0, 1, 2, 7, -8, 4, 5, 12, 11, -2, 6, 3
B:        .word        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
newline:  .string      "\n"

.text
.globl main

main:
    li a2, 2
    la t0, A       # Load address of vector A into t0
    la t1, B       # Load address of vector B into t1
    lw t2, N       # Load N into t2

loop:
    lw t3, 0(t0)   # Load the current element of A into t3
    bgtz t3, check_positive  # Branch to check_positive if t3 > 0

next_iteration:
    addi t2, t2, -1  # Decrement the loop counter
    addi t0, t0, 4   # Move to the next element in A
    bnez t2, loop    # Branch to loop if t2 != 0
    j end

check_positive:
    rem t4, t3, a2     # Compute the remainder of t3 divided by 2
    bnez t4, next_iteration  # If remainder is not zero, skip to next iteration
    
    add a0, a0, t3
    li a7, 1
    ecall
    
    la a0, newline
    li a7, 4
    ecall
    li a0, 0
    
    sw t3, 0(t1)      # Store the even positive number into B
    addi t1, t1, 4    # Move to the next position in B
    j next_iteration  # Continue with the next iteration

end:
    j end

