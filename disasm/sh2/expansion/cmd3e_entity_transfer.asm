/*
 * cmd3e_entity_transfer — VR60 Phase 3A: DREQ-based Entity Transfer
 * Expansion ROM Address: $301600 (SH2: $02301600)
 *
 * Configures SH2 DMAC channel 0 to receive 320 bytes (160 words) of
 * player entity data (256B) + physics globals (64B) from the 68K via
 * DREQ FIFO. Data lands at $0600F20C (entity) and $0600F30C (globals).
 *
 * DMAC channel 0 configuration (same as cmd $02 but different destination):
 *   SAR0 = $20004012 (FIFO register, fixed source, hardware standard)
 *   DAR0 = $0600F20C (entity working copy, auto-increment)
 *   TCR0 = $00A0      (160 words = 320 bytes: 256B entity + 64B globals)
 *   CHCR0 = $000014E5 (external request, word transfer, dest auto-inc)
 *
 * Protocol:
 *   1. 68K sets DREQ_LEN = $00A0, DREQ_CTRL = $04 (CPU write)
 *   2. 68K writes COMM0_LO = $3E, COMM0_HI = $01 (trigger)
 *   3. SH2 receives cmd $3E, configures DMAC, sets COMM1_LO bit 1 (ACK)
 *   4. 68K sees ACK, writes 320 bytes to FIFO (entity 256B + globals 64B)
 *   5. DMAC transfers FIFO → $0600F20C (entity) + $0600F30C (globals)
 *   6. SH2 clears COMM0_HI (idle)
 *
 * Entry: R8 = $20004020 (COMM base, set by dispatch loop)
 * Clobbers: R0-R4
 * Preserves: R5-R7, R15
 */

.section .text
.align 2

cmd3e_entity_transfer:
    /* Save PR for subroutine return */
    /* offset  0 */ sts.l   pr,@-r15

    /* === CONFIGURE DMAC CHANNEL 0 === */
    /* SAR0 = $20004012 (FIFO source, fixed) */
    /* offset  2 */ mov.l   @(.dmac_sar0,pc),r1
    /* offset  4 */ mov.l   @(.fifo_addr,pc),r0
    /* offset  6 */ mov.l   r0,@r1

    /* DAR0 = $0600F20C (entity working copy, auto-increment) */
    /* offset  8 */ mov.l   @(.dmac_dar0,pc),r1
    /* offset 10 */ mov.l   @(.entity_dst,pc),r0
    /* offset 12 */ mov.l   r0,@r1

    /* TCR0 = $00A0 (160 words = 320 bytes: 256B entity + 64B globals) */
    /* offset 14 */ mov.l   @(.dmac_tcr0,pc),r1
    /* offset 16 */ mov.l   @(.tcr_value,pc),r0
    /* offset 18 */ mov.l   r0,@r1

    /* CHCR0 = $000014E5 (enable, external request, word, dest inc) */
    /* offset 20 */ mov.l   @(.dmac_chcr0,pc),r1
    /* offset 22 */ mov.l   @(.chcr_value,pc),r0
    /* offset 24 */ mov.l   r0,@r1

    /* DMAOR = enable DMA (bit 0 = 1, no priority mode) */
    /* offset 26 */ mov.l   @(.dmac_dmaor,pc),r1
    /* offset 28 */ mov     #1,r0
    /* offset 30 */ mov.w   r0,@r1

    /* === SIGNAL ACK: set COMM1_LO bit 1 === */
    /* offset 32 */ mov.b   @(3,r8),r0       /* R0 = COMM1_LO */
    /* offset 34 */ or      #2,r0            /* set bit 1 (DMA ACK) */
    /* offset 36 */ mov.b   r0,@(3,r8)       /* COMM1_LO |= 2 */

    /* === WAIT FOR 68K TO FINISH FIFO WRITES === */
    /* Poll DREQ_LEN (at SH2 $20004010) until 0 */
    /* offset 38 */ mov.l   @(.dreq_len,pc),r1
.wait_done:
    /* offset 40 */ mov.w   @r1,r0
    /* offset 42 */ tst     r0,r0
    /* offset 44 */ bf      .wait_done

    /* === CLEANUP === */
    /* Clear COMM0_HI (idle) */
    /* offset 46 */ mov     #0,r0
    /* offset 48 */ mov.b   r0,@(0,r8)       /* COMM0_HI = 0 */

    /* === RETURN === */
    /* offset 50 */ lds.l   @r15+,pr
    /* offset 52 */ rts
    /* offset 54 */ nop                      /* delay slot */

/* === LITERAL POOL === */
.align 2
.dmac_sar0:
    .long   0xFFFFFF80              /* DMAC SAR0 register */
.fifo_addr:
    .long   0x20004012              /* DREQ FIFO (SH2 address, cache-through) */
.dmac_dar0:
    .long   0xFFFFFF84              /* DMAC DAR0 register */
.entity_dst:
    .long   0x0600F20C              /* Entity working copy (SDRAM, native) */
.dmac_tcr0:
    .long   0xFFFFFF88              /* DMAC TCR0 register */
.tcr_value:
    .long   0x000000A0              /* 160 transfers (= 320 bytes at word width: 256B entity + 64B globals) */
.dmac_chcr0:
    .long   0xFFFFFF8C              /* DMAC CHCR0 register */
.chcr_value:
    .long   0x000014E5              /* External request, word, dest auto-inc, enable */
.dmac_dmaor:
    .long   0xFFFFFFB0              /* DMA operation register */
.dreq_len:
    .long   0x20004010              /* DREQ Length register (SH2 side) */

/* Total: 56 bytes code + 40 bytes pool = 96 bytes */

.global cmd3e_entity_transfer
