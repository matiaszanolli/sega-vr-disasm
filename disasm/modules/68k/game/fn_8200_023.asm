; ============================================================================
; State Dispatch 023 (auto-analyzed)
; ROM Range: $008C40-$008CB0 (112 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;
; Uses: D0, D6
; Confidence: low
; ============================================================================

fn_8200_023:
        MOVEQ   #$00,D0                         ; $008C40
        MOVE.W  D0,(-16198).W                   ; $008C42
        MOVE.B  (-14186).W,D0                   ; $008C46
        MOVE.W  $008C52(PC,D0.W),D0             ; $008C4A
        JMP     $008C52(PC,D0.W)                ; $008C4E
        ORI.B  #$5E,D6                          ; $008C52
        DC.W    $007A                           ; $008C56
        MOVE.W  #$00C0,(-16184).W               ; $008C58
        MOVE.W  #$0100,$00FF60CC                ; $008C5E
        MOVE.W  (-14118).W,(-16210).W           ; $008C66
        MOVEQ   #$00,D0                         ; $008C6C
        MOVE.W  D0,(-16186).W                   ; $008C6E
        MOVE.W  D0,(-16210).W                   ; $008C72
        MOVE.W  D0,(-16208).W                   ; $008C76
        MOVE.W  D0,(-16206).W                   ; $008C7A
        MOVE.W  D0,(-16250).W                   ; $008C7E
        MOVE.W  D0,(-14196).W                   ; $008C82
        MOVE.W  D0,(-14194).W                   ; $008C86
        MOVE.W  D0,(-14192).W                   ; $008C8A
        MOVE.W  D0,(-14090).W                   ; $008C8E
        MOVE.W  (-14116).W,D0                   ; $008C92
        MOVE.W  D0,(-16300).W                   ; $008C96
        MOVE.W  D0,(-14190).W                   ; $008C9A
        MOVE.W  (-14114).W,D0                   ; $008C9E
        MOVE.W  D0,(-16298).W                   ; $008CA2
        MOVE.W  D0,(-14188).W                   ; $008CA6
        ADDQ.B  #2,(-14186).W                   ; $008CAA
        RTS                                     ; $008CAE
