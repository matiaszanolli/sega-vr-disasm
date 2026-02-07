; ============================================================================
; Obj Race 029 (auto-analyzed)
; ROM Range: $0073E8-$00742C (68 bytes)
; ============================================================================
; Category: game
; Purpose: RAM: $C8A0 (race_state)
;   Object (A0, A1, A2): +$00, +$04 (speed_index/velocity), +$E4
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Entry: A2 = object/entity pointer
; Uses: D0, D1, D2, D3, D4, D5, A0, A1
; RAM:
;   $C8A0: race_state
; Object fields:
;   +$00: [unknown]
;   +$04: speed_index/velocity
;   +$E4: [unknown]
; Confidence: medium
; ============================================================================

fn_6200_029:
        MOVE.L  #$00000400,D3                   ; $0073E8
        MOVE.W  D1,D4                           ; $0073EE
        ASR.W  #4,D4                            ; $0073F0
        DC.W    $D843                           ; $0073F2
        ASR.W  #5,D4                            ; $0073F4
        MOVE.W  D2,D5                           ; $0073F6
        ASR.W  #4,D5                            ; $0073F8
        DC.W    $D645                           ; $0073FA
        ANDI.W  #$FFE0,D3                       ; $0073FC
        ASL.W  #1,D3                            ; $007400
        DC.W    $D644                           ; $007402
        DC.W    $D643                           ; $007404
        MOVE.W  (-14176).W,D0                   ; $007406
        DC.W    $D040                           ; $00740A
        DC.W    $45FA,$001E         ; LEA     $00742C(PC),A2; $00740C
        TST.B  $00E4(A0)                        ; $007410
        BEQ.S  .loc_0032                        ; $007414
        DC.W    $45FA,$0044         ; LEA     $00745C(PC),A2; $007416
.loc_0032:
        MOVEA.L $00(A2,D0.W),A1                 ; $00741A
        MOVE.W  $00(A1,D3.W),D3                 ; $00741E
        MOVEA.L $04(A2,D0.W),A1                 ; $007422
        DC.W    $D683                           ; $007426
        ADDA.L  D3,A1                           ; $007428
        RTS                                     ; $00742A
