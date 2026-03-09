/* func_080: Memory Clear (Two Regions)
 * SH2 Address: $02224300 | ROM: $024300 | 34 bytes
 *
 * Clears two memory regions by writing zeros.
 * First region: 4 longs per iteration (16 bytes)
 * Second region: 1 long per iteration
 *
 * Uses:  R0 = zero value
 *        R1 = destination pointer (pre-decrement)
 *        R7 = loop counter
 *
 * Literal pool references:
 *   $024324: Region 1 end address
 *   $024328: Region 1 count
 *   $02432C: Region 2 end address
 *   $024330: Region 2 count
 */
        .section .text

func_080:
        .short  0xD108        /* $024300: MOV.L @(32,PC),R1 → region1 end */
        .short  0xD709        /* $024302: MOV.L @(36,PC),R7 → region1 count */
        .short  0xE000        /* $024304: MOV #0,R0 */
.loop1:
        .short  0x2106        /* $024306: MOV.L R0,@-R1 (clear 4 bytes) */
        .short  0x2106        /* $024308: MOV.L R0,@-R1 (clear 4 bytes) */
        .short  0x2106        /* $02430A: MOV.L R0,@-R1 (clear 4 bytes) */
        .short  0x4710        /* $02430C: DT R7 (count--) */
        .short  0x8FFA        /* $02430E: BF/S .loop1 */
        .short  0x2106        /* $024310: [delay] MOV.L R0,@-R1 (clear 4) */
        .short  0xD106        /* $024312: MOV.L @(24,PC),R1 → region2 end */
        .short  0xD706        /* $024314: MOV.L @(24,PC),R7 → region2 count */
        .short  0xE000        /* $024316: MOV #0,R0 */
.loop2:
        .short  0x4710        /* $024318: DT R7 (count--) */
        .short  0x8FFD        /* $02431A: BF/S .loop2 */
        .short  0x2106        /* $02431C: [delay] MOV.L R0,@-R1 (clear 4) */
        .short  0x000B        /* $02431E: RTS */
        .short  0x0009        /* $024320: [delay] NOP */
