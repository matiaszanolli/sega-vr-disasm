; ============================================================================
; Fm Dispatch 007 (auto-analyzed)
; ROM Range: $0303CC-$0303E8 (28 bytes)
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

fn_30200_007:
        DC.W    $ADA9                           ; $0303CC
        DC.W    $ACA8                           ; $0303CE
        DC.W    $AEAA                           ; $0303D0
        DC.W    $A6A2                           ; $0303D2
        BTST    #1,(A5)                         ; $0303D4
        BNE.S  .loc_001A                        ; $0303D8
        MOVEQ   #$00,D0                         ; $0303DA
        MOVE.B  $0028(A5),D0                    ; $0303DC
        LSL.W  #1,D0                            ; $0303E0
        JMP     $0303E6(PC,D0.W)                ; $0303E2
.loc_001A:
        RTS                                     ; $0303E6
