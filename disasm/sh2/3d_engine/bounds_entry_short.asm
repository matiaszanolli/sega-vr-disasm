/*
 * func_049: Bounds Check Entry Handler (Type 8)
 * ROM File Offset: 0x23D54 - 0x23D6D (26 bytes)
 * SH2 Address: 0x02223D54 - 0x02223D6D
 *
 * Purpose: Handler for dispatch type 8 from func_045.
 *          Checks if value >= $0140 (320), early exits if so.
 *          Otherwise saves PR and jumps into func_050's body.
 *
 * Type: Entry trampoline (pushes PR in delay slot before BRA)
 * Called By: func_045 dispatch (type 8: offset $0088)
 *
 * Operation:
 *   1. Read word value from @(2,R14)
 *   2. If value >= $0140, return immediately
 *   3. Load dest pointer from R14 parameter block
 *   4. Mask value to 4-byte alignment and add to dest
 *   5. Push PR (in delay slot) and branch to func_050 body
 *
 * Note: Uses STS.L PR,@-R15 in delay slot of BRA - saves return
 * address before jumping into func_050's shared processing code.
 */

.section .text
.p2align 1    /* 2-byte alignment for $023D54 start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_049: Bounds Check Entry Handler (Type 8)
 * Entry: 0x02223D54
 * ═══════════════════════════════════════════════════════════════════════════ */
func_049:
    .short  0x85E1        /* $023D54: MOV.W @(2,R14),R0 */
    .short  0x9107        /* $023D56: MOV.W @(14,PC),R1 → $0140 at $023D68 */
    .short  0x3013        /* $023D58: CMP/GE R1,R0 */
    .short  0x8906        /* $023D5A: BT $023D6A (exit if >= $0140) */
    .short  0x59E1        /* $023D5C: MOV.L @(4,R14),R9 */
    .short  0xE1FC        /* $023D5E: MOV #-4,R1 (mask = $FFFFFFFC) */
    .short  0x2019        /* $023D60: AND R1,R0 (align to 4) */
    .short  0x390C        /* $023D62: ADD R0,R9 (offset dest) */
    .short  0xA005        /* $023D64: BRA $023D72 (into func_050 body) */
    .short  0x4F22        /* $023D66: [delay] STS.L PR,@-R15 (save return) */
.literal_0140:
    .short  0x0140        /* $023D68: bounds limit = 320 */
.early_exit:
    .short  0x000B        /* $023D6A: RTS */
    .short  0x0009        /* $023D6C: [delay] NOP */

/* ============================================================================
 * End of func_049 (26 bytes)
 *
 * Note: The STS.L PR,@-R15 in the delay slot at $023D66 saves the return
 * address before branching to $023D72 (func_050's shared body). This allows
 * func_049 to share func_050's epilogue (LDS.L @R15+,PR / RTS).
 * ============================================================================ */
