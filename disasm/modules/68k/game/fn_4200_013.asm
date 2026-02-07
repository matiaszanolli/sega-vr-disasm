; ============================================================================
; Obj Poll Controllers 013 (auto-analyzed)
; ROM Range: $004D1A-$004D98 (126 bytes)
; ============================================================================
; Category: object
; Purpose: Orchestrator calling 10 subroutines
;   RAM: $C8AA (scene_state), $C87E (game_state)
;   Calls: poll_controllers, animation_update, sprite_state_process, sprite_update
;
; Uses: D0, D1, A0
; RAM:
;   $C87E: game_state
;   $C8AA: scene_state
; Calls:
;   $00179E: poll_controllers
;   $00593C: sprite_state_process
;   $00B09E: animation_update
;   $00B684: object_update
;   $00B6DA: sprite_update
; Confidence: high
; ============================================================================

fn_4200_013:
        DC.W    $4EBA,$D412         ; JSR     $00212E(PC); $004D1A
        DC.W    $4EBA,$CA7E         ; JSR     $00179E(PC); $004D1E
        DC.W    $4EBA,$637A         ; JSR     $00B09E(PC); $004D22
        DC.W    $4EBA,$641C         ; JSR     $00B144(PC); $004D26
        DC.W    $4EBA,$67D8         ; JSR     $00B504(PC); $004D2A
        DC.W    $4EBA,$67AC         ; JSR     $00B4DC(PC); $004D2E
        DC.W    $4EBA,$67EE         ; JSR     $00B522(PC); $004D32
        ADDQ.W  #1,(-14166).W                   ; $004D36
        MOVEA.W (-14144).W,A0                   ; $004D3A
        CMPA.W  #$EF00,A0                       ; $004D3E
        BEQ.W  .loc_0044                        ; $004D42
        MOVE.B  (-13967).W,D0                   ; $004D46
        ANDI.B  #$5C,D0                         ; $004D4A
        MOVE.B  (-13965).W,D1                   ; $004D4E
        ANDI.B  #$03,D1                         ; $004D52
        DC.W    $8001                           ; $004D56
        MOVE.B  D0,(A0)+                        ; $004D58
        MOVE.W  A0,(-14144).W                   ; $004D5A
.loc_0044:
        DC.W    $4EBA,$0BDC         ; JSR     $00593C(PC); $004D5E
        DC.W    $4EBA,$6976         ; JSR     $00B6DA(PC); $004D62
        DC.W    $4EBA,$691C         ; JSR     $00B684(PC); $004D66
        ADDQ.W  #4,(-14210).W                   ; $004D6A
        MOVE.W  #$0054,$00FF0008                ; $004D6E
        DC.W    $4EFA,$0980         ; JMP     $0056F8(PC); $004D76
        DC.W    $4EBA,$D3B2         ; JSR     $00212E(PC); $004D7A
        DC.W    $4EBA,$CA1E         ; JSR     $00179E(PC); $004D7E
        DC.W    $4EBA,$631A         ; JSR     $00B09E(PC); $004D82
        DC.W    $4EBA,$63BC         ; JSR     $00B144(PC); $004D86
        ADDQ.B  #1,(-14202).W                   ; $004D8A
        MOVE.W  #$0054,$00FF0008                ; $004D8E
        RTS                                     ; $004D96
