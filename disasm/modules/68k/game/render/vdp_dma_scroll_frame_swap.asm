; ============================================================================
; VDP DMA + Scroll + Frame Swap
; ROM Range: $001F4A-$002010 (198 bytes)
; ============================================================================
; Writes H-scroll and V-scroll data to VDP, then performs DMA to
; CRAM with Z80 bus synchronization. After DMA, checks COMM1 flag
; and optionally: resets game_state, transfers palette via MARS CRAM,
; and toggles frame buffer.
;
; Entry: A5 = VDP control port, A6 = VDP data port
; Uses: D0, D4, A1, A2, A5, A6
; RAM:
;   $8000: hscroll_a
;   $8002: hscroll_b
;   $C80C: frame_toggle
;   $C874: vdp_reg_cache
;   $C876: dma_trigger
;   $C87E: game_state
;   $C880: vscroll_a
;   $C882: vscroll_b
; Calls:
;   $0048D6: palette_copy_a (JSR PC-relative)
;   $0048DA: palette_copy_b (JSR PC-relative)
; ============================================================================

vdp_dma_scroll_frame_swap:
        move.w  (a5),d0                         ; read VDP status
; --- write scroll data ---
        move.l  #$6C000003,(a5)                 ; VRAM write: H-scroll table
        move.w  ($FFFF8000).w,(a6)              ; write hscroll_a
        move.w  ($FFFF8002).w,(a6)              ; write hscroll_b
        move.l  #$40000010,(a5)                 ; VSRAM write
        move.w  ($FFFFC880).w,(a6)              ; write vscroll_a
        move.w  ($FFFFC882).w,(a6)              ; write vscroll_b
; --- request Z80 bus ---
        move.w  #$0100,Z80_BUSREQ
.wait_z80:
        btst    #0,Z80_BUSREQ
        bne.s   .wait_z80
; --- VDP DMA to CRAM ---
        move.w  ($FFFFC874).w,d4                ; vdp_reg_cache
        bset    #4,d4                           ; enable DMA
        move.w  d4,(a5)                         ; write mode register
        move.l  #$93209400,(a5)                 ; DMA length
        move.l  #$954096C2,(a5)                 ; DMA source low+mid
        move.w  #$977F,(a5)                     ; DMA source high
        move.w  #$C000,(a5)                     ; DMA dest = CRAM $0000
        move.w  #$0080,($FFFFC876).w            ; dma_trigger value
        move.w  ($FFFFC876).w,(a5)              ; trigger DMA
        move.w  ($FFFFC874).w,(a5)              ; restore mode register (DMA off)
        move.w  #$0000,Z80_BUSREQ               ; release Z80 bus
; --- check COMM1 game state flag ---
        btst    #0,COMM1_LO
        beq.s   .done                            ; no flag → skip
        bclr    #0,COMM1_LO                     ; clear flag
        move.w  #$0000,($FFFFC87E).w            ; reset game_state
; --- MARS CRAM palette transfer ---
        bclr    #7,MARS_SYS_INTCTL              ; request MARS access
.wait_mars:
        btst    #7,$00A1518A
        beq.s   .wait_mars
        lea     $00FF6E00,a1                    ; palette source
        lea     MARS_CRAM,a2                    ; MARS CRAM dest
        dc.w    $4EBA,$28F0                      ; jsr palette_copy_a(pc) → $0048D6
        dc.w    $4EBA,$28F0                      ; jsr palette_copy_b(pc) → $0048DA
; --- toggle frame buffer ---
        bchg    #0,($FFFFC80C).w                ; flip frame_toggle
        bne.s   .frame_1
        bset    #0,$00A1518B                    ; select frame 0
        bra.s   .enable_mars
.frame_1:
        bclr    #0,$00A1518B                    ; select frame 1
.enable_mars:
        bset    #7,MARS_SYS_INTCTL              ; release MARS access
.done:
        rts
