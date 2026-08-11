/*
 * Q-020 mode-1 validation-only Master external-interrupt/DREQ handler.
 *
 * Fixed link address: ROM $303B00 / SH2 $02303B00.
 *
 * Hardware model:
 *   - Supplement 2 maps every external vector to one entry, dispatches by the
 *     saved SR level, toggles FRT/TOCR bit 1 in every external ISR, and requires
 *     a same-address read after clearing the interrupt source.
 *   - 32X DREQ CPU-write mode exposes 68S, the descriptive destination, and the
 *     live word count to SH2.  FULL is checked by the 68K every four words.
 *   - SH7604 CHCR.TE must be read as 1 and then written as 0 before re-arm.
 *
 * The mode-1 transaction accesses no COMM register.  A setup CMD is recognized
 * only by 68S=1, LEN=$20, destination=$0600F30C, and either a stock-idle or
 * stock-finalization-quiescent saved SPC.  A completion CMD is instead
 * admitted by the exact active DMAC0 identity: the 68K remains blocked between
 * edges, so no later producer can own that signature.  It waits for
 * TCR=0/TE=1.  Cold boot reaches the stock initialization tail via
 * the startup shim without a CMD edge.  Only the phase-pinned post-VRES CMD
 * delegates to the stock reset-flow continuation; VRES always delegates to
 * stock.  Any other CMD, external level, or partial mode-1 signature records a
 * failure and stops.
 *
 * Persistent trace block at cache-through $2600BC20 (16 longwords):
 *   +00 magic "Q21I"       +04 phase (0/3 reset-CMD expected/4 complete/fail)
 *   +08 external sequence  +0C setup count
 *   +10 completion count   +14 VRES count
 *   +18 stock CMD count    +1C error
 *   +20 last SR            +24 last SPC
 *   +28 exact pre-mask     +2C last event (1 setup,2 completion,3 VRES,4 stock)
 *   +30 init count         +34 accepted setup SPC
 *   +38 completion SPC     +3C magic inverse
 */

.section .text
.align 2
.global cmd3e_mode1_validation
.global q020_mode1_cmdint_init

cmd3e_mode1_validation:
    sts.l   pr,@-r15
    mov.l   r0,@-r15
    mov.l   r1,@-r15
    mov.l   r2,@-r15
    mov.l   r3,@-r15
    mov.l   r4,@-r15
    mov.l   r5,@-r15
    mov.l   r6,@-r15
    mov.l   r7,@-r15

    /* Required corrective action on every external interrupt entry. */
    mov.l   @(.L_frt_base,pc),r1
    mov.b   @(7,r1),r0
    xor     #2,r0
    mov.b   r0,@(7,r1)

    stc     sr,r4
    mov     r4,r0
    shlr2   r0
    and     #0x3c,r0
    cmp/eq  #0x20,r0              /* level 8: CMD */
    bt      .L_cmd
    cmp/eq  #0x38,r0              /* level 14: VRES */
    bt      .L_vres
    bra     .L_unexpected_external
    nop

.L_vres:
    mov.l   @(.L_trace_base,pc),r3
    bsr     .L_require_trace
    nop
    tst     r2,r2
    bf      .L_bad_trace
    bsr     .L_capture_common
    nop
    mov.l   @(20,r3),r0
    add     #1,r0
    mov.l   r0,@(20,r3)
    mov     #0,r0
    mov.l   r0,@(28,r3)
    mov     #3,r0
    mov.l   r0,@(44,r3)
    mov.l   r0,@(4,r3)            /* next CMD belongs to stock reset flow */
    mov.l   @(44,r3),r0           /* synchronize trace before stock VRES */
    mov.l   @(.L_stock_vres,pc),r0
    jmp     @r0
    nop

.L_cmd:
    mov.l   @(.L_trace_base,pc),r3
    bsr     .L_require_trace
    nop
    tst     r2,r2
    bf      .L_bad_trace
    bsr     .L_capture_common
    nop

    /* VRES's reset-flow CMD must never be mistaken for a mode-1 edge. */
    mov.l   @(4,r3),r0
    cmp/eq  #3,r0
    bt      .L_stock_reset_cmd

    /* Classify by the SH2-readable DREQ control and length registers. */
    mov.l   @(.L_dreq_ctrl,pc),r1
    mov.w   @r1,r0
    extu.w  r0,r0
    tst     #4,r0
    bt      .L_possible_completion

    /* 68S=1 is reserved to the exact setup signature in this isolated ROM. */
    mov.l   @(.L_dreq_len,pc),r1
    mov.w   @r1,r0
    extu.w  r0,r0
    cmp/eq  #0x20,r0
    bf      .L_bad_setup_signature
    bsr     .L_require_destination_signature
    nop
    tst     r2,r2
    bf      .L_bad_setup_signature
    bsr     .L_require_idle_spc
    nop
    tst     r2,r2
    bf      .L_bad_idle_spc
    bra     .L_setup
    mov.l   @(36,r3),r0              /* delay slot: accepted setup SPC */

.L_possible_completion:
    mov.l   @(.L_dreq_len,pc),r1
    mov.w   @r1,r0
    extu.w  r0,r0
    tst     r0,r0
    bf      .L_stock_cmd
    bsr     .L_require_destination_signature
    nop
    tst     r2,r2
    bf      .L_stock_cmd
    bsr     .L_require_active_dmac_identity
    nop
    tst     r2,r2
    bf      .L_stock_cmd
    bra     .L_completion
    mov.l   @(36,r3),r0              /* delay slot: accepted completion SPC */

.L_setup:
    mov.l   r0,@(52,r3)              /* retain accepted setup boundary */
    nop                               /* preserve fixed bridge-literal layout */
    /*
     * A preceding stock FIFO transfer may have completed with CHCR0.TE still
     * set.  Preserve the documented read-1/write-0 lifecycle before writing a
     * new SAR/DAR/TCR.  TE=0/DE=1 is allowed only while waiting for that final
     * stock transfer end; all mode bits and IE must already equal $44E0.
     */
    mov.l   @(.L_chcr0,pc),r1
.L_wait_prior_te_or_idle:
    mov.l   @r1,r0
    mov     r0,r2
    mov.l   @(.L_chcr_mode_mask,pc),r5
    and     r5,r2
    mov.l   @(.L_chcr_idle,pc),r5
    cmp/eq  r5,r2
    bf      .L_bad_prior_chcr
    tst     #2,r0
    bf      .L_clear_prior_te
    tst     #1,r0
    bt      .L_prior_idle
    bra     .L_wait_prior_te_or_idle
    nop
.L_clear_prior_te:
    mov.l   r5,@r1                  /* prior read observed TE=1; write TE=0 */
    mov.l   @r1,r0
    cmp/eq  r5,r0
    bf      .L_bad_prior_chcr
.L_prior_idle:

    mov.l   @(.L_sar0,pc),r1
    mov.l   @(.L_fifo,pc),r0
    mov.l   r0,@r1
    mov.l   @(.L_dar0,pc),r1
    mov.l   @(.L_globals_dst,pc),r0
    mov.l   r0,@r1
    mov.l   @(.L_tcr0,pc),r1
    mov     #0x20,r0
    mov.l   r0,@r1
    mov.l   @(.L_chcr0,pc),r1
    mov.l   @(.L_chcr_active,pc),r0
    mov.l   r0,@r1
    mov.l   @(.L_dmaor,pc),r1
    mov     #1,r0
    mov.l   r0,@r1
    mov.l   @r1,r0                  /* same-address DMAOR synchronization */
    cmp/eq  #1,r0
    bf      .L_bad_dmaor

    mov.l   @(12,r3),r0
    add     #1,r0
    mov.l   r0,@(12,r3)
    mov     #1,r0
    mov.l   r0,@(44,r3)
    bsr     .L_ack_cmd
    nop
    bra     .L_return
    nop

.L_completion:
    mov.l   r0,@(56,r3)              /* completion owns +$38 exclusively */
    /* LEN/68S may lead the final DMAC write; wait for normal TCR=0/TE=1. */
    mov.l   @(.L_chcr0,pc),r1
.L_wait_mode1_te:
    mov.l   @r1,r0
    mov.l   @(.L_chcr_te,pc),r2
    cmp/eq  r2,r0
    bt      .L_mode1_te_seen
    mov.l   @(.L_chcr_active,pc),r2
    cmp/eq  r2,r0
    bf      .L_bad_completion_chcr
    bra     .L_wait_mode1_te
    nop
.L_mode1_te_seen:
    mov.l   @(.L_tcr0,pc),r1
    mov.l   @r1,r0
    tst     r0,r0
    bf      .L_bad_completion_tcr
    mov.l   @(.L_dar0,pc),r1
    mov.l   @r1,r0
    mov.l   @(.L_globals_end,pc),r2
    cmp/eq  r2,r0
    bf      .L_bad_completion_dar

    /* The CHCR read above observed TE=1.  Write 0 to TE and DE, then prove it. */
    mov.l   @(.L_chcr0,pc),r1
    mov.l   @(.L_chcr_idle,pc),r0
    mov.l   r0,@r1
    mov.l   @r1,r2
    cmp/eq  r0,r2
    bf      .L_bad_completion_ack

    mov.l   @(16,r3),r0
    add     #1,r0
    mov.l   r0,@(16,r3)
    mov     #2,r0
    mov.l   r0,@(44,r3)
    bsr     .L_ack_cmd
    nop
    bra     .L_return
    nop

.L_stock_reset_cmd:
    mov.l   @(24,r3),r0
    add     #1,r0
    mov.l   r0,@(24,r3)
    mov     #4,r0
    mov.l   r0,@(44,r3)
    mov.l   r0,@(4,r3)
    mov.l   @(4,r3),r0
    mov.l   @(.L_sys_mask,pc),r1       /* stock continuation requires SYS base */
    mov.l   @(.L_stock_cmd_boot,pc),r0
    jmp     @r0
    nop

.L_stock_cmd:
    /* Only the phase-pinned VRES reset CMD may delegate in this ROM. */
    bra     .L_fail
    mov     #0x31,r2

/* Mask only CMD, clear/synchronize it, then restore/read back the exact word. */
.L_ack_cmd:
    /*
     * Preserve the pre-existing external MOV.L-PC literal ownership at ROM
     * $303CB4 (user $3039FC).  Every padding word is unreachable behind this
     * branch; the explicitly labeled final longword remains the exact
     * externally-owned $FFFFFFFF.
     */
    bra     .L_ack_cmd_body
    nop
    .long   0xFFFFFFFF
.L_bridge_literal:
    .long   0xFFFFFFFF
    .long   0xFFFFFFFF
    .long   0xFFFFFFFF
.L_external_owned_literal:
    .long   0xFFFFFFFF              /* fixed ROM $303CB4, user $3039FC */
.L_ack_cmd_body:
    mov.l   @(.L_sys_mask,pc),r1
    mov.w   @r1,r0
    extu.w  r0,r0
    mov.l   r0,@(40,r3)
    mov     #-3,r2
    and     r2,r0
    mov.w   r0,@r1
    mov.w   @r1,r0
    tst     #2,r0
    bf      .L_mask_fail

    mov.l   @(.L_cmd_clear,pc),r1
    mov     #0,r0
    mov.w   r0,@r1
    mov.w   @r1,r0                   /* synchronization; value is unspecified */

    mov.l   @(.L_sys_mask,pc),r1
    mov.l   @(40,r3),r2
    mov.w   r2,@r1
    mov.w   @r1,r0
    extu.w  r0,r0
    cmp/eq  r2,r0
    bf      .L_restore_fail
    rts
    nop

.L_require_destination_signature:
    /* DREQ stores the SDRAM-relative 24-bit form $00:F30C. */
    mov     #0,r2
    mov.l   @(.L_dreq_dst_hi,pc),r1
    mov.w   @r1,r0
    extu.w  r0,r0
    mov.l   @(.L_dst_hi,pc),r5
    cmp/eq  r5,r0
    bf      .L_destination_bad
    mov.l   @(.L_dreq_dst_lo,pc),r1
    mov.w   @r1,r0
    extu.w  r0,r0
    mov.l   @(.L_dst_lo,pc),r5
    cmp/eq  r5,r0
    bt      .L_destination_done
.L_destination_bad:
    mov     #1,r2
.L_destination_done:
    rts
    nop

.L_require_active_dmac_identity:
    mov     #0,r2
    mov.l   @(12,r3),r0
    mov.l   @(16,r3),r1
    add     #1,r1
    cmp/eq  r1,r0
    bf      .L_dmac_identity_bad
    mov.l   @(.L_sar0,pc),r1
    mov.l   @r1,r0
    mov.l   @(.L_fifo,pc),r5
    cmp/eq  r5,r0
    bf      .L_dmac_identity_bad
    mov.l   @(.L_dar0,pc),r1
    mov.l   @r1,r0
    mov.l   @(.L_globals_dst,pc),r5
    cmp/hi  r0,r5                     /* start > current is invalid */
    bt      .L_dmac_identity_bad
    mov.l   @(.L_globals_end,pc),r5
    cmp/hi  r5,r0                     /* current > end is invalid */
    bt      .L_dmac_identity_bad
    mov.l   @(.L_tcr0,pc),r1
    mov.l   @r1,r0
    mov     #0x20,r5
    cmp/hi  r5,r0
    bt      .L_dmac_identity_bad
    mov.l   @(.L_chcr0,pc),r1
    mov.l   @r1,r0
    mov.l   @(.L_chcr_active,pc),r5
    cmp/eq  r5,r0
    bt      .L_dmac_chcr_ok
    mov.l   @(.L_chcr_te,pc),r5
    cmp/eq  r5,r0
    bf      .L_dmac_identity_bad
.L_dmac_chcr_ok:
    mov.l   @(.L_dmaor,pc),r1
    mov.l   @r1,r0
    cmp/eq  #1,r0
    bt      .L_dmac_identity_done
.L_dmac_identity_bad:
    mov     #1,r2
.L_dmac_identity_done:
    rts
    nop

.L_require_idle_spc:
    mov     #0,r2
    mov.l   @(12,r3),r0
    mov.l   @(16,r3),r1
    cmp/eq  r1,r0
    bf      .L_idle_spc_bad
    mov.l   @(36,r3),r0
    mov.l   @(.L_idle_460,pc),r1
    cmp/eq  r1,r0
    bt      .L_idle_spc_done
    add     #2,r1
    cmp/eq  r1,r0
    bt      .L_idle_spc_done
    add     #2,r1
    cmp/eq  r1,r0
    bt      .L_idle_spc_done
    add     #2,r1
    cmp/eq  r1,r0
    bt      .L_idle_spc_done
    add     #0x0e,r1                  /* $466 -> $474 post-handler branch */
    cmp/eq  r1,r0
    bt      .L_idle_spc_done
    add     #2,r1                     /* $476 branch delay slot */
    cmp/eq  r1,r0
    bt      .L_idle_spc_done
    /*
     * $06004438-$06004442 is func_087, the penultimate scene-finalize
     * COMM2-zero wait.  Stock DMAC/DREQ work is already terminal here and
     * only the VDP-status wait at $060043E0 follows before completion.  Keep
     * every instruction boundary explicit; no neighboring handler PC is safe.
     */
    mov.l   @(.L_quiescent_438,pc),r1
    cmp/hs  r1,r0                     /* SPC >= $06004438 */
    bf      .L_idle_spc_bad
    mov     r0,r5
    sub     r1,r5
    mov     #0x0a,r1
    cmp/hi  r1,r5                     /* offset > $0A is outside */
    bt      .L_idle_spc_bad
    mov     r5,r0
    tst     #1,r0                     /* only even instruction boundaries */
    bt      .L_idle_spc_done
.L_idle_spc_bad:
    mov     #1,r2
.L_idle_spc_done:
    mov.l   @(.L_tcr0,pc),r1
    mov.l   @r1,r0
    tst     r0,r0
    bt      .L_idle_spc_return
    mov     #1,r2
.L_idle_spc_return:
    rts
    nop

.L_require_trace:
    mov     #0,r2
    mov.l   @r3,r0
    mov.l   @(.L_magic,pc),r1
    cmp/eq  r1,r0
    bf      .L_trace_bad
    mov.l   @(60,r3),r0
    mov.l   @(.L_magic_inverse,pc),r1
    cmp/eq  r1,r0
    bt      .L_trace_ok
.L_trace_bad:
    mov     #1,r2
.L_trace_ok:
    rts
    nop

.L_capture_common:
    mov.l   @(8,r3),r0
    add     #1,r0
    mov.l   r0,@(8,r3)
    mov.l   r4,@(32,r3)
    mov.l   @(36,r15),r0             /* hardware SPC below nine saved longs */
    mov.l   r0,@(36,r3)
    nop                               /* +$38 changes only on accepted completion */
    rts
    nop

.L_bad_trace:             bra .L_fail; mov #0x11,r2
.L_bad_setup_signature:   bra .L_fail; mov #0x12,r2
.L_bad_idle_spc:          bra .L_fail; mov #0x13,r2
.L_bad_sequence:          bra .L_fail; mov #0x14,r2
.L_bad_prior_chcr:        bra .L_fail; mov #0x21,r2
.L_bad_dmaor:             bra .L_fail; mov #0x22,r2
.L_bad_completion_chcr:   bra .L_fail; mov #0x23,r2
.L_bad_completion_tcr:    bra .L_fail; mov #0x24,r2
.L_bad_completion_dar:    bra .L_fail; mov #0x25,r2
.L_bad_completion_ack:    bra .L_fail; mov #0x26,r2
.L_mask_fail:             bra .L_fail; mov #0x27,r2
.L_restore_fail:          bra .L_fail; mov #0x28,r2

.L_fail:
    mov.l   r2,@(28,r3)
    mov     #0x7f,r0
    mov.l   r0,@(44,r3)
    mov.l   @(.L_failure_phase,pc),r0
    mov.l   r0,@(4,r3)
    mov.l   @(4,r3),r0
    bra     .L_hard_stop
    nop

.L_unexpected_external:
    mov.l   @(.L_trace_base,pc),r3
    mov.l   r4,@(32,r3)
    mov.l   @(36,r15),r0
    mov.l   r0,@(36,r3)
    mov     #0x7e,r0
    mov.l   r0,@(28,r3)
    mov     #0x7f,r0
    mov.l   r0,@(44,r3)
    mov.l   @(.L_failure_phase,pc),r0
    mov.l   r0,@(4,r3)
    mov.l   @(4,r3),r0
.L_hard_stop:
    bra     .L_hard_stop
    nop

.L_return:
    mov.l   @r15+,r7
    mov.l   @r15+,r6
    mov.l   @r15+,r5
    mov.l   @r15+,r4
    mov.l   @r15+,r3
    mov.l   @r15+,r2
    mov.l   @r15+,r1
    mov.l   @r15+,r0
    lds.l   @r15+,pr
    rte
    nop                              /* explicit harmless RTE delay slot */

/*
 * Startup shim at fixed $02303E60.  It cannot use R15/PR because the stock
 * startup call precedes application-stack assignment.  Cold boot initializes
 * the trace; VRES preserves it and increments twice through the stock startup
 * chronology (direct VRES continuation, then reset-flow CMD continuation).
 */
.org 0x360
q020_mode1_cmdint_init:
    nop                              /* startup entry witness; no stack use */
    mov.l   @(.L_init_trace,pc),r1
    mov.l   @r1,r0
    mov.l   @(.L_init_magic,pc),r2
    cmp/eq  r2,r0
    bf      .L_init_clear
    mov.l   @(60,r1),r0
    mov.l   @(.L_init_inverse,pc),r2
    cmp/eq  r2,r0
    bt      .L_init_count
.L_init_clear:
    mov     r1,r2
    mov     #0,r0
    mov     #16,r3
.L_init_clear_loop:
    mov.l   r0,@r2
    add     #4,r2
    dt      r3
    bf      .L_init_clear_loop
    mov.l   @(.L_init_magic,pc),r0
    mov.l   r0,@r1
    mov.l   @(.L_init_inverse,pc),r0
    mov.l   r0,@(60,r1)
.L_init_count:
    mov.l   @(48,r1),r0
    add     #1,r0
    mov.l   r0,@(48,r1)
    mov.l   @(48,r1),r0
    mov.l   @(.L_original_init,pc),r0
    jmp     @r0
    nop

.align 2
.L_init_trace:       .long 0x2600BC20
.L_init_magic:       .long 0x51323149
.L_init_inverse:     .long 0xAECDCEB6
.L_original_init:    .long 0x060045CC

.align 2
.L_frt_base:         .long 0xFFFFFE10
.L_trace_base:       .long 0x2600BC20
.L_sys_mask:         .long 0x20004000
.L_dreq_ctrl:        .long 0x20004006
.L_dreq_dst_hi:      .long 0x2000400C
.L_dreq_dst_lo:      .long 0x2000400E
.L_dreq_len:         .long 0x20004010
.L_cmd_clear:        .long 0x2000401A
.L_sar0:             .long 0xFFFFFF80
.L_fifo:             .long 0x20004012
.L_dar0:             .long 0xFFFFFF84
.L_tcr0:             .long 0xFFFFFF88
.L_chcr0:            .long 0xFFFFFF8C
.L_dmaor:            .long 0xFFFFFFB0
.L_dst_hi:           .long 0x00000000
.L_dst_lo:           .long 0x0000F30C
.L_globals_dst:      .long 0x0600F30C
.L_globals_end:      .long 0x0600F34C
.L_chcr_active:      .long 0x000044E1
.L_chcr_te:          .long 0x000044E3
.L_chcr_idle:        .long 0x000044E0
.L_chcr_mode_mask:   .long 0xFFFFFFFC
.L_idle_460:         .long 0x06000460
.L_quiescent_438:    .long 0x06004438
.L_stock_vres:       .long 0x060004A4
.L_stock_cmd_boot:   .long 0x060004E8
.L_magic:            .long 0x51323149
.L_magic_inverse:    .long 0xAECDCEB6
.L_failure_phase:    .long 0x80000001
