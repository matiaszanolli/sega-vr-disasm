; ============================================================================
; Input Clear Both Players
; ROM Range: $0049AA-$0049C8 (30 bytes)
; ============================================================================
; Clears input buffers for both players.
;
; Entry: none
; Uses: none
; ============================================================================

input_clear_both:
        dc.w    $31FC,$FF00,$C86C     ; MOVE.W #$FF00,($C86C).W - P1 input
        dc.w    $31FC,$FF00,$C86E     ; MOVE.W #$FF00,($C86E).W - P2 input
        dc.w    $21FC,$FFFF,$0000,$C970 ; MOVE.L #$FFFF0000,($C970).W - P1 ext
        dc.w    $21FC,$FFFF,$0000,$C974 ; MOVE.L #$FFFF0000,($C974).W - P2 ext
        rts
