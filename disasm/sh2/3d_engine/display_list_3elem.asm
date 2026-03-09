/*
 * func_010: Display List Handler Type B (3-Element Output)
 * ROM File Offset: 0x23202 - 0x2321B (26 bytes)
 * SH2 Address: 0x02223202
 *
 * Purpose: Similar to func_009 but outputs only 3 elements instead of 4.
 *          Handles display list commands requiring 3-element data blocks.
 *
 * Note: First instruction also serves as func_009's delay slot (adjacent)
 *
 * Input:
 *   R0  = Index/counter
 *   R1  = Secondary output pointer
 *   R5  = Byte output offset pointer
 *   R11 = Output buffer pointer
 *   R12 = Source data structure pointer
 *
 * Output:
 *   3 words written to [R11+4], [R11+8], [R11+12]
 *   R11 += 16 (0x10) - advance to next output slot
 *   R0 incremented
 *
 * Data Layout (Source @ R12):
 *   [R12+0x0C] -> [R11+0x04]
 *   [R12+0x1C] -> [R11+0x08]
 *   [R12+0x2C] -> [R11+0x0C]
 *
 * Clobbers: R0, R1, R2
 */

.section .text
.align 2

func_010:
    /* Byte output operations - using .word due to GNU AS encoding issues */
    .word   0x81E3                  /* MOV.W R0,@(6,R14) */
    .word   0x85E1                  /* MOV.W @(2,R14),R0 */
    .word   0x81B1                  /* MOV.W R0,@(2,R11) */

    /* Load 3 longwords from source structure */
    mov.l   @(12,r12),r0            /* R0 = [R12+0x0C] */
    mov.l   @(28,r12),r1            /* R1 = [R12+0x1C] */
    mov.l   @(44,r12),r2            /* R2 = [R12+0x2C] */

    /* Store to output buffer */
    mov.l   r0,@(4,r11)             /* [R11+0x04] = R0 */
    mov.l   r1,@(8,r11)             /* [R11+0x08] = R1 */
    mov.l   r2,@(12,r11)            /* [R11+0x0C] = R2 */

    /* Advance output pointer */
    add     #0x10,r11               /* R11 += 16 */

    /* More byte output operations */
    .word   0x85E3                  /* MOV.W @(6,R14),R0 */
    add     #1,r0                   /* R0++ */
    rts
    /* Delay slot borrowed from following code in ROM */

/*
 * End of func_010
 */
