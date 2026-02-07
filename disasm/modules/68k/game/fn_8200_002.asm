; ============================================================================
; State 002 (auto-analyzed)
; ROM Range: $008246-$008256 (16 bytes)
; ============================================================================
; Category: game
; Purpose: Short helper function
;   Object (A0, A1): +$00, +$2C
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, A0, A1
; Object fields:
;   +$00: [unknown]
;   +$2C: [unknown]
; Confidence: low
; ============================================================================

fn_8200_002:
        MOVE.W  $002C(A0),D0                    ; $008246
        DC.W    $43FA,$000A         ; LEA     $008256(PC),A1; $00824A
        MOVE.B  $00(A1,D0.W),(-14171).W         ; $00824E
        RTS                                     ; $008254
