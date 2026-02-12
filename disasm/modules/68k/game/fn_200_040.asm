; ============================================================================
; VDP DMA + CRAM Transfer
; ROM Range: $001E94-$001F4A (182 bytes)
; ============================================================================
; Performs VDP DMA to CRAM with Z80 bus synchronization. After DMA,
; checks COMM1 flag and optionally: resets game_state (if state=$18),
; transfers palette via MARS CRAM, and toggles frame buffer.
;
; Entry: A5 = VDP control port
; Uses: D0, D4, A1, A2, A5
; RAM:
;   $C80C: frame_toggle
;   $C874: vdp_reg_cache
;   $C876: dma_trigger
;   $C87E: game_state
;   $C8C4: frame_counter
;   $C8C5: state_check_val
; Calls:
;   $0048D6: palette_copy_a (JSR PC-relative)
;   $0048DA: palette_copy_b (JSR PC-relative)
; ============================================================================

fn_200_040:
        move.w  (a5),d0                         ; read VDP status
        move.w  #$0100,Z80_BUSREQ
.wait_z80:
        btst    #0,Z80_BUSREQ
        bne.s   .wait_z80
; --- VDP DMA to CRAM ---
        move.w  ($FFFFC874).w,d4                ; vdp_reg_cache
        bset    #4,d4                           ; enable DMA
        move.w  d4,(a5)                         ; write mode register
        move.l  #$93209400,(a5)                 ; DMA length
        move.l  #$950096D8,(a5)                 ; DMA source low+mid
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
        cmpi.b  #$18,($FFFFC8C5).w              ; state = $18?
        bne.s   .palette_update
        move.w  #$0000,($FFFFC87E).w            ; reset game_state
.palette_update:
        move.b  #$00,($FFFFC8C4).w              ; clear frame_counter
; --- MARS CRAM palette transfer ---
        bclr    #7,MARS_SYS_INTCTL              ; request MARS access
.wait_mars:
        btst    #7,$00A1518A
        beq.s   .wait_mars
        lea     ($FFFFB400).w,a1                ; palette source
        lea     MARS_CRAM,a2                    ; MARS CRAM dest
        dc.w    $4EBA,$29B6                      ; jsr palette_copy_a(pc) → $0048D6
        dc.w    $4EBA,$29B6                      ; jsr palette_copy_b(pc) → $0048DA
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
