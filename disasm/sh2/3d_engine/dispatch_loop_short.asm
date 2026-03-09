/*
 * func_045: Dispatch Loop Processor
 * ROM File Offset: 0x23CB4 - 0x23CF7 (68 bytes: 40 code + 28 data)
 * SH2 Address: 0x02223CB4 - 0x02223CF7
 *
 * Purpose: Processes an array of entries, dispatching to handlers via BSRF.
 *          Iterates R7 times, advancing pointer by 16 bytes per entry.
 *          Uses indexed jump table for type-based dispatch.
 *
 * Type: Non-leaf function (BSRF calls to handlers)
 * Called By: Display engine render pipeline
 *
 * Operation:
 *   1. Read type byte from @(0,R14)
 *   2. If zero, skip dispatch (empty entry)
 *   3. Load offset from jump table at $06003CDC
 *   4. BSRF to handler at PC+4+offset
 *   5. Advance R14 by 16, decrement R7
 *   6. Repeat until R7 reaches zero
 *
 * Registers:
 *   R7: Loop counter (entry count)
 *   R13: Stride value ($0200) - loaded from literal pool
 *   R14: Current entry pointer, advances by 16 each iteration
 *
 * Note: Literal pool for stride and table base at $023D1C-$023D23
 *       (shared with func_046, not included here)
 */

.section .text
.p2align 1    /* 2-byte alignment for $023CB4 start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_045: Dispatch Loop Processor
 * Entry: 0x02223CB4
 * ═══════════════════════════════════════════════════════════════════════════ */
func_045:
    .short  0x4F22        /* $023CB4: STS.L PR,@-R15 */
.loop_start:
    .short  0x84E0        /* $023CB6: MOV.B @(0,R14),R0 */
    .short  0x8800        /* $023CB8: CMP/EQ #0,R0 */
    .short  0x8909        /* $023CBA: BT $023CD0 (skip if zero) */
    .short  0x2FE6        /* $023CBC: MOV.L R14,@-R15 */
    .short  0x2F76        /* $023CBE: MOV.L R7,@-R15 */
    .short  0x9D2C        /* $023CC0: MOV.W @(88,PC),R13 → stride $0200 at $023D1C */
    .short  0xD117        /* $023CC2: MOV.L @(92,PC),R1 → table base $06003CDC at $023D20 */
    .short  0x4000        /* $023CC4: SHLL R0 (multiply by 2 for word index) */
    .short  0x001D        /* $023CC6: MOV.W @(R0,R1),R0 (load offset from table) */
    .short  0x0003        /* $023CC8: BSRF R0 (call handler at PC+4+R0) */
    .short  0x0009        /* $023CCA: [delay] NOP */
    .short  0x67F6        /* $023CCC: MOV.L @R15+,R7 */
    .short  0x6EF6        /* $023CCE: MOV.L @R15+,R14 */
.loop_test:
    .short  0x4710        /* $023CD0: DT R7 */
    .short  0x8FF0        /* $023CD2: BF/S .loop_start (-32) */
    .short  0x7E10        /* $023CD4: [delay] ADD #16,R14 */
    .short  0x4F26        /* $023CD6: LDS.L @R15+,PR */
    .short  0x000B        /* $023CD8: RTS */
    .short  0x0009        /* $023CDA: [delay] NOP */

/* ═══════════════════════════════════════════════════════════════════════════
 * Jump Table: BSRF offsets for each entry type
 * Address: 0x02223CDC - 0x02223CF7 (14 entries, 28 bytes)
 * Values are PC-relative offsets from BSRF at $023CC8+4 = $023CCC
 * ═══════════════════════════════════════════════════════════════════════════ */
.jump_table:
    .short  0x002C        /* $023CDC: Type 0 → $023CF8 (func_046) */
    .short  0x002C        /* $023CDE: Type 1 → $023CF8 (func_046) */
    .short  0x00A2        /* $023CE0: Type 2 → $023D6E */
    .short  0x010C        /* $023CE2: Type 3 → $023DD8 */
    .short  0x0198        /* $023CE4: Type 4 → $023E64 */
    .short  0x0198        /* $023CE6: Type 5 → $023E64 */
    .short  0x01C4        /* $023CE8: Type 6 → $023E90 */
    .short  0x0072        /* $023CEA: Type 7 → $023D3E */
    .short  0x0088        /* $023CEC: Type 8 → $023D54 */
    .short  0x02FA        /* $023CEE: Type 9 → $023FC6 */
    .short  0x0058        /* $023CF0: Type 10 → $023D24 */
    .short  0x0328        /* $023CF2: Type 11 → $023FF4 */
    .short  0x0336        /* $023CF4: Type 12 → $024002 */
    .short  0x0342        /* $023CF6: Type 13 → $02400E */

/* ============================================================================
 * End of func_045 (68 bytes total)
 *
 * Note: This function's MOV.W and MOV.L instructions reference literal pool
 * data at $023D1C and $023D20, which are physically located after func_046.
 * This is normal for SH2 code - literal pools can be distant from code.
 * ============================================================================ */
