/*
 * Slave SH2 Work Check - Simple Version
 * Fits in 18 bytes using basic addressing
 *
 * Strategy: Load both COMM2 and COMM4 addresses using PC-relative
 * Since they're consecutive in memory, pack them together
 */

.section .text

.global slave_work_simple
slave_work_simple:
    mov.l   .L_comm2,r0         /* Load COMM2 address into R0 */
    mov.l   .L_comm4,r1         /* Load COMM4 address into R1 */

work_loop:
    mov.w   @r1,r2              /* Read COMM4 (work signal) */
    tst     r2,r2               /* Test if work available */
    bf      got_work            /* Branch if work detected */
    nop                         /* Delay slot */
    bra     work_loop           /* No work, keep polling */
    nop                         /* Delay slot */

got_work:
    mov.w   @r0,r3              /* Read current COMM2 value */
    add     #1,r3               /* Increment */
    mov.w   r3,@r0              /* Write back to COMM2 */
    bra     work_loop           /* Back to polling */
    nop                         /* Delay slot */

.align 4
.L_comm2:
    .long   0x20004024          /* COMM2 address */
.L_comm4:
    .long   0x20004028          /* COMM4 address */

/*
 * This is definitely too big (need 2 addresses = 8 bytes data minimum,
 * plus ~20+ bytes of code).
 *
 * Let me try the absolute minimum approach...
 */
