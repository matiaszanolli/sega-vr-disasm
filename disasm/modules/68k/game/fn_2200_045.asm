; ============================================================================
; Objs 045 (auto-analyzed)
; ROM Range: $003250-$003272 (34 bytes)
; ============================================================================
; Category: object
; Purpose: Short helper function
;   RAM: $6950 (obj_flags)
;   Object (A1): +$00
;
; Entry: A1 = object/entity pointer
; Uses: A1
; RAM:
;   $6950: obj_flags
; Object fields:
;   +$00: [unknown]
; Confidence: medium
; ============================================================================

fn_2200_045:
        MOVEA.L (-15784).W,A1                   ; $003250
        MOVE.B  #$02,$0000(A1)                  ; $003254
        MOVE.B  #$00,$00FF6940                  ; $00325A
        MOVE.B  #$00,$00FF6950                  ; $003262
        MOVE.B  #$00,(-15611).W                 ; $00326A
        RTS                                     ; $003270
