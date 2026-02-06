/*
 * master_dispatch_hook: Master SH2 Command Dispatcher
 * ROM File Offset: 0x300050 (expansion ROM)
 * SH2 Address: 0x02300050
 * Size: 44 bytes
 */

.section .text
.align 2

master_dispatch_hook:
        sts.l   pr,@-r15                /* Save PR */
        mov     #0x16,r1                /* Vertex transform code */
        cmp/eq  r1,r0                   /* Check if cmd == 0x16 */
        bt      .do_dispatch            /* Skip COMM7 if 0x16 */
        .short  0xD205                  /* MOV.L @(20,PC),R2 - COMM7 addr */
        mov.w   r0,@r2                  /* COMM7 = cmd */
.do_dispatch:
        shll2   r0                      /* cmd * 4 */
        .short  0xD105                  /* MOV.L @(20,PC),R1 - jump table */
        mov.l   @(r0,r1),r0             /* Load handler address */
        jsr     @r0                     /* Call handler */
        nop
        lds.l   @r15+,pr                /* Restore PR */
        .short  0xD003                  /* MOV.L @(12,PC),R0 - loop addr */
        jmp     @r0                     /* Return to loop */
        nop
        nop                             /* Padding */
        .long   0x2000402E              /* COMM7 address */
        .long   0x06000780              /* Jump table */
        .long   0x02020460              /* Loop address */
