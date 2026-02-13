; ============================================================================
; Vint 068 (auto-analyzed)
; ROM Range: $003D5A-$003D9A (64 bytes)
; ============================================================================
; Category: vint
; Purpose: Object (A1): +$04 (speed_index/velocity), +$08
;
; Entry: A1 = object/entity pointer
; Uses: A1
; Object fields:
;   +$04: speed_index/velocity
;   +$08: [unknown]
; Confidence: low
; ============================================================================

fn_2200_068:
        LEA     $00FF6980,A1                    ; $003D5A
        MOVE.B  #$09,(A1)                       ; $003D60
        MOVE.L  #$040268F8,$0004(A1)            ; $003D64
        MOVE.L  #$222F0FBE,$0008(A1)            ; $003D6C
        LEA     $00FF69C0,A1                    ; $003D74
        MOVE.B  #$09,(A1)                       ; $003D7A
        LEA     $00FF6990,A1                    ; $003D7E
        MOVE.B  #$09,(A1)                       ; $003D84
        MOVE.L  #$0402C8EC,$0004(A1)            ; $003D88
        MOVE.L  #$222F22A2,$0008(A1)            ; $003D90
        RTS                                     ; $003D98
