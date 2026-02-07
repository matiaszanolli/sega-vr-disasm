; ============================================================================
; State Dispatch 024 (auto-analyzed)
; ROM Range: $008CCE-$008D06 (56 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   Object (A2): +$46 (display_scale)
;
; Entry: A2 = object/entity pointer
; Uses: D0, D4, A2, A4, A6
; Object fields:
;   +$46: display_scale
; Confidence: low
; ============================================================================

fn_8200_024:
        MOVE.B  (-14186).W,D0                   ; $008CCE
        MOVE.W  $008CE0(PC,D0.W),D0             ; $008CD2
        JSR     $008CE0(PC,D0.W)                ; $008CD6
        JMP     $00888DC0                       ; $008CDA
        DC.W    $0008                           ; $008CE0
        ORI.B  #$32,-(A6)                       ; $008CE2
        ORI.W  #$31F8,-$46(A2,A4.W)             ; $008CE6
        MULU    ($31F8).W,D4                    ; $008CEC
        AND.L  #$C89231F8,D0                    ; $008CF0
        DC.W    $C0BE                           ; $008CF6
        AND.L  (A4),D4                          ; $008CF8
        MOVE.B  #$05,(-14090).W                 ; $008CFA
        ADDQ.B  #2,(-14186).W                   ; $008D00
        RTS                                     ; $008D04
