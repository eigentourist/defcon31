.arch armv8-a

.extern distance
.extern printf

.global _start

    .equ n, 3

_start:
    stp x19, x20, [sp, #-16]!
    str lr, [sp, #16]!

    ldr x20, =points
    mov w19, #n

loop:
    mov x0, x20
    bl distance

    fmov s2, w0
    fcvt d0, s2
    fmov x1, d0
    ldr x0, =prtstr
    bl printf

    add x20, x20, #(4*4)
    subs w19, w19, #1
    b.ne loop

    mov x0, #0
    ldr lr, [sp], #16
    ldp x19, x20, [sp], #16
    ret

.data
points:     .single           0.0, 0.0, 3.0, 4.0
            .single           1.3, 5.4, 3,1, -1.5
            .single 1.323e10, -1.2e4, 34.55, 5454.234
prtstr:     .asciz "Distance = %f\n"

