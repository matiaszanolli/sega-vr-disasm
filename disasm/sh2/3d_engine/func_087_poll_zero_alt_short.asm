/* func_087: Poll Until Zero (Alternate)
 * SH2 Address: $02224438 | ROM: $024438 | 12 bytes
 *
 * Polling loop that waits until register reads 0.
 * Unlike func_085, this just waits without writing.
 *
 * Uses:  R0 = read value
 *        R1 = register address from literal pool
 *
 * Literal pool at $024444:
 *   $024444: $20004024 - register address
 */
        .section .text

func_087:
        .short  0xD102        /* $024438: MOV.L @(8,PC),R1 → $20004024 */
        .short  0x6010        /* $02443A: MOV.B @R1,R0 */
        .short  0x8800        /* $02443C: CMP/EQ #0,R0 */
        .short  0x8BFC        /* $02443E: BF .loop (loop while not zero) */
        .short  0x000B        /* $024440: RTS */
        .short  0x0009        /* $024442: [delay] NOP */
