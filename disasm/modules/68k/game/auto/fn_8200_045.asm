; ============================================================================
; State 045 (auto-analyzed)
; ROM Range: $009E5A-$009E6E (20 bytes)
; ============================================================================
; Category: game
; Purpose: Short helper function
;   Object (A0): +$2A, +$A8
;
; Entry: A0 = object/entity pointer
; Uses: A0
; Object fields:
;   +$2A: [unknown]
;   +$A8: [unknown]
; Confidence: low
; ============================================================================

fn_8200_045:
        TST.W  $00A8(A0)                        ; $009E5A
        BEQ.S  .loc_000A                        ; $009E5E
        SUBQ.W  #1,$00A8(A0)                    ; $009E60
.loc_000A:
        CMPI.W  #$0002,$002A(A0)                ; $009E64
        DC.W    $670C               ; BEQ.S  $009E78; $009E6A
        RTS                                     ; $009E6C
