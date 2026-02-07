; ============================================================================
; Camera Send Cmd 038 (auto-analyzed)
; ROM Range: $013CBA-$013F80 (710 bytes)
; ============================================================================
; Category: game
; Purpose: Orchestrator calling 4 subroutines
;   RAM: $C87E (game_state)
;   Calls: dma_transfer, sh2_send_cmd
;   Object (A0, A3, A4): +$00, +$04 (speed_index/velocity), +$08
;
; Entry: A0 = object/entity pointer
; Entry: A3 = object/entity pointer
; Entry: A4 = object/entity pointer
; Uses: D0, D1, D2, D3, D4, A0, A1, A2
; RAM:
;   $C87E: game_state
; Calls:
;   $00E35A: sh2_send_cmd
;   $00E52C: dma_transfer
; Object fields:
;   +$00: [unknown]
;   +$04: speed_index/velocity
;   +$08: [unknown]
; Confidence: high
; ============================================================================

fn_12200_038:
        CLR.W  D0                               ; $013CBA
        DC.W    $4EBA,$A86E         ; JSR     $00E52C(PC); $013CBC
        JSR     $0088B684                       ; $013CC0
        JSR     $0088B6DA                       ; $013CC6
        MOVEA.L #$06014000,A0                   ; $013CCC
        MOVEA.L #$04004C74,A1                   ; $013CD2
        MOVE.W  #$0058,D0                       ; $013CD8
        MOVE.W  #$0010,D1                       ; $013CDC
        DC.W    $4EBA,$A678         ; JSR     $00E35A(PC); $013CE0
        MOVEA.L #$06014580,A0                   ; $013CE4
        MOVEA.L #$04007018,A1                   ; $013CEA
        MOVE.W  #$0048,D0                       ; $013CF0
        MOVE.W  #$0010,D1                       ; $013CF4
        DC.W    $4EBA,$A660         ; JSR     $00E35A(PC); $013CF8
        MOVEA.L #$06014A00,A0                   ; $013CFC
        MOVEA.L #$04013018,A1                   ; $013D02
        MOVE.W  #$0048,D0                       ; $013D08
        MOVE.W  #$0010,D1                       ; $013D0C
        DC.W    $4EBA,$A648         ; JSR     $00E35A(PC); $013D10
        BTST    #2,(-14312).W                   ; $013D14
        BNE.S  .loc_0088                        ; $013D1A
        LEA     $0089AA12,A0                    ; $013D1C
        CLR.W  D0                               ; $013D22
        MOVE.B  (-366).W,D0                     ; $013D24
        DC.W    $D040                           ; $013D28
        DC.W    $D040                           ; $013D2A
        MOVEA.L $00(A0,D0.W),A0                 ; $013D2C
        MOVEA.L #$0400707C,A1                   ; $013D30
        MOVE.W  #$0048,D0                       ; $013D36
        MOVE.W  #$0010,D1                       ; $013D3A
        DC.W    $4EBA,$A61A         ; JSR     $00E35A(PC); $013D3E
.loc_0088:
        BTST    #3,(-14312).W                   ; $013D42
        BNE.S  .loc_00B6                        ; $013D48
        LEA     $0089AA12,A0                    ; $013D4A
        CLR.W  D0                               ; $013D50
        MOVE.B  (-365).W,D0                     ; $013D52
        DC.W    $D040                           ; $013D56
        DC.W    $D040                           ; $013D58
        MOVEA.L $00(A0,D0.W),A0                 ; $013D5A
        MOVEA.L #$0401307C,A1                   ; $013D5E
        MOVE.W  #$0048,D0                       ; $013D64
        MOVE.W  #$0010,D1                       ; $013D68
        DC.W    $4EBA,$A5EC         ; JSR     $00E35A(PC); $013D6C
.loc_00B6:
        LEA     (-382).W,A2                     ; $013D70
        LEA     $0089AA2E,A3                    ; $013D74
        CLR.W  D4                               ; $013D7A
        MOVE.W  #$0004,D3                       ; $013D7C
        BTST    #0,(-14312).W                   ; $013D80
        BEQ.S  .loc_00D2                        ; $013D86
        MOVE.W  #$0007,D3                       ; $013D88
.loc_00D2:
        MOVEA.L $00(A3,D4.W),A0                 ; $013D8C
        MOVE.W  $08(A3,D4.W),D0                 ; $013D90
        MOVEA.L $04(A3,D4.W),A4                 ; $013D94
        CLR.W  D1                               ; $013D98
        MOVE.B  (A2)+,D1                        ; $013D9A
        DC.W    $D241                           ; $013D9C
        DC.W    $D241                           ; $013D9E
        MOVEA.L $00(A4,D1.W),A1                 ; $013DA0
        BTST    #0,(-14312).W                   ; $013DA4
        BNE.S  .loc_0112                        ; $013DAA
        CMPA.L  #$06017780,A0                   ; $013DAC
        BNE.S  .loc_0112                        ; $013DB2
        MOVEA.L #$06017500,A0                   ; $013DB4
        MOVE.W  #$0018,D0                       ; $013DBA
        CMPI.W  #$0004,D1                       ; $013DBE
        BLE.W  .loc_0112                        ; $013DC2
        ADDA.L  #$00000020,A1                   ; $013DC6
.loc_0112:
        MOVE.W  #$0008,D1                       ; $013DCC
        DC.W    $4EBA,$A588         ; JSR     $00E35A(PC); $013DD0
        ADDI.W  #$000A,D4                       ; $013DD4
        DBRA    D3,.loc_00D2                    ; $013DD8
        TST.W  (-24544).W                       ; $013DDC
        BEQ.S  .loc_0142                        ; $013DE0
        MOVE.W  #$0000,D0                       ; $013DE2
        BTST    #0,(-14312).W                   ; $013DE6
        BEQ.S  .loc_0138                        ; $013DEC
        MOVE.W  #$0001,D0                       ; $013DEE
.loc_0138:
        MOVEQ   #$00,D1                         ; $013DF2
        LEA     (-24551).W,A0                   ; $013DF4
        DC.W    $6100,$03F0         ; BSR.W  $0141EA; $013DF8
.loc_0142:
        BTST    #3,(-14312).W                   ; $013DFC
        BNE.W  .loc_01E2                        ; $013E02
        LEA     (-374).W,A2                     ; $013E06
        LEA     $0089AA2E,A3                    ; $013E0A
        CLR.W  D4                               ; $013E10
        MOVE.W  #$0004,D3                       ; $013E12
        BTST    #1,(-14312).W                   ; $013E16
        BEQ.S  .loc_0168                        ; $013E1C
        MOVE.W  #$0007,D3                       ; $013E1E
.loc_0168:
        MOVEA.L $00(A3,D4.W),A0                 ; $013E22
        MOVE.W  $08(A3,D4.W),D0                 ; $013E26
        MOVEA.L $04(A3,D4.W),A4                 ; $013E2A
        CLR.W  D1                               ; $013E2E
        MOVE.B  (A2)+,D1                        ; $013E30
        DC.W    $D241                           ; $013E32
        DC.W    $D241                           ; $013E34
        MOVEA.L $00(A4,D1.W),A1                 ; $013E36
        BTST    #1,(-14312).W                   ; $013E3A
        BNE.S  .loc_01A8                        ; $013E40
        CMPA.L  #$06017780,A0                   ; $013E42
        BNE.S  .loc_01A8                        ; $013E48
        MOVEA.L #$06017500,A0                   ; $013E4A
        MOVE.W  #$0018,D0                       ; $013E50
        CMPI.W  #$0004,D1                       ; $013E54
        BLE.W  .loc_01A8                        ; $013E58
        ADDA.L  #$00000020,A1                   ; $013E5C
.loc_01A8:
        ADDA.L  #$0000C000,A1                   ; $013E62
        MOVE.W  #$0008,D1                       ; $013E68
        DC.W    $4EBA,$A4EC         ; JSR     $00E35A(PC); $013E6C
        ADDI.W  #$000A,D4                       ; $013E70
        DBRA    D3,.loc_0168                    ; $013E74
        TST.W  (-24542).W                       ; $013E78
        BEQ.S  .loc_01E2                        ; $013E7C
        MOVE.W  #$0000,D0                       ; $013E7E
        BTST    #1,(-14312).W                   ; $013E82
        BEQ.S  .loc_01D4                        ; $013E88
        MOVE.W  #$0001,D0                       ; $013E8A
.loc_01D4:
        MOVE.L  #$0000C000,D1                   ; $013E8E
        LEA     (-24550).W,A0                   ; $013E94
        DC.W    $6100,$0350         ; BSR.W  $0141EA; $013E98
.loc_01E2:
        CMPI.W  #$0001,(-24540).W               ; $013E9C
        BEQ.W  .loc_0288                        ; $013EA2
        CMPI.W  #$0002,(-24540).W               ; $013EA6
        BEQ.W  .loc_029E                        ; $013EAC
        JSR     $0088179E                       ; $013EB0
        CLR.W  D0                               ; $013EB6
        BTST    #0,(-14312).W                   ; $013EB8
        BEQ.S  .loc_020A                        ; $013EBE
        MOVE.W  #$0001,D0                       ; $013EC0
.loc_020A:
        MOVE.W  (-14228).W,D1                   ; $013EC4
        CLR.W  D2                               ; $013EC8
        CLR.W  D3                               ; $013ECA
        LEA     (-366).W,A0                     ; $013ECC
        LEA     (-382).W,A1                     ; $013ED0
        LEA     (-364).W,A2                     ; $013ED4
        LEA     (-24551).W,A3                   ; $013ED8
        LEA     (-24544).W,A4                   ; $013EDC
        DC.W    $6100,$00FE         ; BSR.W  $013FE0; $013EE0
        CLR.W  D0                               ; $013EE4
        BTST    #1,(-14312).W                   ; $013EE6
        BEQ.S  .loc_0238                        ; $013EEC
        MOVE.W  #$0001,D0                       ; $013EEE
.loc_0238:
        MOVE.W  (-14226).W,D1                   ; $013EF2
        MOVE.W  #$0001,D2                       ; $013EF6
        CLR.W  D3                               ; $013EFA
        LEA     (-365).W,A0                     ; $013EFC
        LEA     (-374).W,A1                     ; $013F00
        LEA     (-356).W,A2                     ; $013F04
        LEA     (-24550).W,A3                   ; $013F08
        LEA     (-24542).W,A4                   ; $013F0C
        DC.W    $6100,$00CE         ; BSR.W  $013FE0; $013F10
        TST.W  (-24546).W                       ; $013F14
        BEQ.W  .loc_02B8                        ; $013F18
        MOVE.B  #$01,(-14327).W                 ; $013F1C
        MOVE.B  #$01,(-14326).W                 ; $013F22
        BSET    #7,(-14322).W                   ; $013F28
        MOVE.B  #$01,(-14334).W                 ; $013F2E
        JSR     $0088205E                       ; $013F34
        MOVE.W  #$0002,(-24540).W               ; $013F3A
        BRA.S  .loc_02BC                        ; $013F40
.loc_0288:
        JSR     $0088FB36                       ; $013F42
        BTST    #6,(-14322).W                   ; $013F48
        BNE.S  .loc_02B8                        ; $013F4E
        CLR.W  (-24540).W                       ; $013F50
        BRA.W  .loc_02B8                        ; $013F54
.loc_029E:
        JSR     $0088FB36                       ; $013F58
        BTST    #7,(-14322).W                   ; $013F5E
        BNE.S  .loc_02B8                        ; $013F64
        CLR.W  (-24540).W                       ; $013F66
        ADDQ.W  #4,(-14210).W                   ; $013F6A
        BRA.W  .loc_02BC                        ; $013F6E
.loc_02B8:
        SUBQ.W  #4,(-14210).W                   ; $013F72
.loc_02BC:
        MOVE.W  #$0018,$00FF0008                ; $013F76
        RTS                                     ; $013F7E
