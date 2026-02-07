; ============================================================================
; Input Button Remap 028 (auto-analyzed)
; ROM Range: $00178E-$0017D6 (72 bytes)
; ============================================================================
; Category: input
; Purpose: Reads controller input
;   Calls: zbus_request, button_remap
;
; Uses: D0, D2, A0, A1, A2, A3
; Calls:
;   $0017EE: button_remap
;   $00185E: zbus_request
; Confidence: high
; ============================================================================

fn_200_028:
        DC.W    $0406                           ; $00178E
        BTST    D0,D0                           ; $001790
        BTST    D2,D0                           ; $001792
        DC.W    $0000                           ; $001794
        DC.W    $0406                           ; $001796
        BTST    D0,D0                           ; $001798
        DC.W    $050A                           ; $00179A
        DC.W    $0908                           ; $00179C
        CMPI.B  #$0D,(-14320).W                 ; $00179E
        DC.W    $6630               ; BNE.S  $0017D6; $0017A4
        LEA     (-14228).W,A0                   ; $0017A6
        MOVE.L  (A0),$00FF60D0                  ; $0017AA
        LEA     $00A10003,A1                    ; $0017B0
        LEA     (-13968).W,A2                   ; $0017B6
        LEA     (-382).W,A3                     ; $0017BA
        DC.W    $4EBA,$009E         ; JSR     $00185E(PC); $0017BE
        DC.W    $4EBA,$002A         ; JSR     $0017EE(PC); $0017C2
        CMPI.B  #$0D,(-14319).W                 ; $0017C6
        DC.W    $6716               ; BEQ.S  $0017E4; $0017CC
        MOVE.B  #$00,(-14226).W                 ; $0017CE
        RTS                                     ; $0017D4
