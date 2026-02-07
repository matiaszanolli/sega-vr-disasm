; ============================================================================
; Vint Unpack Tiles Vdp 015 (auto-analyzed)
; ROM Range: $0025B0-$00263E (142 bytes)
; ============================================================================
; Category: vint
; Purpose: Calls: unpack_tiles_vdp
;
; Uses: A0, A5
; Calls:
;   $00247C: unpack_tiles_vdp
; Confidence: low
; ============================================================================

fn_2200_015:
        TST.B  (-14323).W                       ; $0025B0
        BNE.W  .loc_008C                        ; $0025B4
        LEA     (-14200).W,A0                   ; $0025B8
        MOVE.L  #$65020002,(A5)                 ; $0025BC
        DC.W    $4EBA,$FEB8         ; JSR     $00247C(PC); $0025C2
        DC.W    $4EBA,$FEB4         ; JSR     $00247C(PC); $0025C6
        MOVEA.L (-14200).W,A0                   ; $0025CA
        MOVE.L  #$65140002,(A5)                 ; $0025CE
        DC.W    $4EBA,$FEA6         ; JSR     $00247C(PC); $0025D4
        MOVE.L  #$651E0002,(A5)                 ; $0025D8
        DC.W    $4EBA,$FE9C         ; JSR     $00247C(PC); $0025DE
        MOVE.L  #$65280002,(A5)                 ; $0025E2
        DC.W    $4EBA,$FE92         ; JSR     $00247C(PC); $0025E8
        MOVE.L  #$65320002,(A5)                 ; $0025EC
        DC.W    $4EBA,$FE88         ; JSR     $00247C(PC); $0025F2
        ADDQ.L  #8,(-14200).W                   ; $0025F6
        LEA     (-14200).W,A0                   ; $0025FA
        MOVE.L  #$66020002,(A5)                 ; $0025FE
        DC.W    $4EBA,$FE76         ; JSR     $00247C(PC); $002604
        DC.W    $4EBA,$FE72         ; JSR     $00247C(PC); $002608
        MOVEA.L (-14200).W,A0                   ; $00260C
        MOVE.L  #$66140002,(A5)                 ; $002610
        DC.W    $4EBA,$FE64         ; JSR     $00247C(PC); $002616
        MOVE.L  #$661E0002,(A5)                 ; $00261A
        DC.W    $4EBA,$FE5A         ; JSR     $00247C(PC); $002620
        MOVE.L  #$66280002,(A5)                 ; $002624
        DC.W    $4EBA,$FE50         ; JSR     $00247C(PC); $00262A
        MOVE.L  #$66320002,(A5)                 ; $00262E
        DC.W    $4EBA,$FE46         ; JSR     $00247C(PC); $002634
        SUBQ.L  #8,(-14200).W                   ; $002638
.loc_008C:
        RTS                                     ; $00263C
