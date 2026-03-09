/*
 * func_026: Bounds Comparison with Exit Paths (func_027, func_028)
 * ROM File Offset: 0x23644 - 0x23687 (68 bytes)
 * SH2 Address: 0x02223644 - 0x02223687
 *
 * Purpose: Compares coordinate values to determine bounding box
 *          and track minimum/maximum values for visibility testing.
 *
 * Type: Leaf function with shared exit paths
 * Called By: func_023 (frustum cull dispatcher)
 *
 * Note: Includes func_027 ($02367A) and func_028 ($023684) which are
 *       shared exit paths used by both func_026 and func_029.
 *       All instructions as .short to match ROM exactly.
 */

.section .text
.p2align 1    /* 2-byte alignment for 0x23644 start */

func_026:
    /* ─────────────────────────────────────────────────────────────────────────
     * Initialize: Load coordinate buffer and first value
     * ───────────────────────────────────────────────────────────────────────── */
    .short  0xD804                            /* $023644: MOV.L @(4,PC),R8 → coord buffer */
    .short  0x8580                            /* $023646: MOV.W @(0,R8),R0 */
    .short  0x6103                            /* $023648: MOV R0,R1 (min = coord[0]) */
    .short  0x6203                            /* $02364A: MOV R0,R2 (max = coord[0]) */

    /* ─────────────────────────────────────────────────────────────────────────
     * Compare coordinate pair 1
     * ───────────────────────────────────────────────────────────────────────── */
    .short  0x8582                            /* $02364C: MOV.W @(4,R8),R0 (coord[2]) */
    .short  0x3013                            /* $02364E: CMP/GE R1,R0 */
    .short  0x8904                            /* $023650: BT .pair1_ge_min */
    .short  0xA006                            /* $023652: BRA .pair1_update_max */
    .short  0x6103                            /* $023654: [delay] MOV R0,R1 */

    /* Literal pool (must be at 0x23658 for PC-relative load) */
    .short  0x0000                            /* $023656: Padding for alignment */
.lit_coord_buf:
    .byte   0xC0, 0x00, 0x07, 0x40            /* $023658: 0xC0000740 - Coord buffer (cache-through) */

.pair1_ge_min:
    .short  0x3203                            /* $02365C: CMP/GE R0,R2 */
    .short  0x8900                            /* $02365E: BT .pair2_setup */
    .short  0x6203                            /* $023660: MOV R0,R2 (new max) */

    /* ─────────────────────────────────────────────────────────────────────────
     * Compare coordinate pair 2
     * ───────────────────────────────────────────────────────────────────────── */
.pair1_update_max:
.pair2_setup:
    .short  0x8584                            /* $023662: MOV.W @(8,R8),R0 (coord[4]) */
    .short  0x3013                            /* $023664: CMP/GE R1,R0 */
    .short  0x8901                            /* $023666: BT .pair2_ge_min */
    .short  0xA003                            /* $023668: BRA .pair3_setup */
    .short  0x6103                            /* $02366A: [delay] MOV R0,R1 */

.pair2_ge_min:
    .short  0x3203                            /* $02366C: CMP/GE R0,R2 */
    .short  0x8900                            /* $02366E: BT .pair3_setup */
    .short  0x6203                            /* $023670: MOV R0,R2 (new max) */

    /* ─────────────────────────────────────────────────────────────────────────
     * Compare coordinate pair 3
     * ───────────────────────────────────────────────────────────────────────── */
.pair3_setup:
    .short  0x8586                            /* $023672: MOV.W @(12,R8),R0 (coord[6]) */
    .short  0x3013                            /* $023674: CMP/GE R1,R0 */
    .short  0x8901                            /* $023676: BT func_027 */
    .short  0x000B                            /* $023678: RTS */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_027: Shared Exit Path A (Min Value Update)
 * Entry: 0x0222367A
 * Also serves as delay slot for RTS at $023678
 * ═══════════════════════════════════════════════════════════════════════════ */
func_027:
    .short  0x6103                            /* $02367A: MOV R0,R1 (update min) */
    .short  0x3203                            /* $02367C: CMP/GE R0,R2 */
    .short  0x8901                            /* $02367E: BT func_028 */
    .short  0x000B                            /* $023680: RTS */
    .short  0x6203                            /* $023682: [delay] MOV R0,R2 */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_028: Shared Exit Path B (Minimal Exit)
 * Entry: 0x02223684
 * ═══════════════════════════════════════════════════════════════════════════ */
func_028:
    .short  0x000B                            /* $023684: RTS */
    .short  0x0009                            /* $023686: [delay] NOP */

/* ============================================================================
 * End of func_026 + exit paths (68 bytes)
 *
 * Analysis:
 * - Iterates through 4 coordinate values at offsets 0, 4, 8, 12 in buffer
 * - Tracks minimum (R1) and maximum (R2) screen coordinates
 * - Multiple exit paths allow early return when conditions met
 * - Coordinate buffer at 0xC0000740 (cache-through SDRAM)
 * - Used for bounding box calculation in visibility/clipping tests
 * ============================================================================ */
