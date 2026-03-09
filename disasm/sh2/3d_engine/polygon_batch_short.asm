/*
 * func_043: Polygon Batch Processor
 * ROM File Offset: 0x23A70 - 0x23BA7 (312 bytes)
 * SH2 Address: 0x02223A70 - 0x02223BA7
 *
 * Purpose: Core polygon batch processing function. Handles vertex interpolation,
 *          edge calculations, and coordinate transformations for polygon rendering.
 *          Calls func_044 (edge/scan processor) via BSR and uses JSR @R14 callback.
 *
 * Type: Non-leaf function (calls func_044, uses callback)
 * Called By: Display engine polygon pipeline
 * Calls: BSR to func_044 at $023BA8, JSR @R14 callback
 *
 * Features:
 *   - Dual vertex stream processing (R8/R9 pointers)
 *   - Edge interpolation with MULS.W for fixed-point math
 *   - Multiple exit paths with tail-call optimization
 *   - Embedded literal pools at multiple locations
 *
 * Note: Contains embedded literal pool data mixed with code.
 */

.section .text
.p2align 1    /* 2-byte alignment for $023A70 start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_043: Polygon Batch Processor
 * Entry: 0x02223A70
 * ═══════════════════════════════════════════════════════════════════════════ */
func_043:
    .short  0x4F22        /* $023A70: STS.L PR,@-R15 */
    .short  0xD121        /* $023A72: MOV.L @(132,PC),R1 → base addr */
    .short  0x58E9        /* $023A74: MOV.L @(36,R14),R8 */
    .short  0xE000        /* $023A76: MOV #0,R0 */
    .short  0x218B        /* $023A78: OR R8,R1 */
    .short  0x2102        /* $023A7A: MOV.L R0,@R1 */
    .short  0x1104        /* $023A7C: MOV.L R0,@(16,R1) */
    .short  0x1108        /* $023A7E: MOV.L R0,@(32,R1) */
    .short  0x110C        /* $023A80: MOV.L R0,@(48,R1) */
    .short  0x6983        /* $023A82: MOV R8,R9 */
    .short  0x7920        /* $023A84: ADD #32,R9 */
    /* NOP padding for alignment */
    .short  0x0009        /* $023A86: NOP */
    .short  0x0009        /* $023A88: NOP */
    .short  0x0009        /* $023A8A: NOP */
    .short  0x0009        /* $023A8C: NOP */
vertex_loop_1:
    .short  0x6185        /* $023A8E: MOV.W @R8+,R1 */
    .short  0x6285        /* $023A90: MOV.W @R8+,R2 */
    .short  0x4111        /* $023A92: CMP/PZ R1 */
    .short  0x8B50        /* $023A94: BF $023B38 (exit) */
    .short  0x8581        /* $023A96: MOV.W @(2,R8),R0 */
    .short  0x6523        /* $023A98: MOV R2,R5 */
    .short  0x3200        /* $023A9A: CMP/EQ R0,R2 */
    .short  0x89F7        /* $023A9C: BT $023A8E (loop) */
    .short  0x3208        /* $023A9E: SUB R0,R2 */
    .short  0x4215        /* $023AA0: CMP/PL R2 */
    .short  0x8949        /* $023AA2: BT $023B38 (exit) */
    .short  0xD015        /* $023AA4: MOV.L @(84,PC),R0 → coeff */
    .short  0x662B        /* $023AA6: NEG R2,R6 */
    .short  0x4200        /* $023AA8: SHLL R2 */
    .short  0x032D        /* $023AAA: DMULS.L R2,R3 */
    .short  0x8580        /* $023AAC: MOV.W @(0,R8),R0 */
    .short  0x6C13        /* $023AAE: MOV R1,R12 */
    .short  0x4C28        /* $023AB0: SHLL16 R12 */
    .short  0x3108        /* $023AB2: SUB R0,R1 */
    .short  0x231F        /* $023AB4: MULS.W R1,R3 */
vertex_loop_2:
    .short  0x6195        /* $023AB6: MOV.W @R9+,R1 */
    .short  0x6295        /* $023AB8: MOV.W @R9+,R2 */
    .short  0x4111        /* $023ABA: CMP/PZ R1 */
    .short  0x8B3C        /* $023ABC: BF $023B38 (exit) */
    .short  0x8591        /* $023ABE: MOV.W @(2,R9),R0 */
    .short  0x3200        /* $023AC0: CMP/EQ R0,R2 */
    .short  0x89F8        /* $023AC2: BT $023AB6 (loop) */
    .short  0x3208        /* $023AC4: SUB R0,R2 */
    .short  0x4215        /* $023AC6: CMP/PL R2 */
    .short  0x8936        /* $023AC8: BT $023B38 (exit) */
    .short  0x0A1A        /* $023ACA: STS MACL,R10 */
    .short  0x4A08        /* $023ACC: SHLL2 R10 */
    .short  0xD00B        /* $023ACE: MOV.L @(44,PC),R0 → coeff */
    .short  0x672B        /* $023AD0: NEG R2,R7 */
    .short  0x4200        /* $023AD2: SHLL R2 */
    .short  0x032D        /* $023AD4: DMULS.L R2,R3 */
    .short  0x8590        /* $023AD6: MOV.W @(0,R9),R0 */
    .short  0x6D13        /* $023AD8: MOV R1,R13 */
    .short  0x4D28        /* $023ADA: SHLL16 R13 */
    .short  0x3108        /* $023ADC: SUB R0,R1 */
    .short  0x231F        /* $023ADE: MULS.W R1,R3 */
    .short  0xD007        /* $023AE0: MOV.L @(28,PC),R0 → mask */
    .short  0x2C0B        /* $023AE2: OR R0,R12 */
    .short  0x2D0B        /* $023AE4: OR R0,R13 */
    .short  0x0B1A        /* $023AE6: STS MACL,R11 */
    .short  0x4B08        /* $023AE8: SHLL2 R11 */
    .short  0x3DC0        /* $023AEA: CMP/EQ R12,R13 */
    .short  0x890A        /* $023AEC: BT $023B04 (compare) */
    .short  0x3DC7        /* $023AEE: CMP/GT R12,R13 */
    .short  0x8916        /* $023AF0: BT $023B20 (call func_044) */
    .short  0xA00A        /* $023AF2: BRA $023B0A (swap) */
    .short  0x6063        /* $023AF4: [delay] MOV R6,R0 */
    /* Literal pool 1 */
    .short  0x0000        /* $023AF6: padding/alignment */
    .short  0x4000        /* $023AF8: hi word of $40000000 */
    .short  0x0000        /* $023AFA: lo word */
    .short  0x0600        /* $023AFC: hi word of $060048D0 */
    .short  0x48D0        /* $023AFE: lo word */
    .short  0x0000        /* $023B00: hi word of $00008000 */
    .short  0x8000        /* $023B02: lo word */
compare_path:
    .short  0x3BA7        /* $023B04: CMP/GT R10,R11 */
    .short  0x890B        /* $023B06: BT $023B20 (call func_044) */
    .short  0x6063        /* $023B08: MOV R6,R0 */
swap_registers:
    .short  0x6673        /* $023B0A: MOV R7,R6 */
    .short  0x6703        /* $023B0C: MOV R0,R7 */
    .short  0x6083        /* $023B0E: MOV R8,R0 */
    .short  0x6893        /* $023B10: MOV R9,R8 */
    .short  0x6903        /* $023B12: MOV R0,R9 */
    .short  0x60A3        /* $023B14: MOV R10,R0 */
    .short  0x6AB3        /* $023B16: MOV R11,R10 */
    .short  0x6B03        /* $023B18: MOV R0,R11 */
    .short  0x60C3        /* $023B1A: MOV R12,R0 */
    .short  0x6CD3        /* $023B1C: MOV R13,R12 */
    .short  0x6D03        /* $023B1E: MOV R0,R13 */
call_func_044:
    .short  0xB042        /* $023B20: BSR $023BA8 (func_044) */
    .short  0x51E9        /* $023B22: [delay] MOV.L @(36,R14),R1 */
    .short  0x4E0B        /* $023B24: JSR @R14 (callback) */
    .short  0x6153        /* $023B26: [delay] MOV R5,R1 */
    .short  0x9005        /* $023B28: MOV.W @(10,PC),R0 → stride 0x200 */
    .short  0x350C        /* $023B2A: ADD R0,R5 */
    .short  0x4610        /* $023B2C: DT R6 */
    .short  0x8F1B        /* $023B2E: BF/S $023B68 (continue) */
    .short  0x3CAC        /* $023B30: [delay] ADD R10,R12 */
    .short  0xA005        /* $023B32: BRA $023B40 (next vertex) */
    .short  0x6185        /* $023B34: [delay] MOV.W @R8+,R1 */
    /* Literal pool 2 */
    .short  0x0200        /* $023B36: stride constant */
early_exit:
    .short  0x4F26        /* $023B38: LDS.L @R15+,PR */
    .short  0x000B        /* $023B3A: RTS */
    .short  0x0009        /* $023B3C: [delay] NOP */
next_vertex:
    .short  0x6185        /* $023B3E: MOV.W @R8+,R1 */
process_vertex:
    .short  0x6285        /* $023B40: MOV.W @R8+,R2 */
    .short  0x8581        /* $023B42: MOV.W @(2,R8),R0 */
    .short  0x4011        /* $023B44: CMP/PZ R0 */
    .short  0x8B29        /* $023B46: BF $023B9C (exit path 2) */
    .short  0x3200        /* $023B48: CMP/EQ R0,R2 */
    .short  0x89F8        /* $023B4A: BT $023B3E (loop) */
    .short  0x3208        /* $023B4C: SUB R0,R2 */
    .short  0x4215        /* $023B4E: CMP/PL R2 */
    .short  0x89F2        /* $023B50: BT $023B38 (early exit) */
    .short  0xD011        /* $023B52: MOV.L @(68,PC),R0 → coeff */
    .short  0x662B        /* $023B54: NEG R2,R6 */
    .short  0x4200        /* $023B56: SHLL R2 */
    .short  0x032D        /* $023B58: DMULS.L R2,R3 */
    .short  0x8580        /* $023B5A: MOV.W @(0,R8),R0 */
    .short  0x6C13        /* $023B5C: MOV R1,R12 */
    .short  0x4C28        /* $023B5E: SHLL16 R12 */
    .short  0x3108        /* $023B60: SUB R0,R1 */
    .short  0x231F        /* $023B62: MULS.W R1,R3 */
    .short  0x0A1A        /* $023B64: STS MACL,R10 */
    .short  0x4A08        /* $023B66: SHLL2 R10 */
continue_loop:
    .short  0x4710        /* $023B68: DT R7 */
    .short  0x8FDB        /* $023B6A: BF/S $023B24 (callback loop) */
    .short  0x3DBC        /* $023B6C: [delay] ADD R11,R13 */
    .short  0x6195        /* $023B6E: MOV.W @R9+,R1 */
    .short  0x6295        /* $023B70: MOV.W @R9+,R2 */
    .short  0x8591        /* $023B72: MOV.W @(2,R9),R0 */
    .short  0x3200        /* $023B74: CMP/EQ R0,R2 */
    .short  0x89FA        /* $023B76: BT $023B6E (loop) */
    .short  0x3208        /* $023B78: SUB R0,R2 */
    .short  0x4215        /* $023B7A: CMP/PL R2 */
    .short  0x89DC        /* $023B7C: BT $023B38 (early exit) */
    .short  0xD006        /* $023B7E: MOV.L @(24,PC),R0 → coeff */
    .short  0x672B        /* $023B80: NEG R2,R7 */
    .short  0x4200        /* $023B82: SHLL R2 */
    .short  0x032D        /* $023B84: DMULS.L R2,R3 */
    .short  0x8590        /* $023B86: MOV.W @(0,R9),R0 */
    .short  0x6D13        /* $023B88: MOV R1,R13 */
    .short  0x4D28        /* $023B8A: SHLL16 R13 */
    .short  0x3108        /* $023B8C: SUB R0,R1 */
    .short  0x231F        /* $023B8E: MULS.W R1,R3 */
    .short  0x0B1A        /* $023B90: STS MACL,R11 */
    .short  0xAFC7        /* $023B92: BRA $023B24 (callback loop) */
    .short  0x4B08        /* $023B94: [delay] SHLL2 R11 */
    /* Literal pool 3 */
    .short  0x0000        /* $023B96: padding */
    .short  0x0600        /* $023B98: hi word of $060048D0 */
    .short  0x48D0        /* $023B9A: lo word */
exit_path_2:
    .short  0x3DBC        /* $023B9C: ADD R11,R13 */
    .short  0x6153        /* $023B9E: MOV R5,R1 */
    .short  0x4E2B        /* $023BA0: JMP @R14 (tail call) */
    .short  0x4F26        /* $023BA2: [delay] LDS.L @R15+,PR */
    /* Dead code / unreachable (infinite loop) */
    .short  0xAFFE        /* $023BA4: BRA $023BA4 (self) */
    .short  0x0009        /* $023BA6: [delay] NOP */

/* ============================================================================
 * End of func_043 (312 bytes)
 *
 * Note: This is a complex polygon processing function with multiple exit
 * paths and embedded literal pools. Uses both RTS and JMP @R14 tail-call
 * for exits. The infinite loop at the end appears to be unreachable.
 * ============================================================================ */
