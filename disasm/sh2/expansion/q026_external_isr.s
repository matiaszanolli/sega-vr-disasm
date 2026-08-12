/*
 * Q-026 validation-only unified Master external ISR and startup shim.
 *
 * Core/pool: SH2 $02304000-$0230428F (656 bytes)
 * Startup:   SH2 $02304600-$02304653 (84 bytes)
 *
 * Every external entry saves the full interrupted context before applying the
 * FRT workaround and classifying the live accepted ISR SR.  The one bounded
 * diagnostic CMD switches to the dedicated $0600FC00 stack before calling the
 * player-only handler.  VRES/reset delegation is restricted to exact stock
 * SPC/R15 states; all other cases fail closed.
 */

.section .text
.align 2
.global q026_external_entry
q026_external_entry:
    sts.l   pr,@-r15
    stc.l   gbr,@-r15
    sts.l   mach,@-r15
    sts.l   macl,@-r15
    mov.l   r0,@-r15
    mov.l   r1,@-r15
    mov.l   r2,@-r15
    mov.l   r3,@-r15
    mov.l   r4,@-r15
    mov.l   r5,@-r15
    mov.l   r6,@-r15
    mov.l   r7,@-r15
    mov.l   r8,@-r15
    mov.l   r9,@-r15
    mov.l   r10,@-r15
    mov.l   r11,@-r15
    mov.l   r12,@-r15
    mov.l   r13,@-r15
    mov.l   r14,@-r15

    mov.l   @(.L_frt,pc),r1
    mov.b   @(7,r1),r0
    xor     #2,r0
    mov.b   r0,@(7,r1)

    /* F+76 = stacked PC; F+84 = recovered pre-exception R15. */
    mov     r15,r5
    add     #76,r5
    mov.l   @r5,r5
    mov     r15,r6
    add     #84,r6

    /* Classify exclusively from the live accepted ISR SR. */
    stc     sr,r4
    mov     r4,r0
    shlr2   r0
    and     #0x3c,r0
    cmp/eq  #0x38,r0              /* level 14: VRES */
    bt      .L_vres
    cmp/eq  #0x20,r0              /* level 8: CMD */
    bt      .L_cmd
    bra     .L_fail
    mov     #0x01,r2

.L_vres:
    mov.l   @(.L_trace,pc),r3
    mov.l   @r3,r0
    mov.l   @(.L_magic,pc),r1
    cmp/eq  r1,r0
    bf      .L_bad_trace
    mov.l   @(4,r3),r0
    cmp/eq  #1,r0
    bt      .L_nested_vres
    mov.l   @(.L_stock_sp_idle,pc),r0
    cmp/eq  r0,r6
    bf      .L_bad_vres_guard
    mov.l   @(.L_idle_460,pc),r0
    cmp/eq  r0,r5
    bf      .L_bad_vres_guard
    mov     #3,r0
    mov.l   r0,@(4,r3)
    mov.l   @(4,r3),r0
    mov.l   @(.L_stock_vres,pc),r0
    jmp     @r0
    nop

.L_cmd:
    mov.l   @(.L_trace,pc),r3
    mov.l   @r3,r0
    mov.l   @(.L_magic,pc),r1
    cmp/eq  r1,r0
    bf      .L_bad_trace
    mov.l   @(4,r3),r0
    cmp/eq  #3,r0
    bt      .L_stock_reset_cmd
    tst     r0,r0
    bf      .L_bad_phase

    mov.l   @(.L_dreq_ctrl,pc),r1
    mov.w   @r1,r0
    extu.w  r0,r0
    tst     #4,r0
    bf      .L_bad_dreq
    mov.l   @(.L_dreq_len,pc),r1
    mov.w   @r1,r0
    extu.w  r0,r0
    tst     r0,r0
    bf      .L_bad_dreq

    mov.l   @(.L_idle_460,pc),r0
    cmp/eq  r0,r5
    bt      .L_expect_idle_sp
    mov.l   @(.L_idle_462,pc),r0
    cmp/eq  r0,r5
    bt      .L_expect_idle_sp
    mov.l   @(.L_idle_464,pc),r0
    cmp/eq  r0,r5
    bt      .L_expect_idle_sp
    mov.l   @(.L_idle_466,pc),r0
    cmp/eq  r0,r5
    bt      .L_expect_idle_sp
    mov.l   @(.L_idle_474,pc),r0
    cmp/eq  r0,r5
    bt      .L_expect_idle_sp
    mov.l   @(.L_idle_476,pc),r0
    cmp/eq  r0,r5
    bt      .L_expect_idle_sp
    mov.l   @(.L_quiet_438,pc),r0
    cmp/hs  r0,r5
    bf      .L_bad_spc
    mov     r5,r1
    sub     r0,r1
    mov     #10,r0
    cmp/hi  r0,r1
    bt      .L_bad_spc
    mov     r1,r0
    tst     #1,r0
    bf      .L_bad_spc
    mov.l   @(.L_stock_sp_final,pc),r0
    cmp/eq  r0,r6
    bf      .L_bad_stack
    bra     .L_admitted
    nop
.L_expect_idle_sp:
    mov.l   @(.L_stock_sp_idle,pc),r0
    cmp/eq  r0,r6
    bf      .L_bad_stack

.L_admitted:
    mov.l   @(.L_sentinel,pc),r1
    mov.l   @r1,r0
    mov.l   @(.L_mode0_sentinel,pc),r2
    cmp/eq  r2,r0
    bf      .L_bad_seed
    mov.l   @(8,r3),r0
    tst     r0,r0
    bf      .L_bad_count
    mov     #1,r0
    mov.l   r0,@(8,r3)
    mov.l   @(8,r3),r0
    mov.l   r0,@(4,r3)
    mov.l   @(4,r3),r0
    mov.l   @(.L_stack_canary,pc),r1
    mov.l   @r1,r0
    mov.l   @(.L_stack_magic,pc),r2
    cmp/eq  r2,r0
    bf      .L_bad_canary

    mov     r15,r0
    mov.l   @(.L_stack_top,pc),r15
    mov.l   r0,@-r15              /* interrupted frame pointer at $FBFC */
    mov.l   @(.L_handler,pc),r0
    jsr     @r0
    nop

    mov.l   @(.L_sentinel,pc),r1
    mov.l   @(8,r1),r0
    mov.l   @(.L_done_magic,pc),r2
    cmp/eq  r2,r0
    bf      .L_bad_handler_dedicated
    mov.l   @(.L_stack_canary,pc),r1
    mov.l   @r1,r0
    mov.l   @(.L_stack_magic,pc),r2
    cmp/eq  r2,r0
    bf      .L_bad_handler_dedicated
    mov.l   @r15,r0
    mov     r0,r15

    mov.l   @(.L_trace,pc),r3
    mov.l   @(12,r3),r0
    tst     r0,r0
    bf      .L_bad_count
    mov     #1,r0
    mov.l   r0,@(12,r3)
    mov.l   @(12,r3),r0
    mov     #2,r0
    mov.l   r0,@(4,r3)
    mov.l   @(4,r3),r0
    bra     .L_ack_return
    nop

.L_bad_handler_dedicated:
    mov     #0x0a,r2
    mov.l   @r15,r0
    mov     r0,r15
    bra     .L_fail
    nop

.L_stock_reset_cmd:
    mov.l   @(.L_reset_cmd_spc,pc),r0
    cmp/eq  r0,r5
    bf      .L_bad_reset_cmd
    mov.l   @(.L_stock_sp_idle,pc),r0
    cmp/eq  r0,r6
    bf      .L_bad_reset_cmd
    mov     #4,r0
    mov.l   r0,@(4,r3)
    mov.l   @(4,r3),r0
    mov.l   @(.L_sys_mask,pc),r1
    mov.l   @(.L_stock_cmd_boot,pc),r0
    jmp     @r0
    nop

.L_ack_return:
    mov.l   @(.L_sys_mask,pc),r1
    mov.w   @r1,r6
    extu.w  r6,r6
    mov     r6,r0
    mov     #-3,r2
    and     r2,r0
    mov.w   r0,@r1
    mov.w   @r1,r0
    tst     #2,r0
    bf      .L_bad_mask
    mov.l   @(.L_cmd_clear,pc),r1
    mov     #0,r0
    mov.w   r0,@r1
    mov.w   @r1,r0                /* synchronized; read value is not asserted */
    mov.l   @(.L_sys_mask,pc),r1
    mov.w   r6,@r1
    mov.w   @r1,r0
    extu.w  r0,r0
    cmp/eq  r6,r0
    bf      .L_bad_restore
    bra     .L_return
    nop

.L_bad_trace:             bra .L_fail; mov #0x02,r2
.L_nested_vres:           bra .L_fail; mov #0x03,r2
.L_bad_vres_guard:        bra .L_fail; mov #0x04,r2
.L_bad_phase:             bra .L_fail; mov #0x05,r2
.L_bad_dreq:              bra .L_fail; mov #0x06,r2
.L_bad_spc:               bra .L_fail; mov #0x07,r2
.L_bad_stack:             bra .L_fail; mov #0x08,r2
.L_bad_seed:              bra .L_fail; mov #0x09,r2
.L_bad_canary:            bra .L_fail; mov #0x0b,r2
.L_bad_count:             bra .L_fail; mov #0x0c,r2
.L_bad_reset_cmd:         bra .L_fail; mov #0x0d,r2
.L_bad_mask:              bra .L_fail; mov #0x0e,r2
.L_bad_restore:           bra .L_fail; mov #0x0f,r2

.L_fail:
    mov.l   @(.L_trace,pc),r3
    mov.l   @(.L_failure,pc),r0
    or      r2,r0
    mov.l   r0,@(4,r3)
    mov.l   @(4,r3),r0
.L_stop:
    bra     .L_stop
    nop

.L_return:
    mov.l   @r15+,r14
    mov.l   @r15+,r13
    mov.l   @r15+,r12
    mov.l   @r15+,r11
    mov.l   @r15+,r10
    mov.l   @r15+,r9
    mov.l   @r15+,r8
    mov.l   @r15+,r7
    mov.l   @r15+,r6
    mov.l   @r15+,r5
    mov.l   @r15+,r4
    mov.l   @r15+,r3
    mov.l   @r15+,r2
    mov.l   @r15+,r1
    mov.l   @r15+,r0
    lds.l   @r15+,macl
    lds.l   @r15+,mach
    ldc.l   @r15+,gbr
    lds.l   @r15+,pr
    rte
    nop

.align 2
.L_frt:              .long 0xfffffe10
.L_trace:            .long 0x2600bc00
.L_magic:            .long 0x51323649       /* "Q26I" */
.L_dreq_ctrl:        .long 0x20004006
.L_dreq_len:         .long 0x20004010
.L_sentinel:         .long 0x2600fc00
.L_mode0_sentinel:   .long 0x20004020
.L_done_magic:       .long 0x51323643       /* "Q26C" */
.L_stack_top:        .long 0x0600fc00
.L_stack_canary:     .long 0x2600fb90
.L_stack_magic:      .long 0x5132534b       /* "Q2SK" */
.L_handler:          .long 0x02301500
.L_sys_mask:         .long 0x20004000
.L_cmd_clear:        .long 0x2000401a
.L_idle_460:         .long 0x06000460
.L_idle_462:         .long 0x06000462
.L_idle_464:         .long 0x06000464
.L_idle_466:         .long 0x06000466
.L_idle_474:         .long 0x06000474
.L_idle_476:         .long 0x06000476
.L_quiet_438:        .long 0x06004438
.L_stock_sp_idle:    .long 0x0600ff80
.L_stock_sp_final:   .long 0x0600ff78
.L_reset_cmd_spc:    .long 0x06000452
.L_stock_vres:       .long 0x060004a4
.L_stock_cmd_boot:   .long 0x060004e8
.L_failure:          .long 0x80000000

/* The .org preserves the audited literal/padding layout in one linked ELF. */
.org 0x600
.global q026_init
q026_init:
    nop                             /* preceding RTE delay-slot safety */
    mov.l   @(.L_i_trace,pc),r1
    mov.l   @r1,r0
    mov.l   @(.L_i_magic,pc),r2
    cmp/eq  r2,r0
    bf      .L_i_clear
    mov.l   @(4,r1),r0
    cmp/eq  #3,r0
    bt      .L_i_tail
.L_i_clear:
    mov     #0,r0
    mov.l   r0,@(4,r1)
    mov.l   r0,@(8,r1)
    mov.l   r0,@(12,r1)
    mov.l   @(.L_i_magic,pc),r0
    mov.l   r0,@r1
    mov.l   @r1,r0
    mov.l   @(.L_i_canary,pc),r1
    mov.l   @(.L_i_canary_magic,pc),r0
    mov.l   r0,@r1
    mov.l   @r1,r0
    mov.l   @(.L_i_sentinel,pc),r1
    mov     #0,r0
    mov.l   r0,@r1
    mov.l   r0,@(4,r1)
    mov.l   r0,@(8,r1)
    mov.l   r0,@(12,r1)
    mov.l   @(12,r1),r0
.L_i_tail:
    mov.l   @(.L_i_original,pc),r0
    jmp     @r0
    nop
.align 2
.L_i_trace:           .long 0x2600bc00
.L_i_magic:           .long 0x51323649
.L_i_canary:          .long 0x2600fb90
.L_i_canary_magic:    .long 0x5132534b
.L_i_sentinel:        .long 0x2600fc00
.L_i_original:        .long 0x060045cc

.global q026_end
q026_end:
