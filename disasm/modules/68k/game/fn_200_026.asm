; ============================================================================
; Vdp Dispatch 026 (auto-analyzed)
; ROM Range: $001610-$00166C (92 bytes)
; ============================================================================
; Category: vdp
; Purpose: State dispatcher using jump table
;   Calls: vdp_copy_rows
;
; Uses: D0, D1, D2, A0
; Calls:
;   $0010C4: vdp_copy_rows
; Confidence: medium
; ============================================================================

fn_200_026:
        ORI.L  #$3B8E00FF,(A0)                  ; $001610
        MOVE.B  D0,D0                           ; $001616
        ORI.L  #$5A7E00FF,(A0)                  ; $001618
        MOVE.B  D0,D0                           ; $00161E
        ORI.L  #$77CE00FF,(A0)                  ; $001620
        MOVE.B  D0,D0                           ; $001626
        ORI.L  #$992E00FF,(A0)                  ; $001628
        MOVE.B  D0,D0                           ; $00162E
        ORI.L  #$C30E00FF,(A0)                  ; $001630
        MOVE.B  D0,D0                           ; $001636
        MOVE    #$2700,SR                       ; $001638
        MOVEQ   #$03,D2                         ; $00163C
.loc_002E:
        MOVEQ   #$00,D1                         ; $00163E
        MOVE.B  D0,D1                           ; $001640
        BEQ.S  .loc_0050                        ; $001642
        MULU    #$000C,D1                       ; $001644
        MOVEM.L D0/D1/D2,-(A7)                  ; $001648
        LEA     $00166C(PC,D1.W),A0             ; $00164C
        MOVE.W  -(A0),D2                        ; $001650
        MOVE.W  -(A0),D1                        ; $001652
        MOVE.L  -(A0),D0                        ; $001654
        MOVEA.L -(A0),A0                        ; $001656
        DC.W    $4EBA,$FA6A         ; JSR     $0010C4(PC); $001658
        MOVEM.L (A7)+,D0/D1/D2                  ; $00165C
.loc_0050:
        ROR.L  #8,D0                            ; $001660
        DBRA    D2,.loc_002E                    ; $001662
        MOVE    #$2300,SR                       ; $001666
        RTS                                     ; $00166A
