/* func_090: Poll Wait with Flag Set
 * SH2 Address: $022244B4 | ROM: $0244B4 | 24 bytes
 *
 * Polling loop that waits for condition, then sets/clears flag.
 *
 * Uses:  R0 = status/data
 *        R1 = address from literal pool
 *        R14 = base address from literal pool
 *
 * Literal pool at $0244CC:
 *   $0244CC: $20004100 - control register
 *   $0244D0: $00008000 - flag value
 */
        .section .text

func_090:
        .short  0xDE05        /* $0244B4: MOV.L @(20,PC),R14 → base addr */
        .short  0xD106        /* $0244B6: MOV.L @(24,PC),R1 → control reg */
        .short  0x85E5        /* $0244B8: MOV.W @(42,R14),R0 */
        .short  0x2018        /* $0244BA: TST R1,R0 */
        .short  0x89FC        /* $0244BC: BT $0244B4 (loop while clear) */
        .short  0xC801        /* $0244BE: TST #1,R0 */
        .short  0xE000        /* $0244C0: MOV #0,R0 */
        .short  0x8B00        /* $0244C2: BF .skip */
        .short  0xE001        /* $0244C4: MOV #1,R0 */
        .short  0x81E5        /* $0244C6: MOV.W R0,@(42,R14) */
        .short  0x000B        /* $0244C8: RTS */
        .short  0x0009        /* $0244CA: [delay] NOP */
