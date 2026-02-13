; ============================================================================
; Vint 060 (auto-analyzed)
; ROM Range: $003A3E-$003A4E (16 bytes)
; ============================================================================
; Category: vint
; Purpose: Short helper function
;   Object (A1, A2): +$00, +$0A (param_a)
;
; Entry: A1 = object/entity pointer
; Entry: A2 = object/entity pointer
; Uses: D7, A1, A2
; Object fields:
;   +$00: [unknown]
;   +$0A: param_a
; Confidence: low
; ============================================================================

fn_2200_060:
        LEA     $000A(A1),A1                    ; $003A3E
        DC.W    $51CF,$FFB0         ; DBRA    D7,$0039F4; $003A42
        MOVE.W  #$0000,$0000(A2)                ; $003A46
        RTS                                     ; $003A4C
