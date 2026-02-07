; ============================================================================
; Display Dispatch 004 (auto-analyzed)
; ROM Range: $0044E8-$004538 (80 bytes)
; ============================================================================
; Category: display
; Purpose: State dispatcher using jump table
;   RAM: $C048 (camera_state), $C07C (input_state)
;   Object (A2, A6): +$88
;
; Entry: A2 = object/entity pointer
; Entry: A6 = object/entity pointer
; Uses: D0, D2, A1, A2, A4, A6
; RAM:
;   $C048: camera_state
;   $C07C: input_state
; Object fields:
;   +$88: [unknown]
; Confidence: medium
; ============================================================================

fn_4200_004:
        MOVE.W  #$0001,(-16312).W               ; $0044E8
        MOVE.W  (-16260).W,D0                   ; $0044EE
        MOVEA.L $0044F8(PC,D0.W),A1             ; $0044F2
        JMP     (A1)                            ; $0044F6
        DC.W    $0088                           ; $0044F8
        DC.W    $4536                           ; $0044FA
        DC.W    $0088                           ; $0044FC
        DC.W    $4538                           ; $0044FE
        DC.W    $0088                           ; $004500
        DC.W    $4566                           ; $004502
        DC.W    $0088                           ; $004504
        DC.W    $4566                           ; $004506
        DC.W    $0088                           ; $004508
        DC.W    $456C                           ; $00450A
        DC.W    $0088                           ; $00450C
        NOT.B  ($0088).W                        ; $00450E
        DC.W    $464A                           ; $004512
        DC.W    $0088                           ; $004514
        NOT.W  (A4)+                            ; $004516
        DC.W    $0088                           ; $004518
        NOT.L  D2                               ; $00451A
        MOVE.W  (-14146).W,D0                   ; $00451C
        MOVEA.L $004526(PC,D0.W),A1             ; $004520
        JMP     (A1)                            ; $004524
        DC.W    $0088                           ; $004526
        NOT.L  (A6)                             ; $004528
        DC.W    $0088                           ; $00452A
        NOT.L  $0088(A2)                        ; $00452C
        MOVE    $0088(A6),SR                    ; $004530
        DC.W    $471E                           ; $004534
        RTS                                     ; $004536
