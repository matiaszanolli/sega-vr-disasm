; ============================================================================
; Scene Dispatch 022 (auto-analyzed)
; ROM Range: $00D3FC-$00D482 (134 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;
; Uses: D0, D1, D7, A0, A1, A4, A5
; Confidence: low
; ============================================================================

fn_c200_022:
        ORI.B  #$01,D0                          ; $00D3FC
        ORI.B  #$02,D0                          ; $00D400
        ORI.B  #$03,D0                          ; $00D404
        ORI.B  #$05,D0                          ; $00D408
        ORI.B  #$04,D0                          ; $00D40C
        ORI.B  #$04,D0                          ; $00D410
        ORI.B  #$01,D0                          ; $00D414
        ORI.B  #$05,D0                          ; $00D418
        ORI.B  #$06,D0                          ; $00D41C
        ORI.B  #$04,D0                          ; $00D420
        ORI.B  #$07,D0                          ; $00D424
        ORI.B  #$07,D0                          ; $00D428
        MOVE.L  #$40000000,(A5)                 ; $00D42C
        MOVEQ   #$00,D1                         ; $00D432
        JMP     $008848B8                       ; $00D434
        LEA     (-32768).W,A1                   ; $00D43A
        MOVEQ   #$00,D1                         ; $00D43E
        JSR     $0088483E                       ; $00D440
        JMP     $00884842                       ; $00D446
        DC.W    $050A                           ; $00D44C
        BTST    D7,(A4)                         ; $00D44E
        MOVEQ   #$00,D0                         ; $00D450
        MOVE.B  (-344).W,D0                     ; $00D452
        MOVE.B  (-14321).W,D1                   ; $00D456
        BEQ.S  .loc_0064                        ; $00D45A
        MOVE.B  (-340).W,D0                     ; $00D45C
.loc_0064:
        MOVE.B  $00D44C(PC,D0.W),(-14310).W     ; $00D460
        LEA     $00898BFC,A0                    ; $00D466
        LSL.W  #2,D0                            ; $00D46C
        ADDA.L  D0,A0                           ; $00D46E
        MOVE.L  (A0),$00FF6828                  ; $00D470
        TST.B  D1                               ; $00D476
        BEQ.S  .loc_0084                        ; $00D478
        MOVE.L  (A0),$00FF68B8                  ; $00D47A
.loc_0084:
        RTS                                     ; $00D480
