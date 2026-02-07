; ============================================================================
; Obj 058 (auto-analyzed)
; ROM Range: $007E74-$007EA4 (48 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A0): +$06 (speed), +$1C, +$55
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, A0
; Object fields:
;   +$06: speed
;   +$1C: [unknown]
;   +$55: [unknown]
; Confidence: low
; ============================================================================

fn_6200_058:
        BTST    D0,D1                           ; $007E74
        BTST    D0,D1                           ; $007E76
        BTST    D0,D1                           ; $007E78
        BTST    #1,$0055(A0)                    ; $007E7A
        BNE.S  .loc_002A                        ; $007E80
        ADDQ.W  #1,(-16342).W                   ; $007E82
        CMPI.W  #$0050,(-16342).W               ; $007E86
        BLE.S  .loc_002E                        ; $007E8C
        CLR.W  (-16342).W                       ; $007E8E
        CLR.W  $0006(A0)                        ; $007E92
        MOVE.W  $001C(A0),D0                    ; $007E96
        DC.W    $4EFA,$0008         ; JMP     $007EA4(PC); $007E9A
.loc_002A:
        CLR.W  (-16342).W                       ; $007E9E
.loc_002E:
        RTS                                     ; $007EA2
