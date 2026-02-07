; ============================================================================
; Obj Dispatch 009 (auto-analyzed)
; ROM Range: $006B96-$006BCA (52 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;
; Uses: D0, D1, D2, D4, A0
; Confidence: low
; ============================================================================

fn_6200_009:
        ORI.B  #$01,D1                          ; $006B96
        ORI.B  #$02,D2                          ; $006B9A
        ORI.B  #$04,D4                          ; $006B9E
        DC.W    $0008                           ; $006BA2
        DC.W    $0008                           ; $006BA4
        ORI.B  #$10,(A0)                        ; $006BA6
        ORI.B  #$20,-(A0)                       ; $006BAA
        ORI.W  #$0040,D0                        ; $006BAE
        ORI.L  #$00800100,D0                    ; $006BB2
        BTST    D0,D0                           ; $006BB8
        DC.W    $0200                           ; $006BBA
        DC.W    $0200                           ; $006BBC
        MOVE.W  (-16262).W,D0                   ; $006BBE
        MOVE.W  $006BCA(PC,D0.W),(-15764).W     ; $006BC2
        RTS                                     ; $006BC8
