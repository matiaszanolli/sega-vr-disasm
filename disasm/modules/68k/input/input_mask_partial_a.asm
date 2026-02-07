; ============================================================================
; Input Mask Both + P1 Extended Clear
; ROM Range: $004A0C-$004A22 (22 bytes)
; ============================================================================
; Masks P1+P2 inputs, clears P1 extended input.
;
; Entry: none
; Uses: none
; ============================================================================

input_mask_partial_a:
        dc.w    $0278,$FF80,$C86C     ; ANDI.W #$FF80,($C86C).W
        dc.w    $0278,$FF80,$C86E     ; ANDI.W #$FF80,($C86E).W
        dc.w    $21FC,$FFFF,$0000,$C970 ; MOVE.L #$FFFF0000,($C970).W
        rts
