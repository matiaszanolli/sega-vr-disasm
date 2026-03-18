/*
 * cmd3f_vr60_gameframe — VR60 Game Frame Handler (Phase 0: Infrastructure)
 * Expansion ROM Address: $301500 (SH2: $02301500)
 *
 * Phase 0: No-op handler that proves the infrastructure works.
 * Reads the SDRAM mailbox at $0600BC00 (cache-through: $2200BC00),
 * signals completion, and returns.
 *
 * Future phases will add game logic (physics, AI, collision) here.
 *
 * COMM Protocol (cmd $3F):
 *   68K writes:
 *     COMM0_LO = $3F (dispatch index)
 *     COMM0_HI = $01 (trigger, written LAST)
 *   SH2 reads:
 *     SDRAM mailbox at $2200BC00 (controller input, scene commands)
 *   SH2 signals:
 *     COMM0_LO = $00 (params consumed)
 *     COMM1_LO bit 0 = 1 (command done)
 *     COMM0_HI = $00 (idle)
 *
 * SDRAM Mailbox Layout ($0600BC00, 16 bytes):
 *   +$00: controller_input_p1 (word)
 *   +$02: controller_input_p2 (word)
 *   +$04: scene_command (word)
 *   +$06: frame_counter (word)
 *   +$08: game_state (word)
 *   +$0A: race_substate (word)
 *   +$0C: sound_cmd_queue (longword, 4 bytes for queued sound commands)
 *
 * Entry: R8 = $20004020 (COMM base, set by dispatch loop)
 * Clobbers: R0, R1
 * Preserves: R2-R7, R8 (reloaded), R15
 */

.section .text
.align 2

cmd3f_vr60_gameframe:
    /* Save PR */
    /* offset  0 */ sts.l   pr,@-r15

    /* === PARAMS-CONSUMED SIGNAL === */
    /* Clear COMM0_LO immediately (68K .wait_consumed exits) */
    /* offset  2 */ mov     #0,r0
    /* offset  4 */ mov.b   r0,@(1,r8)          /* COMM0_LO = $00 */

    /* === READ SDRAM MAILBOX (proof-of-concept) === */
    /* Read controller input from cache-through SDRAM */
    /* offset  6 */ mov.l   @(.mailbox_addr,pc),r1  /* R1 = $2200BC00 */
    /* offset  8 */ mov.w   @r1,r0               /* R0 = controller_input_p1 (ignored for now) */

    /* === COMPLETION: inline COMM cleanup (func_084 equivalent) === */
    /* Reload COMM base (R8 may still be valid but be safe) */
    /* offset 10 */ nop                          /* align for .comm_base MOV.L */
    /* offset 12 */ mov.l   @(.comm_base,pc),r8  /* R8 = $20004020 */

    /* Clear COMM1, set "command done" bit */
    /* offset 14 */ mov     #0,r0
    /* offset 16 */ mov.w   r0,@(2,r8)           /* COMM1 = $0000 */
    /* offset 18 */ mov.b   @(3,r8),r0           /* R0 = COMM1_LO (just cleared = 0) */
    /* offset 20 */ or      #1,r0                /* R0 |= 1 (set bit 0: "done") */
    /* offset 22 */ mov.b   r0,@(3,r8)           /* COMM1_LO = 1 */

    /* Clear COMM0_HI (handler complete, dispatch loop can poll again) */
    /* offset 24 */ mov     #0,r0
    /* offset 26 */ mov.b   r0,@(0,r8)           /* COMM0_HI = 0 */

    /* === RETURN === */
    /* offset 28 */ lds.l   @r15+,pr
    /* offset 30 */ rts
    /* offset 32 */ nop                          /* delay slot */

/* === LITERAL POOL ===
 * Code ends at offset 34 (17 instructions × 2B = 34B).
 * Alignment: offset 34 is even but not 4-aligned.
 * Add padding for 4-byte alignment.
 */
.align 2
.mailbox_addr:
    .long   0x2200BC00              /* SDRAM mailbox (cache-through) */
.comm_base:
    .long   0x20004020              /* COMM register base (cache-through) */

/* Total: 34 bytes code + 2 bytes pad + 8 bytes pool = 44 bytes */

.global cmd3f_vr60_gameframe
