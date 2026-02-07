; ============================================================================
; Ai 037 (auto-analyzed)
; ROM Range: $00BD00-$00BD2A (42 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A0, A1): +$02 (flags/type), +$10
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: A0, A1
; Object fields:
;   +$02: flags/type
;   +$10: [unknown]
; Confidence: low
; ============================================================================

fn_a200_037:
        LEA     $0002(A0),A1                    ; $00BD00
.loc_0004:
        LEA     -$0010(A1),A1                   ; $00BD04
        CMPI.B  #$0C,-$0002(A1)                 ; $00BD08
        BEQ.S  .loc_0004                        ; $00BD0E
        MOVE.W  (A1)+,(-16250).W                ; $00BD10
        MOVE.W  (A1)+,(-16300).W                ; $00BD14
        MOVE.W  (A1)+,(-16298).W                ; $00BD18
        MOVE.W  (A1)+,(-16210).W                ; $00BD1C
        MOVE.W  (A1)+,(-16208).W                ; $00BD20
        MOVE.W  (A1)+,(-16206).W                ; $00BD24
        RTS                                     ; $00BD28
