; ============================================================================
; VDP Fill Pattern
; ROM Range: $00281E-$00284A (46 bytes)
; ============================================================================
; Fills a VDP region at address $1F00 with pattern $0101.
;
; Entry: none
; Uses: A2, A3, A4, D0, D1
; ============================================================================

vdp_fill_pattern:
        lea     $00A15100,a4          ; MARS system base
        lea     $00A15186,a2          ; VDP fill address register
        lea     $00A15188,a3          ; VDP fill data register
        move.w  #$1F00,d1             ; Fill address
        move.w  #$0101,d0             ; Fill pattern
        move.w  #$00FF,$0084(a4)      ; Auto-increment
        move.w  d1,(a2)               ; Set address
        move.w  d0,(a3)               ; Write fill data
.busy_wait:
        btst    #1,$008B(a4)          ; Check fill busy
        bne.s   .busy_wait            ; Wait until done
        rts
