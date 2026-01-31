/*
 * func_052: Small BSR Handler (Type 4/5)
 * ROM File Offset: 0x23E48 - 0x23E5D (22 bytes)
 * SH2 Address: 0x02223E48 - 0x02223E5D
 *
 * Purpose: Handler for dispatch types 4 and 5 from func_045.
 *          Simplified version with only 2 BSR calls.
 *
 * Type: Non-leaf function (2 BSR calls to $023F2E)
 * Called By: func_045 dispatch (types 4,5: offset $0198)
 * Calls: BSR to $023F2E (2 times)
 */

.section .text
.p2align 1    /* 2-byte alignment for $023E48 start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_052: Small BSR Handler
 * Entry: 0x02223E48
 * ═══════════════════════════════════════════════════════════════════════════ */
func_052:
    .short  0x4F22        /* $023E48: STS.L PR,@-R15 */
    .short  0x59E1        /* $023E4A: MOV.L @(4,R14),R9 */
    .short  0xDA04        /* $023E4C: MOV.L @(16,PC),R10 → addr at $023E60 */
    .short  0xB06E        /* $023E4E: BSR $023F2E */
    .short  0x84EA        /* $023E50: [delay] MOV.B @(10,R14),R0 */
    .short  0x7908        /* $023E52: ADD #8,R9 */
    .short  0xB06B        /* $023E54: BSR $023F2E */
    .short  0x84EB        /* $023E56: [delay] MOV.B @(11,R14),R0 */
    .short  0x4F26        /* $023E58: LDS.L @R15+,PR */
    .short  0x000B        /* $023E5A: RTS */
    .short  0x0009        /* $023E5C: [delay] NOP */

/* ============================================================================
 * End of func_052 (22 bytes)
 * ============================================================================ */
