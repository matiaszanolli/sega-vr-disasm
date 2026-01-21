/*
 * Slave SH2 COMM4 Poll-Only Test
 * Ultra-compact: increment COMM2 only when COMM4 is non-zero
 *
 * Location: ROM $02050C (SH2: 0x0602050C)
 * Size: Exactly 18 bytes (9 words)
 *
 * Behavior:
 * - COMM4 = 0: COMM2 unchanged (idle)
 * - COMM4 != 0: COMM2 increments rapidly
 *
 * This is the SIMPLEST possible test of work distribution
 */

.section .text

.global slave_comm4_poll_only
slave_comm4_poll_only:
    mov.l   .L_comm2,r0             /* D002: R0 = COMM2 addr */
    mov     #0,r2                   /* E200: R2 = counter */

poll_loop:
    mov.l   @(4,r0),r1              /* 5014: R1 = COMM4 (offset +4) */
    tst     r1,r1                   /* 2118: Test if zero */
    bt      poll_loop               /* 8BFC: Loop back if zero */
    add     #1,r2                   /* 7201: counter++ (in delay slot!) */
    mov.l   r2,@r0                  /* 2022: Write COMM2 */
    bra     poll_loop               /* AFFA: Loop back */
    nop                             /* 0009: Delay slot */

.align 4
.L_comm2:
    .long   0x20004024              /* COMM2 address */

/*
 * Size calculation:
 * - mov.l @(PC),r0    : 2 bytes (D002)
 * - mov #0,r2         : 2 bytes (E200)
 * - mov.l @(4,r0),r1  : 2 bytes (5014)
 * - tst r1,r1         : 2 bytes (2118)
 * - bt -4             : 2 bytes (8BFC)
 * - add #1,r2         : 2 bytes (7201) [delay slot]
 * - mov.l r2,@r0      : 2 bytes (2022)
 * - bra -8            : 2 bytes (AFFA)
 * - nop               : 2 bytes (0009)
 * - .long addr        : 4 bytes
 * Total: 22 bytes
 *
 * STILL 4 BYTES OVER! The issue is the address literal takes 4 bytes.
 *
 * Final optimization: Use immediate load if possible, or accept redirect
 *
 * Let me try using the delay slot more efficiently:
 */

.global slave_comm4_ultra_compact
slave_comm4_ultra_compact:
    mov.l   .L_base,r0              /* D001: R0 = COMM2 */

ultra_loop:
    mov.l   @(4,r0),r1              /* 5014: COMM4 */
    mov.l   @r0,r2                  /* 6202: COMM2 current */
    tst     r1,r1                   /* 2118: Test COMM4 */
    bt      ultra_loop              /* 8BFC: Loop if zero */
    add     #1,r2                   /* 7201: Inc (delay) */
    mov.l   r2,@r0                  /* 2022: Write COMM2 */
    bra     ultra_loop              /* AFF9: Loop */
    nop                             /* 0009: Delay */

.align 4
.L_base:
    .long   0x20004024

/*
 * Size: Still 22 bytes
 *
 * FINAL DECISION: We CANNOT fit this in 18 bytes.
 * Must use redirect approach or find larger injection point.
 *
 * For now, let's create a 16-byte version (8 words) that
 * we can place at $020466 (18-byte gap), and use a 6-byte
 * redirect at $02050C to jump there.
 */
