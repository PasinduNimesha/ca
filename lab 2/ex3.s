.data
n:             .word        12       # Number of Fibonacci numbers to generate
f0:            .word         0       # First Fibonacci number
f1:            .word         1       # Second Fibonacci number
array:         .word         0       # Array to store Fibonacci numbers

.text
.globl main

main:
    la t0, array         # Load address of the array into t0
    lw t4, n             # Load the value of n into t4
    lw t1, f0            # Load the value of the first Fibonacci number into t1
    lw t2, f1            # Load the value of the second Fibonacci number into t2
    
    sw t1, 0(t0)         # Store the first Fibonacci number in the array
    add t3, t1, x0       # Prepare for printing the first Fibonacci number
    addi t4, t4, -1      # Decrement the loop counter
    sw t2, 0(t0)         # Store the second Fibonacci number in the array
    add t3, t2, x0       # Prepare for printing the second Fibonacci number
    addi t4, t4, -1      # Decrement the loop counter
    
loop:
    add t3, t2, t1       # Calculate the next Fibonacci number
    add t1, t2, x0       # Shift t1 to the next Fibonacci number
    add t2, t3, x0       # Shift t2 to the next Fibonacci number
    sw t3, 0(t0)         # Store the calculated Fibonacci number in the array
    addi t0, t0, 4       # Move to the next position in the array
    addi t4, t4, -1      # Decrement the loop counter

    bnez t4, loop        # Branch to loop if t4 != 0
    j end                # Jump to the end
   
end:
    ret                  # Return from the main function



