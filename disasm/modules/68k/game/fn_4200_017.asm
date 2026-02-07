; ============================================================================
; Logic Poll Controllers 017 (auto-analyzed)
; ROM Range: $00509E-$005100 (98 bytes)
; ============================================================================
; Category: game
; Purpose: Orchestrator calling 12 subroutines
;   RAM: $C8AA (scene_state), $C87E (game_state)
;   Calls: animation_update, sprite_update, object_update, poll_controllers
;
; RAM:
;   $C87E: game_state
;   $C8AA: scene_state
; Calls:
;   $00179E: poll_controllers
;   $00B09E: animation_update
;   $00B684: object_update
;   $00B6DA: sprite_update
; Confidence: high
; ============================================================================

fn_4200_017:
        DC.W    $4EBA,$D104         ; JSR     $0021A4(PC); $00509E
        DC.W    $4EBA,$13F2         ; JSR     $006496(PC); $0050A2
        DC.W    $4EBA,$5FF6         ; JSR     $00B09E(PC); $0050A6
        DC.W    $4EBA,$5FE8         ; JSR     $00B094(PC); $0050AA
        DC.W    $4EBA,$602E         ; JSR     $00B0DE(PC); $0050AE
        DC.W    $4EBA,$6450         ; JSR     $00B504(PC); $0050B2
        DC.W    $4EBA,$6440         ; JSR     $00B4F8(PC); $0050B6
        DC.W    $4EBA,$649E         ; JSR     $00B55A(PC); $0050BA
        DC.W    $4EBA,$64D0         ; JSR     $00B590(PC); $0050BE
        ADDQ.W  #1,(-14166).W                   ; $0050C2
        DC.W    $4EBA,$6612         ; JSR     $00B6DA(PC); $0050C6
        DC.W    $4EBA,$65B8         ; JSR     $00B684(PC); $0050CA
        ADDQ.W  #4,(-14210).W                   ; $0050CE
        MOVE.W  #$0054,$00FF0008                ; $0050D2
        DC.W    $4EFA,$061C         ; JMP     $0056F8(PC); $0050DA
        DC.W    $4EBA,$D0C4         ; JSR     $0021A4(PC); $0050DE
        DC.W    $4EBA,$C6BA         ; JSR     $00179E(PC); $0050E2
        DC.W    $4EBA,$5FB6         ; JSR     $00B09E(PC); $0050E6
        DC.W    $4EBA,$5FA8         ; JSR     $00B094(PC); $0050EA
        DC.W    $4EBA,$5FEE         ; JSR     $00B0DE(PC); $0050EE
        ADDQ.B  #1,(-14202).W                   ; $0050F2
        MOVE.W  #$0054,$00FF0008                ; $0050F6
        RTS                                     ; $0050FE
