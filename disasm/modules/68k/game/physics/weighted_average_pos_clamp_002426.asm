; ============================================================================
; Weighted Average Position Clamp
; ROM Range: $002426-$002452 (44 bytes)
; ============================================================================
; Category: game
; Purpose: Computes weighted average: D1 = (D0×7/64 + $1A5E + *A1) / 2.
;   Clamps result to range [$1A5E, $21A0].
;   If D1 > $21A0 → branches to $002452 (external upper-clamp path).
;   If D1 in range → branches to $002456 (external store path).
;   If D1 ≤ $1A5E → clamps to $1A5E, stores to (A1) and $8760.
;
; Entry: D0 = input value, A1 = position pointer
; Uses: D0, D1, A1
; RAM:
;   $8760: output position (word)
; ============================================================================

weighted_average_pos_clamp_002426:
        lsr.w   #4,D0                           ; $002426  D0 = input >> 4
        move.w  D0,D1                           ; $002428  D1 = D0 (×1)
        lsr.w   #1,D0                           ; $00242A  D0 >>= 1
        dc.w    $D240                           ; $00242C  add.w d0,d1 — D1 += D0 (×1.5)
        lsr.w   #1,D0                           ; $00242E  D0 >>= 1
        dc.w    $D240                           ; $002430  add.w d0,d1 — D1 += D0 (×1.75 ≈ 7/64)
        addi.w  #$1A5E,D1                       ; $002432  D1 += base ($1A5E)
        add.w   (A1),D1                         ; $002436  D1 += current value
        lsr.w   #1,D1                           ; $002438  D1 /= 2 (average)
        cmpi.w  #$21A0,D1                       ; $00243A  D1 > max?
        dc.w    $6E12                           ; $00243E  bgt.s $002452 → external upper path
        cmpi.w  #$1A5E,D1                       ; $002440  D1 > min?
        dc.w    $6E10                           ; $002444  bgt.s $002456 → external store path
        move.w  #$1A5E,D1                       ; $002446  clamp D1 = min
        move.w  D1,(A1)                         ; $00244A  store to position
        move.w  (A1),($FFFF8760).w              ; $00244C  copy to output
        rts                                     ; $002450
