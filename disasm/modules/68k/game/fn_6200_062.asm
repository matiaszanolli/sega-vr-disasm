; ============================================================================
; Obj Scene 062 (auto-analyzed)
; ROM Range: $007F64-$007FDA (118 bytes)
; ============================================================================
; Category: game
; Purpose: RAM: $C8AA (scene_state)
;   Object (A0): +$02 (flags/type), +$08, +$1C, +$28, +$2C, +$2D
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, A0
; RAM:
;   $C8AA: scene_state
; Object fields:
;   +$02: flags/type
;   +$08: [unknown]
;   +$1C: [unknown]
;   +$28: [unknown]
;   +$2C: [unknown]
;   +$2D: [unknown]
;   +$2E: [unknown]
;   +$AC: [unknown]
; Confidence: high
; ============================================================================

fn_6200_062:
        CMPI.W  #$FF9C,D0                       ; $007F64
        DC.W    $6C00,$009A         ; BGE.W  $008004; $007F68
        ADDQ.W  #1,$002E(A0)                    ; $007F6C
        MOVE.W  #$0497,$0008(A0)                ; $007F70
        MOVE.W  $002C(A0),D1                    ; $007F76
        ADDQ.W  #1,D1                           ; $007F7A
        CMP.W  $002E(A0),D1                     ; $007F7C
        BNE.S  .loc_0074                        ; $007F80
        MOVE.B  #$04,(-15611).W                 ; $007F82
        ADDQ.W  #1,$002C(A0)                    ; $007F88
        CLR.W  $0028(A0)                        ; $007F8C
        TST.W  $00AC(A0)                        ; $007F90
        BLE.S  .loc_003A                        ; $007F94
        CMPI.W  #$0003,$001C(A0)                ; $007F96
        BGT.S  .loc_004A                        ; $007F9C
.loc_003A:
        ORI.W  #$4000,$0002(A0)                 ; $007F9E
        MOVE.W  #$0050,(-16306).W               ; $007FA4
        CLR.W  (-14166).W                       ; $007FAA
.loc_004A:
        MOVE.B  (-15600).W,D0                   ; $007FAE
        SUBQ.B  #1,D0                           ; $007FB2
        CMP.B  $002D(A0),D0                     ; $007FB4
        DC.W    $6C34               ; BGE.S  $007FEE; $007FB8
        BSET    #5,(-15602).W                   ; $007FBA
        BTST    #5,(-14322).W                   ; $007FC0
        DC.W    $6712               ; BEQ.S  $007FDA; $007FC6
        ORI.W  #$4000,$0002(A0)                 ; $007FC8
        MOVE.W  #$0050,(-16306).W               ; $007FCE
        CLR.W  (-14166).W                       ; $007FD4
.loc_0074:
        RTS                                     ; $007FD8
