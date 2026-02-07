; ============================================================================
; Sh2 Comm 070 (auto-analyzed)
; ROM Range: $008170-$0081C0 (80 bytes)
; ============================================================================
; Category: sh2
; Purpose: RAM: $C89C (sh2_comm_state), $C8C8 (vint_state)
;   Object (A0): +$24, +$3C (heading_mirror), +$40 (heading_angle), +$62, +$92 (param_92), +$E5
;
; Entry: A0 = object/entity pointer
; Uses: D0, A0
; RAM:
;   $C89C: sh2_comm_state
;   $C8C8: vint_state
; Object fields:
;   +$24: [unknown]
;   +$3C: heading_mirror
;   +$40: heading_angle
;   +$62: [unknown]
;   +$92: param_92
;   +$E5: [unknown]
; Confidence: medium
; ============================================================================

fn_6200_070:
        TST.W  $0062(A0)                        ; $008170
        BLE.S  .loc_004E                        ; $008174
        SUBQ.W  #1,$0062(A0)                    ; $008176
        BNE.S  .loc_004E                        ; $00817A
        CMPI.W  #$0001,(-14180).W               ; $00817C
        BNE.S  .loc_002E                        ; $008182
        MOVE.B  $00E5(A0),D0                    ; $008184
        ANDI.B  #$06,D0                         ; $008188
        BEQ.S  .loc_002E                        ; $00818C
        MOVE.W  $0024(A0),D0                    ; $00818E
        CMPI.W  #$0069,D0                       ; $008192
        BLT.S  .loc_002E                        ; $008196
        CMPI.W  #$006F,D0                       ; $008198
        BLE.S  .loc_004E                        ; $00819C
.loc_002E:
        MOVE.W  #$000F,(-16212).W               ; $00819E
        CMPI.W  #$0002,(-14136).W               ; $0081A4
        BNE.S  .loc_0042                        ; $0081AA
        MOVE.W  #$0004,(-16212).W               ; $0081AC
.loc_0042:
        MOVE.W  #$0028,$0092(A0)                ; $0081B2
        MOVE.W  $003C(A0),$0040(A0)             ; $0081B8
.loc_004E:
        RTS                                     ; $0081BE
