; ============================================================================
; Input Mask P2 + P2 Extended Clear
; ROM Range: $004A22-$004A32 (16 bytes)
; ============================================================================
; Masks P2 input, clears P2 extended input.
;
; Entry: none
; Uses: none
; ============================================================================

input_mask_partial_b:
        dc.w    $0278,$FF80,$C86E     ; ANDI.W #$FF80,($C86E).W
        dc.w    $21FC,$FFFF,$0000,$C974 ; MOVE.L #$FFFF0000,($C974).W
        rts
