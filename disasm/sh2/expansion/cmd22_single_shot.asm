/*
 * cmd22_single_shot — Single-Shot 2D Block Copy Handler (cmd $22)
 * Expansion ROM Address: $3010F0 (SH2: $023010F0)
 * Size: 176 bytes (162 bytes code + 14 bytes literal pool)
 *
 * Inline COMM cleanup protocol (Phase 2 optimization):
 *   Replaces func_084 JSR with inline byte/word-level COMM writes.
 *   After copy completes, the handler clears COMM1, sets COMM1_LO bit 0
 *   ("command done"), then clears COMM0_HI via byte write (preserving
 *   COMM0_LO for potential re-dispatch detection).
 *
 *   Re-dispatch check: after clearing COMM0_HI, reads COMM0_LO.
 *   If $22, another cmd22 was queued during cleanup → re-dispatch.
 *   If non-zero, a different command is pending → restore COMM0_HI=$01, exit.
 *   If $00, truly idle → exit to dispatch loop.
 *
 *   Key insight: func_084 is called by HANDLERS, not the dispatch loop.
 *   The dispatch loop is just: poll COMM0_HI → read COMM0_LO → JSR handler
 *   → BRA poll. Since cmd22 does inline COMM cleanup, there is no external
 *   func_084 race to worry about.
 *
 * Longword optimization (Phase 3):
 *   When both source and destination addresses are longword-aligned AND the
 *   word count per row is even, the inner copy loop uses 32-bit MOV.L
 *   transfers instead of 16-bit MOV.W. This halves the loop iteration count,
 *   saving ~2.5 SH2 cycles per word pair in instruction overhead.
 *   Falls back to 16-bit word copy for unaligned addresses or odd widths.
 *   Even width guarantees R3 (auto-incremented source) stays 4-byte aligned
 *   across row boundaries (each row consumes width×2 bytes = multiple of 4).
 *
 * COMM Register Layout (68K write order, SH2 read perspective, R8 = $20004020):
 *   COMM0_HI (offset 0):  $01 — trigger (written LAST by 68K)
 *   COMM0_LO (offset 1):  $22 — dispatch index; cleared to $00 by SH2 (handshake)
 *   COMM1    (offsets 2,3): Cleared by completion (func_084 equivalent)
 *   COMM2_HI (offset 4):  $00 — NEVER WRITTEN (Slave's work-cmd poll byte)
 *   COMM2_LO (offset 5):  D0/2 (words per row, pre-divided by 68K)
 *   COMM3_HI (offset 6):  D1 (height in rows)
 *   COMM3_LO (offset 7):  A0[23:16] (src ptr byte 2)
 *   COMM4_HI (offset 8):  A0[15:8]  (src ptr byte 1)
 *   COMM4_LO (offset 9):  A0[7:0]   (src ptr byte 0)
 *   COMM5_HI (offset 10): A1[31:24] (dst ptr top byte — masked to $04)
 *   COMM5_LO (offset 11): A1[23:16]
 *   COMM6_HI (offset 12): A1[15:8]
 *   COMM6_LO (offset 13): A1[7:0]
 *   COMM7    (offsets 14,15): UNTOUCHED
 *
 * Entry: R8 = $20004020 (COMM base, set by dispatch loop before JSR)
 *
 * Register Mapping:
 *   R0 = scratch (all @(disp,R8) reads/writes go through R0); final: A1 dest base
 *   R1 = Words per row (from COMM2_LO = D0/2); halved for longword path
 *   R2 = Height / row count (from COMM3_HI = D1)
 *   R3 = Source pointer (A0 reconstructed: $06 | COMM3_LO:COMM4)
 *   R4 = A0[15:0] temp; current dest pointer within row (inner loop)
 *   R5 = A1[31:16] temp; alignment check scratch; words/longwords remaining (inner loop)
 *   R6 = A1[15:0] temp during param read; Row stride ($0200) during copy
 *   R7 = Word/longword being copied / alignment check scratch / prefix constant temp
 *   R8 = COMM base during param read; unused during copy; reloaded after copy
 *
 * PC-relative alignment notes:
 *   NOP at offset 34: .a0_prefix MOV.L at offset 36 (36%4=0 ✓)
 *   .a1_prefix MOV.L at offset 48 (48%4=0 ✓)
 *   NOP at offset 118: .comm_base MOV.L at offset 120 (120%4=0 ✓)
 *
 * Pool layout (offsets from function start, base=$3010F0):
 *   offset 162 ($301192): .stride     = $0200 (2 bytes)
 *   offset 164 ($301194): .comm_base  = $20004020 (4 bytes)
 *   offset 168 ($301198): .a0_prefix  = $06000000 (4 bytes)
 *   offset 172 ($30119C): .a1_prefix  = $04000000 (4 bytes)
 *   Total pool: 14 bytes → grand total: 176 bytes
 *
 * Algorithm:
 *   do {
 *     read ALL params from COMM2-6 into registers, THEN clear COMM0_LO
 *     reconstruct A0 ($06xxxxxx), A1 ($04xxxxxx)
 *     if (both aligned && even width) {
 *       width /= 2;  // longwords per row
 *       for (row = 0; row < height; row++) {
 *         dest = base;
 *         for (lw = 0; lw < width; lw++)
 *           *(long*)dest++ = *(long*)src++;  // 32-bit
 *         base += 0x200;
 *       }
 *     } else {
 *       for (row = 0; row < height; row++) {
 *         dest = base;
 *         for (word = 0; word < width; word++)
 *           *dest++ = *src++;  // 16-bit
 *         base += 0x200;
 *       }
 *     }
 *     reload R8 = COMM base
 *     COMM1 cleanup (clear + set bit 0)
 *     clear COMM0_HI via byte write (preserves COMM0_LO)
 *     re-check COMM0_LO:
 *       if ($22) → re-dispatch (catch late 68K writes)
 *       if (other) → restore COMM0_HI=$01, exit
 *       if ($00) → truly idle, exit
 *   } while (1);
 */

.section .text
.align 2

cmd22_single_shot:
    /* offset  0 */ sts.l   pr,@-r15            /* Save PR — once only */

.param_read:                                     /* Re-dispatch entry (R8=$20004020 guaranteed) */
    /* === PARAM READ: ALL COMM params into registers BEFORE signaling consumed === */
    /* offset  2 */ mov.b   @(6,r8),r0          /* R0 = COMM3_HI = D1 (height) */
    /* offset  4 */ extu.b  r0,r2               /* R2 = height (zero-extended) */
    /* offset  6 */ mov.b   @(5,r8),r0          /* R0 = COMM2_LO = D0/2 (words/row) */
    /* offset  8 */ extu.b  r0,r1               /* R1 = words/row (zero-extended) */
    /* offset 10 */ mov.b   @(7,r8),r0          /* R0 = COMM3_LO = A0[23:16] — R0 only! */
    /* offset 12 */ extu.b  r0,r3               /* R3 = A0[23:16] (zero-extended) */
    /* offset 14 */ mov.w   @(8,r8),r0          /* R0 = COMM4 word = A0[15:0] — R0 only! */
    /* offset 16 */ extu.w  r0,r4               /* R4 = A0[15:0] (zero-extended) */
    /* offset 18 */ mov.w   @(10,r8),r0         /* R0 = COMM5 word = A1[31:16] — R0 only! */
    /* offset 20 */ mov     r0,r5               /* R5 = A1[31:16] (save before next read) */
    /* offset 22 */ mov.w   @(12,r8),r0         /* R0 = COMM6 word = A1[15:0] — R0 only! */
    /* offset 24 */ extu.w  r0,r6               /* R6 = A1[15:0] (saved to R6; R6 free until stride load) */

    /* === PARAMS-CONSUMED SIGNAL: all params in registers, safe to release COMM === */
    /* offset 26 */ mov     #0,r0               /* R0 = 0 */
    /* offset 28 */ mov.b   r0,@(1,r8)          /* COMM0_LO = $00 (68K .wait_consumed exits) */

    /* === A0 RECONSTRUCTION: $06 | R3[23:16] | R4[15:0] === */
    /* offset 30 */ shll16  r3                  /* R3 = A0[23:16] << 16 */
    /* offset 32 */ or      r4,r3               /* R3 = A0[23:0] */

    /* === ALIGNMENT NOP: offset 34 → .a0_prefix MOV.L at offset 36 (36%4=0 ✓) === */
    /* offset 34 */ nop

    /* offset 36 */ mov.l   @(.a0_prefix,pc),r7 /* R7=$06000000 */
    /* offset 38 */ or      r7,r3               /* R3 = $06xxxxxx (A0: ROM native read) */

    /* === A1 RECONSTRUCTION: mask top byte, apply $04 prefix === */
    /* offset 40 */ shll16  r5                  /* R5 = A1[31:16] << 16 */
    /* offset 42 */ or      r6,r5               /* R5 = A1 raw (R6=A1[15:0] from offset 24) */
    /* offset 44 */ shll8   r5                  /* R5 <<= 8 (shift top byte out) */
    /* offset 46 */ shlr8   r5                  /* R5 >>= 8 (top byte now $00) */
    /* offset 48 */ mov.l   @(.a1_prefix,pc),r7 /* R7=$04000000 */
    /* offset 50 */ or      r7,r5               /* R5 = $04xxxxxx (A1: cached framebuffer) */
    /* offset 52 */ mov     r5,r0               /* R0 = A1 dest base (loop uses R0) */

    /* === ALIGNMENT + WIDTH CHECK ===                                             */
    /* Test: both addresses 4-byte aligned AND words/row is even.                  */
    /* Method: shift width left 1 (bit 0 → bit 1), OR with src|dest, test bit 1.  */
    /* If any source has bit 1 set, falls back to safe 16-bit word copy.           */
    /* offset 54 */ mov     r1,r7               /* R7 = words/row */
    /* offset 56 */ shll    r7                  /* R7 <<= 1 (width bit 0 → bit 1) */
    /* offset 58 */ or      r3,r7               /* R7 |= src address */
    /* offset 60 */ or      r0,r7               /* R7 |= dest address */
    /* offset 62 */ mov     #2,r5               /* R5 = 2 (test mask for bit 1) */
    /* offset 64 */ tst     r5,r7               /* T = ((result & 2) == 0)? */
    /* offset 66 */ bt      .long_setup         /* T=1 → aligned + even width → longword path */

    /* === WORD COPY PATH (16-bit, handles all cases) === */
    /* offset 68 */ mov.w   @(.stride,pc),r6    /* R6=$0200 (row stride) */
.word_row_loop:
    /* offset 70 */ mov     r0,r4               /* R4 = dest row start */
    /* offset 72 */ mov     r1,r5               /* R5 = words per row */
.copy_word:
    /* offset 74 */ mov.w   @r3+,r7             /* R7 = *src++; read word */
    /* offset 76 */ mov.w   r7,@r4              /* *dest = R7; write word */
    /* offset 78 */ dt      r5                  /* R5-- and test zero */
    /* offset 80 */ bf/s    .copy_word          /* Branch if words remain */
    /* offset 82 */ add     #2,r4               /* [delay slot] dest += 2 */

    /* === ROW COMPLETE (word path) === */
    /* offset 84 */ dt      r2                  /* R2-- (row counter) */
    /* offset 86 */ bf/s    .word_row_loop      /* Branch if rows remain */
    /* offset 88 */ add     r6,r0               /* [delay slot] dest base += stride */

    /* offset 90 */ bra     .cleanup            /* Jump to completion */
    /* offset 92 */ nop                         /* [delay slot] */

    /* === LONGWORD COPY PATH (32-bit, for aligned + even-width) === */
.long_setup:
    /* offset 94 */ shlr    r1                  /* R1 = words/2 = longwords per row */
    /* offset 96 */ mov.w   @(.stride,pc),r6    /* R6=$0200 (row stride) */
.long_row_loop:
    /* offset 98 */ mov     r0,r4               /* R4 = dest row start */
    /* offset 100 */ mov    r1,r5               /* R5 = longwords per row */
.copy_long:
    /* offset 102 */ mov.l  @r3+,r7             /* R7 = *src++ (32-bit read) */
    /* offset 104 */ mov.l  r7,@r4              /* *dest = R7 (32-bit write) */
    /* offset 106 */ dt     r5                  /* R5-- and test zero */
    /* offset 108 */ bf/s   .copy_long          /* Branch if longwords remain */
    /* offset 110 */ add    #4,r4               /* [delay slot] dest += 4 */

    /* === ROW COMPLETE (longword path) === */
    /* offset 112 */ dt     r2                  /* R2-- (row counter) */
    /* offset 114 */ bf/s   .long_row_loop      /* Branch if rows remain */
    /* offset 116 */ add    r6,r0               /* [delay slot] dest base += stride */

    /* === Fall through to cleanup === */

    /* === COMPLETION: Race-safe inline cleanup + re-dispatch === */
.cleanup:
    /* === ALIGNMENT NOP: offset 118 → .comm_base MOV.L at offset 120 (120%4=0 ✓) === */
    /* offset 118 */ nop

    /* Reload COMM base (clobbered during param read / copy setup) */
    /* offset 120 */ mov.l  @(.comm_base,pc),r8 /* R8=$20004020 */

    /* === COMM1 cleanup (func_084 equivalent) === */
    /* offset 122 */ mov    #0,r0               /* R0 = 0 */
    /* offset 124 */ mov.w  r0,@(2,r8)          /* COMM1_HI:LO = $0000 (word write at offset 2) */
    /* offset 126 */ mov.b  @(3,r8),r0          /* R0 = COMM1_LO (just cleared = 0) */
    /* offset 128 */ or     #1,r0               /* R0 |= 1 (set bit 0: "command done") */
    /* offset 130 */ mov.b  r0,@(3,r8)          /* COMM1_LO = 1 */

    /* === Clear COMM0_HI via byte write — preserves COMM0_LO === */
    /* offset 132 */ mov    #0,r0               /* R0 = 0 */
    /* offset 134 */ mov.b  r0,@(0,r8)          /* COMM0_HI = 0 (byte write only!) */

    /* === Race-safe re-check: 68K may have written COMM0_LO during cleanup === */
    /* offset 136 */ mov.b  @(1,r8),r0          /* R0 = COMM0_LO */
    /* offset 138 */ cmp/eq #0x22,r0            /* Is it another cmd22? */
    /* offset 140 */ bt     .param_read         /* Yes → re-dispatch */
    /* offset 142 */ tst    r0,r0               /* Is COMM0_LO zero? */
    /* offset 144 */ bf     .other_cmd          /* Non-zero → different command */

    /* === CLEAN EXIT: Truly idle, COMM0_HI already cleared above === */
    /* offset 146 */ lds.l  @r15+,pr            /* Restore PR */
    /* offset 148 */ rts                        /* Return to dispatch loop */
    /* offset 150 */ nop                        /* [delay slot] */

.other_cmd:
    /* === OTHER COMMAND: COMM0_HI was cleared above, restore trigger for dispatch loop === */
    /* offset 152 */ mov    #1,r0               /* R0 = 1 */
    /* offset 154 */ mov.b  r0,@(0,r8)          /* COMM0_HI = $01 (dispatch loop will read COMM0_LO) */
    /* offset 156 */ lds.l  @r15+,pr            /* Restore PR */
    /* offset 158 */ rts                        /* Return to dispatch loop */
    /* offset 160 */ nop                        /* [delay slot] */

/* === LITERAL POOL ===
 * Code ends at offset 162 (81 instructions × 2B = 162B).
 * Pool (14 bytes):
 *   offset 162 ($301192): .stride     = $0200 (2 bytes)
 *   offset 164 ($301194): .comm_base  = $20004020 (4 bytes)
 *   offset 168 ($301198): .a0_prefix  = $06000000 (4 bytes)
 *   offset 172 ($30119C): .a1_prefix  = $04000000 (4 bytes)
 * Total: 162 + 14 = 176 bytes
 */
.align 1
.stride:
    .word   0x0200                  /* Row stride (512 bytes = 256 words) */
.align 2
.comm_base:
    .long   0x20004020              /* COMM register base (cache-through) */
.a0_prefix:
    .long   0x06000000              /* SDRAM native read prefix (src) */
.a1_prefix:
    .long   0x04000000              /* Cached framebuffer write prefix (dst) */

/* Total: 162 bytes code + 14 bytes pool = 176 bytes */

.global cmd22_single_shot
