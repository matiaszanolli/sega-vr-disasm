; ============================================================================
; Obj Velocity 054 (auto-analyzed)
; ROM Range: $007CF0-$007D56 (102 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A0): +$02 (flags/type), +$04 (speed_index/velocity), +$1C, +$55, +$56, +$57
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, A0
; Object fields:
;   +$02: flags/type
;   +$04: speed_index/velocity
;   +$1C: [unknown]
;   +$55: [unknown]
;   +$56: [unknown]
;   +$57: [unknown]
;   +$62: [unknown]
;   +$6A: [unknown]
; Confidence: medium
; ============================================================================

fn_6200_054:
        ANDI.B  #$0C,D0                         ; $007CF0
        BEQ.S  .loc_0040                        ; $007CF4
        CMPI.W  #$0064,$0004(A0)                ; $007CF6
        BLE.S  .loc_0040                        ; $007CFC
        TST.W  $006A(A0)                        ; $007CFE
        BNE.S  .loc_0040                        ; $007D02
        TST.W  $008C(A0)                        ; $007D04
        BNE.S  .loc_0040                        ; $007D08
        MOVE.W  (-14126).W,D0                   ; $007D0A
        CMP.W  $0094(A0),D0                     ; $007D0E
        BGT.S  .loc_002C                        ; $007D12
        ORI.W  #$1000,$0002(A0)                 ; $007D14
        BRA.S  .loc_003A                        ; $007D1A
.loc_002C:
        NEG.W  D0                               ; $007D1C
        CMP.W  $0094(A0),D0                     ; $007D1E
        BLT.S  .loc_0040                        ; $007D22
        ORI.W  #$2000,$0002(A0)                 ; $007D24
.loc_003A:
        MOVE.B  #$B2,(-14172).W                 ; $007D2A
.loc_0040:
        TST.W  $0062(A0)                        ; $007D30
        BEQ.S  .loc_005C                        ; $007D34
        MOVE.B  $0057(A0),D1                    ; $007D36
        AND.B  $0056(A0),D1                     ; $007D3A
        ANDI.B  #$01,D1                         ; $007D3E
        BEQ.S  .loc_0064                        ; $007D42
        MOVE.W  $001C(A0),D0                    ; $007D44
        DC.W    $4EFA,$015A         ; JMP     $007EA4(PC); $007D48
.loc_005C:
        BTST    #0,$0055(A0)                    ; $007D4C
        DC.W    $6602               ; BNE.S  $007D56; $007D52
.loc_0064:
        RTS                                     ; $007D54
