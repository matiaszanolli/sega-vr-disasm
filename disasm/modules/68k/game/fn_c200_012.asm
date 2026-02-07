; ============================================================================
; Scene Dispatch 012 (auto-analyzed)
; ROM Range: $00C8E6-$00C9AE (200 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   RAM: $C8CC (race_substate)
;   Object (A1, A4): +$00, +$10
;
; Entry: A1 = object/entity pointer
; Entry: A4 = object/entity pointer
; Uses: D0, A1, A2, A3, A4
; RAM:
;   $C8CC: race_substate
; Object fields:
;   +$00: [unknown]
;   +$10: [unknown]
; Confidence: medium
; ============================================================================

fn_c200_012:
        ADDQ.B  #2,D0                           ; $00C8E6
        SUBQ.B  #2,D0                           ; $00C8E8
        ADDQ.B  #5,D0                           ; $00C8EA
        SUBQ.B  #5,D0                           ; $00C8EC
        TST.B  D0                               ; $00C8EE
        DC.W    $4B00                           ; $00C8F0
        MOVE.W  (-14132).W,D0                   ; $00C8F2
        MOVE.W  $00C8E6(PC,D0.W),$00FF6122      ; $00C8F6
        MOVE.W  $00C8E8(PC,D0.W),$00FF6352      ; $00C8FE
        LEA     $008957A0,A1                    ; $00C906
        BSR.S  .loc_007C                        ; $00C90C
        LEA     $00FF6114,A1                    ; $00C90E
        LEA     $008957A0,A4                    ; $00C914
        BSR.S  .loc_00A0                        ; $00C91A
        DC.W    $4EBA,$0090         ; JSR     $00C9AE(PC); $00C91C
        LEA     $00FF6218,A1                    ; $00C920
        LEA     $008957A0,A4                    ; $00C926
        BSR.S  .loc_00A0                        ; $00C92C
        MOVE.L  (-14508).W,$00FF6228            ; $00C92E
        LEA     $00FF6344,A1                    ; $00C936
        LEA     $008957A0,A4                    ; $00C93C
        BSR.S  .loc_00A0                        ; $00C942
        DC.W    $6168               ; BSR.S  $00C9AE; $00C944
        MOVE.L  (-14508).W,$00FF6354            ; $00C946
        LEA     $00FF6448,A1                    ; $00C94E
        LEA     $008957A0,A4                    ; $00C954
        BRA.S  .loc_00A0                        ; $00C95A
.loc_0076:
        LEA     $008956C8,A1                    ; $00C95C
.loc_007C:
        MOVE.W  (-14132).W,D0                   ; $00C962
        MOVEA.L $00(A1,D0.W),A1                 ; $00C966
        LEA     (-14576).W,A2                   ; $00C96A
        JMP     $008848FE                       ; $00C96E
        BSR.S  .loc_0076                        ; $00C974
        LEA     $00FF6114,A1                    ; $00C976
        BSR.S  .loc_009A                        ; $00C97C
        DC.W    $602E               ; BRA.S  $00C9AE; $00C97E
.loc_009A:
        LEA     $008956C8,A4                    ; $00C980
.loc_00A0:
        MOVEA.L (-14540).W,A3                   ; $00C986
        MOVE.W  (-14132).W,D0                   ; $00C98A
        MOVEA.L $00(A4,D0.W),A4                 ; $00C98E
        MOVEQ   #$01,D0                         ; $00C992
        MOVE.W  D0,(A1)                         ; $00C994
        LEA     $0010(A1),A1                    ; $00C996
        MOVE.L  (A4)+,(A1)+                     ; $00C99A
        BSR.S  .loc_00BC                        ; $00C99C
        BSR.S  .loc_00BC                        ; $00C99E
        NOP                                     ; $00C9A0
.loc_00BC:
        MOVE.W  D0,(A1)+                        ; $00C9A2
        MOVE.L  (A3)+,(A1)+                     ; $00C9A4
        MOVE.W  (A3)+,(A1)+                     ; $00C9A6
        ADDQ.L  #8,A1                           ; $00C9A8
        MOVE.L  (A4)+,(A1)+                     ; $00C9AA
        RTS                                     ; $00C9AC
