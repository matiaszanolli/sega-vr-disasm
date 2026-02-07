; ============================================================================
; Logic Dispatch 027 (auto-analyzed)
; ROM Range: $005618-$005658 (64 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   RAM: $C87E (game_state)
;   Calls: VDPSyncSH2, sfx_queue_process, sprite_input_check
;   Object (A6): +$78
;
; Entry: A6 = object/entity pointer
; Uses: D0, D6, A0, A1, A6
; RAM:
;   $C87E: game_state
; Calls:
;   $0021CA: sfx_queue_process
;   $0028C2: VDPSyncSH2
;   $0058C8: sprite_input_check
; Object fields:
;   +$78: [unknown]
; Confidence: medium
; ============================================================================

fn_4200_027:
        MOVE.W  (-14210).W,D0                   ; $005618
        MOVEA.L $005622(PC,D0.W),A1             ; $00561C
        JMP     (A1)                            ; $005620
        DC.W    $0088                           ; $005622
        ADDQ.B  #3,-$78(A6,D0.W)                ; $005624
        ADDQ.W  #3,(A0)+                        ; $005628
        DC.W    $0088                           ; $00562A
        ADDQ.W  #3,-$78(A6,D0.W)                ; $00562C
        DC.W    $56CE,$0088         ; DBNE    D6,$0056BA; $005630
        DC.W    $573C                           ; $005634
        DC.W    $4EBA,$D28A         ; JSR     $0028C2(PC); $005636
        DC.W    $4EBA,$CB8E         ; JSR     $0021CA(PC); $00563A
        DC.W    $4EBA,$327E         ; JSR     $0088BE(PC); $00563E
        DC.W    $4EBA,$0284         ; JSR     $0058C8(PC); $005642
        ADDQ.B  #1,(-14202).W                   ; $005646
        ADDQ.W  #4,(-14210).W                   ; $00564A
        MOVE.W  #$0010,$00FF0008                ; $00564E
        RTS                                     ; $005656
