/*
 * func_034: Span Filler / Edge Interpolation
 * ROM File Offset: 0x2375C - 0x237D5 (122 bytes)
 * SH2 Address: 0x0222375C - 0x022237D5
 *
 * Purpose: Calculates interpolated edge values for scanline rendering.
 *          Sets up span data for horizontal line drawing in the rasterizer.
 *          Uses reciprocal table lookup for fast division.
 *
 * Called By: func_033 (render_quad)
 *
 * Input:
 *   R0  = Edge value A (written to output)
 *   R1  = Y1:X1 packed (high word: Y, low word: X)
 *   R2  = Y2:X2 packed
 *   R3  = Edge value B
 *   R9  = Output pointer
 *   R13 = Secondary output pointer
 *
 * Output:
 *   Writes interpolated span data to @R9 and @R13 output areas
 *
 * Note: First instruction ($2902) is shared as func_033's RTS delay slot.
 *       All instructions as .short to match ROM exactly.
 */

.section .text
.p2align 1    /* 2-byte alignment for 0x2375C start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_034: Span Filler Entry
 * Entry: 0x0222375C
 * ═══════════════════════════════════════════════════════════════════════════ */
func_034:
    /* Store first edge value and extract/compare coordinates */
    .short  0x2902                            /* $02375C: MOV.L R0,@R9 (store edge A) */
    .short  0x641F                            /* $02375E: EXTS.W R1,R4 (X1 sign-extend) */
    .short  0x652F                            /* $023760: EXTS.W R2,R5 (X2 sign-extend) */
    .short  0x3543                            /* $023762: CMP/GE R4,R5 (X2 >= X1?) */
    .short  0x8902                            /* $023764: BT .no_swap (+4) */

    /* Swap R1 and R2 if out of order */
    .short  0x6413                            /* $023766: MOV R1,R4 */
    .short  0x6123                            /* $023768: MOV R2,R1 */
    .short  0x6243                            /* $02376A: MOV R4,R2 */

.no_swap:
    /* Extract high words (Y coordinates) via swap */
    .short  0x6419                            /* $02376C: SWAP.W R1,R4 */
    .short  0x644F                            /* $02376E: EXTS.W R4,R4 (Y1 sign-extend) */
    .short  0x6529                            /* $023770: SWAP.W R2,R5 */
    .short  0x655F                            /* $023772: EXTS.W R5,R5 (Y2 sign-extend) */

    /* Calculate delta-Y */
    .short  0x3458                            /* $023774: SUB R5,R4 (R4 = Y1 - Y2 = -deltaY) */

    /* Load reciprocal table limit */
    .short  0x9718                            /* $023776: MOV.W @(24,PC),R7 → 0x237B (max delta) */

    /* Calculate delta-X */
    .short  0x651F                            /* $023778: EXTS.W R1,R5 (X1) */
    .short  0x662F                            /* $02377A: EXTS.W R2,R6 (X2) */
    .short  0x3568                            /* $02377C: SUB R6,R5 (R5 = X1 - X2 = deltaX) */

    /* Check if delta exceeds table limit */
    .short  0x3757                            /* $02377E: CMP/GT R5,R7 (R7 > deltaX?) */
    .short  0x8916                            /* $023780: BT .small_delta (+44 → $0237B0) */

    /* ─────────────────────────────────────────────────────────────────────────
     * Large delta path: use reciprocal table lookup
     * ───────────────────────────────────────────────────────────────────────── */
    .short  0xD70A                            /* $023782: MOV.L @(10,PC),R7 → 0x060048D0 (recip table) */
    .short  0x4500                            /* $023784: SHLL R5 (deltaX * 2 for word offset) */
    .short  0x375C                            /* $023786: ADD R5,R7 (table + offset) */
    .short  0x6771                            /* $023788: MOV.W @R7,R7 (load reciprocal) */
    .short  0x274F                            /* $02378A: MULS.W R4,R7 (deltaY * reciprocal) */

    .short  0x651F                            /* $02378C: EXTS.W R1,R5 (X1) */
    .short  0x673F                            /* $02378E: EXTS.W R3,R7 (edge B sign-ext) */
    .short  0x041A                            /* $023790: STS MACL,R4 (interpolation result) */
    .short  0x3758                            /* $023792: SUB R5,R7 (edgeB - X1) */
    .short  0x4728                            /* $023794: SHLL16 R7 ((edgeB - X1) << 16) */
    .short  0x4408                            /* $023796: SHLL2 R4 (scale result) */
    .short  0x374D                            /* $023798: ADD.S R4,R7 (scaled position) */

    .short  0x633D                            /* $02379A: EXTU.W R3,R3 (zero-extend edge B) */
    .short  0x6419                            /* $02379C: SWAP.W R1,R4 (Y1) */
    .short  0x070A                            /* $02379E: STS MACH,R7 (high part of multiply) */
    .short  0x644F                            /* $0237A0: EXTS.W R4,R4 (Y1 sign-ext) */
    .short  0x374C                            /* $0237A2: ADD R4,R7 (R7 += Y1) */
    .short  0x4728                            /* $0237A4: SHLL16 R7 (R7 <<= 16) */
    .short  0x000B                            /* $0237A6: RTS */
    .short  0x237B                            /* $0237A8: [delay] MOV.L R7,@R3 */

/* ─────────────────────────────────────────────────────────────────────────────
 * Literal pool (8 bytes)
 * ───────────────────────────────────────────────────────────────────────────── */
.lit_max_delta:
    .short  0xFF01                            /* $0237AA: 0xFF01 (literal/padding) */
.lit_recip_table:
    .byte   0x06, 0x00, 0x48, 0xD0            /* $0237AC: 0x060048D0 - Reciprocal table */

/* ─────────────────────────────────────────────────────────────────────────────
 * Small delta path: direct calculation without table
 * ───────────────────────────────────────────────────────────────────────────── */
.small_delta:
    .short  0x651F                            /* $0237B0: EXTS.W R1,R5 (X1) */
    .short  0x673F                            /* $0237B2: EXTS.W R3,R7 (edge B) */
    .short  0x3758                            /* $0237B4: SUB R5,R7 (edgeB - X1) */
    .short  0x247F                            /* $0237B6: MULS.W R7,R4 ((edgeB - X1) * deltaY) */

    .short  0x9D0C                            /* $0237B8: MOV.W @(12,PC),R13 → output ptr */
    .short  0x662F                            /* $0237BA: EXTS.W R2,R6 (X2) */
    .short  0x3568                            /* $0237BC: SUB R6,R5 (deltaX) */
    .short  0x071A                            /* $0237BE: STS MACL,R7 (multiply result) */
    .short  0x1D50                            /* $0237C0: MOV.L R5,@(0,R13) (store deltaX) */
    .short  0x1D71                            /* $0237C2: MOV.L R7,@(4,R13) (store interp value) */

    .short  0x633D                            /* $0237C4: EXTU.W R3,R3 (zero-extend edge B) */
    .short  0x6419                            /* $0237C6: SWAP.W R1,R4 (Y1) */
    .short  0x644F                            /* $0237C8: EXTS.W R4,R4 (Y1 sign-ext) */
    .short  0x57D7                            /* $0237CA: MOV.L @(28,R13),R7 (load from output) */
    .short  0x374C                            /* $0237CC: ADD R4,R7 (R7 += Y1) */
    .short  0x4728                            /* $0237CE: SHLL16 R7 (R7 <<= 16) */
    .short  0x000B                            /* $0237D0: RTS */
    .short  0x237B                            /* $0237D2: [delay] MOV.L R7,@R3 */

/* Literal for small_delta path output pointer */
.lit_small_output:
    .short  0xFF00                            /* $0237D4: Literal/padding */

/* ============================================================================
 * End of func_034 (120 bytes)
 *
 * Analysis:
 * - Bresenham-style edge interpolation for polygon rasterizer
 * - Two paths: large delta uses reciprocal table, small delta uses direct calc
 * - Reciprocal table at 0x060048D0 allows division via multiplication
 * - MULS.W for 16-bit signed multiplication (edge interpolation)
 * - SHLL16/SHLL2 for fixed-point scaling
 * - Both paths end with storing result via MOV.L R7,@R3
 * ============================================================================ */
