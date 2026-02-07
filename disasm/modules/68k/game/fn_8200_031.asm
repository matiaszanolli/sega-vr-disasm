; ============================================================================
; State Dispatch 031 (auto-analyzed)
; ROM Range: $008F4E-$008F88 (58 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   Object (A0, A1): +$00, +$78
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, D1, D6, D7, A0, A1, A4
; Object fields:
;   +$00: [unknown]
;   +$78: [unknown]
; Confidence: low
; ============================================================================

fn_8200_031:
        ADDI.W  #$4000,D0                       ; $008F4E
        MOVEQ   #$00,D1                         ; $008F52
        MOVE.W  D0,D1                           ; $008F54
        LSR.W  #6,D0                            ; $008F56
        LSL.L  #2,D1                            ; $008F58
        SWAP    D1                              ; $008F5A
        DC.W    $D241                           ; $008F5C
        DC.W    $D241                           ; $008F5E
        MOVEA.L $008F66(PC,D1.W),A1             ; $008F60
        JMP     (A1)                            ; $008F64
        DC.W    $0088                           ; $008F66
        DC.W    $8F7A                           ; $008F68
        DC.W    $0088                           ; $008F6A
        DC.W    $8F88                           ; $008F6C
        DC.W    $0088                           ; $008F6E
        OR.L   D7,(A4)+                         ; $008F70
        DC.W    $0088                           ; $008F72
        OR.L   D7,-$78(A0,D0.W)                 ; $008F74
        DIVS    D6,D7                           ; $008F78
        LEA     $00930000,A1                    ; $008F7A
        DC.W    $D040                           ; $008F80
        MOVE.W  $00(A1,D0.W),D0                 ; $008F82
        RTS                                     ; $008F86
