/*
 * Slave SH2 Work Check - Absolute Minimum
 * MUST fit in exactly 18 bytes
 *
 * Strategy: Derive COMM4 address from COMM2 (COMM4 = COMM2 + 4)
 * This saves 4 bytes of data space
 *
 * Simplified behavior:
 * - Poll COMM4 continuously
 * - When COMM4 non-zero: increment COMM2 and loop back
 * - Master must clear COMM4 after seeing COMM2 change
 */

.section .text

.global slave_work_tight
slave_work_tight:
    mov.l   .L_comm2,r0         /* D002: R0 = COMM2 address (0x20004024) */
    mov     r0,r1               /* 6103: R1 = R0 (copy COMM2 address) */
    add     #4,r1               /* 7104: R1 = R1 + 4 = COMM4 address */

poll_loop:
    mov.w   @r1,r2              /* 6112: R2 = COMM4 value (work signal) */
    tst     r2,r2               /* 2228: Test if COMM4 non-zero */
    bf      do_work             /* 89xx: Branch if work detected */
    nop                         /* 0009: Delay slot */
    bra     poll_loop           /* AFxx: No work, keep polling */
    nop                         /* 0009: Delay slot */

do_work:
    mov.w   @r0,r3              /* 6302: R3 = current COMM2 */
    add     #1,r3               /* 7301: Increment work counter */
    mov.w   r3,@r0              /* 2032: Write COMM2 (acknowledge) */
    bra     poll_loop           /* AFxx: Back to polling */
    nop                         /* 0009: Delay slot */

.align 4
.L_comm2:
    .long   0x20004024          /* COMM2 address (COMM4 = this + 4) */

/*
 * Instruction count:
 * mov.l, mov, add = 6 bytes (initialization)
 * mov.w, tst, bf, nop, bra, nop = 12 bytes (poll loop)
 * mov.w, add, mov.w, bra, nop = 10 bytes (do_work)
 * Total code: 28 bytes
 * Data: 4 bytes
 * Total: 32 bytes - TOO BIG!
 *
 * I need to eliminate the do_work section somehow...
 */
