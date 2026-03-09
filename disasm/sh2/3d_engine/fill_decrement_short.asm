/* func_079: Fill with Decrementing Pattern
 * SH2 Address: $022242E0 | ROM: $0242E0 | 20 bytes
 *
 * Called when func_077 dispatches value 0x80 (BT at $02427E).
 * Fills buffer with decrementing word pattern.
 *
 * Entry: (from func_077, value was 0x80)
 * Uses:  R0 = pattern value (decremented each iteration)
 *        R1 = decrement amount
 *        R7 = loop counter
 *        R8 = destination pointer (pre-decrement)
 *
 * Writes R7 words, each R1 less than previous, using @-R8.
 */
        .section .text

func_079:
        .short  0xD806        /* $0242E0: MOV.L @(24,PC),R8 → $240001C0 */
        .short  0x9007        /* $0242E2: MOV.W @(14,PC),R0 → $FF00 */
        .short  0x9107        /* $0242E4: MOV.W @(14,PC),R1 → $0100 */
        .short  0x9707        /* $0242E6: MOV.W @(14,PC),R7 → $00E0 */
.loop:
        .short  0x2805        /* $0242E8: MOV.W R0,@-R8 (write, pre-decr) */
        .short  0x4710        /* $0242EA: DT R7 (count--) */
        .short  0x8FFC        /* $0242EC: BF/S .loop */
        .short  0x3018        /* $0242EE: [delay] SUB R1,R0 (pattern -= decr) */
        .short  0x000B        /* $0242F0: RTS */
        .short  0x0009        /* $0242F2: [delay] NOP */
