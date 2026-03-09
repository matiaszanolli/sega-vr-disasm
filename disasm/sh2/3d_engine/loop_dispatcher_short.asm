/*
 * func_070: Loop Dispatcher
 * ROM File Offset: 0x24060 - 0x24083 (36 bytes)
 * SH2 Address: 0x02224060 - 0x02224083
 *
 * Purpose: Dispatcher loop that conditionally calls two subroutines.
 *          Loops through elements, calling BSR targets for each.
 *
 * Type: Non-leaf function (2 BSR calls)
 * Called By: Unknown
 * Calls: $024084 (setup), $0241A4 (processing)
 *
 * Operation:
 *   1. Check byte @(0,R14) - if zero, skip to loop
 *   2. Push R14, R7 onto stack
 *   3. Call $024084 (setup subroutine)
 *   4. Call $0241A4 (processing subroutine)
 *   5. Pop R7, R14; decrement R7, advance R14 by 20
 *   6. Loop while R7 > 0
 */

.section .text
.p2align 1    /* 2-byte alignment for $024060 start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_070: Loop Dispatcher
 * Entry: 0x02224060
 * ═══════════════════════════════════════════════════════════════════════════ */
func_070:
    .short  0x4F22        /* $024060: STS.L PR,@-R15 */
.loop:
    .short  0x85E0        /* $024062: MOV.W @(0,R14),R0 */
    .short  0x8800        /* $024064: CMP/EQ #0,R0 */
    .short  0x8907        /* $024066: BT .next (skip if zero) */
    .short  0x2FE6        /* $024068: MOV.L R14,@-R15 */
    .short  0x2F76        /* $02406A: MOV.L R7,@-R15 */
    .short  0xB00A        /* $02406C: BSR $024084 (setup) */
    .short  0x0009        /* $02406E: [delay] NOP */
    .short  0xB098        /* $024070: BSR $0241A4 (process) */
    .short  0x0009        /* $024072: [delay] NOP */
    .short  0x67F6        /* $024074: MOV.L @R15+,R7 */
    .short  0x6EF6        /* $024076: MOV.L @R15+,R14 */
.next:
    .short  0x4710        /* $024078: DT R7 */
    .short  0x8FF2        /* $02407A: BF/S .loop */
    .short  0x7E14        /* $02407C: [delay] ADD #20,R14 */
    .short  0x4F26        /* $02407E: LDS.L @R15+,PR */
    .short  0x000B        /* $024080: RTS */
    .short  0x0009        /* $024082: [delay] NOP */

/* ============================================================================
 * End of func_070 (36 bytes = 18 instructions)
 *
 * Note: This is a dispatcher that iterates through an array of elements.
 * Each element is 20 bytes (R14 += 20). R7 is the element count.
 * For each non-zero element, calls setup ($024084) then process ($0241A4).
 * ============================================================================ */
