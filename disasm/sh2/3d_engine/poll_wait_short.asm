/* func_083: Poll Wait Loop
 * SH2 Address: $022243E0 | ROM: $0243E0 | 12 bytes
 *
 * Small polling loop that waits for a condition.
 * Reads from a memory location and loops until condition met.
 *
 * Uses:  R1 = address from literal pool
 *        R0 = read value (tested for condition)
 *
 * Literal pool at $0243EC: $20004100
 */
        .section .text

func_083:
        .short  0xD102        /* $0243E0: MOV.L @(8,PC),R1 → $20004100 */
        .short  0x8515        /* $0243E2: MOV.W @(42,R5),R0? */
        .short  0xC802        /* $0243E4: TST #2,R0 (test bit 1) */
        .short  0x8BFC        /* $0243E6: BF .loop (loop while not set) */
        .short  0x000B        /* $0243E8: RTS */
        .short  0x0009        /* $0243EA: [delay] NOP */
