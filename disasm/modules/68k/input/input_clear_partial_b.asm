; ============================================================================
; Input Clear P2 + P2 Extended
; ROM Range: $0049DE-$0049EE (16 bytes)
; ============================================================================
; Clears P2 input lower byte and P2 extended input.
;
; Entry: none
; Uses: none
; ============================================================================

input_clear_partial_b:
        dc.w    $31FC,$FF00,$C86E     ; MOVE.W #$FF00,($C86E).W - P2
        dc.w    $21FC,$FFFF,$0000,$C974 ; MOVE.L #$FFFF0000,($C974).W - P2 ext
        rts
