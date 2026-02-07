; ============================================================================
; Vint 064 (auto-analyzed)
; ROM Range: $003C1A-$003C2A (16 bytes)
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

fn_2200_064:
        LEA     $000A(A1),A1                    ; $003C1A
        DC.W    $51CF,$FFAC         ; DBRA    D7,$003BCC; $003C1E
        MOVE.W  #$0000,$0000(A2)                ; $003C22
        RTS                                     ; $003C28
