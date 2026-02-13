; ============================================================================
; PSG Set Envelope — route by channel type and set envelope number
; ROM Range: $031406-$031418 (18 bytes)
; ============================================================================
; Reads byte from sequence. If FM channel (positive A5+$01): branches to
; set_envelope_number ($0314F6). If PSG: stores byte to A5+$0A (envelope number),
; reads next sequence byte (consumed but not used here).
;
; Entry: A5 = channel structure pointer, A4 = sequence pointer
; Uses: D0, A4
; Confidence: medium
; ============================================================================

psg_set_envelope:
        MOVE.B  (A4)+,D0                        ; $031406
        TST.B  $0001(A5)                        ; $031408
        DC.W    $6A00,$00E8         ; BPL.W  $0314F6; $03140C
        MOVE.B  D0,$000A(A5)                    ; $031410
        MOVE.B  (A4)+,D0                        ; $031414
        RTS                                     ; $031416
