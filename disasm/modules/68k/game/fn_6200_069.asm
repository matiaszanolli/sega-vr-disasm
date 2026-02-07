; ============================================================================
; Obj Camera 069 (auto-analyzed)
; ROM Range: $0080D6-$008170 (154 bytes)
; ============================================================================
; Category: game
; Purpose: RAM: $C048 (camera_state), $C89C (sh2_comm_state)
;   Object (A0): +$06 (speed), +$24, +$3C (heading_mirror), +$40 (heading_angle), +$8C (velocity_x), +$92 (param_92)
;
; Entry: A0 = object/entity pointer
; Uses: D0, D2, A0, A1
; RAM:
;   $C048: camera_state
;   $C89C: sh2_comm_state
; Object fields:
;   +$06: speed
;   +$24: [unknown]
;   +$3C: heading_mirror
;   +$40: heading_angle
;   +$8C: velocity_x
;   +$92: param_92
;   +$9C: [unknown]
;   +$9E: [unknown]
; Confidence: medium
; ============================================================================

fn_6200_069:
        TST.W  (-16308).W                       ; $0080D6
        BEQ.S  .loc_0012                        ; $0080DA
        MOVE.W  #$0001,(-16380).W               ; $0080DC
        MOVE.W  #$0001,(-16312).W               ; $0080E2
.loc_0012:
        LEA     $00939EEC,A1                    ; $0080E8
        LSL.W  #3,D2                            ; $0080EE
        ADDA.L  D2,A1                           ; $0080F0
        MOVE.W  (A1)+,$009C(A0)                 ; $0080F2
        MOVE.W  (A1)+,$009E(A0)                 ; $0080F6
        MOVE.W  (A1)+,$00A0(A0)                 ; $0080FA
        MOVE.W  (A1),$00A2(A0)                  ; $0080FE
        SUBQ.W  #1,$008C(A0)                    ; $008102
        BGT.S  .loc_0098                        ; $008106
        TST.W  (-16380).W                       ; $008108
        BEQ.S  .loc_0040                        ; $00810C
        CLR.W  (-16312).W                       ; $00810E
        CLR.W  (-16380).W                       ; $008112
.loc_0040:
        MOVEQ   #$00,D0                         ; $008116
        MOVE.W  D0,$008C(A0)                    ; $008118
        MOVE.W  D0,$009E(A0)                    ; $00811C
        MOVE.W  D0,$00A0(A0)                    ; $008120
        MOVE.W  D0,$00A2(A0)                    ; $008124
        MOVE.W  D0,$009C(A0)                    ; $008128
        CMPI.W  #$011C,$0006(A0)                ; $00812C
        BGE.S  .loc_0064                        ; $008132
        MOVE.W  #$011C,$0006(A0)                ; $008134
.loc_0064:
        CMPI.W  #$0001,(-14180).W               ; $00813A
        BNE.S  .loc_0086                        ; $008140
        MOVE.B  $00E5(A0),D0                    ; $008142
        ANDI.B  #$06,D0                         ; $008146
        BEQ.S  .loc_0086                        ; $00814A
        MOVE.W  $0024(A0),D0                    ; $00814C
        CMPI.W  #$0069,D0                       ; $008150
        BLT.S  .loc_0086                        ; $008154
        CMPI.W  #$0071,D0                       ; $008156
        BLE.S  .loc_0098                        ; $00815A
.loc_0086:
        MOVE.W  #$0027,(-16212).W               ; $00815C
        MOVE.W  #$0028,$0092(A0)                ; $008162
        MOVE.W  $003C(A0),$0040(A0)             ; $008168
.loc_0098:
        RTS                                     ; $00816E
