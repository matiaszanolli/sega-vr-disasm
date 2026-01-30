/*
 * func_013: VDP Initialization / Data Table Copy
 * ROM File Offset: 0x232D4 - 0x23306 (50 bytes)
 * SH2 Address: 0x022232D4 - 0x02223306
 *
 * Purpose: Initializes VDP registers and frame buffer parameters
 *          by copying configuration data from ROM tables to SDRAM.
 *          Part of the rendering setup sequence.
 *
 * Type: Leaf function (no calls)
 * Called By: Rendering initialization
 *
 * Processing:
 *   1. Copy 14 longs (56 bytes) from ROM table to context
 *   2. Write values at 64-byte intervals (VDP register setup)
 */

.section .text
.align 2

func_013:
    /* ─────────────────────────────────────────────────────────────────────────
     * Setup: Load pointers and counter
     * ───────────────────────────────────────────────────────────────────────── */
    /* $0232D4: DE0D */ mov.l   .lit_dest_base,r14  /* R14 = destination base */
    /* $0232D6: C70F */ mova    .lit_src_table,r0   /* R0 = source table address */
    /* $0232D8: E70E */ mov     #14,r7              /* R7 = 14 (loop count) */
    /* $0232DA: 6DE3 */ mov     r14,r13             /* R13 = dest copy */
    /* $0232DC: 7D0C */ add     #12,r13             /* R13 = dest + 12 */

    /* ─────────────────────────────────────────────────────────────────────────
     * Loop 1: Copy 14 longs from ROM to SDRAM
     * ───────────────────────────────────────────────────────────────────────── */
.copy_loop:
    /* $0232DE: 6106 */ mov.l   @r0+,r1             /* R1 = *src++  */
    /* $0232E0: 2D12 */ mov.l   r1,@r13             /* *dest = R1 */
    /* $0232E2: 4710 */ dt      r7                  /* R7--, set T if zero */
    /* $0232E4: 8FFB */ bf/s    .copy_loop          /* Loop if R7 != 0 */
    /* $0232E6: 7D04 */ add     #4,r13              /* [delay] dest += 4 */

    /* ─────────────────────────────────────────────────────────────────────────
     * Setup for VDP register writes
     * ───────────────────────────────────────────────────────────────────────── */
    /* $0232E8: D009 */ mov.l   .lit_vdp_mask,r0    /* R0 = VDP mask/flag */
    /* $0232EA: 51E9 */ mov.l   @(36,r14),r1        /* R1 = context->field_0x24 */
    /* $0232EC: 210B */ or      r0,r1               /* R1 |= mask */
    /* $0232EE: E008 */ mov     #8,r0               /* R0 = 8 (second loop count) */
    /* $0232F0: 970B */ mov.w   .lit_stride,r7      /* R7 = stride value */

    /* ─────────────────────────────────────────────────────────────────────────
     * Loop 2: Write to VDP at 64-byte intervals
     * ───────────────────────────────────────────────────────────────────────── */
.vdp_write_loop:
    /* $0232F2: 811E */ mov.w   r1,@(28,r14)        /* context->field_0x1C = R1 */
    /* $0232F4: 7140 */ add     #64,r1              /* R1 += 64 (next VDP slot) */
    /* $0232F6: 811E */ mov.w   r1,@(28,r14)        /* Write again */
    /* $0232F8: 7140 */ add     #64,r1              /* R1 += 64 */
    /* $0232FA: 811E */ mov.w   r1,@(28,r14)        /* Write again */
    /* $0232FC: 7140 */ add     #64,r1              /* R1 += 64 */
    /* $0232FE: 811E */ mov.w   r1,@(28,r14)        /* Write again */
    /* $023300: 4710 */ dt      r7                  /* R7-- */
    /* $023302: 8FF6 */ bf/s    .vdp_write_loop     /* Loop if R7 != 0 */
    /* $023304: 7140 */ add     #64,r1              /* [delay] R1 += 64 */

    /* $023306: 000B */ rts                         /* Return */
    /* $023308: 0009 */ nop                         /* Delay slot */

/* ─────────────────────────────────────────────────────────────────────────────
 * Literal Pool and Data Table
 * ───────────────────────────────────────────────────────────────────────────── */
.align 4
.lit_dest_base:
    /* Destination context pointer */
.lit_src_table:
    /* Source configuration table (14 longs) */
.lit_vdp_mask:
    /* VDP control mask */
.lit_stride:
    /* Loop stride value */

/* ============================================================================
 * func_014: Secondary Data Copy (24 bytes)
 * Address: 0x02223330 - 0x0222333E
 * Purpose: Copies 6 longs of configuration data
 * ============================================================================ */
func_014:
    /* $023330: D204 */ mov.l   .lit_dest2,r2       /* R2 = destination */
    /* $023332: E706 */ mov     #6,r7               /* R7 = 6 (copy count) */
.copy_loop2:
    /* $023334: 6016 */ mov.l   @r1+,r0             /* R0 = *src++ */
    /* $023336: 2202 */ mov.l   r0,@r2              /* *dest = R0 */
    /* $023338: 4710 */ dt      r7                  /* R7-- */
    /* $02333A: 8FFB */ bf/s    .copy_loop2         /* Loop */
    /* $02333C: 7204 */ add     #4,r2               /* [delay] dest += 4 */
    /* $02333E: 000B */ rts                         /* Return */
    /* $023340: 0009 */ nop                         /* Delay slot */

/* ============================================================================
 * func_015: Tertiary Data Copy (24 bytes)
 * Address: 0x02223348 - 0x02223358
 * Purpose: Copies data with word-based count
 * ============================================================================ */
func_015:
    /* $023348: D105 */ mov.l   .lit_dest3,r1       /* R1 = destination */
    /* $02334A: D006 */ mov.l   .lit_src3,r0        /* R0 = source */
    /* $02334C: 9706 */ mov.w   .lit_count3,r7      /* R7 = count (from word) */
.copy_loop3:
    /* $02334E: 6206 */ mov.l   @r0+,r2             /* R2 = *src++ */
    /* $023350: 2122 */ mov.l   r2,@r1              /* *dest = R2 */
    /* $023352: 4710 */ dt      r7                  /* R7-- */
    /* $023354: 8FFB */ bf/s    .copy_loop3         /* Loop */
    /* $023356: 7104 */ add     #4,r1               /* [delay] dest += 4 */
    /* $023358: 000B */ rts                         /* Return */
    /* $02335A: 0009 */ nop                         /* Delay slot */

/* ============================================================================
 * ANALYSIS NOTES
 *
 * 1. Initialization Sequence:
 *    These three functions form the VDP/rendering context initialization:
 *    - func_013: Main context setup (14 longs + VDP writes)
 *    - func_014: Secondary buffer setup (6 longs)
 *    - func_015: Additional data copy
 *
 * 2. VDP Write Pattern in func_013:
 *    Writes same value to field_0x1C four times per iteration,
 *    incrementing by 64 each time. This likely initializes:
 *    - Frame buffer line pointers
 *    - Sprite table entries
 *    - Tile map rows
 *
 * 3. 64-Byte Stride:
 *    The VDP uses 64-byte aligned structures for:
 *    - Sprite attribute tables (64 entries × 8 bytes = 512 bytes)
 *    - Pattern name tables
 *    - Color palettes
 *
 * 4. Unrolled Loop:
 *    func_013's inner loop is unrolled 4× (four MOV.W + ADD #64)
 *    for performance - reduces loop overhead.
 *
 * ============================================================================ */
