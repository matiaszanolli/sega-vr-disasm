/*
 * Slave SH2 Minimal Work Loop
 * Ultra-compact version that fits in 18 bytes
 *
 * Location: ROM $02050C (SH2: 0x0602050C)
 * Size: MUST be exactly 18 bytes (9 words)
 *
 * Strategy: Keep it simple - just check COMM4 and increment COMM2
 * No fancy logic, just the bare minimum to prove work distribution works
 */

.section .text

.global slave_work_minimal
slave_work_minimal:
    mov.l   .L_addrs,r0         /* D002: Load addresses base */
    mov.w   @(4,r0),r1          /* 6814: Read COMM4 (offset +4 from base) */
check_loop:
    tst     r1,r1               /* 2118: Test if work available */
    bt      check_loop          /* 8BFD: Loop if zero */
    mov.w   @r0,r2              /* 6202: Read COMM2 in delay slot */
    add     #1,r2               /* 7201: Increment */
    bra     slave_work_minimal  /* AFFA: Restart */
    mov.w   r2,@r0              /* 2022: Write COMM2 in delay slot */

.align 4
.L_addrs:
    .long   0x20004024          /* Base: COMM2 address (COMM4 is +4) */

/*
 * Size: Let's assemble and see...
 *
 * Wait, this won't work either - we need TWO addresses (COMM2 and COMM4)
 * but can only load one in PC-relative mode with 4-byte alignment.
 *
 * Let me try a different approach: absolute immediate loads
 */
