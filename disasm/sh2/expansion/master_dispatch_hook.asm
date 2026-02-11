/*
 * master_dispatch_hook: Master SH2 Command Dispatcher (JMP version)
 * ROM File Offset: 0x300050 (expansion ROM)
 * SH2 Address: 0x02300050
 * Size: 28 bytes
 *
 * Entry: R0 = command byte (from COMM0 low byte)
 *        PR = return address (dispatch loop BRA at $020470)
 *
 * For all commands except 0x16 (vertex transform), writes COMM7 = cmd
 * to signal the Slave SH2. Then dispatches to the command handler via
 * the jump table. Uses JMP (not JSR) so handler RTS returns directly
 * to the dispatch loop via PR.
 */

.section .text
.align 2

master_dispatch_hook:
        mov     #0x16,r1                /* Vertex transform code */
        cmp/eq  r1,r0                   /* Check if cmd == 0x16 */
        bt      .do_dispatch            /* Skip COMM7 if 0x16 */
        .short  0xD203                  /* MOV.L @(12,PC),R2 - COMM7 addr */
        mov.w   r0,@r2                  /* COMM7 = cmd */
.do_dispatch:
        shll2   r0                      /* cmd * 4 */
        .short  0xD102                  /* MOV.L @(8,PC),R1 - jump table */
        mov.l   @(r0,r1),r0            /* Load handler address */
        jmp     @r0                     /* JMP to handler */
        nop
        .long   0x2000402E              /* COMM7 address */
        .long   0x06000780              /* Jump table base */
