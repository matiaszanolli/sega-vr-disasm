/*
 * func_003 and func_004: Offset-Based Data Copy Utilities
 * ROM File Offset: 0x230C8 - 0x230E7 (32 bytes)
 * SH2 Address: 0x022230C8 - 0x022230E7
 *
 * Also includes func_002's exit paths which precede func_003.
 *
 * Addresses:
 *   func_002_exit_path1: 0x022230C8
 *   func_002_alt_path:   0x022230CE
 *   func_003:            0x022230D4
 *   func_004:            0x022230DE
 *
 * Note: All instructions as .short to match ROM exactly.
 */

.section .text
.p2align 1    /* 2-byte alignment for 0x230C8 start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_002 exit paths (shared control flow)
 * ═══════════════════════════════════════════════════════════════════════════ */
func_002_exit_path1:
    .short  0x4F26                            /* $0230C8: LDS.L @R15+,PR */
    .short  0x000B                            /* $0230CA: RTS */
    .short  0x0009                            /* $0230CC: [delay] NOP */

func_002_alt_path:
    .short  0x37CC                            /* $0230CE: ADD R12,R7 */
    .short  0xAFFA                            /* $0230D0: BRA func_002_exit_path1 */
    .short  0x1743                            /* $0230D2: [delay] MOV.L R4,@(12,R7) */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_003: Offset Copy with R10 Adjustment
 * Entry: 0x022230D4
 * Size: 10 bytes
 *
 * R6 += R10 (source), R7 += R12 (dest), copy @(12,R6) to @(12,R7)
 * ═══════════════════════════════════════════════════════════════════════════ */
func_003:
    .short  0x36AC                            /* $0230D4: ADD R10,R6 */
    .short  0x37CC                            /* $0230D6: ADD R12,R7 */
    .short  0x5463                            /* $0230D8: MOV.L @(12,R6),R4 */
    .short  0x000B                            /* $0230DA: RTS */
    .short  0x1743                            /* $0230DC: [delay] MOV.L R4,@(12,R7) */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_004: Offset Copy with R12 for Both
 * Entry: 0x022230DE
 * Size: 10 bytes
 *
 * R6 += R12 (source), R7 += R12 (dest), copy @(12,R6) to @(12,R7)
 * ═══════════════════════════════════════════════════════════════════════════ */
func_004:
    .short  0x36CC                            /* $0230DE: ADD R12,R6 */
    .short  0x37CC                            /* $0230E0: ADD R12,R7 */
    .short  0x5463                            /* $0230E2: MOV.L @(12,R6),R4 */
    .short  0x000B                            /* $0230E4: RTS */
    .short  0x1743                            /* $0230E6: [delay] MOV.L R4,@(12,R7) */

/* ============================================================================
 * End of func_002 exits + func_003 + func_004 (32 bytes)
 *
 * Analysis:
 * - func_003 uses R10 for source offset, R12 for dest offset
 * - func_004 uses R12 for both source and dest offset
 * - Both copy a single longword at fixed +12 byte displacement
 * - Used for copying transformation parameters with varying strides
 * ============================================================================ */
