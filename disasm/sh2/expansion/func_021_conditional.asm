/*
 * func_021_conditional: Phase 1 - Safe Timing Measurement
 * Location: Expansion ROM $300440 (SH2 address: 0x02300440)
 *
 * Master ALWAYS calls func_021_optimized (guarantees correctness).
 * When Slave is idle, ALSO signals new work via COMM7 (parallel execution).
 * COMM6 tracks Master calls for gap analysis.
 *
 * Use this to measure: can Slave keep up with Master?
 *
 * Input: (same as func_021)
 *   R14 = RenderingContext pointer
 *   R7 = loop counter
 *   R8 = data pointer
 *   R5 = output pointer
 *
 * COMM registers used:
 *   COMM6 ($2000402C) = Master call counter (incremented each call)
 *   COMM7 ($2000402E) = Slave work signal (0x16 = vertex transform)
 *
 * Parameter block at $2203E000 (cache-through SDRAM):
 *   +0x00: R14 (context pointer)
 *   +0x04: R7  (loop counter)
 *   +0x08: R8  (data pointer)
 *   +0x0C: R5  (output pointer)
 */

.section .text
.align 2

.global func_021_conditional
func_021_conditional:
    /* Save return address (we'll call func_021_optimized) */
    sts.l   pr,@-r15

    /* Check if Slave is busy (COMM7 != 0) */
    mov.l   .L_comm7_addr,r0        /* R0 = COMM7 address */
    mov.w   @r0,r1                  /* R1 = COMM7 value */
    tst     r1,r1                   /* Test if zero */
    bf      .L_call_optimized       /* Skip signal if Slave busy */

    /* Slave idle - capture params and signal (parallel work) */
    mov.l   .L_param_block,r2       /* R2 = param block address */
    mov.l   r14,@r2                 /* Save R14 (context) */
    mov.l   r7,@(4,r2)              /* Save R7 (loop counter) */
    mov.l   r8,@(8,r2)              /* Save R8 (data pointer) */
    mov.l   r5,@(12,r2)             /* Save R5 (output pointer) */
    mov     #0x16,r1                /* Work signal = 0x16 (vertex transform) */
    mov.w   r1,@r0                  /* COMM7 = 0x16 */

.L_call_optimized:
    /* Increment COMM6 (Master call counter) for timing analysis */
    mov.l   .L_comm6_addr,r0        /* R0 = COMM6 address */
    mov.w   @r0,r1                  /* R1 = current COMM6 */
    add     #1,r1                   /* Increment */
    mov.w   r1,@r0                  /* Write back */

    /* Call func_021_optimized (Master ALWAYS produces result) */
    mov.l   .L_func_addr,r0         /* R0 = func_021_optimized address */
    jsr     @r0                     /* Call it */
    nop                             /* Delay slot */

    /* Restore return address and return */
    lds.l   @r15+,pr                /* Restore PR */
    rts
    nop

/* Literal pool - must be 4-byte aligned */
.align 4
.L_comm7_addr:
    .long   0x2000402E              /* COMM7 address */
.L_param_block:
    .long   0x2203E000              /* Parameter block (cache-through SDRAM) */
.L_comm6_addr:
    .long   0x2000402C              /* COMM6 address */
.L_func_addr:
    .long   0x02300100              /* func_021_optimized address */

/*
 * Size: ~64 bytes (code + literals)
 */
