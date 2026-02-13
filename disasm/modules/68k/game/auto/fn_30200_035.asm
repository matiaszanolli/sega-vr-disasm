; ============================================================================
; PSG Vibrato Check — conditional PSG write based on vibrato state
; ROM Range: $030F82-$030F90 (14 bytes)
; ============================================================================
; Checks vibrato enable (A5+$13). If zero, branches to PSG volume write
; at $030F72. If enabled, checks vibrato timer (A5+$12): if nonzero,
; also branches to write. Otherwise returns without update.
;
; Entry: A5 = PSG channel structure pointer
; Uses: A5
; Confidence: medium
; ============================================================================

fn_30200_035:
        TST.B  $0013(A5)                        ; $030F82
        DC.W    $67EA               ; BEQ.S  $030F72; $030F86
        TST.B  $0012(A5)                        ; $030F88
        DC.W    $66E4               ; BNE.S  $030F72; $030F8C
        RTS                                     ; $030F8E
