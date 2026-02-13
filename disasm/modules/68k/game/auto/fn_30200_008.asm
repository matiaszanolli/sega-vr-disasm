; ============================================================================
; Fm Dispatch 008 (auto-analyzed)
; ROM Range: $0303E8-$030402 (26 bytes)
; ============================================================================
; Category: sound
; Purpose: State dispatcher using jump table
;   Object (A5): +$28
;
; Entry: A5 = object/entity pointer
; Uses: D0, A5
; Object fields:
;   +$28: [unknown]
; Confidence: low
; ============================================================================

fn_30200_008:
        DC.W    $6028               ; BRA.S  $030412; $0303E8
        DC.W    $601C               ; BRA.S  $030408; $0303EA
        DC.W    $601A               ; BRA.S  $030408; $0303EC
        BTST    #1,(A5)                         ; $0303EE
        BNE.S  .loc_0018                        ; $0303F2
        MOVEQ   #$00,D0                         ; $0303F4
        MOVE.B  $0028(A5),D0                    ; $0303F6
        LSL.W  #1,D0                            ; $0303FA
        JMP     $030400(PC,D0.W)                ; $0303FC
.loc_0018:
        RTS                                     ; $030400
