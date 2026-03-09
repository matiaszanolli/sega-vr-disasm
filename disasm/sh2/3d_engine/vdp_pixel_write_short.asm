/* func_076: VDP Pixel Write Loop
 * SH2 Address: $02224228 | ROM: $024228 | 76 bytes
 *
 * Initializes VDP registers and processes pixel data in a loop.
 * Reads word pairs from R3, unpacks into X/Y coordinates, writes to VDP.
 *
 * Entry: R1 = VDP control port base
 *        R3 = source data pointer
 *        R4 = loop counter
 *        R5 = destination buffer base
 * Uses:  R0, R1, R6, R7 = working registers
 *        R14 = loaded from literal pool
 *        GBR = set from literal pool
 *
 * Note: $C105 is MOV.W R0,@(disp,GBR) - GBR-relative word store
 */
        .section .text

func_076:
        .short  0xDE0E        /* $024228: MOV.L @(56,PC),R14 → $20004030 */
        .short  0x9019        /* $02422A: MOV.W @(50,PC),R0 → $0105 (261) */
        .short  0x81E0        /* $02422C: MOV.W R0,@(0,R14) (write VDP ctrl) */
        .short  0x9018        /* $02422E: MOV.W @(48,PC),R0 → $0417 (1047) */
        .short  0x81E1        /* $024230: MOV.W R0,@(2,R14) (write VDP ctrl) */
        .short  0xD00D        /* $024232: MOV.L @(52,PC),R0 → $0600F800 */
        .short  0x401E        /* $024234: LDC R0,GBR (set GBR for fast access) */
        .short  0xE000        /* $024236: MOV #0,R0 */
        .short  0xC105        /* $024238: MOV.W R0,@(10,GBR) (clear status) */
.loop:
        .short  0x4410        /* $02423A: DT R4 (decrement and test) */
        .short  0x8918        /* $02423C: BT .done (if counter=0, exit) */
        .short  0x6035        /* $02423E: MOV.W @R3+,R0 (read packed XY) */
        .short  0x6108        /* $024240: SWAP.B R0,R1 (swap bytes) */
        .short  0x611C        /* $024242: EXTU.B R1,R1 (zero-extend Y) */
        .short  0x4108        /* $024244: SHLL2 R1 (Y *= 4) */
        .short  0x6613        /* $024246: MOV R1,R6 (save Y*4) */
        .short  0x600C        /* $024248: EXTU.B R0,R0 (zero-extend X) */
        .short  0x4008        /* $02424A: SHLL2 R0 (X *= 4) */
        .short  0x6703        /* $02424C: MOV R0,R7 (save X*4) */
.poll:
        .short  0xD107        /* $02424E: MOV.L @(28,PC),R1 → $00008000 */
        .short  0x85E2        /* $024250: MOV.W @(4,R14),R0 (read VDP status) */
        .short  0x2018        /* $024252: TST R1,R0 (test ready bit) */
        .short  0x8BFB        /* $024254: BF .poll (wait until ready) */
        .short  0x6063        /* $024256: MOV R6,R0 (restore Y*4) */
        .short  0x81E2        /* $024258: MOV.W R0,@(4,R14) (write Y coord) */
        .short  0x6073        /* $02425A: MOV R7,R0 (restore X*4) */
        .short  0xAFED        /* $02425C: BRA .loop */
        .short  0x81E3        /* $02425E: [delay] MOV.W R0,@(6,R14) (write X) */
/* Literal pool */
        .short  0x0105        /* $024260: VDP control value 1 */
        .short  0x0417        /* $024262: VDP control value 2 */
        .short  0x2000        /* $024264: R14 base high word */
        .short  0x4030        /* $024266: R14 base low word ($20004030) */
        .short  0x0600        /* $024268: GBR high word */
        .short  0xF800        /* $02426A: GBR low word ($0600F800) */
        .short  0x0000        /* $02426C: ready mask high word */
        .short  0x8000        /* $02426E: ready mask low word ($00008000) */
.done:
        .short  0x000B        /* $024270: RTS */
        .short  0x0009        /* $024272: [delay] NOP */
