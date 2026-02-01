/* func_088: Structure Initialization
 * SH2 Address: $02224448 | ROM: $024448 | 34 bytes
 *
 * Initializes a structure with values from literal pool.
 * Writes multiple longwords to structure pointed to by R8.
 *
 * Uses:  R0 = data values
 *        R1 = input parameter / address
 *        R8 = structure base address (set from literal pool)
 *        R9 = secondary address
 *
 * Literal pool at $02446A:
 *   $02446A: $FF80 (word constant)
 *   $02446C: $20004000 - base addr
 *   $024470: $20004012 - value
 *   $024474: $000044E1 - value
 *   $024478: $00000001 - value
 *   $02447C: $20004023 - value
 *   $024480: control register address
 */
        .section .text

func_088:
        .short  0x980F        /* $024448: MOV.W @(30,PC),R0 → $FF80 */
        .short  0xD908        /* $02444A: MOV.L @(32,PC),R9 → $20004000 */
        .short  0xD008        /* $02444C: MOV.L @(32,PC),R0 → $20004012 */
        .short  0x1800        /* $02444E: MOV.L R0,@(0,R8) */
        .short  0x1811        /* $024450: MOV.L R1,@(4,R8) */
        .short  0x8598        /* $024452: MOV.W @(48,R9),R0 */
        .short  0x1802        /* $024454: MOV.L R0,@(8,R8) */
        .short  0xD007        /* $024456: MOV.L @(28,PC),R0 → $000044E1 */
        .short  0x1803        /* $024458: MOV.L R0,@(12,R8) */
        .short  0xD007        /* $02445A: MOV.L @(28,PC),R0 → $00000001 */
        .short  0x180C        /* $02445C: MOV.L R0,@(48,R8) */
        .short  0xD107        /* $02445E: MOV.L @(28,PC),R1 → $20004023 */
        .short  0x6010        /* $024460: MOV.B @R1,R0 */
        .short  0xCB02        /* $024462: OR #2,R0 (set bit 1) */
        .short  0x2100        /* $024464: MOV.L R0,@R1 */
        .short  0x000B        /* $024466: RTS */
        .short  0x0009        /* $024468: [delay] NOP */
