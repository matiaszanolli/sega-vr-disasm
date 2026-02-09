/*
 * slave_test_func: Slave Parameter Loader
 * ROM File Offset: 0x300280 (expansion ROM)
 * SH2 Address: 0x02300280
 * Size: ~32 bytes (reduced - counter now in slave_work_wrapper_v2)
 *
 * FIXED: Removed COMM5 increment - counter now handled by slave_work_wrapper_v2
 */

.section .text
.align 2

slave_test_func:
        sts.l   pr,@-r15                /* Save PR */
        .short  0xD004                  /* MOV.L @(16,PC),R0 - param block */
        mov.l   @r0,r14                 /* R14 = param[0] (context ptr) */
        mov.l   @(4,r0),r7              /* R7 = param[1] (loop count) */
        mov.l   @(8,r0),r8              /* R8 = param[2] (data ptr) */
        mov.l   @(12,r0),r5             /* R5 = param[3] (output ptr) */
        .short  0xD003                  /* MOV.L @(12,PC),R0 - func addr */
        jsr     @r0                     /* Call func_021_optimized */
        nop
        lds.l   @r15+,pr                /* Restore PR */
        rts
        nop

        /* Literal pool (4-byte aligned) */
        .align 4
        .long   0x2203E000              /* Parameter block */
        .long   0x02300100              /* func_021_optimized */
