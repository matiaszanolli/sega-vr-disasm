/*
 * func_048: Bounds Check Handler (Type 7)
 * ROM File Offset: 0x23D3E - 0x23D53 (22 bytes)
 * SH2 Address: 0x02223D3E - 0x02223D53
 *
 * Purpose: Handler for dispatch type 7 from func_045.
 *          Checks if value >= $0200 (512), early exits if so.
 *          Otherwise sets up parameters and jumps forward to $023FCA.
 *
 * Type: Leaf function (no subroutine calls, but BRA forward)
 * Called By: func_045 dispatch (type 7: offset $0072)
 *
 * Operation:
 *   1. Read word value from @(2,R14)
 *   2. If value >= $0200, return immediately
 *   3. Load source/dest pointers from R14 parameter block
 *   4. Jump to processing routine at $023FCA
 */

.section .text
.p2align 1    /* 2-byte alignment for $023D3E start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_048: Bounds Check Handler (Type 7)
 * Entry: 0x02223D3E
 * ═══════════════════════════════════════════════════════════════════════════ */
func_048:
    .short  0x85E1        /* $023D3E: MOV.W @(2,R14),R0 */
    .short  0x9105        /* $023D40: MOV.W @(10,PC),R1 → $0200 at $023D4E */
    .short  0x3013        /* $023D42: CMP/GE R1,R0 */
    .short  0x8904        /* $023D44: BT $023D50 (exit if >= $0200) */
    .short  0x58E2        /* $023D46: MOV.L @(8,R14),R8 */
    .short  0x59E1        /* $023D48: MOV.L @(4,R14),R9 */
    .short  0xA13E        /* $023D4A: BRA $023FCA (forward jump) */
    .short  0x390C        /* $023D4C: [delay] ADD R0,R9 (offset dest) */
.literal_0200:
    .short  0x0200        /* $023D4E: bounds limit = 512 */
.early_exit:
    .short  0x000B        /* $023D50: RTS */
    .short  0x0009        /* $023D52: [delay] NOP */

/* ============================================================================
 * End of func_048 (22 bytes)
 * ============================================================================ */
