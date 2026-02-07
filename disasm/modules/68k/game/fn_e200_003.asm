; ============================================================================
; Sh2 Comm Send Cmd 003 (auto-analyzed)
; ROM Range: $00E93A-$00EAC2 (392 bytes)
; ============================================================================
; Category: sh2
; Purpose: RAM: $C87E (game_state)
;   Calls: sh2_send_cmd, dma_transfer
;   Object (A0, A1): +$00
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, D1, D7, A0, A1, A2
; RAM:
;   $C87E: game_state
; Calls:
;   $00E35A: sh2_send_cmd
;   $00E52C: dma_transfer
; Object fields:
;   +$00: [unknown]
; Confidence: medium
; ============================================================================

fn_e200_003:
        MOVEA.L #$06038000,A0                   ; $00E93A
        MOVEA.L #$04012010,A1                   ; $00E940
        MOVE.W  #$0120,D0                       ; $00E946
        MOVE.W  #$0030,D1                       ; $00E94A
        DC.W    $4EBA,$FA0A         ; JSR     $00E35A(PC); $00E94E
        MOVEA.L #$0603B600,A0                   ; $00E952
        MOVEA.L #$0401B010,A1                   ; $00E958
        MOVE.W  #$0120,D0                       ; $00E95E
        MOVE.W  #$0018,D1                       ; $00E962
        DC.W    $4EBA,$F9F2         ; JSR     $00E35A(PC); $00E966
        MOVEQ   #$00,D0                         ; $00E96A
        TST.B  (-24550).W                       ; $00E96C
        BNE.S  .loc_003E                        ; $00E970
        MOVE.B  (-24551).W,D0                   ; $00E972
        BRA.S  .loc_0042                        ; $00E976
.loc_003E:
        MOVE.B  (-24546).W,D0                   ; $00E978
.loc_0042:
        MOVE.W  D0,D1                           ; $00E97C
        DC.W    $D241                           ; $00E97E
        DC.W    $D241                           ; $00E980
        LEA     $00FF6E00,A0                    ; $00E982
        LEA     $0088EACE,A1                    ; $00E988
        MOVEA.L $00(A1,D1.W),A1                 ; $00E98E
        MOVE.W  #$007F,D1                       ; $00E992
.loc_005C:
        MOVE.W  (A1)+,(A0)+                     ; $00E996
        DBRA    D1,.loc_005C                    ; $00E998
        LEA     $0088EAC2,A0                    ; $00E99C
        DC.W    $D040                           ; $00E9A2
        DC.W    $D040                           ; $00E9A4
        MOVEA.L $00(A0,D0.W),A0                 ; $00E9A6
        MOVE.L  (-24556).W,D0                   ; $00E9AA
        JSR     (A0)                            ; $00E9AE
.loc_0076:
        BTST    #1,$00A15123                    ; $00E9B0
        BEQ.S  .loc_0076                        ; $00E9B8
        BCLR    #1,$00A15123                    ; $00E9BA
        LEA     $00FF60C8,A1                    ; $00E9C2
        LEA     $00A15112,A2                    ; $00E9C8
        MOVE.W  #$0043,D7                       ; $00E9CE
.loc_0098:
        BTST    #7,$00A15107                    ; $00E9D2
        BNE.S  .loc_0098                        ; $00E9DA
        MOVE.W  (A1)+,(A2)                      ; $00E9DC
        DBRA    D7,.loc_0098                    ; $00E9DE
        MOVE.L  (-24556).W,D0                   ; $00E9E2
        ADDI.L  #$00000080,D0                   ; $00E9E6
        ANDI.L  #$0000FFFF,D0                   ; $00E9EC
        MOVE.L  D0,(-24556).W                   ; $00E9F2
        CLR.W  D0                               ; $00E9F6
        MOVE.B  (-24550).W,D0                   ; $00E9F8
        DC.W    $6100,$FB2E         ; BSR.W  $00E52C; $00E9FC
        JSR     $0088179E                       ; $00EA00
        TST.W  (-24544).W                       ; $00EA06
        BNE.W  .loc_017A                        ; $00EA0A
        MOVE.B  (-24551).W,D0                   ; $00EA0E
        MOVE.W  (-14228).W,D1                   ; $00EA12
        BTST    #3,D1                           ; $00EA16
        BEQ.S  .loc_0108                        ; $00EA1A
        MOVE.B  #$A9,(-14172).W                 ; $00EA1C
        TST.B  (-24550).W                       ; $00EA22
        BEQ.W  .loc_00FA                        ; $00EA26
        CMPI.B  #$01,D0                         ; $00EA2A
        BGE.S  .loc_0104                        ; $00EA2E
        BRA.W  .loc_0100                        ; $00EA30
.loc_00FA:
        CMPI.B  #$02,D0                         ; $00EA34
        BGE.S  .loc_0104                        ; $00EA38
.loc_0100:
        ADDQ.B  #1,D0                           ; $00EA3A
        BRA.S  .loc_0176                        ; $00EA3C
.loc_0104:
        CLR.B  D0                               ; $00EA3E
        BRA.S  .loc_0176                        ; $00EA40
.loc_0108:
        BTST    #2,D1                           ; $00EA42
        BEQ.S  .loc_0130                        ; $00EA46
        MOVE.B  #$A9,(-14172).W                 ; $00EA48
        TST.B  D0                               ; $00EA4E
        BLE.S  .loc_011C                        ; $00EA50
        SUBQ.B  #1,D0                           ; $00EA52
        BRA.S  .loc_0176                        ; $00EA54
.loc_011C:
        TST.B  (-24550).W                       ; $00EA56
        BEQ.W  .loc_012A                        ; $00EA5A
        MOVE.B  #$01,D0                         ; $00EA5E
        BRA.S  .loc_0176                        ; $00EA62
.loc_012A:
        MOVE.B  #$02,D0                         ; $00EA64
        BRA.S  .loc_0176                        ; $00EA68
.loc_0130:
        BTST    #0,D1                           ; $00EA6A
        BEQ.W  .loc_0152                        ; $00EA6E
        TST.B  (-24550).W                       ; $00EA72
        BEQ.S  .loc_0176                        ; $00EA76
        MOVE.B  #$A9,(-14172).W                 ; $00EA78
        CLR.B  (-24550).W                       ; $00EA7E
        MOVE.B  D0,(-24547).W                   ; $00EA82
        MOVE.B  (-24546).W,D0                   ; $00EA86
        BRA.S  .loc_0176                        ; $00EA8A
.loc_0152:
        BTST    #1,D1                           ; $00EA8C
        BEQ.W  .loc_0176                        ; $00EA90
        CMPI.B  #$01,(-24550).W                 ; $00EA94
        BGE.S  .loc_0176                        ; $00EA9A
        MOVE.B  #$A9,(-14172).W                 ; $00EA9C
        MOVE.B  #$01,(-24550).W                 ; $00EAA2
        MOVE.B  D0,(-24546).W                   ; $00EAA8
        MOVE.B  (-24547).W,D0                   ; $00EAAC
.loc_0176:
        MOVE.B  D0,(-24551).W                   ; $00EAB0
.loc_017A:
        ADDQ.W  #4,(-14210).W                   ; $00EAB4
        MOVE.W  #$0020,$00FF0008                ; $00EAB8
        RTS                                     ; $00EAC0
