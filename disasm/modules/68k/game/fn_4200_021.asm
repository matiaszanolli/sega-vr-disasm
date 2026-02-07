; ============================================================================
; Logic Poll Controllers 021 (auto-analyzed)
; ROM Range: $00535E-$0053B0 (82 bytes)
; ============================================================================
; Category: game
; Purpose: Orchestrator calling 9 subroutines
;   RAM: $C8AA (scene_state), $C87E (game_state)
;   Calls: poll_controllers, animation_update, sprite_update, object_update
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

fn_4200_021:
        DC.W    $4EBA,$CDCE         ; JSR     $00212E(PC); $00535E
        DC.W    $4EBA,$C43A         ; JSR     $00179E(PC); $005362
        DC.W    $4EBA,$5D36         ; JSR     $00B09E(PC); $005366
        DC.W    $4EBA,$5DAE         ; JSR     $00B11A(PC); $00536A
        DC.W    $4EBA,$6194         ; JSR     $00B504(PC); $00536E
        DC.W    $4EBA,$6230         ; JSR     $00B5A4(PC); $005372
        ADDQ.W  #1,(-14166).W                   ; $005376
        DC.W    $4EBA,$14C4         ; JSR     $006840(PC); $00537A
        DC.W    $4EBA,$635A         ; JSR     $00B6DA(PC); $00537E
        DC.W    $4EBA,$6300         ; JSR     $00B684(PC); $005382
        ADDQ.W  #4,(-14210).W                   ; $005386
        MOVE.W  #$0054,$00FF0008                ; $00538A
        DC.W    $4EFA,$0364         ; JMP     $0056F8(PC); $005392
        DC.W    $4EBA,$CD96         ; JSR     $00212E(PC); $005396
        DC.W    $4EBA,$C402         ; JSR     $00179E(PC); $00539A
        DC.W    $4EBA,$5CFE         ; JSR     $00B09E(PC); $00539E
        ADDQ.B  #1,(-14202).W                   ; $0053A2
        MOVE.W  #$0054,$00FF0008                ; $0053A6
        RTS                                     ; $0053AE
