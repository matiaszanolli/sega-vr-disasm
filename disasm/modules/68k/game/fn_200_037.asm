; ============================================================================
; VDP DMA + Frame Swap 037
; ROM Range: $001D0C-$001DBE (178 bytes)
; ============================================================================
; Category: sh2
; Purpose: Performs VDP register writes, DMA transfer, and frame buffer swap
;   Similar to fn_200_036 but checks COMM1 for game state reset
;   Clears game_state and toggles frame buffer on COMM1 signal
;
; Uses: D0, D4, A5, A6
; RAM:
;   $8000: vdp_scroll_h
;   $8002: vdp_scroll_v
;   $C874: vdp_reg_cache
;   $C876: vdp_dma_ctrl
;   $C880: vdp_color_a
;   $C882: vdp_color_b
;   $C87E: game_state
;   $C80C: frame_toggle
; Confidence: high
; ============================================================================

fn_200_037:
        move.w  (A5),D0                         ; $001D0C  save VDP status
        move.l  #$6C000003,(A5)                 ; $001D0E  VDP reg: scroll address
        move.w  ($FFFF8000).w,(A6)              ; $001D14  write scroll_h
        move.w  ($FFFF8002).w,(A6)              ; $001D18  write scroll_v
        move.l  #$40000010,(A5)                 ; $001D1C  VDP reg: color address
        move.w  ($FFFFC880).w,(A6)              ; $001D22  write color_a
        move.w  ($FFFFC882).w,(A6)              ; $001D26  write color_b
; --- request Z80 bus ---
        move.w  #$0100,Z80_BUSREQ               ; $001D2A
.wait_z80:
        btst    #0,Z80_BUSREQ                   ; $001D32  Z80 bus granted?
        bne.s   .wait_z80                       ; $001D3A  no → wait
; --- VDP DMA setup ---
        move.w  ($FFFFC874).w,D4                ; $001D3C  D4 = vdp_reg_cache
        bset    #4,D4                           ; $001D40  enable DMA bit
        move.w  D4,(A5)                         ; $001D44  write mode register
        move.l  #$93409400,(A5)                 ; $001D46  DMA length = $0040
        move.l  #$954096C2,(A5)                 ; $001D4C  DMA source = $D845 << 1
        move.w  #$977F,(A5)                     ; $001D52  DMA source high = $7F
        move.w  #$C000,(A5)                     ; $001D56  DMA dest = CRAM $0000
        move.w  #$0080,($FFFFC876).w            ; $001D5A  vdp_dma_ctrl = $0080
        move.w  ($FFFFC876).w,(A5)              ; $001D60  trigger DMA
        move.w  ($FFFFC874).w,(A5)              ; $001D64  restore mode register
; --- release Z80 bus ---
        move.w  #$0000,Z80_BUSREQ               ; $001D68  release Z80
; --- check COMM1 for game state reset ---
        btst    #0,COMM1_LO                    ; $001D70  COMM1 bit 0?
        beq.s   .exit                           ; $001D78  no → done
        bclr    #0,COMM1_LO                    ; $001D7A  clear COMM1 bit 0
        move.w  #$0000,($FFFFC87E).w            ; $001D82  game_state = 0
        bclr    #7,MARS_SYS_INTCTL              ; $001D88  clear CMD INT
.wait_ack:
        btst    #7,$00A1518A                    ; $001D90  CMD INT acknowledged?
        beq.s   .wait_ack                       ; $001D98  no → wait
; --- toggle frame buffer ---
        bchg    #0,($FFFFC80C).w                ; $001D9A  flip frame_toggle
        bne.s   .set_buf_1                      ; $001DA0  was 1 → set buf 1
        bset    #0,$00A1518B                    ; $001DA2  adapter: select buffer 0
        bra.s   .restore_int                    ; $001DAA
.set_buf_1:
        bclr    #0,$00A1518B                    ; $001DAC  adapter: select buffer 1
.restore_int:
        bset    #7,MARS_SYS_INTCTL              ; $001DB4  re-enable CMD INT
.exit:
        rts                                     ; $001DBC
