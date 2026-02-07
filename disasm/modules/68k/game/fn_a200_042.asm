; ============================================================================
; Ai Dispatch 042 (auto-analyzed)
; ROM Range: $00BEC4-$00BEFC (56 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   RAM: $C8A0 (race_state)
;   Object (A1): +$00, +$08
;
; Entry: A1 = object/entity pointer
; Uses: D0, A1
; RAM:
;   $C8A0: race_state
; Object fields:
;   +$00: [unknown]
;   +$08: [unknown]
; Confidence: medium
; ============================================================================

fn_a200_042:
        ADDQ.W  #4,(-24342).W                   ; $00BEC4
        CLR.W  (-24340).W                       ; $00BEC8
        LEA     $00FF6800,A1                    ; $00BECC
        MOVE.B  #$01,$0000(A1)                  ; $00BED2
        LEA     $00FF6810,A1                    ; $00BED8
        MOVE.B  #$01,$0000(A1)                  ; $00BEDE
        LEA     $00FF6820,A1                    ; $00BEE4
        MOVE.B  #$01,$0000(A1)                  ; $00BEEA
        MOVE.W  (-14176).W,D0                   ; $00BEF0
        MOVE.L  $00BEFC(PC,D0.W),$0008(A1)      ; $00BEF4
        RTS                                     ; $00BEFA
