/*
 * func_071: Context Setup / Parameter Initialization
 * ROM File Offset: 0x24084 - 0x240FD (122 bytes)
 * SH2 Address: 0x02224084 - 0x022240FD
 *
 * Purpose: Initializes rendering context parameters from R14 structure.
 *          Performs indexed table lookup and stores results to VDP registers.
 *          Called by func_070's BSR at $02406C.
 *
 * Type: Leaf function (no subroutine calls)
 * Called By: func_070 (via BSR)
 *
 * Operation:
 *   1. Load VDP base ($C0000000) and table base ($0600410C) from literals
 *   2. Read index from context, perform table lookup
 *   3. Copy multiple parameters from context to destination
 *   4. Read string/data bytes from indexed table location
 *
 * Literal pool at $024100:
 *   $024100: $C0000000 (VDP base)
 *   $024104: $0600410C (table base 1)
 *   $024108: $06004184 (table base 2)
 */

.section .text
.p2align 1    /* 2-byte alignment for $024084 start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_071: Context Setup
 * Entry: 0x02224084
 * ═══════════════════════════════════════════════════════════════════════════ */
func_071:
    .short  0xDD1E        /* $024084: MOV.L @(120,PC),R13 → $C0000000 at $024100 */
    .short  0xD11F        /* $024086: MOV.L @(124,PC),R1 → $0600410C at $024104 */
    .short  0x84E2        /* $024088: MOV.B @(2,R14),R0 */
    .short  0x4008        /* $02408A: SHLL2 R0 (index *= 4) */
    .short  0x001E        /* $02408C: MOV.L @(R0,R1),R0 (table lookup) */
    .short  0x2D02        /* $02408E: MOV.L R0,@R13 */
    .short  0xE000        /* $024090: MOV #0,R0 */
    .short  0x81D2        /* $024092: MOV.W R0,@(4,R13) */
    .short  0x85E8        /* $024094: MOV.W @(16,R14),R0 */
    .short  0x81D3        /* $024096: MOV.W R0,@(6,R13) */
    .short  0x85E9        /* $024098: MOV.W @(18,R14),R0 */
    .short  0x81D4        /* $02409A: MOV.W R0,@(8,R13) */
    .short  0xE000        /* $02409C: MOV #0,R0 */
    .short  0x80DA        /* $02409E: MOV.B R0,@(10,R13) */
    .short  0x84EA        /* $0240A0: MOV.B @(10,R14),R0 */
    .short  0x7030        /* $0240A2: ADD #48,R0 */
    .short  0x80DB        /* $0240A4: MOV.B R0,@(11,R13) */
    .short  0xE027        /* $0240A6: MOV #39,R0 */
    .short  0x80DC        /* $0240A8: MOV.B R0,@(12,R13) */
    .short  0x84EB        /* $0240AA: MOV.B @(11,R14),R0 */
    .short  0x7030        /* $0240AC: ADD #48,R0 */
    .short  0x80DD        /* $0240AE: MOV.B R0,@(13,R13) */
    .short  0x84EC        /* $0240B0: MOV.B @(12,R14),R0 */
    .short  0x7030        /* $0240B2: ADD #48,R0 */
    .short  0x80DE        /* $0240B4: MOV.B R0,@(14,R13) */
    .short  0xE022        /* $0240B6: MOV #34,R0 */
    .short  0x80DF        /* $0240B8: MOV.B R0,@(15,R13) */
    .short  0x7D10        /* $0240BA: ADD #16,R13 */
    .short  0x84ED        /* $0240BC: MOV.B @(13,R14),R0 */
    .short  0x7030        /* $0240BE: ADD #48,R0 */
    .short  0x80D0        /* $0240C0: MOV.B R0,@(0,R13) */
    .short  0x84EE        /* $0240C2: MOV.B @(14,R14),R0 */
    .short  0x7030        /* $0240C4: ADD #48,R0 */
    .short  0x80D1        /* $0240C6: MOV.B R0,@(1,R13) */
    .short  0x84EF        /* $0240C8: MOV.B @(15,R14),R0 */
    .short  0x7030        /* $0240CA: ADD #48,R0 */
    .short  0x80D2        /* $0240CC: MOV.B R0,@(2,R13) */
    .short  0xE000        /* $0240CE: MOV #0,R0 */
    .short  0x80D3        /* $0240D0: MOV.B R0,@(3,R13) */
    .short  0x80D4        /* $0240D2: MOV.B R0,@(4,R13) */
    .short  0x84E3        /* $0240D4: MOV.B @(3,R14),R0 */
    .short  0xD10C        /* $0240D6: MOV.L @(48,PC),R1 → $06004184 at $024108 */
    .short  0x4008        /* $0240D8: SHLL2 R0 */
    .short  0x4000        /* $0240DA: SHLL R0 (index *= 8) */
    .short  0x310C        /* $0240DC: ADD R0,R1 */
    .short  0x6014        /* $0240DE: MOV.B @R1+,R0 */
    .short  0x80D5        /* $0240E0: MOV.B R0,@(5,R13) */
    .short  0x6014        /* $0240E2: MOV.B @R1+,R0 */
    .short  0x80D6        /* $0240E4: MOV.B R0,@(6,R13) */
    .short  0x6014        /* $0240E6: MOV.B @R1+,R0 */
    .short  0x80D7        /* $0240E8: MOV.B R0,@(7,R13) */
    .short  0x6014        /* $0240EA: MOV.B @R1+,R0 */
    .short  0x80D8        /* $0240EC: MOV.B R0,@(8,R13) */
    .short  0x6014        /* $0240EE: MOV.B @R1+,R0 */
    .short  0x80D9        /* $0240F0: MOV.B R0,@(9,R13) */
    .short  0x6014        /* $0240F2: MOV.B @R1+,R0 */
    .short  0x80DA        /* $0240F4: MOV.B R0,@(10,R13) */
    .short  0x6014        /* $0240F6: MOV.B @R1+,R0 */
    .short  0x80DB        /* $0240F8: MOV.B R0,@(11,R13) */
    .short  0x000B        /* $0240FA: RTS */
    .short  0x0009        /* $0240FC: [delay] NOP */

/* ============================================================================
 * End of func_071 (122 bytes = 61 instructions)
 *
 * Literal pool follows at $0240FE:
 *   $024100: $C0000000 - VDP base address
 *   $024104: $0600410C - Table base 1 (indexed lookup)
 *   $024108: $06004184 - Table base 2 (string/data table)
 *
 * Note: The ADD #48 operations ($7030) convert binary digits to ASCII ('0'=48).
 * This function appears to format numeric display data.
 * ============================================================================ */
