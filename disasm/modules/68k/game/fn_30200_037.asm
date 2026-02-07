; ============================================================================
; Vdp 037 (auto-analyzed)
; ROM Range: $030FA2-$030FC8 (38 bytes)
; ============================================================================
; Category: vdp
; Purpose: Short helper function
;   Accesses VDP registers
;   Object (A0, A5): +$01, +$0C
;
; Entry: A0 = object/entity pointer
; Entry: A5 = object/entity pointer
; Uses: D0, A0, A5
; Object fields:
;   +$01: [unknown]
;   +$0C: [unknown]
; Confidence: medium
; ============================================================================

fn_30200_037:
        MOVE.B  $01(A0,D0.W),$000C(A5)          ; $030FA2
        DC.W    $6084               ; BRA.S  $030F2E; $030FA8
        CLR.B  $000C(A5)                        ; $030FAA
        DC.W    $6000,$FF7E         ; BRA.W  $030F2E; $030FAE
        BTST    #2,(A5)                         ; $030FB2
        BNE.S  .loc_0024                        ; $030FB6
        MOVE.B  $0001(A5),D0                    ; $030FB8
        ORI.B  #$1F,D0                          ; $030FBC
        MOVE.B  D0,$00C00011                    ; $030FC0
.loc_0024:
        RTS                                     ; $030FC6
