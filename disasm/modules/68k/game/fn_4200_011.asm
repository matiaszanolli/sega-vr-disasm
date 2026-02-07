; ============================================================================
; Logic Dispatch 011 (auto-analyzed)
; ROM Range: $004CB8-$004D00 (72 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   RAM: $C87E (game_state)
;   Calls: VDPSyncSH2, animation_update, sprite_input_check
;
; Uses: D0, D3, D7, A1, A2
; RAM:
;   $C87E: game_state
; Calls:
;   $0028C2: VDPSyncSH2
;   $0058C8: sprite_input_check
;   $00B09E: animation_update
; Confidence: medium
; ============================================================================

fn_4200_011:
        DC.W    $A2A0                           ; $004CB8
        DC.W    $A100                           ; $004CBA
        MOVE.W  (-14210).W,D0                   ; $004CBC
        MOVEA.L $004CC6(PC,D0.W),A1             ; $004CC0
        JMP     (A1)                            ; $004CC4
        DC.W    $0088                           ; $004CC6
        MOVEM.L (A2)+,D3/D7                     ; $004CC8
        DC.W    $4D00                           ; $004CCC
        DC.W    $0088                           ; $004CCE
        DC.W    $4D1A                           ; $004CD0
        DC.W    $0088                           ; $004CD2
        DC.W    $4D7A                           ; $004CD4
        DC.W    $0088                           ; $004CD6
        DC.W    $573C                           ; $004CD8
        DC.W    $4EBA,$DBE6         ; JSR     $0028C2(PC); $004CDA
        DC.W    $4EBA,$D3F6         ; JSR     $0020D6(PC); $004CDE
        DC.W    $4EBA,$63BA         ; JSR     $00B09E(PC); $004CE2
        DC.W    $4EBA,$6344         ; JSR     $00B02C(PC); $004CE6
        DC.W    $4EBA,$6946         ; JSR     $00B632(PC); $004CEA
        DC.W    $4EBA,$0BD8         ; JSR     $0058C8(PC); $004CEE
        ADDQ.W  #4,(-14210).W                   ; $004CF2
        MOVE.W  #$0010,$00FF0008                ; $004CF6
        RTS                                     ; $004CFE
