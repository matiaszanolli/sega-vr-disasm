/*
 * Slave SH2 Test Loop - EXACT binary layout
 * Location: ROM $02050C (SH2: 0x0602050C)
 *
 * This version uses explicit NOPs to control layout exactly
 * No .align directives - manual control for byte-perfect match
 */

.section .text

/* Entry: offset 0x00 */
slave_comm2_test:
    mov.l   .L_comm2,r0         /* D002: Load COMM2 address (disp=2) */
    mov     #0,r1               /* E100: Initialize counter */

/* Loop: offset 0x04 */
test_loop:
    add     #1,r1               /* 7101: counter++ */
    mov.l   r1,@r0              /* 2012: Write to COMM2 */
    bra     test_loop           /* AFFC: Loop back (disp=-4) */
    nop                         /* 0009: Delay slot */

/* Data: offset 0x0C (12 bytes = 0x0C) */
.L_comm2:
    .long   0x20004024          /* COMM2 register address */
    nop                         /* 0009: Padding to 18 bytes total */

/*
 * Layout verification:
 * 0x00: D002 E100 - mov.l + mov
 * 0x04: 7101 2012 - add + mov.l
 * 0x08: AFFC 0009 - bra + nop
 * 0x0C: 20004024 - data
 * 0x10: 0009      - padding
 * Total: 18 bytes (0x12)
 *
 * PC-relative calculation for mov.l .L_comm2,r0 at offset 0x00:
 * PC = 0x00 (instruction address)
 * Base = ((PC + 4) & ~3) = (0x04 & ~3) = 0x04
 * Target = 0x0C
 * Displacement = (0x0C - 0x04) / 4 = 0x08 / 4 = 2
 * Opcode = D002 ✓
 */
