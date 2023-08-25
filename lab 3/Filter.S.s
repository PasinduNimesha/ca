.equ N 6

.data
A: .word 48,64,56,80,96,48
newline: .string "\n"

.bss
B: .word 0, 0, 0, 0, 0, 0

.text
.globl main


jal main
li a0,0
li a7,93
ecall

main:
    addi sp, sp, -16
    la s0, A
    la s1, B
    la s2, N
    mv s3, s2
    
    addi s3, s3, -1
    loop1:
        beq t0, s3, endloop1
        sw ra, 0(sp)
        lw a0, 0(s0)
        lw a1, 4(s0)
        jal myFilter
        addi t0, t0, 1
        bnez a0, if_body
        addi s0, s0, 4
        j loop1
        
        
    if_body:
        lw a0, 0(s0)
        lw a1, 4(s0)
        add a0, a0, a1
        addi a0, a0, 2
        sw a0, 0(s1)
        
        li a7, 1
        ecall
        la a0, newline
        li a7, 4
        ecall
        
        addi s1, s1, 4
        
        
        
        addi s0, s0, 4
        j loop1
        
        
    endloop1:
        li a7, 10
        ecall
        
myFilter:
    addi sp, sp, -16
    sw s0, 0(sp)
    sw s1, 4(sp)
    mv s0, a0
    mv s1, a1
    
    mv a0, s0
    mv t1, s1
    li t3, 16
    remu t4, a0, t3
    sltu t5, a0, t1
    li t6, 1
    sltu t4, t4, t6
    
    and a0, t4, t5
    
    lw s0, 0(sp)
    lw s1, 4(sp)
    addi sp, sp, 16
    ret

