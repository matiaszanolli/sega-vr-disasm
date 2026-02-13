; ============================================================================
; sequence_fade_rate_set — Sequence Fade Rate Set
; ROM Range: $031666-$031680 (26 bytes)
; Sets fade rate parameters from sequence data. If channel is not already
; in fade state $02, writes state $01 to A6+$38 and reads two bytes from
; sequence pointer (A4)+ into A6+$3A (fade target) and A6+$3B (fade rate).
;
; Entry: A4 = sequence data pointer, A6 = channel struct pointer
; Uses: A4, A6
; Channel fields:
;   +$38: fade state (0=idle, 1=fade active, 2=fade complete)
;   +$3A: fade target level
;   +$3B: fade rate
; Confidence: high
; ============================================================================

sequence_fade_rate_set:
        CMPI.B  #$02,$0038(A6)                  ; $031666
        BEQ.W  .loc_0018                        ; $03166C
        MOVE.B  #$01,$0038(A6)                  ; $031670
        MOVE.B  (A4)+,$003A(A6)                 ; $031676
        MOVE.B  (A4)+,$003B(A6)                 ; $03167A
.loc_0018:
        RTS                                     ; $03167E
