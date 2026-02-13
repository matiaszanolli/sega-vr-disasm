; ============================================================================
; Fade Level Decrement (Brightness Down)
; ROM Range: $014848-$014862 (26 bytes)
; ============================================================================
; Reads the fade level from $C888 (long), decrements by 8, and
; clamps at minimum $00FF6000. Writes the result back.
;
; Memory:
;   $FFFFC888 = fade level (long, decremented by 8, min $00FF6000)
; Entry: none | Exit: fade level decremented | Uses: D0
; ============================================================================

fade_level_dec:
        move.l  ($FFFFC888).w,d0                ; $014848: $2038 $C888 — load fade level
        subq.l  #8,d0                           ; $01484C: $5180 — decrement
        cmpi.l  #$00FF6000,d0                   ; $01484E: $0C80 $00FF $6000 — at min?
        bge.s   .write                          ; $014854: $6C06 — no → write
        move.l  #$00FFFFF7,d0                   ; $014856: $203C $00FF $FFF7 — clamp to ceiling
.write:
        move.l  d0,($FFFFC888).w                ; $01485C: $21C0 $C888 — store fade level
        rts                                     ; $014860: $4E75

