/*
 * func_044: Edge/Scan Processor
 * ROM File Offset: 0x23BA8 - 0x23CB3 (268 bytes)
 * SH2 Address: 0x02223BA8 - 0x02223CB3
 *
 * Purpose: Edge and scanline processing for polygon rasterization.
 *          Contains multiple entry points for different edge cases.
 *          Handles horizontal span filling with byte and word operations.
 *
 * Type: Leaf function (no PR save - multiple entry points)
 * Called By: func_043 (polygon batch processor) via BSR
 *
 * Features:
 *   - Multiple entry points for different edge configurations
 *   - Byte and word-aligned span filling
 *   - Uses SWAP.B/SWAP.W for byte manipulation
 *   - Embedded literal pools for address calculation
 *
 * Note: Contains complex control flow with multiple RTS exit points.
 */

.section .text
.p2align 1    /* 2-byte alignment for $023BA8 start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_044: Edge/Scan Processor - Entry Point A
 * Entry: 0x02223BA8
 * ═══════════════════════════════════════════════════════════════════════════ */
func_044_entry_a:
    .short  0x851F        /* $023BA8: MOV.W @(30,R8),R0 */
    .short  0x940B        /* $023BAA: MOV.W @(22,PC),R4 → mask 0xFF00 */
    .short  0xC802        /* $023BAC: TST #2,R0 */
    .short  0x8B0F        /* $023BAE: BF $023BD0 (entry_b) */
    .short  0x2049        /* $023BB0: AND R4,R0 */
    .short  0x6408        /* $023BB2: SWAP.B R0,R4 */
    .short  0x240B        /* $023BB4: OR R0,R4 */
    .short  0xD004        /* $023BB6: MOV.L @(16,PC),R0 → base addr */
    .short  0x4518        /* $023BB8: SHLL8 R5 */
    .short  0x4500        /* $023BBA: SHLL R5 */
    .short  0x350C        /* $023BBC: ADD R0,R5 */
    .short  0xDE03        /* $023BBE: MOV.L @(12,PC),R14 → context */
    .short  0x000B        /* $023BC0: RTS */
    .short  0x0009        /* $023BC2: [delay] NOP */
    /* Literal pool 1 */
    .short  0xFF00        /* $023BC4: mask constant */
    .short  0x0000        /* $023BC6: padding */
    .short  0x2400        /* $023BC8: hi word of $24004000 */
    .short  0x4000        /* $023BCA: lo word */
    .short  0xC000        /* $023BCC: hi word of $C0000188 */
    .short  0x0188        /* $023BCE: lo word */

/* ═══════════════════════════════════════════════════════════════════════════
 * Entry Point B - Alternate path
 * Entry: 0x02223BD0
 * ═══════════════════════════════════════════════════════════════════════════ */
func_044_entry_b:
    .short  0x2409        /* $023BD0: AND R0,R4 */
    .short  0x6053        /* $023BD2: MOV R5,R0 */
    .short  0xC801        /* $023BD4: TST #1,R0 */
    .short  0x8B00        /* $023BD6: BF $023BDA */
    .short  0x6448        /* $023BD8: SWAP.B R4,R4 */
    .short  0xD005        /* $023BDA: MOV.L @(20,PC),R0 → base addr */
    .short  0x4518        /* $023BDC: SHLL8 R5 */
    .short  0x4500        /* $023BDE: SHLL R5 */
    .short  0x350C        /* $023BE0: ADD R0,R5 */
    .short  0xDE04        /* $023BE2: MOV.L @(16,PC),R14 → context */
wait_loop_1:
    .short  0xC505        /* $023BE4: MOV.W @(10,GBR),R0 */
    .short  0xC802        /* $023BE6: TST #2,R0 */
    .short  0x8BFC        /* $023BE8: BF $023BE4 (wait) */
    .short  0x000B        /* $023BEA: RTS */
    .short  0x0009        /* $023BEC: [delay] NOP */
    /* Literal pool 2 */
    .short  0x0000        /* $023BEE: padding */
    .short  0x2402        /* $023BF0: hi word of $24024000 */
    .short  0x4000        /* $023BF2: lo word */
    .short  0xC000        /* $023BF4: hi word of $C00001F4 */
    .short  0x01F4        /* $023BF6: lo word */

/* ═══════════════════════════════════════════════════════════════════════════
 * Entry Point C - Scan line fill (left to right)
 * Entry: 0x02223BF8
 * ═══════════════════════════════════════════════════════════════════════════ */
func_044_scanfill_lr:
    .short  0x62C9        /* $023BF8: SWAP.W R12,R2 */
    .short  0x622F        /* $023BFA: EXTS.W R2,R2 */
    .short  0x63D9        /* $023BFC: SWAP.W R13,R3 */
    .short  0x633F        /* $023BFE: EXTS.W R3,R3 */
    .short  0x312C        /* $023C00: ADD R2,R1 */
    .short  0x3320        /* $023C02: CMP/EQ R2,R3 */
    .short  0x891E        /* $023C04: BT $023C44 (wait_exit) */
wait_loop_2:
    .short  0xC505        /* $023C06: MOV.W @(10,GBR),R0 */
    .short  0xC802        /* $023C08: TST #2,R0 */
    .short  0x8FFC        /* $023C0A: BF/S $023C06 (wait) */
    .short  0xE001        /* $023C0C: [delay] MOV #1,R0 */
    .short  0x2208        /* $023C0E: TST R0,R2 */
    .short  0x8902        /* $023C10: BT $023C18 */
    .short  0x2140        /* $023C12: MOV.B R4,@R1 */
    .short  0x7101        /* $023C14: ADD #1,R1 */
    .short  0x7201        /* $023C16: ADD #1,R2 */
check_r3_odd:
    .short  0x2308        /* $023C18: TST R0,R3 */
    .short  0x8F03        /* $023C1A: BF/S $023C24 */
    .short  0x6033        /* $023C1C: [delay] MOV R3,R0 */
    .short  0x305C        /* $023C1E: ADD R5,R0 */
    .short  0x2040        /* $023C20: MOV.B R4,@R0 */
    .short  0x6033        /* $023C22: MOV R3,R0 */
calc_span:
    .short  0x3028        /* $023C24: SUB R2,R0 */
    .short  0x7001        /* $023C26: ADD #1,R0 */
    .short  0xE202        /* $023C28: MOV #2,R2 */
    .short  0x3023        /* $023C2A: CMP/GE R2,R0 */
    .short  0x8F08        /* $023C2C: BF/S $023C40 (short_exit) */
    .short  0x4001        /* $023C2E: [delay] SHLR R0 */
    .short  0x70FF        /* $023C30: ADD #-1,R0 */
    .short  0xC102        /* $023C32: MOV.W R0,@(4,GBR) */
    .short  0x6013        /* $023C34: MOV R1,R0 */
    .short  0x4001        /* $023C36: SHLR R0 */
    .short  0xC103        /* $023C38: MOV.W R0,@(6,GBR) */
    .short  0x6043        /* $023C3A: MOV R4,R0 */
    .short  0x000B        /* $023C3C: RTS */
    .short  0xC104        /* $023C3E: [delay] MOV.W R0,@(8,GBR) */
short_exit:
    .short  0x000B        /* $023C40: RTS */
    .short  0x0009        /* $023C42: [delay] NOP */
wait_exit:
    .short  0xC505        /* $023C44: MOV.W @(10,GBR),R0 */
    .short  0xC802        /* $023C46: TST #2,R0 */
    .short  0x8BFC        /* $023C48: BF $023C44 (wait) */
    .short  0x000B        /* $023C4A: RTS */
single_pixel:
    .short  0x2140        /* $023C4C: MOV.B R4,@R1 */
    .short  0xE202        /* $023C4E: MOV #2,R2 */
    .short  0x3023        /* $023C50: CMP/GE R2,R0 */
    .short  0x8BF5        /* $023C52: BF $023C40 (short_exit) */
    .short  0x4001        /* $023C54: SHLR R0 */
word_fill_loop:
    .short  0x2141        /* $023C56: MOV.W R4,@R1 */
    .short  0x4010        /* $023C58: DT R0 */
    .short  0x8FFC        /* $023C5A: BF/S $023C56 (word_fill) */
    .short  0x7102        /* $023C5C: [delay] ADD #2,R1 */
    .short  0x000B        /* $023C5E: RTS */
    .short  0x0009        /* $023C60: [delay] NOP */
    .short  0x0009        /* $023C62: NOP (padding) */

/* ═══════════════════════════════════════════════════════════════════════════
 * Entry Point D - Scan line fill (right to left)
 * Entry: 0x02223C64
 * ═══════════════════════════════════════════════════════════════════════════ */
func_044_scanfill_rl:
    .short  0x62C9        /* $023C64: SWAP.W R12,R2 */
    .short  0x622F        /* $023C66: EXTS.W R2,R2 */
    .short  0x63D9        /* $023C68: SWAP.W R13,R3 */
    .short  0x633F        /* $023C6A: EXTS.W R3,R3 */
    .short  0x6448        /* $023C6C: SWAP.B R4,R4 */
    .short  0x313C        /* $023C6E: ADD R3,R1 */
    .short  0x3320        /* $023C70: CMP/EQ R2,R3 */
    .short  0x8917        /* $023C72: BT $023CA4 (check_end) */
    .short  0x6033        /* $023C74: MOV R3,R0 */
    .short  0xC801        /* $023C76: TST #1,R0 */
    .short  0x8F03        /* $023C78: BF/S $023C82 */
    .short  0x6048        /* $023C7A: [delay] SWAP.B R4,R0 */
    .short  0x2100        /* $023C7C: MOV.B R0,@R1 */
    .short  0x71FF        /* $023C7E: ADD #-1,R1 */
    .short  0x73FF        /* $023C80: ADD #-1,R3 */
continue_rl:
    .short  0x7101        /* $023C82: ADD #1,R1 */
    .short  0x6033        /* $023C84: MOV R3,R0 */
    .short  0x3028        /* $023C86: SUB R2,R0 */
    .short  0x7001        /* $023C88: ADD #1,R0 */
    .short  0xE302        /* $023C8A: MOV #2,R3 */
    .short  0x3033        /* $023C8C: CMP/GE R3,R0 */
    .short  0x8F03        /* $023C8E: BF/S $023C98 (check_r2) */
    .short  0x4001        /* $023C90: [delay] SHLR R0 */
word_fill_rl:
    .short  0x4010        /* $023C92: DT R0 */
    .short  0x8FFD        /* $023C94: BF/S $023C92 */
    .short  0x2145        /* $023C96: [delay] MOV.W R4,@-R1 */
check_r2:
    .short  0x6023        /* $023C98: MOV R2,R0 */
    .short  0xC801        /* $023C9A: TST #1,R0 */
    .short  0x8900        /* $023C9C: BT $023CA0 */
    .short  0x2144        /* $023C9E: MOV.B R4,@-R1 */
exit_rl:
    .short  0x000B        /* $023CA0: RTS */
    .short  0x0009        /* $023CA2: [delay] NOP */
check_end:
    .short  0x6023        /* $023CA4: MOV R2,R0 */
    .short  0xC801        /* $023CA6: TST #1,R0 */
    .short  0x8B02        /* $023CA8: BF $023CB0 */
    .short  0x6048        /* $023CAA: SWAP.B R4,R0 */
    .short  0x000B        /* $023CAC: RTS */
    .short  0x2100        /* $023CAE: [delay] MOV.B R0,@R1 */
final_exit:
    .short  0x000B        /* $023CB0: RTS */
    .short  0x2140        /* $023CB2: [delay] MOV.B R4,@R1 */

/* ============================================================================
 * End of func_044 (268 bytes)
 *
 * Note: This function has four entry points:
 *   A ($023BA8): Initial setup path
 *   B ($023BD0): Alternate setup path
 *   C ($023BF8): Left-to-right scan fill
 *   D ($023C64): Right-to-left scan fill
 * ============================================================================ */
