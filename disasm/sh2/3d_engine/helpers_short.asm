/*
 * func_037, func_038, func_039: Visibility Helper Functions
 * ROM File Offset: 0x2381E - 0x2385D (64 bytes)
 * SH2 Addresses:
 *   func_037: 0x0222381E (visibility test)
 *   func_038: 0x02223834 (conditional early return)
 *   func_039: 0x02223844 (span setup caller)
 *
 * These are helper subroutines called by func_036 (render dispatch).
 *
 * Note: All instructions as .short to match ROM exactly.
 */

.section .text
.p2align 1    /* 2-byte alignment for 0x2381E start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_037: Visibility Test Helper
 * Entry: 0x0222381E
 * Size: 22 bytes
 *
 * Purpose: Test if value R3 is within bounds [R14+0x1C, R14+0x20]
 *          Returns visibility flags in R0 (0=inside, 4=below, 2=above)
 *
 * Input:
 *   R3  = Value to test
 *   R14 = Context pointer
 *
 * Output:
 *   R0  = Visibility flags
 * ═══════════════════════════════════════════════════════════════════════════ */
func_037:
    .short  0x51E7                            /* $02381E: MOV.L @(28,R14),R1 (min bound) */
    .short  0x52E8                            /* $023820: MOV.L @(32,R14),R2 (max bound) */
    .short  0xE000                            /* $023822: MOV #0,R0 (clear flags) */
    .short  0x3313                            /* $023824: CMP/GE R1,R3 (R3 >= min?) */
    .short  0x8900                            /* $023826: BT .check_max (+0) */
    .short  0xCB04                            /* $023828: OR #4,R0 (below min flag) */
.check_max:
    .short  0x3233                            /* $02382A: CMP/GE R3,R2 (max >= R3?) */
    .short  0x8900                            /* $02382C: BT .done_037 (+0) */
    .short  0xCB02                            /* $02382E: OR #2,R0 (above max flag) */
.done_037:
    .short  0x000B                            /* $023830: RTS */
    .short  0xC806                            /* $023832: [delay] TST #6,R0 */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_038: Conditional Early Return Helper
 * Entry: 0x02223834
 * Size: 16 bytes
 *
 * Purpose: Check visibility flags and return early or load context value
 *
 * Input:
 *   R0  = Visibility flags from func_037
 *   R14 = Context pointer
 *
 * Output:
 *   R3  = Context value (from offset 28 or 32)
 * ═══════════════════════════════════════════════════════════════════════════ */
func_038:
    .short  0x8800                            /* $023834: CMP/EQ #0,R0 (is zero?) */
    .short  0x8B01                            /* $023836: BF .not_zero (+2) */
    .short  0x000B                            /* $023838: RTS (early return if zero) */
    .short  0x0009                            /* $02383A: [delay] NOP */
.not_zero:
    .short  0x8802                            /* $02383C: CMP/EQ #2,R0 (is 2?) */
    .short  0x53E8                            /* $02383E: MOV.L @(32,R14),R3 */
    .short  0x8900                            /* $023840: BT .done_038 (+0) */
    .short  0x53E7                            /* $023842: MOV.L @(28,R14),R3 */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_039: Span Setup Caller
 * Entry: 0x02223844
 * Size: 26 bytes
 *
 * Purpose: Set up span parameters and call func_034 (span filler)
 *
 * Input:
 *   R8  = Input pointer
 *   R9  = Output pointer
 *
 * Calls: func_034 via BSR
 * ═══════════════════════════════════════════════════════════════════════════ */
func_039:
.done_038:
    .short  0x4F22                            /* $023844: STS.L PR,@-R15 (save PR) */
    .short  0x6282                            /* $023846: MOV.L @R8,R2 */
    .short  0x6083                            /* $023848: MOV R8,R0 */
    .short  0x70FC                            /* $02384A: ADD #-4,R0 */
    .short  0x6102                            /* $02384C: MOV.L @R0,R1 */
    .short  0x6229                            /* $02384E: SWAP.W R2,R2 */
    .short  0xBF85                            /* $023850: BSR func_034 (-246 → $02375C) */
    .short  0x6119                            /* $023852: [delay] SWAP.W R1,R1 */
    .short  0x6339                            /* $023854: SWAP.W R3,R3 */
    .short  0x2932                            /* $023856: MOV.L R3,@R9 */
    .short  0x4F26                            /* $023858: LDS.L @R15+,PR (restore PR) */
    .short  0x000B                            /* $02385A: RTS */
    .short  0x7904                            /* $02385C: [delay] ADD #4,R9 */

/* ============================================================================
 * End of func_037_038_039 (64 bytes)
 *
 * Analysis:
 * - func_037: Visibility test against context bounds (22 bytes)
 * - func_038: Conditional return based on visibility flags (16 bytes)
 * - func_039: Span setup and func_034 call (26 bytes)
 * - Used by func_036 render dispatch for polygon visibility culling
 * ============================================================================ */
