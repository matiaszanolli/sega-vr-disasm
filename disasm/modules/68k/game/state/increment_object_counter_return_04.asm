; ============================================================================
; Increment Object Counter + Return $04
; ROM Range: $007A92-$007A9A (8 bytes)
; ============================================================================
; Increments the object pending counter at $C31A and returns D0 = $04.
; One of three related functions (038/039/040) returning different codes.
;
; Memory:
;   $FFFFC31A = object pending counter (byte, incremented)
; Entry: none | Exit: D0 = $04 | Uses: D0
; ============================================================================

increment_object_counter_return_04:
        addq.b  #1,($FFFFC31A).w               ; $007A92: $5238 $C31A — increment counter
        moveq   #$04,d0                         ; $007A96: $7004 — return code $04
        rts                                     ; $007A98: $4E75
