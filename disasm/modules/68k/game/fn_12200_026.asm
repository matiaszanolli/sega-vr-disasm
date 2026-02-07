; ============================================================================
; Sh2 Comm Object Update 026 (auto-analyzed)
; ROM Range: $012CC2-$012F0A (584 bytes)
; ============================================================================
; Category: sh2
; Purpose: Orchestrator calling 5 subroutines
;   Accesses 32X registers: COMM0
;   RAM: $C87E (game_state)
;   Calls: dma_transfer, object_update, sprite_update, sh2_send_cmd
;
; Uses: D0, D1, D2, A0, A1
; RAM:
;   $C87E: game_state
; Calls:
;   $00B684: object_update
;   $00B6DA: sprite_update
;   $00E35A: sh2_send_cmd
;   $00E52C: dma_transfer
; Confidence: high
; ============================================================================

fn_12200_026:
        CLR.W  D0                               ; $012CC2
        DC.W    $6100,$B866         ; BSR.W  $00E52C; $012CC4
        DC.W    $4EBA,$89BA         ; JSR     $00B684(PC); $012CC8
        DC.W    $4EBA,$8A0C         ; JSR     $00B6DA(PC); $012CCC
        JSR     $0088179E                       ; $012CD0
        TST.W  (-24518).W                       ; $012CD6
        BNE.W  .loc_0150                        ; $012CDA
        TST.B  (-14309).W                       ; $012CDE
        BNE.W  .loc_011C                        ; $012CE2
        MOVE.B  (-24551).W,D0                   ; $012CE6
        MOVE.W  (-14228).W,D1                   ; $012CEA
        TST.L  (-24540).W                       ; $012CEE
        BNE.W  .loc_014C                        ; $012CF2
        BTST    #3,D1                           ; $012CF6
        BEQ.S  .loc_00B2                        ; $012CFA
        MOVE.B  #$A9,(-14172).W                 ; $012CFC
        TST.B  (-600).W                         ; $012D02
        BEQ.S  .loc_008E                        ; $012D06
        CMPI.B  #$05,D0                         ; $012D08
        BLT.S  .loc_0060                        ; $012D0C
        CLR.B  D0                               ; $012D0E
        MOVE.L  #$00000004,(-24540).W           ; $012D10
        MOVE.W  #$0037,(-24536).W               ; $012D18
        BRA.W  .loc_014C                        ; $012D1E
.loc_0060:
        ADDQ.B  #1,D0                           ; $012D22
        BTST    #3,(-14312).W                   ; $012D24
        BEQ.S  .loc_0074                        ; $012D2A
        CMPI.B  #$02,D0                         ; $012D2C
        BNE.S  .loc_0074                        ; $012D30
        MOVE.B  #$03,D0                         ; $012D32
.loc_0074:
        CMPI.B  #$05,D0                         ; $012D36
        BNE.W  .loc_014C                        ; $012D3A
        MOVE.L  #$FFFFFFFC,(-24540).W           ; $012D3E
        MOVE.W  #$0037,(-24536).W               ; $012D46
        BRA.W  .loc_014C                        ; $012D4C
.loc_008E:
        CMPI.B  #$04,D0                         ; $012D50
        BLT.S  .loc_009A                        ; $012D54
        CLR.B  D0                               ; $012D56
        BRA.W  .loc_014C                        ; $012D58
.loc_009A:
        ADDQ.B  #1,D0                           ; $012D5C
        BTST    #3,(-14312).W                   ; $012D5E
        BEQ.S  .loc_00AE                        ; $012D64
        CMPI.B  #$02,D0                         ; $012D66
        BNE.S  .loc_00AE                        ; $012D6A
        MOVE.B  #$03,D0                         ; $012D6C
.loc_00AE:
        BRA.W  .loc_014C                        ; $012D70
.loc_00B2:
        BTST    #2,D1                           ; $012D74
        BEQ.W  .loc_014C                        ; $012D78
        MOVE.B  #$A9,(-14172).W                 ; $012D7C
        TST.B  D0                               ; $012D82
        BGT.S  .loc_00E6                        ; $012D84
        MOVE.B  #$04,D0                         ; $012D86
        TST.B  (-600).W                         ; $012D8A
        BEQ.W  .loc_014C                        ; $012D8E
        MOVE.B  #$05,D0                         ; $012D92
        MOVE.L  #$FFFFFFFC,(-24540).W           ; $012D96
        MOVE.W  #$0037,(-24536).W               ; $012D9E
        BRA.W  .loc_014C                        ; $012DA4
.loc_00E6:
        SUBQ.B  #1,D0                           ; $012DA8
        BTST    #3,(-14312).W                   ; $012DAA
        BEQ.S  .loc_00FA                        ; $012DB0
        CMPI.B  #$02,D0                         ; $012DB2
        BNE.S  .loc_00FA                        ; $012DB6
        MOVE.B  #$01,D0                         ; $012DB8
.loc_00FA:
        TST.B  (-600).W                         ; $012DBC
        BEQ.W  .loc_014C                        ; $012DC0
        CMPI.B  #$04,D0                         ; $012DC4
        BNE.W  .loc_014C                        ; $012DC8
        MOVE.L  #$00000004,(-24540).W           ; $012DCC
        MOVE.W  #$0037,(-24536).W               ; $012DD4
        BRA.W  .loc_014C                        ; $012DDA
.loc_011C:
        MOVE.B  (-24551).W,D0                   ; $012DDE
        MOVE.W  (-14226).W,D1                   ; $012DE2
        BTST    #3,D1                           ; $012DE6
        BNE.S  .loc_0134                        ; $012DEA
        BTST    #2,D1                           ; $012DEC
        BNE.S  .loc_0134                        ; $012DF0
        BRA.W  .loc_014C                        ; $012DF2
.loc_0134:
        MOVE.B  #$A9,(-14172).W                 ; $012DF6
        CMPI.B  #$02,D0                         ; $012DFC
        BEQ.S  .loc_0148                        ; $012E00
        MOVE.B  #$02,D0                         ; $012E02
        BRA.W  .loc_014C                        ; $012E06
.loc_0148:
        MOVE.B  #$04,D0                         ; $012E0A
.loc_014C:
        MOVE.B  D0,(-24551).W                   ; $012E0E
.loc_0150:
        MOVEA.L #$06038000,A0                   ; $012E12
        MOVEA.L #$04014000,A1                   ; $012E18
        ADDA.L  (-24544).W,A1                   ; $012E1E
        MOVE.W  #$0150,D0                       ; $012E22
        MOVE.W  #$0048,D1                       ; $012E26
        DC.W    $4EBA,$B52E         ; JSR     $00E35A(PC); $012E2A
        TST.L  (-24540).W                       ; $012E2E
        BNE.W  .loc_0180                        ; $012E32
.loc_0174:
        TST.B  $00A15120                        ; $012E36
        BNE.S  .loc_0174                        ; $012E3C
        DC.W    $6100,$0132         ; BSR.W  $012F72; $012E3E
.loc_0180:
        MOVEA.L #$0603DE80,A0                   ; $012E42
        MOVEA.L #$04004C60,A1                   ; $012E48
        MOVE.W  #$0080,D0                       ; $012E4E
        MOVE.W  #$0010,D1                       ; $012E52
        DC.W    $4EBA,$B502         ; JSR     $00E35A(PC); $012E56
.loc_0198:
        TST.B  $00A15120                        ; $012E5A
        BNE.S  .loc_0198                        ; $012E60
        TST.L  (-24540).W                       ; $012E62
        BNE.W  .loc_01D4                        ; $012E66
        CMPI.W  #$0001,(-24518).W               ; $012E6A
        BEQ.W  .loc_0210                        ; $012E70
        CMPI.W  #$0002,(-24518).W               ; $012E74
        BEQ.W  .loc_0220                        ; $012E7A
        MOVE.W  (-14228).W,D1                   ; $012E7E
        TST.B  (-14309).W                       ; $012E82
        BEQ.W  .loc_01CC                        ; $012E86
        MOVE.W  (-14226).W,D1                   ; $012E8A
.loc_01CC:
        MOVE.W  D1,D2                           ; $012E8E
        ANDI.B  #$E0,D2                         ; $012E90
        BNE.S  .loc_01DC                        ; $012E94
.loc_01D4:
        SUBQ.W  #8,(-14210).W                   ; $012E96
        BRA.W  .loc_0238                        ; $012E9A
.loc_01DC:
        BTST    #0,D1                           ; $012E9E
        BEQ.S  .loc_01E8                        ; $012EA2
        BSET    #0,(-14325).W                   ; $012EA4
.loc_01E8:
        MOVE.B  #$A8,(-14172).W                 ; $012EAA
        MOVE.B  #$01,(-14327).W                 ; $012EB0
        MOVE.B  #$01,(-14326).W                 ; $012EB6
        BSET    #7,(-14322).W                   ; $012EBC
        MOVE.B  #$01,(-14334).W                 ; $012EC2
        MOVE.W  #$0002,(-24518).W               ; $012EC8
        BRA.W  .loc_0234                        ; $012ECE
.loc_0210:
        BTST    #6,(-14322).W                   ; $012ED2
        BNE.S  .loc_0234                        ; $012ED8
        CLR.W  (-24518).W                       ; $012EDA
        BRA.W  .loc_0234                        ; $012EDE
.loc_0220:
        BTST    #7,(-14322).W                   ; $012EE2
        BNE.S  .loc_0234                        ; $012EE8
        CLR.W  (-24518).W                       ; $012EEA
        ADDQ.W  #4,(-14210).W                   ; $012EEE
        BRA.W  .loc_0238                        ; $012EF2
.loc_0234:
        SUBQ.W  #8,(-14210).W                   ; $012EF6
.loc_0238:
        MOVE.W  #$0018,$00FF0008                ; $012EFA
        MOVE.B  #$01,(-14303).W                 ; $012F02
        RTS                                     ; $012F08
