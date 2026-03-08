/*
 * cmd22_single_shot — Single-Shot 2D Block Copy Handler (cmd $22)
 * Expansion ROM Address: $3010F0 (SH2: $023010F0)
 * Size: 136 bytes (122 bytes code + 14 bytes literal pool)
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
 *   R1 = Words per row (from COMM2_LO = D0/2)
 *   R2 = Height / row count (from COMM3_HI = D1)
 *   R3 = Source pointer (A0 reconstructed: $06 | COMM3_LO:COMM4)
 *   R4 = A0[15:0] temp; current dest pointer within row (inner loop)
 *   R5 = A1[31:16] temp; words remaining in current row (inner loop)
 *   R6 = A1[15:0] temp during param read; Row stride ($0200) during copy
 *   R7 = Word being copied / prefix constant temp
 *   R8 = 1 during copy (clobbers COMM base); reloaded to $20004020 after copy
 *
 * PC-relative alignment notes:
 *   NOP at offset 34: .a0_prefix MOV.L at offset 36 (36%4=0 ✓)
 *   .a1_prefix MOV.L at offset 48 (48%4=0 ✓)
 *   NOP at offset 78: .comm_base MOV.L at offset 80 (80%4=0 ✓)
 *
 * Pool layout (offsets from function start, base=$3010F0):
 *   offset 122 ($30116A): .stride     = $0200 (2 bytes)
 *   offset 124 ($30116C): .comm_base  = $20004020 (4 bytes)
 *   offset 128 ($301170): .a0_prefix  = $06000000 (4 bytes)
 *   offset 132 ($301174): .a1_prefix  = $04000000 (4 bytes)
 *   Total pool: 14 bytes → grand total: 136 bytes
 *
 * Algorithm:
 *   do {
 *     read ALL params from COMM2-6 into registers, THEN clear COMM0_LO
 *     reconstruct A0 ($06xxxxxx), A1 ($04xxxxxx)
 *     for (row = 0; row < height; row++) {
 *       dest = base;
 *       for (word = 0; word < width; word++)
 *         *dest++ = *src++;
 *       base += 0x200;
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

    /* offset 36 */ mov.l   @(.a0_prefix,pc),r7 /* R7=$06000000 [PC=base+40, target=base+128, disp=88/4=22 ✓] */
    /* offset 38 */ or      r7,r3               /* R3 = $06xxxxxx (A0: SDRAM native) */

    /* === A1 RECONSTRUCTION: mask top byte, apply $04 prefix === */
    /* offset 40 */ shll16  r5                  /* R5 = A1[31:16] << 16 */
    /* offset 42 */ or      r6,r5               /* R5 = A1 raw (R6=A1[15:0] from offset 24) */
    /* offset 44 */ shll8   r5                  /* R5 <<= 8 (shift top byte out) */
    /* offset 46 */ shlr8   r5                  /* R5 >>= 8 (top byte now $00) */
    /* offset 48 */ mov.l   @(.a1_prefix,pc),r7 /* R7=$04000000 [PC=base+52, target=base+132, disp=80/4=20 ✓] */
    /* offset 50 */ or      r7,r5               /* R5 = $04xxxxxx (A1: cached framebuffer) */
    /* offset 52 */ mov     r5,r0               /* R0 = A1 dest base (loop uses R0) */

    /* === BLOCK COPY SETUP === */
    /* offset 54 */ mov.w   @(.stride,pc),r6    /* R6=$0200 [PC=base+58, target=base+122, disp=64/2=32 ✓] */
    /* offset 56 */ mov     #1,r8               /* R8 = 1 (loop constant; clobbers COMM base) */

    /* === OUTER LOOP: Row Iterator === */
.row_loop:
    /* offset 58 */ mov     r0,r4               /* R4 = dest row start */
    /* offset 60 */ mov     r1,r5               /* R5 = words per row */

    /* === INNER LOOP: Word Copy === */
.copy_word:
    /* offset 62 */ mov.w   @r3+,r7             /* R7 = *src++; read word */
    /* offset 64 */ mov.w   r7,@r4              /* *dest = R7; write word */
    /* offset 66 */ dt      r5                  /* R5-- and test zero */
    /* offset 68 */ bf/s    .copy_word          /* Branch if words remain */
    /* offset 70 */ add     #2,r4               /* [delay slot] dest += 2 */

    /* === ROW COMPLETE === */
    /* offset 72 */ dt      r2                  /* R2-- (row counter) */
    /* offset 74 */ bf/s    .row_loop           /* Branch if rows remain */
    /* offset 76 */ add     r6,r0               /* [delay slot] dest base += stride */

    /* === COMPLETION: Race-safe inline cleanup + re-dispatch === */
    /* === ALIGNMENT NOP: offset 78 → .comm_base MOV.L at offset 80 (80%4=0 ✓) === */
    /* offset 78 */ nop

    /* Reload COMM base (clobbered to 1 by copy loop) */
    /* offset 80 */ mov.l   @(.comm_base,pc),r8 /* R8=$20004020 [PC=base+84, target=base+124, disp=40/4=10 ✓] */

    /* === COMM1 cleanup (func_084 equivalent) === */
    /* offset 82 */ mov     #0,r0               /* R0 = 0 */
    /* offset 84 */ mov.w   r0,@(2,r8)          /* COMM1_HI:LO = $0000 (word write at offset 2) */
    /* offset 86 */ mov.b   @(3,r8),r0          /* R0 = COMM1_LO (just cleared = 0) */
    /* offset 88 */ or      #1,r0               /* R0 |= 1 (set bit 0: "command done") */
    /* offset 90 */ mov.b   r0,@(3,r8)          /* COMM1_LO = 1 */

    /* === Clear COMM0_HI via byte write — preserves COMM0_LO === */
    /* offset 92 */ mov     #0,r0               /* R0 = 0 */
    /* offset 94 */ mov.b   r0,@(0,r8)          /* COMM0_HI = 0 (byte write only!) */

    /* === Race-safe re-check: 68K may have written COMM0_LO during cleanup === */
    /* offset 96 */ mov.b   @(1,r8),r0          /* R0 = COMM0_LO */
    /* offset 98 */ cmp/eq  #0x22,r0            /* Is it another cmd22? */
    /* offset 100 */ bt     .param_read         /* Yes → re-dispatch [disp=(2-104)/2=-51 ✓] */
    /* offset 102 */ tst    r0,r0               /* Is COMM0_LO zero? */
    /* offset 104 */ bf     .other_cmd          /* Non-zero → different command [disp=(112-108)/2=2 ✓] */

    /* === CLEAN EXIT: Truly idle, COMM0_HI already cleared above === */
    /* offset 106 */ lds.l  @r15+,pr            /* Restore PR */
    /* offset 108 */ rts                        /* Return to dispatch loop */
    /* offset 110 */ nop                        /* [delay slot] */

.other_cmd:
    /* === OTHER COMMAND: COMM0_HI was cleared above, restore trigger for dispatch loop === */
    /* offset 112 */ mov    #1,r0               /* R0 = 1 */
    /* offset 114 */ mov.b  r0,@(0,r8)          /* COMM0_HI = $01 (dispatch loop will read COMM0_LO) */
    /* offset 116 */ lds.l  @r15+,pr            /* Restore PR */
    /* offset 118 */ rts                        /* Return to dispatch loop */
    /* offset 120 */ nop                        /* [delay slot] */

/* === LITERAL POOL ===
 * Code ends at offset 122 (61 instructions × 2B = 122B).
 * Pool (14 bytes):
 *   offset 122 ($30116A): .stride     = $0200 (2 bytes)
 *   offset 124 ($30116C): .comm_base  = $20004020 (4 bytes)
 *   offset 128 ($301170): .a0_prefix  = $06000000 (4 bytes)
 *   offset 132 ($301174): .a1_prefix  = $04000000 (4 bytes)
 * Total: 122 + 14 = 136 bytes
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

/* Total: 122 bytes code + 14 bytes pool = 136 bytes */

.global cmd22_single_shot
