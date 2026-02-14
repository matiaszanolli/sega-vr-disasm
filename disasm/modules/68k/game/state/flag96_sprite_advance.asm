; ============================================================================
; Flag $96, Sprite Adjust, Advance
; ROM Range: $00464A-$00465C (18 bytes)
; ============================================================================
; Sets effect code $96, moves sprite up by 6 pixels, advances state.
;
; Entry: none
; Uses: none
; ============================================================================

flag96_sprite_advance:
        move.b  #$96,($FFFFC8A5).w      ; $11FC $0096 $C8A5
        subq.w  #6,$00FF69E2          ; Move sprite up by 6
        addq.w  #4,($FFFFC07C).w        ; $5878 $C07C
        rts
