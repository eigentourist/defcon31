.arch armv8-a

.global distance // Allow function to be called by others

distance:
    str lr, [sp, #-16]!

    ldp s0, s1, [x0], #8
    ldp s2, s3, [x0]

    fsub s4, s2, s0
    fsub s5, s3, s1

    fmul s4, s4, s4
    fmul s5, s5, s5

    fadd s4, s4, s5
    fsqrt s4, s4

    fmov w0, s4
    ldr lr, [sp], #16
    ret

