/*
 * Slave SH2 COMM4 Work Signal Detector
 * Tests work distribution by checking COMM4 before incrementing COMM2
 *
 * Location: ROM $02050C (SH2: 0x0602050C)
 * Size: MUST be exactly 18 bytes (9 words)
 *
 * Protocol:
 * - Master (or 68K for testing) writes non-zero to COMM4 when work available
 * - Slave polls COMM4 in tight loop
 * - When COMM4 != 0: Slave increments COMM2 (acknowledges work)
 * - Slave continues looping (Master should clear COMM4 when done)
 *
 * Expected Behavior:
 * - COMM4 = 0: COMM2 stays unchanged (Slave waiting)
 * - COMM4 = 1: COMM2 increments continuously (Slave working)
 *
 * Test Method:
 * - Manually set COMM4 from 68K code or debugger
 * - Watch COMM2 for increments
 * - Proves Slave is responding to work signals
 */

.section .text

.global slave_comm4_detector
slave_comm4_detector:
    /* Load COMM register addresses - only need one mov.l with offset addressing */
    mov.l   .L_comm2_addr,r0        /* D002: R0 = COMM2 address (0x20004024) */

check_work_loop:
    /* Read COMM4 (offset +4 from COMM2) */
    mov.l   @(4,r0),r1              /* 5014: R1 = COMM4 value (offset +4) */

    /* Test if work available (COMM4 != 0) */
    tst     r1,r1                   /* 2118: Set T flag if R1 == 0 */
    bt      check_work_loop         /* 8BFD: Branch back if T=1 (no work) */
    nop                             /* 0009: Delay slot */

    /* Work detected! Increment COMM2 */
    mov.l   @r0,r2                  /* 6202: Read COMM2 current value */
    add     #1,r2                   /* 7201: Increment counter */
    mov.l   r2,@r0                  /* 2022: Write back to COMM2 */

    /* Loop back to keep checking */
    bra     check_work_loop         /* AFFA: Branch back */
    nop                             /* 0009: Delay slot */

/* Data section - COMM2 address (COMM4 is at +4 offset) */
.align 4
.L_comm2_addr:
    .long   0x20004024              /* COMM2 register address */

/*
 * =================================================================
 * SIZE ANALYSIS
 * =================================================================
 *
 * Instruction count:
 * - mov.l   @(PC),r0    : 2 bytes (D002)
 * - mov.l   @(4,r0),r1  : 2 bytes (5014)
 * - tst     r1,r1       : 2 bytes (2118)
 * - bt      -4          : 2 bytes (8BFD)
 * - nop                 : 2 bytes (0009)
 * - mov.l   @r0,r2      : 2 bytes (6202)
 * - add     #1,r2       : 2 bytes (7201)
 * - mov.l   r2,@r0      : 2 bytes (2022)
 * - bra     -8          : 2 bytes (AFFA)
 * - nop                 : 2 bytes (0009)
 * - .align + .long      : 4 bytes
 * ===================================
 * Total: 22 bytes
 *
 * PROBLEM: This is 22 bytes, but we only have 18 bytes available!
 *
 * We need to optimize. Options:
 * 1. Remove one NOP (risky - delay slot requirement)
 * 2. Combine operations
 * 3. Use different addressing mode
 *
 * Let me try removing the padding NOP and using direct branch:
 */
