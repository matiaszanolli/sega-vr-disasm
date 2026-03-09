/* func_078: Negative Value Fill Handler
 * SH2 Address: $022242AC | ROM: $0242AC | 40 bytes
 *
 * Called when func_077 dispatches a negative value (BF at $024282).
 * Negates input value, then fills buffer with incrementing pattern.
 *
 * Entry: R0 = negative count (from func_077)
 * Uses:  R0 = loop counter (inner)
 *        R1 = destination pointer
 *        R2 = increment value
 *        R3 = row stride
 *        R4, R8 = pattern value (modified by R2)
 *        R5 = base address
 *        R6 = negated count (outer loop)
 *        R7 = row counter (28)
 *
 * Nested loop fills 28 rows, each with -R0 words,
 * incrementing pattern by R2 per word, R3 per row.
 */
        .section .text

func_078:
        .short  0x660B        /* $0242AC: NEG R0,R6 (negate count) */
        .short  0xD50B        /* $0242AE: MOV.L @(44,PC),R5 → $24000000 */
        .short  0x9410        /* $0242B0: MOV.W @(32,PC),R4 → $2000 */
        .short  0x9210        /* $0242B2: MOV.W @(32,PC),R2 → $0100 */
        .short  0x9310        /* $0242B4: MOV.W @(32,PC),R3 → $0800 */
        .short  0xE71C        /* $0242B6: MOV #28,R7 (28 rows) */
.row_loop:
        .short  0x6153        /* $0242B8: MOV R5,R1 (dest = base) */
        .short  0x6843        /* $0242BA: MOV R4,R8 (pattern = start) */
        .short  0x6063        /* $0242BC: MOV R6,R0 (count = negated) */
.col_loop:
        .short  0x2181        /* $0242BE: MOV.W R8,@R1 (write pattern) */
        .short  0x382C        /* $0242C0: ADD R2,R8 (pattern += incr) */
        .short  0x4010        /* $0242C2: DT R0 (count--) */
        .short  0x8FFB        /* $0242C4: BF/S .col_loop */
        .short  0x7102        /* $0242C6: [delay] ADD #2,R1 (next word) */
        .short  0x343C        /* $0242C8: ADD R3,R4 (row pattern += stride) */
        .short  0x4710        /* $0242CA: DT R7 (row--) */
        .short  0x8FF4        /* $0242CC: BF/S .row_loop */
        .short  0x7510        /* $0242CE: [delay] ADD #16,R5 (next row) */
        .short  0x000B        /* $0242D0: RTS */
        .short  0x0009        /* $0242D2: [delay] NOP */
