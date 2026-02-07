; ============================================================================
; Ai Dispatch 011 (auto-analyzed)
; ROM Range: $00B36E-$00B398 (42 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   RAM: $C8A0 (race_state)
;
; Uses: D0, A0, A1
; RAM:
;   $C8A0: race_state
; Confidence: medium
; ============================================================================

fn_a200_011:
        DC.W    $00D0                           ; $00B36E
        DC.W    $00C0                           ; $00B370
        ORI.L  #$009000A0,(A0)                  ; $00B372
        BTST    D0,D0                           ; $00B378
        ORI.L  #$008000E0,D0                    ; $00B37A
        DC.W    $00D0                           ; $00B380
        BTST    D0,D0                           ; $00B382
        BTST    D0,D0                           ; $00B384
        ADD.W  (-14176).W,D0                    ; $00B386
        MOVE.W  $00B36E(PC,D0.W),D0             ; $00B38A
        CMPI.B  #$60,(A1)                       ; $00B38E
        DC.W    $6D00,$FF70         ; BLT.W  $00B304; $00B392
        RTS                                     ; $00B396
