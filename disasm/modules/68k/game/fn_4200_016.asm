; ============================================================================
; Logic Poll Controllers 016 (auto-analyzed)
; ROM Range: $005070-$00509E (46 bytes)
; ============================================================================
; Category: game
; Purpose: Orchestrator calling 8 subroutines
;   RAM: $C87E (game_state)
;   Calls: poll_controllers, animation_update
;
; RAM:
;   $C87E: game_state
; Calls:
;   $00179E: poll_controllers
;   $00B09E: animation_update
; Confidence: medium
; ============================================================================

fn_4200_016:
        DC.W    $4EBA,$D10E         ; JSR     $002180(PC); $005070
        DC.W    $4EBA,$C728         ; JSR     $00179E(PC); $005074
        DC.W    $4EBA,$6024         ; JSR     $00B09E(PC); $005078
        DC.W    $4EBA,$6016         ; JSR     $00B094(PC); $00507C
        DC.W    $4EBA,$605C         ; JSR     $00B0DE(PC); $005080
        DC.W    $4EBA,$60A2         ; JSR     $00B128(PC); $005084
        DC.W    $4EBA,$60AC         ; JSR     $00B136(PC); $005088
        DC.W    $4EBA,$1380         ; JSR     $00640E(PC); $00508C
        ADDQ.W  #4,(-14210).W                   ; $005090
        MOVE.W  #$001C,$00FF0008                ; $005094
        RTS                                     ; $00509C
