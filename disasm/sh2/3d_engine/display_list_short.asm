/*
 * func_040: Display List Buffer Setup
 * ROM File Offset: 0x2385E - 0x238D7 (122 bytes)
 * SH2 Address: 0x0222385E - 0x022238D7
 *
 * Purpose: Initialize display list buffers at VDP addresses.
 *          Copies polygon data from context to VDP frame buffers.
 *          Handles jump table dispatch for different polygon types.
 *
 * Type: Leaf function with jump table
 * Called By: Display engine coordinator
 *
 * Note: All instructions as .short to match ROM exactly.
 */

.section .text
.p2align 1    /* 2-byte alignment for 0x2385E start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_040: Display List Buffer Setup
 * Entry: 0x0222385E
 * ═══════════════════════════════════════════════════════════════════════════ */
func_040:
    /* Load VDP buffer pointers and context */
    .short  0xD811                              /* $02385E: MOV.L @(68,PC),R8 → VDP buf A */
    .short  0xD911                              /* $023860: MOV.L @(68,PC),R9 → VDP buf B */
    .short  0x56E9                              /* $023862: MOV.L @(36,R14),R6 */
    .short  0xD111                              /* $023864: MOV.L @(68,PC),R1 → flag mask */
    .short  0x216B                              /* $023866: OR R6,R1 */
    .short  0x851E                              /* $023868: MOV.W @(28,R1),R0 */
    .short  0xC808                              /* $02386A: TST #8,R0 */
    .short  0x89FC                              /* $02386C: BT .wait_loop (-8) */

    /* Setup source pointers */
    .short  0x6A63                              /* $02386E: MOV R6,R10 */
    .short  0x6B63                              /* $023870: MOV R6,R11 */
    .short  0x7B20                              /* $023872: ADD #32,R11 */

    /* Check status and dispatch */
    .short  0x85E2                              /* $023874: MOV.W @(4,R14),R0 */
    .short  0x8800                              /* $023876: CMP/EQ #0,R0 */
    .short  0x8D1A                              /* $023878: BT/S .process_b (+52) */
    .short  0x6303                              /* $02387A: [delay] MOV R0,R3 */

    /* Jump table setup */
    .short  0xC702                              /* $02387C: MOVA @(8,PC),R0 */
    .short  0x51EA                              /* $02387E: MOV.L @(40,R14),R1 */
    .short  0x003D                              /* $023880: MOV.B @(R0,R3),R0 */
    .short  0x0023                              /* $023882: BRAF R0 */
    .short  0x52EB                              /* $023884: [delay] MOV.L @(44,R14),R2 */

/* Jump table offsets */
.jump_table:
    .short  0x0009                              /* $023886: offset 0 */
    .short  0x002A                              /* $023888: offset 1 */
    .short  0x0042                              /* $02388A: offset 2 */
    .short  0x0048                              /* $02388C: offset 3 */
    .short  0x004E                              /* $02388E: offset 4 */
    .short  0x0052                              /* $023890: offset 5 */
    .short  0x0058                              /* $023892: offset 6 */
    .short  0x007E                              /* $023894: offset 7 */
    .short  0x004E                              /* $023896: offset 8 */
    .short  0x0088                              /* $023898: offset 9 */
    .short  0x008E                              /* $02389A: offset 10 */
    .short  0x0058                              /* $02389C: offset 11 */

    /* Branch to process_b */
    .short  0xA007                              /* $02389E: BRA .done_setup (+14) */
    .short  0x0009                              /* $0238A0: [delay] NOP */

/* Literal Pool */
.lit_pool:
    .short  0x0000                              /* $0238A2: Padding */
    .short  0xC000                              /* $0238A4: VDP buf A (0xC00007C0) */
    .short  0x07C0                              /* $0238A6: */
    .short  0xC000                              /* $0238A8: VDP buf B (0xC00007E0) */
    .short  0x07E0                              /* $0238AA: */
    .short  0x2000                              /* $0238AC: Flag mask (0x20000000) */
    .short  0x0000                              /* $0238AE: */

/* Copy loop A - read from VDP, write to buffer */
.copy_loop_a:
    .short  0x6086                              /* $0238B0: MOV.L @R8+,R0 */
    .short  0x88FF                              /* $0238B2: CMP/EQ #-1,R0 (0xFF terminator) */
    .short  0x8902                              /* $0238B4: BT .done_a (+4) */
    .short  0x2A02                              /* $0238B6: MOV.L R0,@R10 */
    .short  0xAFFA                              /* $0238B8: BRA .copy_loop_a (-12) */
    .short  0x7A04                              /* $0238BA: [delay] ADD #4,R10 */

/* Copy loop B */
.copy_loop_b:
    .short  0x6096                              /* $0238BC: MOV.L @R9+,R0 */
    .short  0x88FF                              /* $0238BE: CMP/EQ #-1,R0 */
    .short  0x892D                              /* $0238C0: BT .final_exit (+90) */
    .short  0x2B02                              /* $0238C2: MOV.L R0,@R11 */
    .short  0xAFFA                              /* $0238C4: BRA .copy_loop_b (-12) */
    .short  0x7B04                              /* $0238C6: [delay] ADD #4,R11 */

/* Alternate copy paths */
.alt_copy_1:
    .short  0x2B22                              /* $0238C8: MOV.L R2,@R11 */
    .short  0xAFF1                              /* $0238CA: BRA .copy_loop_b (-30) */
    .short  0x7B04                              /* $0238CC: [delay] ADD #4,R11 */

.alt_copy_2:
    .short  0x2B12                              /* $0238CE: MOV.L R1,@R11 */
    .short  0xAFEE                              /* $0238D0: BRA .copy_loop_b (-36) */
    .short  0x7B04                              /* $0238D2: [delay] ADD #4,R11 */

/* Return */
.return:
    .short  0x000B                              /* $0238D4: RTS */
    .short  0x0009                              /* $0238D6: [delay] NOP */

/* ============================================================================
 * End of func_040 (122 bytes)
 *
 * Analysis:
 * - Initializes VDP display list buffers at 0xC00007C0 and 0xC00007E0
 * - Uses jump table for polygon type dispatch (12 entries)
 * - Two copy loops transfer data from VDP to working buffers
 * - Uses 0xFF as terminator for copy loops
 * - Multiple alternate entry points for different copy modes
 * ============================================================================ */
