; ============================================================================
; Obj Position 019 (auto-analyzed)
; ROM Range: $006D50-$006D6E (30 bytes)
; ============================================================================
; Category: game
; Purpose: Short helper function
;   Object (A0, A2): +$00, +$02 (flags/type), +$1C, +$30 (x_position), +$34 (y_position)
;
; Entry: A0 = object/entity pointer
; Entry: A2 = object/entity pointer
; Uses: D0, A0, A2
; Object fields:
;   +$00: [unknown]
;   +$02: flags/type
;   +$1C: [unknown]
;   +$30: x_position
;   +$34: y_position
; Confidence: medium
; ============================================================================

fn_6200_019:
        ADDQ.W  #1,$001C(A0)                    ; $006D50
        MOVE.W  $001C(A0),D0                    ; $006D54
        MOVEA.L (-14592).W,A2                   ; $006D58
        DC.W    $D040                           ; $006D5C
        DC.W    $D040                           ; $006D5E
        MOVE.W  $00(A2,D0.W),$0030(A0)          ; $006D60
        MOVE.W  $02(A2,D0.W),$0034(A0)          ; $006D66
        RTS                                     ; $006D6C
