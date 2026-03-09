/*
 * func_013: VDP Initialization / Data Table Copy
 * ROM File Offset: 0x232D4 - 0x2332F (92 bytes: 54 code + 38 literals/data)
 * SH2 Address: 0x022232D4
 *
 * Purpose: Initializes VDP registers by copying configuration data from
 *          ROM tables to SDRAM and writing VDP control values.
 *
 * Type: Leaf function (no calls)
 * Called By: Rendering initialization
 *
 * Note: All instructions manually encoded as .short to match ROM exactly.
 */

.section .text
.p2align 1    /* 2-byte alignment for 0x232D4 start */

func_013:
    /* ─────────────────────────────────────────────────────────────────────────
     * Setup: Load pointers and counter
     * ───────────────────────────────────────────────────────────────────────── */
    .short  0xDE0D                            /* $0232D4: MOV.L @(13,PC),R14 → dest_base */
    .short  0xC70F                            /* $0232D6: MOVA @(15,PC),R0 → src_table */
    .short  0xE70E                            /* $0232D8: MOV #14,R7 (loop count) */
    .short  0x6DE3                            /* $0232DA: MOV R14,R13 */
    .short  0x7D0C                            /* $0232DC: ADD #12,R13 */

    /* ─────────────────────────────────────────────────────────────────────────
     * Loop 1: Copy 14 longs from ROM to SDRAM
     * ───────────────────────────────────────────────────────────────────────── */
.copy_loop:
    .short  0x6106                            /* $0232DE: MOV.L @R0+,R1 */
    .short  0x2D12                            /* $0232E0: MOV.L R1,@R13 */
    .short  0x4710                            /* $0232E2: DT R7 */
    .short  0x8FFB                            /* $0232E4: BF/S .copy_loop */
    .short  0x7D04                            /* $0232E6: [delay] ADD #4,R13 */

    /* ─────────────────────────────────────────────────────────────────────────
     * Setup for VDP register writes
     * ───────────────────────────────────────────────────────────────────────── */
    .short  0xD009                            /* $0232E8: MOV.L @(9,PC),R0 → vdp_mask */
    .short  0x51E9                            /* $0232EA: MOV.L @(36,R14),R1 */
    .short  0x210B                            /* $0232EC: OR R0,R1 */
    .short  0xE008                            /* $0232EE: MOV #8,R0 (loop count) */
    .short  0x970B                            /* $0232F0: MOV.W @(11,PC),R7 → stride */

    /* ─────────────────────────────────────────────────────────────────────────
     * Loop 2: Write to VDP at 64-byte intervals (unrolled 4x)
     * ───────────────────────────────────────────────────────────────────────── */
.vdp_write_loop:
    .short  0x811E                            /* $0232F2: MOV.W R1,@(28,R14) */
    .short  0x7140                            /* $0232F4: ADD #64,R1 */
    .short  0x811E                            /* $0232F6: MOV.W R1,@(28,R14) */
    .short  0x7140                            /* $0232F8: ADD #64,R1 */
    .short  0x811E                            /* $0232FA: MOV.W R1,@(28,R14) */
    .short  0x7140                            /* $0232FC: ADD #64,R1 */
    .short  0x811E                            /* $0232FE: MOV.W R1,@(28,R14) */
    .short  0x4710                            /* $023300: DT R7 */
    .short  0x8FF6                            /* $023302: BF/S .vdp_write_loop */
    .short  0x7140                            /* $023304: [delay] ADD #64,R1 */

    /* Epilogue */
    .short  0x000B                            /* $023306: RTS */
    .short  0x0009                            /* $023308: [delay] NOP */

/* ─────────────────────────────────────────────────────────────────────────────
 * Literal Pool (must be at correct addresses for PC-relative loads)
 * ───────────────────────────────────────────────────────────────────────────── */
.lit_stride:
    .short  0x0040                            /* $02330A: stride = 64 */

.lit_dest_base:
    .byte   0xC0, 0x00, 0x07, 0x00            /* $02330C: 0xC0000700 - SDRAM context */

.lit_vdp_mask:
    .byte   0x20, 0x00, 0x00, 0x00            /* $023310: 0x20000000 - VDP control mask */

/* Configuration data table (copied to SDRAM by first loop) */
.data_table:
    .byte   0x00, 0x00, 0x00, 0xA0            /* $023314: 0x000000A0 */
    .byte   0x00, 0x00, 0x00, 0x70            /* $023318: 0x00000070 */
    .byte   0x00, 0x00, 0x00, 0x10            /* $02331C: 0x00000010 */
    .byte   0x00, 0x00, 0x00, 0xCF            /* $023320: 0x000000CF */
    .byte   0x00, 0x00, 0x00, 0x00            /* $023324: 0x00000000 */
    .byte   0x00, 0x00, 0x01, 0x3F            /* $023328: 0x0000013F */
    .byte   0x06, 0x01, 0x80, 0x00            /* $02332C: 0x06018000 */

/* ============================================================================
 * End of func_013 (92 bytes: 54 code + 2 stride + 8 literals + 28 data)
 *
 * Note: The loop copies 14 longs but only 7 longs of data are in this
 * literal pool. The remaining 7 longs come from the ROM addresses that
 * follow (which includes func_014's code area when accessed as data).
 * ============================================================================ */
