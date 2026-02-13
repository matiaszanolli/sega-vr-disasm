/* DOCUMENTATION ONLY — not used by build system.
 * Build source: func_024_screen_coords_short.asm
 */
/*
 * func_024: Screen Coordinate Calculator
 * ROM File Offset: 0x235F6 - 0x23632 (60 bytes)
 * SH2 Address: 0x022235F6 - 0x02223632
 *
 * Purpose: Calculates screen-space coordinates for quad vertices.
 *          Takes transformed 3D coordinates and computes final 2D
 *          screen positions for rasterization.
 *
 * Type: Leaf function (no calls)
 * Called By: func_023 (frustum cull dispatcher)
 *
 * Input:
 *   R8  = Packed vertex data (byte components extracted)
 *   R9  = Output buffer pointer (screen coordinates)
 *   R14 = RenderingContext pointer
 *
 * Context Fields Used:
 *   @(0,R14)   = Control/status word
 *   @(12,R14)  = Base X coordinate (R1)
 *   @(16,R14)  = Base Y coordinate (R2)
 *
 * Output:
 *   @(0,R9)  = Screen X1
 *   @(2,R9)  = Screen Y1
 *   @(4,R9)  = Screen X2
 *   @(6,R9)  = Screen Y2
 *   @(8,R9)  = Screen X3
 *   @(10,R9) = Screen Y3
 *   @(12,R9) = Conditional output based on flag
 */

.section .text
.align 2

func_024:
    /* ─────────────────────────────────────────────────────────────────────────
     * Load base coordinates from context
     * ───────────────────────────────────────────────────────────────────────── */
    /* $0235F6: 51E3 */ mov.l   @(12,r14),r1        /* R1 = context->base_x */
    /* $0235F8: 52E4 */ mov.l   @(16,r14),r2        /* R2 = context->base_y */

    /* Extract and store control byte */
    /* $0235FA: 6085 */ extu.b  r8,r0               /* R0 = R8 & 0xFF */
    /* $0235FC: 81E0 */ mov.w   r0,@(0,r14)         /* context->status = R0 */

    /* ─────────────────────────────────────────────────────────────────────────
     * Vertex 1: Calculate X1, Y1
     * ───────────────────────────────────────────────────────────────────────── */
    /* $0235FE: 6085 */ extu.b  r8,r0               /* R0 = R8 & 0xFF (X offset) */
    /* $023600: 6485 */ extu.b  r8,r4               /* R4 = R8 & 0xFF (Y offset) */
    /* $023602: 301C */ add     r1,r0               /* R0 = base_x + offset */
    /* $023604: 8190 */ mov.w   r0,@(0,r9)          /* screen[0] = X1 */
    /* $023606: 3428 */ sub     r2,r4               /* R4 = offset - base_y */
    /* $023608: 604B */ neg     r4,r0               /* R0 = base_y - offset */
    /* $02360A: 8191 */ mov.w   r0,@(2,r9)          /* screen[2] = Y1 */

    /* ─────────────────────────────────────────────────────────────────────────
     * Vertex 2: Calculate X2, Y2
     * ───────────────────────────────────────────────────────────────────────── */
    /* $02360C: 6085 */ extu.b  r8,r0               /* R0 = R8 & 0xFF */
    /* $02360E: 6485 */ extu.b  r8,r4               /* R4 = R8 & 0xFF */
    /* $023610: 301C */ add     r1,r0               /* R0 = base_x + offset */
    /* $023612: 8192 */ mov.w   r0,@(4,r9)          /* screen[4] = X2 */
    /* $023614: 3428 */ sub     r2,r4               /* R4 = offset - base_y */
    /* $023616: 604B */ neg     r4,r0               /* R0 = base_y - offset */
    /* $023618: 8193 */ mov.w   r0,@(6,r9)          /* screen[6] = Y2 */

    /* ─────────────────────────────────────────────────────────────────────────
     * Vertex 3: Calculate X3, Y3
     * ───────────────────────────────────────────────────────────────────────── */
    /* $02361A: 6085 */ extu.b  r8,r0               /* R0 = R8 & 0xFF */
    /* $02361C: 6485 */ extu.b  r8,r4               /* R4 = R8 & 0xFF */
    /* $02361E: 301C */ add     r1,r0               /* R0 = base_x + offset */
    /* $023620: 8194 */ mov.w   r0,@(8,r9)          /* screen[8] = X3 */
    /* $023622: 3428 */ sub     r2,r4               /* R4 = offset - base_y */
    /* $023624: 604B */ neg     r4,r0               /* R0 = base_y - offset */
    /* $023626: 8195 */ mov.w   r0,@(10,r9)         /* screen[10] = Y3 */

    /* ─────────────────────────────────────────────────────────────────────────
     * Conditional output based on status flag
     * ───────────────────────────────────────────────────────────────────────── */
    /* $023628: 85E0 */ mov.w   @(0,r14),r0         /* R0 = context->status */
    /* $02362A: C801 */ tst     #1,r0               /* Test bit 0 */
    /* $02362C: 8902 */ bt      .skip_extra         /* Skip if bit clear */
    /* $02362E: 5092 */ mov.l   @(8,r9),r0          /* R0 = screen[8] (X3) */
    /* $023630: 000B */ rts                         /* Return */
    /* $023632: 1903 */ mov.l   r0,@(12,r9)         /* [delay] screen[12] = X3 copy */

.skip_extra:
    /* Return without extra store - delay slot executes but result unused */

/* ============================================================================
 * ANALYSIS NOTES
 *
 * 1. Screen Coordinate Format:
 *    Output is 6 words (12 bytes) at R9:
 *    - Words 0,1: Vertex 1 (X1, Y1)
 *    - Words 2,3: Vertex 2 (X2, Y2)
 *    - Words 4,5: Vertex 3 (X3, Y3)
 *    These represent 3 corners of the quad in screen space.
 *
 * 2. Coordinate Calculation:
 *    X = base_x + offset (from R8)
 *    Y = base_y - offset (from R8)
 *    The Y inversion (NEG) converts from world to screen coordinates
 *    where Y increases downward.
 *
 * 3. Packed Vertex Data (R8):
 *    R8 appears to contain packed byte offsets that are repeatedly
 *    extracted. The EXTU.B extracts the same byte each time, suggesting
 *    R8 is shifted or modified between vertex calculations elsewhere,
 *    or there's a register renaming I'm not seeing.
 *
 * 4. Note on Assembly:
 *    The repeated EXTU.B R8,R0 pattern seems redundant unless R8 is
 *    being modified between instructions by hardware or the pattern
 *    is part of a loop unrolling optimization.
 *
 * 5. Flag-based Extra Output:
 *    If bit 0 of status is set, copies X3 to screen[12].
 *    This may be for quad completion (4th vertex = 1st vertex for
 *    closed shape) or for special rendering modes.
 *
 * ============================================================================ */
