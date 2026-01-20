/*
 * Slave SH2 COMM4 Detector - ULTRA MINIMAL
 * Absolutely minimal version that fits in 18 bytes
 *
 * Location: ROM $02050C (SH2: 0x0602050C)
 * Size: Exactly 18 bytes (9 words)
 *
 * Strategy: Single loop, delay slot optimization, no initialization
 */

.section .text

.global slave_comm4_minimal
slave_comm4_minimal:
    mov.l   .L_comm_base,r0         /* D002: R0 = COMM2 addr (0x20004024) */

loop:
    mov.l   @(4,r0),r1              /* 5014: R1 = COMM4 (offset +4) */
    tst     r1,r1                   /* 2118: Test COMM4 */
    bf      work_found              /* 8901: Branch if work (T=0) */
    nop                             /* 0009: Delay slot */
    bra     loop                    /* AFFB: No work, keep looping */
    nop                             /* 0009: Delay slot */

work_found:
    mov.l   @r0,r2                  /* 6202: Read COMM2 */
    add     #1,r2                   /* 7201: Increment */
    bra     loop                    /* AFF8: Continue */
    mov.l   r2,@r0                  /* 2022: Write COMM2 (delay slot!) */

.align 4
.L_comm_base:
    .long   0x20004024              /* COMM2 address */

/*
 * Size calculation:
 * - mov.l @(PC),r0    : 2 bytes (D002)
 * - mov.l @(4,r0),r1  : 2 bytes (5014)
 * - tst r1,r1         : 2 bytes (2118)
 * - bf +6             : 2 bytes (8901)
 * - nop               : 2 bytes (0009)
 * - bra -10           : 2 bytes (AFFB)
 * - nop               : 2 bytes (0009)
 * - mov.l @r0,r2      : 2 bytes (6202)
 * - add #1,r2         : 2 bytes (7201)
 * - bra -12           : 2 bytes (AFF8)
 * - mov.l r2,@r0      : 2 bytes (2022) [in delay slot]
 * - .long addr        : 4 bytes
 * Total: 26 bytes
 *
 * ARGH! Still 26 bytes. The problem is we need:
 * - 1 address load (2 bytes)
 * - 1 COMM4 read (2 bytes)
 * - 1 test (2 bytes)
 * - 1 branch (2 bytes)
 * - 1 COMM2 read (2 bytes)
 * - 1 increment (2 bytes)
 * - 1 COMM2 write (2 bytes)
 * - 1 loop branch (2 bytes)
 * - 1 address literal (4 bytes)
 * = 20 bytes minimum + delay slots
 *
 * We can't fit this in 18 bytes with proper delay slots!
 *
 * DECISION: Use the 18-byte space as a REDIRECT to a larger
 * function in one of the ROM gaps we identified earlier.
 */
