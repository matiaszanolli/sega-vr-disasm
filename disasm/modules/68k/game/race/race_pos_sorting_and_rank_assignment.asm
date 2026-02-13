; ============================================================================
; race_pos_sorting_and_rank_assignment — Race Position Sorting and Rank Assignment
; ROM Range: $009C9C-$009DD6 (314 bytes)
; Data tables (50 bytes) at start, then race position sorting logic.
; Builds sorted entity lists by segment position and lap distance across
; all 16 race entities. Assigns rank (+$2A) to each entity. Detects
; position changes and triggers appropriate sound effects based on race
; mode ($CC series). Saves/restores A0 via stack.
;
; Entry: A0 = player entity pointer
; Uses: D0, D1, D2, D3, D4, D5, D6, D7, A0-A3
; Object fields: +$04 speed, +$24 segment, +$2A rank, +$2B prev rank,
;   +$2C lap, +$2E lap segment, +$A4 sort key A, +$A6 sort key B,
;   +$C2 sound trigger, +$E5 AI flags
; Confidence: high
; ============================================================================

race_pos_sorting_and_rank_assignment:
        ORI.B  #$01,D0                          ; $009C9C
        ORI.B  #$03,D2                          ; $009CA0
        ORI.B  #$06,D4                          ; $009CA4
        DC.W    $0008                           ; $009CA8
        DC.W    $0009                           ; $009CAA
        DC.W    $000A                           ; $009CAC
        ORI.B  #$01,D0                          ; $009CAE
        ORI.B  #$02,D1                          ; $009CB2
        ORI.B  #$03,D3                          ; $009CB6
        ORI.B  #$05,D4                          ; $009CBA
        ORI.B  #$06,D5                          ; $009CBE
        ORI.B  #$07,D7                          ; $009CC2
        DC.W    $0008                           ; $009CC6
        DC.W    $0009                           ; $009CC8
        DC.W    $0009                           ; $009CCA
        DC.W    $000A                           ; $009CCC
        MOVE.L  A0,-(A7)                        ; $009CCE
        MOVE.W  $00A4(A0),D6                    ; $009CD0
        MOVE.W  $00A6(A0),D7                    ; $009CD4
        LEA     (A0),A1                         ; $009CD8
        LEA     (-24508).W,A2                   ; $009CDA
        LEA     (-24576).W,A3                   ; $009CDE
        MOVE.W  $0024(A1),(A2)+                 ; $009CE2
        MOVE.W  A1,(A2)+                        ; $009CE6
        MOVE.W  $002E(A1),D0                    ; $009CE8
        LSL.W  #8,D0                            ; $009CEC
        ADD.W  $0024(A1),D0                     ; $009CEE
        MOVE.W  D0,(A3)+                        ; $009CF2
        MOVE.W  A1,(A3)+                        ; $009CF4
        LEA     $0100(A1),A1                    ; $009CF6
        MOVEQ   #$0E,D2                         ; $009CFA
.loc_0060:
        MOVE.W  $0024(A1),(A2)+                 ; $009CFC
        MOVE.W  A1,(A2)+                        ; $009D00
        MOVE.W  $002C(A1),D0                    ; $009D02
        LSL.W  #8,D0                            ; $009D06
        ADD.W  $0024(A1),D0                     ; $009D08
        MOVE.W  D0,(A3)+                        ; $009D0C
        MOVE.W  A1,(A3)+                        ; $009D0E
        LEA     $0100(A1),A1                    ; $009D10
        DBRA    D2,.loc_0060                    ; $009D14
        LEA     (-24508).W,A0                   ; $009D18
        DC.W    $4EBA,$00C4         ; JSR     $009DE2(PC); $009D1C
        LEA     (-24576).W,A0                   ; $009D20
        DC.W    $4EBA,$00BC         ; JSR     $009DE2(PC); $009D24
        LEA     (-24508).W,A0                   ; $009D28
        MOVE.L  $003C(A0),-$0004(A0)            ; $009D2C
        MOVE.L  (A0),$0040(A0)                  ; $009D32
        MOVEQ   #$0F,D2                         ; $009D36
.loc_009C:
        MOVEA.W $0002(A0),A3                    ; $009D38
        MOVE.W  -$0002(A0),D0                   ; $009D3C
        LSR.W  #8,D0                            ; $009D40
        ANDI.W  #$000F,D0                       ; $009D42
        MOVE.W  D0,$00A4(A3)                    ; $009D46
        MOVE.W  $0006(A0),D0                    ; $009D4A
        LSR.W  #8,D0                            ; $009D4E
        ANDI.W  #$000F,D0                       ; $009D50
        MOVE.W  D0,$00A6(A3)                    ; $009D54
        LEA     $0004(A0),A0                    ; $009D58
        DBRA    D2,.loc_009C                    ; $009D5C
        LEA     (-24576).W,A0                   ; $009D60
        MOVEQ   #$01,D1                         ; $009D64
        MOVEQ   #$0F,D2                         ; $009D66
.loc_00CC:
        MOVEA.W $0002(A0),A2                    ; $009D68
        MOVE.W  D1,$002A(A2)                    ; $009D6C
        LEA     $0004(A0),A0                    ; $009D70
        ADDQ.W  #1,D1                           ; $009D74
        DBRA    D2,.loc_00CC                    ; $009D76
        LEA     (-28672).W,A0                   ; $009D7A
        MOVE.B  $002B(A0),(-15612).W            ; $009D7E
        CMP.W  $00A6(A0),D6                     ; $009D84
        BEQ.S  .loc_00F6                        ; $009D88
        CMP.W  $00A4(A0),D7                     ; $009D8A
        BNE.S  .loc_0136                        ; $009D8E
        MOVE.W  D7,D6                           ; $009D90
.loc_00F6:
        MOVE.W  $0004(A0),D1                    ; $009D92
        MOVE.B  $00E5(A0),D2                    ; $009D96
        LSL.W  #8,D6                            ; $009D9A
        LEA     $00(A0,D6.W),A0                 ; $009D9C
        SUB.W  $0004(A0),D1                     ; $009DA0
        BPL.S  .loc_010C                        ; $009DA4
        NEG.W  D1                               ; $009DA6
.loc_010C:
        CMPI.W  #$0014,D1                       ; $009DA8
        BLE.S  .loc_0136                        ; $009DAC
        CMPI.W  #$0004,(-14180).W               ; $009DAE
        BNE.S  .loc_0126                        ; $009DB4
        MOVE.B  $00E5(A0),D1                    ; $009DB6
        EOR.B   D1,D2                           ; $009DBA
        ANDI.B  #$06,D2                         ; $009DBC
        BNE.S  .loc_0136                        ; $009DC0
.loc_0126:
        MOVE.W  $00C2(A0),D0                    ; $009DC2
        LSR.W  #4,D0                            ; $009DC6
        ADD.W  (-14132).W,D0                    ; $009DC8
        MOVE.B  $009DD6(PC,D0.W),(-14172).W     ; $009DCC
.loc_0136:
        MOVEA.L (A7)+,A0                        ; $009DD2
        RTS                                     ; $009DD4
