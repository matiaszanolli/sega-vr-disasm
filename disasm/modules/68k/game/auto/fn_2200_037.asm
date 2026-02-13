; ============================================================================
; fn_2200_037 — Object Visibility Enable
; ROM Range: $002EEE-$002F04 (22 bytes)
; ============================================================================
; Sets visibility flag to 1 for all 5 render slots in the camera buffer:
; (A1)+$00, +$14, +$28, +$3C, +$50. Each slot is a 20-byte ($14) render
; parameter block. Value 1 = visible, 0 = hidden, 2 = special.
;
; Entry: A1 = camera/render buffer pointer
; Uses: D0, A1
; ============================================================================

fn_2200_037:
        MOVEQ   #$01,D0                         ; $002EEE
        MOVE.W  D0,(A1)                         ; $002EF0
        MOVE.W  D0,$0014(A1)                    ; $002EF2
        MOVE.W  D0,$0028(A1)                    ; $002EF6
        MOVE.W  D0,$003C(A1)                    ; $002EFA
        MOVE.W  D0,$0050(A1)                    ; $002EFE
        RTS                                     ; $002F02
