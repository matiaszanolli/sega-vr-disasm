/*
 * func_040_utility: Data Copy and GBR Setup
 * ROM File Offset: 0x239B0 - 0x239CB (28 bytes)
 * SH2 Address: 0x022239B0 - 0x022239CB
 *
 * Purpose: Small utility function that copies 14 longwords from source
 *          (passed in R0) to a VDP context area, then sets up GBR.
 *          Called by func_041 during render pipeline initialization.
 *
 * Type: Leaf function (no subroutine calls)
 * Called By: func_041 at $0239FC
 *
 * Input:
 *   R0 = Source data pointer
 *
 * Operation:
 *   1. Load VDP context base from literal pool (0xC0000700)
 *   2. Get table address via MOVA
 *   3. Copy 14 longwords from R0 to context+12
 *   4. Set GBR to SDRAM context (0x20004100)
 *
 * Note: The literal pool referenced by this function is at $0239CC-$0239D3,
 *       located immediately after this function in ROM.
 */

.section .text
.p2align 1    /* 2-byte alignment for $0239B0 start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_040_utility: Data Copy and GBR Setup
 * Entry: 0x022239B0
 * ═══════════════════════════════════════════════════════════════════════════ */
func_040_utility:
    .short  0xDE06        /* $0239B0: MOV.L @(24,PC),R14 → VDP context 0xC0000700 */
    .short  0xC708        /* $0239B2: MOVA @(32,PC),R0 → table address */
    .short  0xE70E        /* $0239B4: MOV #14,R7 (loop counter) */
    .short  0x6DE3        /* $0239B6: MOV R14,R13 (copy base) */
    .short  0x7D0C        /* $0239B8: ADD #12,R13 (offset to data area) */
.copy_loop:
    .short  0x6106        /* $0239BA: MOV.L @R0+,R1 (read source) */
    .short  0x2D12        /* $0239BC: MOV.L R1,@R13 (write dest) */
    .short  0x4710        /* $0239BE: DT R7 (decrement counter) */
    .short  0x8FFB        /* $0239C0: BF/S .copy_loop (-10) */
    .short  0x7D04        /* $0239C2: [delay] ADD #4,R13 */
    /* Setup GBR */
    .short  0xD002        /* $0239C4: MOV.L @(8,PC),R0 → SDRAM 0x20004100 */
    .short  0x401E        /* $0239C6: LDC R0,GBR */
    .short  0x000B        /* $0239C8: RTS */
    .short  0x0009        /* $0239CA: [delay] NOP */

/* ============================================================================
 * End of func_040_utility (28 bytes, 14 instructions)
 *
 * Literal pool layout (not included here):
 *   $0239CC: 0xC0000700 (VDP context base)
 *   $0239D0: 0x20004100 (SDRAM context for GBR)
 * ============================================================================ */
