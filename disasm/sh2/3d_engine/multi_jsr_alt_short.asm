/* func_082: Multi-JSR Coordinator (Alternate)
 * SH2 Address: $0222438C | ROM: $02438C | 50 bytes
 *
 * Similar to func_081 but with different parameter setup.
 * Calls multiple subroutines via JSR after loading parameters.
 *
 * Uses:  R0 = function addresses from literal pool
 *        R1, R7, R8 = parameters for called functions
 *        PR = saved/restored
 *
 * Reads R7 from memory location pointed to by literal pool.
 */
        .section .text

func_082:
        .short  0x4F22        /* $02438C: STS.L PR,@-R15 (save PR) */
        .short  0xD00C        /* $02438E: MOV.L @(48,PC),R0 → func addr */
        .short  0x400B        /* $024390: JSR @R0 */
        .short  0x0009        /* $024392: [delay] NOP */
        .short  0xD00B        /* $024394: MOV.L @(44,PC),R0 → func addr */
        .short  0x400B        /* $024396: JSR @R0 */
        .short  0xE101        /* $024398: [delay] MOV #1,R1 */
        .short  0xD10B        /* $02439A: MOV.L @(44,PC),R1 → param addr */
        .short  0x6711        /* $02439C: MOV.W @R1,R7 (load param) */
        .short  0xD80B        /* $02439E: MOV.L @(44,PC),R8 → param */
        .short  0xD00B        /* $0243A0: MOV.L @(44,PC),R0 → func addr */
        .short  0x400B        /* $0243A2: JSR @R0 */
        .short  0x0009        /* $0243A4: [delay] NOP */
        .short  0xD00B        /* $0243A6: MOV.L @(44,PC),R0 → func addr */
        .short  0x400B        /* $0243A8: JSR @R0 */
        .short  0x0009        /* $0243AA: [delay] NOP */
        .short  0xD00A        /* $0243AC: MOV.L @(40,PC),R0 → func addr */
        .short  0x400B        /* $0243AE: JSR @R0 */
        .short  0x0009        /* $0243B0: [delay] NOP */
        .short  0xD00A        /* $0243B2: MOV.L @(40,PC),R0 → func addr */
        .short  0x400B        /* $0243B4: JSR @R0 */
        .short  0x0009        /* $0243B6: [delay] NOP */
        .short  0x4F26        /* $0243B8: LDS.L @R15+,PR (restore PR) */
        .short  0x000B        /* $0243BA: RTS */
        .short  0x0009        /* $0243BC: [delay] NOP */
