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
        move.b  #$F2,($FFFFC822).w      ; $11FC $00F2 $C822 — queue sound
        subq.w  #6,$00FF69E2          ; Move sprite up by 6
        addq.w  #4,($FFFFC07C).w        ; $5878 $C07C
        rts
