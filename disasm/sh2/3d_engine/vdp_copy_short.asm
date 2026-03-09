/*
 * func_014 and func_015: VDP Data Copy Utilities
 * ROM File Offset: 0x23330 - 0x23367 (56 bytes)
 * SH2 Address: 0x02223330 - 0x02223367
 *
 * func_014: 6-byte copy to VDP registers (18 bytes code + 6 bytes literal)
 * func_015: 402-byte bulk copy to frame buffer (20 bytes code + 12 bytes literal)
 *
 * Note: All instructions as .short to match ROM exactly.
 */

.section .text
.p2align 1    /* 2-byte alignment for 0x23330 start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_014: 6-Byte VDP Register Copy
 * Entry: 0x02223330
 * Size: 18 bytes code + 6 bytes literal = 24 bytes
 *
 * Copies 6 bytes from @R1 to VDP address 0xC000070C with stride 4
 * ═══════════════════════════════════════════════════════════════════════════ */
func_014:
    .short  0xD204                            /* $023330: MOV.L @(4,PC),R2 → 0xC000070C */
    .short  0xE706                            /* $023332: MOV #6,R7 (loop count) */
.loop_014:
    .short  0x6016                            /* $023334: MOV.B @R1,R0 */
    .short  0x2202                            /* $023336: MOV.B R0,@R2 */
    .short  0x4710                            /* $023338: DT R7 (decrement and test) */
    .short  0x8FFB                            /* $02333A: BF/S loop_014 (-10) */
    .short  0x7204                            /* $02333C: [delay] ADD #4,R2 */
    .short  0x000B                            /* $02333E: RTS */
    .short  0x0009                            /* $023340: [delay] NOP */

/* Literal pool for func_014 */
    .short  0x0000                            /* $023342: padding for 4-byte alignment */
.lit_vdp_reg:
    .byte   0xC0, 0x00, 0x07, 0x0C            /* $023344: 0xC000070C - VDP register base */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_015: Bulk Frame Buffer Copy
 * Entry: 0x02223348
 * Size: 20 bytes code + 12 bytes literal = 32 bytes
 *
 * Copies 402 bytes from SDRAM to VDP frame buffer with stride 4
 * ═══════════════════════════════════════════════════════════════════════════ */
func_015:
    .short  0xD105                            /* $023348: MOV.L @(5,PC),R1 → 0xC0000000 */
    .short  0xD006                            /* $02334A: MOV.L @(6,PC),R0 → 0x06003368 */
    .short  0x9706                            /* $02334C: MOV.W @(6,PC),R7 → 0x0192 (402) */
.loop_015:
    .short  0x6206                            /* $02334E: MOV.B @R0,R2 */
    .short  0x2122                            /* $023350: MOV.B R2,@R1 */
    .short  0x4710                            /* $023352: DT R7 (decrement and test) */
    .short  0x8FFB                            /* $023354: BF/S loop_015 (-10) */
    .short  0x7104                            /* $023356: [delay] ADD #4,R1 */
    .short  0x000B                            /* $023358: RTS */
    .short  0x0009                            /* $02335A: [delay] NOP */

/* Literal pool for func_015 */
.lit_count:
    .short  0x0192                            /* $02335C: 402 (byte count) */
    .short  0x0000                            /* $02335E: padding */
.lit_vdp_fb:
    .byte   0xC0, 0x00, 0x00, 0x00            /* $023360: 0xC0000000 - VDP frame buffer */
.lit_src_data:
    .byte   0x06, 0x00, 0x33, 0x68            /* $023364: 0x06003368 - Source in SDRAM */

/* ============================================================================
 * End of func_014 + func_015 (56 bytes total)
 *
 * Analysis:
 * - func_014: Copies 6 bytes to VDP registers (initialization)
 * - func_015: Copies 402 bytes of frame data (DMA-like transfer)
 * - Both use stride-4 destination (VDP word access pattern)
 * - Cache-through addresses (0xC0xxxxxx) for direct VDP access
 * ============================================================================ */
