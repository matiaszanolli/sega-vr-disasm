; ============================================================================
; Sh2 Comm 057 (auto-analyzed)
; ROM Range: $007E0C-$007E74 (104 bytes)
; ============================================================================
; Category: sh2
; Purpose: RAM: $C89C (sh2_comm_state)
;   Object (A0): +$14 (effect_duration), +$1C, +$1D, +$40 (heading_angle), +$56, +$57
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, A0
; RAM:
;   $C89C: sh2_comm_state
; Object fields:
;   +$14: effect_duration
;   +$1C: [unknown]
;   +$1D: [unknown]
;   +$40: heading_angle
;   +$56: [unknown]
;   +$57: [unknown]
;   +$62: [unknown]
;   +$64: [unknown]
; Confidence: medium
; ============================================================================

fn_6200_057:
        CMPI.W  #$0001,(-14180).W               ; $007E0C
        BNE.S  .loc_0010                        ; $007E12
        CMPI.B  #$B1,$001D(A0)                  ; $007E14
        BEQ.S  .loc_0024                        ; $007E1A
.loc_0010:
        MOVE.B  $0057(A0),D1                    ; $007E1C
        AND.B  $0056(A0),D1                     ; $007E20
        ANDI.B  #$01,D1                         ; $007E24
        BNE.S  .loc_0024                        ; $007E28
        CMPI.W  #$3000,D0                       ; $007E2A
        BLE.S  .loc_002C                        ; $007E2E
.loc_0024:
        MOVE.W  $001C(A0),D0                    ; $007E30
        DC.W    $4EFA,$006E         ; JMP     $007EA4(PC); $007E34
.loc_002C:
        TST.W  $0092(A0)                        ; $007E38
        BGT.S  .loc_0066                        ; $007E3C
        ADDI.W  #$1000,D0                       ; $007E3E
        ASL.W  #1,D0                            ; $007E42
        MOVE.W  #$FFFF,$0068(A0)                ; $007E44
        TST.W  $0072(A0)                        ; $007E4A
        BLE.S  .loc_004C                        ; $007E4E
        MOVE.W  #$0001,$0068(A0)                ; $007E50
        NEG.W  D0                               ; $007E56
.loc_004C:
        MOVE.W  D0,$0066(A0)                    ; $007E58
        SUB.W  $0040(A0),D0                     ; $007E5C
        NEG.W  D0                               ; $007E60
        MOVE.W  D0,$0064(A0)                    ; $007E62
        MOVE.W  #$0004,$0062(A0)                ; $007E66
        MOVE.W  #$0004,$0014(A0)                ; $007E6C
.loc_0066:
        RTS                                     ; $007E72
