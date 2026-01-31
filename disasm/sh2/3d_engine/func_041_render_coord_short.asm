/*
 * func_041: Main Render Coordinator
 * ROM File Offset: 0x239F0 - 0x23A51 (98 bytes)
 * SH2 Address: 0x022239F0 - 0x02223A51
 *
 * Purpose: Coordinates the rendering pipeline by calling initialization,
 *          data copy (func_042), and GBR setup (func_040_utility) routines.
 *          Includes status checking and a 16-iteration delay loop.
 *
 * Type: Non-leaf function (calls multiple subroutines)
 * Called By: Display engine main loop
 * Calls: JSR to init routine, BSR to func_042, BSR to func_040_utility
 *
 * Note: Contains embedded literal pool data mixed with code.
 *       Uses tail call (JMP) for some exit paths instead of RTS.
 */

.section .text
.p2align 1    /* 2-byte alignment for $0239F0 start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_041: Main Render Coordinator
 * Entry: 0x022239F0
 * ═══════════════════════════════════════════════════════════════════════════ */
func_041:
    .short  0x4F22        /* $0239F0: STS.L PR,@-R15 (save return addr) */
    .short  0xD00E        /* $0239F2: MOV.L @(56,PC),R0 → init routine */
    .short  0x400B        /* $0239F4: JSR @R0 */
    .short  0x0009        /* $0239F6: [delay] NOP */
    .short  0xB02B        /* $0239F8: BSR $023A52 (func_042) */
    .short  0x0009        /* $0239FA: [delay] NOP */
    .short  0xBFD8        /* $0239FC: BSR $0239B0 (func_040_utility) */
    .short  0x0009        /* $0239FE: [delay] NOP */
status_check:
    .short  0xD00B        /* $023A00: MOV.L @(44,PC),R0 → status mask */
    .short  0x51E9        /* $023A02: MOV.L @(36,R14),R1 */
    .short  0x210B        /* $023A04: OR R0,R1 */
    .short  0x851E        /* $023A06: MOV.W @(28,R1),R0 */
    .short  0xC804        /* $023A08: TST #4,R0 */
    .short  0x891D        /* $023A0A: BT $023A48 (to delay loop) */
    .short  0xC802        /* $023A0C: TST #2,R0 */
    .short  0x8B13        /* $023A0E: BF $023A38 (exit path) */
    /* Processing path */
    .short  0xD008        /* $023A10: MOV.L @(32,PC),R0 → proc routine */
    .short  0x400B        /* $023A12: JSR @R0 */
    .short  0x2FE6        /* $023A14: [delay] MOV.L R14,@-R15 */
    .short  0x6EF6        /* $023A16: MOV.L @R15+,R14 */
    .short  0x51E9        /* $023A18: MOV.L @(36,R14),R1 */
    .short  0xE008        /* $023A1A: MOV #8,R0 */
    .short  0x811E        /* $023A1C: MOV.W R0,@(28,R1) */
    .short  0x9004        /* $023A1E: MOV.W @(8,PC),R0 → mask 0xBFFF */
    .short  0x51E9        /* $023A20: MOV.L @(36,R14),R1 */
    .short  0x7140        /* $023A22: ADD #64,R1 */
    .short  0x2109        /* $023A24: AND R0,R1 */
    .short  0xAFEB        /* $023A26: BRA $023A00 (loop back) */
    .short  0x1E19        /* $023A28: [delay] MOV.L R1,@(36,R14) */
    /* Embedded data - this acts as both literal and potential dead code */
    .short  0xBFFF        /* $023A2A: mask constant / BSR to next */
    /* Literal pool entries */
    .short  0x0600        /* $023A2C: hi word of $060045CC (init routine) */
    .short  0x45CC        /* $023A2E: lo word */
    .short  0x2000        /* $023A30: hi word of $20000000 (status mask) */
    .short  0x0000        /* $023A32: lo word */
    .short  0xC000        /* $023A34: hi word of $C0000000 (proc routine) */
    .short  0x0000        /* $023A36: lo word */
exit_path:
    .short  0x9003        /* $023A38: MOV.W @(6,PC),R0 */
    .short  0x811E        /* $023A3A: MOV.W R0,@(28,R1) */
    .short  0xD001        /* $023A3C: MOV.L @(4,PC),R0 → exit addr */
    .short  0x402B        /* $023A3E: JMP @R0 (tail call) */
    .short  0x4F26        /* $023A40: [delay] LDS.L @R15+,PR */
    /* More embedded data */
    .short  0xAB00        /* $023A42: BRA offset / data */
    .short  0x0600        /* $023A44: hi word of $0600442C (exit addr) */
    .short  0x442C        /* $023A46: lo word */
delay_loop:
    .short  0xE710        /* $023A48: MOV #16,R7 */
.delay_spin:
    .short  0x4710        /* $023A4A: DT R7 */
    .short  0x8BFD        /* $023A4C: BF $023A4A (spin) */
    .short  0xAFDA        /* $023A4E: BRA $023A06 (back to status) */
    .short  0x0009        /* $023A50: [delay] NOP */

/* ============================================================================
 * End of func_041 (98 bytes)
 *
 * Note: This function uses tail call optimization (JMP with PR restore
 * in delay slot) rather than RTS for some exit paths. The embedded
 * literal pool is referenced by PC-relative addressing.
 * ============================================================================ */
