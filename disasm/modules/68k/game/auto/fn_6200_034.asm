; ============================================================================
; Obj Frame Calc 034 (auto-analyzed)
; ROM Range: $007700-$00789C (412 bytes)
; ============================================================================
; Category: game
; Purpose: Calls: obj_frame_calc
;   Object (A0): +$30 (x_position), +$32, +$34 (y_position), +$36, +$38, +$40 (heading_angle)
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, D2, D3, D4, D5, D6, D7
; Calls:
;   $00789C: obj_frame_calc
; Object fields:
;   +$30: x_position
;   +$32: [unknown]
;   +$34: y_position
;   +$36: [unknown]
;   +$38: [unknown]
;   +$40: heading_angle
;   +$42: [unknown]
;   +$46: display_scale
; Confidence: medium
; ============================================================================

fn_6200_034:
        DC.W    $4EBA,$019A         ; JSR     $00789C(PC); $007700
        CMPI.W  #$0000,$0062(A0)                ; $007704
        BGT.W  .loc_00FA                        ; $00770A
        BTST    #0,$0055(A0)                    ; $00770E
        BEQ.W  .loc_00FA                        ; $007714
        MOVE.W  $0040(A0),D3                    ; $007718
        SUB.W  $0042(A0),D3                     ; $00771C
        ASR.W  #2,D3                            ; $007720
        MOVE.W  $0046(A0),D4                    ; $007722
        SUB.W  $0048(A0),D4                     ; $007726
        ASR.W  #2,D4                            ; $00772A
        MOVE.W  $0030(A0),D5                    ; $00772C
        SUB.W  $0036(A0),D5                     ; $007730
        ASR.W  #2,D5                            ; $007734
        MOVE.W  $0034(A0),D6                    ; $007736
        SUB.W  $0038(A0),D6                     ; $00773A
        ASR.W  #2,D6                            ; $00773E
        MOVE.W  $0036(A0),$0030(A0)             ; $007740
        MOVE.W  $0038(A0),$0034(A0)             ; $007746
        MOVE.W  $0042(A0),$0040(A0)             ; $00774C
        MOVE.W  $0048(A0),$0046(A0)             ; $007752
        ADD.W  D3,$0040(A0)                     ; $007758
        ADD.W  D4,$0046(A0)                     ; $00775C
        ADD.W  D5,$0030(A0)                     ; $007760
        ADD.W  D6,$0034(A0)                     ; $007764
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7,-(A7)   ; $007768
        DC.W    $4EBA,$012E         ; JSR     $00789C(PC); $00776C
        MOVEM.L (A7)+,D0/D1/D2/D3/D4/D5/D6/D7   ; $007770
        BTST    #0,$0055(A0)                    ; $007774
        BNE.W  .loc_00EA                        ; $00777A
        ADD.W  D3,$0040(A0)                     ; $00777E
        ADD.W  D4,$0046(A0)                     ; $007782
        ADD.W  D5,$0030(A0)                     ; $007786
        ADD.W  D6,$0034(A0)                     ; $00778A
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7,-(A7)   ; $00778E
        DC.W    $4EBA,$0108         ; JSR     $00789C(PC); $007792
        MOVEM.L (A7)+,D0/D1/D2/D3/D4/D5/D6/D7   ; $007796
        BTST    #0,$0055(A0)                    ; $00779A
        BNE.S  .loc_00EA                        ; $0077A0
        ADD.W  D3,$0040(A0)                     ; $0077A2
        ADD.W  D4,$0046(A0)                     ; $0077A6
        ADD.W  D5,$0030(A0)                     ; $0077AA
        ADD.W  D6,$0034(A0)                     ; $0077AE
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7,-(A7)   ; $0077B2
        DC.W    $4EBA,$00E4         ; JSR     $00789C(PC); $0077B6
        MOVEM.L (A7)+,D0/D1/D2/D3/D4/D5/D6/D7   ; $0077BA
        BTST    #0,$0055(A0)                    ; $0077BE
        BNE.S  .loc_00EA                        ; $0077C4
        ADD.W  D3,$0040(A0)                     ; $0077C6
        ADD.W  D4,$0046(A0)                     ; $0077CA
        ADD.W  D5,$0030(A0)                     ; $0077CE
        ADD.W  D6,$0034(A0)                     ; $0077D2
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7,-(A7)   ; $0077D6
        DC.W    $4EBA,$00C0         ; JSR     $00789C(PC); $0077DA
        MOVEM.L (A7)+,D0/D1/D2/D3/D4/D5/D6/D7   ; $0077DE
        BTST    #0,$0055(A0)                    ; $0077E2
        BEQ.S  .loc_00FA                        ; $0077E8
.loc_00EA:
        SUB.W  D3,$0040(A0)                     ; $0077EA
        SUB.W  D4,$0046(A0)                     ; $0077EE
        SUB.W  D5,$0030(A0)                     ; $0077F2
        SUB.W  D6,$0034(A0)                     ; $0077F6
.loc_00FA:
        MOVE.W  $0040(A0),$0042(A0)             ; $0077FA
        MOVE.W  $0046(A0),$0048(A0)             ; $007800
        MOVE.W  $0030(A0),$0036(A0)             ; $007806
        MOVE.W  $0034(A0),$0038(A0)             ; $00780C
        BRA.W  .loc_011A                        ; $007812
        DC.W    $4EBA,$0084         ; JSR     $00789C(PC); $007816
.loc_011A:
        MOVEA.L $00D2(A0),A2                    ; $00781A
        MOVE.W  (-16172).W,D1                   ; $00781E
        MOVE.W  (-16170).W,D2                   ; $007822
        DC.W    $4EBA,$FDB8         ; JSR     $0075E0(PC); $007826
        BLE.S  .loc_013A                        ; $00782A
        MOVE.W  $005A(A0),D2                    ; $00782C
        EXT.L   D2                              ; $007830
        DC.W    $D282                           ; $007832
        ASR.L  #1,D1                            ; $007834
        MOVE.W  D1,$005A(A0)                    ; $007836
.loc_013A:
        MOVEA.L $00D6(A0),A2                    ; $00783A
        MOVE.W  (-16168).W,D1                   ; $00783E
        MOVE.W  (-16166).W,D2                   ; $007842
        DC.W    $4EBA,$FD98         ; JSR     $0075E0(PC); $007846
        BLE.S  .loc_015A                        ; $00784A
        MOVE.W  $005C(A0),D2                    ; $00784C
        EXT.L   D2                              ; $007850
        DC.W    $D282                           ; $007852
        ASR.L  #1,D1                            ; $007854
        MOVE.W  D1,$005C(A0)                    ; $007856
.loc_015A:
        MOVEA.L $00DA(A0),A2                    ; $00785A
        MOVE.W  (-16164).W,D1                   ; $00785E
        MOVE.W  (-16162).W,D2                   ; $007862
        DC.W    $4EBA,$FD78         ; JSR     $0075E0(PC); $007866
        BLE.S  .loc_017A                        ; $00786A
        MOVE.W  $005E(A0),D2                    ; $00786C
        EXT.L   D2                              ; $007870
        DC.W    $D282                           ; $007872
        ASR.L  #1,D1                            ; $007874
        MOVE.W  D1,$005E(A0)                    ; $007876
.loc_017A:
        MOVEA.L $00CE(A0),A2                    ; $00787A
        MOVE.W  (-16176).W,D1                   ; $00787E
        MOVE.W  (-16174).W,D2                   ; $007882
        DC.W    $4EBA,$FD58         ; JSR     $0075E0(PC); $007886
        BLE.S  .loc_019A                        ; $00788A
        MOVE.W  $0032(A0),D2                    ; $00788C
        EXT.L   D2                              ; $007890
        DC.W    $D282                           ; $007892
        ASR.L  #1,D1                            ; $007894
        MOVE.W  D1,$0032(A0)                    ; $007896
.loc_019A:
        RTS                                     ; $00789A
