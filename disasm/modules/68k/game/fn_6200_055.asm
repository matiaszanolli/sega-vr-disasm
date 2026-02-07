; ============================================================================
; Obj Velocity 055 (auto-analyzed)
; ROM Range: $007D56-$007D82 (44 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A0): +$04 (speed_index/velocity), +$1E, +$40 (heading_angle), +$8C (velocity_x)
;
; Entry: A0 = object/entity pointer
; Uses: D0, A0
; Object fields:
;   +$04: speed_index/velocity
;   +$1E: [unknown]
;   +$40: heading_angle
;   +$8C: velocity_x
; Confidence: medium
; ============================================================================

fn_6200_055:
        MOVE.B  #$B5,(-14172).W                 ; $007D56
        MOVE.W  $0040(A0),D0                    ; $007D5C
        SUB.W  $001E(A0),D0                     ; $007D60
        BPL.S  .loc_0012                        ; $007D64
        NEG.W  D0                               ; $007D66
.loc_0012:
        CMPI.W  #$0118,$0004(A0)                ; $007D68
        DC.W    $6F00,$009C         ; BLE.W  $007E0C; $007D6E
        CMPI.W  #$0800,D0                       ; $007D72
        DC.W    $6F00,$0094         ; BLE.W  $007E0C; $007D76
        TST.W  $008C(A0)                        ; $007D7A
        DC.W    $6702               ; BEQ.S  $007D82; $007D7E
        RTS                                     ; $007D80
