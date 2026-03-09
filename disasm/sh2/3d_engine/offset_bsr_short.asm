/*
 * func_051: Offset Multi-BSR Processing Handler (Type 3)
 * ROM File Offset: 0x23DD8 - 0x23E33 (92 bytes)
 * SH2 Address: 0x02223DD8 - 0x02223E33
 *
 * Purpose: Handler for dispatch type 3 from func_045.
 *          Similar to func_050 but adds offset to destination and
 *          calls different subroutine ($023F2E instead of $023ED0).
 *
 * Type: Non-leaf function (multiple BSR calls to $023F2E)
 * Called By: func_045 dispatch (type 3: offset $010C)
 * Calls: BSR to $023F2E (10 times)
 *
 * Operation:
 *   1. Save PR
 *   2. Load dest pointer and add offset ($0400) from literal pool
 *   3. Load address constant into R10
 *   4. For each of 10 elements:
 *      - Read byte from R14 parameter block
 *      - If not zero, call processing subroutine
 *      - Advance R9 by 8
 *   5. Restore PR and return
 */

.section .text
.p2align 1    /* 2-byte alignment for $023DD8 start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_051: Offset Multi-BSR Processing Handler
 * Entry: 0x02223DD8
 * ═══════════════════════════════════════════════════════════════════════════ */
func_051:
    .short  0x4F22        /* $023DD8: STS.L PR,@-R15 */
    .short  0x59E1        /* $023DDA: MOV.L @(4,R14),R9 */
    .short  0x902A        /* $023DDC: MOV.W @(84,PC),R0 → $0400 at $023E34 */
    .short  0x390C        /* $023DDE: ADD R0,R9 (add offset to dest) */
    .short  0xDA15        /* $023DE0: MOV.L @(84,PC),R10 → addr at $023E38 */
    .short  0x84E1        /* $023DE2: MOV.B @(1,R14),R0 */
    .short  0x4008        /* $023DE4: SHLL2 R0 */
    .short  0x0AAE        /* $023DE6: MULU.W R10,R10 */
    .short  0x84E8        /* $023DE8: MOV.B @(8,R14),R0 */
    .short  0x8800        /* $023DEA: CMP/EQ #0,R0 */
    .short  0x8901        /* $023DEC: BT $023DF2 (skip if zero) */
    .short  0xB09E        /* $023DEE: BSR $023F2E */
    .short  0x0009        /* $023DF0: [delay] NOP */
.elem_1:
    .short  0x7908        /* $023DF2: ADD #8,R9 */
    .short  0x84E9        /* $023DF4: MOV.B @(9,R14),R0 */
    .short  0x8800        /* $023DF6: CMP/EQ #0,R0 */
    .short  0x8901        /* $023DF8: BT $023DFE (skip if zero) */
    .short  0xB098        /* $023DFA: BSR $023F2E */
    .short  0x0009        /* $023DFC: [delay] NOP */
.elem_2:
    .short  0x7908        /* $023DFE: ADD #8,R9 */
    .short  0xB095        /* $023E00: BSR $023F2E */
    .short  0x84EA        /* $023E02: [delay] MOV.B @(10,R14),R0 */
.elem_3:
    .short  0x7908        /* $023E04: ADD #8,R9 */
    .short  0xB092        /* $023E06: BSR $023F2E */
    .short  0xE00A        /* $023E08: [delay] MOV #10,R0 */
.elem_4:
    .short  0x7908        /* $023E0A: ADD #8,R9 */
    .short  0xB08F        /* $023E0C: BSR $023F2E */
    .short  0x84EB        /* $023E0E: [delay] MOV.B @(11,R14),R0 */
.elem_5:
    .short  0x7908        /* $023E10: ADD #8,R9 */
    .short  0xB08C        /* $023E12: BSR $023F2E */
    .short  0x84EC        /* $023E14: [delay] MOV.B @(12,R14),R0 */
.elem_6:
    .short  0x7908        /* $023E16: ADD #8,R9 */
    .short  0xB089        /* $023E18: BSR $023F2E */
    .short  0xE00B        /* $023E1A: [delay] MOV #11,R0 */
.elem_7:
    .short  0x7908        /* $023E1C: ADD #8,R9 */
    .short  0xB086        /* $023E1E: BSR $023F2E */
    .short  0x84ED        /* $023E20: [delay] MOV.B @(13,R14),R0 */
.elem_8:
    .short  0x7908        /* $023E22: ADD #8,R9 */
    .short  0xB083        /* $023E24: BSR $023F2E */
    .short  0x84EE        /* $023E26: [delay] MOV.B @(14,R14),R0 */
.elem_9:
    .short  0x7908        /* $023E28: ADD #8,R9 */
    .short  0xB080        /* $023E2A: BSR $023F2E */
    .short  0x84EF        /* $023E2C: [delay] MOV.B @(15,R14),R0 */
.done:
    .short  0x4F26        /* $023E2E: LDS.L @R15+,PR */
    .short  0x000B        /* $023E30: RTS */
    .short  0x0009        /* $023E32: [delay] NOP */

/* ============================================================================
 * End of func_051 (92 bytes)
 *
 * Literal pool follows at $023E34:
 *   $023E34: $0400 (offset constant)
 *   $023E38: $06003E3C (address constant)
 * These are NOT included - remain in code_22200.asm
 * ============================================================================ */
