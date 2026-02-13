; ============================================================================
; Ai 015 (auto-analyzed)
; ROM Range: $00B422-$00B43C (26 bytes)
; ============================================================================
; Category: game
; Purpose: Short helper function
;   Object (A3): +$00
;
; Entry: A3 = object/entity pointer
; Uses: D3, A1, A3
; Object fields:
;   +$00: [unknown]
; Confidence: low
; ============================================================================

fn_a200_015:
        LSL.W  #2,D3                            ; $00B422
        LEA     $00FF68D8,A3                    ; $00B424
        LEA     $00(A3,D3.W),A3                 ; $00B42A
        DC.W    $610C               ; BSR.S  $00B43C; $00B42E
        LEA     $00FF6958,A1                    ; $00B430
        MOVE.L  (A3)+,(A1)+                     ; $00B436
        MOVE.L  (A3),(A1)                       ; $00B438
        RTS                                     ; $00B43A
