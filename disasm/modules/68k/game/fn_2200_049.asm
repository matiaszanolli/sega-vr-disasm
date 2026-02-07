; ============================================================================
; Obj Dispatch 049 (auto-analyzed)
; ROM Range: $0034E8-$003540 (88 bytes)
; ============================================================================
; Category: object
; Purpose: State dispatcher using jump table
;   RAM: $6950 (obj_flags)
;   Object (A2): +$78, +$88
;
; Entry: A2 = object/entity pointer
; Uses: D0, A1, A2, A3, A4
; RAM:
;   $6950: obj_flags
; Object fields:
;   +$78: [unknown]
;   +$88: [unknown]
; Confidence: medium
; ============================================================================

fn_2200_049:
        MOVEQ   #$00,D0                         ; $0034E8
        MOVE.B  (-15611).W,D0                   ; $0034EA
        MOVEA.L $0034F4(PC,D0.W),A1             ; $0034EE
        JMP     (A1)                            ; $0034F2
        DC.W    $0088                           ; $0034F4
        MOVE.W  (A4)+,(A3)+                     ; $0034F6
        DC.W    $0088                           ; $0034F8
        DC.W    $35B4                           ; $0034FA
        DC.W    $0088                           ; $0034FC
        MOVE.W  -(A4),-(A2)                     ; $0034FE
        DC.W    $0088                           ; $003500
        MOVE.W  -(A4),-(A2)                     ; $003502
        DC.W    $0088                           ; $003504
        MOVE.W  -(A4),-(A2)                     ; $003506
        DC.W    $0088                           ; $003508
        MOVE.W  -(A4),-(A2)                     ; $00350A
        DC.W    $0088                           ; $00350C
        MOVE.W  D0,-$78(A2,D0.W)                ; $00350E
        MOVE.W  D0,-$78(A2,D0.W)                ; $003512
        MOVE.W  D0,-$78(A2,D0.W)                ; $003516
        MOVE.W  D0,$0088(A2)                    ; $00351A
        MOVE.W  (A4)+,-$78(A2,D0.W)             ; $00351E
        MOVE.W  D0,(A3)+                        ; $003522
        TST.W  (-16306).W                       ; $003524
        DC.W    $6772               ; BEQ.S  $00359C; $003528
        MOVE.B  #$03,$00FF6950                  ; $00352A
        MOVE.B  #$01,$00FF6940                  ; $003532
        ADDQ.B  #4,(-15611).W                   ; $00353A
        RTS                                     ; $00353E
