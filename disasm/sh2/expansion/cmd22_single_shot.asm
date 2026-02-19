/*
 * cmd22_single_shot — Single-Shot 2D Block Copy Handler (cmd $22)
 * Expansion ROM Address: $3010F0 (SH2: $023010F0)
 * Size: ~62 bytes (31 words)
 *
 * B-004 v5: COMM1-safe parameter layout. COMM1 is NEVER read — it carries
 * Slave work commands (COMM1_HI != 0 → Slave dispatches). v4's use of
 * COMM1 for A1_HI caused spurious Slave dispatch on every sh2_send_cmd
 * call (A1_HI is always non-zero for any framebuffer/SDRAM address).
 *
 * DISPATCH: Master SH2 dispatch loop reads COMM0_LO ($20004021) as the
 * jump table index. 68K writes $2222 → COMM0_HI=$22 (trigger), COMM0_LO=$22
 * (dispatch index) → entry $22 at $06000808 → this handler.
 *
 * COMM Register Layout (SH2 perspective, base R8 = $20004020):
 *   COMM0 ($20004020) = $22xx (HI=$22 trigger, LO=$22 dispatch index)
 *   COMM1 ($20004022) = UNTOUCHED (Slave work cmd — never read/written here)
 *   COMM2:3 ($20004024) = A0 (source pointer, longword, 4-byte aligned)
 *   COMM4:5 ($20004028) = A1 (dest pointer, longword, 4-byte aligned)
 *   COMM6_HI ($2000402C) = D1 (height in rows, byte, < 224)
 *   COMM6_LO ($2000402D) = D0/2 (words per row, byte, < 256; pre-divided by 68K)
 *   COMM7 = UNTOUCHED (reserved for Slave doorbell)
 *
 * Entry: R8 = $20004020 (COMM base, set by dispatch loop)
 *        R0 = $22 (COMM0_HI, used as table index then clobbered)
 *        R4 = COMM0_LO (set by dispatch loop, unused by this handler)
 *
 * Register Mapping:
 *   R0 = Destination base pointer (from COMM4:5 = A1, loaded last)
 *   R1 = Words per row (from COMM6_LO = D0/2, pre-divided — no shlr needed)
 *   R2 = Height / row count (from COMM6_HI = D1)
 *   R3 = Source pointer (from COMM2:3 = A0)
 *   R4 = Current dest pointer within row (temp during inner loop)
 *   R5 = Words remaining in current row
 *   R6 = Row stride ($0200 = 512 bytes)
 *   R7 = Word being copied
 *   R8 = 1 (loop constant, clobbers COMM base — restored by dispatch loop)
 *
 * Params-Read Signal: After reading all COMM params, writes $0100 to
 *   COMM0 (word) — clears COMM0_LO to $00. 68K polls COMM0_LO until zero,
 *   then re-enables interrupts and polls COMM0_HI for copy completion.
 *
 * Completion: Calls func_084 ($060043F0) which clears COMM0_HI to $00
 *   and sets COMM1_LO bit 0 ("command done" signal for V-INT).
 *
 * Algorithm:
 *   for (row = 0; row < R2; row++) {
 *       dest = R0;
 *       for (word = 0; word < R1; word++)  // R1 = words/row (pre-divided)
 *           *dest++ = *src++;
 *       R0 += 0x200;  // next row (stride)
 *   }
 */

.section .text
.align 2

cmd22_single_shot:
    /* === PARAM READ (7 instructions, 14 bytes) === */
    /* Read COMM6 first (requires R0 as dest), then A0/A1 into R3/R0 last. */
    sts.l   pr,@-r15            /* Save return address */
    mov.b   @(12,r8),r0         /* R0 = COMM6_HI = D1 (height) [byte offset 12] */
    extu.b  r0,r2               /* R2 = height (zero-extended) */
    mov.b   @(13,r8),r0         /* R0 = COMM6_LO = D0/2 (words/row) [byte offset 13] */
    extu.b  r0,r1               /* R1 = words/row (zero-extended, already halved) */
    mov.l   @(4,r8),r3          /* R3 = A0 (COMM2:3 longword = source) [byte offset 4] */
    mov.l   @(8,r8),r0          /* R0 = A1 (COMM4:5 longword = dest) [byte offset 8] */

    /* === PARAMS-READ SIGNAL (3 instructions, 6 bytes) === */
    /* Write $0100 to COMM0 (word): COMM0_HI=$01, COMM0_LO=$00.          */
    /* 68K polls COMM0_LO until $00, then re-enables interrupts.          */
    mov     #1,r6               /* R6 = 1 */
    shll8   r6                  /* R6 = $0100 */
    mov.w   r6,@r8              /* Word write to COMM0 (R8 still = COMM base) */

    /* === BLOCK COPY SETUP (2 instructions, 4 bytes) === */
    /* R1 already holds words/row (pre-divided by 68K — no shlr needed). */
    mov.w   @(.stride,pc),r6    /* R6 = $0200 (row stride, 512 bytes) */
    mov     #1,r8               /* R8 = 1 (loop constant, clobbers COMM base) */

    /* === OUTER LOOP: Row Iterator === */
.row_loop:
    mov     r0,r4               /* R4 = dest row start */
    mov     r1,r5               /* R5 = words per row */

    /* === INNER LOOP: Word Copy === */
.copy_word:
    mov.w   @r3+,r7             /* R7 = *src++; read word */
    mov.w   r7,@r4              /* *dest = R7; write word */
    dt      r5                  /* R5-- and test */
    bf/s    .copy_word          /* Loop if words remain */
    add     #2,r4               /* [delay] dest += 2 */

    /* Row complete */
    dt      r2                  /* R2-- (row counter) */
    bf/s    .row_loop           /* Loop if rows remain */
    add     r6,r0               /* [delay] dest += stride */

    /* === COMPLETION: Clear COMM0 via func_084 === */
    mov.l   @(.func084,pc),r0   /* R0 = $060043F0 */
    jsr     @r0                 /* Call func_084 (clears COMM0_HI, sets COMM1_LO bit 0) */
    nop                         /* Delay slot */
    lds.l   @r15+,pr            /* Restore PR */
    rts                         /* Return to dispatch loop */
    nop                         /* Delay slot */

/* === LITERAL POOL === */
.align 1    /* 2-byte alignment (2^1 = 2) for word data */
.stride:
    .word   0x0200              /* Row stride (512 bytes) */
.align 2    /* 4-byte alignment (2^2 = 4) for longword data */
.func084:
    .long   0x060043F0          /* Completion handler */

/* End: ~62 bytes */

.global cmd22_single_shot
