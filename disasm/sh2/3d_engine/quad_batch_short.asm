/*
 * func_018: Quad Batch Processor
 * ROM File Offset: 0x233A4 - 0x23413 (112 bytes)
 * SH2 Address: 0x022233A4 - 0x02223413
 *
 * Purpose: Main quad batch processing loop. Processes a batch of quads
 *          by calling func_020 (recursive quad processor) for each vertex.
 *
 * Type: Coordinator
 * Called By: Rendering pipeline
 * Calls: func_020 (conditional, 4× per quad)
 *
 * Input:
 *   R0  = Initial control value
 *   R6  = Quad data pointer
 *   R7  = Quad count (loop counter)
 *   R10 = Output buffer pointer
 *   R11 = State/context pointer
 *   R14 = RenderingContext pointer
 *
 * Stack Usage:
 *   Saves: R6, R7, R10, PR (for nested calls)
 *
 * Note: All instructions as .short to match ROM exactly.
 */

.section .text
.p2align 1    /* 2-byte alignment for 0x233A4 start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_018: Quad Batch Processor
 * Entry: 0x022233A4
 * ═══════════════════════════════════════════════════════════════════════════ */
func_018:
    /* Initialize output buffer */
    .short  0xE100                            /* $0233A4: MOV #0,R1 */
    .short  0x2A12                            /* $0233A6: MOV.L R1,@R10 (clear header) */
    .short  0x7AFC                            /* $0233A8: ADD #-4,R10 */
    .short  0x4001                            /* $0233AA: SHLR R0 */
    .short  0x1E02                            /* $0233AC: MOV.L R0,@(8,R14) */

    /* Save registers for nested calls */
    .short  0x2F66                            /* $0233AE: MOV.L R6,@-R15 */
    .short  0x2F76                            /* $0233B0: MOV.L R7,@-R15 */
    .short  0x2FA6                            /* $0233B2: MOV.L R10,@-R15 */

.loop_start:
    /* Vertex 1: Check and process */
    .short  0xC9FF                            /* $0233B4: AND #0xFF,R0 */
    .short  0x8800                            /* $0233B6: CMP/EQ #0,R0 */
    .short  0x8901                            /* $0233B8: BT .skip_v1 (+2) */
    .short  0xB071                            /* $0233BA: BSR func_020 (+226 → $0234A0) */
    .short  0x4F22                            /* $0233BC: [delay] STS.L PR,@-R15 */
.skip_v1:
    .short  0x7BF0                            /* $0233BE: ADD #-16,R11 */

    /* Vertex 2: Check and process */
    .short  0x84EA                            /* $0233C0: MOV.W @(20,R14),R0 */
    .short  0x8800                            /* $0233C2: CMP/EQ #0,R0 */
    .short  0x8901                            /* $0233C4: BT .skip_v2 (+2) */
    .short  0xB06B                            /* $0233C6: BSR func_020 (+214 → $0234A0) */
    .short  0x4F22                            /* $0233C8: [delay] STS.L PR,@-R15 */
.skip_v2:
    .short  0x7BF0                            /* $0233CA: ADD #-16,R11 */

    /* Vertex 3: Check and process */
    .short  0x84E9                            /* $0233CC: MOV.W @(18,R14),R0 */
    .short  0x8800                            /* $0233CE: CMP/EQ #0,R0 */
    .short  0x8901                            /* $0233D0: BT .skip_v3 (+2) */
    .short  0xB065                            /* $0233D2: BSR func_020 (+202 → $0234A0) */
    .short  0x4F22                            /* $0233D4: [delay] STS.L PR,@-R15 */
.skip_v3:
    .short  0x7BF0                            /* $0233D6: ADD #-16,R11 */

    /* Vertex 4: Check and process */
    .short  0x84E8                            /* $0233D8: MOV.W @(16,R14),R0 */
    .short  0x8800                            /* $0233DA: CMP/EQ #0,R0 */
    .short  0x8901                            /* $0233DC: BT .skip_v4 (+2) */
    .short  0xB05F                            /* $0233DE: BSR func_020 (+190 → $0234A0) */
    .short  0x4F22                            /* $0233E0: [delay] STS.L PR,@-R15 */
.skip_v4:

    /* Restore and loop */
    .short  0x6AF6                            /* $0233E2: MOV.L @R15+,R10 */
    .short  0x67F6                            /* $0233E4: MOV.L @R15+,R7 */
    .short  0x66F6                            /* $0233E6: MOV.L @R15+,R6 */
    .short  0x4710                            /* $0233E8: DT R7 */
    .short  0x8FD1                            /* $0233EA: BF/S .loop_start (-94 → $0233B4) */
    .short  0x7BF0                            /* $0233EC: [delay] ADD #-16,R11 */

    /* Exit via alternate path */
    .short  0xAFD6                            /* $0233EE: BRA .exit (-84 → $0239A... wait) */
    .short  0x0009                            /* $0233F0: [delay] NOP */

/* ─────────────────────────────────────────────────────────────────────────────
 * Alternate entry / secondary processing path
 * ───────────────────────────────────────────────────────────────────────────── */
.alternate_path:
    .short  0x4F22                            /* $0233F2: STS.L PR,@-R15 */
    .short  0xBFB8                            /* $0233F4: BSR func_016 (-144 → $023368) */
    .short  0x0009                            /* $0233F6: [delay] NOP */

.check_loop:
    .short  0x60A2                            /* $0233F8: MOV.B @R10,R0 */
    .short  0xD105                            /* $0233FA: MOV.L @(5,PC),R1 → .mask_literal */
    .short  0x2018                            /* $0233FC: TST R1,R0 */
    .short  0x8B09                            /* $0233FE: BF .exit (+18 → $023414) */
    .short  0x7AFC                            /* $023400: ADD #-4,R10 */
    .short  0x4710                            /* $023402: DT R7 */
    .short  0x8FF8                            /* $023404: BF/S .check_loop (-16 → $0233F8) */
    .short  0x7BC0                            /* $023406: [delay] ADD #-64,R11 */

.exit:
    .short  0x4F26                            /* $023408: LDS.L @R15+,PR */
    .short  0x000B                            /* $02340A: RTS */
    .short  0x0009                            /* $02340C: [delay] NOP */

/* ─────────────────────────────────────────────────────────────────────────────
 * Literal pool
 * ───────────────────────────────────────────────────────────────────────────── */
.mask_literal:
    .short  0x0000                            /* $02340E: High word of 0x0000FF00 */
    .short  0xFF00                            /* $023410: Low word of 0x0000FF00 */
    .short  0xFF00                            /* $023412: Padding/constant */

/* ============================================================================
 * End of func_018 (112 bytes)
 *
 * Analysis:
 * - Processes 4 vertices per quad via conditional BSR to func_020
 * - Uses visibility flags from context at offsets 16, 18, 20
 * - R11 decremented by 16 for each vertex (64 bytes per quad state stride)
 * - Stack heavy due to saves/restores each iteration
 * - Alternate path calls func_016 for coordinate transformation
 * ============================================================================ */
