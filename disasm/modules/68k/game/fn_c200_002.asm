; ============================================================================
; Scene Dispatch 002 (auto-analyzed)
; ROM Range: $00C30A-$00C368 (94 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   RAM: $C87E (game_state)
;   Object (A0): +$88
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, D2, A0, A1, A6
; RAM:
;   $C87E: game_state
; Object fields:
;   +$88: [unknown]
; Confidence: medium
; ============================================================================

fn_c200_002:
        MOVE.W  (-14210).W,D0                   ; $00C30A
        MOVEA.L $00C314(PC,D0.W),A1             ; $00C30E
        JMP     (A1)                            ; $00C312
        DC.W    $0088                           ; $00C314
        AND.B  D1,$0088(A0)                     ; $00C316
        AND.W  D1,$0088(A0)                     ; $00C31A
        AND.L  D1,(A0)                          ; $00C31E
        DC.W    $0088                           ; $00C320
        MULS    #$0088,D1                       ; $00C322
        AND.W  (A6)+,D2                         ; $00C326
        JSR     $008828C2                       ; $00C328
        JSR     $008821CA                       ; $00C32E
        MOVE.W  (-14228).W,-(A7)                ; $00C334
        MOVE.W  #$FF00,(-14228).W               ; $00C338
        BTST    #0,(-14308).W                   ; $00C33E
        BNE.S  .loc_0042                        ; $00C344
        JSR     $008888BE                       ; $00C346
.loc_0042:
        MOVE.W  (A7)+,(-14228).W                ; $00C34C
        JSR     $008858C8                       ; $00C350
        ADDQ.B  #1,(-14202).W                   ; $00C356
        ADDQ.W  #4,(-14210).W                   ; $00C35A
        MOVE.W  #$0010,$00FF0008                ; $00C35E
        RTS                                     ; $00C366
