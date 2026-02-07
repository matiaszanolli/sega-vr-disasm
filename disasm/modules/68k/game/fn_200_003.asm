; ============================================================================
; Init 003 (auto-analyzed)
; ROM Range: $00063E-$000694 (86 bytes)
; ============================================================================
; Category: boot
; Purpose: Object (A1): +$04 (speed_index/velocity), +$06 (speed), +$08, +$0B, +$80
;
; Entry: A1 = object/entity pointer
; Uses: D0, D1, D7, A1, A4
; Object fields:
;   +$04: speed_index/velocity
;   +$06: speed
;   +$08: [unknown]
;   +$0B: [unknown]
;   +$80: [unknown]
; Confidence: low
; ============================================================================

fn_200_003:
        OR.B   D0,(A4)                          ; $00063E
        DC.W    $8F01                           ; $000640
        DC.W    $93FF                           ; $000642
        DC.W    $94FF                           ; $000644
        DC.W    $9500                           ; $000646
        DC.W    $9600                           ; $000648
        DC.W    $9780                           ; $00064A
        NEGX.B D0                               ; $00064C
        ORI.L  #$81048F02,D0                    ; $00064E
        MOVEM.L D0/D1/D7/A1,-(A7)               ; $000654
        LEA     $00A15180,A1                    ; $000658
.loc_0020:
        BCLR    #7,-$0080(A1)                   ; $00065E
        BNE.S  .loc_0020                        ; $000664
        MOVE.W  #$00FF,D7                       ; $000666
        MOVEQ   #$00,D0                         ; $00066A
        MOVEQ   #$00,D1                         ; $00066C
        MOVE.W  #$00FF,$0004(A1)                ; $00066E
.loc_0036:
        MOVE.W  D1,$0006(A1)                    ; $000674
        MOVE.W  D0,$0008(A1)                    ; $000678
        NOP                                     ; $00067C
.loc_0040:
        BTST    #1,$000B(A1)                    ; $00067E
        BNE.S  .loc_0040                        ; $000684
        ADDI.W  #$0100,D1                       ; $000686
        DBRA    D7,.loc_0036                    ; $00068A
        MOVEM.L (A7)+,D0/D1/D7/A1               ; $00068E
        RTS                                     ; $000692
