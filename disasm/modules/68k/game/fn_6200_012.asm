; ============================================================================
; Display Scroll 012 (auto-analyzed)
; ROM Range: $006C26-$006C46 (32 bytes)
; ============================================================================
; Category: display
; Purpose: Short helper function
;   RAM: $C050 (scroll_state), $C07C (input_state)
;
; Uses: D0
; RAM:
;   $C050: scroll_state
;   $C07C: input_state
; Confidence: medium
; ============================================================================

fn_6200_012:
        MOVE.W  (-16304).W,D0                   ; $006C26
        BPL.S  .loc_001E                        ; $006C2A
        BSET    #0,(-15602).W                   ; $006C2C
        MOVE.W  (-16234).W,(-16262).W           ; $006C32
        MOVE.W  #$0014,(-16260).W               ; $006C38
        MOVE.W  #$0000,(-16304).W               ; $006C3E
.loc_001E:
        RTS                                     ; $006C44
