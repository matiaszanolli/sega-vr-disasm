; ============================================================================
; Vint Unpack Tiles Vdp 013 (auto-analyzed)
; ROM Range: $0024CA-$002594 (202 bytes)
; ============================================================================
; Category: vint
; Purpose: Calls: unpack_tiles_vdp
;
; Uses: A0, A5
; Calls:
;   $00247C: unpack_tiles_vdp
; Confidence: low
; ============================================================================

fn_2200_013:
        TST.B  (-14323).W                       ; $0024CA
        BNE.W  .loc_00C8                        ; $0024CE
        MOVE.W  #$0000,(-32768).W               ; $0024D2
        MOVE.W  #$FFF8,(-14208).W               ; $0024D8
        LEA     $00FF6116,A0                    ; $0024DE
        MOVE.L  #$62020002,(A5)                 ; $0024E4
        DC.W    $4EBA,$FF90         ; JSR     $00247C(PC); $0024EA
        LEA     (-28622).W,A0                   ; $0024EE
        MOVE.L  #$620C0002,(A5)                 ; $0024F2
        DC.W    $4EBA,$FF82         ; JSR     $00247C(PC); $0024F8
        LEA     $00FF611A,A0                    ; $0024FC
        MOVE.L  #$62160002,(A5)                 ; $002502
        DC.W    $4EBA,$FF72         ; JSR     $00247C(PC); $002508
        LEA     $00FF6108,A0                    ; $00250C
        MOVE.L  #$63020002,(A5)                 ; $002512
        DC.W    $4EBA,$FF62         ; JSR     $00247C(PC); $002518
        LEA     $00FF610A,A0                    ; $00251C
        MOVE.L  #$630C0002,(A5)                 ; $002522
        DC.W    $4EBA,$FF52         ; JSR     $00247C(PC); $002528
        LEA     $00FF610C,A0                    ; $00252C
        MOVE.L  #$63160002,(A5)                 ; $002532
        DC.W    $4EBA,$FF42         ; JSR     $00247C(PC); $002538
        LEA     $00FF6104,A0                    ; $00253C
        MOVE.L  #$632A0002,(A5)                 ; $002542
        DC.W    $4EBA,$FF32         ; JSR     $00247C(PC); $002548
        LEA     $00FF6106,A0                    ; $00254C
        MOVE.L  #$63340002,(A5)                 ; $002552
        DC.W    $4EBA,$FF22         ; JSR     $00247C(PC); $002558
        LEA     $00FF5FF8,A0                    ; $00255C
        MOVE.L  #$640C0002,(A5)                 ; $002562
        DC.W    $4EBA,$FF12         ; JSR     $00247C(PC); $002568
        MOVE.L  #$64160002,(A5)                 ; $00256C
        DC.W    $4EBA,$FF08         ; JSR     $00247C(PC); $002572
        MOVE.L  #$64200002,(A5)                 ; $002576
        DC.W    $4EBA,$FEFE         ; JSR     $00247C(PC); $00257C
        MOVE.L  #$642A0002,(A5)                 ; $002580
        DC.W    $4EBA,$FEF4         ; JSR     $00247C(PC); $002586
        MOVE.B  #$00,$00FF5FFF                  ; $00258A
.loc_00C8:
        RTS                                     ; $002592
