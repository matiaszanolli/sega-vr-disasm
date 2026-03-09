/*
 * func_029: Visibility Edge Classifier with Exit Paths (func_030, func_031)
 * ROM File Offset: 0x23688 - 0x236D9 (82 bytes)
 * SH2 Address: 0x02223688 - 0x022236D9
 *
 * Purpose: Classifies quad edges for visibility determination.
 *          Compares vertex coordinates to set flags for rasterizer.
 *          Pairs with func_026 (X-axis) - this handles Y-axis.
 *
 * Addresses:
 *   func_029: 0x02223688 (main visibility classifier)
 *   func_030: 0x022236CA (shared exit with flag update)
 *   func_031: 0x022236D6 (minimal exit)
 *
 * Note: All instructions as .short to match ROM exactly.
 */

.section .text
.p2align 1    /* 2-byte alignment for 0x23688 start */

func_029:
    /* ─────────────────────────────────────────────────────────────────────────
     * Initialize: Load coordinate buffer and clear flags
     * ───────────────────────────────────────────────────────────────────────── */
    .short  0xD805                            /* $023688: MOV.L @(5,PC),R8 → coord buffer */
    .short  0x8580                            /* $02368A: MOV.W @(0,R8),R0 */
    .short  0xEA00                            /* $02368C: MOV #0,R10 (X flags) */
    .short  0xEB00                            /* $02368E: MOV #0,R11 (Y flags) */
    .short  0x6103                            /* $023690: MOV R0,R1 (min) */
    .short  0x6203                            /* $023692: MOV R0,R2 (max) */

    /* ─────────────────────────────────────────────────────────────────────────
     * Test coordinate pair 1
     * ───────────────────────────────────────────────────────────────────────── */
    .short  0x8582                            /* $023694: MOV.W @(4,R8),R0 */
    .short  0x3013                            /* $023696: CMP/GE R1,R0 */
    .short  0x8904                            /* $023698: BT .pair1_ge */
    .short  0xEA04                            /* $02369A: MOV #4,R10 */
    .short  0xA006                            /* $02369C: BRA .pair1_done */
    .short  0x6103                            /* $02369E: [delay] MOV R0,R1 */

    /* Literal pool (must be at 0x236A0 for PC-relative load) */
.lit_coord_buf:
    .byte   0xC0, 0x00, 0x07, 0x42            /* $0236A0: 0xC0000742 - Coord buffer Y offset */

.pair1_ge:
    .short  0x3203                            /* $0236A4: CMP/GE R0,R2 */
    .short  0x8901                            /* $0236A6: BT .pair2_setup */
    .short  0xEB04                            /* $0236A8: MOV #4,R11 */
    .short  0x6203                            /* $0236AA: MOV R0,R2 */

    /* ─────────────────────────────────────────────────────────────────────────
     * Test coordinate pair 2
     * ───────────────────────────────────────────────────────────────────────── */
.pair1_done:
.pair2_setup:
    .short  0x8584                            /* $0236AC: MOV.W @(8,R8),R0 */
    .short  0x3013                            /* $0236AE: CMP/GE R1,R0 */
    .short  0x8902                            /* $0236B0: BT .pair2_ge */
    .short  0xEA08                            /* $0236B2: MOV #8,R10 */
    .short  0xA004                            /* $0236B4: BRA .pair3_setup */
    .short  0x6103                            /* $0236B6: [delay] MOV R0,R1 */

.pair2_ge:
    .short  0x3203                            /* $0236B8: CMP/GE R0,R2 */
    .short  0x8901                            /* $0236BA: BT .pair3_setup */
    .short  0xEB08                            /* $0236BC: MOV #8,R11 */
    .short  0x6203                            /* $0236BE: MOV R0,R2 */

    /* ─────────────────────────────────────────────────────────────────────────
     * Test coordinate pair 3
     * ───────────────────────────────────────────────────────────────────────── */
.pair3_setup:
    .short  0x8586                            /* $0236C0: MOV.W @(12,R8),R0 */
    .short  0x3013                            /* $0236C2: CMP/GE R1,R0 */
    .short  0x8902                            /* $0236C4: BT func_030 */
    .short  0xEA0C                            /* $0236C6: MOV #12,R10 */
    .short  0x000B                            /* $0236C8: RTS */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_030: Shared Exit Path (with R11 flag update)
 * Entry: 0x022236CA
 * ═══════════════════════════════════════════════════════════════════════════ */
func_030:
    .short  0x6103                            /* $0236CA: MOV R0,R1 (update min) */
    .short  0x3203                            /* $0236CC: CMP/GE R0,R2 */
    .short  0x8902                            /* $0236CE: BT func_031 */
    .short  0xEB0C                            /* $0236D0: MOV #12,R11 */
    .short  0x000B                            /* $0236D2: RTS */
    .short  0x6203                            /* $0236D4: [delay] MOV R0,R2 */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_031: Minimal Exit
 * Entry: 0x022236D6
 * ═══════════════════════════════════════════════════════════════════════════ */
func_031:
    .short  0x000B                            /* $0236D6: RTS */
    .short  0x0009                            /* $0236D8: [delay] NOP */

/* ============================================================================
 * End of func_029 + exit paths (82 bytes)
 *
 * Analysis:
 * - Classifies Y-coordinate visibility (pairs with func_026 for X)
 * - Iterates through 4 coordinate Y values
 * - Sets R10 (X flags) and R11 (Y flags) based on edge positions
 * - Flag values: 0=inside, 4=edge A clip, 8=edge B clip, 12=both clips
 * - Coordinate buffer at 0xC0000742 (Y offset from 0xC0000740)
 * ============================================================================ */
