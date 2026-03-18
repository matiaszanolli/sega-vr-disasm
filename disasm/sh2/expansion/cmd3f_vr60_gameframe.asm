/*
 * cmd3f_vr60_gameframe — VR60 Game Frame Handler (Phase 1B: COMM Relay + SDRAM Validation)
 * Expansion ROM Address: $301500 (SH2: $02301500)
 *
 * Reads game state from COMM3-5 (written by 68K vr60_comm_trigger),
 * copies to SDRAM mailbox at $2200BC00, then copies 480 bytes of entity
 * visibility data from $2200C800 to $2200F20C, writes validation canary.
 *
 * COMM protocol (follows cmd22 proven pattern: read ALL params BEFORE clearing COMM0_LO):
 *   R8 = $20004020 (COMM base, cache-through, set by dispatch loop)
 *   Read COMM3  @(6,R8)  = frame_counter   → mailbox +$06
 *   Read COMM4  @(8,R8)  = game_state      → mailbox +$08
 *   Read COMM5  @(10,R8) = frame_toggle    → mailbox +$0A
 *   THEN clear COMM0_LO (params consumed signal)
 *
 * Evidence for param-read-before-clear pattern:
 *   cmd22_single_shot.asm:109 "ALL COMM params into registers BEFORE signaling consumed"
 *   cmd22_single_shot.asm:123-125 (clear COMM0_LO after all reads)
 *
 * SDRAM addresses (all cache-through for cross-CPU visibility):
 *   Mailbox:  $2200BC00  (+$06=frame_counter, +$08=game_state, +$0A=frame_toggle)
 *   Source:   $2200C800  (entity visibility table, 32 × 16B)
 *   Dest:     $2200F20C  (VR60 entity mirror, verified free: VR60_ROADMAP.md §5.2)
 *   Canary:   $2200FC00  ($DEADBEEF)
 *
 * Entry: R8 = $20004020
 * Clobbers: R0-R5
 * Preserves: R6-R7, R15 (R8 reloaded)
 */

.section .text
.align 2

cmd3f_vr60_gameframe:
    /* Save PR */
    /* offset  0 */ sts.l   pr,@-r15

    /* === PARAM READ: read ALL COMM params BEFORE clearing COMM0_LO === */
    /* (follows cmd22 proven pattern — cmd22_single_shot.asm:110-121) */
    /* SH2 constraint: mov.w @(disp,Rn) dest must be R0 (ISA restriction) */
    /* offset  2 */ mov.w   @(6,r8),r0           /* R0 = COMM3 */
    /* offset  4 */ mov     r0,r1                /* R1 = frame_counter */
    /* offset  6 */ mov.w   @(8,r8),r0           /* R0 = COMM4 */
    /* offset  8 */ mov     r0,r2                /* R2 = game_state */
    /* offset 10 */ mov.w   @(10,r8),r0          /* R0 = COMM5 */
    /* offset 12 */ mov     r0,r3                /* R3 = frame_toggle */

    /* === PARAMS-CONSUMED SIGNAL (after all reads) === */
    /* offset  8 */ mov     #0,r0
    /* offset 10 */ mov.b   r0,@(1,r8)           /* COMM0_LO = $00 */

    /* === WRITE COMM DATA TO SDRAM MAILBOX === */
    /* SH2 constraint: mov.w @(disp,Rn) requires R0 as source (ISA restriction) */
    /* Displacement is byte offset; Gas divides by 2 internally (CLAUDE.md note) */
    /* offset 12 */ mov.l   @(.mailbox_addr,pc),r4  /* R4 = $2200BC00 */
    /* offset 14 */ mov     r1,r0                /* R0 = frame_counter */
    /* offset 16 */ mov.w   r0,@(6,r4)           /* mailbox+$06 = frame_counter */
    /* offset 18 */ mov     r2,r0                /* R0 = game_state */
    /* offset 20 */ mov.w   r0,@(8,r4)           /* mailbox+$08 = game_state */
    /* offset 22 */ mov     r3,r0                /* R0 = frame_toggle */
    /* offset 24 */ mov.w   r0,@(10,r4)          /* mailbox+$0A = frame_toggle */

    /* === MEMCPY: $2200C800 → $2200F20C (480 bytes = 120 longwords) === */
    /* offset 26 */ mov.l   @(.src_addr,pc),r3   /* R3 = $2200C800 */
    /* offset 28 */ mov.l   @(.dst_addr,pc),r4   /* R4 = $2200F20C */
    /* offset 30 */ mov     #120,r5              /* R5 = 120 longwords */

.copy_loop:
    /* offset 32 */ mov.l   @r3+,r0              /* R0 = *src++ */
    /* offset 34 */ mov.l   r0,@r4               /* *dst = R0 */
    /* offset 36 */ dt      r5                   /* R5-- and test zero */
    /* offset 38 */ bf/s    .copy_loop           /* loop if not zero */
    /* offset 40 */ add     #4,r4                /* [delay slot] dst += 4 */

    /* === WRITE VALIDATION CANARY === */
    /* offset 42 */ mov.l   @(.canary_addr,pc),r4 /* R4 = $2200FC00 */
    /* offset 44 */ mov.l   @(.canary_val,pc),r0  /* R0 = $DEADBEEF */
    /* offset 46 */ mov.l   r0,@r4               /* *canary = $DEADBEEF */

    /* === COMPLETION: inline COMM cleanup (func_084 equivalent) === */
    /* offset 48 */ mov.l   @(.comm_base,pc),r8  /* R8 = $20004020  (48%4=0, aligned) */

    /* Clear COMM1, set "command done" bit */
    /* offset 50 */ mov     #0,r0
    /* offset 52 */ mov.w   r0,@(2,r8)           /* COMM1 = $0000 */
    /* offset 54 */ mov.b   @(3,r8),r0           /* R0 = COMM1_LO (0) */
    /* offset 56 */ or      #1,r0                /* R0 |= 1 */
    /* offset 58 */ mov.b   r0,@(3,r8)           /* COMM1_LO = 1 ("done") */

    /* Clear COMM0_HI */
    /* offset 60 */ mov     #0,r0
    /* offset 62 */ mov.b   r0,@(0,r8)           /* COMM0_HI = 0 */

    /* === RETURN === */
    /* offset 64 */ lds.l   @r15+,pr
    /* offset 66 */ rts
    /* offset 68 */ nop                          /* delay slot */

/* === LITERAL POOL ===
 * Code ends at offset 70.
 * Alignment: offset 70 is even but not 4-aligned → 2 bytes padding.
 */
.align 2
.mailbox_addr:
    .long   0x2200BC00              /* SDRAM mailbox (cache-through) */
.src_addr:
    .long   0x2200C800              /* Entity visibility table (cache-through) */
.dst_addr:
    .long   0x2200F20C              /* VR60 entity mirror area (cache-through) */
.canary_addr:
    .long   0x2200FC00              /* Validation canary location */
.canary_val:
    .long   0xDEADBEEF              /* Canary value */
.comm_base:
    .long   0x20004020              /* COMM register base (cache-through) */

/* Total: 76 bytes code + 0 bytes pad + 24 bytes pool = 100 bytes (estimate, verify with assembler) */

.global cmd3f_vr60_gameframe
