/* func_084: Hardware Register Init
 * SH2 Address: $022243F0 | ROM: $0243F0 | 28 bytes
 *
 * Initializes hardware registers based on condition.
 * Reads from control register, tests bit 7, then writes to other registers.
 *
 * Uses:  R0 = data register
 *        R1 = address from literal pool
 *
 * Literal pool at $02440C-$02441A:
 *   $02440C: $20004000 - control register
 *   $024410: $20004100 - status register
 *   $024414: $20004020 - output register 1
 *   $024418: $20004023 - output register 2
 */
        .section .text

func_084:
        .short  0xD106        /* $0243F0: MOV.L @(24,PC),R1 → $20004000 */
        .short  0x8410        /* $0243F2: MOV.B @(16,R1),R0 */
        .short  0xC880        /* $0243F4: TST #$80,R0 (test bit 7) */
        .short  0x8901        /* $0243F6: BT .skip (branch if bit 7 clear) */
        .short  0xD105        /* $0243F8: MOV.L @(20,PC),R1 → $20004100 */
        .short  0x8510        /* $0243FA: MOV.W @(32,R1),R0 */
        .short  0xD105        /* $0243FC: MOV.L @(20,PC),R1 → $20004020 */
        .short  0xE000        /* $0243FE: MOV #0,R0 */
        .short  0x2100        /* $024400: MOV.L R0,@R1 (write 0) */
        .short  0xD105        /* $024402: MOV.L @(20,PC),R1 → $20004023 */
        .short  0x6010        /* $024404: MOV.B @R1,R0 */
        .short  0xCB01        /* $024406: OR #1,R0 (set bit 0) */
        .short  0x000B        /* $024408: RTS */
        .short  0x2100        /* $02440A: [delay] MOV.L R0,@R1 */
