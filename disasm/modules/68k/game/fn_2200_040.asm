; ============================================================================
; Vint 040 (auto-analyzed)
; ROM Range: $0030C6-$003116 (80 bytes)
; ============================================================================
; Category: vint
; Purpose: RAM: $C8C8 (vint_state)
;   Object (A1): +$0A (param_a)
;
; Entry: A1 = object/entity pointer
; Uses: D0, D1, A1
; RAM:
;   $C8C8: vint_state
; Object fields:
;   +$0A: param_a
; Confidence: medium
; ============================================================================

fn_2200_040:
        BTST    #5,(-15602).W                   ; $0030C6
        BEQ.S  .loc_004E                        ; $0030CC
        LEA     $00FF6100,A1                    ; $0030CE
        MOVE.W  $000A(A1),D0                    ; $0030D4
        SUB.W  (-16208).W,D0                    ; $0030D8
        MOVE.W  #$F000,D1                       ; $0030DC
        CMP.W  D1,D0                            ; $0030E0
        BLE.S  .loc_0026                        ; $0030E2
        ADDI.W  #$0040,(-16208).W               ; $0030E4
        MOVE.W  D0,D1                           ; $0030EA
.loc_0026:
        MOVE.W  D1,$000A(A1)                    ; $0030EC
        MOVE.W  (-16298).W,D0                   ; $0030F0
        MOVE.W  #$0280,D1                       ; $0030F4
        TST.W  (-14136).W                       ; $0030F8
        BEQ.S  .loc_003C                        ; $0030FC
        MOVE.W  #$0350,D1                       ; $0030FE
.loc_003C:
        CMP.W  D1,D0                            ; $003102
        BLE.S  .loc_004A                        ; $003104
        SUBI.W  #$0010,(-16298).W               ; $003106
        MOVE.W  (-16298).W,D1                   ; $00310C
.loc_004A:
        MOVE.W  D1,(-16298).W                   ; $003110
.loc_004E:
        RTS                                     ; $003114
