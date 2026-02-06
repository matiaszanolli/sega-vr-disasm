/*
 * slave_test_func: Slave Parameter Loader
 * ROM File Offset: 0x300280 (expansion ROM)
 * SH2 Address: 0x02300280
 * Size: 44 bytes
 */

.section .text
.align 2

slave_test_func:
        sts.l   pr,@-r15                /* Save PR */
        .short  0xD007                  /* MOV.L @(28,PC),R0 - param block */
        mov.l   @r0,r14                 /* R14 = param[0] */
        mov.l   @(4,r0),r7              /* R7 = param[1] */
        mov.l   @(8,r0),r8              /* R8 = param[2] */
        mov.l   @(12,r0),r5             /* R5 = param[3] */
        .short  0xD005                  /* MOV.L @(20,PC),R0 - func addr */
        jsr     @r0                     /* Call func_021_optimized */
        nop
        .short  0xD005                  /* MOV.L @(20,PC),R0 - COMM5 addr */
        mov.w   @r0,r1                  /* Read COMM5 */
        add     #100,r1                 /* Add 100 */
        mov.w   r1,@r0                  /* Write back */
        lds.l   @r15+,pr                /* Restore PR */
        rts
        nop
        .long   0x2203E000              /* Parameter block */
        .long   0x02300100              /* func_021_optimized */
        .long   0x2000402A              /* COMM5 address */
