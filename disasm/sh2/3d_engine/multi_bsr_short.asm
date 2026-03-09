/*
 * func_050: Multi-BSR Processing Handler (Type 2)
 * ROM File Offset: 0x23D6E - 0x23DC5 (88 bytes)
 * SH2 Address: 0x02223D6E - 0x02223DC5
 *
 * Purpose: Handler for dispatch type 2 from func_045.
 *          Processes 10 elements by calling BSR to $023ED0 repeatedly.
 *          Each iteration advances destination pointer by 8 bytes.
 *
 * Type: Non-leaf function (multiple BSR calls to $023ED0)
 * Called By: func_045 dispatch (type 2: offset $00A2)
 * Alternate Entry: $023D72 (from func_049 with PR already saved)
 * Calls: BSR to $023ED0 (10 times)
 *
 * Operation:
 *   1. Save PR (entry at $023D6E) or skip (entry at $023D72)
 *   2. Load address from literal pool into R10
 *   3. For each of 10 elements:
 *      - Read byte from R14 parameter block
 *      - Square R10 (MULU.W R10,R10)
 *      - If not zero, call processing subroutine
 *      - Advance R9 by 8
 *   4. Restore PR and return
 */

.section .text
.p2align 1    /* 2-byte alignment for $023D6E start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_050: Multi-BSR Processing Handler
 * Entry: 0x02223D6E (normal) / 0x02223D72 (alt from func_049)
 * ═══════════════════════════════════════════════════════════════════════════ */
func_050:
    .short  0x4F22        /* $023D6E: STS.L PR,@-R15 */
    .short  0x59E1        /* $023D70: MOV.L @(4,R14),R9 */
.alt_entry:
    .short  0xDA15        /* $023D72: MOV.L @(84,PC),R10 → addr at $023DC8 */
    .short  0x84E1        /* $023D74: MOV.B @(1,R14),R0 */
    .short  0x4008        /* $023D76: SHLL2 R0 */
    .short  0x0AAE        /* $023D78: MULU.W R10,R10 */
    .short  0x84E8        /* $023D7A: MOV.B @(8,R14),R0 */
    .short  0x8800        /* $023D7C: CMP/EQ #0,R0 */
    .short  0x8901        /* $023D7E: BT $023D84 (skip if zero) */
    .short  0xB0A6        /* $023D80: BSR $023ED0 */
    .short  0x0009        /* $023D82: [delay] NOP */
.elem_1:
    .short  0x7908        /* $023D84: ADD #8,R9 */
    .short  0x84E9        /* $023D86: MOV.B @(9,R14),R0 */
    .short  0x8800        /* $023D88: CMP/EQ #0,R0 */
    .short  0x8901        /* $023D8A: BT $023D90 (skip if zero) */
    .short  0xB0A0        /* $023D8C: BSR $023ED0 */
    .short  0x0009        /* $023D8E: [delay] NOP */
.elem_2:
    .short  0x7908        /* $023D90: ADD #8,R9 */
    .short  0xB09D        /* $023D92: BSR $023ED0 */
    .short  0x84EA        /* $023D94: [delay] MOV.B @(10,R14),R0 */
.elem_3:
    .short  0x7908        /* $023D96: ADD #8,R9 */
    .short  0xB09A        /* $023D98: BSR $023ED0 */
    .short  0xE00A        /* $023D9A: [delay] MOV #10,R0 */
.elem_4:
    .short  0x7908        /* $023D9C: ADD #8,R9 */
    .short  0xB097        /* $023D9E: BSR $023ED0 */
    .short  0x84EB        /* $023DA0: [delay] MOV.B @(11,R14),R0 */
.elem_5:
    .short  0x7908        /* $023DA2: ADD #8,R9 */
    .short  0xB094        /* $023DA4: BSR $023ED0 */
    .short  0x84EC        /* $023DA6: [delay] MOV.B @(12,R14),R0 */
.elem_6:
    .short  0x7908        /* $023DA8: ADD #8,R9 */
    .short  0xB091        /* $023DAA: BSR $023ED0 */
    .short  0xE00B        /* $023DAC: [delay] MOV #11,R0 */
.elem_7:
    .short  0x7908        /* $023DAE: ADD #8,R9 */
    .short  0xB08E        /* $023DB0: BSR $023ED0 */
    .short  0x84ED        /* $023DB2: [delay] MOV.B @(13,R14),R0 */
.elem_8:
    .short  0x7908        /* $023DB4: ADD #8,R9 */
    .short  0xB08B        /* $023DB6: BSR $023ED0 */
    .short  0x84EE        /* $023DB8: [delay] MOV.B @(14,R14),R0 */
.elem_9:
    .short  0x7908        /* $023DBA: ADD #8,R9 */
    .short  0xB088        /* $023DBC: BSR $023ED0 */
    .short  0x84EF        /* $023DBE: [delay] MOV.B @(15,R14),R0 */
.done:
    .short  0x4F26        /* $023DC0: LDS.L @R15+,PR */
    .short  0x000B        /* $023DC2: RTS */
    .short  0x0009        /* $023DC4: [delay] NOP */

/* ============================================================================
 * End of func_050 (88 bytes)
 *
 * Literal pool follows at $023DC6:
 *   $023DC8: $06003DCC (address constant used by MOV.L)
 * These are NOT included - remain in code_22200.asm
 * ============================================================================ */
