/*
 * Q-020 cmd $3E mode-1 validation-only Master handler
 *
 * Fixed expansion placement: file $303A10, SH2 $02303A10.
 * This is a globals-only, non-promotable handler selected only by the isolated
 * mode-1 ROM pair. It cannot dispatch mode 0, mode 2, or cmd $3F.
 *
 * Entry: R8 = $20004020 cache-through COMM base.
 * Clobbers: R0-R2. Preserves PR/R15.
 */

.section .text
.align 2

cmd3e_mode1_validation:
    mov.l   @(.sentinel_addr,pc),r1
    mov.l   r8,@r1
    sts.l   pr,@-r15

    /* Fail stopped if the 68K did not publish mode 1 before its sole trigger. */
    mov.b   @(6,r8),r0
    cmp/eq  #1,r0
    bf      .fail_stop

    /* DMAC channel 0: fixed FIFO source -> globals destination, 32 words. */
    mov.l   @(.dmac_sar0,pc),r1
    mov.l   @(.fifo_addr,pc),r0
    mov.l   r0,@r1
    mov.l   @(.dmac_dar0,pc),r1
    mov.l   @(.globals_dst,pc),r0
    mov.l   r0,@r1
    mov.l   @(.dmac_tcr0,pc),r1
    mov.l   @(.tcr_globals,pc),r0
    mov.l   r0,@r1
    mov.l   @(.dmac_chcr0,pc),r1
    mov.l   @(.chcr_value,pc),r0
    mov.l   r0,@r1
    mov.l   @(.dmac_dmaor,pc),r1
    mov     #1,r0
    mov.l   r0,@r1
    mov.l   @r1,r0                  /* synchronize DMAC enable */

    /* Preserve system bit 0, set ACK bit 1, then flush the external write. */
    mov.b   @(3,r8),r0
    or      #2,r0
    mov.b   r0,@(3,r8)
    mov.b   @(3,r8),r0              /* required same-address readback */

    mov.l   @(.dreq_len,pc),r1
.wait_dreq_complete:
    mov.w   @r1,r0
    tst     r0,r0
    bf      .wait_dreq_complete

    /* 68K cleared ACK before FIFO streaming; inspect it only after DREQ==0. */
.wait_ack_clear:
    mov.b   @(3,r8),r0
    tst     #2,r0
    bf      .wait_ack_clear

    /* Publish completion and force it to the physical COMM register. */
    mov     #0,r0
    mov.b   r0,@(0,r8)
    mov.b   @(0,r8),r0              /* required same-address readback */

    lds.l   @r15+,pr
    rts
    nop

.fail_stop:
    bra     .fail_stop
    nop

.align 2
.dmac_sar0:
    .long   0xFFFFFF80
.fifo_addr:
    .long   0x20004012
.dmac_dar0:
    .long   0xFFFFFF84
.globals_dst:
    .long   0x0600F30C
.dmac_tcr0:
    .long   0xFFFFFF88
.tcr_globals:
    .long   0x00000020
.dmac_chcr0:
    .long   0xFFFFFF8C
.chcr_value:
    .long   0x000044E5
.dmac_dmaor:
    .long   0xFFFFFFB0
.dreq_len:
    .long   0x20004010
.sentinel_addr:
    .long   0x2600FC04

.global cmd3e_mode1_validation
