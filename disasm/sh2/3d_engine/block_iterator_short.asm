/* func_075: Byte Block Iterator
 * SH2 Address: $0222420C | ROM: $02420C | 26 bytes
 *
 * Iterates through byte array, calling func_074 for each non-zero element.
 * Loads stride value from literal pool, adds to R9 after each call.
 *
 * Entry: R8 = source byte array pointer
 *        R9 = destination pointer (modified by stride)
 * Uses:  R0 = current byte value
 *        R13 = stride value (loaded from literal pool)
 * Calls: func_074 (block copy 14) at $0241E8
 *
 * Loop behavior:
 *   - Read byte from R8++
 *   - If zero, exit
 *   - Call func_074 (BSR)
 *   - Add stride (8) to R9
 *   - Loop back
 */
        .section .text

func_075:
        .short  0x4F22        /* $02420C: STS.L PR,@-R15 (save return address) */
        .short  0x9D06        /* $02420E: MOV.W @(12,PC),R13 → stride = $0200 (512) */
.loop:
        .short  0x6084        /* $024210: MOV.B @R8+,R0 (read next byte) */
        .short  0x8800        /* $024212: CMP/EQ #0,R0 (check if zero) */
        .short  0x8904        /* $024214: BT .done (if zero, exit loop) */
        .short  0xBFE7        /* $024216: BSR $0241E8 (call func_074) */
        .short  0x0009        /* $024218: [delay] NOP */
        .short  0xAFF9        /* $02421A: BRA .loop */
        .short  0x7908        /* $02421C: [delay] ADD #8,R9 (stride) */
/* Literal pool (word constant accessed by MOV.W @(PC),R13) */
        .short  0x0200        /* $02421E: stride value = 512 */
.done:
        .short  0x4F26        /* $024220: LDS.L @R15+,PR (restore return address) */
        .short  0x000B        /* $024222: RTS */
        .short  0x0009        /* $024224: [delay] NOP */
