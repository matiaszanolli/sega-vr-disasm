; ============================================================================
; Ai 022 (auto-analyzed)
; ROM Range: $00B604-$00B632 (46 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A1): +$00
;
; Entry: A1 = object/entity pointer
; Uses: D0, A1
; Object fields:
;   +$00: [unknown]
; Confidence: low
; ============================================================================

fn_a200_022:
        LEA     $00FF68D0,A1                    ; $00B604
        LEA     $00(A1,D0.W),A1                 ; $00B60A
        MOVE.B  #$00,(A1)                       ; $00B60E
        BTST    #4,(-13977).W                   ; $00B612
        BNE.S  .loc_001A                        ; $00B618
        MOVE.B  #$02,(A1)                       ; $00B61A
.loc_001A:
        MOVEQ   #$09,D0                         ; $00B61E
        BTST    #5,(-13977).W                   ; $00B620
        BNE.S  .loc_0026                        ; $00B626
        MOVEQ   #$00,D0                         ; $00B628
.loc_0026:
        MOVE.B  D0,$00FF68B0                    ; $00B62A
        RTS                                     ; $00B630
