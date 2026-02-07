; ============================================================================
; State Sh2 Comm 007 (auto-analyzed)
; ROM Range: $0082FA-$008368 (110 bytes)
; ============================================================================
; Category: game
; Purpose: RAM: $C89C (sh2_comm_state), $C8A0 (race_state), $C8C8 (vint_state), $C8CC (race_substate)
;   Object (A3): +$00
;
; Entry: A3 = object/entity pointer
; Uses: D0, D1, D2, D5, D6, A1, A2, A3
; RAM:
;   $C89C: sh2_comm_state
;   $C8A0: race_state
;   $C8C8: vint_state
;   $C8CC: race_substate
; Object fields:
;   +$00: [unknown]
; Confidence: high
; ============================================================================

fn_8200_007:
        LEA     (-14330).W,A1                   ; $0082FA
        LEA     (-15760).W,A2                   ; $0082FE
        DC.W    $4EBA,$30CA         ; JSR     $00B3CE(PC); $008302
        MOVEQ   #$00,D0                         ; $008306
        LEA     (-15760).W,A1                   ; $008308
        DC.W    $4EBA,$3078         ; JSR     $00B386(PC); $00830C
        MOVE.L  (-15760).W,D5                   ; $008310
        MOVEQ   #$04,D6                         ; $008314
        BRA.S  .loc_003A                        ; $008316
        LEA     (-14330).W,A1                   ; $008318
        LEA     (-15756).W,A2                   ; $00831C
        DC.W    $4EBA,$30AC         ; JSR     $00B3CE(PC); $008320
        MOVEQ   #$02,D0                         ; $008324
        LEA     (-15756).W,A1                   ; $008326
        DC.W    $4EBA,$305A         ; JSR     $00B386(PC); $00832A
        MOVE.L  (-15756).W,D5                   ; $00832E
        MOVEQ   #$08,D6                         ; $008332
.loc_003A:
        LEA     (-598).W,A3                     ; $008334
        MOVE.W  (-14180).W,D1                   ; $008338
        LSL.W  #5,D1                            ; $00833C
        ADD.W  (-14176).W,D1                    ; $00833E
        MOVE.W  (-14136).W,D2                   ; $008342
        LSL.W  #3,D2                            ; $008346
        ADD.W  (-14132).W,D2                    ; $008348
        DC.W    $D242                           ; $00834C
        DC.W    $D246                           ; $00834E
        LEA     $00(A3,D1.W),A3                 ; $008350
        CMPI.L  #$60000000,D5                   ; $008354
        DC.W    $6D0C               ; BLT.S  $008368; $00835A
        MOVE.L  #$DDDD0DDD,(A4)                 ; $00835C
        MOVEQ   #$01,D0                         ; $008362
        MOVEQ   #$00,D1                         ; $008364
        RTS                                     ; $008366
