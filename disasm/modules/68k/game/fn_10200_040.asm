; ============================================================================
; Sh2 Comm Send Cmd 040 (auto-analyzed)
; ROM Range: $012084-$0121FA (374 bytes)
; ============================================================================
; Category: sh2
; Purpose: Orchestrator calling 3 subroutines
;   Accesses 32X registers: COMM0, COMM6, COMM4
;   RAM: $C87E (game_state)
;   Calls: dma_transfer, sh2_send_cmd, sh2_cmd_27
;   Object (A1): +$00, +$04 (speed_index/velocity)
;
; Entry: A1 = object/entity pointer
; Uses: D0, D1, D2, D3, A0, A1
; RAM:
;   $C87E: game_state
; Calls:
;   $00E35A: sh2_send_cmd
;   $00E3B4: sh2_cmd_27
;   $00E52C: dma_transfer
; Object fields:
;   +$00: [unknown]
;   +$04: speed_index/velocity
; Confidence: high
; ============================================================================

fn_10200_040:
        CLR.W  D0                               ; $012084
        DC.W    $4EBA,$C4A4         ; JSR     $00E52C(PC); $012086
        MOVEA.L #$06018000,A0                   ; $01208A
        MOVEA.L #$04004C74,A1                   ; $012090
        MOVE.W  #$0058,D0                       ; $012096
        MOVE.W  #$0010,D1                       ; $01209A
        DC.W    $4EBA,$C2BA         ; JSR     $00E35A(PC); $01209E
        MOVEA.L #$06018900,A0                   ; $0120A2
        MOVEA.L #$04019010,A1                   ; $0120A8
        MOVE.W  #$0120,D0                       ; $0120AE
        MOVE.W  #$0010,D1                       ; $0120B2
        DC.W    $4EBA,$C2A2         ; JSR     $00E35A(PC); $0120B6
        MOVEA.L #$06019B00,A0                   ; $0120BA
        MOVEA.L #$0401C010,A1                   ; $0120C0
        MOVE.W  #$0120,D0                       ; $0120C6
        MOVE.W  #$0010,D1                       ; $0120CA
        DC.W    $4EBA,$C28A         ; JSR     $00E35A(PC); $0120CE
        MOVEQ   #$00,D0                         ; $0120D2
        TST.B  (-24550).W                       ; $0120D4
        BNE.S  .loc_0060                        ; $0120D8
        MOVE.B  (-24551).W,D0                   ; $0120DA
        MOVE.W  #$0010,D2                       ; $0120DE
        BRA.S  .loc_0068                        ; $0120E2
.loc_0060:
        MOVE.B  (-24549).W,D0                   ; $0120E4
        MOVE.W  #$FFC0,D2                       ; $0120E8
.loc_0068:
        MOVE.B  D0,D3                           ; $0120EC
        LEA     $008921FA,A1                    ; $0120EE
        DC.W    $D040                           ; $0120F4
        DC.W    $D040                           ; $0120F6
        MOVEA.L $00(A1,D0.W),A0                 ; $0120F8
        MOVE.W  #$0061,D0                       ; $0120FC
        TST.B  D3                               ; $012100
        BNE.S  .loc_0084                        ; $012102
        MOVE.W  #$0060,D0                       ; $012104
.loc_0084:
        MOVE.W  #$0010,D1                       ; $012108
.loc_0088:
        TST.B  $00A15120                        ; $01210C
        BNE.S  .loc_0088                        ; $012112
        DC.W    $4EBA,$C29E         ; JSR     $00E3B4(PC); $012114
        MOVEQ   #$00,D0                         ; $012118
        TST.B  (-24550).W                       ; $01211A
        BEQ.S  .loc_00A6                        ; $01211E
        MOVE.B  (-24551).W,D0                   ; $012120
        MOVE.W  #$0010,D2                       ; $012124
        BRA.S  .loc_00AE                        ; $012128
.loc_00A6:
        MOVE.B  (-24548).W,D0                   ; $01212A
        MOVE.W  #$FFC0,D2                       ; $01212E
.loc_00AE:
        LEA     $00892206,A1                    ; $012132
        DC.W    $D040                           ; $012138
        MOVE.W  D0,D1                           ; $01213A
        DC.W    $D040                           ; $01213C
        DC.W    $D041                           ; $01213E
        MOVEA.L $00(A1,D0.W),A0                 ; $012140
        MOVE.W  $04(A1,D0.W),D0                 ; $012144
        MOVE.W  #$0010,D1                       ; $012148
.loc_00C8:
        TST.B  $00A15120                        ; $01214C
        BNE.S  .loc_00C8                        ; $012152
        DC.W    $4EBA,$C25E         ; JSR     $00E3B4(PC); $012154
.loc_00D4:
        TST.B  $00A15120                        ; $012158
        BNE.S  .loc_00D4                        ; $01215E
        MOVE.W  #$0101,$00A1512C                ; $012160
        MOVE.W  #$4000,$00A15128                ; $012168
        MOVE.B  #$2C,$00A15121                  ; $012170
        MOVE.B  #$01,$00A15120                  ; $012178
.loc_00FC:
        TST.B  $00A1512C                        ; $012180
        BNE.S  .loc_00FC                        ; $012186
        MOVE.W  #$0078,$00A15128                ; $012188
        MOVE.W  #$0101,$00A1512C                ; $012190
        MOVEQ   #$00,D0                         ; $012198
        MOVE.B  (-24551).W,D0                   ; $01219A
        TST.B  (-24550).W                       ; $01219E
        BEQ.S  .loc_0124                        ; $0121A2
        MOVE.B  (-24549).W,D0                   ; $0121A4
.loc_0124:
        MOVE.L  D0,(-24546).W                   ; $0121A8
        MOVEQ   #$00,D0                         ; $0121AC
        MOVE.B  (-24551).W,D0                   ; $0121AE
        TST.B  (-24550).W                       ; $0121B2
        BNE.S  .loc_0138                        ; $0121B6
        MOVE.B  (-24548).W,D0                   ; $0121B8
.loc_0138:
        MOVE.L  D0,(-24542).W                   ; $0121BC
        MOVEA.L #$0601BE00,A0                   ; $0121C0
        MOVEQ   #$00,D1                         ; $0121C6
        MOVE.W  (-24532).W,D0                   ; $0121C8
        BEQ.S  .loc_0158                        ; $0121CC
        SUBQ.W  #1,D0                           ; $0121CE
.loc_014C:
        ADDI.L  #$00000280,D1                   ; $0121D0
        DBRA    D0,.loc_014C                    ; $0121D6
        ADDA.L  D1,A0                           ; $0121DA
.loc_0158:
        MOVEA.L (-24524).W,A1                   ; $0121DC
        MOVE.W  #$0028,D0                       ; $0121E0
        MOVE.W  #$0060,D1                       ; $0121E4
        DC.W    $4EBA,$C170         ; JSR     $00E35A(PC); $0121E8
        ADDQ.W  #4,(-14210).W                   ; $0121EC
        MOVE.W  #$0020,$00FF0008                ; $0121F0
        RTS                                     ; $0121F8
