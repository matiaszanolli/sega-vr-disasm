; ============================================================================
; weighted_timer_average_b — Weighted Timer Average B
; ROM Range: $0022EC-$002314 (40 bytes)
; ============================================================================
; Computes weighted average for frame timing smoothing:
;   D1 = (D0/16) * ~1.5 + $1A5E, then average with (A1): D1 = (D1 + (A1))/2
; Clamps result to range [$1A5E, $21A0]. Stores result to (A1).
; Narrower range variant (upper bound $21A0 vs $21D0 in weighted_timer_average_a).
;
; Entry: D0 = raw timing input, A1 = timer storage pointer
; Exit: D1 = smoothed timing value, (A1) = updated
; Uses: D0, D1, A1
; ============================================================================

weighted_timer_average_b:
        LSR.W  #4,D0                            ; $0022EC
        MOVE.W  D0,D1                           ; $0022EE
        LSR.W  #1,D0                            ; $0022F0
        ADD.W   D0,D1                           ; $0022F2
        LSR.W  #1,D0                            ; $0022F4
        ADD.W   D0,D1                           ; $0022F6
        ADDI.W  #$1A5E,D1                       ; $0022F8
        ADD.W  (A1),D1                          ; $0022FC
        LSR.W  #1,D1                            ; $0022FE
        CMPI.W  #$21A0,D1                       ; $002300
        DC.W    $6E0E               ; BGT.S  $002314; $002304
        CMPI.W  #$1A5E,D1                       ; $002306
        DC.W    $6E0C               ; BGT.S  $002318; $00230A
        MOVE.W  #$1A5E,D1                       ; $00230C
        MOVE.W  D1,(A1)                         ; $002310
        RTS                                     ; $002312
