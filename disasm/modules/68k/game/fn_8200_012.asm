; ============================================================================
; State 012 (auto-analyzed)
; ROM Range: $0083C6-$0083E4 (30 bytes)
; ============================================================================
; Category: game
; Purpose: Short helper function
;   Object (A0): +$02 (flags/type)
;
; Entry: A0 = object/entity pointer
; Uses: D0, A0, A1, A2
; Object fields:
;   +$02: flags/type
; Confidence: low
; ============================================================================

fn_8200_012:
        MOVEQ   #$00,D0                         ; $0083C6
        MOVE.B  (-22048).W,D0                   ; $0083C8
        ADDQ.B  #1,(-22048).W                   ; $0083CC
        LEA     (-22045).W,A1                   ; $0083D0
        LEA     (-22528).W,A2                   ; $0083D4
        DC.W    $601C               ; BRA.S  $0083F6; $0083D8
        BTST    #6,$0002(A0)                    ; $0083DA
        DC.W    $6602               ; BNE.S  $0083E4; $0083E0
        RTS                                     ; $0083E2
