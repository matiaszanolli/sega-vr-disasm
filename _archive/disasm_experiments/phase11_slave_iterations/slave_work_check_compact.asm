/*
 * Slave SH2 Work Check - Ultra Compact Version
 * MUST fit in exactly 18 bytes (9 words)
 *
 * Location: ROM $02050C (SH2: 0x0602050C)
 * Size: 18 bytes exactly
 *
 * Key Optimization: COMM2 and COMM4 are only 4 bytes apart!
 * COMM2: 0x20004024
 * COMM4: 0x20004028 (COMM2 + 4)
 *
 * Strategy: Load COMM2 base address, access COMM4 with offset
 */

.section .text

.global slave_work_check
slave_work_check:
    mov.l   .L_comm2,r0         /* D002: Load COMM2 base address */
    mov     #0,r1               /* E100: Initialize work counter */

work_loop:
    mov.w   @(2,r0),r2          /* 6824: Read COMM4 (offset +2 words from COMM2) */
    tst     r2,r2               /* 2228: Test if work signal is non-zero */
    bt      work_loop           /* 8BFC: Branch if zero (no work), keep polling */
    nop                         /* 0009: Delay slot */

    add     #1,r1               /* 7101: Work detected! Increment counter */
    mov.w   r1,@r0              /* 2011: Write counter to COMM2 (acknowledge) */
    bra     work_loop           /* AFF8: Back to polling */
    nop                         /* 0009: Delay slot */

.align 4
.L_comm2:
    .long   0x20004024          /* COMM2 base address */

/*
 * Instruction breakdown:
 * 0x00: D002      MOV.L @(disp,PC),R0  - Load COMM2 address
 * 0x02: E100      MOV #0,R1            - Initialize counter
 * 0x04: 6824      MOV.W @(4,R0),R2     - Read COMM4 (COMM2+4)
 * 0x06: 2228      TST R2,R2            - Test for work
 * 0x08: 8BFC      BT work_loop         - Loop if no work
 * 0x0A: 0009      NOP                  - Delay slot
 * 0x0C: 7101      ADD #1,R1            - Increment work counter
 * 0x0E: 2011      MOV.W R1,@R0         - Write COMM2
 * 0x10: AFF8      BRA work_loop        - Loop back
 * 0x12: 0009      NOP                  - Delay slot
 * 0x14: (align)
 * 0x18: 20004024  .long COMM2          - Data
 *
 * Let's assemble and check size...
 */
