/*
 * func_040_cases: Jump Table Case Handlers for Display List Processing
 * ROM File Offset: 0x238D8 - 0x239AB (212 bytes)
 * SH2 Address: 0x022238D8 - 0x022239AB
 *
 * Purpose: Case handlers for func_040's 12-entry jump table. Each handler
 *          processes different polygon/edge configurations in the display list,
 *          then branches back to func_040's main loop at $022238B0.
 *
 * Type: Jump table targets (not standalone functions)
 * Called By: func_040 jump table dispatch
 *
 * Structure:
 *   - case_0-6: First set of handlers ($0238D8-$02391D) - basic edge processing
 *   - case_7: Complex handler with embedded data table ($02391E-$0239AB)
 *   - All handlers use R10/R11 as buffer pointers, R8/R9 as VDP sources
 */

.section .text
.p2align 1    /* 2-byte alignment for $0238D8 start */

/* ═══════════════════════════════════════════════════════════════════════════
 * case_0: Store R2 to buffer A, return to loop
 * Entry: $0238D8 (offset 0 from table)
 * ═══════════════════════════════════════════════════════════════════════════ */
case_0:
    .short  0x2A22        /* $0238D8: MOV.L R2,@R10 */
    .short  0xAFE9        /* $0238DA: BRA $022238B0 (back to func_040 loop) */
    .short  0x7A04        /* $0238DC: [delay] ADD #4,R10 */

/* ═══════════════════════════════════════════════════════════════════════════
 * case_1: Compare values, conditional store to A or B
 * Entry: $0238DE
 * Compare R8/R9 contents for 0xFF terminator and value ordering
 * ═══════════════════════════════════════════════════════════════════════════ */
case_1:
    .short  0xE0FF        /* $0238DE: MOV #-1,R0 (0xFF terminator) */
    .short  0x6382        /* $0238E0: MOV.L @R8,R3 */
    .short  0x3300        /* $0238E2: CMP/EQ R0,R3 */
    .short  0x8906        /* $0238E4: BT $0238F4 (if R3 == 0xFF) */
    .short  0x6492        /* $0238E6: MOV.L @R9,R4 */
    .short  0x3400        /* $0238E8: CMP/EQ R0,R4 */
    .short  0x8907        /* $0238EA: BT $0238FC (if R4 == 0xFF) */
    .short  0x633F        /* $0238EC: EXTS.W R3,R3 (sign extend) */
    .short  0x644F        /* $0238EE: EXTS.W R4,R4 (sign extend) */
    .short  0x3437        /* $0238F0: CMP/GT R3,R4 */
    .short  0x8903        /* $0238F2: BT $0238FC (if R4 > R3) */
    /* Fall through: store from R9 to A */
    .short  0x6092        /* $0238F4: MOV.L @R9,R0 */
    .short  0x2A02        /* $0238F6: MOV.L R0,@R10 */
    .short  0xAFDA        /* $0238F8: BRA $022238B0 */
    .short  0x7A04        /* $0238FA: [delay] ADD #4,R10 */
    /* Store from R8 to B */
    .short  0x6082        /* $0238FC: MOV.L @R8,R0 */
    .short  0x2B02        /* $0238FE: MOV.L R0,@R11 */
    .short  0xAFD6        /* $023900: BRA $022238B0 */
    .short  0x7B04        /* $023902: [delay] ADD #4,R11 */

/* ═══════════════════════════════════════════════════════════════════════════
 * case_2: Store R2 to A, R1 to B
 * Entry: $023904
 * ═══════════════════════════════════════════════════════════════════════════ */
case_2:
    .short  0x2A22        /* $023904: MOV.L R2,@R10 */
    .short  0x7A04        /* $023906: ADD #4,R10 */
    .short  0x2B12        /* $023908: MOV.L R1,@R11 */
    .short  0xAFD1        /* $02390A: BRA $022238B0 */
    .short  0x7B04        /* $02390C: [delay] ADD #4,R11 */

/* ═══════════════════════════════════════════════════════════════════════════
 * case_3: Store R1 to A only
 * Entry: $02390E
 * ═══════════════════════════════════════════════════════════════════════════ */
case_3:
    .short  0x2A12        /* $02390E: MOV.L R1,@R10 */
    .short  0xAFCE        /* $023910: BRA $022238B0 */
    .short  0x7A04        /* $023912: [delay] ADD #4,R10 */

/* ═══════════════════════════════════════════════════════════════════════════
 * case_4: Store R1 to A, R2 to B
 * Entry: $023914
 * ═══════════════════════════════════════════════════════════════════════════ */
case_4:
    .short  0x2A12        /* $023914: MOV.L R1,@R10 */
    .short  0x7A04        /* $023916: ADD #4,R10 */
    .short  0x2B22        /* $023918: MOV.L R2,@R11 */
    .short  0xAFC9        /* $02391A: BRA $022238B0 */
    .short  0x7B04        /* $02391C: [delay] ADD #4,R11 */

/* ═══════════════════════════════════════════════════════════════════════════
 * case_5: Complex handler with embedded jump table
 * Entry: $02391E
 * Reads status byte, dispatches through embedded offset table
 * ═══════════════════════════════════════════════════════════════════════════ */
case_5:
    .short  0x85E3        /* $02391E: MOV.W @(6,R14),R0 (read status) */
    .short  0x8800        /* $023920: CMP/EQ #0,R0 */
    .short  0x8D10        /* $023922: BT/S $023946 (if status == 0) */
    .short  0x6303        /* $023924: [delay] MOV R0,R3 */
    .short  0xC702        /* $023926: MOVA @(8,PC),R0 (→ offset table) */
    .short  0x51EC        /* $023928: MOV.L @(48,R14),R1 */
    /* Embedded offset table (12 half-word entries) */
    .short  0x003D        /* $02392A: offset[0] = 0x3D (→ $023946?) */
    .short  0x0023        /* $02392C: offset[1] = 0x23 */
    .short  0x52ED        /* $02392E: MOV.L @(52,R14),R2 */
    .short  0x0016        /* $023930: offset[2] = 0x16 */
    .short  0x001E        /* $023932: offset[3] = 0x1E */
    .short  0x0024        /* $023934: offset[4] = 0x24 */
    .short  0x002A        /* $023936: offset[5] = 0x2A */
    .short  0x002E        /* $023938: offset[6] = 0x2E */
    .short  0x0034        /* $02393A: offset[7] = 0x34 */
    .short  0x0050        /* $02393C: offset[8] = 0x50 */
    .short  0x002A        /* $02393E: offset[9] = 0x2A */
    .short  0x005A        /* $023940: offset[10] = 0x5A */
    .short  0x0060        /* $023942: offset[11] = 0x60 */
    .short  0x0034        /* $023944: offset[12] = 0x34 */

/* ═══════════════════════════════════════════════════════════════════════════
 * case_5_terminator: Store 0xFF to both buffers, exit
 * Entry: $023946
 * ═══════════════════════════════════════════════════════════════════════════ */
case_5_term:
    .short  0xE0FF        /* $023946: MOV #-1,R0 (0xFF terminator) */
    .short  0x2A02        /* $023948: MOV.L R0,@R10 */
    .short  0xA026        /* $02394A: BRA $02399A (to exit path) */
    .short  0x2B02        /* $02394C: [delay] MOV.L R0,@R11 */

/* ═══════════════════════════════════════════════════════════════════════════
 * case_5 sub-handlers (reached via offset table)
 * ═══════════════════════════════════════════════════════════════════════════ */
case_5_sub1:
    .short  0x2B22        /* $02394E: MOV.L R2,@R11 */
    .short  0xAFF9        /* $023950: BRA $023946 (to terminator) */
    .short  0x7B04        /* $023952: [delay] ADD #4,R11 */

case_5_sub2:
    .short  0x2B12        /* $023954: MOV.L R1,@R11 */
    .short  0xAFF6        /* $023956: BRA $023946 */
    .short  0x7B04        /* $023958: [delay] ADD #4,R11 */

/* Internal RTS - early exit point */
    .short  0x000B        /* $02395A: RTS */
    .short  0x0009        /* $02395C: [delay] NOP */

case_5_sub3:
    .short  0x2A22        /* $02395E: MOV.L R2,@R10 */
    .short  0xAFF1        /* $023960: BRA $023946 */
    .short  0x7A04        /* $023962: [delay] ADD #4,R10 */

/* ═══════════════════════════════════════════════════════════════════════════
 * case_6: Compare and swap handler
 * Entry: $023964
 * Decrements pointers, compares values, stores to appropriate buffer
 * ═══════════════════════════════════════════════════════════════════════════ */
case_6:
    .short  0x7AFC        /* $023964: ADD #-4,R10 */
    .short  0x7BFC        /* $023966: ADD #-4,R11 */
    .short  0x63A6        /* $023968: MOV.L @R10+,R3 */
    .short  0x64B6        /* $02396A: MOV.L @R11+,R4 */
    .short  0x613F        /* $02396C: EXTS.W R3,R1 */
    .short  0x624F        /* $02396E: EXTS.W R4,R2 */
    .short  0x3217        /* $023970: CMP/GT R1,R2 */
    .short  0x8902        /* $023972: BT $02397A (if R2 > R1) */
    .short  0x2B32        /* $023974: MOV.L R3,@R11 */
    .short  0xAFE6        /* $023976: BRA $023946 */
    .short  0x7B04        /* $023978: [delay] ADD #4,R11 */
case_6_alt:
    .short  0x2A42        /* $02397A: MOV.L R4,@R10 */
    .short  0xAFE3        /* $02397C: BRA $023946 */
    .short  0x7A04        /* $02397E: [delay] ADD #4,R10 */

/* ═══════════════════════════════════════════════════════════════════════════
 * case_7-9: Additional store combinations
 * ═══════════════════════════════════════════════════════════════════════════ */
case_7:
    .short  0x2A22        /* $023980: MOV.L R2,@R10 */
    .short  0x7A04        /* $023982: ADD #4,R10 */
    .short  0x2B12        /* $023984: MOV.L R1,@R11 */
    .short  0xAFDE        /* $023986: BRA $023946 */
    .short  0x7B04        /* $023988: [delay] ADD #4,R11 */

case_8:
    .short  0x2A12        /* $02398A: MOV.L R1,@R10 */
    .short  0xAFDB        /* $02398C: BRA $023946 */
    .short  0x7A04        /* $02398E: [delay] ADD #4,R10 */

case_9:
    .short  0x2A12        /* $023990: MOV.L R1,@R10 */
    .short  0x7A04        /* $023992: ADD #4,R10 */
    .short  0x2B22        /* $023994: MOV.L R2,@R11 */
    .short  0xAFD6        /* $023996: BRA $023946 */
    .short  0x7B04        /* $023998: [delay] ADD #4,R11 */

/* ═══════════════════════════════════════════════════════════════════════════
 * exit_path: Final status update and return
 * Entry: $02399A (target of BRA from case_5_term)
 * ═══════════════════════════════════════════════════════════════════════════ */
exit_path:
    .short  0x85E0        /* $02399A: MOV.W @(0,R14),R0 */
    .short  0x816F        /* $02399C: MOV.W R0,@(30,R1) */
    .short  0xE004        /* $02399E: MOV #4,R0 */
    .short  0x816E        /* $0239A0: MOV.W R0,@(28,R1) */
    .short  0x9003        /* $0239A2: MOV.W @(6,PC),R0 (→ mask) */
    .short  0x7640        /* $0239A4: ADD #64,R6 */
    .short  0x2609        /* $0239A6: AND R0,R6 */
    .short  0x000B        /* $0239A8: RTS */
    .short  0x1E69        /* $0239AA: [delay] MOV.L R6,@(36,R14) */

/* ============================================================================
 * End of func_040_cases (212 bytes)
 *
 * Note: The word immediately after ($0239AC) contains mask constant 0xBFFF
 *       which is part of a literal pool, not code.
 * ============================================================================ */
