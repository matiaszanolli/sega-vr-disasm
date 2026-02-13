; ============================================================================
; Set Channel Tempo — read tempo byte from sequence
; ROM Range: $03154E-$031554 (6 bytes)
; ============================================================================
; Reads one byte from sequence pointer (A4), stores to channel tempo
; divider at A5+$02. Controls playback speed of the channel.
;
; Entry: A5 = channel structure pointer, A4 = sequence pointer
; Uses: A4
; Confidence: high
; ============================================================================

fn_30200_059:
        MOVE.B  (A4)+,$0002(A5)                 ; $03154E
        RTS                                     ; $031552
