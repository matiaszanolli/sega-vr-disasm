/* func_089: Poll and Branch with Loop
 * SH2 Address: $02224480 | ROM: $024480 | 40 bytes
 *
 * Complex polling routine with embedded data and loop.
 * First part polls until condition met, then branches forward.
 * Second part (at $024494) is a separate loop that writes to memory.
 *
 * Contains embedded literal pool at $02448E-$024492.
 */
        .section .text

func_089:
        .short  0xDE03        /* $024480: MOV.L @(12,PC),R14 → const addr */
        .short  0x50E3        /* $024482: MOV.L @(12,R14),R0 */
        .short  0xC802        /* $024484: TST #2,R0 (test bit 1) */
        .short  0x89FC        /* $024486: BT $024480 (loop while set) */
        .short  0xE000        /* $024488: MOV #0,R0 */
        .short  0xA09F        /* $02448A: BRA forward (+159) */
        .short  0x1E0C        /* $02448C: [delay] MOV.L R0,@(48,R14) */
/* Embedded literal pool */
        .short  0x0000        /* $02448E: padding */
        .short  0xFFFF        /* $024490: high word of $FFFFFF80 */
        .short  0xFF80        /* $024492: low word of $FFFFFF80 */
/* Secondary entry point - memory write loop */
        .short  0xD806        /* $024494: MOV.L @(24,PC),R8 → buffer addr */
        .short  0x9007        /* $024496: MOV.W @(14,PC),R0 → value */
        .short  0x9107        /* $024498: MOV.W @(14,PC),R1 → compare */
        .short  0x9707        /* $02449A: MOV.W @(14,PC),R7 → count */
        .short  0x2805        /* $02449C: MOV.L R0,@R8 */
        .short  0x3018        /* $02449E: CMP/GT R1,R0? */
        .short  0x4710        /* $0244A0: DT R7 (decrement and test) */
        .short  0x8BFB        /* $0244A2: BF $024494 (loop) */
        .short  0x000B        /* $0244A4: RTS */
        .short  0x0009        /* $0244A6: [delay] NOP */
