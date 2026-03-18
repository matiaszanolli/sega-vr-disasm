/*
 * cmd3f_vr60_gameframe — VR60 Game Frame Handler (Phase 1A: SDRAM Validation)
 * Expansion ROM Address: $301500 (SH2: $02301500)
 *
 * Phase 1A: Validates SDRAM path by copying entity visibility data from the
 * existing cmd $02 DMA landing area ($0600C800) to the new VR60 entity table
 * area ($0600F20C), then writes a validation canary at $0600FC00.
 *
 * This proves the Master SH2 can read and write the VR60 SDRAM region without
 * conflicting with the rendering pipeline. Zero game behavior changes.
 *
 * COMM Protocol (cmd $3F):
 *   68K writes:
 *     COMM0_LO = $3F (dispatch index)
 *     COMM0_HI = $01 (trigger, written LAST)
 *   SH2 clears:
 *     COMM0_LO = $00 (params consumed)
 *   SH2 work:
 *     Copy 480 bytes: $2200C800 → $2200F20C (cache-through)
 *     Write canary: $DEADBEEF at $2200FC00
 *   SH2 signals:
 *     COMM1_LO bit 0 = 1 (command done)
 *     COMM0_HI = $00 (idle)
 *
 * Memory addresses (all cache-through for cross-CPU visibility):
 *   Source:  $2200C800  (entity visibility table, 32 × 16B)
 *   Dest:   $2200F20C  (VR60 entity mirror area, verified free)
 *   Canary: $2200FC00  (validation marker)
 *   Mailbox: $2200BC00 (controller input, future use)
 *
 * Entry: R8 = $20004020 (COMM base, set by dispatch loop)
 * Clobbers: R0-R5
 * Preserves: R6-R7, R15 (R8 reloaded)
 */

.section .text
.align 2

cmd3f_vr60_gameframe:
    /* Save PR */
    /* offset  0 */ sts.l   pr,@-r15

    /* === PARAMS-CONSUMED SIGNAL === */
    /* offset  2 */ mov     #0,r0
    /* offset  4 */ mov.b   r0,@(1,r8)          /* COMM0_LO = $00 */

    /* === MEMCPY: $2200C800 → $2200F20C (480 bytes = 120 longwords) === */
    /* Load source address (entity visibility table, cache-through) */
    /* offset  6 */ mov.l   @(.src_addr,pc),r3   /* R3 = $2200C800 */
    /* offset  8 */ mov.l   @(.dst_addr,pc),r4   /* R4 = $2200F20C */
    /* offset 10 */ mov     #120,r5              /* R5 = 120 longwords (480 bytes) */

.copy_loop:
    /* offset 12 */ mov.l   @r3+,r0              /* R0 = *src++ */
    /* offset 14 */ mov.l   r0,@r4               /* *dst = R0 */
    /* offset 16 */ dt      r5                   /* R5-- and test zero */
    /* offset 18 */ bf/s    .copy_loop           /* loop if not zero */
    /* offset 20 */ add     #4,r4                /* [delay slot] dst += 4 */

    /* === WRITE VALIDATION CANARY === */
    /* offset 22 */ mov.l   @(.canary_addr,pc),r4 /* R4 = $2200FC00 */
    /* offset 24 */ mov.l   @(.canary_val,pc),r0  /* R0 = $DEADBEEF */
    /* offset 26 */ mov.l   r0,@r4               /* *canary = $DEADBEEF */

    /* === READ SDRAM MAILBOX (proof of mailbox access) === */
    /* offset 28 */ mov.l   @(.mailbox_addr,pc),r1 /* R1 = $2200BC00 */
    /* offset 30 */ mov.w   @r1,r0               /* R0 = controller_input_p1 */

    /* === COMPLETION: inline COMM cleanup === */
    /* offset 32 */ mov.l   @(.comm_base,pc),r8  /* R8 = $20004020 */

    /* Clear COMM1, set "command done" bit */
    /* offset 34 */ mov     #0,r0
    /* offset 36 */ mov.w   r0,@(2,r8)           /* COMM1 = $0000 */
    /* offset 38 */ mov.b   @(3,r8),r0           /* R0 = COMM1_LO (0) */
    /* offset 40 */ or      #1,r0                /* R0 |= 1 */
    /* offset 42 */ mov.b   r0,@(3,r8)           /* COMM1_LO = 1 ("done") */

    /* Clear COMM0_HI */
    /* offset 44 */ mov     #0,r0
    /* offset 46 */ mov.b   r0,@(0,r8)           /* COMM0_HI = 0 */

    /* === RETURN === */
    /* offset 48 */ lds.l   @r15+,pr
    /* offset 50 */ rts
    /* offset 52 */ nop                          /* delay slot */

/* === LITERAL POOL ===
 * Code ends at offset 54.
 * Alignment: offset 54 is even but not 4-aligned → 2 bytes padding.
 */
.align 2
.src_addr:
    .long   0x2200C800              /* Entity visibility table (cache-through) */
.dst_addr:
    .long   0x2200F20C              /* VR60 entity mirror area (cache-through) */
.canary_addr:
    .long   0x2200FC00              /* Validation canary location */
.canary_val:
    .long   0xDEADBEEF              /* Canary value */
.mailbox_addr:
    .long   0x2200BC00              /* SDRAM mailbox (cache-through) */
.comm_base:
    .long   0x20004020              /* COMM register base (cache-through) */

/* Total: 54 bytes code + 2 bytes pad + 24 bytes pool = 80 bytes */

.global cmd3f_vr60_gameframe
