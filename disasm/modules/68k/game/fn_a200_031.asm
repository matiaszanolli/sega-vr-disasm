; ============================================================================
; Ai Heading 031 (auto-analyzed)
; ROM Range: $00B990-$00BA18 (136 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A1, A2): +$00, +$10, +$14 (effect_duration), +$16 (calc_speed), +$18, +$1A (direction)
;
; Entry: A1 = object/entity pointer
; Entry: A2 = object/entity pointer
; Uses: D0, A1, A2
; Object fields:
;   +$00: [unknown]
;   +$10: [unknown]
;   +$14: effect_duration
;   +$16: calc_speed
;   +$18: [unknown]
;   +$1A: direction
;   +$24: [unknown]
;   +$28: [unknown]
; Confidence: low
; ============================================================================

fn_a200_031:
        MOVEA.L (-14524).W,A1                   ; $00B990
        ADD.W  (-14148).W,D0                    ; $00B994
        MOVEA.L $00(A1,D0.W),A1                 ; $00B998
        MOVEQ   #$00,D0                         ; $00B99C
        MOVE.B  (-15613).W,D0                   ; $00B99E
        DC.W    $D040                           ; $00B9A2
        DC.W    $D040                           ; $00B9A4
        MOVE.L  $00(A1,D0.W),D0                 ; $00B9A6
        MOVE.W  D0,(-16298).W                   ; $00B9AA
        SWAP    D0                              ; $00B9AE
        MOVE.W  D0,(-16300).W                   ; $00B9B0
        MOVE.L  (-14576).W,$0010(A2)            ; $00B9B4
        MOVE.L  (-14572).W,$0024(A2)            ; $00B9BA
        MOVE.L  (-14568).W,$0038(A2)            ; $00B9C0
        MOVE.L  (-14564).W,$004C(A2)            ; $00B9C6
        MOVE.L  (-14560).W,$0060(A2)            ; $00B9CC
        MOVEA.L (-14540).W,A1                   ; $00B9D2
        MOVE.W  (A1)+,$0016(A2)                 ; $00B9D6
        MOVE.W  (A1)+,$0018(A2)                 ; $00B9DA
        MOVE.W  (A1)+,$001A(A2)                 ; $00B9DE
        MOVE.W  (A1)+,$002A(A2)                 ; $00B9E2
        MOVE.W  (A1)+,$002C(A2)                 ; $00B9E6
        MOVE.W  (A1)+,$002E(A2)                 ; $00B9EA
        MOVE.W  (A1)+,$003E(A2)                 ; $00B9EE
        MOVE.W  (A1)+,$0040(A2)                 ; $00B9F2
        MOVE.W  (A1),$0042(A2)                  ; $00B9F6
        MOVE.W  #$0000,(-16308).W               ; $00B9FA
        MOVEQ   #$01,D0                         ; $00BA00
        MOVE.W  D0,$0000(A2)                    ; $00BA02
        MOVE.W  D0,$0014(A2)                    ; $00BA06
        MOVE.W  D0,$0028(A2)                    ; $00BA0A
        MOVE.W  D0,$0050(A2)                    ; $00BA0E
        MOVE.W  D0,$003C(A2)                    ; $00BA12
        RTS                                     ; $00BA16
