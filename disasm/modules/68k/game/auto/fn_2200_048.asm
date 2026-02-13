; ============================================================================
; Input 048 (auto-analyzed)
; ROM Range: $003404-$0034D2 (206 bytes)
; ============================================================================
; Category: input
; Purpose: RAM: $C07C (input_state)
;   Object (A0, A1, A3): +$00, +$01, +$02 (flags/type), +$08, +$2C
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Entry: A3 = object/entity pointer
; Uses: D0, A0, A1, A2, A3
; RAM:
;   $C07C: input_state
; Object fields:
;   +$00: [unknown]
;   +$01: [unknown]
;   +$02: flags/type
;   +$08: [unknown]
;   +$2C: [unknown]
; Confidence: medium
; ============================================================================

fn_2200_048:
        LEA     (-14330).W,A1                   ; $003404
        CMPA.W  #$9000,A0                       ; $003408
        BEQ.S  .loc_000E                        ; $00340C
        LEA     (-14317).W,A1                   ; $00340E
.loc_000E:
        MOVEA.W (-16266).W,A2                   ; $003412
        MOVEQ   #$00,D0                         ; $003416
        MOVE.B  (A1),D0                         ; $003418
        MOVE.B  #$00,(A1)                       ; $00341A
        DC.W    $D040                           ; $00341E
        LEA     $00899884,A3                    ; $003420
        MOVE.W  $00(A3,D0.W),D0                 ; $003426
        MOVE.B  D0,(A2)+                        ; $00342A
        MOVEQ   #$00,D0                         ; $00342C
        MOVE.B  $0001(A1),D0                    ; $00342E
        MOVE.B  #$C4,$0001(A1)                  ; $003432
        SUBI.B  #$C4,D0                         ; $003438
        DC.W    $D040                           ; $00343C
        LEA     $00899884,A3                    ; $00343E
        MOVE.W  $00(A3,D0.W),D0                 ; $003444
        MOVE.B  D0,(A2)+                        ; $003448
        MOVEQ   #$00,D0                         ; $00344A
        MOVE.B  $0002(A1),D0                    ; $00344C
        MOVE.B  #$C4,$0002(A1)                  ; $003450
        SUBI.B  #$C4,D0                         ; $003456
        DC.W    $D040                           ; $00345A
        LEA     $0089980C,A3                    ; $00345C
        MOVE.W  $00(A3,D0.W),D0                 ; $003462
        MOVE.W  D0,(A2)+                        ; $003466
        MOVE.W  A2,(-16266).W                   ; $003468
        DC.W    $4EBA,$7E76         ; JSR     $00B2E4(PC); $00346C
        SUBQ.L  #4,A2                           ; $003470
        MOVE.L  (A2),D0                         ; $003472
        CMP.L  (-15788).W,D0                    ; $003474
        BGE.S  .loc_00A8                        ; $003478
        MOVE.L  D0,(-15788).W                   ; $00347A
        MOVE.W  $002C(A0),D0                    ; $00347E
        SUBQ.W  #1,D0                           ; $003482
        LSL.W  #4,D0                            ; $003484
        MOVE.B  D0,(-15609).W                   ; $003486
        LEA     (-15788).W,A1                   ; $00348A
        LEA     $00FF68E8,A3                    ; $00348E
        CMPA.W  #$9000,A0                       ; $003494
        BEQ.S  .loc_009C                        ; $003498
        LEA     $00FF6968,A3                    ; $00349A
.loc_009C:
        MOVE.B  #$02,-$0008(A3)                 ; $0034A0
        JSR     $0088B43C                       ; $0034A6
.loc_00A8:
        BTST    #5,(-15602).W                   ; $0034AC
        BNE.S  .loc_00BC                        ; $0034B2
        TST.B  (-14311).W                       ; $0034B4
        DC.W    $6718               ; BEQ.S  $0034D2; $0034B8
        MOVE.W  (-16232).W,(-16262).W           ; $0034BA
.loc_00BC:
        MOVE.W  #$0004,(-16260).W               ; $0034C0
        ADDQ.B  #1,(-14311).W                   ; $0034C6
        MOVE.B  #$38,(-15611).W                 ; $0034CA
        RTS                                     ; $0034D0
