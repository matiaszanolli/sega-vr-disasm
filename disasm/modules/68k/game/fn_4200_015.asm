; ============================================================================
; Logic Dispatch 015 (auto-analyzed)
; ROM Range: $005020-$005070 (80 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   RAM: $C87E (game_state)
;   Calls: VDPSyncSH2, animation_update
;   Object (A0): +$78
;
; Entry: A0 = object/entity pointer
; Uses: D0, D2, A0, A1, A6
; RAM:
;   $C87E: game_state
; Calls:
;   $0028C2: VDPSyncSH2
;   $00B09E: animation_update
; Object fields:
;   +$78: [unknown]
; Confidence: medium
; ============================================================================

fn_4200_015:
        DC.W    $A5A3                           ; $005020
        DC.W    $A400                           ; $005022
        MOVE.W  (-14210).W,D0                   ; $005024
        MOVEA.L $00502E(PC,D0.W),A1             ; $005028
        JMP     (A1)                            ; $00502C
        DC.W    $0088                           ; $00502E
        ADDQ.W  #8,D2                           ; $005030
        DC.W    $0088                           ; $005032
        ADDQ.W  #8,-$78(A0,D0.W)                ; $005034
        ADDQ.L  #8,(A6)+                        ; $005038
        DC.W    $0088                           ; $00503A
        ST      (A6)+                           ; $00503C
        DC.W    $0088                           ; $00503E
        DC.W    $573C                           ; $005040
        DC.W    $4EBA,$D87E         ; JSR     $0028C2(PC); $005042
        DC.W    $4EBA,$D10C         ; JSR     $002154(PC); $005046
        DC.W    $4EBA,$6052         ; JSR     $00B09E(PC); $00504A
        DC.W    $4EBA,$6044         ; JSR     $00B094(PC); $00504E
        DC.W    $4EBA,$608A         ; JSR     $00B0DE(PC); $005052
        DC.W    $4EBA,$5FE4         ; JSR     $00B03C(PC); $005056
        DC.W    $4EBA,$65D6         ; JSR     $00B632(PC); $00505A
        DC.W    $4EBA,$65E6         ; JSR     $00B646(PC); $00505E
        ADDQ.W  #4,(-14210).W                   ; $005062
        MOVE.W  #$0014,$00FF0008                ; $005066
        RTS                                     ; $00506E
