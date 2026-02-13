; ============================================================================
; fn_12200_004 — Camera Angle Decrement Clamp
; ROM Range: $012CB0-$012CC2 (18 bytes)
; ============================================================================
; Subtracts a small decrement ($10) from D0 if D0 ≥ $C000 (≥ 270° in 16-bit
; angle space). If D0 < $C000, returns unchanged. Secondary entry at $012CBC
; subtracts a larger decrement ($40) unconditionally.
;
; Entry: D0 = camera angle (16-bit, $0000-$FFFF)
; Exit: D0 = adjusted angle
; Uses: D0
; ============================================================================

fn_12200_004:
        CMPI.W  #$C000,D0                       ; $012CB0
        BLT.S  .loc_0010                        ; $012CB4
        SUBI.W  #$0010,D0                       ; $012CB6
        BRA.S  .loc_0010                        ; $012CBA
        SUBI.W  #$0040,D0                       ; $012CBC
.loc_0010:
        RTS                                     ; $012CC0
