/*
 * func_021_conditional_v2: Phase 2 - Full Skip When Safe
 * Location: Expansion ROM $300480 (SH2 address: 0x02300480)
 *
 * If COMM5 >= COMM6 → Slave ahead → skip Master work, use Slave result
 * Else → Slave behind → Master does work, signal Slave if idle
 *
 * CRITICAL: Only use after Phase 1 confirms Slave can keep up!
 *
 * Input: (same as func_021)
 *   R14 = RenderingContext pointer
 *   R7 = loop counter
 *   R8 = data pointer
 *   R5 = output pointer
 *
 * COMM registers used:
 *   COMM5 ($2000402A) = Slave completion counter
 *   COMM6 ($2000402C) = Master call counter
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

.global func_021_conditional_v2
func_021_conditional_v2:
    /* Save return address */
    sts.l   pr,@-r15

    /* Read COMM6 (Master call count) */
    mov.l   .L2_comm6_addr,r0       /* R0 = COMM6 address */
    mov.w   @r0,r1                  /* R1 = COMM6 value */

    /* Read COMM5 (Slave completions) */
    mov.l   .L2_comm5_addr,r0       /* R0 = COMM5 address */
    mov.w   @r0,r0                  /* R0 = COMM5 value */

    /* Is Slave caught up? (COMM5 >= COMM6) */
    cmp/hs  r1,r0                   /* T = (R0 >= R1) unsigned */
    bf      .L2_master_path         /* Branch if Slave behind */

.L2_slave_ahead:
    /* Slave ahead - signal next work, skip Master computation */
    mov.l   .L2_param_block,r2      /* R2 = param block address */
    mov.l   r14,@r2                 /* Save R14 */
    mov.l   r7,@(4,r2)              /* Save R7 */
    mov.l   r8,@(8,r2)              /* Save R8 */
    mov.l   r5,@(12,r2)             /* Save R5 */

    mov.l   .L2_comm7_addr,r2       /* R2 = COMM7 address */
    mov     #0x16,r0                /* Work signal */
    mov.w   r0,@r2                  /* COMM7 = 0x16 */

    /* Increment COMM6 */
    mov.l   .L2_comm6_addr,r0       /* R0 = COMM6 address */
    add     #1,r1                   /* R1 = COMM6 + 1 */
    mov.w   r1,@r0                  /* Write COMM6 */

    /* Return - Slave result already in buffer */
    lds.l   @r15+,pr                /* Restore PR */
    rts
    nop

.L2_master_path:
    /* Slave behind - Master does work */
    /* First increment COMM6 */
    mov.l   .L2_comm6_addr,r0       /* R0 = COMM6 address */
    add     #1,r1                   /* R1 = COMM6 + 1 */
    mov.w   r1,@r0                  /* Write COMM6 */

    /* Call func_021_optimized */
    mov.l   .L2_func_addr,r0        /* R0 = func_021_optimized */
    jsr     @r0                     /* Call it */
    nop                             /* Delay slot */

    /* Restore and return */
    lds.l   @r15+,pr                /* Restore PR */
    rts
    nop

/* Literal pool - must be 4-byte aligned */
.align 4
.L2_comm6_addr:
    .long   0x2000402C              /* COMM6 address */
.L2_comm5_addr:
    .long   0x2000402A              /* COMM5 address */
.L2_param_block:
    .long   0x2203E000              /* Parameter block address */
.L2_comm7_addr:
    .long   0x2000402E              /* COMM7 address */
.L2_func_addr:
    .long   0x02300100              /* func_021_optimized address */

/*
 * Size: ~80 bytes (code + literals)
 */
