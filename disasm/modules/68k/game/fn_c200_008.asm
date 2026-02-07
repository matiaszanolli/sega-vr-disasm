; ============================================================================
; Scene Dispatch 008 (auto-analyzed)
; ROM Range: $00C4C2-$00C542 (128 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   RAM: $C8AA (scene_state), $C082 (menu_state)
;   Calls: sprite_update, object_update
;
; Uses: D0, D1, D2, A0, A1, A2
; RAM:
;   $C082: menu_state
;   $C8AA: scene_state
; Calls:
;   $00B684: object_update
;   $00B6DA: sprite_update
; Confidence: high
; ============================================================================

fn_c200_008:
        JSR     $0088179E                       ; $00C4C2
        ADDQ.W  #1,(-16256).W                   ; $00C4C8
        ADDQ.W  #1,(-14166).W                   ; $00C4CC
        MOVE.L  #$FFFF0000,(-13968).W           ; $00C4D0
        MOVEA.W (-14144).W,A0                   ; $00C4D8
        MOVE.B  (A0)+,D0                        ; $00C4DC
        MOVE.B  D0,D1                           ; $00C4DE
        ANDI.B  #$5C,D0                         ; $00C4E0
        MOVE.B  D0,(-13967).W                   ; $00C4E4
        ANDI.B  #$03,D1                         ; $00C4E8
        MOVE.B  D1,(-13965).W                   ; $00C4EC
        MOVE.W  A0,(-14144).W                   ; $00C4F0
        JSR     $00886DF0                       ; $00C4F4
        JSR     $008824CA                       ; $00C4FA
        ADDQ.B  #1,(-14202).W                   ; $00C500
        ADDQ.B  #4,(-14140).W                   ; $00C504
        MOVE.W  #$0044,$00FF0008                ; $00C508
        MOVEQ   #$00,D0                         ; $00C510
        MOVE.B  (-16254).W,D0                   ; $00C512
        MOVEA.L $00C52C(PC,D0.W),A1             ; $00C516
        JSR     (A1)                            ; $00C51A
        DC.W    $4EBA,$FB52         ; JSR     $00C070(PC); $00C51C
        DC.W    $4EBA,$F1B8         ; JSR     $00B6DA(PC); $00C520
        DC.W    $4EBA,$F15E         ; JSR     $00B684(PC); $00C524
        DC.W    $4EFA,$0138         ; JMP     $00C662(PC); $00C528
        DC.W    $0088                           ; $00C52C
        DC.W    $C542                           ; $00C52E
        DC.W    $0088                           ; $00C530
        DC.W    $C544                           ; $00C532
        DC.W    $0088                           ; $00C534
        DC.W    $C586                           ; $00C536
        DC.W    $0088                           ; $00C538
        AND.L  D2,(A2)                          ; $00C53A
        ADDQ.B  #1,(-14202).W                   ; $00C53C
        RTS                                     ; $00C540
