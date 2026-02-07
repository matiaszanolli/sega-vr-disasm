; ============================================================================
; Fm Z80 Dac Write 030 (auto-analyzed)
; ROM Range: $030D4E-$030DEE (160 bytes)
; ============================================================================
; Category: sound
; Purpose: Orchestrator calling 3 subroutines
;   Calls: z80_dac_write
;   Object (A5, A6): +$09, +$38, +$39, +$3A, +$3B, +$40 (heading_angle)
;
; Entry: A5 = object/entity pointer
; Entry: A6 = object/entity pointer
; Uses: D5, D6, D7, A5, A6
; Calls:
;   $030DF4: z80_dac_write
; Object fields:
;   +$09: [unknown]
;   +$38: [unknown]
;   +$39: [unknown]
;   +$3A: [unknown]
;   +$3B: [unknown]
;   +$40: heading_angle
;   +$70: [unknown]
; Confidence: medium
; ============================================================================

fn_30200_030:
        TST.B  $0038(A6)                        ; $030D4E
        DC.W    $6700,$009E         ; BEQ.W  $030DF2; $030D52
        CMPI.B  #$02,$0038(A6)                  ; $030D56
        DC.W    $6700,$0094         ; BEQ.W  $030DF2; $030D5C
        MOVE.B  $0039(A6),D6                    ; $030D60
        LEA     $0040(A6),A5                    ; $030D64
        TST.B  (A5)                             ; $030D68
        BPL.S  .loc_0034                        ; $030D6A
        TST.B  $0038(A6)                        ; $030D6C
        BPL.S  .loc_002A                        ; $030D70
        SUB.B  D6,$0009(A5)                     ; $030D72
        BRA.S  .loc_0030                        ; $030D76
.loc_002A:
        ADD.B  D6,$0009(A5)                     ; $030D78
        BMI.S  .loc_0034                        ; $030D7C
.loc_0030:
        DC.W    $4EBA,$0074         ; JSR     $030DF4(PC); $030D7E
.loc_0034:
        MOVE.B  $003A(A6),D6                    ; $030D82
        LEA     $0070(A6),A5                    ; $030D86
        MOVEQ   #$05,D7                         ; $030D8A
.loc_003E:
        TST.B  (A5)                             ; $030D8C
        BPL.S  .loc_0058                        ; $030D8E
        TST.B  $0038(A6)                        ; $030D90
        BPL.S  .loc_004E                        ; $030D94
        SUB.B  D6,$0009(A5)                     ; $030D96
        BRA.S  .loc_0054                        ; $030D9A
.loc_004E:
        ADD.B  D6,$0009(A5)                     ; $030D9C
        BMI.S  .loc_0058                        ; $030DA0
.loc_0054:
        DC.W    $4EBA,$05B6         ; JSR     $03135A(PC); $030DA2
.loc_0058:
        ADDA.W  #$0030,A5                       ; $030DA6
        DBRA    D7,.loc_003E                    ; $030DAA
        MOVE.B  $003B(A6),D5                    ; $030DAE
        MOVEQ   #$02,D7                         ; $030DB2
.loc_0066:
        TST.B  (A5)                             ; $030DB4
        BPL.S  .loc_008A                        ; $030DB6
        TST.B  $0038(A6)                        ; $030DB8
        BPL.S  .loc_0076                        ; $030DBC
        SUB.B  D5,$0009(A5)                     ; $030DBE
        BRA.S  .loc_0082                        ; $030DC2
.loc_0076:
        ADD.B  D5,$0009(A5)                     ; $030DC4
        CMPI.B  #$10,$0009(A5)                  ; $030DC8
        BCC.S  .loc_008A                        ; $030DCE
.loc_0082:
        MOVE.B  $0009(A5),D6                    ; $030DD0
        DC.W    $4EBA,$018A         ; JSR     $030F60(PC); $030DD4
.loc_008A:
        ADDA.W  #$0030,A5                       ; $030DD8
        DBRA    D7,.loc_0066                    ; $030DDC
        TST.B  $0038(A6)                        ; $030DE0
        DC.W    $6B08               ; BMI.S  $030DEE; $030DE4
        MOVE.B  #$02,$0038(A6)                  ; $030DE6
        RTS                                     ; $030DEC
