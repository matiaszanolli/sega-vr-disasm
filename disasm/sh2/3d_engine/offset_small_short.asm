/*
 * func_053: Offset Small BSR Handler (Type 6)
 * ROM File Offset: 0x23E64 - 0x23E89 (38 bytes)
 * SH2 Address: 0x02223E64 - 0x02223E89
 *
 * Purpose: Handler for dispatch type 6 from func_045.
 *          Adds offset to dest, then 2 BSR calls with conditional skip.
 *
 * Type: Non-leaf function (2 BSR calls to $023F2E)
 * Called By: func_045 dispatch (type 6: offset $01C4)
 * Calls: BSR to $023F2E (2 times)
 */

.section .text
.p2align 1    /* 2-byte alignment for $023E64 start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_053: Offset Small BSR Handler
 * Entry: 0x02223E64
 * ═══════════════════════════════════════════════════════════════════════════ */
func_053:
    .short  0x4F22        /* $023E64: STS.L PR,@-R15 */
    .short  0x59E1        /* $023E66: MOV.L @(4,R14),R9 */
    .short  0x900F        /* $023E68: MOV.W @(30,PC),R0 → $0400 at $023E8A */
    .short  0x390C        /* $023E6A: ADD R0,R9 (add offset) */
    .short  0xDA07        /* $023E6C: MOV.L @(28,PC),R10 → addr at $023E8C */
    .short  0x84E1        /* $023E6E: MOV.B @(1,R14),R0 */
    .short  0x4008        /* $023E70: SHLL2 R0 */
    .short  0x0AAE        /* $023E72: MULU.W R10,R10 */
    .short  0x84EA        /* $023E74: MOV.B @(10,R14),R0 */
    .short  0x8800        /* $023E76: CMP/EQ #0,R0 */
    .short  0x8901        /* $023E78: BT $023E7E (skip if zero) */
    .short  0xB058        /* $023E7A: BSR $023F2E */
    .short  0x0009        /* $023E7C: [delay] NOP */
.elem_1:
    .short  0x7908        /* $023E7E: ADD #8,R9 */
    .short  0xB055        /* $023E80: BSR $023F2E */
    .short  0x84EB        /* $023E82: [delay] MOV.B @(11,R14),R0 */
    .short  0x4F26        /* $023E84: LDS.L @R15+,PR */
    .short  0x000B        /* $023E86: RTS */
    .short  0x0009        /* $023E88: [delay] NOP */

/* ============================================================================
 * End of func_053 (38 bytes)
 * ============================================================================ */
