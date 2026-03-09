/* func_077: Value-Based Dispatch
 * SH2 Address: $02224274 | ROM: $024274 | 46 bytes
 *
 * Reads byte from memory location, dispatches based on value:
 *   - 0:    Return immediately (RTS)
 *   - 0x80: Branch to $0242E0 (handled externally)
 *   - >0:   Nested loop writing to buffer
 *   - <0:   Branch to $0242AC (handled externally)
 *
 * Entry: Uses values from literal pool
 * Uses:  R0 = value from memory / loop counter
 *        R1 = destination pointer
 *        R4 = word value to write
 *        R5 = base address
 *        R6 = outer loop counter (copy of input)
 *        R7 = row counter (28 rows)
 *
 * Note: BT to $0242E0 and BF to $0242AC are forward branches
 *       to code in subsequent functions (shared handlers)
 */
        .section .text

func_077:
        .short  0xD00B        /* $024274: MOV.L @(44,PC),R0 → addr $0600C0D5 */
        .short  0x6000        /* $024276: MOV.B @R0,R0 (read dispatch value) */
        .short  0x8800        /* $024278: CMP/EQ #0,R0 */
        .short  0x8910        /* $02427A: BT .exit (value==0, done) */
        .short  0x8880        /* $02427C: CMP/EQ #$80,R0 */
        .short  0x892F        /* $02427E: BT $0242E0 (value==0x80, alt path) */
        .short  0x4015        /* $024280: CMP/PL R0 (check if positive) */
        .short  0x8B13        /* $024282: BF $0242AC (negative, alt path) */
/* Positive value processing - nested loop to fill buffer */
        .short  0x6603        /* $024284: MOV R0,R6 (save count) */
        .short  0x940C        /* $024286: MOV.W @(24,PC),R4 → $1F00 */
        .short  0xD507        /* $024288: MOV.L @(28,PC),R5 → $24000000 */
        .short  0xE71C        /* $02428A: MOV #28,R7 (28 rows) */
.row_loop:
        .short  0x6063        /* $02428C: MOV R6,R0 (restore count) */
        .short  0x6153        /* $02428E: MOV R5,R1 (dest ptr = base) */
.col_loop:
        .short  0x2141        /* $024290: MOV.W R4,@R1 (write pattern) */
        .short  0x4010        /* $024292: DT R0 (decrement count) */
        .short  0x8FFC        /* $024294: BF/S .col_loop */
        .short  0x7102        /* $024296: [delay] ADD #2,R1 (next word) */
        .short  0x4710        /* $024298: DT R7 (decrement row) */
        .short  0x8FF7        /* $02429A: BF/S .row_loop */
        .short  0x7510        /* $02429C: [delay] ADD #16,R5 (next row) */
.exit:
        .short  0x000B        /* $02429E: RTS */
        .short  0x0009        /* $0242A0: [delay] NOP */
