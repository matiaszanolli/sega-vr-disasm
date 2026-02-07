; ============================================================================
; Vint Heading 036 (auto-analyzed)
; ROM Range: $002EC6-$002EEE (40 bytes)
; ============================================================================
; Category: game
; Purpose: Short helper function
;   Object (A0, A1): +$14 (effect_duration), +$28, +$3C (heading_mirror), +$50, +$64, +$E5
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, A0, A1
; Object fields:
;   +$14: effect_duration
;   +$28: [unknown]
;   +$3C: heading_mirror
;   +$50: [unknown]
;   +$64: [unknown]
;   +$E5: [unknown]
; Confidence: low
; ============================================================================

fn_2200_036:
        TST.B  (-15588).W                       ; $002EC6
        DC.W    $6722               ; BEQ.S  $002EEE; $002ECA
        BTST    #3,$00E5(A0)                    ; $002ECC
        DC.W    $671A               ; BEQ.S  $002EEE; $002ED2
        MOVEQ   #$00,D0                         ; $002ED4
        MOVE.W  D0,(A1)                         ; $002ED6
        MOVE.W  D0,$0014(A1)                    ; $002ED8
        MOVE.W  D0,$0028(A1)                    ; $002EDC
        MOVE.W  D0,$003C(A1)                    ; $002EE0
        MOVE.W  D0,$0050(A1)                    ; $002EE4
        MOVE.W  D0,$0064(A1)                    ; $002EE8
        RTS                                     ; $002EEC
