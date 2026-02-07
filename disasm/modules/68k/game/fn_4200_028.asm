; ============================================================================
; Logic Sfx Queue Process 028 (auto-analyzed)
; ROM Range: $005658-$005676 (30 bytes)
; ============================================================================
; Category: game
; Purpose: Orchestrator calling 4 subroutines
;   RAM: $C87E (game_state)
;   Calls: sfx_queue_process, sprite_update_check
;
; RAM:
;   $C87E: game_state
; Calls:
;   $0021CA: sfx_queue_process
;   $005908: sprite_update_check
; Confidence: medium
; ============================================================================

fn_4200_028:
        DC.W    $4EBA,$CB70         ; JSR     $0021CA(PC); $005658
        DC.W    $4EBA,$59CE         ; JSR     $00B02C(PC); $00565C
        DC.W    $4EBA,$5FD0         ; JSR     $00B632(PC); $005660
        DC.W    $4EBA,$02A2         ; JSR     $005908(PC); $005664
        ADDQ.W  #4,(-14210).W                   ; $005668
        MOVE.W  #$0010,$00FF0008                ; $00566C
        RTS                                     ; $005674
