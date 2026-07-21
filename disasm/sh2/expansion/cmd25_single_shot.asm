/*
 * cmd25_single_shot — Single-Shot Decompression Handler (cmd $25)
 * Expansion ROM Address: $300500 (SH2: $02300500)
 * Size: 64 bytes (52 bytes code + 12 bytes literal pool)
 *
 * B-005: Converts the 3-phase sh2_send_cmd_wait protocol to single-shot.
 *
 * The original cmd $25 handler at $06005024 used a 3-phase COMM6 handshake:
 *   Phase 1: 68K writes A0 (source) to COMM4, SH2 acks via COMM6=0
 *   Phase 2: 68K writes A1 (dest) to COMM4, SH2 acks via COMM6=0
 * This required ~350 cycles per call due to two COMM6 polling loops.
 *
 * The single-shot protocol writes both pointers at once:
 *   COMM3:4 = A0 (source, with $02000000 cartridge-ROM prefix from 68K)
 *   COMM5:6 = A1 (dest, full SH2 address e.g. $0601xxxx)
 *   COMM0_LO = $25 (dispatch index), COMM0_HI = $01 (trigger, written LAST)
 *
 * Params-consumed handshake (same as B-004):
 *   - SH2 clears COMM0_LO=$00 immediately after reading all params
 *   - 68K sender polls COMM0_LO==0 before returning
 *   - Prevents COMM overwrite while SH2 is still reading
 *
 * COMM Register Layout (68K write order, SH2 read perspective, R8=$20004020):
 *   COMM0_HI (offset 0):  $01 — trigger (written LAST by 68K)
 *   COMM0_LO (offset 1):  $25 — dispatch index; cleared to $00 by SH2 (handshake)
 *   COMM1    (offsets 2,3): UNTOUCHED
 *   COMM2_HI (offset 4):  $00 — NEVER WRITTEN (Slave's work-cmd poll byte)
 *   COMM2_LO (offset 5):  unused
 *   COMM3_HI (offset 6):  A0[31:24] = $02 (cartridge-ROM prefix, added by 68K)
 *   COMM3_LO (offset 7):  A0[23:16]
 *   COMM4_HI (offset 8):  A0[15:8]
 *   COMM4_LO (offset 9):  A0[7:0]
 *   COMM5_HI (offset 10): A1[31:24] (typically $06 for SDRAM cached)
 *   COMM5_LO (offset 11): A1[23:16]
 *   COMM6_HI (offset 12): A1[15:8]
 *   COMM6_LO (offset 13): A1[7:0]
 *   COMM7    (offsets 14,15): UNTOUCHED
 *
 * DISPATCH: Master SH2 dispatch loop reads COMM0_HI until non-zero (trigger),
 * then reads COMM0_LO as dispatch index. SHLL2 on COMM0_LO=$25 -> offset $94
 * into jump table at $06000780 -> entry at $06000814 = $02300500 (this handler).
 *
 * Entry: R8 = $20004020 (COMM base, set by dispatch loop before JSR)
 *
 * Register Mapping:
 *   R0 = scratch (all @(disp,R8) reads/writes; JSR target)
 *   R3 = A1[15:0] temp
 *   R4 = A0[15:0] temp
 *   R7 = prefix constant ($02000000)
 *   R9 = reconstructed source pointer ($02xxxxxx)
 *   R10 = reconstructed dest pointer ($06xxxxxx)
 *
 * A0 Reconstruction:
 *   COMM3_LO -> R9[23:16], COMM4 -> R4[15:0]
 *   SHLL16 R9, OR R4 -> R9[23:0], OR $02000000 -> R9 = $02xxxxxx
 *   (A0[31:24] is always $02, so we hardcode the prefix)
 *
 * A1 Reconstruction:
 *   COMM5 -> R10[31:16], COMM6 -> R3[15:0]
 *   SHLL16 R10, OR R3 -> R10 = full SH2 address
 *   (A1 is already a full SH2 address like $0601xxxx; no prefix needed)
 *
 * After param read + COMM0_LO clear, calls the existing decompressor
 * subroutine at $06005058 (runtime SDRAM) with R9=cartridge-ROM source and
 * R10=SDRAM destination.
 * The decompressor saves/restores all registers internally.
 *
 * Completion: calls func_084 ($060043F0) which clears COMM0_HI to $00
 * (separate from the COMM0_LO handshake). The 68K polls COMM0_HI==0 at
 * the start of the next call, not during this one.
 *
 * Pool layout (offsets from function start, base=$300500):
 *   offset 52 ($300534): .src_prefix = $02000000 (4 bytes)
 *   offset 56 ($300538): .decomp     = $06005058 (4 bytes)
 *   offset 60 ($30053C): .func084    = $060043F0 (4 bytes)
 *   Total pool: 12 bytes -> grand total: 64 bytes
 *
 * PC-relative MOV.L alignment verification:
 *   offset 26: MOV.L -> PC=base+30, (PC&~3)=base+28, target=base+52, disp=6 (6*4=24 OK)
 *   offset 34: MOV.L -> PC=base+38, (PC&~3)=base+36, target=base+56, disp=5 (5*4=20 OK)
 *   offset 40: MOV.L -> PC=base+44, (PC&~3)=base+44, target=base+60, disp=4 (4*4=16 OK)
 *   No alignment NOPs needed.
 */

.section .text
.align 2

cmd25_single_shot:
    /* === SAVE PR === */
    /* offset  0 */ sts.l   pr,@-r15            /* Save PR */

    /* === PARAM READ: Source addr (A0) from COMM3_LO:COMM4 === */
    /* offset  2 */ mov.b   @(7,r8),r0          /* R0 = COMM3_LO = A0[23:16] */
    /* offset  4 */ extu.b  r0,r9               /* R9 = A0[23:16] (zero-extended) */
    /* offset  6 */ mov.w   @(8,r8),r0          /* R0 = COMM4 = A0[15:0] (byte offset 8) */
    /* offset  8 */ extu.w  r0,r4               /* R4 = A0[15:0] (zero-extended) */

    /* === PARAM READ: Dest addr (A1) from COMM5:COMM6 === */
    /* offset 10 */ mov.w   @(10,r8),r0         /* R0 = COMM5 = A1[31:16] (byte offset 10) */
    /* offset 12 */ mov     r0,r10              /* R10 = A1[31:16] (save before next read) */
    /* offset 14 */ mov.w   @(12,r8),r0         /* R0 = COMM6 = A1[15:0] (byte offset 12) */
    /* offset 16 */ extu.w  r0,r3               /* R3 = A1[15:0] (zero-extended) */

    /* === PARAMS-CONSUMED SIGNAL: clear COMM0_LO=$00 -> 68K can return === */
    /* offset 18 */ mov     #0,r0               /* R0 = 0 */
    /* offset 20 */ mov.b   r0,@(1,r8)          /* COMM0_LO = $00 (params read) */

    /* === A0 RECONSTRUCTION: $02000000 | (A0[23:16] << 16) | A0[15:0] === */
    /* offset 22 */ shll16  r9                  /* R9 = A0[23:16] << 16 */
    /* offset 24 */ or      r4,r9               /* R9 = A0[23:0] */
    /* offset 26 */ mov.l   @(.src_prefix,pc),r7 /* R7=$02000000 [disp=6] */
    /* offset 28 */ or      r7,r9               /* R9 = $02xxxxxx (cached cartridge ROM) */

    /* === A1 RECONSTRUCTION: (A1[31:16] << 16) | A1[15:0] === */
    /* offset 30 */ shll16  r10                 /* R10 = A1[31:16] << 16 */
    /* offset 32 */ or      r3,r10              /* R10 = full A1 address ($06xxxxxx) */

    /* === CALL DECOMPRESSOR at $06005058 === */
    /* offset 34 */ mov.l   @(.decomp,pc),r0    /* R0=$06005058 [disp=5] */
    /* offset 36 */ jsr     @r0                 /* Call decompressor (saves/restores all regs) */
    /* offset 38 */ nop                         /* [delay slot] */

    /* === COMPLETION: Clear COMM0_HI via func_084 === */
    /* offset 40 */ mov.l   @(.func084,pc),r0   /* R0=$060043F0 [disp=4] */
    /* offset 42 */ jsr     @r0                 /* Call func_084 (clears COMM0_HI, sets COMM1_LO bit 0) */
    /* offset 44 */ nop                         /* [delay slot] */

    /* === RETURN === */
    /* offset 46 */ lds.l   @r15+,pr            /* Restore PR */
    /* offset 48 */ rts                         /* Return to dispatch loop */
    /* offset 50 */ nop                         /* [delay slot] */

/* === LITERAL POOL ===
 * Code ends at offset 52 (26 instructions x 2B = 52B).
 * Pool (12 bytes):
 *   offset 52 ($300534): .src_prefix = $02000000
 *   offset 56 ($300538): .decomp     = $06005058
 *   offset 60 ($30053C): .func084    = $060043F0
 * Total: 52 + 12 = 64 bytes
 */
.align 2
.src_prefix:
    .long   0x02000000              /* Cached cartridge-ROM read prefix (src) */
.decomp:
    .long   0x06005058              /* Decompressor subroutine in SDRAM */
.func084:
    .long   0x060043F0              /* func_084: clears COMM0_HI, sets COMM1_LO bit 0 */

/* Total: 52 bytes code + 12 bytes pool = 64 bytes */

.global cmd25_single_shot
