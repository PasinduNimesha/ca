.data
N:        .word        12
A:        .word        2, 3, 5, -7, 8, -4, 6, 13, -11, 2, 5, 1
B:        .word        0, 1, 2, 7, -8, 4, 5, 12, 11, -2, 6, 3
C:        .word        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
newline:  .string      "\n"

.text
.globl main

main:
    li a2, 2
    la t0, A    # Load address of vector A into t0
    la t1, B    # Load address of vector B into t1
    la t2, C    # Load address of vector B into t2
    lw t3, N    # Load N into t3

loop:
    lw t4, 0(t0)        # Load the current element of A into t4
    lw t5, 44(t1)
    
    add t6, t4, t5
    sw t3, 0(t6)
    j next_iteration    # Branch to check_positive if t3 > 0

next_iteration:
    addi t3, t3, -1    # Decrement the loop counter
    addi t0, t0, 4     # Move to the next element in A
    addi t1, t1, -4    # Move to the next element in B
    
    add a0, a0, t6
    li a7, 1
    ecall
    
    la a0, newline
    li a7, 4
    ecall
    li a0, 0
    
    bnez t3, loop    # Branch to loop if t3 != 0
    j end


end:
    j end