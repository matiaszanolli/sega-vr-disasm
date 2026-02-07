; ============================================================================
; Vint 058 (auto-analyzed)
; ROM Range: $00397C-$0039EC (112 bytes)
; ============================================================================
; Category: vint
; Purpose: Object (A2): +$00, +$02 (flags/type), +$06 (speed), +$0A (param_a), +$0E (param_e), +$10
;
; Entry: A2 = object/entity pointer
; Uses: D0, D1, D3, A1, A2
; Object fields:
;   +$00: [unknown]
;   +$02: flags/type
;   +$06: speed
;   +$0A: param_a
;   +$0E: param_e
;   +$10: [unknown]
;   +$14: effect_duration
;   +$20: [unknown]
; Confidence: low
; ============================================================================

fn_2200_058:
        LEA     $00883A80,A1                    ; $00397C
        LEA     $00FF65D8,A2                    ; $003982
        ADDI.W  #$001E,(-14110).W               ; $003988
        MOVE.W  #$0C80,D1                       ; $00398E
        MOVE.W  #$1400,D3                       ; $003992
        MOVE.W  #$0000,$0000(A2)                ; $003996
        MOVE.W  #$0000,$0014(A2)                ; $00399C
        MOVE.W  (-14110).W,D0                   ; $0039A2
        ANDI.W  #$1FFF,D0                       ; $0039A6
        MOVE.W  D0,$0020(A2)                    ; $0039AA
        DC.W    $4EBA,$FF10         ; JSR     $0038C0(PC); $0039AE
        LEA     $00FF65C4,A2                    ; $0039B2
        MOVE.W  #$0000,$0000(A2)                ; $0039B8
        TST.W  $00FF65D8                        ; $0039BE
        BEQ.S  .loc_006E                        ; $0039C4
        LEA     $00883A76,A1                    ; $0039C6
        MOVE.W  #$0001,$0000(A2)                ; $0039CC
        MOVE.L  (A1)+,$0002(A2)                 ; $0039D2
        MOVE.W  (A1)+,$0006(A2)                 ; $0039D6
        MOVE.W  (A1)+,$000A(A2)                 ; $0039DA
        MOVE.W  (A1),$000E(A2)                  ; $0039DE
        MOVE.L  #$222A218E,$0010(A2)            ; $0039E2
.loc_006E:
        RTS                                     ; $0039EA
