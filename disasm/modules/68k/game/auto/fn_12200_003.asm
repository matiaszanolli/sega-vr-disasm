; ============================================================================
; fn_12200_003 — Camera Angle Increment Clamp
; ROM Range: $012C9E-$012CB0 (18 bytes)
; ============================================================================
; Adds a small increment ($10) to D0 if D0 ≤ $4000 (≤ 90° in 16-bit angle
; space). If D0 > $4000, returns unchanged. Secondary entry at $012CAA adds
; a larger increment ($40) unconditionally.
;
; Entry: D0 = camera angle (16-bit, $0000-$FFFF)
; Exit: D0 = adjusted angle
; Uses: D0
; ============================================================================

fn_12200_003:
        CMPI.W  #$4000,D0                       ; $012C9E
        BGT.S  .loc_0010                        ; $012CA2
        ADDI.W  #$0010,D0                       ; $012CA4
        BRA.S  .loc_0010                        ; $012CA8
        ADDI.W  #$0040,D0                       ; $012CAA
.loc_0010:
        RTS                                     ; $012CAE
