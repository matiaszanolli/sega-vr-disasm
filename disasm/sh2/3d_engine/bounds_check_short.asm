/*
 * func_047: Bounds Check Handler (Type 10)
 * ROM File Offset: 0x23D24 - 0x23D3D (26 bytes)
 * SH2 Address: 0x02223D24 - 0x02223D3D
 *
 * Purpose: Handler for dispatch type 10 from func_045.
 *          Checks if value >= $0140 (320), early exits if so.
 *          Otherwise sets up parameters and jumps into func_046's inner loop.
 *
 * Type: Leaf function (no subroutine calls, but BRA to func_046)
 * Called By: func_045 dispatch (type 10: offset $0058)
 *
 * Operation:
 *   1. Read word value from @(2,R14)
 *   2. If value >= $0140, return immediately
 *   3. Load source/dest pointers from R14 parameter block
 *   4. Mask value to 4-byte alignment
 *   5. Jump into func_046's copy loop at $023CFC
 */

.section .text
.p2align 1    /* 2-byte alignment for $023D24 start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_047: Bounds Check Handler (Type 10)
 * Entry: 0x02223D24
 * ═══════════════════════════════════════════════════════════════════════════ */
func_047:
    .short  0x85E1        /* $023D24: MOV.W @(2,R14),R0 */
    .short  0x9107        /* $023D26: MOV.W @(14,PC),R1 → $0140 at $023D38 */
    .short  0x3013        /* $023D28: CMP/GE R1,R0 */
    .short  0x8906        /* $023D2A: BT $023D3A (exit if >= $0140) */
    .short  0x58E2        /* $023D2C: MOV.L @(8,R14),R8 */
    .short  0x59E1        /* $023D2E: MOV.L @(4,R14),R9 */
    .short  0xE1FC        /* $023D30: MOV #-4,R1 (mask = $FFFFFFFC) */
    .short  0x2019        /* $023D32: AND R1,R0 (align to 4) */
    .short  0xAFE2        /* $023D34: BRA $023CFC (func_046 inner loop) */
    .short  0x390C        /* $023D36: [delay] ADD R0,R9 (offset dest) */
.literal_0140:
    .short  0x0140        /* $023D38: bounds limit = 320 */
.early_exit:
    .short  0x000B        /* $023D3A: RTS */
    .short  0x0009        /* $023D3C: [delay] NOP */

/* ============================================================================
 * End of func_047 (26 bytes)
 * ============================================================================ */
