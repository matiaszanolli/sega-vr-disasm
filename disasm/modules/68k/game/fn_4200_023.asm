; ============================================================================
; Logic Dispatch 023 (auto-analyzed)
; ROM Range: $005586-$0055BA (52 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   RAM: $C87E (game_state)
;   Calls: VDPSyncSH2, sfx_queue_process, sprite_input_check
;
; Uses: D0, A0, A1
; RAM:
;   $C87E: game_state
; Calls:
;   $0021CA: sfx_queue_process
;   $0028C2: VDPSyncSH2
;   $0058C8: sprite_input_check
; Confidence: medium
; ============================================================================

fn_4200_023:
        MOVE.W  (-14210).W,D0                   ; $005586
        MOVEA.L $005590(PC,D0.W),A1             ; $00558A
        JMP     (A1)                            ; $00558E
        DC.W    $0088                           ; $005590
        SUBQ.L  #2,-(A0)                        ; $005592
        DC.W    $0088                           ; $005594
        DC.W    $55BA                           ; $005596
        DC.W    $0088                           ; $005598
        SCS     (A0)                            ; $00559A
        DC.W    $0088                           ; $00559C
        DC.W    $55FE                           ; $00559E
        DC.W    $4EBA,$D320         ; JSR     $0028C2(PC); $0055A0
        DC.W    $4EBA,$CC24         ; JSR     $0021CA(PC); $0055A4
        DC.W    $4EBA,$031E         ; JSR     $0058C8(PC); $0055A8
        ADDQ.W  #4,(-14210).W                   ; $0055AC
        MOVE.W  #$0010,$00FF0008                ; $0055B0
        RTS                                     ; $0055B8
