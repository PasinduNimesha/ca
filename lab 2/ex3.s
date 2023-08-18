.data
n:             .word        12
f0:            .word         0
f1:            .word         1
array:         .word         0


.text
.globl main

main:  
    la t0, array 
    lw t4, n
    lw t1, f0 
    lw t2, f1
    
    sw t1, 0(t0)
    add t3, t1, x0
    addi t4, t4, -1
    sw t2, 0(t0)
    add t3, t2, x0
    addi t4, t4, -1
    

loop:
    add t3, t2, t1
    add t1, t2, x0
    add t2, t3, x0
    sw t3, 0(t0)
    addi t0, t0, 4
    addi t4, t4, -1

    bnez t4, loop
    j end
   
end:
    ret