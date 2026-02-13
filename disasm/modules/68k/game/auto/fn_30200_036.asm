; ============================================================================
; PSG Envelope Command Handler — rewind/mute for volume envelope
; ROM Range: $030F90-$030FA2 (18 bytes)
; ============================================================================
; Two entry points for special envelope command bytes:
;   $030F90: Rewind 2 positions (SUBQ.B #2 A5+$0C), set mute flag
;     (BSET bit 1), branch to fm_set_volume ($030FB2) for PSG silence.
;   $030F9C: Rewind 2 positions only, return to continue reading.
;
; Entry: A5 = PSG channel structure pointer
; Uses: A5
; Confidence: high
; ============================================================================

fn_30200_036:
        SUBQ.B  #2,$000C(A5)                    ; $030F90
        BSET    #1,(A5)                         ; $030F94
        DC.W    $6000,$0018         ; BRA.W  $030FB2; $030F98
        SUBQ.B  #2,$000C(A5)                    ; $030F9C
        RTS                                     ; $030FA0
