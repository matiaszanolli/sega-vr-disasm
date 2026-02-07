; ============================================================================
; Vint Heading 037 (auto-analyzed)
; ROM Range: $002EEE-$002F04 (22 bytes)
; ============================================================================
; Category: game
; Purpose: Short helper function
;   Object (A1): +$14 (effect_duration), +$28, +$3C (heading_mirror), +$50
;
; Entry: A1 = object/entity pointer
; Uses: D0, A1
; Object fields:
;   +$14: effect_duration
;   +$28: [unknown]
;   +$3C: heading_mirror
;   +$50: [unknown]
; Confidence: low
; ============================================================================

fn_2200_037:
        MOVEQ   #$01,D0                         ; $002EEE
        MOVE.W  D0,(A1)                         ; $002EF0
        MOVE.W  D0,$0014(A1)                    ; $002EF2
        MOVE.W  D0,$0028(A1)                    ; $002EF6
        MOVE.W  D0,$003C(A1)                    ; $002EFA
        MOVE.W  D0,$0050(A1)                    ; $002EFE
        RTS                                     ; $002F02
