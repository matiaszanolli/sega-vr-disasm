; ============================================================================
; Scene Object Update 025 (auto-analyzed)
; ROM Range: $00D8B8-$00D8CC (20 bytes)
; ============================================================================
; Category: game
; Purpose: Short helper function
;   RAM: $C87E (game_state)
;   Calls: object_update
;
; RAM:
;   $C87E: game_state
; Calls:
;   $00B684: object_update
; Confidence: high
; ============================================================================

fn_c200_025:
        DC.W    $4EBA,$DDCA         ; JSR     $00B684(PC); $00D8B8
        BTST    #6,(-14322).W                   ; $00D8BC
        BNE.S  .loc_0012                        ; $00D8C2
        ADDQ.W  #4,(-14210).W                   ; $00D8C4
        NOP                                     ; $00D8C8
.loc_0012:
        RTS                                     ; $00D8CA
