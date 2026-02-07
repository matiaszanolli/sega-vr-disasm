; ============================================================================
; Scene Object Update 004 (auto-analyzed)
; ROM Range: $00C390-$00C416 (134 bytes)
; ============================================================================
; Category: game
; Purpose: Orchestrator calling 5 subroutines
;   RAM: $C8AA (scene_state), $C87E (game_state)
;   Calls: sprite_update, object_update
;
; Uses: D0, D1, A0
; RAM:
;   $C87E: game_state
;   $C8AA: scene_state
; Calls:
;   $00B684: object_update
;   $00B6DA: sprite_update
; Confidence: high
; ============================================================================

fn_c200_004:
        JSR     $008821CA                       ; $00C390
        JSR     $0088179E                       ; $00C396
        ADDQ.W  #1,(-16256).W                   ; $00C39C
        ADDQ.W  #1,(-14166).W                   ; $00C3A0
        MOVE.L  #$FFFF0000,(-13968).W           ; $00C3A4
        MOVEA.W (-14144).W,A0                   ; $00C3AC
        MOVE.B  (A0)+,D0                        ; $00C3B0
        MOVE.B  D0,D1                           ; $00C3B2
        ANDI.B  #$5C,D0                         ; $00C3B4
        MOVE.B  D0,(-13967).W                   ; $00C3B8
        ANDI.B  #$03,D1                         ; $00C3BC
        MOVE.B  D1,(-13965).W                   ; $00C3C0
        MOVE.W  A0,(-14144).W                   ; $00C3C4
        JSR     $0088593C                       ; $00C3C8
        JSR     $008824CA                       ; $00C3CE
        DC.W    $4EBA,$F304         ; JSR     $00B6DA(PC); $00C3D4
        DC.W    $4EBA,$F2AA         ; JSR     $00B684(PC); $00C3D8
        ADDQ.B  #1,(-14202).W                   ; $00C3DC
        ADDQ.W  #4,(-14210).W                   ; $00C3E0
        MOVE.W  #$0038,$00FF0008                ; $00C3E4
        DC.W    $4EBA,$0028         ; JSR     $00C416(PC); $00C3EC
        DC.W    $4EBA,$01BC         ; JSR     $00C5AE(PC); $00C3F0
        DC.W    $4EBA,$FC7A         ; JSR     $00C070(PC); $00C3F4
        DC.W    $4EFA,$0268         ; JMP     $00C662(PC); $00C3F8
        JSR     $008821CA                       ; $00C3FC
        JSR     $0088179E                       ; $00C402
        ADDQ.B  #1,(-14202).W                   ; $00C408
        MOVE.W  #$0038,$00FF0008                ; $00C40C
        RTS                                     ; $00C414
