; ============================================================================
; Increment Object Counter + Return $08
; ROM Range: $007A9A-$007AA2 (8 bytes)
; ============================================================================
; Increments the object pending counter at $C31A and returns D0 = $08.
; One of three related functions (038/039/040) returning different codes.
;
; Memory:
;   $FFFFC31A = object pending counter (byte, incremented)
; Entry: none | Exit: D0 = $08 | Uses: D0
; ============================================================================

fn_6200_039:
        addq.b  #1,($FFFFC31A).w               ; $007A9A: $5238 $C31A — increment counter
        moveq   #$08,d0                         ; $007A9E: $7008 — return code $08
        rts                                     ; $007AA0: $4E75
