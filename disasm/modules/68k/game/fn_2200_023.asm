; ============================================================================
; Vint Velocity 023 (auto-analyzed)
; ROM Range: $002A72-$002AAA (56 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A0, A1): +$14 (effect_duration), +$24, +$28, +$3C (heading_mirror), +$50, +$64
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, A0, A1
; Object fields:
;   +$14: effect_duration
;   +$24: [unknown]
;   +$28: [unknown]
;   +$3C: heading_mirror
;   +$50: [unknown]
;   +$64: [unknown]
;   +$8A: param_8a
;   +$8C: velocity_x
; Confidence: medium
; ============================================================================

fn_2200_023:
        MOVEQ   #$01,D0                         ; $002A72
        MOVE.W  D0,(A1)                         ; $002A74
        MOVE.W  D0,$0014(A1)                    ; $002A76
        MOVE.W  D0,$0028(A1)                    ; $002A7A
        MOVE.W  D0,$003C(A1)                    ; $002A7E
        MOVE.W  D0,$0050(A1)                    ; $002A82
        MOVE.W  $008A(A0),D0                    ; $002A86
        DC.W    $6738               ; BEQ.S  $002AC4; $002A8A
        SUBQ.W  #1,D0                           ; $002A8C
        DC.W    $671A               ; BEQ.S  $002AAA; $002A8E
        MOVE.L  (-14516).W,$0024(A1)            ; $002A90
        MOVE.W  #$0001,$0064(A1)                ; $002A96
        TST.W  $008C(A0)                        ; $002A9C
        DC.W    $673A               ; BEQ.S  $002ADC; $002AA0
        MOVE.W  #$0000,$0064(A1)                ; $002AA2
        RTS                                     ; $002AA8
