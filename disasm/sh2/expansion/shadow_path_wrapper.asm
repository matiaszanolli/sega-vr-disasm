/*
 * shadow_path_wrapper: Shadow Path Instrumentation Wrapper
 * ROM File Offset: 0x300400 (expansion ROM)
 * SH2 Address: 0x02300400
 * Size: 52 bytes
 */

.section .text
.align 2

shadow_path_wrapper:
        .short  0xD00A                  /* MOV.L @(40,PC),R0 - COMM6 addr */
        mov.w   @r0,r1                  /* Read COMM6 */
        add     #1,r1                   /* Increment */
        mov.w   r1,@r0                  /* Write back */
        .short  0xD009                  /* MOV.L @(36,PC),R0 - param block */
        mov.l   r14,@r0                 /* param[0] = R14 */
        mov.l   r7,@(4,r0)              /* param[1] = R7 */
        mov.l   r8,@(8,r0)              /* param[2] = R8 */
        mov.l   r5,@(12,r0)             /* param[3] = R5 */
        .short  0xD008                  /* MOV.L @(32,PC),R0 - COMM7 addr */
        mov     #0x16,r1                /* Signal value */
        mov.w   r1,@r0                  /* COMM7 = 0x16 */
        .short  0xD008                  /* MOV.L @(32,PC),R0 - func addr */
        jsr     @r0                     /* Call original */
        nop
        rts
        nop
        nop                             /* Padding */
        .long   0x2000402C              /* COMM6 address */
        .long   0x2203E000              /* Parameter block */
        .long   0x2000402E              /* COMM7 address */
        .long   0x02300300              /* func_021_original_relocated */
