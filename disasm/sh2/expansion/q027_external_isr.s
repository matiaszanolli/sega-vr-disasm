/*
 * Q-027 validation-only unified Master external ISR.
 *
 * Section placements are fixed independently at $02304000 (core), $02304500
 * (no-memory park), and $02304600 (startup).  Every external entry full-saves
 * PR,GBR,MACH,MACL,R0-R14 after the hardware PC/SR frame and applies the stock
 * FRT workaround before classifying the live ISR SR.
 */

.section .q027_core,"ax"
.align 2
.global q027_external_entry
q027_external_entry:
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
    mov     r15,r7
    add     #76,r7
    mov.l   @r7,r5
    mov     r15,r6
    add     #84,r6

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
    tst     r0,r0
    bt      .L_vres_quiescent
    cmp/eq  #4,r0
    bf      .L_nested_vres
.L_vres_quiescent:
    mov.l   @(.L_stock_sp,pc),r0
    cmp/eq  r0,r6
    bf      .L_bad_vres_guard
    mov.l   @(.L_idle_460,pc),r0
    cmp/eq  r0,r5
    bf      .L_bad_vres_guard
    mov     #5,r0
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
    cmp/eq  #5,r0
    bt      .L_stock_reset_cmd
    tst     r0,r0
    bt      .L_edge1
    cmp/eq  #1,r0
    bt      .L_edge2
    bra     .L_bad_phase
    nop

.L_require_dreq_idle:
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
    rts
    nop

.L_edge1:
    bsr     .L_require_dreq_idle
    nop
    mov.l   @(.L_stock_sp,pc),r0
    cmp/eq  r0,r6
    bf      .L_bad_stack
    mov.l   @(.L_idle_460,pc),r0
    cmp/eq  r0,r5
    bt      .L_edge1_pc_ok
    mov.l   @(.L_idle_462,pc),r0
    cmp/eq  r0,r5
    bt      .L_edge1_pc_ok
    mov.l   @(.L_idle_464,pc),r0
    cmp/eq  r0,r5
    bt      .L_edge1_pc_ok
    mov.l   @(.L_idle_466,pc),r0
    cmp/eq  r0,r5
    bt      .L_edge1_pc_ok
    mov.l   @(.L_idle_474,pc),r0
    cmp/eq  r0,r5
    bt      .L_edge1_pc_ok
    mov.l   @(.L_idle_476,pc),r0
    cmp/eq  r0,r5
    bf      .L_bad_spc
.L_edge1_pc_ok:
    mov.l   @(.L_seed_sentinel,pc),r1
    mov.l   @r1,r0
    mov.l   @(.L_mode0_sentinel,pc),r2
    cmp/eq  r2,r0
    bf      .L_bad_seed
    mov.l   @(.L_comm0,pc),r1
    mov.b   @r1,r0
    extu.b  r0,r0
    tst     r0,r0
    bf      .L_bad_comm0
    mov.l   @(8,r3),r0
    tst     r0,r0
    bf      .L_bad_count
    mov     #1,r0
    mov.l   r0,@(8,r3)
    mov.l   @(8,r3),r0
    mov.l   r5,@(16,r3)
    mov.l   @(16,r3),r0
    mov.l   r6,@(20,r3)
    mov.l   @(20,r3),r0
    mov     #1,r0
    mov.l   r0,@(4,r3)
    mov.l   @(4,r3),r0
    mov.l   @(.L_park,pc),r0
    mov.l   r0,@r7                   /* redirect only stacked PC */
    bra     .L_ack_edge1
    nop

.L_edge2:
    bsr     .L_require_dreq_idle
    nop
    mov.l   @(.L_stock_sp,pc),r0
    cmp/eq  r0,r6
    bf      .L_bad_stack
    mov.l   @(.L_park,pc),r0
    cmp/eq  r0,r5
    bt      .L_edge2_pc_ok
    mov.l   @(.L_park_2,pc),r0
    cmp/eq  r0,r5
    bf      .L_bad_spc
.L_edge2_pc_ok:
    mov.l   @(8,r3),r0
    cmp/eq  #1,r0
    bf      .L_bad_count
    mov.l   @(.L_comm0,pc),r1
    mov.w   @r1,r0
    extu.w  r0,r0
    mov.w   @(.L_cmd_013f,pc),r2
    extu.w  r2,r2
    cmp/eq  r2,r0
    bf      .L_bad_comm0
    mov.l   @(.L_canary,pc),r1
    mov.l   @(.L_canary_magic,pc),r2
    mov.l   r2,@r1
    mov.l   @r1,r0
    cmp/eq  r2,r0
    bf      .L_bad_canary
    mov.l   @(.L_sys_mask,pc),r1
    mov.w   @r1,r6
    extu.w  r6,r6
    mov.l   r6,@(32,r3)
    mov.l   @(32,r3),r0
    mov     r6,r0
    mov     #-3,r2
    and     r2,r0
    mov.w   r0,@r1
    mov.w   @r1,r0
    tst     #2,r0
    bf      .L_bad_mask
    mov     #2,r0
    mov.l   r0,@(8,r3)
    mov.l   @(8,r3),r0
    mov.l   r5,@(24,r3)
    mov.l   @(24,r3),r0
    mov.l   @(.L_stock_sp,pc),r0
    mov.l   r0,@(28,r3)
    mov.l   @(28,r3),r0

    /* Sole ACTIVE/STAGE-CONTROL executable delta: one fixed branch word. */
.ifdef Q027_STAGE_CONTROL
    bra     .L_control_complete
.else
    nop
.endif
    nop

    mov     #2,r0
    mov.l   r0,@(4,r3)
    mov.l   @(4,r3),r0
    mov.l   @(.L_idle_460,pc),r0
    mov.l   r0,@r7
    bra     .L_return
    nop

.L_control_complete:
    mov.l   @(.L_comm0,pc),r1
    mov     #0,r0
    mov.w   r0,@r1
    mov.w   @r1,r0
    tst     r0,r0
    bf      .L_bad_comm0
    mov.l   @(.L_control_magic,pc),r0
    mov.l   r0,@(44,r3)
    mov.l   @(44,r3),r0
    mov     #4,r0
    mov.l   r0,@(4,r3)
    mov.l   @(4,r3),r0
    mov.l   @(.L_cmd_clear,pc),r1
    mov     #0,r0
    mov.w   r0,@r1
    mov.w   @r1,r0
    tst     r0,r0
    bf      .L_bad_cmd_clear
    mov.l   @(.L_sys_mask,pc),r1
    mov.w   r6,@r1
    mov.w   @r1,r0
    extu.w  r0,r0
    cmp/eq  r6,r0
    bf      .L_bad_restore
    mov.l   @(.L_idle_460,pc),r0
    mov.l   r0,@r7
    bra     .L_return
    nop

.L_ack_edge1:
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
    mov.w   @r1,r0
    tst     r0,r0
    bf      .L_bad_cmd_clear
    mov.l   @(.L_sys_mask,pc),r1
    mov.w   r6,@r1
    mov.w   @r1,r0
    extu.w  r0,r0
    cmp/eq  r6,r0
    bf      .L_bad_restore
    bra     .L_return
    nop

.L_stock_reset_cmd:
    mov.l   @(.L_reset_cmd_spc,pc),r0
    cmp/eq  r0,r5
    bf      .L_bad_reset_cmd
    mov.l   @(.L_stock_sp,pc),r0
    cmp/eq  r0,r6
    bf      .L_bad_reset_cmd
    mov     #6,r0
    mov.l   r0,@(4,r3)
    mov.l   @(4,r3),r0
    mov.l   @(.L_stock_cmd_boot,pc),r0
    jmp     @r0
    nop

.L_bad_trace:       bra .L_fail; mov #0x02,r2
.L_nested_vres:     bra .L_fail; mov #0x03,r2
.L_bad_vres_guard:  bra .L_fail; mov #0x04,r2
.L_bad_phase:       bra .L_fail; mov #0x05,r2
.L_bad_dreq:        bra .L_fail; mov #0x06,r2
.L_bad_spc:         bra .L_fail; mov #0x07,r2
.L_bad_stack:       bra .L_fail; mov #0x08,r2
.L_bad_seed:        bra .L_fail; mov #0x09,r2
.L_bad_canary:      bra .L_fail; mov #0x0a,r2
.L_bad_count:       bra .L_fail; mov #0x0b,r2
.L_bad_comm0:       bra .L_fail; mov #0x0c,r2
.L_bad_mask:        bra .L_fail; mov #0x0d,r2
.L_bad_cmd_clear:   bra .L_fail; mov #0x0e,r2
.L_bad_restore:     bra .L_fail; mov #0x0f,r2
.L_bad_reset_cmd:   bra .L_fail; mov #0x10,r2

.L_fail:
    mov.l   @(.L_trace,pc),r3
    mov.l   @(.L_failure,pc),r0
    or      r2,r0
    mov.l   r0,@(48,r3)
    mov.l   @(48,r3),r0
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
.L_trace:            .long 0x2600bc60
.L_magic:            .long 0x51323749       /* "Q27I" */
.L_dreq_ctrl:        .long 0x20004006
.L_dreq_len:         .long 0x20004010
.L_seed_sentinel:    .long 0x2600fc00
.L_mode0_sentinel:   .long 0x20004020
.L_comm0:            .long 0x20004020
.L_canary:           .long 0x2600fb64
.L_canary_magic:     .long 0x5132374b       /* "Q27K" */
.L_sys_mask:         .long 0x20004000
.L_cmd_clear:        .long 0x2000401a
.L_idle_460:         .long 0x06000460
.L_idle_462:         .long 0x06000462
.L_idle_464:         .long 0x06000464
.L_idle_466:         .long 0x06000466
.L_idle_474:         .long 0x06000474
.L_idle_476:         .long 0x06000476
.L_stock_sp:         .long 0x0600ff80
.L_park:             .long 0x02304500
.L_park_2:           .long 0x02304502
.L_cmd_013f:         .word 0x013f
.align 2
.L_control_magic:    .long 0x51323753       /* "Q27S" */
.L_reset_cmd_spc:    .long 0x06000452
.L_stock_vres:       .long 0x060004a4
.L_stock_cmd_boot:   .long 0x060004e8
.L_failure:          .long 0x80000000

.global q027_external_core_end
q027_external_core_end:

.section .q027_park,"ax"
.align 2
.global q027_master_park
q027_master_park:
    bra     q027_master_park
    nop
.global q027_master_park_end
q027_master_park_end:

.section .q027_init,"ax"
.align 2
.global q027_init
q027_init:
    nop                             /* preceding stock RTE delay-slot safety */
    mov.l   @(.L_i_trace,pc),r1
    mov.l   @r1,r0
    mov.l   @(.L_i_magic,pc),r2
    cmp/eq  r2,r0
    bf      .L_i_clear
    mov.l   @(4,r1),r0
    cmp/eq  #5,r0
    bt      .L_i_tail
.L_i_clear:
    mov     #0,r0
    mov     #16,r3
.L_i_trace_loop:
    mov.l   r0,@r1
    add     #4,r1
    dt      r3
    bf      .L_i_trace_loop
    mov.l   @(.L_i_trace,pc),r1
    mov.l   @(.L_i_magic,pc),r0
    mov.l   r0,@r1
    mov.l   @r1,r0
    mov.l   @(.L_i_mailbox,pc),r1
    mov     #4,r3
    mov     #0,r0
.L_i_mailbox_loop:
    mov.l   r0,@r1
    add     #4,r1
    dt      r3
    bf      .L_i_mailbox_loop
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
.L_i_trace:          .long 0x2600bc60
.L_i_magic:          .long 0x51323749
.L_i_mailbox:        .long 0x2600bc00
.L_i_canary:         .long 0x2600fb64
.L_i_canary_magic:   .long 0x5132374b
.L_i_sentinel:       .long 0x2600fc00
.L_i_original:       .long 0x060045cc

.global q027_init_end
q027_init_end:
