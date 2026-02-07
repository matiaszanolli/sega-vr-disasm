; ============================================================================
; Obj Poll Controllers 029 (auto-analyzed)
; ROM Range: $005676-$0056E4 (110 bytes)
; ============================================================================
; Category: object
; Purpose: Orchestrator calling 8 subroutines
;   RAM: $C8AA (scene_state), $C87E (game_state)
;   Calls: sfx_queue_process, poll_controllers, sprite_state_process, sprite_update
;
; Uses: D0, D1, A0
; RAM:
;   $C87E: game_state
;   $C8AA: scene_state
; Calls:
;   $00179E: poll_controllers
;   $0021CA: sfx_queue_process
;   $00593C: sprite_state_process
;   $00B684: object_update
;   $00B6DA: sprite_update
; Confidence: high
; ============================================================================

fn_4200_029:
        DC.W    $4EBA,$CB52         ; JSR     $0021CA(PC); $005676
        DC.W    $4EBA,$C122         ; JSR     $00179E(PC); $00567A
        DC.W    $4EBA,$5E84         ; JSR     $00B504(PC); $00567E
        DC.W    $4EBA,$5E9E         ; JSR     $00B522(PC); $005682
        ADDQ.W  #1,(-14166).W                   ; $005686
        MOVE.L  #$FFFF0000,(-13968).W           ; $00568A
        MOVEA.W (-14144).W,A0                   ; $005692
        MOVE.B  (A0)+,D0                        ; $005696
        MOVE.B  D0,D1                           ; $005698
        ANDI.B  #$5C,D0                         ; $00569A
        MOVE.B  D0,(-13967).W                   ; $00569E
        ANDI.B  #$03,D1                         ; $0056A2
        MOVE.B  D1,(-13965).W                   ; $0056A6
        MOVE.W  A0,(-14144).W                   ; $0056AA
        DC.W    $4EBA,$5F1A         ; JSR     $00B5CA(PC); $0056AE
        DC.W    $4EBA,$0288         ; JSR     $00593C(PC); $0056B2
        DC.W    $4EBA,$6022         ; JSR     $00B6DA(PC); $0056B6
        DC.W    $4EBA,$5FC8         ; JSR     $00B684(PC); $0056BA
        ADDQ.W  #4,(-14210).W                   ; $0056BE
        MOVE.W  #$0054,$00FF0008                ; $0056C2
        DC.W    $4EFA,$002C         ; JMP     $0056F8(PC); $0056CA
        DC.W    $4EBA,$CAFA         ; JSR     $0021CA(PC); $0056CE
        DC.W    $4EBA,$C0CA         ; JSR     $00179E(PC); $0056D2
        ADDQ.B  #1,(-14202).W                   ; $0056D6
        MOVE.W  #$0054,$00FF0008                ; $0056DA
        RTS                                     ; $0056E2
