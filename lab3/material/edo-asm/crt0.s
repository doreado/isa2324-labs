.section .init, "ax"
.global _start
_start:
    .cfi_startproc
    .cfi_undefined ra
    .option push
    .option norelax
    la gp, __global_pointer$
    .option pop
    la sp, __stack_top
    add s0, sp, zero
    addi x5, x5, 3
    addi x4, x4, 2
    bge x5, x4, test
ma:
    jal ra, main

test:
    addi a1, a1, 2
    bge  a1, x0, ma

el:
    j el
    nop
    nop	
    .cfi_endproc
    .end
