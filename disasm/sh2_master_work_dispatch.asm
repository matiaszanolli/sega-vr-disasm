/* ============================================================================
 * SH2 Master Work Dispatch Function
 *
 * Signals the Slave SH2 that work is available by setting COMM4 register.
 *
 * This function is called from the Master rendering loop at the end of each
 * frame processing cycle (at ROM address 0x23062).
 * ============================================================================ */

.section .text
.align 2

/* COMM register addresses from SH2 perspective */
.set COMM4_ADDR, 0x20004028    /* Work signal to Slave */

.globl master_dispatch_work

/* Entry point: To be inserted at 0x23062
 *
 * Called from: End of Master rendering loop
 * Returns: Continues to original epilogue
 *
 * Logic:
 *   1. Load COMM4 address
 *   2. Set COMM4 = 1 (signal work to Slave)
 *   3. Return to original code flow
 *
 * Size: 12 bytes (6 words) + 4 bytes data = 16 bytes total
 */
master_dispatch_work:
    mov.l   comm4_addr, r0      /* R0 = COMM4 address */
    mov     #1, r1              /* R1 = 1 (work signal) */
    mov.w   r1, @r0             /* COMM4 = 1 */
    nop                         /* Padding for alignment */
    nop                         /* Extra padding */
    nop

.align 4

comm4_addr:
    .long   COMM4_ADDR
