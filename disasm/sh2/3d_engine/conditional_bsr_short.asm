/*
 * func_054: Conditional BSR Handler (Type 9)
 * ROM File Offset: 0x23E90 - 0x23EC7 (56 bytes)
 * SH2 Address: 0x02223E90 - 0x02223EC7
 *
 * Purpose: Handler for dispatch type 9 from func_045.
 *          Uses R12 as a flag to track if any BSR was called.
 *          Second element conditionally skips based on flag state.
 *
 * Type: Non-leaf function (3 BSR calls to $023F2E)
 * Called By: func_045 dispatch (type 9: offset $02FA)
 * Calls: BSR to $023F2E (up to 3 times)
 *
 * Operation:
 *   1. Add offset $0400 to destination
 *   2. Set flag R12 = 0
 *   3. First element: if non-zero, call BSR and set flag
 *   4. Second element: if flag set OR value non-zero, call BSR
 *   5. Third element: always call BSR
 */

.section .text
.p2align 1    /* 2-byte alignment for $023E90 start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_054: Conditional BSR Handler
 * Entry: 0x02223E90
 * ═══════════════════════════════════════════════════════════════════════════ */
func_054:
    .short  0x4F22        /* $023E90: STS.L PR,@-R15 */
    .short  0x59E1        /* $023E92: MOV.L @(4,R14),R9 */
    .short  0x9018        /* $023E94: MOV.W @(48,PC),R0 → $0400 at $023EC8 */
    .short  0x390C        /* $023E96: ADD R0,R9 (add offset) */
    .short  0xDA0C        /* $023E98: MOV.L @(48,PC),R10 → addr at $023ECC */
    .short  0x84E1        /* $023E9A: MOV.B @(1,R14),R0 */
    .short  0x4008        /* $023E9C: SHLL2 R0 */
    .short  0x0AAE        /* $023E9E: MULU.W R10,R10 */
    .short  0xEC00        /* $023EA0: MOV #0,R12 (flag = 0) */
    .short  0x84E9        /* $023EA2: MOV.B @(9,R14),R0 */
    .short  0x8800        /* $023EA4: CMP/EQ #0,R0 */
    .short  0x8901        /* $023EA6: BT $023EAC (skip if zero) */
    .short  0xB041        /* $023EA8: BSR $023F2E */
    .short  0xEC01        /* $023EAA: [delay] MOV #1,R12 (flag = 1) */
.elem_1:
    .short  0x7908        /* $023EAC: ADD #8,R9 */
    .short  0x84EA        /* $023EAE: MOV.B @(10,R14),R0 */
    .short  0x4C15        /* $023EB0: CMP/PL R12 (is flag > 0?) */
    .short  0x8901        /* $023EB2: BT $023EB8 (if flag set, always call) */
    .short  0x8800        /* $023EB4: CMP/EQ #0,R0 */
    .short  0x8901        /* $023EB6: BT $023EBC (skip if zero) */
.call_bsr:
    .short  0xB039        /* $023EB8: BSR $023F2E */
    .short  0xEC01        /* $023EBA: [delay] MOV #1,R12 */
.elem_2:
    .short  0x7908        /* $023EBC: ADD #8,R9 */
    .short  0xB036        /* $023EBE: BSR $023F2E */
    .short  0x84EB        /* $023EC0: [delay] MOV.B @(11,R14),R0 */
    .short  0x4F26        /* $023EC2: LDS.L @R15+,PR */
    .short  0x000B        /* $023EC4: RTS */
    .short  0x0009        /* $023EC6: [delay] NOP */

/* ============================================================================
 * End of func_054 (56 bytes)
 *
 * Literal pool follows at $023EC8:
 *   $023EC8: $0400 (offset constant)
 *   $023ECC: $06003E3C (address constant)
 * ============================================================================ */
