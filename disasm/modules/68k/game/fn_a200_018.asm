; ============================================================================
; Display Scroll 018 (auto-analyzed)
; ROM Range: $00B4CA-$00B55A (144 bytes)
; ============================================================================
; Category: display
; Purpose: RAM: $C050 (scroll_state)
;   Object (A0): +$00
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, A0, A1, A2
; RAM:
;   $C050: scroll_state
; Object fields:
;   +$00: [unknown]
; Confidence: medium
; ============================================================================

fn_a200_018:
        MOVE.L  (-15788).W,(-4356).W            ; $00B4CA
        LEA     (-15872).W,A1                   ; $00B4D0
        LEA     (-4384).W,A2                    ; $00B4D4
        DC.W    $4EFA,$9446         ; JMP     $004920(PC); $00B4D8
        MOVE.W  (-16304).W,D0                   ; $00B4DC
        BPL.S  .loc_001A                        ; $00B4E0
        MOVEQ   #$00,D0                         ; $00B4E2
.loc_001A:
        DC.W    $D040                           ; $00B4E4
        LEA     $00899884,A0                    ; $00B4E6
        MOVE.W  $00(A0,D0.W),D0                 ; $00B4EC
        LEA     $00FF68BA,A1                    ; $00B4F0
        BRA.S  .loc_0082                        ; $00B4F6
        LEA     $00FF6908,A1                    ; $00B4F8
        MOVE.W  (-24828).W,D0                   ; $00B4FE
        BRA.S  .loc_0044                        ; $00B502
        LEA     $00FF68C8,A1                    ; $00B504
        MOVE.W  (-28668).W,D0                   ; $00B50A
.loc_0044:
        DC.W    $D040                           ; $00B50E
        LEA     $00899884,A0                    ; $00B510
        MOVE.W  $00(A0,D0.W),D0                 ; $00B516
        MOVE.W  D0,D1                           ; $00B51A
        LSR.W  #8,D1                            ; $00B51C
        MOVE.W  D1,(A1)+                        ; $00B51E
        BRA.S  .loc_0082                        ; $00B520
        MOVEQ   #$00,D0                         ; $00B522
        MOVE.B  (-15604).W,D0                   ; $00B524
        DC.W    $D040                           ; $00B528
        MOVE.W  D0,D1                           ; $00B52A
        DC.W    $D040                           ; $00B52C
        LEA     $00898C24,A0                    ; $00B52E
        MOVE.L  $00(A0,D0.W),$00FF68A8          ; $00B534
        LEA     $00899884,A0                    ; $00B53C
        MOVE.W  $00(A0,D1.W),D0                 ; $00B542
        LEA     $00FF689A,A1                    ; $00B546
.loc_0082:
        MOVE.B  D0,D1                           ; $00B54C
        LSR.B  #4,D1                            ; $00B54E
        MOVE.B  D1,(A1)+                        ; $00B550
        ANDI.B  #$0F,D0                         ; $00B552
        MOVE.B  D0,(A1)                         ; $00B556
        RTS                                     ; $00B558
