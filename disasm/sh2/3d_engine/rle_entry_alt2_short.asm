/*
 * func_068: RLE Entry Point (Alternative 2)
 * ROM File Offset: 0x24002 - 0x2400D (12 bytes)
 * SH2 Address: 0x02224002 - 0x0222400D
 *
 * Purpose: Second alternative entry point for RLE decoder (func_066).
 *          Similar to func_067 but without NEG R13 in delay slot.
 *
 * Type: Entry point (BRA to func_066)
 * Called By: Unknown dispatcher
 * Jumps To: $023FCC (func_066 inner loop)
 *
 * Operation:
 *   1. Load R8 = @(8,R14), R9 = @(4,R14)
 *   2. R8 += 2 (skip header word)
 *   3. R7 = word from @(2,R14)
 *   4. BRA to func_066 loop
 */

.section .text
.p2align 1    /* 2-byte alignment for $024002 start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_068: RLE Entry Point (Alternative 2)
 * Entry: 0x02224002
 * ═══════════════════════════════════════════════════════════════════════════ */
func_068:
    .short  0x58E2        /* $024002: MOV.L @(8,R14),R8 */
    .short  0x59E1        /* $024004: MOV.L @(4,R14),R9 */
    .short  0x7802        /* $024006: ADD #2,R8 */
    .short  0x85E1        /* $024008: MOV.W @(2,R14),R0 */
    .short  0xAFDF        /* $02400A: BRA $023FCC (into func_066 loop) */
    .short  0x6703        /* $02400C: [delay] MOV R0,R7 */

/* ============================================================================
 * End of func_068 (12 bytes = 6 instructions)
 *
 * Note: Similar to func_067 but R13 is not negated.
 * Both entry points share func_066's main RLE decoding loop.
 * ============================================================================ */
