; ============================================================================
; VDP DMA + Palette Transfer 036
; ROM Range: $001C66-$001D0C (166 bytes)
; ============================================================================
; Category: sh2
; Purpose: Performs VDP register writes, DMA transfer, and palette copy
;   Writes scroll/color data, sets up VDP DMA from ROM to VRAM
;   Toggles frame buffer via adapter control register
;   Calls PaletteRAMCopy if COMM0 is clear (SH2 not busy)
;
; Uses: D0, D4, A5, A6
; RAM:
;   $8000: vdp_scroll_h
;   $8002: vdp_scroll_v
;   $C874: vdp_reg_cache
;   $C876: vdp_dma_ctrl
;   $C880: vdp_color_a
;   $C882: vdp_color_b
;   $C80C: frame_toggle
; Calls:
;   $002878: PaletteRAMCopy
; Confidence: high
; ============================================================================

vdp_dma_palette_xfer_036:
        move.w  (A5),D0                         ; $001C66  save VDP status
        move.l  #$6C000003,(A5)                 ; $001C68  VDP reg: scroll address
        move.w  ($FFFF8000).w,(A6)              ; $001C6E  write scroll_h
        move.w  ($FFFF8002).w,(A6)              ; $001C72  write scroll_v
        move.l  #$40000010,(A5)                 ; $001C76  VDP reg: color address
        move.w  ($FFFFC880).w,(A6)              ; $001C7C  write color_a
        move.w  ($FFFFC882).w,(A6)              ; $001C80  write color_b
; --- request Z80 bus ---
        move.w  #$0100,Z80_BUSREQ               ; $001C84
.wait_z80:
        btst    #0,Z80_BUSREQ                   ; $001C8C  Z80 bus granted?
        bne.s   .wait_z80                       ; $001C94  no → wait
; --- VDP DMA setup ---
        move.w  ($FFFFC874).w,D4                ; $001C96  D4 = vdp_reg_cache
        bset    #4,D4                           ; $001C9A  enable DMA bit
        move.w  D4,(A5)                         ; $001C9E  write mode register
        move.l  #$93409400,(A5)                 ; $001CA0  DMA length = $0040
        move.l  #$954096C2,(A5)                 ; $001CA6  DMA source = $D845 << 1
        move.w  #$977F,(A5)                     ; $001CAC  DMA source high = $7F
        move.w  #$C000,(A5)                     ; $001CB0  DMA dest = CRAM $0000
        move.w  #$0080,($FFFFC876).w            ; $001CB4  vdp_dma_ctrl = $0080
        move.w  ($FFFFC876).w,(A5)              ; $001CBA  trigger DMA
        move.w  ($FFFFC874).w,(A5)              ; $001CBE  restore mode register
; --- release Z80 bus ---
        move.w  #$0000,Z80_BUSREQ               ; $001CC2  release Z80
; --- palette copy if SH2 idle ---
        tst.b   COMM0_HI                        ; $001CCA  SH2 busy?
        bne.s   .exit                           ; $001CD0  yes → skip
        bclr    #7,MARS_SYS_INTCTL              ; $001CD2  clear CMD INT
.wait_ack:
        btst    #7,$00A1518A                    ; $001CDA  CMD INT acknowledged?
        beq.s   .wait_ack                       ; $001CE2  no → wait
        jsr     v_int_cram_xfer_gate(pc); $4EBA $0B92
; --- toggle frame buffer ---
        bchg    #0,($FFFFC80C).w                ; $001CE8  flip frame_toggle
        bne.s   .set_buf_1                      ; $001CEE  was 1 → set buf 1
        bset    #0,$00A1518B                    ; $001CF0  adapter: select buffer 0
        bra.s   .restore_int                    ; $001CF8
.set_buf_1:
        bclr    #0,$00A1518B                    ; $001CFA  adapter: select buffer 1
.restore_int:
        bset    #7,MARS_SYS_INTCTL              ; $001D02  re-enable CMD INT
.exit:
        rts                                     ; $001D0A
