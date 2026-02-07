; ============================================================================
; Ai 006 (auto-analyzed)
; ROM Range: $00B15E-$00B1B8 (90 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A0, A1): +$00, +$01, +$09
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, D1, D3, A0, A1, A2
; Object fields:
;   +$00: [unknown]
;   +$01: [unknown]
;   +$09: [unknown]
; Confidence: low
; ============================================================================

fn_a200_006:
        LSL.W  #4,D3                            ; $00B15E
        LEA     $00(A1,D3.W),A1                 ; $00B160
        MOVE.B  #$02,-$0009(A1)                 ; $00B164
        MOVEQ   #$00,D0                         ; $00B16A
        MOVE.B  (A2)+,D0                        ; $00B16C
        DC.W    $D040                           ; $00B16E
        LEA     $00899884,A0                    ; $00B170
        MOVE.W  $00(A0,D0.W),D0                 ; $00B176
        BSR.S  .loc_004C                        ; $00B17A
        MOVEQ   #$00,D0                         ; $00B17C
        MOVE.B  (A2)+,D0                        ; $00B17E
        SUBI.B  #$C4,D0                         ; $00B180
        DC.W    $D040                           ; $00B184
        LEA     $00899884,A0                    ; $00B186
        MOVE.W  $00(A0,D0.W),D0                 ; $00B18C
        BSR.S  .loc_004C                        ; $00B190
        MOVEQ   #$00,D0                         ; $00B192
        MOVE.B  (A2)+,D0                        ; $00B194
        SUBI.B  #$C4,D0                         ; $00B196
        DC.W    $D040                           ; $00B19A
        LEA     $0089980C,A0                    ; $00B19C
        MOVE.B  $00(A0,D0.W),(A1)+              ; $00B1A2
        MOVE.B  $01(A0,D0.W),D0                 ; $00B1A6
.loc_004C:
        MOVE.B  D0,D1                           ; $00B1AA
        LSR.B  #4,D1                            ; $00B1AC
        MOVE.B  D1,(A1)+                        ; $00B1AE
        ANDI.B  #$0F,D0                         ; $00B1B0
        MOVE.B  D0,(A1)+                        ; $00B1B4
        RTS                                     ; $00B1B6
