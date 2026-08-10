/*
 * Q-020 validation-only Master SH2 external-interrupt probe.
 *
 * Fixed placement:
 *   ROM file  $303B00
 *   SH2       $02303B00
 *
 * Supplement 2 requires every external vector to reach one entry and every
 * entry to perform the FRT workaround.  The stock Master enables only CMD;
 * VRES is unmaskable.  There is no stock generic Master dispatcher to which
 * V/H/PWM can safely be delegated, so any third level records a failure and
 * stops.  This is deliberately a non-promotable probe.
 *
 * Persistent trace block (cache-through writes):
 *   $2600BC20 +00 magic          "Q20P"
 *             +04 phase          0=CMD expected, 2=CMD complete,
 *                                3=post-VRES boot CMD expected,
 *                                4=post-VRES boot CMD complete,
 *                                $80000001=failure
 *             +08 sequence
 *             +0C CMD count
 *             +10 VRES count
 *             +14 error code
 *             +18 last SR
 *             +1C last SPC
 *             +20 pre-mask SYS register
 *             +24 COMM0/COMM1 snapshot
 *             +28 last event      2=diagnostic CMD, 3=VRES,
 *                                 4=post-VRES boot CMD, $7F=failure
 *             +2C init count      cold boot plus each stock VRES re-init
 *             +30 magic inverse
 *             +34..+3F reserved
 */

.section .text
.align 2
.global q020_cmdint_probe_isr
.global q020_cmdint_probe_init

q020_cmdint_probe_isr:
    sts.l   pr,@-r15
    mov.l   r0,@-r15
    mov.l   r1,@-r15
    mov.l   r2,@-r15
    mov.l   r3,@-r15
    mov.l   r4,@-r15

    /* Required on every external interrupt; SH7604 TOCR is byte FFFFFE17. */
    mov.l   @(.L_frt_base,pc),r1
    mov.b   @(7,r1),r0
    xor     #2,r0
    mov.b   r0,@(7,r1)

    /* External level = (current ISR SR >> 4) & $0f, represented as level*4. */
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
    mov.l   @(16,r3),r0
    add     #1,r0
    mov.l   r0,@(16,r3)
    mov     #0,r0
    mov.l   r0,@(20,r3)
    mov     #3,r0
    mov.l   r0,@(40,r3)
    mov.l   r0,@(4,r3)            /* publish reset-CMD expectation */
    mov.l   @(40,r3),r0           /* synchronize trace before reset clear */
    mov.l   @(.L_stock_vres,pc),r0
    jmp     @r0                   /* stock clears VRES and rejoins init */
    nop

.L_cmd:
    mov.l   @(.L_trace_base,pc),r3
    bsr     .L_require_trace
    nop
    tst     r2,r2
    bf      .L_bad_trace
    mov.l   @(4,r3),r0
    tst     r0,r0
    bt      .L_diagnostic_cmd
    cmp/eq  #3,r0
    bt      .L_reset_boot_cmd
    cmp/eq  #4,r0
    bf      .L_bad_phase
.L_diagnostic_cmd:
    bsr     .L_capture_common
    nop
    mov.l   @(12,r3),r0
    add     #1,r0
    mov.l   r0,@(12,r3)
    mov     #0,r0
    mov.l   r0,@(20,r3)
    mov     #2,r0
    mov.l   r0,@(40,r3)

    /* Mask only CMD while preserving all other per-CPU/system bits. */
    mov.l   @(.L_sys_mask,pc),r1
    mov.w   @r1,r0
    extu.w  r0,r0
    mov.l   r0,@(32,r3)
    mov     #-3,r2
    and     r2,r0
    mov.w   r0,@r1
    mov.w   @r1,r0                /* required write-buffer drain */
    tst     #2,r0
    bf      .L_mask_fail

    /* Clear and synchronize the request while CMD remains masked. */
    mov.l   @(.L_cmd_clear,pc),r1
    mov     #0,r0
    mov.w   r0,@r1
    mov.w   @r1,r0                /* clear-register synchronization */
    tst     r0,r0
    bf      .L_clear_fail

    /* Restore the exact pre-mask word only after the request is clear. */
    mov.l   @(.L_sys_mask,pc),r1
    mov.l   @(32,r3),r2
    mov.w   r2,@r1
    mov.w   @r1,r0
    extu.w  r0,r0
    cmp/eq  r2,r0
    bf      .L_restore_fail

    /* Publish terminal success only after clear and exact mask restoration. */
    mov     #2,r0
    mov.l   r0,@(4,r3)
    mov.l   @(4,r3),r0
    cmp/eq  #2,r0
    bf      .L_phase2_fail
    bra     .L_return
    nop

.L_reset_boot_cmd:
    bsr     .L_capture_common
    nop
    mov.l   @(12,r3),r0
    add     #1,r0
    mov.l   r0,@(12,r3)
    mov     #0,r0
    mov.l   r0,@(20,r3)
    mov     #4,r0
    mov.l   r0,@(40,r3)
    mov.l   r0,@(4,r3)
    mov.l   @(4,r3),r0            /* synchronize before stock CMD clear */
    mov.l   @(.L_sys_mask,pc),r1  /* stock continuation requires SYS base */
    mov.l   @(.L_stock_cmd_boot,pc),r0
    jmp     @r0
    nop

.L_require_trace:
    mov     #0,r2
    mov.l   @r3,r0
    mov.l   @(.L_magic,pc),r1
    cmp/eq  r1,r0
    bf      .L_trace_bad
    mov.l   @(48,r3),r0
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
    mov.l   r4,@(24,r3)
    mov.l   @(24,r15),r0          /* hardware SPC below six saved longs */
    mov.l   r0,@(28,r3)
    mov.l   @(.L_comm01,pc),r1
    mov.l   @r1,r0
    mov.l   r0,@(36,r3)
    rts
    nop

.L_bad_trace:
    bra     .L_fail
    mov     #0x11,r2
.L_bad_phase:
    bra     .L_fail
    mov     #0x12,r2
.L_mask_fail:
    bra     .L_fail
    mov     #0x21,r2
.L_phase2_fail:
    bra     .L_fail
    mov     #0x22,r2
.L_clear_fail:
    bra     .L_fail
    mov     #0x23,r2
.L_restore_fail:
    bra     .L_fail
    mov     #0x24,r2

.L_fail:
    mov.l   r2,@(20,r3)
    mov     #0x7f,r0
    mov.l   r0,@(40,r3)
    mov.l   @(.L_failure_phase,pc),r0
    mov.l   r0,@(4,r3)
    mov.l   @(4,r3),r0
    bra     .L_hard_stop
    nop

.L_unexpected_external:
    mov.l   @(.L_trace_base,pc),r3
    mov.l   r4,@(24,r3)
    mov.l   @(24,r15),r0
    mov.l   r0,@(28,r3)
    mov     #0x7e,r0
    mov.l   r0,@(20,r3)
    mov     #0x7f,r0
    mov.l   r0,@(40,r3)
    mov.l   @(.L_failure_phase,pc),r0
    mov.l   r0,@(4,r3)
    mov.l   @(4,r3),r0
.L_hard_stop:
    bra     .L_hard_stop
    nop

.L_return:
    mov.l   @r15+,r4
    mov.l   @r15+,r3
    mov.l   @r15+,r2
    mov.l   @r15+,r1
    mov.l   @r15+,r0
    lds.l   @r15+,pr
    rte

/*
 * The startup JSR literal at ROM $020480 selects this probe-only shim.  It is
 * called before the Master assigns its application stack, so it must not use
 * R15 or replace PR.  It initializes the trace on cold boot and increments
 * the init count on every stock-init entry before tail-calling $060045CC.
 * One VRES lifecycle increments twice: the VRES continuation enters $0438,
 * then the reset-flow CMD delegates through $04E8 and enters $0438 again.
 * Its leading NOP is also the preceding RTE's harmless delay slot.
 */
q020_cmdint_probe_init:
    nop
    mov.l   @(.L_init_trace,pc),r1
    mov.l   @r1,r0
    mov.l   @(.L_init_magic,pc),r2
    cmp/eq  r2,r0
    bf      .L_init_clear
    mov.l   @(48,r1),r0
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
    mov.l   r0,@(48,r1)
.L_init_count:
    mov.l   @(44,r1),r0
    add     #1,r0
    mov.l   r0,@(44,r1)
    mov.l   @(44,r1),r0          /* synchronize before original init */
    mov.l   @(.L_original_init,pc),r0
    jmp     @r0
    nop

.align 2
.L_init_trace:      .long   0x2600BC20
.L_init_magic:      .long   0x51323050
.L_init_inverse:    .long   0xAECDCFAF
.L_original_init:   .long   0x060045CC

.align 2
.L_frt_base:        .long   0xFFFFFE10
.L_trace_base:      .long   0x2600BC20
.L_sys_mask:        .long   0x20004000
.L_comm01:          .long   0x20004020
.L_cmd_clear:       .long   0x2000401A
.L_stock_vres:      .long   0x060004A4
.L_stock_cmd_boot:  .long   0x060004E8
.L_bridge_literal:  .long   0xFFFFFFFF /* preserve external user $3039FC */
.L_magic:           .long   0x51323050
.L_magic_inverse:   .long   0xAECDCFAF
.L_failure_phase:   .long   0x80000001
