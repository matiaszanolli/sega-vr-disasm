/*
 * func_016: Coordinate Transformation Utility
 * ROM File Offset: 0x23368 - 0x2338A (34 bytes)
 * SH2 Address: 0x02223368
 *
 * Purpose: Combines coordinate fields from context structure into output
 *          fields using bit operations. Packs 16-bit X/Y coordinate pairs
 *          into 32-bit values for hardware-friendly viewport format.
 *
 * HOTSPOT: Called 4× per polygon by func_017, func_018 (2×), func_019
 *          Per frame (800 polygons): 67,200 cycles = 17% of frame budget
 *
 * Input:
 *   R14 = Pointer to RenderingContext structure (56 bytes)
 *
 * Output:
 *   R14->field_0x28 = processed coordinate 1
 *   R14->field_0x2C = processed coordinate 2
 *   R14->field_0x30 = processed coordinate 3
 *   R14->field_0x34 = processed coordinate 4
 *
 * Clobbers: R0, R1, R2, R3, R4
 */

.section .text
.align 2

func_016:
    /* Load coordinate fields from context */
    mov.l   @(28,r14),r1            /* R1 = field_0x1C (coordinate Y1) */
    mov.l   @(32,r14),r2            /* R2 = field_0x20 (coordinate Y2) */

    /* Shift to upper 16 bits */
    shll16  r1                      /* R1 = R1 << 16 */
    shll16  r2                      /* R2 = R2 << 16 */

    /* Load base value and prepare copies */
    mov.l   @(20,r14),r0            /* R0 = field_0x14 (base X value) */
    mov     r1,r3                   /* R3 = copy of shifted Y1 */
    mov     r2,r4                   /* R4 = copy of shifted Y2 */

    /* Combine with first base value: upper(Y) | lower(X) */
    or      r0,r1                   /* R1 = Y1<<16 | X1 */
    or      r0,r2                   /* R2 = Y2<<16 | X1 */

    /* Store first pair of packed coordinates */
    mov.l   r1,@(40,r14)            /* field_0x28 = packed coord 1 */
    mov.l   r2,@(44,r14)            /* field_0x2C = packed coord 2 */

    /* Load alternate base value */
    mov.l   @(24,r14),r0            /* R0 = field_0x18 (alternate X) */

    /* Combine with second base value */
    or      r0,r3                   /* R3 = Y1<<16 | X2 */
    or      r0,r4                   /* R4 = Y2<<16 | X2 */

    /* Store second pair of packed coordinates */
    mov.l   r3,@(48,r14)            /* field_0x30 = packed coord 3 */
    rts
    mov.l   r4,@(52,r14)            /* field_0x34 = packed coord 4 (delay slot) */

/*
 * End of func_016
 */
