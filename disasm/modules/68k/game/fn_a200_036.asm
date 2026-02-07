; ============================================================================
; Ai Menu Substate 036 (auto-analyzed)
; ROM Range: $00BCDA-$00BD00 (38 bytes)
; ============================================================================
; Category: game
; Purpose: Short helper function
;   RAM: $C8AA (scene_state), $C084 (menu_substate)
;   Object (A0): +$02 (flags/type)
;
; Entry: A0 = object/entity pointer
; Uses: A0, A1
; RAM:
;   $C084: menu_substate
;   $C8AA: scene_state
; Object fields:
;   +$02: flags/type
; Confidence: high
; ============================================================================

fn_a200_036:
        CLR.W  (-14166).W                       ; $00BCDA
        CLR.W  (-16252).W                       ; $00BCDE
        LEA     $0002(A0),A1                    ; $00BCE2
        MOVE.W  (A1)+,(-16250).W                ; $00BCE6
        MOVE.W  (A1)+,(-16300).W                ; $00BCEA
        MOVE.W  (A1)+,(-16298).W                ; $00BCEE
        MOVE.W  (A1)+,(-16210).W                ; $00BCF2
        MOVE.W  (A1)+,(-16208).W                ; $00BCF6
        MOVE.W  (A1)+,(-16206).W                ; $00BCFA
        RTS                                     ; $00BCFE
