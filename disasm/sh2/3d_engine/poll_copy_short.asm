/* func_091: Poll and Copy
 * SH2 Address: $022244D4 | ROM: $0244D4 | 18 bytes
 *
 * Polling loop that waits for condition, then copies value.
 *
 * Uses:  R0 = data
 *        R2 = address from literal pool
 *        R14 = base address from literal pool
 *
 * Literal pool at $0244E8:
 *   $0244E8: $20004100 - control register
 *   $0244EC: $00008000 - flag value
 */
        .section .text

func_091:
        .short  0xDE04        /* $0244D4: MOV.L @(16,PC),R14 → base addr */
        .short  0xD205        /* $0244D6: MOV.L @(20,PC),R2 → control reg */
        .short  0x85E5        /* $0244D8: MOV.W @(42,R14),R0 */
        .short  0x2028        /* $0244DA: TST R2,R0 */
        .short  0x89FC        /* $0244DC: BT $0244D4 (loop while clear) */
        .short  0x6013        /* $0244DE: MOV R1,R0 */
        .short  0x81E5        /* $0244E0: MOV.W R0,@(42,R14) */
        .short  0x000B        /* $0244E2: RTS */
        .short  0x0009        /* $0244E4: [delay] NOP */
