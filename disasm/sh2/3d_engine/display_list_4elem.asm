/*
 * func_009: Display List Handler Type A (4-Element Output)
 * ROM File Offset: 0x231E4 - 0x23201 (30 bytes)
 * SH2 Address: 0x022231E4
 *
 * Purpose: Command handler that extracts 4 values from source structure (R12)
 *          and writes them to output buffer (R11). Used for display list
 *          commands requiring 4-element data blocks.
 *
 * Input:
 *   R0  = Index/counter
 *   R1  = Secondary output pointer
 *   R5  = Byte output offset pointer
 *   R11 = Output buffer pointer
 *   R12 = Source data structure pointer
 *
 * Output:
 *   4 words written to [R11+4], [R11+8], [R11+12], [R11+16]
 *   R11 += 20 (0x14) - advance to next output slot
 *   R0 incremented
 *
 * Data Layout (Source @ R12):
 *   [R12+0x0C] -> [R11+0x04]
 *   [R12+0x1C] -> [R11+0x08]
 *   [R12+0x2C] -> [R11+0x0C]
 *   [R12+0x3C] -> [R11+0x10]
 *
 * Note: Delay slot is first instruction of func_010 (adjacent in ROM)
 *
 * Clobbers: R0, R1, R2, R3
 */

.section .text
.align 2

func_009:
    /* Byte output operations - using .word due to GNU AS encoding issues */
    .word   0x81A7                  /* MOV.W R0,@(14,R10) */
    .word   0x85E1                  /* MOV.W @(2,R14),R0 */
    .word   0x81B1                  /* MOV.W R0,@(2,R11) */

    /* Load 4 longwords from source structure */
    mov.l   @(12,r12),r0            /* R0 = [R12+0x0C] */
    mov.l   @(28,r12),r1            /* R1 = [R12+0x1C] */
    mov.l   @(44,r12),r2            /* R2 = [R12+0x2C] */
    mov.l   @(60,r12),r3            /* R3 = [R12+0x3C] */

    /* Store to output buffer */
    mov.l   r0,@(4,r11)             /* [R11+0x04] = R0 */
    mov.l   r1,@(8,r11)             /* [R11+0x08] = R1 */
    mov.l   r2,@(12,r11)            /* [R11+0x0C] = R2 */
    mov.l   r3,@(16,r11)            /* [R11+0x10] = R3 */

    /* Advance output pointer */
    add     #0x14,r11               /* R11 += 20 */

    /* More byte output operations */
    .word   0x85E3                  /* MOV.W @(6,R14),R0 */
    add     #1,r0                   /* R0++ (increment counter) */
    rts
    /* Delay slot: first instruction of func_010 (0x81E3) */

/*
 * End of func_009
 */
