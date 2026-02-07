; ============================================================================
; Vint Position 059 (auto-analyzed)
; ROM Range: $0039EC-$003A3E (82 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A0, A1, A2): +$00, +$02 (flags/type), +$04 (speed_index/velocity), +$06 (speed), +$0A (param_a), +$0E (param_e)
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Entry: A2 = object/entity pointer
; Uses: D0, D1, D2, D3, D4, D5, A0, A1
; Object fields:
;   +$00: [unknown]
;   +$02: flags/type
;   +$04: speed_index/velocity
;   +$06: speed
;   +$0A: param_a
;   +$0E: param_e
;   +$10: [unknown]
;   +$30: x_position
; Confidence: low
; ============================================================================

fn_2200_059:
        MOVE.W  #$0C80,D1                       ; $0039EC
        MOVE.W  #$0300,D3                       ; $0039F0
        MOVE.W  $0030(A0),D2                    ; $0039F4
        MOVE.W  $0034(A0),D4                    ; $0039F8
        MOVE.W  $0032(A0),D5                    ; $0039FC
        SUB.W  (A1),D2                          ; $003A00
        BPL.S  .loc_001A                        ; $003A02
        NEG.W  D2                               ; $003A04
.loc_001A:
        CMP.W  D1,D2                            ; $003A06
        DC.W    $6E34               ; BGT.S  $003A3E; $003A08
        SUB.W  $0002(A1),D5                     ; $003A0A
        BPL.S  .loc_0026                        ; $003A0E
        NEG.W  D5                               ; $003A10
.loc_0026:
        CMP.W  D3,D5                            ; $003A12
        DC.W    $6E28               ; BGT.S  $003A3E; $003A14
        SUB.W  $0004(A1),D4                     ; $003A16
        BPL.S  .loc_0032                        ; $003A1A
        NEG.W  D4                               ; $003A1C
.loc_0032:
        CMP.W  D1,D4                            ; $003A1E
        DC.W    $6E1C               ; BGT.S  $003A3E; $003A20
        MOVE.W  #$0001,$0000(A2)                ; $003A22
        MOVE.L  (A1)+,$0002(A2)                 ; $003A28
        MOVE.W  (A1)+,$0006(A2)                 ; $003A2C
        MOVE.W  (A1)+,$000A(A2)                 ; $003A30
        MOVE.W  (A1),$000E(A2)                  ; $003A34
        MOVE.L  D0,$0010(A2)                    ; $003A38
        RTS                                     ; $003A3C
