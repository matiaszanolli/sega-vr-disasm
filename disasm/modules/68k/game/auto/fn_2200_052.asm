; ============================================================================
; Vint Objs 052 (auto-analyzed)
; ROM Range: $0035B4-$0036C8 (276 bytes)
; ============================================================================
; Category: game
; Purpose: RAM: $6950 (obj_flags), $C89C (sh2_comm_state), $C8A0 (race_state), $C8C8 (vint_state)
;   Object (A0, A1, A3): +$00, +$2C
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Entry: A3 = object/entity pointer
; Uses: D0, D1, D2, A0, A1, A2, A3
; RAM:
;   $6950: obj_flags
;   $C89C: sh2_comm_state
;   $C8A0: race_state
;   $C8C8: vint_state
;   $C8CC: race_substate
; Object fields:
;   +$00: [unknown]
;   +$2C: [unknown]
; Confidence: high
; ============================================================================

fn_2200_052:
        MOVE.B  #$01,(-15608).W                 ; $0035B4
        MOVE.W  $002C(A0),D0                    ; $0035BA
        ADDQ.W  #1,D0                           ; $0035BE
        CMP.B  (-15600).W,D0                    ; $0035C0
        BNE.S  .loc_0018                        ; $0035C4
        MOVE.B  #$02,(-15608).W                 ; $0035C6
.loc_0018:
        MOVE.B  #$03,$00FF6950                  ; $0035CC
        MOVEA.W (-16266).W,A2                   ; $0035D4
        MOVEQ   #$00,D0                         ; $0035D8
        MOVE.B  (-14330).W,D0                   ; $0035DA
        MOVE.B  #$00,(-14330).W                 ; $0035DE
        DC.W    $D040                           ; $0035E4
        LEA     $00899884,A3                    ; $0035E6
        MOVE.W  $00(A3,D0.W),D0                 ; $0035EC
        MOVE.B  D0,(A2)+                        ; $0035F0
        MOVEQ   #$00,D0                         ; $0035F2
        MOVE.B  (-14329).W,D0                   ; $0035F4
        MOVE.B  #$C4,(-14329).W                 ; $0035F8
        SUBI.B  #$C4,D0                         ; $0035FE
        DC.W    $D040                           ; $003602
        LEA     $00899884,A3                    ; $003604
        MOVE.W  $00(A3,D0.W),D0                 ; $00360A
        MOVE.B  D0,(A2)+                        ; $00360E
        MOVEQ   #$00,D0                         ; $003610
        MOVE.B  (-14328).W,D0                   ; $003612
        MOVE.B  #$C4,(-14328).W                 ; $003616
        SUBI.B  #$C4,D0                         ; $00361C
        DC.W    $D040                           ; $003620
        LEA     $0089980C,A3                    ; $003622
        MOVE.W  $00(A3,D0.W),D0                 ; $003628
        MOVE.W  D0,(A2)+                        ; $00362C
        MOVE.W  A2,(-16266).W                   ; $00362E
        DC.W    $4EBA,$7CB0         ; JSR     $00B2E4(PC); $003632
        DC.W    $4EBA,$7DD6         ; JSR     $00B40E(PC); $003636
        SUBQ.L  #4,A2                           ; $00363A
        MOVE.L  (A2),D0                         ; $00363C
        MOVE.L  #$222E070C,$00FF6948            ; $00363E
        CMP.L  (-15788).W,D0                    ; $003648
        BGE.S  .loc_00FC                        ; $00364C
        MOVE.L  D0,(-15788).W                   ; $00364E
        MOVEQ   #$00,D1                         ; $003652
        MOVE.W  $002C(A0),D1                    ; $003654
        SUBQ.W  #1,D1                           ; $003658
        LSL.W  #4,D1                            ; $00365A
        MOVE.B  D1,(-15609).W                   ; $00365C
        MOVE.L  #$222DFB7C,$00FF6948            ; $003660
        LEA     (-598).W,A1                     ; $00366A
        MOVE.W  (-14180).W,D1                   ; $00366E
        LSL.W  #5,D1                            ; $003672
        ADD.W  (-14176).W,D1                    ; $003674
        MOVE.W  (-14136).W,D2                   ; $003678
        LSL.W  #3,D2                            ; $00367C
        ADD.W  (-14132).W,D2                    ; $00367E
        DC.W    $D242                           ; $003682
        LEA     $00(A1,D1.W),A1                 ; $003684
        CMP.L  (A1),D0                          ; $003688
        BGE.S  .loc_00FC                        ; $00368A
        MOVE.L  #$222E0508,$00FF6948            ; $00368C
        MOVE.L  D0,(A1)+                        ; $003696
        MOVE.L  (-15760).W,(A1)+                ; $003698
        MOVE.L  (-15756).W,(A1)                 ; $00369C
        LEA     $00FF6958,A1                    ; $0036A0
        LEA     $00FF68E8,A2                    ; $0036A6
        MOVE.L  (A1)+,(A2)+                     ; $0036AC
        MOVE.L  (A1),(A2)                       ; $0036AE
.loc_00FC:
        MOVE.B  #$01,$00FF6940                  ; $0036B0
        BTST    #5,(-15602).W                   ; $0036B8
        DC.W    $6708               ; BEQ.S  $0036C8; $0036BE
        MOVE.B  #$2C,(-15611).W                 ; $0036C0
        RTS                                     ; $0036C6
