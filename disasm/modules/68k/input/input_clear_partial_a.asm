; ============================================================================
; Input Clear Both + P1 Extended
; ROM Range: $0049C8-$0049DE (22 bytes)
; ============================================================================
; Clears P1+P2 input lower bytes and P1 extended input.
;
; Entry: none
; Uses: none
; ============================================================================

input_clear_partial_a:
        dc.w    $31FC,$FF00,$C86C     ; MOVE.W #$FF00,($C86C).W - P1
        dc.w    $31FC,$FF00,$C86E     ; MOVE.W #$FF00,($C86E).W - P2
        dc.w    $21FC,$FFFF,$0000,$C970 ; MOVE.L #$FFFF0000,($C970).W - P1 ext
        rts
