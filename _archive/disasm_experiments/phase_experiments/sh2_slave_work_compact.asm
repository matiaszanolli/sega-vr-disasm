/* ============================================================================
 * SH2 Slave Work Check Function - Compact Version
 * Fits in exactly 20 bytes (10 words) at 0x20490-0x204A2
 * ============================================================================ */

.section .text
.align 2

.set COMM_BASE, 0x20004020      /* COMM0 base address */

.globl slave_work_check_compact

/* Ultra-compact version using COMM base + offsets */
slave_work_check_compact:
    mov.l   comm4_addr, r0      /* R0 = COMM4 address */
    mov.l   comm2_addr, r1      /* R1 = COMM2 address */
    mov.w   @r0, r2             /* R2 = COMM4 (work flag) */
    tst     r2, r2              /* Test if zero */
    bt      done                /* Skip if no work */
    mov.w   @r1, r3             /* R3 = COMM2 */
    add     #1, r3              /* Increment */
    mov.w   r3, @r1             /* Write back */
done:
    rts
    nop

.align 4

comm4_addr:
    .long   0x20004028

comm2_addr:
    .long   0x20004024

.align 4

comm_base:
    .long   COMM_BASE
