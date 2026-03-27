/*
 * cmd3e_entity_transfer — VR60 Phase 3A: DREQ-based Entity Transfer
 * Expansion ROM Address: $301600 (SH2: $02301600)
 *
 * Configures SH2 DMAC channel 0 to receive data from the 68K via DREQ FIFO.
 * Supports two modes selected by COMM3_HI:
 *
 * Mode 0 (COMM3_HI = $00): Full entity+globals transfer (320 bytes)
 *   DAR0 = $0600F20C, TCR0 = $00A0 (160 words)
 *   Data: 256B entity + 64B globals → $0600F20C-$0600F34B
 *
 * Mode 1 (COMM3_HI = $01): Globals-only transfer (64 bytes)
 *   DAR0 = $0600F30C, TCR0 = $0020 (32 words)
 *   Data: 64B globals → $0600F30C-$0600F34B
 *
 * Protocol:
 *   1. 68K sets DREQ_LEN, DREQ_CTRL = $04 (CPU write)
 *   2. 68K writes COMM3_HI = mode, COMM0_LO = $3E, COMM0_HI = $01
 *   3. SH2 reads COMM3_HI, configures DMAC, sets COMM1_LO bit 1 (ACK)
 *   4. 68K sees ACK, writes data to FIFO
 *   5. DMAC transfers FIFO → SDRAM
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

    /* === CHECK MODE: COMM3_HI selects transfer type === */
    /* Mode 0: entity+globals (320B → $0600F20C) */
    /* Mode 1: globals-only (64B → $0600F30C) */
    /* Mode 2: AI entities (3840B → $06010000) — Phase 4 */
    /* offset  2 */ mov.b   @(6,r8),r0       /* R0 = COMM3_HI (mode byte) */
    /* offset  4 */ tst     r0,r0            /* mode == 0? */
    /* offset  6 */ bf      .check_mode1     /* non-zero: check further */

    /* === MODE 0: PLAYER ENTITY + GLOBALS (320B) === */
    mov.l   @(.dmac_sar0,pc),r1
    mov.l   @(.fifo_addr,pc),r0
    mov.l   r0,@r1
    mov.l   @(.dmac_dar0,pc),r1
    mov.l   @(.entity_dst,pc),r0
    mov.l   r0,@r1
    mov.l   @(.dmac_tcr0,pc),r1
    mov.l   @(.tcr_full,pc),r0
    mov.l   r0,@r1
    bra     .configure_chcr
    nop

.check_mode1:
    mov     #1,r1
    cmp/eq  r1,r0                /* mode == 1? */
    bf      .ai_entities         /* mode 2+: AI entities */

    /* === MODE 1: GLOBALS-ONLY (64B) === */
    mov.l   @(.dmac_sar0,pc),r1
    mov.l   @(.fifo_addr,pc),r0
    mov.l   r0,@r1
    mov.l   @(.dmac_dar0,pc),r1
    mov.l   @(.globals_dst,pc),r0
    mov.l   r0,@r1
    mov.l   @(.dmac_tcr0,pc),r1
    mov.l   @(.tcr_globals,pc),r0
    mov.l   r0,@r1
    bra     .configure_chcr
    nop

.ai_entities:
    /* === MODE 2: AI ENTITIES (3840B → $06010000) === */
    mov.l   @(.dmac_sar0,pc),r1
    mov.l   @(.fifo_addr,pc),r0
    mov.l   r0,@r1
    mov.l   @(.dmac_dar0,pc),r1
    mov.l   @(.ai_dst,pc),r0
    mov.l   r0,@r1
    mov.l   @(.dmac_tcr0,pc),r1
    mov.l   @(.tcr_ai,pc),r0
    mov.l   r0,@r1

.configure_chcr:

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
.globals_dst:
    .long   0x0600F30C              /* Globals base (entity + 256, SDRAM native) */
.dmac_tcr0:
    .long   0xFFFFFF88              /* DMAC TCR0 register */
.tcr_full:
    .long   0x000000A0              /* 160 transfers (= 320 bytes: 256B entity + 64B globals) */
.tcr_globals:
    .long   0x00000020              /* 32 transfers (= 64 bytes: globals only) */
.ai_dst:
    .long   0x06010000              /* AI entity base (SDRAM, 15 × 256B) */
.tcr_ai:
    .long   0x00000780              /* 1920 transfers (= 3840 bytes: 15 AI entities) */
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
