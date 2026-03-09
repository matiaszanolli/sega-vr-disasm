/*
 * func_007: Alternative Transform Loop (calls func_008)
 * ROM File Offset: 0x23178 - 0x231AB (52 bytes: 44 code + 8 literals)
 * SH2 Address: 0x02223178
 *
 * Purpose: Vertex transformation loop, nearly identical to func_005
 *          but calls func_008 instead of func_006 for the matrix multiply.
 *          Likely used for a different vertex/transform type.
 *
 * Type: Hub function (calls func_008 + indirect via JSR @R14)
 * Called By: func_001 (via BSR from entry point A)
 * Calls:
 *   - JSR @R14 (indirect function pointer)
 *   - func_008 @ $0231AC (alternate matrix × vector multiply)
 *
 * Note: All instructions manually encoded as .short to match ROM exactly.
 */

.section .text
.p2align 1    /* 2-byte alignment for 0x23178 start */

func_007:
    /* ─────────────────────────────────────────────────────────────────────────
     * Prologue: Save registers
     * ───────────────────────────────────────────────────────────────────────── */
    .short  0x2FE6                            /* $023178: MOV.L R14,@-R15 */
    .short  0x4F22                            /* $02317A: STS.L PR,@-R15 */

    /* ─────────────────────────────────────────────────────────────────────────
     * Setup: Extract loop counter and load context fields
     * ───────────────────────────────────────────────────────────────────────── */
    .short  0x6BD5                            /* $02317C: EXTU.W R13,R11 (loop counter) */
    .short  0x5AEB                            /* $02317E: MOV.L @(44,R14),R10 (output ptr) */
    .short  0x5CE4                            /* $023180: MOV.L @(16,R14),R12 (coord offsets) */

    /* Extract X and Y offsets from packed R12 */
    .short  0x69C9                            /* $023182: SWAP.W R12,R9 */
    .short  0x699F                            /* $023184: EXTS.W R9,R9 */
    .short  0x6CCF                            /* $023186: EXTS.W R12,R12 */

    /* ─────────────────────────────────────────────────────────────────────────
     * Load parameters for transform function
     * ───────────────────────────────────────────────────────────────────────── */
    .short  0x53E6                            /* $023188: MOV.L @(24,R14),R3 */
    .short  0xD406                            /* $02318A: MOV.L @(6,PC),R4 → matrix ptr */
    .short  0xD506                            /* $02318C: MOV.L @(6,PC),R5 → vector ptr */

.loop_start:
    /* ─────────────────────────────────────────────────────────────────────────
     * Call indirect function via R14 (vertex setup?)
     * ───────────────────────────────────────────────────────────────────────── */
    .short  0x5EE7                            /* $02318E: MOV.L @(28,R14),R14 */
    .short  0x4E0B                            /* $023190: JSR @R14 */
    .short  0x60D5                            /* $023192: [delay] EXTU.W R13,R0 */

    /* ─────────────────────────────────────────────────────────────────────────
     * Call func_008: Alternate Matrix × Vector multiplication
     * ───────────────────────────────────────────────────────────────────────── */
    .short  0xB00A                            /* $023194: BSR func_008 (at 0x231AC) */
    .short  0x0028                            /* $023196: [delay] CLRMAC */

    /* ─────────────────────────────────────────────────────────────────────────
     * Loop: Decrement counter and advance pointer
     * ───────────────────────────────────────────────────────────────────────── */
    .short  0x4B10                            /* $023198: DT R11 */
    .short  0x8FF9                            /* $02319A: BF/S .loop_start */
    .short  0x7A10                            /* $02319C: [delay] ADD #16,R10 */

    /* ─────────────────────────────────────────────────────────────────────────
     * Epilogue: Restore registers and return
     * ───────────────────────────────────────────────────────────────────────── */
    .short  0x4F26                            /* $02319E: LDS.L @R15+,PR */
    .short  0x000B                            /* $0231A0: RTS */
    .short  0x6EF6                            /* $0231A2: [delay] MOV.L @R15+,R14 */

/* ─────────────────────────────────────────────────────────────────────────────
 * Literal Pool
 * ───────────────────────────────────────────────────────────────────────────── */
.lit_matrix_ptr:
    .byte   0xC0, 0x00, 0x07, 0x40            /* $0231A4: 0xC0000740 - Matrix data */

.lit_vector_ptr:
    .byte   0xC0, 0x00, 0x07, 0x70            /* $0231A8: 0xC0000770 - Vector data */

/* ============================================================================
 * End of func_007 (52 bytes: 44 code + 8 literals)
 *
 * Key differences from func_005:
 * - Calls func_008 instead of func_006
 * - Loads R3 from @(24,R14) instead of R7 from @(8,R14)
 * - Matrix pointer is 0xC0000740 vs 0xC0000760
 * - No MOV.W literal load (no output base offset)
 * ============================================================================ */
