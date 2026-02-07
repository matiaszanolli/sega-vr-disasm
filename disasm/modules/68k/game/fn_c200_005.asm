; ============================================================================
; Scene Dispatch 005 (auto-analyzed)
; ROM Range: $00C416-$00C44C (54 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   RAM: $C87E (game_state), $C082 (menu_state)
;
; Uses: D0
; RAM:
;   $C082: menu_state
;   $C87E: game_state
; Confidence: high
; ============================================================================

fn_c200_005:
        MOVEQ   #$00,D0                         ; $00C416
        MOVE.B  (-14091).W,D0                   ; $00C418
        MOVE.W  $00C44C(PC,D0.W),D0             ; $00C41C
        CMP.W  (-16256).W,D0                    ; $00C420
        BNE.S  .loc_0034                        ; $00C424
        JSR     $008849AA                       ; $00C426
        MOVE.W  #$0010,(-14210).W               ; $00C42C
        MOVE.W  #$0C00,(-14140).W               ; $00C432
        MOVE.B  #$04,(-16254).W                 ; $00C438
        ADDQ.B  #2,(-14091).W                   ; $00C43E
        MOVE.W  #$0044,$00FF0008                ; $00C442
.loc_0034:
        RTS                                     ; $00C44A
