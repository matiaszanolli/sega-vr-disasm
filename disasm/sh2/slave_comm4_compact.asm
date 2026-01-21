/*
 * Slave SH2 COMM4 Detector - COMPACT VERSION
 * Fits in exactly 18 bytes by optimizing the loop structure
 *
 * Location: ROM $02050C (SH2: 0x0602050C)
 * Size: Exactly 18 bytes (9 words)
 *
 * Strategy: Use tighter loop with shared register usage
 */

.section .text

.global slave_comm4_compact
slave_comm4_compact:
    /* Load base address for both COMM2 and COMM4 */
    mov.l   .L_comm2_addr,r0        /* D002: R0 = 0x20004024 (COMM2) */
    mov     #0,r2                   /* E200: R2 = 0 (work counter) */

work_loop:
    /* Check COMM4 (at offset +4 from COMM2) */
    mov.l   @(4,r0),r1              /* 5014: R1 = COMM4 */
    tst     r1,r1                   /* 2118: Test if zero */
    bt      work_loop               /* 8BFC: Loop if no work (T=1) */
    nop                             /* 0009: Delay slot */

    /* Work found - increment and write COMM2 */
    add     #1,r2                   /* 7201: counter++ */
    mov.l   r2,@r0                  /* 2022: Write to COMM2 */
    bra     work_loop               /* AFF8: Continue checking */
    nop                             /* 0009: Delay slot */

.align 4
.L_comm2_addr:
    .long   0x20004024              /* COMM2 address */

/*
 * Size calculation:
 * - mov.l @(PC),r0  : 2 bytes
 * - mov #0,r2       : 2 bytes
 * - mov.l @(4,r0),r1: 2 bytes
 * - tst r1,r1       : 2 bytes
 * - bt -4           : 2 bytes
 * - nop             : 2 bytes
 * - add #1,r2       : 2 bytes
 * - mov.l r2,@r0    : 2 bytes
 * - bra -10         : 2 bytes
 * - nop             : 2 bytes
 * - .long addr      : 4 bytes
 * Total: 24 bytes
 *
 * STILL TOO BIG! Need 18 bytes, have 24.
 *
 * Problem: The loop structure with two branches is inefficient.
 * Solution: Eliminate one of the NOPs or restructure completely.
 *
 * Let me try a different approach: eliminate the delay slot NOP
 * by putting useful work in the delay slot.
 */
