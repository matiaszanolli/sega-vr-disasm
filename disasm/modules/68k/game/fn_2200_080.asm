; ============================================================================
; Input 080 (auto-analyzed)
; ROM Range: $00413A-$004168 (46 bytes)
; ============================================================================
; Category: input
; Purpose: RAM: $C07C (input_state), $C8AA (scene_state)
;   Object (A2): +$04 (speed_index/velocity), +$06 (speed), +$08
;
; Entry: A2 = object/entity pointer
; Uses: D0, A2
; RAM:
;   $C07C: input_state
;   $C8AA: scene_state
; Object fields:
;   +$04: speed_index/velocity
;   +$06: speed
;   +$08: [unknown]
; Confidence: medium
; ============================================================================

fn_2200_080:
        LEA     $00FF6754,A2                    ; $00413A
        ADDQ.W  #8,(-15780).W                   ; $004140
        MOVE.W  (-15780).W,D0                   ; $004144
        MOVE.W  D0,$0006(A2)                    ; $004148
        ADDQ.W  #2,$0004(A2)                    ; $00414C
        ADDI.W  #$01C0,$0008(A2)                ; $004150
        CMPI.W  #$0100,D0                       ; $004156
        BNE.S  .loc_002C                        ; $00415A
        ADDQ.W  #4,(-16260).W                   ; $00415C
        MOVE.W  #$0000,(-14166).W               ; $004160
.loc_002C:
        RTS                                     ; $004166
