; ============================================================================
; Sound Queue, Sprite Adjust, Advance
; ROM Range: $004638-$00464A (18 bytes)
; ============================================================================
; Queues sound $F2, moves sprite up by 6 pixels, advances state.
;
; Entry: none
; Uses: none
; ============================================================================

sound_sprite_advance:
        dc.w    $11FC,$00F2,$C822     ; MOVE.B #$F2,($C822).W - queue sound
        subq.w  #6,$00FF69E2          ; Move sprite up by 6
        dc.w    $5878,$C07C           ; ADDQ.W #4,($C07C).W
        rts
