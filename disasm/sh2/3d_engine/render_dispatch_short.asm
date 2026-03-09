/*
 * func_036: Render Dispatch D / Display List Processor
 * ROM File Offset: 0x237D6 - 0x2381D (72 bytes)
 * SH2 Address: 0x022237D6 - 0x0222381D
 *
 * Purpose: Process display list of polygon entries, performing visibility
 *          tests and dispatching to render subroutines. Processes entries
 *          until 0xFF terminator is found.
 *
 * Called By: func_023 (frustum_cull) third visibility path
 *
 * Input:
 *   R8  = Input display list pointer
 *   R9  = Output buffer pointer
 *   R12 = Output control / stride
 *   R14 = Context pointer (contains bounds at +0x1C, +0x20)
 *
 * Output:
 *   R8  = Advanced past processed entries
 *   R9  = Advanced past output data
 *   R0  = 0xFF written to output as terminator
 *
 * Calls:
 *   Subroutine @ $02381E (visibility test helper) via BSR
 *   Subroutine @ $023834 (render output helper) via BSR
 *
 * Note: All instructions as .short to match ROM exactly.
 */

.section .text
.p2align 1    /* 2-byte alignment for 0x237D6 start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_036: Render Dispatch D
 * Entry: 0x022237D6
 * ═══════════════════════════════════════════════════════════════════════════ */
func_036:
    /* Function prologue - save PR for subroutine calls */
    .short  0x4F22                            /* $0237D6: STS.L PR,@-R15 */

    /* First visibility test call */
    .short  0xB021                            /* $0237D8: BSR $02381E (visibility test) */
    .short  0x6381                            /* $0237DA: [delay] MOV.W @R8,R3 (load entry) */

    /* Store visibility results */
    .short  0x6A03                            /* $0237DC: MOV R0,R10 (result A) */
    .short  0x6C03                            /* $0237DE: MOV R0,R12 (current visibility) */

.entry_loop:
    /* Load next entry and test */
    .short  0x6386                            /* $0237E0: MOV.L @R8+,R3 (load & advance) */
    .short  0x8B01                            /* $0237E2: BF .skip_output (+2) */
    .short  0x2932                            /* $0237E4: MOV.L R3,@R9 (output entry) */
    .short  0x7904                            /* $0237E6: ADD #4,R9 (advance output) */

.skip_output:
    /* Second visibility test */
    .short  0xB019                            /* $0237E8: BSR $02381E (visibility test) */
    .short  0x6381                            /* $0237EA: [delay] MOV.W @R8,R3 (load entry) */
    .short  0x6B03                            /* $0237EC: MOV R0,R11 (result B) */

    /* Test combined visibility */
    .short  0x20C8                            /* $0237EE: TST R12,R0 */
    .short  0x8B0C                            /* $0237F0: BF .write_terminator (+24) */
    .short  0x20CB                            /* $0237F2: TST R12,R11 */
    .short  0xC806                            /* $0237F4: TST #6,R0 */
    .short  0x8906                            /* $0237F6: BT .alt_path (+12) */

    /* Primary render path */
    .short  0xB01C                            /* $0237F8: BSR $023834 (render helper) */
    .short  0x60C3                            /* $0237FA: [delay] MOV R12,R0 */
    .short  0xB01A                            /* $0237FC: BSR $023834 (render helper) */
    .short  0x60B3                            /* $0237FE: [delay] MOV R11,R0 */

.alt_path:
    /* Alternate visibility test */
    .short  0x60B3                            /* $023800: MOV R11,R0 */
    .short  0xC806                            /* $023802: TST #6,R0 */
    .short  0x8B02                            /* $023804: BF .continue_loop (+4) */
    .short  0x6382                            /* $023806: MOV.L @R8+,R3 (skip entry) */
    .short  0x2932                            /* $023808: MOV.L R3,@R9 */
    .short  0x7904                            /* $02380A: ADD #4,R9 */

.continue_loop:
    /* Advance and loop check */
    .short  0x7804                            /* $02380C: ADD #4,R8 (advance input) */
    .short  0x6CB3                            /* $02380E: MOV R11,R12 (update visibility) */
    .short  0x6082                            /* $023810: MOV.L @R8,R0 (peek next) */
    .short  0x88FF                            /* $023812: CMP/EQ #0xFF,R0 (terminator?) */
    .short  0x8BE8                            /* $023814: BF .entry_loop (-48) */

.write_terminator:
    /* Write terminator and return */
    .short  0xE0FF                            /* $023816: MOV #-1,R0 (0xFF terminator) */
    .short  0x4F26                            /* $023818: LDS.L @R15+,PR (restore PR) */
    .short  0x000B                            /* $02381A: RTS */
    .short  0x2902                            /* $02381C: [delay] MOV.L R0,@R9 (write term) */

/* ============================================================================
 * End of func_036 (72 bytes)
 *
 * Analysis:
 * - Processes display list entries in a loop
 * - Calls visibility test helper ($02381E) for each entry
 * - Calls render helper ($023834) for visible entries
 * - Uses R10, R11, R12 to track visibility state across iterations
 * - Writes 0xFF terminator when done
 * - Entry format appears to be longword-aligned polygon descriptors
 * ============================================================================ */
