/*
 * Slave SH2 Work Check Loop
 * Replaces simple COMM2 increment test with actual work detection
 *
 * Location: ROM $02050C (SH2: 0x0602050C)
 * Size: Must fit in 18 bytes (9 words) - EXACT MATCH REQUIRED
 *
 * Purpose: Check COMM4 for work signal from Master, increment COMM2 when work found
 *
 * Communication Protocol:
 * - Master writes non-zero to COMM4 when work is available
 * - Slave checks COMM4 in tight loop
 * - When work detected: increment COMM2 and return to loop
 *
 * Assembly with: sh-elf-as --isa=sh2 -o slave_work_loop.o slave_work_loop.asm
 */

.section .text

/*
 * Slave Work Check Loop
 * Continuously checks COMM4 for work signal from Master
 */
.global slave_work_loop
slave_work_loop:
    mov.l   .L_comm4,r0         /* D002: Load COMM4 address (work signal) */
    mov.l   .L_comm2,r1         /* D101: Load COMM2 address (work counter) */

work_check_loop:
    mov.w   @r0,r2              /* 6202: Read COMM4 (work signal) */
    tst     r2,r2               /* 2228: Test if work available (non-zero) */
    bt      work_check_loop     /* 8BFC: Branch if no work, loop again */
    nop                         /* 0009: Delay slot */

/* Work found - increment COMM2 and continue checking */
    mov.w   @r1,r3              /* 6312: Read COMM2 current value */
    add     #1,r3               /* 7301: Increment work counter */
    mov.w   r3,@r1              /* 2132: Write back to COMM2 */
    bra     work_check_loop     /* AFF7: Loop back to check for more work */
    nop                         /* 0009: Delay slot */

/* Data section - COMM register addresses */
.align 4
.L_comm4:
    .long   0x20004028          /* COMM4 - work signal from Master */
.L_comm2:
    .long   0x20004024          /* COMM2 - work counter */

/*
 * =================================================================
 * EXPECTED BEHAVIOR
 * =================================================================
 *
 * When COMM4 = 0 (no work):
 *   - Slave loops continuously checking COMM4
 *   - Very low CPU usage (just polling)
 *   - COMM2 stays unchanged
 *
 * When Master sets COMM4 = non-zero (work available):
 *   - Slave detects work immediately
 *   - Increments COMM2 (acknowledges work)
 *   - Loops back to check for more work
 *
 * Master can verify Slave is working by:
 *   - Write COMM4 = 1
 *   - Wait a few cycles
 *   - Read COMM2 - should have incremented
 *
 * =================================================================
 * SIZE CONSTRAINT
 * =================================================================
 *
 * This function is MORE complex than the simple test loop but must
 * fit in the same 18-byte space. If it doesn't fit:
 *
 * Option A: Simplify logic (just check and increment)
 * Option B: Place in expansion ROM and use JSR redirect
 * Option C: Find larger code gap in Slave ROM
 *
 * Let's see what size we get...
 * =================================================================
 */
