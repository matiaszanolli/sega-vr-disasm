/* func_085: Poll Until Zero
 * SH2 Address: $0222441C | ROM: $02441C | 12 bytes
 *
 * Polling loop that waits until register reads 0, then stores R1.
 *
 * Uses:  R0 = read value
 *        R1 = value to store (input parameter)
 *        R2 = register address from literal pool
 *
 * Literal pool at $024428:
 *   $024428: $20004024 - register address
 */
        .section .text

func_085:
        .short  0xD202        /* $02441C: MOV.L @(8,PC),R2 → $20004024 */
        .short  0x6020        /* $02441E: MOV.B @R2,R0 */
        .short  0x8800        /* $024420: CMP/EQ #0,R0 */
        .short  0x8BFC        /* $024422: BF .loop (loop while not zero) */
        .short  0x000B        /* $024424: RTS */
        .short  0x2210        /* $024426: [delay] MOV.L R1,@R2 */
