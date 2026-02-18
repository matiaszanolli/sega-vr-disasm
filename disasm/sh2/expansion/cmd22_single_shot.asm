/*
 * cmd22_single_shot — Single-Shot 2D Block Copy Handler (cmd $22)
 * Expansion ROM Address: $3010F0 (SH2: $023010F0)
 * Size: 60 bytes (30 words)
 *
 * Replaces the 3-phase COMM6 handshake protocol with a single-shot
 * parameter read from COMM1-6. The 68K writes all params at once,
 * the Master reads them in one shot. Eliminates 2 blocking waits
 * from the 68K side (~128 cycles saved per call × 14 calls/frame).
 *
 * COMM Register Layout (SH2 perspective, base R8 = $20004020):
 *   COMM1 ($20004022) = D1 (height, number of rows)
 *   COMM2:3 ($20004024) = A0 (source pointer, longword)
 *   COMM4:5 ($20004028) = A1 (destination pointer, longword)
 *   COMM6 ($2000402C) = D0 (width, bytes per row)
 *   COMM7 = UNTOUCHED (reserved for Slave doorbell)
 *
 * Entry: R8 = $20004020 (COMM base, set by dispatch loop)
 *        R0 = command code (from COMM0_LO, clobbered)
 *
 * Register Mapping:
 *   R0 = Destination base pointer (from COMM4:5 = A1)
 *   R1 = Width in bytes (from COMM6 = D0), halved to words per row
 *   R2 = Height / row count (from COMM1 = D1)
 *   R3 = Source pointer (from COMM2:3 = A0)
 *   R4 = Current destination pointer (within row)
 *   R5 = Words remaining in current row
 *   R6 = Row stride ($0200 = 512 bytes)
 *   R7 = Temp (word being copied)
 *   R8 = 1 (constant, clobbers COMM base — restored by dispatch loop)
 *
 * Completion: Calls func_084 ($060043F0) which clears COMM0+COMM1,
 *   signaling the 68K that the command is done.
 *
 * Algorithm:
 *   words = R1 / 2;   // bytes → words (ONCE, before loop)
 *   for (row = 0; row < R2; row++) {
 *       dest = R0;
 *       for (word = 0; word < words; word++)
 *           *dest++ = *src++;
 *       R0 += 0x200;  // next row
 *   }
 */

.section .text
.align 2

cmd22_single_shot:
    /* === PARAM READ (8 instructions, 16 bytes) === */
    /* $3010F0 */ sts.l   pr,@-r15            /* Save return address */
    /* $3010F2 */ mov.w   @(2,r8),r0           /* R0 = COMM1 = D1 (height) [byte offset 2] */
    /* $3010F4 */ mov     r0,r2               /* R2 = height */
    /* $3010F6 */ mov.w   @(12,r8),r0          /* R0 = COMM6 = D0 (width) [byte offset 12] */
    /* $3010F8 */ mov     r0,r1               /* R1 = width */
    /* $3010FA */ mov.l   @(4,r8),r0           /* R0 = COMM2:3 = A0 (source) [byte offset 4] */
    /* $3010FC */ mov     r0,r3               /* R3 = source pointer */
    /* $3010FE */ mov.l   @(8,r8),r0           /* R0 = COMM4:5 = A1 (dest) [byte offset 8] */

    /* === BLOCK COPY SETUP (3 instructions, 6 bytes) === */
    /* $301100 */ mov.w   @(.stride,pc),r6    /* R6 = $0200 (row stride) */
    /* $301102 */ mov     #1,r8               /* R8 = 1 (loop constant) */
    /* $301104 */ shlr    r1                  /* R1 /= 2 (bytes → words, ONCE) */

    /* === OUTER LOOP: Row Iterator === */
.row_loop:
    /* $301106 */ mov     r0,r4               /* R4 = dest row start */
    /* $301108 */ mov     r1,r5               /* R5 = words per row */

    /* === INNER LOOP: Word Copy === */
.copy_word:
    /* $30110A */ mov.w   @r3+,r7             /* R7 = *src++; read word */
    /* $30110C */ mov.w   r7,@r4              /* *dest = R7; write word */
    /* $30110E */ dt      r5                  /* R5-- and test */
    /* $301110 */ bf/s    .copy_word          /* Loop if words remain */
    /* $301112 */ add     #2,r4               /* [delay] dest += 2 */

    /* Row complete */
    /* $301114 */ dt      r2                  /* R2-- (row counter) */
    /* $301116 */ bf/s    .row_loop           /* Loop if rows remain */
    /* $301118 */ add     r6,r0               /* [delay] dest += stride */

    /* === COMPLETION: Clear COMM0 via func_084 === */
    /* $30111A */ mov.l   @(.func084,pc),r0   /* R0 = $060043F0 */
    /* $30111C */ jsr     @r0                 /* Call func_084 */
    /* $30111E */ nop                         /* Delay slot */
    /* $301120 */ lds.l   @r15+,pr            /* Restore PR */
    /* $301122 */ rts                         /* Return to dispatch loop */
    /* $301124 */ nop                         /* Delay slot */

/* === LITERAL POOL === */
.align 1    /* 2-byte alignment (2^1 = 2) for word data */
.stride:
    /* $301126 */ .word   0x0200              /* Row stride (512 bytes) */
.align 2    /* 4-byte alignment (2^2 = 4) for longword data */
.func084:
    /* $301128 */ .long   0x060043F0          /* Completion handler */

/* End: $30112C (60 bytes total) */

.global cmd22_single_shot
