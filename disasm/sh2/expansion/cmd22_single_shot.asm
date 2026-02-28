/*
 * cmd22_single_shot — Single-Shot 2D Block Copy Handler (cmd $22)
 * Expansion ROM Address: $3010F0 (SH2: $023010F0)
 * Size: 108 bytes (92 bytes code + 16 bytes literal pool)
 *
 * B-004 v6-corrected: COMM2_HI-safe by construction + params-consumed handshake.
 *
 * The 68K sender writes A0 as a longword to COMM3:4 ($A15126), briefly setting
 * COMM3_HI=$06, then immediately overwrites it with D1 (height). COMM2_HI
 * ($A15124) is NEVER written — stays $00 permanently. The Slave SH2 polls
 * COMM2_HI every ~25 cycles; it never becomes non-zero, so no spurious dispatch.
 *
 * Params-consumed handshake (new in v6-corrected):
 *   - SH2 clears COMM0_LO=$00 immediately after reading all params
 *   - 68K sender polls COMM0_LO==0 after writing trigger before returning
 *   - This prevents the 68K from overwriting COMM2-6 while SH2 is still reading
 *
 * COMM Register Layout (68K write order, SH2 read perspective, R8 = $20004020):
 *   COMM0_HI (offset 0):  $01 — trigger (written LAST by 68K)
 *   COMM0_LO (offset 1):  $22 — dispatch index; cleared to $00 by SH2 (handshake)
 *   COMM1    (offsets 2,3): UNTOUCHED
 *   COMM2_HI (offset 4):  $00 — NEVER WRITTEN (Slave's work-cmd poll byte)
 *   COMM2_LO (offset 5):  D0/2 (words per row, pre-divided by 68K)
 *   COMM3_HI (offset 6):  D1 (height in rows, overwrites A0 top-byte $06)
 *   COMM3_LO (offset 7):  A0[23:16] (src ptr byte 2)
 *   COMM4_HI (offset 8):  A0[15:8]  (src ptr byte 1)
 *   COMM4_LO (offset 9):  A0[7:0]   (src ptr byte 0)
 *   COMM5_HI (offset 10): A1[31:24] (dst ptr top byte — $04 or $24, masked to $04)
 *   COMM5_LO (offset 11): A1[23:16]
 *   COMM6_HI (offset 12): A1[15:8]
 *   COMM6_LO (offset 13): A1[7:0]
 *   COMM7    (offsets 14,15): UNTOUCHED
 *
 * DISPATCH: Master SH2 dispatch loop reads COMM0_HI until non-zero (trigger),
 * then reads COMM0_LO as dispatch index. SHLL2 on COMM0_LO=$22 → offset $88
 * into jump table at $06000780 → entry at $06000808 = $023010F0 (this handler).
 *
 * Entry: R8 = $20004020 (COMM base, set by dispatch loop before JSR)
 *
 * SH2 @(disp,Rn) CONSTRAINT:
 *   - MOV.B @(disp,Rn),R0 and MOV.W @(disp,Rn),R0: destination MUST be R0
 *   - MOV.B R0,@(disp,Rn): source MUST be R0
 *   All COMM reads route through R0, then transfer to target register.
 *   The params-consumed store also uses R0 (load #0 into R0, then store).
 *
 * Register Mapping:
 *   R0 = scratch (all @(disp,R8) reads/writes go through R0); final: A1 dest base
 *   R1 = Words per row (from COMM2_LO = D0/2)
 *   R2 = Height / row count (from COMM3_HI = D1)
 *   R3 = Source pointer (A0 reconstructed: $06 | COMM3_LO:COMM4)
 *   R4 = A0[15:0] temp; current dest pointer within row (inner loop)
 *   R5 = A1[31:16] temp; words remaining in current row (inner loop)
 *   R6 = Row stride ($0200 = 512 bytes)
 *   R7 = Word being copied / prefix constant temp
 *   R8 = 1 (loop constant, clobbers COMM base — restored by dispatch loop)
 *
 * A0 Reconstruction:
 *   R0 = MOV.B @(7,R8) → EXTU.B R0,R3 → R3 = A0[23:16]
 *   R0 = MOV.W @(8,R8) → EXTU.W R0,R4 → R4 = A0[15:0]
 *   SHLL16 R3 → R3 = A0[23:16] << 16
 *   OR R4,R3 → R3 = A0[23:0]
 *   MOV.L @(.a0_prefix,PC),R7 → R7 = $06000000
 *   OR R7,R3 → R3 = $06xxxxxx (SDRAM read, native address)
 *
 * A1 Reconstruction:
 *   R0 = MOV.W @(10,R8) → MOV R0,R5 → R5 = A1[31:16]
 *   R0 = MOV.W @(12,R8) → EXTU.W R0,R0 → R0 = A1[15:0]
 *   SHLL16 R5 → R5 = A1[31:16] << 16
 *   OR R0,R5 → R5 = A1 raw (top byte $04 or $24)
 *   SHLL8/SHLR8 R5 → mask top byte to $00
 *   MOV.L @(.a1_prefix,PC),R7 → R7 = $04000000
 *   OR R7,R5 → R5 = $04xxxxxx (cached framebuffer write, same as original handler)
 *   MOV R5,R0 → R0 = A1 dest base for loop
 *
 * PC-relative MOV.L alignment: instruction offset must be ≡ 0 mod 4 so that
 * PC (= instr_addr + 4) is 4-byte aligned and displacement is a multiple of 4.
 * Two alignment NOPs:
 *   NOP at offset 34: moves .a0_prefix MOV.L to offset 36 (36%4=0 ✓)
 *   NOP at offset 78: moves .func084 MOV.L to offset 80 (80%4=0 ✓)
 *   .a1_prefix MOV.L naturally at offset 48 (48%4=0 ✓)
 *   .stride MOV.W at offset 54 (54%2=0 ✓)
 *
 * Pool layout (offsets from function start, base=$3010F0):
 *   offset 92 ($30114C): .stride    = $0200 (2 bytes)
 *   offset 94 ($30114E): pad        = 2 bytes (.align 2)
 *   offset 96 ($301150): .func084   = $060043F0 (4 bytes)
 *   offset 100 ($301154): .a0_prefix = $06000000 (4 bytes)
 *   offset 104 ($301158): .a1_prefix = $04000000 (4 bytes)
 *   Total pool: 16 bytes → grand total: 108 bytes
 *
 * Completion: calls func_084 ($060043F0) which clears COMM0_HI to $00
 * (separate from the COMM0_LO handshake). The 68K polls COMM0_HI==0 at
 * the start of the next call, not during this one.
 *
 * Algorithm:
 *   for (row = 0; row < R2; row++) {
 *       dest = R0;
 *       for (word = 0; word < R1; word++)
 *           *dest++ = *src++;
 *       R0 += 0x200;
 *   }
 */

.section .text
.align 2

cmd22_single_shot:
    /* === PARAM READ: Scalar params (D1 → R2, D0/2 → R1) === */
    /* offset  0 */ sts.l   pr,@-r15            /* Save PR */
    /* offset  2 */ mov.b   @(6,r8),r0          /* R0 = COMM3_HI = D1 (height) */
    /* offset  4 */ extu.b  r0,r2               /* R2 = height (zero-extended) */
    /* offset  6 */ mov.b   @(5,r8),r0          /* R0 = COMM2_LO = D0/2 (words/row) */
    /* offset  8 */ extu.b  r0,r1               /* R1 = words/row (zero-extended) */

    /* === PARAMS-CONSUMED SIGNAL: clear COMM0_LO=$00 → 68K can return === */
    /* offset 10 */ mov     #0,r0               /* R0 = 0 */
    /* offset 12 */ mov.b   r0,@(1,r8)          /* COMM0_LO = $00 (params read; 68K .wait_consumed exits) */

    /* === PARAM READ: A0 components (COMM3_LO → R3, COMM4 → R4) === */
    /* offset 14 */ mov.b   @(7,r8),r0          /* R0 = COMM3_LO = A0[23:16] — R0 only! */
    /* offset 16 */ extu.b  r0,r3               /* R3 = A0[23:16] (zero-extended) */
    /* offset 18 */ mov.w   @(8,r8),r0          /* R0 = COMM4 word = A0[15:0] — R0 only! */
    /* offset 20 */ extu.w  r0,r4               /* R4 = A0[15:0] (zero-extended) */

    /* === PARAM READ: A1 components (COMM5 → R5, COMM6 → R0) === */
    /* offset 22 */ mov.w   @(10,r8),r0         /* R0 = COMM5 word = A1[31:16] — R0 only! */
    /* offset 24 */ mov     r0,r5               /* R5 = A1[31:16] (save before next read) */
    /* offset 26 */ mov.w   @(12,r8),r0         /* R0 = COMM6 word = A1[15:0] — R0 only! */
    /* offset 28 */ extu.w  r0,r0               /* R0 = A1[15:0] (zero-extended) */

    /* === A0 RECONSTRUCTION: $06 | COMM3_LO[23:16] | COMM4[15:0] === */
    /* offset 30 */ shll16  r3                  /* R3 = A0[23:16] << 16 */
    /* offset 32 */ or      r4,r3               /* R3 = A0[23:0] */

    /* === ALIGNMENT NOP: offset 34 → .a0_prefix MOV.L at offset 36 (36%4=0 ✓) === */
    /* offset 34 */ nop

    /* offset 36 */ mov.l   @(.a0_prefix,pc),r7 /* R7=$06000000 [PC=base+40, target=base+100, disp=60, 60/4=15 ✓] */
    /* offset 38 */ or      r7,r3               /* R3 = $06xxxxxx (A0: SDRAM native) */

    /* === A1 RECONSTRUCTION: $24 | COMM5[31:16] | COMM6[15:0], masked === */
    /* offset 40 */ shll16  r5                  /* R5 = A1[31:16] << 16 */
    /* offset 42 */ or      r0,r5               /* R5 = A1 raw (top byte $04 or $24) */
    /* offset 44 */ shll8   r5                  /* R5 <<= 8 (shift top byte out) */
    /* offset 46 */ shlr8   r5                  /* R5 >>= 8 (top byte now $00) */
    /* offset 48 */ mov.l   @(.a1_prefix,pc),r7 /* R7=$04000000 [PC=base+52, target=base+104, disp=52, 52/4=13 ✓] */
    /* offset 50 */ or      r7,r5               /* R5 = $04xxxxxx (A1: cached framebuffer, same as original handler) */
    /* offset 52 */ mov     r5,r0               /* R0 = A1 dest base (loop uses R0) */

    /* === BLOCK COPY SETUP === */
    /* offset 54 */ mov.w   @(.stride,pc),r6    /* R6=$0200 [PC=base+58, target=base+92, disp=34, 34/2=17 ✓] */
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

    /* === ALIGNMENT NOP: offset 78 → .func084 MOV.L at offset 80 (80%4=0 ✓) === */
    /* offset 78 */ nop

    /* === COMPLETION: Clear COMM0_HI via func_084 === */
    /* offset 80 */ mov.l   @(.func084,pc),r0   /* R0=$060043F0 [PC=base+84, target=base+96, disp=12, 12/4=3 ✓] */
    /* offset 82 */ jsr     @r0                 /* Call func_084 (clears COMM0_HI, sets COMM1_LO bit 0) */
    /* offset 84 */ nop                         /* [delay slot] */
    /* offset 86 */ lds.l   @r15+,pr            /* Restore PR */
    /* offset 88 */ rts                         /* Return to dispatch loop */
    /* offset 90 */ nop                         /* [delay slot] */

/* === LITERAL POOL ===
 * Code ends at offset 92 (46 instructions × 2B = 92B).
 * Pool (16 bytes):
 *   offset 92 ($30114C): .stride    = $0200
 *   offset 94 ($30114E): pad 2B (.align 2: 94%4=2 → pad to 96)
 *   offset 96 ($301150): .func084   = $060043F0
 *   offset 100 ($301154): .a0_prefix = $06000000
 *   offset 104 ($301158): .a1_prefix = $04000000
 * Total: 92 + 16 = 108 bytes
 */
.align 1
.stride:
    .word   0x0200                  /* Row stride (512 bytes = 256 words) */
.align 2
.func084:
    .long   0x060043F0              /* func_084: clears COMM0_HI, sets COMM1_LO bit 0 */
.a0_prefix:
    .long   0x06000000              /* SDRAM native read prefix (src) */
.a1_prefix:
    .long   0x04000000              /* Cached framebuffer write prefix (dst) — same as original $06005198 handler */

/* Total: 92 bytes code + 16 bytes pool = 108 bytes */

.global cmd22_single_shot
