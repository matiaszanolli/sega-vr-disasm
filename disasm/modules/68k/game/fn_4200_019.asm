; ============================================================================
; Logic Dispatch 019 (auto-analyzed)
; ROM Range: $005308-$005348 (64 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   RAM: $C87E (game_state)
;   Calls: VDPSyncSH2, animation_update
;
; Uses: D0, A0, A1, A6
; RAM:
;   $C87E: game_state
; Calls:
;   $0028C2: VDPSyncSH2
;   $00B09E: animation_update
; Confidence: medium
; ============================================================================

fn_4200_019:
        MOVE.W  (-14210).W,D0                   ; $005308
        MOVEA.L $005312(PC,D0.W),A1             ; $00530C
        JMP     (A1)                            ; $005310
        DC.W    $0088                           ; $005312
        SUBQ.B  #1,-(A6)                        ; $005314
        DC.W    $0088                           ; $005316
        SUBQ.W  #1,A0                           ; $005318
        DC.W    $0088                           ; $00531A
        SUBQ.W  #1,(A6)+                        ; $00531C
        DC.W    $0088                           ; $00531E
        SUBQ.L  #1,(A6)                         ; $005320
        DC.W    $0088                           ; $005322
        DC.W    $573C                           ; $005324
        DC.W    $4EBA,$D59A         ; JSR     $0028C2(PC); $005326
        DC.W    $4EBA,$CDAA         ; JSR     $0020D6(PC); $00532A
        DC.W    $4EBA,$5D6E         ; JSR     $00B09E(PC); $00532E
        DC.W    $4EBA,$5CF8         ; JSR     $00B02C(PC); $005332
        DC.W    $4EBA,$62FA         ; JSR     $00B632(PC); $005336
        ADDQ.W  #4,(-14210).W                   ; $00533A
        MOVE.W  #$0010,$00FF0008                ; $00533E
        RTS                                     ; $005346
