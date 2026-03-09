/*
 * func_005: Matrix Transform Loop with Indirect Dispatch
 * ROM File Offset: 0x230E8 - 0x2311F (56 bytes: 46 code + 2 pad + 8 literals)
 * SH2 Address: 0x022230E8
 *
 * Purpose: Vertex transformation loop that iterates over vertex data,
 *          applying matrix transforms via func_006 and dispatching
 *          through an indirect function pointer in R14.
 *
 * Type: Hub function (calls func_006 + indirect via JSR @R14)
 * Called By: func_001 (via BSR from entry point B)
 * Calls:
 *   - JSR @R14 (indirect function pointer)
 *   - func_006 @ $023120 (matrix × vector multiply)
 *
 * Note: All instructions manually encoded as .short to match ROM exactly.
 *       Previous mnemonic-based translation had errors (wrong opcodes).
 */

.section .text
.p2align 1    /* 2-byte alignment for 0x230E8 start */

func_005:
    /* ─────────────────────────────────────────────────────────────────────────
     * Prologue: Save registers
     * ───────────────────────────────────────────────────────────────────────── */
    .short  0x2FE6                            /* $0230E8: MOV.L R14,@-R15 */
    .short  0x4F22                            /* $0230EA: STS.L PR,@-R15 */

    /* ─────────────────────────────────────────────────────────────────────────
     * Setup: Extract loop counter and load context fields
     * ───────────────────────────────────────────────────────────────────────── */
    .short  0x6BD5                            /* $0230EC: EXTU.W R13,R11 (loop counter) */
    .short  0x5AEB                            /* $0230EE: MOV.L @(44,R14),R10 (output ptr) */
    .short  0x5CE4                            /* $0230F0: MOV.L @(16,R14),R12 (coord offsets) */

    /* Extract X and Y offsets from packed R12 */
    .short  0x69C9                            /* $0230F2: SWAP.W R12,R9 (not EXTU.B!) */
    .short  0x699F                            /* $0230F4: EXTS.W R9,R9 */
    .short  0x6CCF                            /* $0230F6: EXTS.W R12,R12 */

    /* ─────────────────────────────────────────────────────────────────────────
     * Load parameters for transform function
     * ───────────────────────────────────────────────────────────────────────── */
    .short  0x57E2                            /* $0230F8: MOV.L @(8,R14),R7 */
    .short  0xD407                            /* $0230FA: MOV.L @(7,PC),R4 → matrix ptr */
    .short  0xD507                            /* $0230FC: MOV.L @(7,PC),R5 → vector ptr */
    .short  0x960A                            /* $0230FE: MOV.W @(10,PC),R6 → output base */

.loop_start:
    /* ─────────────────────────────────────────────────────────────────────────
     * Call indirect function via R14 (vertex setup?)
     * ───────────────────────────────────────────────────────────────────────── */
    .short  0x5EE7                            /* $023100: MOV.L @(28,R14),R14 */
    .short  0x4E0B                            /* $023102: JSR @R14 */
    .short  0x60D5                            /* $023104: [delay] EXTU.W R13,R0 */

    /* ─────────────────────────────────────────────────────────────────────────
     * Call func_006: Matrix × Vector multiplication
     * ───────────────────────────────────────────────────────────────────────── */
    .short  0xB00B                            /* $023106: BSR func_006 (at 0x23120) */
    .short  0x0028                            /* $023108: [delay] CLRMAC */

    /* ─────────────────────────────────────────────────────────────────────────
     * Loop: Decrement counter and advance pointer
     * ───────────────────────────────────────────────────────────────────────── */
    .short  0x4B10                            /* $02310A: DT R11 */
    .short  0x8FF9                            /* $02310C: BF/S .loop_start */
    .short  0x7A10                            /* $02310E: [delay] ADD #16,R10 */

    /* ─────────────────────────────────────────────────────────────────────────
     * Epilogue: Restore registers and return
     * ───────────────────────────────────────────────────────────────────────── */
    .short  0x4F26                            /* $023110: LDS.L @R15+,PR */
    .short  0x000B                            /* $023112: RTS */
    .short  0x6EF6                            /* $023114: [delay] MOV.L @R15+,R14 */

/* ─────────────────────────────────────────────────────────────────────────────
 * Literal Pool
 * ───────────────────────────────────────────────────────────────────────────── */
.lit_output_base:
    .byte   0xFF, 0x00                        /* $023116: Output base offset (word) */

.lit_matrix_ptr:
    .byte   0xC0, 0x00, 0x07, 0x60            /* $023118: 0xC0000760 - Matrix data */

.lit_vector_ptr:
    .byte   0xC0, 0x00, 0x07, 0x70            /* $02311C: 0xC0000770 - Vector data */

/* ============================================================================
 * End of func_005 (56 bytes: 46 code + 2 pad + 8 literals)
 *
 * Corrections from original mnemonic translation:
 * - $0230F2: Was EXTU.B R12,R9, actually SWAP.W R12,R9 (69C9)
 * - $023108: Was SUB R2,R0, actually CLRMAC (0028)
 * ============================================================================ */
