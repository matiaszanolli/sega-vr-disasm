/* ============================================================================
 * SH2 Slave Work Check Function
 *
 * Checks COMM4 register for work signal from Master SH2.
 * If work is signaled (COMM4 != 0), increments COMM2 counter.
 *
 * This function is called in a tight loop from the Slave idle loop at 0x20460.
 * ============================================================================ */

.section .text
.align 2

/* COMM register addresses from SH2 perspective */
.set COMM2_ADDR, 0x20004024    /* Work counter */
.set COMM4_ADDR, 0x20004028    /* Work signal from Master */

.globl slave_check_work

/* Entry point: 0x20468 (ROM offset 0x20468)
 *
 * Called from: BSR at 0x20460
 * Returns: RTS
 *
 * Logic:
 *   1. Read COMM4 (work flag)
 *   2. If COMM4 == 0, return (no work)
 *   3. If COMM4 != 0:
 *      - Read COMM2
 *      - Increment COMM2
 *      - Write COMM2
 *      - Return
 */
slave_check_work:
    mov.l   comm4_addr, r0      /* R0 = COMM4 address */
    mov.w   @r0, r1             /* R1 = COMM4 value (work flag) */
    tst     r1, r1              /* Test if R1 == 0 */
    bt/s    no_work             /* Branch if T=1 (no work) */
    mov.l   comm2_addr, r1      /* R1 = COMM2 address [delay slot] */

    /* Work detected - increment counter */
    mov.w   @r1, r2             /* R2 = COMM2 value */
    add     #1, r2              /* R2++ */
    mov.w   r2, @r1             /* COMM2 = R2 */

no_work:
    rts
    nop

.align 4

comm4_addr:
    .long   COMM4_ADDR

comm2_addr:
    .long   COMM2_ADDR
