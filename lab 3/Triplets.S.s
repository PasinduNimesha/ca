.equ N 4

.data
A: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
newline: .string "\n"

.bss
B: .word 0, 0, 0, 0

.text
.globl main


li s0, 0
li s1, 0
jal main
li a0,0
li a7,93
ecall

main:
    
    la s0, A
    la s1, B
    li s2, N
    
    loop1:
        beq t0, s2, endloop1
        
        addi sp, sp, -16
        sw ra, 0(sp)   
        la a0, A
        mv a1, t1
        jal res_triplet
        addi t0, t0, 1
        addi t1, t1, 3
        sw a0, 0(s1)
        addi s1, s1, 4
        
        li a7, 1
        ecall
        la a0, newline
        li a7, 4
        ecall
        
        j loop1
        
    endloop1:
    li a0 0
    addi sp, sp, 16
    j endloop1

res_triplet:
    addi sp, sp, -16
    sw s0, 0(sp)
    sw s1, 4(sp)
    mv s0, a0
    mv s1, a1

    li t2, 3
    mv s0, a0
    li t3, 0
    li t6, 4
    mul t6, t6, s1
    add s0, s0, t6
    li t5, 0
    loop2:
        beq t3, t2, endloop2   
        lw t4, 0(s0)
        add t5, t5, t4
        addi s0, s0, 4
        addi t3, t3, 1
        j loop2
    

    
    endloop2:
    mv a0, t5
    lw s0, 0(sp)
    lw s1, 4(sp)
    addi sp, sp, 16
    ret