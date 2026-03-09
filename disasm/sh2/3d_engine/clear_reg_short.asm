/* func_086: Clear Register
 * SH2 Address: $0222442C | ROM: $02442C | 8 bytes
 *
 * Simple function that writes 0 to a register.
 *
 * Uses:  R0 = zero value
 *        R1 = register address from literal pool
 *
 * Literal pool at $024434:
 *   $024434: $20004024 - register address
 */
        .section .text

func_086:
        .short  0xD101        /* $02442C: MOV.L @(4,PC),R1 → $20004024 */
        .short  0xE000        /* $02442E: MOV #0,R0 */
        .short  0x000B        /* $024430: RTS */
        .short  0x2100        /* $024432: [delay] MOV.L R0,@R1 */
