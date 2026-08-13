/*
 * Q-027 validation-only table-dispatched player-shadow handler.
 *
 * Fixed entry: SH2 $02301500, reached only by the unmodified stock Master
 * dispatcher table[$3f].  The caller contract is R8=$20004020,
 * PR=$06000474, R15=$0600ff80.  This handler moves to the Q-027-only stack,
 * preserves PR/GBR/MACH/MACL/R8-R14 exactly, writes the frozen mailbox proof,
 * runs the accepted Q-026 player-only sequence, and owns final COMM0/CMD
 * cleanup.  It contains no AI, collision, framebuffer, Slave, bridge,
 * authority, cadence, or shared-lane transport.
 */

.section .text
.align 2
.global q027_player_stock_dispatch
q027_player_stock_dispatch:
    mov     r15,r0
    mov.l   @(.L_stack_top,pc),r15
    mov.l   r0,@-r15                  /* incoming stock R15 -> $0600fbfc */
    sts.l   pr,@-r15
    stc.l   gbr,@-r15
    sts.l   mach,@-r15
    sts.l   macl,@-r15
    mov.l   r8,@-r15
    mov.l   r9,@-r15
    mov.l   r10,@-r15
    mov.l   r11,@-r15
    mov.l   r12,@-r15
    mov.l   r13,@-r15
    mov.l   r14,@-r15                 /* preservation frame ends at $0600fbd0 */

    mov.l   @(.L_trace,pc),r4
    mov     #0x21,r3
    mov.l   @(4,r4),r0
    cmp/eq  #2,r0                     /* Edge 2 must have fenced DISPATCHING */
    bf      .L_fail
    mov     #0x22,r3
    mov.l   @(12,r4),r0
    tst     r0,r0
    bf      .L_fail
    mov     #1,r0
    mov.l   r0,@(12,r4)
    mov.l   @(12,r4),r0
    mov     #3,r0
    mov.l   r0,@(4,r4)
    mov.l   @(4,r4),r0

    /* Frozen 16-byte mailbox image; every store is read back in place. */
    mov     #0x23,r3
    mov.l   @(.L_mailbox,pc),r4
    mov.l   @(.L_mailbox_0,pc),r0
    mov.l   r0,@r4
    mov.l   @r4,r1
    cmp/eq  r0,r1
    bf      .L_fail
    mov.w   @(.L_mailbox_4,pc),r0
    mov     r0,r2
    mov.w   r0,@(4,r4)
    mov.w   @(4,r4),r0
    cmp/eq  r2,r0
    bf      .L_fail
    mov.w   @(.L_mailbox_6,pc),r0
    mov     r0,r2
    mov.w   r0,@(6,r4)
    mov.w   @(6,r4),r0
    cmp/eq  r2,r0
    bf      .L_fail
    mov.w   @(.L_mailbox_8,pc),r0
    mov     r0,r2
    mov.w   r0,@(8,r4)
    mov.w   @(8,r4),r0
    cmp/eq  r2,r0
    bf      .L_fail
    mov.w   @(.L_mailbox_a,pc),r0
    mov     r0,r2
    mov.w   r0,@(10,r4)
    mov.w   @(10,r4),r0
    cmp/eq  r2,r0
    bf      .L_fail
    mov.l   @(.L_mailbox_c,pc),r0
    mov.l   r0,@(12,r4)
    mov.l   @(12,r4),r1
    cmp/eq  r0,r1
    bf      .L_fail

    /* Require the accepted mode-0 transfer provenance before player work. */
    mov     #0x24,r3
    mov.l   @(.L_seed_sentinel,pc),r1
    mov.l   @r1,r0
    mov.l   @(.L_mode0_sentinel,pc),r2
    cmp/eq  r2,r0
    bf      .L_fail

    mov.l   @(.L_entity,pc),r0
    ldc     r0,gbr
    mov     r0,r14
    mov.l   @(.L_globals,pc),r13
    bsr     .L_player_core
    nop

    mov     #0x25,r3
    mov.l   @(.L_canary,pc),r1
    mov.l   @r1,r0
    mov.l   @(.L_canary_magic,pc),r2
    cmp/eq  r2,r0
    bf      .L_fail

    /* Final consumer owns the only Q-027 Master COMM write. */
    mov     #0x26,r3
    mov.l   @(.L_mode0_sentinel,pc),r1
    mov     #0,r0
    mov.w   r0,@r1
    mov.w   @r1,r0
    tst     r0,r0
    bf      .L_fail

    mov.l   @(.L_trace,pc),r4
    mov.l   @(.L_mailbox_c,pc),r0
    mov.l   r0,@(40,r4)
    mov.l   @(40,r4),r0
    mov     #4,r0
    mov.l   r0,@(4,r4)
    mov.l   @(4,r4),r0

    /* Keep pending CMD masked until every success witness is fenced. */
    mov     #0x27,r3
    mov.l   @(.L_cmd_clear,pc),r1
    mov     #0,r0
    mov.w   r0,@r1
    mov.w   @r1,r0
    tst     r0,r0
    bf      .L_fail
    mov     #0x28,r3
    mov.l   @(32,r4),r2
    mov.l   @(.L_sys_mask,pc),r1
    mov.w   r2,@r1
    mov.w   @r1,r0
    extu.w  r0,r0
    extu.w  r2,r2
    cmp/eq  r2,r0
    bf      .L_fail

    /* No COMM access follows the synchronized full-word clear above. */
    mov     #0x25,r3
    mov.l   @(.L_canary,pc),r1
    mov.l   @r1,r0
    mov.l   @(.L_canary_magic,pc),r2
    cmp/eq  r2,r0
    bf      .L_fail

    mov.l   @r15+,r14
    mov.l   @r15+,r13
    mov.l   @r15+,r12
    mov.l   @r15+,r11
    mov.l   @r15+,r10
    mov.l   @r15+,r9
    mov.l   @r15+,r8
    lds.l   @r15+,macl
    lds.l   @r15+,mach
    ldc.l   @r15+,gbr
    lds.l   @r15+,pr
    mov.l   @r15,r15
    rts
    nop

/* Exact accepted Q-026 player-only call sequence. */
.L_player_core:
    sts.l   pr,@-r15
    mov.w   @(0x30,gbr),r0
    mov.w   r0,@(0xec,gbr)
    mov.w   @(0x34,gbr),r0
    mov.w   r0,@(0xee,gbr)

    mov.l   @(.L_call_table_ptr,pc),r12
    mov     #14,r11
.L_player_call_loop:
    mov.l   @r12+,r0
    jsr     @r0
    nop
    dt      r11
    bf      .L_player_call_loop
    lds.l   @r15+,pr
    rts
    nop

.L_fail:
    mov.l   @(.L_trace,pc),r4
    mov.l   r3,@(48,r4)
    mov.l   @(48,r4),r0
.L_stop:
    bra     .L_stop
    nop

.align 2
.L_stack_top:       .long 0x0600fc00
.L_trace:           .long 0x2600bc60
.L_mailbox:         .long 0x2600bc00
.L_mailbox_0:       .long 0x5132374d
.L_mailbox_4:       .word 0x0001
.L_mailbox_6:       .word 0x2711
.L_mailbox_8:       .word 0x3f01
.L_mailbox_a:       .word 0xa55a
.L_mailbox_c:       .long 0x51323743
.L_seed_sentinel:   .long 0x2600fc00
.L_mode0_sentinel:  .long 0x20004020
.L_entity:          .long 0x2600f20c
.L_globals:         .long 0x2600f30c
.L_canary:          .long 0x2600fb64
.L_canary_magic:    .long 0x5132374b       /* "Q27K" */
.L_cmd_clear:       .long 0x2000401a
.L_sys_mask:        .long 0x20004000
.L_call_table_ptr:  .long .L_call_table
.L_call_table:
    .long 0x023017c0, 0x02301d94, 0x02301e00, 0x02301e20
    .long 0x02301d40, 0x02301820, 0x0230189c, 0x023017f2
    .long 0x02301b40, 0x02301cbc, 0x02301f20, 0x02302158
    .long 0x02301e2e, 0x02301e60

.global q027_player_stock_dispatch_end
q027_player_stock_dispatch_end:
