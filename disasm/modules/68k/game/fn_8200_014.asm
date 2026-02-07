; ============================================================================
; State 014 (auto-analyzed)
; ROM Range: $0084F4-$00850A (22 bytes)
; ============================================================================
; Category: game
; Purpose: Short helper function
;   Object (A2, A3): +$00
;
; Entry: A2 = object/entity pointer
; Entry: A3 = object/entity pointer
; Uses: D0, D1, D4, D5, A2, A3
; Object fields:
;   +$00: [unknown]
; Confidence: low
; ============================================================================

fn_8200_014:
        SUBQ.W  #1,D1                           ; $0084F4
        LSL.W  #2,D1                            ; $0084F6
        MOVE.L  $00(A2,D1.W),D5                 ; $0084F8
        MOVE.L  $00(A3,D1.W),D4                 ; $0084FC
        DC.W    $6708               ; BEQ.S  $00850A; $008500
        CMP.L  D4,D5                            ; $008502
        DC.W    $6D04               ; BLT.S  $00850A; $008504
        MOVEQ   #$00,D0                         ; $008506
        RTS                                     ; $008508
