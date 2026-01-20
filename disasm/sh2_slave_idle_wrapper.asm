/* ============================================================================
 * SH2 Slave Idle Loop Wrapper
 *
 * This wrapper sits in expansion ROM and provides a non-invasive way to
 * inject work checking into the Slave's idle loop.
 *
 * Strategy:
 * 1. Call original VDP wait function at 0x0602050C
 * 2. Check COMM4 for work signal
 * 3. If work detected, increment COMM2 counter
 * 4. Loop forever
 *
 * Location: Will be placed at $300040 in expansion ROM (SH2: 0x06300040)
 * ============================================================================ */

.section .text
.align 2

.set VDP_WAIT_FUNC, 0x0602050C   /* Original VDP wait function */
.set COMM4_ADDR,    0x20004028   /* Work signal from Master */
.set COMM2_ADDR,    0x20004024   /* Work counter */

.globl slave_idle_wrapper

/* Wrapper idle loop that checks for work while waiting for VDP */
slave_idle_wrapper:
    /* Load function addresses once */
    mov.l   vdp_wait_addr, r10    /* R10 = VDP wait function */
    mov.l   comm4_addr, r11       /* R11 = COMM4 address */
    mov.l   comm2_addr, r12       /* R12 = COMM2 address */

idle_loop:
    /* Call original VDP wait function */
    jsr     @r10
    nop

    /* Check for work signal in COMM4 */
    mov.w   @r11, r1              /* R1 = COMM4 */
    tst     r1, r1                /* Test if zero */
    bt      idle_loop             /* No work, loop again */

    /* Work detected - increment counter */
    mov.w   @r12, r2              /* R2 = COMM2 */
    add     #1, r2                /* R2++ */
    mov.w   r2, @r12              /* COMM2 = R2 */

    /* Clear work flag (optional - depends on protocol) */
    mov     #0, r1
    mov.w   r1, @r11              /* COMM4 = 0 */

    /* Continue looping */
    bra     idle_loop
    nop

.align 4

vdp_wait_addr:
    .long   VDP_WAIT_FUNC

comm4_addr:
    .long   COMM4_ADDR

comm2_addr:
    .long   COMM2_ADDR
