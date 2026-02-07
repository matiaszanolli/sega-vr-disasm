; ============================================================================
; State 035 (auto-analyzed)
; ROM Range: $009458-$0094F4 (156 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A0, A1): +$00, +$04 (speed_index/velocity), +$06 (speed), +$0A (param_a), +$14 (effect_duration), +$16 (calc_speed)
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, D1, A0, A1
; Object fields:
;   +$00: [unknown]
;   +$04: speed_index/velocity
;   +$06: speed
;   +$0A: param_a
;   +$14: effect_duration
;   +$16: calc_speed
;   +$8A: param_8a
;   +$A8: [unknown]
; Confidence: low
; ============================================================================

fn_8200_035:
        MOVEM.L D0/A1,-(A7)                     ; $009458
        MOVEA.L (-15748).W,A1                   ; $00945C
        MOVE.W  $0004(A0),D0                    ; $009460
        DC.W    $D040                           ; $009464
        MOVE.W  $00(A1,D0.W),D0                 ; $009466
        MULS    (-16154).W,D0                   ; $00946A
        ASR.L  #8,D0                            ; $00946E
        MOVE.W  D0,$0016(A0)                    ; $009470
        TST.B  (-14298).W                       ; $009474
        BEQ.S  .loc_0032                        ; $009478
        MOVEQ   #$10,D0                         ; $00947A
        ADD.W  $008A(A0),D0                     ; $00947C
        MULS    $0016(A0),D0                    ; $009480
        ASR.L  #4,D0                            ; $009484
        MOVE.W  D0,$0016(A0)                    ; $009486
.loc_0032:
        MOVE.W  $0016(A0),D0                    ; $00948A
        CMPI.W  #$0004,$00A8(A0)                ; $00948E
        BLE.S  .loc_004E                        ; $009494
        MOVE.W  D0,D1                           ; $009496
        DC.W    $D040                           ; $009498
        DC.W    $D040                           ; $00949A
        DC.W    $D041                           ; $00949C
        DC.W    $D040                           ; $00949E
        DC.W    $D041                           ; $0094A0
        ASR.W  #4,D0                            ; $0094A2
        BRA.S  .loc_0064                        ; $0094A4
.loc_004E:
        TST.W  $00A8(A0)                        ; $0094A6
        BEQ.S  .loc_0064                        ; $0094AA
        MOVE.W  $0006(A0),D1                    ; $0094AC
        CMP.W  $000A(A0),D1                     ; $0094B0
        BLE.S  .loc_0064                        ; $0094B4
        MOVE.W  D0,D1                           ; $0094B6
        ASR.W  #1,D1                            ; $0094B8
        DC.W    $D041                           ; $0094BA
.loc_0064:
        MOVE.W  D0,$0016(A0)                    ; $0094BC
        DC.W    $4EBA,$0670         ; JSR     $009B32(PC); $0094C0
        ADD.W  D0,$0016(A0)                     ; $0094C4
        TST.B  (-15589).W                       ; $0094C8
        BEQ.S  .loc_0086                        ; $0094CC
        MOVE.W  $0016(A0),D0                    ; $0094CE
        ASR.W  #1,D0                            ; $0094D2
        MOVE.W  D0,D1                           ; $0094D4
        ASR.W  #1,D1                            ; $0094D6
        DC.W    $D041                           ; $0094D8
        ADD.W  D0,$0016(A0)                     ; $0094DA
.loc_0086:
        TST.W  $0014(A0)                        ; $0094DE
        BLE.S  .loc_0096                        ; $0094E2
        SUBQ.W  #1,$0014(A0)                    ; $0094E4
        ADDI.W  #$0738,$0016(A0)                ; $0094E8
.loc_0096:
        MOVEM.L (A7)+,D0/A1                     ; $0094EE
        RTS                                     ; $0094F2
