; ============================================================================
; State Ai Steering Calc 028 (auto-analyzed)
; ROM Range: $008EB6-$008ED6 (32 bytes)
; ============================================================================
; Category: game
; Purpose: Short helper function
;   Calls: ai_steering_calc
;   Object (A0): +$30 (x_position), +$34 (y_position)
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, D2, D3, A0
; Calls:
;   $00A7A0: ai_steering_calc
; Object fields:
;   +$30: x_position
;   +$34: y_position
; Confidence: medium
; ============================================================================

fn_8200_028:
        MOVE.W  (-16198).W,D0                   ; $008EB6
        MOVE.W  (-16194).W,D1                   ; $008EBA
        MOVE.W  $0030(A0),D2                    ; $008EBE
        MOVE.W  $0034(A0),D3                    ; $008EC2
        DC.W    $4EBA,$18D8         ; JSR     $00A7A0(PC); $008EC6
        SUBI.W  #$4000,D0                       ; $008ECA
        NEG.W  D0                               ; $008ECE
        MOVE.W  D0,(-16190).W                   ; $008ED0
        RTS                                     ; $008ED4
