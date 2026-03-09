/*
 * func_067: RLE Entry Point (Alternative 1)
 * ROM File Offset: 0x23FF4 - 0x24001 (14 bytes)
 * SH2 Address: 0x02223FF4 - 0x02224001
 *
 * Purpose: Alternative entry point for RLE decoder (func_066).
 *          Sets up R8/R9 with offset adjustment, then jumps to func_066's loop.
 *          The delay slot negates R13 (stride adjustment).
 *
 * Type: Entry point (BRA to func_066)
 * Called By: Unknown dispatcher
 * Jumps To: $023FCC (func_066 inner loop)
 *
 * Operation:
 *   1. Load R8 = @(8,R14), R9 = @(4,R14)
 *   2. R8 += 2 (skip header word)
 *   3. R7 = word from @(2,R14)
 *   4. BRA to func_066 loop with R13 = -R13 in delay slot
 */

.section .text
.p2align 1    /* 2-byte alignment for $023FF4 start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_067: RLE Entry Point (Alternative 1)
 * Entry: 0x02223FF4
 * ═══════════════════════════════════════════════════════════════════════════ */
func_067:
    .short  0x58E2        /* $023FF4: MOV.L @(8,R14),R8 */
    .short  0x59E1        /* $023FF6: MOV.L @(4,R14),R9 */
    .short  0x7802        /* $023FF8: ADD #2,R8 */
    .short  0x85E1        /* $023FFA: MOV.W @(2,R14),R0 */
    .short  0x6703        /* $023FFC: MOV R0,R7 */
    .short  0xAFE5        /* $023FFE: BRA $023FCC (into func_066 loop) */
    .short  0x6DDB        /* $024000: [delay] NEG R13,R13 */

/* ============================================================================
 * End of func_067 (14 bytes = 7 instructions)
 *
 * Note: This is an alternative entry point for the RLE decoder (func_066).
 * The NEG R13,R13 in the delay slot reverses the stride direction.
 * ============================================================================ */
