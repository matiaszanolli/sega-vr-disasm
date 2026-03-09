/*
 * func_012: Display List Entry Handler
 * ROM File Offset: 0x23278 - 0x232D3 (92 bytes: 78 code + 2 pad + 12 literals)
 * SH2 Address: 0x02223278
 *
 * Purpose: Processes a single display list entry by performing
 *          matrix transformation and calling result handlers.
 *          Called repeatedly by func_011 for each visible object.
 *
 * Type: Coordinator
 * Called By: func_011 (display list loop)
 * Calls:
 *   - func_008 @ $0231AC (alternate matrix multiply) - 4 times
 *   - func_009 @ $0231E4 (result packing)
 *
 * Note: All instructions manually encoded as .short to match ROM exactly.
 *       Original mnemonic source had translation errors (SWAP.W vs EXTU.B,
 *       0x06... vs 0xC0... literal addresses).
 */

.section .text
.p2align 1    /* 2-byte alignment for 0x23278 start */

func_012:
    /* ─────────────────────────────────────────────────────────────────────────
     * Prologue: Save PR and setup registers
     * ───────────────────────────────────────────────────────────────────────── */
    .short  0x4F22                            /* $023278: STS.L PR,@-R15 */
    .short  0x5CE4                            /* $02327A: MOV.L @(16,R14),R12 */

    /* Extract X and Y offsets (NOTE: 69C9 is SWAP.W, not EXTU.B!) */
    .short  0x69C9                            /* $02327C: SWAP.W R12,R9 */
    .short  0x699F                            /* $02327E: EXTS.W R9,R9 */
    .short  0x6CCF                            /* $023280: EXTS.W R12,R12 */

    /* Load transform parameters */
    .short  0x53E6                            /* $023282: MOV.L @(24,R14),R3 */
    .short  0xD410                            /* $023284: MOV.L @(16,PC),R4 → matrix ptr */
    .short  0xD511                            /* $023286: MOV.L @(17,PC),R5 → vector ptr */
    .short  0x5AE8                            /* $023288: MOV.L @(32,R14),R10 */

    /* ─────────────────────────────────────────────────────────────────────────
     * Transform pass 1: Call func_008 (matrix multiply)
     * ───────────────────────────────────────────────────────────────────────── */
    .short  0xBF8F                            /* $02328A: BSR func_008 (→$0231AC) */
    .short  0x0028                            /* $02328C: [delay] CLRMAC */
    .short  0x7A10                            /* $02328E: ADD #16,R10 */

    /* ─────────────────────────────────────────────────────────────────────────
     * Transform pass 2: Modify vector[0] and call func_008
     * ───────────────────────────────────────────────────────────────────────── */
    .short  0xD00F                            /* $023290: MOV.L @(15,PC),R0 → offset */
    .short  0x5150                            /* $023292: MOV.L @(0,R5),R1 */
    .short  0x310C                            /* $023294: ADD R0,R1 */
    .short  0x1510                            /* $023296: MOV.L R1,@(0,R5) */
    .short  0xBF88                            /* $023298: BSR func_008 (→$0231AC) */
    .short  0x0028                            /* $02329A: [delay] CLRMAC */
    .short  0x7A10                            /* $02329C: ADD #16,R10 */

    /* ─────────────────────────────────────────────────────────────────────────
     * Transform pass 3: Modify vector[2] and call func_008
     * ───────────────────────────────────────────────────────────────────────── */
    .short  0xD00C                            /* $02329E: MOV.L @(12,PC),R0 → offset */
    .short  0x5152                            /* $0232A0: MOV.L @(8,R5),R1 */
    .short  0x3108                            /* $0232A2: SUB R0,R1 */
    .short  0x1512                            /* $0232A4: MOV.L R1,@(8,R5) */
    .short  0xBF81                            /* $0232A6: BSR func_008 (→$0231AC) */
    .short  0x0028                            /* $0232A8: [delay] CLRMAC */
    .short  0x7A10                            /* $0232AA: ADD #16,R10 */

    /* ─────────────────────────────────────────────────────────────────────────
     * Transform pass 4: Modify vector[0] and call func_008
     * ───────────────────────────────────────────────────────────────────────── */
    .short  0xD008                            /* $0232AC: MOV.L @(8,PC),R0 → offset */
    .short  0x5150                            /* $0232AE: MOV.L @(0,R5),R1 */
    .short  0x3108                            /* $0232B0: SUB R0,R1 */
    .short  0x1510                            /* $0232B2: MOV.L R1,@(0,R5) */
    .short  0xBF7A                            /* $0232B4: BSR func_008 (→$0231AC) */
    .short  0x0028                            /* $0232B6: [delay] CLRMAC */

    /* ─────────────────────────────────────────────────────────────────────────
     * Finalize: Call result packer (func_009) and return
     * ───────────────────────────────────────────────────────────────────────── */
    .short  0x5CE8                            /* $0232B8: MOV.L @(32,R14),R12 */
    .short  0x5BE9                            /* $0232BA: MOV.L @(36,R14),R11 */
    .short  0xBF93                            /* $0232BC: BSR func_009 (→$0231E4) */
    .short  0x0009                            /* $0232BE: [delay] NOP */

    /* Epilogue: Restore PR and return */
    .short  0x4F26                            /* $0232C0: LDS.L @R15+,PR */
    .short  0x000B                            /* $0232C2: RTS */
    .short  0x1EB9                            /* $0232C4: [delay] MOV.L R11,@(36,R14) */

/* ─────────────────────────────────────────────────────────────────────────────
 * Literal Pool (must be at correct addresses for PC-relative loads)
 * ───────────────────────────────────────────────────────────────────────────── */
.lit_pad:
    .short  0x0000                            /* $0232C6: Padding for alignment */

.lit_matrix_ptr:
    .byte   0xC0, 0x00, 0x07, 0x40            /* $0232C8: 0xC0000740 - Matrix A */

.lit_vector_ptr:
    .byte   0xC0, 0x00, 0x07, 0x70            /* $0232CC: 0xC0000770 - Vector buffer */

.lit_offset:
    .byte   0x00, 0x20, 0x00, 0x00            /* $0232D0: 0x00200000 - Quad offset */

/* ============================================================================
 * End of func_012 (92 bytes: 78 code + 2 pad + 12 literals)
 *
 * Analysis:
 * - Four transform passes walk around quad corners:
 *   Pass 1: Original vector
 *   Pass 2: vector[0] += 0x200000
 *   Pass 3: vector[2] -= 0x200000
 *   Pass 4: vector[0] -= 0x200000
 * - Each pass calls func_008 (matrix multiply)
 * - Output advances by 16 bytes per pass (64 bytes total for quad)
 * - Final call to func_009 packs results for rasterization
 * ============================================================================ */
