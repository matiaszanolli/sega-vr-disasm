; ============================================================================
; Objs 044 (auto-analyzed)
; ROM Range: $003204-$003250 (76 bytes)
; ============================================================================
; Category: object
; Purpose: RAM: $6950 (obj_flags)
;   Object (A0, A1): +$00, +$2C
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, A0, A1
; RAM:
;   $6950: obj_flags
; Object fields:
;   +$00: [unknown]
;   +$2C: [unknown]
; Confidence: medium
; ============================================================================

fn_2200_044:
        SUBQ.B  #1,(-15608).W                   ; $003204
        BNE.S  .loc_0020                        ; $003208
        MOVE.W  (-16242).W,D0                   ; $00320A
        CMP.W  (-16262).W,D0                    ; $00320E
        BEQ.S  .loc_0020                        ; $003212
        MOVE.W  $002C(A0),D0                    ; $003214
        LEA     $008989EE,A1                    ; $003218
        MOVE.B  $00(A1,D0.W),(-14171).W         ; $00321E
.loc_0020:
        MOVE.B  #$04,(-15611).W                 ; $003224
        TST.W  (-16306).W                       ; $00322A
        DC.W    $6720               ; BEQ.S  $003250; $00322E
        MOVEA.L (-15784).W,A1                   ; $003230
        MOVE.B  #$00,$0000(A1)                  ; $003234
        MOVE.B  #$00,$00FF6940                  ; $00323A
        MOVE.B  #$00,$00FF6950                  ; $003242
        ADDQ.B  #4,(-15611).W                   ; $00324A
        RTS                                     ; $00324E
