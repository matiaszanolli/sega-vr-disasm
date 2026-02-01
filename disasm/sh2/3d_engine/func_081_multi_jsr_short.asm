/* func_081: Multi-JSR Coordinator
 * SH2 Address: $02224334 | ROM: $024334 | 52 bytes
 *
 * Coordinator function that calls multiple subroutines in sequence.
 * Saves/restores PR and calls 6 different functions via JSR.
 *
 * Uses:  R0 = function addresses from literal pool
 *        R1, R6, R7, R10, R11 = parameters for called functions
 *        PR = saved/restored
 *
 * Calls (via literal pool):
 *   $024368: JSR to $06003348
 *   $02436C: JSR to $0600441C
 *   $024370: Parameter $000004C0
 *   $024374: Parameter $0600EDFC
 *   $024378: Parameter $06032FF0
 *   $02437C: JSR to $C0000022
 *   $024380: JSR to $060034EE
 *   $024384: JSR to $06004438
 *   $024388: JSR to $060043E0
 */
        .section .text

func_081:
        .short  0x4F22        /* $024334: STS.L PR,@-R15 (save PR) */
        .short  0xD00C        /* $024336: MOV.L @(48,PC),R0 → $06003348 */
        .short  0x400B        /* $024338: JSR @R0 */
        .short  0x0009        /* $02433A: [delay] NOP */
        .short  0xD00B        /* $02433C: MOV.L @(44,PC),R0 → $0600441C */
        .short  0x400B        /* $02433E: JSR @R0 */
        .short  0xE101        /* $024340: [delay] MOV #1,R1 */
        .short  0xE610        /* $024342: MOV #16,R6 */
        .short  0xD70A        /* $024344: MOV.L @(40,PC),R7 → $000004C0 */
        .short  0xDA0B        /* $024346: MOV.L @(44,PC),R10 → $0600EDFC */
        .short  0xDB0B        /* $024348: MOV.L @(44,PC),R11 → $06032FF0 */
        .short  0xD00C        /* $02434A: MOV.L @(48,PC),R0 → $C0000022 */
        .short  0x400B        /* $02434C: JSR @R0 */
        .short  0x0009        /* $02434E: [delay] NOP */
        .short  0xD00B        /* $024350: MOV.L @(44,PC),R0 → $060034EE */
        .short  0x400B        /* $024352: JSR @R0 */
        .short  0x0009        /* $024354: [delay] NOP */
        .short  0xD00B        /* $024356: MOV.L @(44,PC),R0 → $06004438 */
        .short  0x400B        /* $024358: JSR @R0 */
        .short  0x0009        /* $02435A: [delay] NOP */
        .short  0xD00A        /* $02435C: MOV.L @(40,PC),R0 → $060043E0 */
        .short  0x400B        /* $02435E: JSR @R0 */
        .short  0x0009        /* $024360: [delay] NOP */
        .short  0x4F26        /* $024362: LDS.L @R15+,PR (restore PR) */
        .short  0x000B        /* $024364: RTS */
        .short  0x0009        /* $024366: [delay] NOP */
