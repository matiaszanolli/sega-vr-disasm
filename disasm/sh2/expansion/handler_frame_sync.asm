/*
 * handler_frame_sync: Frame Synchronization Handler  
 * ROM File Offset: 0x300028 (expansion ROM)
 * SH2 Address: 0x02300028
 * Size: 22 bytes
 */

.section .text

handler_frame_sync:
        .short  0xD001          /* MOV.L @(4,PC),R0 - COMM4 addr */
        nop
        nop
        nop
        .byte   0x20, 0x00, 0x40, 0x28      /* COMM4: 0x20004028 (big-endian) */
        mov.w   @r0,r1          /* Read COMM4 */
        add     #1,r1           /* Increment */
        mov.w   r1,@r0          /* Write back */
        rts
        nop
