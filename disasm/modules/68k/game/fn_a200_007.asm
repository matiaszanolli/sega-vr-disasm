; ============================================================================
; Ai 007 (auto-analyzed)
; ROM Range: $00B1B8-$00B25E (166 bytes)
; ============================================================================
; Category: game
; Purpose: Orchestrator calling 3 subroutines
;   Object (A1, A3): +$00
;
; Entry: A1 = object/entity pointer
; Entry: A3 = object/entity pointer
; Uses: D0, D3, A1, A3
; Object fields:
;   +$00: [unknown]
; Confidence: low
; ============================================================================

fn_a200_007:
        MOVEQ   #$00,D0                         ; $00B1B8
        MOVE.W  (-28628).W,D0                   ; $00B1BA
        CMPI.W  #$0005,D0                       ; $00B1BE
        BNE.S  .loc_000E                        ; $00B1C2
        SUBQ.W  #1,D0                           ; $00B1C4
.loc_000E:
        LEA     (-15872).W,A1                   ; $00B1C6
        DC.W    $D040                           ; $00B1CA
        DC.W    $D040                           ; $00B1CC
        MOVE.W  D0,D3                           ; $00B1CE
        ADDA.L  D0,A1                           ; $00B1D0
        MOVEQ   #$00,D0                         ; $00B1D2
        MOVE.B  (-14330).W,D0                   ; $00B1D4
        DC.W    $D040                           ; $00B1D8
        LEA     $00899884,A3                    ; $00B1DA
        MOVE.W  $00(A3,D0.W),D0                 ; $00B1E0
        MOVE.B  D0,(A1)+                        ; $00B1E4
        MOVEQ   #$00,D0                         ; $00B1E6
        MOVE.B  (-14329).W,D0                   ; $00B1E8
        SUBI.B  #$C4,D0                         ; $00B1EC
        DC.W    $D040                           ; $00B1F0
        LEA     $00899884,A3                    ; $00B1F2
        MOVE.W  $00(A3,D0.W),D0                 ; $00B1F8
        MOVE.B  D0,(A1)+                        ; $00B1FC
        MOVEQ   #$00,D0                         ; $00B1FE
        MOVE.B  (-14328).W,D0                   ; $00B200
        SUBI.B  #$C4,D0                         ; $00B204
        DC.W    $D040                           ; $00B208
        LEA     $0089980C,A3                    ; $00B20A
        MOVE.W  $00(A3,D0.W),D0                 ; $00B210
        MOVE.W  D0,(A1)                         ; $00B214
        DC.W    $4EBA,$00D4         ; JSR     $00B2EC(PC); $00B216
        DC.W    $4EBA,$0206         ; JSR     $00B422(PC); $00B21A
        MOVEQ   #$03,D3                         ; $00B21E
        DC.W    $4EBA,$003E         ; JSR     $00B260(PC); $00B220
        CMPI.W  #$0005,(-28628).W               ; $00B224
        BNE.S  .loc_00A4                        ; $00B22A
        MOVE.L  (-15856).W,D0                   ; $00B22C
        CMP.L  (-15788).W,D0                    ; $00B230
        BGE.S  .loc_00A4                        ; $00B234
        MOVE.L  D0,(-15788).W                   ; $00B236
        MOVEQ   #$00,D0                         ; $00B23A
        MOVE.B  (-15609).W,D0                   ; $00B23C
        LEA     $00FF68D1,A1                    ; $00B240
        LEA     $00(A1,D0.W),A1                 ; $00B246
        MOVE.B  #$00,(A1)                       ; $00B24A
        MOVE.B  #$50,(-15609).W                 ; $00B24E
        MOVE.B  #$01,$00FF6911                  ; $00B254
.loc_00A4:
        RTS                                     ; $00B25C
