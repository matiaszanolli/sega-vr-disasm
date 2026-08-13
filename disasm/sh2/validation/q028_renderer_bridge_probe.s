/*
 * Q-028 validation-only stock-cmd $02 descriptor visibility wrapper.
 *
 * Linked only at the boot-copied SDRAM address $0600BBC0.  The common
 * instruction layout, fixed access PCs, and 296-byte end are part of the
 * audited contract; do not compact or relocate this source.
 *
 * Required assembler symbols:
 *   Q028_FAMILY = 1 (A), 2 (B), or 3 (C)
 *   Q028_INDEX  = -1 for FAMILY_ALL, otherwise a legal logical index
 *   Q028_STAGE_CONTROL = 1 for the idempotent control selector (optional)
 */

.ifndef Q028_FAMILY
.error "Q028_FAMILY is required"
.endif
.ifndef Q028_INDEX
.error "Q028_INDEX is required"
.endif

.if Q028_FAMILY == 1
  .set Q028_NATIVE_COUNT, 4
  .set Q028_RET_PC,       0x06000ff4
  .set Q028_ENTRY_SP,     0x0600fff8
  .set Q028_DESC_BASE,    0x0600c128
  .set Q028_STATE_BASE,   0x0600ca60
  .set Q028_MAX_INDEX,    3
.elseif Q028_FAMILY == 2
  .set Q028_NATIVE_COUNT, 8
  .set Q028_RET_PC,       0x06000ffe
  .set Q028_ENTRY_SP,     0x0600fff8
  .set Q028_DESC_BASE,    0x0600c178
  .set Q028_STATE_BASE,   0x0600cb20
  .set Q028_MAX_INDEX,    7
.elseif Q028_FAMILY == 3
  .set Q028_NATIVE_COUNT, 3
  .set Q028_RET_PC,       0x06001016
  .set Q028_ENTRY_SP,     0x0600fff4
  .set Q028_DESC_BASE,    0x0600c254
  .set Q028_STATE_BASE,   0x0600cd30
  .set Q028_MAX_INDEX,    20
.else
  .error "Q028_FAMILY must be 1, 2, or 3"
.endif

.if Q028_INDEX < -1
  .error "Q028_INDEX must be FAMILY_ALL (-1) or non-negative"
.endif
.if Q028_INDEX > Q028_MAX_INDEX
  .error "Q028_INDEX is outside the selected family"
.endif

.if Q028_INDEX == -1
  .if Q028_FAMILY == 3
    .set Q028_MATCH_GROUPS, 7
  .else
    .set Q028_MATCH_GROUPS, 1
  .endif
  .set Q028_TARGET_COUNT, Q028_NATIVE_COUNT
  .set Q028_TARGET_OFFSET, 0
  .set Q028_RESTORE_DELTA, 0
.else
  .set Q028_MATCH_GROUPS, 1
  .set Q028_TARGET_COUNT, 1
  .if Q028_FAMILY == 3
    .set Q028_GROUP, Q028_INDEX / 3
    .set Q028_IN_GROUP, Q028_INDEX - Q028_GROUP * 3
    .set Q028_DESC_BASE, Q028_DESC_BASE + Q028_GROUP * 0x78
    .set Q028_STATE_BASE, Q028_STATE_BASE + Q028_GROUP * 0x120
    .set Q028_TARGET_OFFSET, Q028_IN_GROUP * 20
    .set Q028_RESTORE_DELTA, (Q028_IN_GROUP + 1 - Q028_NATIVE_COUNT) * 20
  .else
    .set Q028_TARGET_OFFSET, Q028_INDEX * 20
    .set Q028_RESTORE_DELTA, (Q028_INDEX + 1 - Q028_NATIVE_COUNT) * 20
  .endif
.endif

.section .text
.align 2
.global q028_probe
q028_probe:
    /* Fixed-size exact tuple matcher.  A/B use one iteration; C-all uses 7. */
    mov.l r1,@-r15
    sts pr,r0
    mov.l @(.ret_pc,pc),r1
    cmp/eq r1,r0
    bf .early_reject
    mov.l @(.entry_sp,pc),r1
    cmp/eq r1,r15
    bf .early_reject
    sts.l pr,@-r15
    mov.l r2,@-r15
    mov.l r3,@-r15
    mov.l r4,@-r15
    mov.l r5,@-r15
    mov.l r6,@-r15
    mov #Q028_NATIVE_COUNT,r0
    cmp/eq r0,r7
    bf .admission_fail
    mov.l @(.desc_base,pc),r2
    mov r14,r0
    sub r2,r0
    mov.l @(.state_base,pc),r2
    mov r13,r1
    sub r2,r1
    mov #Q028_MATCH_GROUPS,r2
.match_loop:
    mov r0,r3
    or r1,r3
    tst r3,r3
    bt .admit
.match_next:
    add #-120,r0
    mov.l @(.state_group_stride,pc),r3
    sub r3,r1
    dt r2
    bf .match_loop
    nop
    bra .admission_fail
    nop

.admit:
    /* Two consecutive CT observations: 68S clear and DREQ LEN zero. */
    mov.l @(.dreq_ctrl,pc),r1
    mov.w @r1,r0
    tst #4,r0
    bf .admission_fail
    mov.l @(.dreq_len,pc),r2
    mov.w @r2,r0
    tst r0,r0
    bf .admission_fail
    mov.w @r1,r0
    tst #4,r0
    bf .admission_fail
    mov.w @r2,r0
    tst r0,r0
    bf .admission_fail

    mov.l @(.ct_mask,pc),r0
    or r0,r14
    mov r14,r1
    mov #Q028_TARGET_COUNT,r3
    mov #0,r4
    /* Fixed two-word exact-index target adjustment slot. */
.if Q028_TARGET_OFFSET > 120
    add #120,r1
    add #(Q028_TARGET_OFFSET - 120),r1
.elseif Q028_TARGET_OFFSET != 0
    add #Q028_TARGET_OFFSET,r1
    nop
.else
    nop
    nop
.endif
.pre_loop:
    mov.w @r1,r0
    extu.w r0,r0
    mov.l r0,@-r15
    add #1,r4
.ifdef Q028_STAGE_CONTROL
    mov r0,r2
.else
    xor r2,r2
.endif
    nop
    mov.w r2,@r1
    mov.w @r1,r0
    extu.w r0,r0
    cmp/eq r2,r0
    bf .pre_fail
    add #20,r1
    dt r3
    bf .pre_loop
    nop

    mov.l @(.stock_loop,pc),r0
    jsr @r0
    nop
    mov r0,r6
    mov r14,r5
    /* Fixed two-word reverse-restore pointer adjustment slot. */
.if Q028_RESTORE_DELTA < -120
    add #-120,r14
    add #(Q028_RESTORE_DELTA + 120),r14
.elseif Q028_RESTORE_DELTA != 0
    add #Q028_RESTORE_DELTA,r14
    nop
.else
    nop
    nop
.endif
    mov #Q028_TARGET_COUNT,r3
.restore_loop:
    add #-20,r14
    mov.l @r15+,r0
    mov.w r0,@r14
    mov.w @r14,r1
    extu.w r1,r1
    cmp/eq r0,r1
    bf .fail_stop
    dt r3
    bf .restore_loop
    nop
    mov r5,r14
    mov.l @(.native_mask,pc),r0
    and r0,r14
    mov r6,r0

.return_ctx:
    mov.l @r15+,r6
    mov.l @r15+,r5
    mov.l @r15+,r4
    mov.l @r15+,r3
    mov.l @r15+,r2
    lds.l @r15+,pr
    mov.l @r15+,r1
    rts
    nop

.pre_fail:
    mov r1,r3
    nop
.unwind:
    mov.l @r15+,r0
    mov.w r0,@r3
    mov.w @r3,r2
    extu.w r2,r2
    cmp/eq r0,r2
    bf .fail_stop
    dt r4
    bf/s .unwind
    add #-20,r3
    mov.l @(.native_mask,pc),r0
    and r0,r14
.admission_fail:
    mov.l @r15+,r6
    mov.l @r15+,r5
    mov.l @r15+,r4
    mov.l @r15+,r3
    mov.l @r15+,r2
    lds.l @r15+,pr
.early_reject:
    mov.l @r15+,r1
.tail:
    mov.l @(.stock_loop,pc),r0
    jmp @r0
    nop

.fail_stop:
    bra .fail_stop
    nop

.align 2
.ret_pc:             .long Q028_RET_PC
.entry_sp:           .long Q028_ENTRY_SP
.desc_base:          .long Q028_DESC_BASE
.state_base:         .long Q028_STATE_BASE
.state_group_stride: .long 0x00000120
.dreq_ctrl:          .long 0x20004006
.dreq_len:           .long 0x20004010
.ct_mask:            .long 0x20000000
.native_mask:        .long 0xdfffffff
.stock_loop:         .long 0x060024dc
.global q028_probe_end
q028_probe_end:
