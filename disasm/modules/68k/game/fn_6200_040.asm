; ============================================================================
; Increment Object Counter + Return $10
; ROM Range: $007AA2-$007AAA (8 bytes)
; ============================================================================
; Increments the object pending counter at $C31A and returns D0 = $10.
; One of three related functions (038/039/040) returning different codes.
;
; Memory:
;   $FFFFC31A = object pending counter (byte, incremented)
; Entry: none | Exit: D0 = $10 | Uses: D0
; ============================================================================

fn_6200_040:
        addq.b  #1,($FFFFC31A).w               ; $007AA2: $5238 $C31A — increment counter
        moveq   #$10,d0                         ; $007AA6: $7010 — return code $10
        rts                                     ; $007AA8: $4E75
