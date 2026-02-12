; ============================================================================
; Fade Level Increment (Brightness Up)
; ROM Range: $01482E-$014848 (26 bytes)
; ============================================================================
; Reads the fade level from $C888 (long), increments by 8, and
; clamps at $00FFFFFF (maximum). Writes the result back.
;
; Memory:
;   $FFFFC888 = fade level (long, incremented by 8, max $00FFFFFF)
; Entry: none | Exit: fade level incremented | Uses: D0
; ============================================================================

fn_14200_034:
        move.l  ($FFFFC888).w,d0                ; $01482E: $2038 $C888 — load fade level
        addq.l  #8,d0                           ; $014832: $5080 — increment
        cmpi.l  #$00FFFFFF,d0                   ; $014834: $0C80 $00FF $FFFF — at max?
        ble.s   .write                          ; $01483A: $6F06 — no → write
        move.l  #$00FF0000,d0                   ; $01483C: $203C $00FF $0000 — clamp to base
.write:
        move.l  d0,($FFFFC888).w                ; $014842: $21C0 $C888 — store fade level
        rts                                     ; $014846: $4E75

