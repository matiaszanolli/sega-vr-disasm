/* Helper to generate JSR to expansion ROM function */
.section .text
.align 2

/* JSR to slave_work_check at 0x06300000 */
jsr_work_check:
    mov.l   func_addr, r0
    jsr     @r0
    nop

.align 4

func_addr:
    .long   0x06300000
