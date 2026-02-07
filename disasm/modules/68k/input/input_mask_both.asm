; ============================================================================
; Input Mask Both Players
; ROM Range: $0049EE-$004A0C (30 bytes)
; ============================================================================
; Masks both player inputs to keep direction bits only, clears extended.
;
; Entry: none
; Uses: none
; ============================================================================

input_mask_both:
        dc.w    $0278,$FF80,$C86C     ; ANDI.W #$FF80,($C86C).W - P1 mask
        dc.w    $0278,$FF80,$C86E     ; ANDI.W #$FF80,($C86E).W - P2 mask
        dc.w    $21FC,$FFFF,$0000,$C970 ; MOVE.L #$FFFF0000,($C970).W
        dc.w    $21FC,$FFFF,$0000,$C974 ; MOVE.L #$FFFF0000,($C974).W
        rts
