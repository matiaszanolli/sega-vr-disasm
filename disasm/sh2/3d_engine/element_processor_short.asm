/*
 * func_072: Element Processor
 * ROM File Offset: 0x241A4 - 0x241CD (42 bytes)
 * SH2 Address: 0x022241A4 - 0x022241CD
 *
 * Purpose: Processes elements from VDP buffer, conditionally calling
 *          func_074 for each non-zero element. Handles negative counts.
 *
 * Type: Non-leaf function (BSR to func_074)
 * Called By: func_070 via BSR at $024070
 * Calls: func_074 via BSR at $0241BE
 *
 * Operation:
 *   1. Load VDP base ($C0000000) and offset ($0200) from literals
 *   2. Check element count - if negative, jump to func_073 entry
 *   3. Loop: read byte from VDP, if non-zero call func_074
 *   4. Advance dest by 8 for each element
 *
 * Literal pool at $0241CE:
 *   $0241CE: $0200 (offset)
 *   $0241D0: $0400 (offset 2)
 *   $0241D4: $C0000000 (VDP base)
 */

.section .text
.p2align 1    /* 2-byte alignment for $0241A4 start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_072: Element Processor
 * Entry: 0x022241A4
 * ═══════════════════════════════════════════════════════════════════════════ */
func_072:
    .short  0x4F22        /* $0241A4: STS.L PR,@-R15 */
    .short  0xDC0B        /* $0241A6: MOV.L @(44,PC),R12 → $C0000000 at $0241D4 */
    .short  0x9D11        /* $0241A8: MOV.W @(34,PC),R13 → $0200 at $0241CE */
    .short  0x59E1        /* $0241AA: MOV.L @(4,R14),R9 */
    .short  0x9010        /* $0241AC: MOV.W @(32,PC),R0 → $0400 at $0241D0 */
    .short  0x390C        /* $0241AE: ADD R0,R9 */
    .short  0x85E0        /* $0241B0: MOV.W @(0,R14),R0 (element count) */
    .short  0x4011        /* $0241B2: CMP/PZ R0 */
    .short  0x8B10        /* $0241B4: BF .negative_handler ($0241D8) */
    .short  0x6B03        /* $0241B6: MOV R0,R11 */
.loop:
    .short  0x60C4        /* $0241B8: MOV.B @R12+,R0 */
    .short  0x8800        /* $0241BA: CMP/EQ #0,R0 */
    .short  0x8901        /* $0241BC: BT .skip */
    .short  0xB013        /* $0241BE: BSR func_074 ($0241E8) */
    .short  0x0009        /* $0241C0: [delay] NOP */
.skip:
    .short  0x4B10        /* $0241C2: DT R11 */
    .short  0x8FF8        /* $0241C4: BF/S .loop */
    .short  0x7908        /* $0241C6: [delay] ADD #8,R9 */
    .short  0x4F26        /* $0241C8: LDS.L @R15+,PR */
    .short  0x000B        /* $0241CA: RTS */
    .short  0x0009        /* $0241CC: [delay] NOP */

/* ============================================================================
 * End of func_072 (42 bytes = 21 instructions)
 *
 * Literal pool follows at $0241CE:
 *   $0241CE: $0200 - offset constant
 *   $0241D0: $0400 - second offset
 *   $0241D2: $0000 - padding
 *   $0241D4: $C0000000 - VDP base address (as longword)
 *
 * Note: func_073 at $0241D8 is an alternative entry that handles negative
 * counts by adjusting R11/R12/R9 before jumping into this function's loop.
 * ============================================================================ */
