; ============================================================================
; VDP DMA Transfer + VRAM Clear (10-Word Data Prefix)
; ROM Range: $001034-$0010C4 (144 bytes)
; ============================================================================
; Category: game
; Purpose: Data prefix: 10 words — VDP DMA config or padding.
;   Code: Disables interrupts, requests Z80 bus, sets VDP regs ($C81C
;   with bit 4 set, DMA regs $8F01/$93FF/$94FF/$9780), writes zero to
;   VRAM $0000 via DMA, polls DMA complete, restores VDP reg $8F02
;   and $C81C, releases Z80 bus, restores SR. Calls handler at $10AC,
;   sets VDP CRAM $40000010, tail-jumps to $48A8. Includes handlers
;   for VSRAM clear ($10AC) and nametable clear ($10B8).
;
; Uses: D0, D1, D3, D4, D7, A5, A6
; RAM:
;   $C874: vdp_reg (word, read and modified)
; Calls:
;   $0048A8: cram_handler
;   $004888: vsram_handler
; ============================================================================

vdp_dma_xfer_vram_clear:
; --- data prefix: 10 words ---
        dc.w    $0424,$283C,$0679,$0000,$0000   ; $001034
        dc.w    $0700,$813B,$0002,$0300,$0000   ; $00103E
; --- code: VDP DMA transfer ---
        move    SR,-(A7)                        ; $001048  save SR
        move    #$2700,SR                       ; $00104A  disable interrupts
        move.w  #$0100,Z80_BUSREQ               ; $00104E  request Z80 bus
.wait_bus:
        btst    #0,Z80_BUSREQ                   ; $001056  bus granted?
        bne.s   .wait_bus                       ; $00105E  no → wait
        move.w  ($FFFFC874).w,D4                ; $001060  D4 = vdp_reg
        bset    #4,D4                           ; $001064  set bit 4
        move.w  D4,(A5)                         ; $001068  write VDP reg
        move.w  #$8F01,(A5)                     ; $00106A  VDP autoincrement = 1
        move.l  #$93FF94FF,(A5)                 ; $00106E  DMA len = $FFFF
        move.w  #$9780,(A5)                     ; $001074  DMA mode = VRAM fill
        move.l  #$40000080,(A5)                 ; $001078  VDP addr = VRAM $0000 (write)
        move.w  #$0000,(A6)                     ; $00107E  write zero (DMA fill value)
.wait_dma:
        move.w  (A5),D7                         ; $001082  D7 = VDP status
        andi.w  #$0002,D7                       ; $001084  DMA active?
        bne.s   .wait_dma                       ; $001088  yes → wait
        move.w  #$8F02,(A5)                     ; $00108A  VDP autoincrement = 2
        move.w  ($FFFFC874).w,(A5)              ; $00108E  restore vdp_reg
        move.w  #$0000,Z80_BUSREQ               ; $001092  release Z80 bus
        move    (A7)+,SR                        ; $00109A  restore SR
        jsr     vdp_dma_xfer_vram_clear+120(pc); $4EBA $000E
        move.l  #$40000010,(A5)                 ; $0010A0  VDP addr = CRAM $0000
        moveq   #$00,D1                         ; $0010A6  D1 = 0
        jmp     fast_fill_128_fixed+32(pc); $4EFA $37FE
; --- vsram_clear ---
        move.l  #$C0000000,(A5)                 ; $0010AC  VDP addr = VSRAM $0000
        moveq   #$00,D1                         ; $0010B2  D1 = 0
        jmp     fast_fill_128_fixed(pc) ; $4EFA $37D2
; --- nametable_clear ---
        moveq   #$00,D1                         ; $0010B8  D1 = 0
        move.l  #$72000003,(A5)                 ; $0010BA  VDP addr = VRAM $7200
        move.l  D1,(A6)                         ; $0010C0  write zero
        rts                                     ; $0010C2
