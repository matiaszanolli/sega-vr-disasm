/*
 * cmd3f_vr60_gameframe — VR60 Game Frame Handler (Phase 2B: Async Block Copies)
 * Expansion ROM Address: $301500 (SH2: $02301500)
 *
 * Phase 3A: Fire-and-forget handler. 68K triggers cmd $3F and continues
 * immediately. This handler performs:
 *   1. Read COMM3-5 game state, write to SDRAM mailbox
 *   2. Geometry block copy: $06038000 → $04012010, 144 words × 48 rows
 *   3. Sprite block copy:   $0603B600 → $0401B010, 144 words × 24 rows
 *   4. Entity data validation: read $2200F20C (written by cmd $3E), canary
 *   5. COMM cleanup:        COMM1_LO bit 0 = "frame done" signal
 *
 * Phase 3A change: Entity copy removed (cmd $3E now handles entity transfer
 * via dedicated DREQ). Canary reads entity first longword for verification.
 *
 * Block copy algorithm reused from cmd22_single_shot.asm (longword path).
 * All addresses are 4-byte aligned and width is even → always longword path.
 * Row stride = $0200 (512 bytes, framebuffer line width).
 * Source is contiguous in SDRAM; destination is strided in framebuffer.
 *
 * Synchronization: V-INT $54 (vdp_dma_frame_swap_037) polls COMM1_LO bit 0.
 * When set, it swaps the frame buffer and resets $C87E. This gates state 0's
 * DREQ DMA from firing while copies are still in progress.
 * See: analysis/ASYNC_PIPELINE_ARCHITECTURE.md §6.3
 *
 * COMM protocol (follows cmd22 proven pattern):
 *   R8 = $20004020 (COMM base, cache-through, set by dispatch loop)
 *   Read COMM3  @(6,R8)  = frame_counter   → mailbox +$06
 *   Read COMM4  @(8,R8)  = game_state      → mailbox +$08
 *   Read COMM5  @(10,R8) = frame_toggle    → mailbox +$0A
 *   THEN clear COMM0_LO (params consumed signal)
 *
 * Block copy parameters (constant during racing, hardcoded):
 *   Geometry: src=$06038000 (SDRAM), dst=$04012010 (framebuffer)
 *            144 words/row = 72 longwords/row, 48 rows, stride $0200
 *   Sprites:  src=$0603B600 (SDRAM), dst=$0401B010 (framebuffer)
 *            144 words/row = 72 longwords/row, 24 rows, stride $0200
 *
 * Entry: R8 = $20004020
 * Clobbers: R0-R7 (R8 reloaded for cleanup)
 * Preserves: R15
 */

.section .text
.align 2

cmd3f_vr60_gameframe:
    /* Save PR */
    /* offset  0 */ sts.l   pr,@-r15

    /* === PARAM READ: read ALL COMM params BEFORE clearing COMM0_LO === */
    /* offset  2 */ mov.w   @(6,r8),r0           /* R0 = COMM3 */
    /* offset  4 */ mov     r0,r1                /* R1 = frame_counter */
    /* offset  6 */ mov.w   @(8,r8),r0           /* R0 = COMM4 */
    /* offset  8 */ mov     r0,r2                /* R2 = game_state */
    /* offset 10 */ mov.w   @(10,r8),r0          /* R0 = COMM5 */
    /* offset 12 */ mov     r0,r3                /* R3 = frame_toggle */

    /* === PARAMS-CONSUMED SIGNAL === */
    /* offset 14 */ mov     #0,r0
    /* offset 16 */ mov.b   r0,@(1,r8)           /* COMM0_LO = $00 */

    /* === WRITE COMM DATA TO SDRAM MAILBOX === */
    /* offset 18 */ mov.l   @(.mailbox_addr,pc),r4  /* R4 = $2200BC00 */
    /* offset 20 */ mov     r1,r0                /* R0 = frame_counter */
    /* offset 22 */ mov.w   r0,@(6,r4)           /* mailbox+$06 */
    /* offset 24 */ mov     r2,r0                /* R0 = game_state */
    /* offset 26 */ mov.w   r0,@(8,r4)           /* mailbox+$08 */
    /* offset 28 */ mov     r3,r0                /* R0 = frame_toggle */
    /* offset 30 */ mov.w   r0,@(10,r4)          /* mailbox+$0A */

    /* === GEOMETRY BLOCK COPY: $06038000 → $04012010, 72 longs × 48 rows === */
    /* Source is contiguous SDRAM (Slave rendered here during state 0).        */
    /* Dest is strided framebuffer (stride = $0200 = 512 bytes/line).          */
    /* offset 32 */ mov.l   @(.geo_src,pc),r3    /* R3 = $06038000 (src, auto-inc) */
    /* offset 34 */ mov.l   @(.geo_dst,pc),r0    /* R0 = $04012010 (dest base) */
    /* offset 36 */ mov     #2,r6                /* Build stride: R6 = 2 */
    /* offset 38 */ shll8   r6                   /* R6 = $0200 (512) */
    /* offset 40 */ mov     #48,r2               /* R2 = 48 rows */
.geo_row:
    /* offset 42 */ mov     r0,r4                /* R4 = dest row start */
    /* offset 44 */ mov     #72,r5               /* R5 = 72 longwords/row */
.geo_copy:
    /* offset 46 */ mov.l   @r3+,r7              /* R7 = *src++ */
    /* offset 48 */ mov.l   r7,@r4               /* *dest = R7 */
    /* offset 50 */ dt      r5                   /* R5-- and test */
    /* offset 52 */ bf/s    .geo_copy            /* loop if not zero */
    /* offset 54 */ add     #4,r4                /* [delay slot] dest += 4 */
    /* offset 56 */ dt      r2                   /* row-- */
    /* offset 58 */ bf/s    .geo_row             /* next row */
    /* offset 60 */ add     r6,r0                /* [delay slot] dest base += stride */

    /* === SPRITE BLOCK COPY: $0603B600 → $0401B010, 72 longs × 24 rows === */
    /* R6 = $0200 (stride preserved from geometry copy) */
    /* offset 62 */ mov.l   @(.spr_src,pc),r3    /* R3 = $0603B600 (src) */
    /* offset 64 */ mov.l   @(.spr_dst,pc),r0    /* R0 = $0401B010 (dest base) */
    /* offset 66 */ mov     #24,r2               /* R2 = 24 rows */
.spr_row:
    /* offset 68 */ mov     r0,r4                /* R4 = dest row start */
    /* offset 70 */ mov     #72,r5               /* R5 = 72 longwords/row */
.spr_copy:
    /* offset 72 */ mov.l   @r3+,r7              /* R7 = *src++ */
    /* offset 74 */ mov.l   r7,@r4               /* *dest = R7 */
    /* offset 76 */ dt      r5                   /* R5-- and test */
    /* offset 78 */ bf/s    .spr_copy            /* loop if not zero */
    /* offset 80 */ add     #4,r4                /* [delay slot] dest += 4 */
    /* offset 82 */ dt      r2                   /* row-- */
    /* offset 84 */ bf/s    .spr_row             /* next row */
    /* offset 86 */ add     r6,r0                /* [delay slot] dest base += stride */

    /* === ENTITY DATA VALIDATION (Phase 3A) === */
    /* cmd $3E already transferred 256B entity to $0600F20C via DREQ.         */
    /* Read first longword from entity working copy as canary verification.    */
    /* offset 88 */ mov.l   @(.ent_dst,pc),r4    /* R4 = $2200F20C */
    /* offset 90 */ mov.l   @r4,r0               /* R0 = entity[0..3] */
    /* Write to canary location for profiler verification */
    /* offset 92 */ mov.l   @(.canary_addr,pc),r4 /* R4 = $2200FC00 */
    /* offset 94 */ mov.l   r0,@r4               /* canary = entity first longword */
    /* Also write $DEADBEEF at +4 to confirm handler reached this point */
    /* offset 96 */ mov.l   @(.canary_val,pc),r0  /* R0 = $DEADBEEF */
    /* offset 98 */ mov.l   r0,@(4,r4)            /* canary+4 = $DEADBEEF */

    /* === COMPLETION: inline COMM cleanup (func_084 equivalent) === */
    /* Reload COMM base (clobbered during copy loops) */
    /* offset 110 */ mov.l  @(.comm_base,pc),r8  /* R8 = $20004020 */

    /* Clear COMM1, set "command done" bit */
    /* offset 112 */ mov    #0,r0
    /* offset 114 */ mov.w  r0,@(2,r8)           /* COMM1 = $0000 */
    /* offset 116 */ mov.b  @(3,r8),r0           /* R0 = COMM1_LO (0) */
    /* offset 118 */ or     #1,r0                /* R0 |= 1 */
    /* offset 120 */ mov.b  r0,@(3,r8)           /* COMM1_LO = 1 ("done") */

    /* Clear COMM0_HI (idle — allows next COMM0 command) */
    /* offset 122 */ mov    #0,r0
    /* offset 124 */ mov.b  r0,@(0,r8)           /* COMM0_HI = 0 */

    /* === RETURN === */
    /* offset 126 */ lds.l  @r15+,pr
    /* offset 128 */ rts
    /* offset 130 */ nop                         /* delay slot */

/* === LITERAL POOL ===
 * Code ends at offset 132.
 * All longword entries must be 4-byte aligned.
 */
.align 2
.mailbox_addr:
    .long   0x2200BC00              /* SDRAM mailbox (cache-through) */
.geo_src:
    .long   0x06038000              /* Geometry source (SDRAM, native read) */
.geo_dst:
    .long   0x04012010              /* Geometry dest (framebuffer, cached write) */
.spr_src:
    .long   0x0603B600              /* Sprite source (SDRAM, native read) */
.spr_dst:
    .long   0x0401B010              /* Sprite dest (framebuffer, cached write) */
.ent_dst:
    .long   0x2200F20C              /* VR60 entity working copy (cache-through, written by cmd $3E) */
.canary_addr:
    .long   0x2200FC00              /* Validation canary location */
.canary_val:
    .long   0xDEADBEEF              /* Canary value */
.comm_base:
    .long   0x20004020              /* COMM register base (cache-through) */

/* Total: ~100 bytes code + pad + 32 bytes pool = ~136 bytes (Phase 1A entity copy removed, Phase 3A canary added) */

.global cmd3f_vr60_gameframe
