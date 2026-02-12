; ============================================================================
; Randomized Sound Parameter (Base $1E00)
; ROM Range: $0023C2-$0023DC (26 bytes)
; ============================================================================
; Loads base value $1E00 into D1. If current value at (A1) matches
; the base, calls random_number_gen, masks to 0-15, and subtracts
; from D1 to add jitter. Stores D1 to (A1) and copies to sound
; register $8760.
;
; Memory:
;   $FFFF8760 = sound register (word, updated)
; Entry: A1 = parameter pointer | Exit: sound param updated | Uses: D0, D1
; ============================================================================

fn_2200_008:
        move.w  #$1E00,d1                       ; $0023C2: $323C $1E00 — base value
        cmp.w   (a1),d1                         ; $0023C6: $B251 — compare with current
        bne.s   .store                          ; $0023C8: $660A — different → just store
        dc.w    $4EBA,$25A2                     ; BSR.W $00496E ; $0023CA: — call random_number_gen
        andi.w  #$000F,d0                       ; $0023CE: $0240 $000F — mask to 0-15
        sub.w   d0,d1                           ; $0023D2: $9240 — D1 = D1 - D0 (add jitter)
.store:
        move.w  d1,(a1)                         ; $0023D4: $3281 — store to parameter
        move.w  (a1),($FFFF8760).w              ; $0023D6: $31D1 $8760 — copy to sound register
        rts                                     ; $0023DA: $4E75

