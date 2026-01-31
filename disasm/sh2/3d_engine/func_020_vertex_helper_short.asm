/*
 * func_020: Vertex Processor Helper
 * ROM File Offset: 0x234A0 - 0x234C7 (40 bytes)
 * SH2 Address: 0x022234A0 - 0x022234C7
 *
 * Purpose: Helper function called by func_018/func_019 quad batch processors.
 *          Processes vertex data with loop, calling utility function.
 *
 * Type: Non-leaf function (calls utility at $02350A)
 * Called By: func_018, func_019
 *
 * Note: All instructions as .short to match ROM exactly.
 */

.section .text
.p2align 1    /* 2-byte alignment for 0x234A0 start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_020: Vertex Processor Helper
 * Entry: 0x022234A0
 * ═══════════════════════════════════════════════════════════════════════════ */
func_020:
    /* Save R11 and load initial data */
    .short  0x2FB6                              /* $0234A0: MOV.L R11,@-R15 */
    .short  0x61B5                              /* $0234A2: MOV.W @R11,R1 */
    .short  0xD807                              /* $0234A4: MOV.L @(28,PC),R8 → literal */
    .short  0x611D                              /* $0234A6: EXTU.W R1,R1 */
    .short  0x381C                              /* $0234A8: ADD R1,R8 */

.loop:
    /* Save context and call utility */
    .short  0x2FB6                              /* $0234AA: MOV.L R11,@-R15 */
    .short  0x2F06                              /* $0234AC: MOV.L R0,@-R15 */
    .short  0xB02C                              /* $0234AE: BSR $02350A (utility func) */
    .short  0x4F22                              /* $0234B0: [delay] STS.L PR,@-R15 */

    /* Restore context and loop */
    .short  0x60F6                              /* $0234B2: MOV.L @R15+,R0 */
    .short  0x6BF6                              /* $0234B4: MOV.L @R15+,R11 */
    .short  0x4010                              /* $0234B6: DT R0 (decrement and test) */
    .short  0x8BF3                              /* $0234B8: BF .loop (-26) */

    /* Restore and return */
    .short  0x6BF6                              /* $0234BA: MOV.L @R15+,R11 */
    .short  0x4F26                              /* $0234BC: LDS.L @R15+,PR */
    .short  0x000B                              /* $0234BE: RTS */
    .short  0x0009                              /* $0234C0: [delay] NOP */

/* ─────────────────────────────────────────────────────────────────────────────
 * Literal Pool
 * ───────────────────────────────────────────────────────────────────────────── */
    .short  0x0000                              /* $0234C2: Padding for alignment */
.lit_base_addr:
    .short  0x0601                              /* $0234C4: Base address literal */
    .short  0x0000                              /* $0234C6: (0x06010000) */

/* ============================================================================
 * End of func_020 (40 bytes)
 *
 * Analysis:
 * - Saves R11, loads base address from literal pool
 * - Loops R0 times, calling utility function at $02350A each iteration
 * - Uses R8 as computed address (base + offset from R11)
 * - Standard prologue/epilogue with PR save/restore
 * ============================================================================ */
