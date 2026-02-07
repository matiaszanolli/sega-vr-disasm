; ============================================================================
; Fm 052 (auto-analyzed)
; ROM Range: $0313CA-$031406 (60 bytes)
; ============================================================================
; Category: sound
; Purpose: Object (A5): +$0A (param_a), +$14 (effect_duration), +$18, +$19, +$1A (direction), +$1B
;
; Entry: A5 = object/entity pointer
; Uses: D0, D2, A0, A4, A5
; Object fields:
;   +$0A: param_a
;   +$14: effect_duration
;   +$18: [unknown]
;   +$19: [unknown]
;   +$1A: direction
;   +$1B: [unknown]
;   +$1C: [unknown]
; Confidence: low
; ============================================================================

fn_30200_052:
        MOVE.W  ($343C).W,D0                    ; $0313CA
        ADDQ.W  #8,(A0)+                        ; $0313CE
        ADDQ.W  #2,(A4)+                        ; $0313D0
        DC.W    $6068               ; BRA.S  $03143C; $0313D2
        DC.W    $646C               ; BCC.S  $031442; $0313D4
        MOVEQ   #$78,D0                         ; $0313D6
        MOVEQ   #$7C,D2                         ; $0313D8
        DC.W    $8088                           ; $0313DA
        DC.W    $848C                           ; $0313DC
        DC.W    $4048                           ; $0313DE
        DC.W    $444C                           ; $0313E0
        BSET    #7,$000A(A5)                    ; $0313E2
        MOVE.L  A4,$0014(A5)                    ; $0313E8
        MOVE.B  (A4)+,$0018(A5)                 ; $0313EC
        MOVE.B  (A4)+,$0019(A5)                 ; $0313F0
        MOVE.B  (A4)+,$001A(A5)                 ; $0313F4
        MOVE.B  (A4)+,D0                        ; $0313F8
        LSR.B  #1,D0                            ; $0313FA
        MOVE.B  D0,$001B(A5)                    ; $0313FC
        CLR.W  $001C(A5)                        ; $031400
        RTS                                     ; $031404
