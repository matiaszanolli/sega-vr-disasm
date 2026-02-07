; ============================================================================
; Ai Dispatch 012 (auto-analyzed)
; ROM Range: $00B398-$00B3CE (54 bytes)
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

fn_a200_012:
        ORI.L  #$00D000C0,-(A0)                 ; $00B398
        BTST    D0,(A0)                         ; $00B39E
        ORI.L  #$00900080,(A0)                  ; $00B3A0
        ORI.L  #$01000080,-(A0)                 ; $00B3A6
        ORI.L  #$008000D0,D0                    ; $00B3AC
        DC.W    $00E0                           ; $00B3B2
        DC.W    $00D0                           ; $00B3B4
        BTST    D0,D0                           ; $00B3B6
        BTST    D0,D0                           ; $00B3B8
        BTST    D0,D0                           ; $00B3BA
        ADD.W  (-14176).W,D0                    ; $00B3BC
        MOVE.W  $00B398(PC,D0.W),D0             ; $00B3C0
        CMPI.B  #$60,(A1)                       ; $00B3C4
        DC.W    $6D00,$FF3A         ; BLT.W  $00B304; $00B3C8
        RTS                                     ; $00B3CC
