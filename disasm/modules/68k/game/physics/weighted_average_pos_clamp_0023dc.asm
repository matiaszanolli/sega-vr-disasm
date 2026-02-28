; ============================================================================
; Weighted Average Position Clamp (Variant B)
; ROM Range: $0023DC-$00240C (48 bytes)
; ============================================================================
; Category: game
; Purpose: Computes weighted average: D1 = (D0×29/256 + $1A5E + *A1) / 2.
;   Clamps result to range [$1A5E, $21D0].
;   If D1 > $21D0 → branches to $00240C (external upper-clamp path).
;   If D1 in range → branches to $002410 (external store path).
;   If D1 ≤ $1A5E → clamps to $1A5E, stores to (A1) and $8760.
;   Same structure as weighted_average_pos_clamp_002426 but different coefficients and upper bound.
;
; Entry: D0 = input value, A1 = position pointer
; Uses: D0, D1, A1
; RAM:
;   $8760: output position (word)
; ============================================================================

weighted_average_pos_clamp_0023dc:
        lsr.w   #4,D0                           ; $0023DC  D0 = input >> 4
        move.w  D0,D1                           ; $0023DE  D1 = D0 (×1)
        lsr.w   #1,D0                           ; $0023E0  D0 >>= 1
        add.w   d0,d1                   ; $D240
        lsr.w   #1,D0                           ; $0023E4  D0 >>= 1
        add.w   d0,d1                   ; $D240
        lsr.w   #2,D0                           ; $0023E8  D0 >>= 2
        add.w   d0,d1                   ; $D240
        addi.w  #$1A5E,D1                       ; $0023EC  D1 += base ($1A5E)
        add.w   (A1),D1                         ; $0023F0  D1 += current value
        lsr.w   #1,D1                           ; $0023F2  D1 /= 2 (average)
        cmpi.w  #$21D0,D1                       ; $0023F4  D1 > max?
        bgt.s   randomized_sound_param_00240c    ; $0023F8  → upper clamp path
        cmpi.w  #$1A5E,D1                       ; $0023FA  D1 > min?
        bgt.s   randomized_sound_param_00240c+4 ; $0023FE  → store path (cmp.w in next fn)
        move.w  #$1A5E,D1                       ; $002400  clamp D1 = min
        move.w  D1,(A1)                         ; $002404  store to position
        move.w  (A1),($FFFF8760).w              ; $002406  copy to output
        rts                                     ; $00240A
