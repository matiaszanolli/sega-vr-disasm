/*
 * vis_bitmask_handler — Entity Visibility Descriptor Patcher (cmd $07)
 * Expansion ROM Address: $3011A0 (SH2: $023011A0)
 * Size: 64 bytes (56 bytes code + 8 bytes literal pool)
 *
 * DORMANT/INVALID S-1c EXPERIMENT: the literals below use $22xxxxxx, which
 * is cache-through cartridge ROM—not SDRAM. The descriptor family was also
 * proven unused for racing. Do not activate this handler; a new experiment
 * would need verified live descriptors and $26xxxxxx SDRAM aliases.
 *
 * Sequential mapping: 68K entities 0-14 → SH2 descriptors at
 * $0600C344 + N*$14 (contiguous groups A-D, stride $14 = 20 bytes).
 * Historical writes incorrectly used $2200xxxx ROM aliases.
 *
 * The Slave SH2 entity loops check MOV.W @(0,R14),R0 / CMP/EQ #0,R0 / BT
 * at the start of each iteration. Flag=0 → skip all rendering for that
 * entity. Flag≠0 → render normally.
 *
 * COMM Register Layout (R8 = $20004020):
 *   COMM0_HI (offset 0):  $01 — trigger (68K sets last)
 *   COMM0_LO (offset 1):  $07 — dispatch index; cleared to $00 by SH2
 *   COMM3    (offset 6,7): 15-bit visibility bitmask (bit N = entity N)
 *
 * Historical invalid descriptor base $2200C344 (ROM alias):
 *   Stride: $14 (20 bytes), flag word at offset +0
 *   15 descriptors patched: entities 0-4 (group A), 5-12 (group B),
 *   13-14 (group C first 2 of 5)
 *
 * Entry: R8 = $20004020 (COMM base, set by dispatch loop)
 * Uses: R0, R1, R2, R3, R5, R6
 */

.section .text
.align 2

vis_bitmask_handler:
    /* --- Read bitmask from COMM3 --- */
    /* offset  0 */ mov.w   @(6,r8),r0          /* R0 = COMM3 = 15-bit bitmask       $8583 */
    /* offset  2 */ extu.w  r0,r5               /* R5 = bitmask (preserved in loop)   $650D */

    /* --- Store bitmask to SDRAM (Phase 1 compatibility) --- */
    /* offset  4 */ mov.l   @(.vis_sdram,pc),r1 /* R1 = $2203E020                    $D10C */
    /* offset  6 */ mov.w   r5,@r1              /* Store raw bitmask to SDRAM         $2151 */

    /* --- Handshake: signal params consumed --- */
    /* offset  8 */ mov     #0,r0               /* R0 = 0                             $E000 */
    /* offset 10 */ mov.b   r0,@(1,r8)          /* COMM0_LO = $00 (68K can proceed)  $8081 */

    /* --- Setup descriptor patching loop --- */
    /* offset 12 */ mov.l   @(.desc_base,pc),r2 /* R2 = $2200C344 (1st descriptor)   $D20B */
    /* offset 14 */ mov     #1,r6               /* R6 = 1 (visible flag + test mask)  $E601 */
    /* offset 16 */ mov     #0,r1               /* R1 = 0 (invisible flag value)      $E100 */
    /* offset 18 */ mov     #15,r3              /* R3 = 15 iterations (entities 0-14) $E30F */

.loop:
    /* --- Test visibility bit and patch descriptor flag --- */
    /* offset 20 */ tst     r6,r5               /* T = (R5 & 1 == 0)                  $2568 */
    /* offset 22 */ bt      .invisible          /* T=1 → bit=0 → invisible            $8901 */
    /* offset 24 */ bra     .next               /* visible → skip invisible write      $A001 */
    /* offset 26 */ mov.w   r6,@r2              /* [delay slot] flag = 1 (visible)     $2261 */
.invisible:
    /* offset 28 */ mov.w   r1,@r2              /* flag = 0 (invisible)                $2211 */
.next:
    /* offset 30 */ add     #20,r2              /* next descriptor (+$14 stride)       $7214 */
    /* offset 32 */ shlr    r5                  /* shift bitmask right                 $4501 */
    /* offset 34 */ dt      r3                  /* R3--; T = (R3 == 0)                 $4310 */
    /* offset 36 */ bf      .loop               /* loop if R3 ≠ 0                     $8BF6 */

    /* --- COMM1 cleanup (func_084 equivalent) --- */
    /* offset 38 */ mov     #0,r0               /* R0 = 0                              $E000 */
    /* offset 40 */ mov.w   r0,@(2,r8)          /* COMM1_HI:LO = $0000                $8181 */
    /* offset 42 */ mov.b   @(3,r8),r0          /* R0 = COMM1_LO (just cleared = 0)   $8483 */
    /* offset 44 */ or      #1,r0               /* R0 |= 1 ("command done")            $CB01 */
    /* offset 46 */ mov.b   r0,@(3,r8)          /* COMM1_LO = 1                        $8083 */

    /* --- Clear COMM0_HI (byte write, preserves COMM0_LO) --- */
    /* offset 48 */ mov     #0,r0               /* R0 = 0                              $E000 */
    /* offset 50 */ mov.b   r0,@(0,r8)          /* COMM0_HI = 0 (release bus)          $8080 */

    /* --- Return to dispatch loop --- */
    /* offset 52 */ rts                         /*                                     $000B */
    /* offset 54 */ nop                         /* [delay slot]                         $0009 */

/* === LITERAL POOL ===
 * Offset 56: $2203E020 — invalid ROM alias (historical bitmask storage)
 * Offset 60: $2200C344 — invalid ROM alias (historical descriptor base)
 *
 * MOV.L at offset 4 → disp = ($3011D8 - $3011A8) / 4 = $30/4 = 12
 * MOV.L at offset 12 → disp = ($3011DC - $3011B0) / 4 = $2C/4 = 11
 *
 * Total: 56 bytes code + 8 bytes pool = 64 bytes
 */
.align 2
.vis_sdram:
    .long   0x2203E020          /* INVALID legacy ROM alias; handler dormant */
.desc_base:
    .long   0x2200C344          /* INVALID legacy ROM alias; handler dormant */

/* Total: 64 bytes ($3011A0-$3011DF) */
.global vis_bitmask_handler
