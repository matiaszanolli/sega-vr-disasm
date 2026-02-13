; ============================================================================
; Fm 063 (auto-analyzed)
; ROM Range: $031666-$031680 (26 bytes)
; ============================================================================
; Category: sound
; Purpose: Short helper function
;   Object (A6): +$38, +$3A, +$3B
;
; Entry: A6 = object/entity pointer
; Uses: A4, A6
; Object fields:
;   +$38: [unknown]
;   +$3A: [unknown]
;   +$3B: [unknown]
; Confidence: low
; ============================================================================

fn_30200_063:
        CMPI.B  #$02,$0038(A6)                  ; $031666
        BEQ.W  .loc_0018                        ; $03166C
        MOVE.B  #$01,$0038(A6)                  ; $031670
        MOVE.B  (A4)+,$003A(A6)                 ; $031676
        MOVE.B  (A4)+,$003B(A6)                 ; $03167A
.loc_0018:
        RTS                                     ; $03167E
