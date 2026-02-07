; ============================================================================
; State Dispatch 038 (auto-analyzed)
; ROM Range: $009802-$00987E (124 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   RAM: $C8CC (race_substate)
;   Object (A0, A2): +$4C, +$62, +$88, +$92 (param_92), +$94, +$96
;
; Entry: A0 = object/entity pointer
; Entry: A2 = object/entity pointer
; Uses: D0, D1, D4, A0, A1, A2
; RAM:
;   $C8CC: race_substate
; Object fields:
;   +$4C: [unknown]
;   +$62: [unknown]
;   +$88: [unknown]
;   +$92: param_92
;   +$94: [unknown]
;   +$96: [unknown]
; Confidence: medium
; ============================================================================

fn_8200_038:
        MOVE.W  (-14132).W,D0                   ; $009802
        MOVEA.L $00980C(PC,D0.W),A1             ; $009806
        JMP     (A1)                            ; $00980A
        DC.W    $0088                           ; $00980C
        SUB.B  (A0)+,D4                         ; $00980E
        DC.W    $0088                           ; $009810
        SUB.L  D4,$0088(A2)                     ; $009812
        DC.W    $987E                           ; $009816
        MOVE.W  $0092(A0),D0                    ; $009818
        OR.W   $0062(A0),D0                     ; $00981C
        BNE.S  .loc_004C                        ; $009820
        MOVE.W  $004C(A0),D0                    ; $009822
        BPL.S  .loc_0028                        ; $009826
        NEG.W  D0                               ; $009828
.loc_0028:
        CMPI.W  #$0037,D0                       ; $00982A
        BLE.S  .loc_004C                        ; $00982E
        MOVE.W  $004C(A0),D0                    ; $009830
        ASR.W  #7,D0                            ; $009834
        MOVE.W  D0,D1                           ; $009836
        ASR.W  #1,D0                            ; $009838
        DC.W    $D041                           ; $00983A
        ADD.W  D0,$0094(A0)                     ; $00983C
        MOVE.W  $0094(A0),D0                    ; $009840
        ASR.W  #1,D0                            ; $009844
        MOVE.W  D0,$0096(A0)                    ; $009846
        BRA.W  .loc_007A                        ; $00984A
.loc_004C:
        MOVE.W  $0094(A0),D0                    ; $00984E
        MOVE.W  D0,D1                           ; $009852
        ASR.W  #2,D0                            ; $009854
        SUB.W  D0,$0094(A0)                     ; $009856
        MOVE.W  $0094(A0),D0                    ; $00985A
        MOVE.W  D0,$0096(A0)                    ; $00985E
        TST.W  D1                               ; $009862
        BGE.S  .loc_0068                        ; $009864
        NEG.W  D0                               ; $009866
        NEG.W  D1                               ; $009868
.loc_0068:
        CMP.W  D0,D1                            ; $00986A
        BLT.S  .loc_007A                        ; $00986C
        TST.W  D0                               ; $00986E
        BLT.S  .loc_007A                        ; $009870
        CMPI.W  #$000F,D0                       ; $009872
        BGT.S  .loc_007A                        ; $009876
        CLR.W  $0094(A0)                        ; $009878
.loc_007A:
        RTS                                     ; $00987C
