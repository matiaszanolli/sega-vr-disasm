/*
 * func_024: Screen Coordinate Calculator
 * ROM File Offset: 0x235F6 - 0x23633 (62 bytes)
 * SH2 Address: 0x022235F6 - 0x02223633
 *
 * Purpose: Calculates screen-space coordinates for quad vertices.
 *          Takes transformed 3D coordinates and computes final 2D
 *          screen positions for rasterization.
 *
 * Type: Leaf function (no calls)
 * Called By: func_023 (frustum cull dispatcher)
 *
 * Note: All instructions as .short to match ROM exactly.
 */

.section .text
.p2align 1    /* 2-byte alignment for 0x235F6 start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_024: Screen Coordinate Calculator
 * Entry: 0x022235F6
 * Size: 62 bytes
 * ═══════════════════════════════════════════════════════════════════════════ */
func_024:
    /* Load base coordinates from context */
    .short  0x51E3                            /* $0235F6: MOV.L @(12,R14),R1 → base_x */
    .short  0x52E4                            /* $0235F8: MOV.L @(16,R14),R2 → base_y */

    /* Extract and store control byte */
    .short  0x6085                            /* $0235FA: EXTU.B R8,R0 (R0 = R8 & 0xFF) */
    .short  0x81E0                            /* $0235FC: MOV.W R0,@(0,R14) → status */

    /* Vertex 1: Calculate X1, Y1 */
    .short  0x6085                            /* $0235FE: EXTU.B R8,R0 (X offset) */
    .short  0x6485                            /* $023600: EXTU.B R8,R4 (Y offset) */
    .short  0x301C                            /* $023602: ADD R1,R0 → X1 = base_x + offset */
    .short  0x8190                            /* $023604: MOV.W R0,@(0,R9) → screen[0] = X1 */
    .short  0x3428                            /* $023606: SUB R2,R4 */
    .short  0x604B                            /* $023608: NEG R4,R0 → Y1 = base_y - offset */
    .short  0x8191                            /* $02360A: MOV.W R0,@(2,R9) → screen[2] = Y1 */

    /* Vertex 2: Calculate X2, Y2 */
    .short  0x6085                            /* $02360C: EXTU.B R8,R0 (X offset) */
    .short  0x6485                            /* $02360E: EXTU.B R8,R4 (Y offset) */
    .short  0x301C                            /* $023610: ADD R1,R0 → X2 */
    .short  0x8192                            /* $023612: MOV.W R0,@(4,R9) → screen[4] = X2 */
    .short  0x3428                            /* $023614: SUB R2,R4 */
    .short  0x604B                            /* $023616: NEG R4,R0 → Y2 */
    .short  0x8193                            /* $023618: MOV.W R0,@(6,R9) → screen[6] = Y2 */

    /* Vertex 3: Calculate X3, Y3 */
    .short  0x6085                            /* $02361A: EXTU.B R8,R0 (X offset) */
    .short  0x6485                            /* $02361C: EXTU.B R8,R4 (Y offset) */
    .short  0x301C                            /* $02361E: ADD R1,R0 → X3 */
    .short  0x8194                            /* $023620: MOV.W R0,@(8,R9) → screen[8] = X3 */
    .short  0x3428                            /* $023622: SUB R2,R4 */
    .short  0x604B                            /* $023624: NEG R4,R0 → Y3 */
    .short  0x8195                            /* $023626: MOV.W R0,@(10,R9) → screen[10] = Y3 */

    /* Conditional output based on status flag */
    .short  0x85E0                            /* $023628: MOV.W @(0,R14),R0 → status */
    .short  0xC801                            /* $02362A: TST #1,R0 */
    .short  0x8902                            /* $02362C: BT skip_extra (+4) */
    .short  0x5092                            /* $02362E: MOV.L @(8,R9),R0 → X3 */
    .short  0x000B                            /* $023630: RTS */
    .short  0x1903                            /* $023632: [delay] MOV.L R0,@(12,R9) → screen[12] = X3 */

/* ============================================================================
 * End of func_024 (62 bytes)
 *
 * Analysis:
 * - Screen coordinate calculation for quad vertices
 * - Converts world coordinates to screen space (Y inversion via NEG)
 * - Conditional 4th vertex output based on status bit 0
 * - Output format: 6 words (12 bytes) + optional 4 bytes
 * ============================================================================ */
