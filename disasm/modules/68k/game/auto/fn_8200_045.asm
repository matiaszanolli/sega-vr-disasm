; ============================================================================
; fn_8200_045 — Timer Decrement and Rank Check Guard
; ROM Range: $009E5A-$009E6E (20 bytes)
; Decrements timer +$A8 if nonzero. Then checks if entity rank +$2A
; equals 2; if so, falls through past RTS to continue processing.
; Otherwise returns. Guards subsequent code for 2nd-place entities.
;
; Entry: A0 = entity pointer
; Uses: A0
; Object fields: +$2A rank, +$A8 countdown timer
; Confidence: high
; ============================================================================

fn_8200_045:
        TST.W  $00A8(A0)                        ; $009E5A
        BEQ.S  .loc_000A                        ; $009E5E
        SUBQ.W  #1,$00A8(A0)                    ; $009E60
.loc_000A:
        CMPI.W  #$0002,$002A(A0)                ; $009E64
        DC.W    $670C               ; BEQ.S  $009E78; $009E6A
        RTS                                     ; $009E6C
