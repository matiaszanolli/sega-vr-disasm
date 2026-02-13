; ============================================================================
; Scene Send Cmd 027 (auto-analyzed)
; ROM Range: $00DA90-$00DCAC (540 bytes)
; ============================================================================
; Category: game
; Purpose: Orchestrator calling 6 subroutines
;   RAM: $C87E (game_state)
;   Calls: dma_transfer, sh2_send_cmd
;   Object (A0): +$00, +$02 (flags/type), +$04 (speed_index/velocity), +$06 (speed), +$08
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, D3, D4, D5, A0, A1, A4
; RAM:
;   $C87E: game_state
; Calls:
;   $00E35A: sh2_send_cmd
;   $00E52C: dma_transfer
; Object fields:
;   +$00: [unknown]
;   +$02: flags/type
;   +$04: speed_index/velocity
;   +$06: speed
;   +$08: [unknown]
; Confidence: medium
; ============================================================================

fn_c200_027:
        MOVE.L  $6AE2(A1),D1                    ; $00DA90
        MOVE.L  -$7BF4(A1),D1                   ; $00DA94
        MOVE.L  -$5D12(A1),D1                   ; $00DA98
        MOVE.L  -$4608(A1),D1                   ; $00DA9C
        MOVE.L  -$2CD4(A1),D1                   ; $00DAA0
        MOVE.L  $6AE2(A1),D1                    ; $00DAA4
        DC.W    $008B                           ; $00DAA8
        CMP.W  (A4)+,D3                         ; $00DAAA
        DC.W    $008B                           ; $00DAAC
        EOR.W  D3,(A4)+                         ; $00DAAE
        DC.W    $008B                           ; $00DAB0
        CMP.W  (A4)+,D4                         ; $00DAB2
        DC.W    $008B                           ; $00DAB4
        EOR.W  D4,(A4)+                         ; $00DAB6
        DC.W    $008B                           ; $00DAB8
        CMP.W  (A4)+,D5                         ; $00DABA
        DC.W    $008B                           ; $00DABC
        CMP.W  (A4)+,D3                         ; $00DABE
        CLR.W  D0                               ; $00DAC0
        MOVE.B  (-24537).W,D0                   ; $00DAC2
        DC.W    $4EBA,$0A64         ; JSR     $00E52C(PC); $00DAC6
        MOVEA.L #$0603D100,A0                   ; $00DACA
        MOVEA.L #$24004C58,A1                   ; $00DAD0
        MOVE.W  #$0090,D0                       ; $00DAD6
        MOVE.W  #$0010,D1                       ; $00DADA
        DC.W    $6100,$087A         ; BSR.W  $00E35A; $00DADE
        CLR.W  D0                               ; $00DAE2
        MOVE.B  (-24551).W,D0                   ; $00DAE4
        TST.B  (-24537).W                       ; $00DAE8
        BEQ.W  .loc_0064                        ; $00DAEC
        MOVE.B  (-24539).W,D0                   ; $00DAF0
.loc_0064:
        DC.W    $D040                           ; $00DAF4
        MOVE.W  D0,D1                           ; $00DAF6
        DC.W    $D040                           ; $00DAF8
        DC.W    $D040                           ; $00DAFA
        DC.W    $D041                           ; $00DAFC
        LEA     $00FF2000,A0                    ; $00DAFE
        MOVE.W  $00(A0,D0.W),(-24550).W         ; $00DB04
        MOVE.W  $02(A0,D0.W),(-24548).W         ; $00DB0A
        MOVE.W  $04(A0,D0.W),(-24546).W         ; $00DB10
        MOVE.W  $06(A0,D0.W),(-24544).W         ; $00DB16
        MOVE.W  $08(A0,D0.W),(-24542).W         ; $00DB1C
        MOVE.W  (-14226).W,D1                   ; $00DB22
        LSR.L  #8,D1                            ; $00DB26
        BTST    #7,D1                           ; $00DB28
        BEQ.W  .loc_01CE                        ; $00DB2C
        BTST    #5,D1                           ; $00DB30
        BNE.W  .loc_0174                        ; $00DB34
        BTST    #0,D1                           ; $00DB38
        BEQ.S  .loc_00CA                        ; $00DB3C
        MOVE.W  (-24548).W,D0                   ; $00DB3E
        DC.W    $6100,$0168         ; BSR.W  $00DCAC; $00DB42
        CMPI.W  #$02F0,D0                       ; $00DB46
        BLT.W  .loc_00C2                        ; $00DB4A
        MOVE.W  #$02F0,D0                       ; $00DB4E
.loc_00C2:
        MOVE.W  D0,(-24548).W                   ; $00DB52
        BRA.W  .loc_01CE                        ; $00DB56
.loc_00CA:
        BTST    #1,D1                           ; $00DB5A
        BEQ.S  .loc_00EC                        ; $00DB5E
        MOVE.W  (-24548).W,D0                   ; $00DB60
        DC.W    $6100,$0158         ; BSR.W  $00DCBE; $00DB64
        CMPI.W  #$FBFE,D0                       ; $00DB68
        BGT.W  .loc_00E4                        ; $00DB6C
        MOVE.W  #$FBFE,D0                       ; $00DB70
.loc_00E4:
        MOVE.W  D0,(-24548).W                   ; $00DB74
        BRA.W  .loc_01CE                        ; $00DB78
.loc_00EC:
        BTST    #3,D1                           ; $00DB7C
        BEQ.S  .loc_010E                        ; $00DB80
        MOVE.W  (-24550).W,D0                   ; $00DB82
        DC.W    $6100,$0124         ; BSR.W  $00DCAC; $00DB86
        CMPI.W  #$0120,D0                       ; $00DB8A
        BLT.W  .loc_0106                        ; $00DB8E
        MOVE.W  #$0120,D0                       ; $00DB92
.loc_0106:
        MOVE.W  D0,(-24550).W                   ; $00DB96
        BRA.W  .loc_01CE                        ; $00DB9A
.loc_010E:
        BTST    #2,D1                           ; $00DB9E
        BEQ.S  .loc_0130                        ; $00DBA2
        MOVE.W  (-24550).W,D0                   ; $00DBA4
        DC.W    $6100,$0114         ; BSR.W  $00DCBE; $00DBA8
        CMPI.W  #$FEE0,D0                       ; $00DBAC
        BGT.W  .loc_0128                        ; $00DBB0
        MOVE.W  #$FEE0,D0                       ; $00DBB4
.loc_0128:
        MOVE.W  D0,(-24550).W                   ; $00DBB8
        BRA.W  .loc_01CE                        ; $00DBBC
.loc_0130:
        BTST    #6,D1                           ; $00DBC0
        BEQ.S  .loc_0152                        ; $00DBC4
        MOVE.W  (-24546).W,D0                   ; $00DBC6
        DC.W    $6100,$00E0         ; BSR.W  $00DCAC; $00DBCA
        CMPI.W  #$0460,D0                       ; $00DBCE
        BLT.W  .loc_014A                        ; $00DBD2
        MOVE.W  #$0460,D0                       ; $00DBD6
.loc_014A:
        MOVE.W  D0,(-24546).W                   ; $00DBDA
        BRA.W  .loc_01CE                        ; $00DBDE
.loc_0152:
        BTST    #4,D1                           ; $00DBE2
        BEQ.S  .loc_01CE                        ; $00DBE6
        MOVE.W  (-24546).W,D0                   ; $00DBE8
        DC.W    $6100,$00D0         ; BSR.W  $00DCBE; $00DBEC
        CMPI.W  #$0050,D0                       ; $00DBF0
        BGT.W  .loc_016C                        ; $00DBF4
        MOVE.W  #$0050,D0                       ; $00DBF8
.loc_016C:
        MOVE.W  D0,(-24546).W                   ; $00DBFC
        BRA.W  .loc_01CE                        ; $00DC00
.loc_0174:
        BTST    #0,D1                           ; $00DC04
        BEQ.S  .loc_018A                        ; $00DC08
        MOVE.W  (-24544).W,D0                   ; $00DC0A
        DC.W    $6100,$00A8         ; BSR.W  $00DCB8; $00DC0E
        MOVE.W  D0,(-24544).W                   ; $00DC12
        BRA.W  .loc_01CE                        ; $00DC16
.loc_018A:
        BTST    #1,D1                           ; $00DC1A
        BEQ.S  .loc_01A0                        ; $00DC1E
        MOVE.W  (-24544).W,D0                   ; $00DC20
        DC.W    $6100,$00A4         ; BSR.W  $00DCCA; $00DC24
        MOVE.W  D0,(-24544).W                   ; $00DC28
        BRA.W  .loc_01CE                        ; $00DC2C
.loc_01A0:
        BTST    #3,D1                           ; $00DC30
        BEQ.S  .loc_01B6                        ; $00DC34
        MOVE.W  (-24542).W,D0                   ; $00DC36
        DC.W    $6100,$007C         ; BSR.W  $00DCB8; $00DC3A
        MOVE.W  D0,(-24542).W                   ; $00DC3E
        BRA.W  .loc_01CE                        ; $00DC42
.loc_01B6:
        BTST    #2,D1                           ; $00DC46
        BEQ.S  .loc_01CE                        ; $00DC4A
        MOVE.W  (-24542).W,D0                   ; $00DC4C
        DC.W    $6100,$0078         ; BSR.W  $00DCCA; $00DC50
        MOVE.W  D0,(-24542).W                   ; $00DC54
        BRA.W  .loc_01CE                        ; $00DC58
        NOP                                     ; $00DC5C
.loc_01CE:
        CLR.W  D0                               ; $00DC5E
        MOVE.B  (-24551).W,D0                   ; $00DC60
        TST.B  (-24537).W                       ; $00DC64
        BEQ.W  .loc_01E0                        ; $00DC68
        MOVE.B  (-24539).W,D0                   ; $00DC6C
.loc_01E0:
        DC.W    $D040                           ; $00DC70
        MOVE.W  D0,D1                           ; $00DC72
        DC.W    $D040                           ; $00DC74
        DC.W    $D040                           ; $00DC76
        DC.W    $D041                           ; $00DC78
        LEA     $00FF2000,A0                    ; $00DC7A
        MOVE.W  (-24550).W,$00(A0,D0.W)         ; $00DC80
        MOVE.W  (-24548).W,$02(A0,D0.W)         ; $00DC86
        MOVE.W  (-24546).W,$04(A0,D0.W)         ; $00DC8C
        MOVE.W  (-24544).W,$06(A0,D0.W)         ; $00DC92
        MOVE.W  (-24542).W,$08(A0,D0.W)         ; $00DC98
        MOVE.W  #$0020,$00FF0008                ; $00DC9E
        ADDQ.W  #4,(-14210).W                   ; $00DCA6
        RTS                                     ; $00DCAA
