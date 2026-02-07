; ============================================================================
; Obj Movement 060 (auto-analyzed)
; ROM Range: $007EB2-$007EFC (74 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A0, A1): +$00, +$02 (flags/type), +$1E, +$30 (x_position), +$34 (y_position), +$3C (heading_mirror)
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, D1, D2, D3, A0, A1
; Object fields:
;   +$00: [unknown]
;   +$02: flags/type
;   +$1E: [unknown]
;   +$30: x_position
;   +$34: y_position
;   +$3C: heading_mirror
;   +$4E: [unknown]
;   +$50: [unknown]
; Confidence: medium
; ============================================================================

fn_6200_060:
        MOVE.W  (-16240).W,(-16262).W           ; $007EB2
        MOVE.W  D1,(-16340).W                   ; $007EB8
        DC.W    $D040                           ; $007EBC
        MOVE.W  D0,D2                           ; $007EBE
        DC.W    $D442                           ; $007EC0
        MOVEA.L (-14592).W,A1                   ; $007EC2
        MOVE.W  $00(A1,D2.W),D3                 ; $007EC6
        SUB.W  $0030(A0),D3                     ; $007ECA
        EXT.L   D3                              ; $007ECE
        DIVS    D1,D3                           ; $007ED0
        ADDQ.W  #1,D3                           ; $007ED2
        MOVE.W  D3,$004E(A0)                    ; $007ED4
        MOVE.W  $02(A1,D2.W),D3                 ; $007ED8
        SUB.W  $0034(A0),D3                     ; $007EDC
        EXT.L   D3                              ; $007EE0
        DIVS    D1,D3                           ; $007EE2
        ADDQ.W  #1,D3                           ; $007EE4
        MOVE.W  D3,$0050(A0)                    ; $007EE6
        MOVE.W  $001E(A0),D0                    ; $007EEA
        SUB.W  $003C(A0),D0                     ; $007EEE
        EXT.L   D0                              ; $007EF2
        DIVS    D1,D0                           ; $007EF4
        MOVE.W  D0,$0052(A0)                    ; $007EF6
        RTS                                     ; $007EFA
