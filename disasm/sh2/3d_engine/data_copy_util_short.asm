/*
 * func_042: VDP Data Copy Helper
 * ROM File Offset: 0x23A52 - 0x23A65 (20 bytes)
 * SH2 Address: 0x02223A52 - 0x02223A65
 *
 * Purpose: Small utility that copies data from source (R0) to destination (R1).
 *          Loop count is loaded from literal pool. Called by func_041 during
 *          render pipeline initialization.
 *
 * Type: Leaf function (no subroutine calls)
 * Called By: func_041 at $0239F8
 *
 * Operation:
 *   1. Load destination pointer from literal pool
 *   2. Load source pointer from literal pool
 *   3. Load loop count from literal pool
 *   4. Copy R7 longwords from R0 to R1
 *
 * Note: Literal pool is located at $023A66+ (immediately after function)
 */

.section .text
.p2align 1    /* 2-byte alignment for $023A52 start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_042: VDP Data Copy Helper
 * Entry: 0x02223A52
 * ═══════════════════════════════════════════════════════════════════════════ */
func_042:
    .short  0xD105        /* $023A52: MOV.L @(20,PC),R1 → dest addr */
    .short  0xD005        /* $023A54: MOV.L @(20,PC),R0 → source addr */
    .short  0x9706        /* $023A56: MOV.W @(12,PC),R7 → loop count */
.copy_loop:
    .short  0x6206        /* $023A58: MOV.L @R0+,R2 */
    .short  0x2122        /* $023A5A: MOV.L R2,@R1 */
    .short  0x4710        /* $023A5C: DT R7 */
    .short  0x8FFB        /* $023A5E: BF/S .copy_loop (-10) */
    .short  0x7104        /* $023A60: [delay] ADD #4,R1 */
    .short  0x000B        /* $023A62: RTS */
    .short  0x0009        /* $023A64: [delay] NOP */

/* ============================================================================
 * End of func_042 (20 bytes)
 *
 * Literal pool follows at $023A66:
 *   $023A66: 0x0091 (loop count = 145)
 *   $023A68: destination address
 *   $023A6C: source address
 * ============================================================================ */
