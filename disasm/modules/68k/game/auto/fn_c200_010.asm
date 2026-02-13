; ============================================================================
; fn_c200_010 — Race Scene Data Loader
; ROM Range: $00C6B6-$00C7C2 (268 bytes)
; Race initialization orchestrator. Loads terrain, entity, and track
; data via 4 subroutine calls ($0048EA, $0048D2). Configures SH2
; communication ($00FF0002/$00FF0008), sets camera viewport
; ($00C0/$0540), race parameters (speed limits, distances), and
; populates entity sort keys (+$0A, +$B6) from ROM table.
; Initializes timing table pointer at $0088C7E0.
;
; Uses: D0-D7, A0-A6 (saves/restores via MOVEM)
; Confidence: high
; ============================================================================

fn_c200_010:
        MOVE.B  #$00,(-14092).W                 ; $00C6B6
        BCLR    #7,(-14308).W                   ; $00C6BC
        MOVE.L  #$00894262,$00FF0002            ; $00C6C2
        MOVE.W  #$0020,$00FF0008                ; $00C6CC
        JMP     $00882890                       ; $00C6D4
        LEA     $008BB45C,A1                    ; $00C6DA
        LEA     (-20480).W,A2                   ; $00C6E0
        DC.W    $4EBA,$8204         ; JSR     $0048EA(PC); $00C6E4
        LEA     $008BAFC4,A1                    ; $00C6E8
        LEA     (-19456).W,A2                   ; $00C6EE
        DC.W    $4EBA,$81DE         ; JSR     $0048D2(PC); $00C6F2
        LEA     $008BA220,A1                    ; $00C6F6
        MOVE.W  (-14176).W,D0                   ; $00C6FC
        MOVEA.L $00(A1,D0.W),A1                 ; $00C700
        LEA     $00FF6E00,A2                    ; $00C704
        DC.W    $4EBA,$81C6         ; JSR     $0048D2(PC); $00C70A
        LEA     $008BAE38,A1                    ; $00C70E
        MOVE.W  (-14132).W,D0                   ; $00C714
        MOVEA.L $00(A1,D0.W),A1                 ; $00C718
        LEA     $00FF6E40,A2                    ; $00C71C
        DC.W    $4EBA,$81C6         ; JSR     $0048EA(PC); $00C722
        MOVE.B  #$03,(-14326).W                 ; $00C726
        LEA     (-15872).W,A2                   ; $00C72C
        LEA     (-4384).W,A1                    ; $00C730
        JSR     $00884920                       ; $00C734
        MOVE.L  (-4356).W,(-15788).W            ; $00C73A
        MOVE.W  #$00C0,(-16300).W               ; $00C740
        MOVE.W  #$0540,(-16298).W               ; $00C746
        MOVE.W  #$0000,(-14186).W               ; $00C74C
        DC.W    $4EBA,$A808         ; JSR     $006F5C(PC); $00C752
        DC.W    $4EBA,$C166         ; JSR     $0088BE(PC); $00C756
        MOVE.W  #$00C0,(-16184).W               ; $00C75A
        MOVE.W  #$07D0,(-14124).W               ; $00C760
        MOVE.W  #$0600,(-14122).W               ; $00C766
        MOVE.W  #$3000,(-14120).W               ; $00C76C
        MOVE.W  #$0000,(-14118).W               ; $00C772
        MOVE.W  #$00C0,(-14116).W               ; $00C778
        MOVE.W  #$0540,(-14114).W               ; $00C77E
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7/A0/A1/A2/A3/A4/A5/A6,-(A7); $00C784
        MOVEQ   #$00,D1                         ; $00C788
        DC.W    $43FA,$0036         ; LEA     $00C7C2(PC),A1; $00C78A
        LEA     (-28416).W,A2                   ; $00C78E
        MOVEQ   #$0E,D0                         ; $00C792
.loc_00DE:
        MOVE.W  (A1),$00B6(A2)                  ; $00C794
        MOVE.W  (A1)+,$000A(A2)                 ; $00C798
        LEA     $0100(A2),A2                    ; $00C79C
        DBRA    D0,.loc_00DE                    ; $00C7A0
        MOVE.L  #$0088C7E0,(-15744).W           ; $00C7A4
        LEA     $0093C0EC,A0                    ; $00C7AC
        MOVEA.W (-14144).W,A1                   ; $00C7B2
        JSR     $008813B4                       ; $00C7B6
        MOVEM.L (A7)+,D0/D1/D2/D3/D4/D5/D6/D7/A0/A1/A2/A3/A4/A5/A6; $00C7BC
        RTS                                     ; $00C7C0
