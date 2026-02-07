; ============================================================================
; Name Entry 005 (auto-analyzed)
; ROM Range: $0119B8-$011A5C (164 bytes)
; ============================================================================
; Category: game
; Purpose: Function in 10200 section (164 bytes)
;
; Uses: D0, D1, D2, D3, D4, D5, A0, A1
; Confidence: low
; ============================================================================

fn_10200_005:
        LEA     $00FF6E00,A0                    ; $0119B8
        ADDA.L  #$000001E0,A0                   ; $0119BE
        LEA     $00891A70,A1                    ; $0119C4
        MOVE.W  #$0007,D0                       ; $0119CA
.loc_0016:
        MOVE.W  (A1)+,D1                        ; $0119CE
        BSET    #15,D1                          ; $0119D0
        MOVE.W  D1,(A0)+                        ; $0119D4
        DBRA    D0,.loc_0016                    ; $0119D6
        MOVEQ   #$00,D0                         ; $0119DA
        MOVE.B  (-24551).W,D0                   ; $0119DC
        DC.W    $D080                           ; $0119E0
        DC.W    $D080                           ; $0119E2
        DC.W    $D080                           ; $0119E4
        LEA     $00FF6E00,A0                    ; $0119E6
        ADDA.L  #$000001E0,A0                   ; $0119EC
        ADDA.L  D0,A0                           ; $0119F2
        LEA     $00891A80,A1                    ; $0119F4
        MOVEQ   #$00,D1                         ; $0119FA
        MOVE.B  (-24550).W,D1                   ; $0119FC
        MOVE.W  #$0003,D2                       ; $011A00
.loc_004C:
        MOVE.W  (A1)+,D5                        ; $011A04
        DC.W    $6154               ; BSR.S  $011A5C; $011A06
        MOVE.W  D5,D3                           ; $011A08
        MOVE.W  (A1)+,D5                        ; $011A0A
        DC.W    $614E               ; BSR.S  $011A5C; $011A0C
        MOVE.W  D5,D4                           ; $011A0E
        MOVE.W  (A1)+,D5                        ; $011A10
        DC.W    $6148               ; BSR.S  $011A5C; $011A12
        LSL.W  #5,D4                            ; $011A14
        LSL.W  #8,D5                            ; $011A16
        LSL.W  #2,D5                            ; $011A18
        DC.W    $8644                           ; $011A1A
        DC.W    $8645                           ; $011A1C
        BSET    #15,D3                          ; $011A1E
        MOVE.W  D3,(A0)+                        ; $011A22
        DBRA    D2,.loc_004C                    ; $011A24
        MOVE.B  (-24550).W,D0                   ; $011A28
        MOVE.B  (-24548).W,D1                   ; $011A2C
        DC.W    $D001                           ; $011A30
        CMPI.B  #$1F,D0                         ; $011A32
        BLE.S  .loc_008A                        ; $011A36
        MOVE.B  #$1F,D0                         ; $011A38
        MOVE.B  #$FE,D1                         ; $011A3C
        BRA.S  .loc_0094                        ; $011A40
.loc_008A:
        TST.B  D0                               ; $011A42
        BGE.S  .loc_0094                        ; $011A44
        CLR.B  D0                               ; $011A46
        MOVE.B  #$02,D1                         ; $011A48
.loc_0094:
        MOVE.B  D0,(-24550).W                   ; $011A4C
        MOVE.B  D1,(-24548).W                   ; $011A50
        MOVE.B  #$01,(-14303).W                 ; $011A54
        RTS                                     ; $011A5A
