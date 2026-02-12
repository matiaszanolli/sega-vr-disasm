; ============================================================================
; Randomized Sound Parameter (Base $21A0)
; ROM Range: $002452-$00246C (26 bytes)
; ============================================================================
; Loads base value $21A0 into D1. If current value at (A1) matches
; the base, calls random_number_gen, masks to 0-15, and subtracts
; from D1 to add jitter. Stores D1 to (A1) and copies to sound
; register $8760.
;
; Memory:
;   $FFFF8760 = sound register (word, updated)
; Entry: A1 = parameter pointer | Exit: sound param updated | Uses: D0, D1
; ============================================================================

fn_2200_012:
        move.w  #$21A0,d1                       ; $002452: $323C $21A0 — base value
        cmp.w   (a1),d1                         ; $002456: $B251 — compare with current
        bne.s   .store                          ; $002458: $660A — different → just store
        dc.w    $4EBA,$2512                     ; BSR.W $00496E ; $00245A: — call random_number_gen
        andi.w  #$000F,d0                       ; $00245E: $0240 $000F — mask to 0-15
        sub.w   d0,d1                           ; $002462: $9240 — D1 = D1 - D0 (add jitter)
.store:
        move.w  d1,(a1)                         ; $002464: $3281 — store to parameter
        move.w  (a1),($FFFF8760).w              ; $002466: $31D1 $8760 — copy to sound register
        rts                                     ; $00246A: $4E75

