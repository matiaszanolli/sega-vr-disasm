; ============================================================================
; State Dispatch 047 (auto-analyzed)
; ROM Range: $00A050-$00A0B4 (100 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   RAM: $C0FA (timer_state), $C8A0 (race_state), $C8C8 (vint_state)
;
; Uses: D0, D1, A1
; RAM:
;   $C0FA: timer_state
;   $C8A0: race_state
;   $C8C8: vint_state
; Confidence: medium
; ============================================================================

fn_8200_047:
        LEA     $00898824,A1                    ; $00A050
        MOVE.L  (A1)+,(-15752).W                ; $00A056
        MOVE.W  (A1)+,(-16154).W                ; $00A05A
        MOVE.W  (A1)+,(-16152).W                ; $00A05E
        MOVE.W  (A1)+,(-16150).W                ; $00A062
        MOVE.W  (A1)+,(-16148).W                ; $00A066
        MOVE.W  (A1)+,(-16146).W                ; $00A06A
        MOVE.W  (A1)+,(-16144).W                ; $00A06E
        MOVE.W  (A1)+,(-16142).W                ; $00A072
        MOVE.W  (A1)+,(-16140).W                ; $00A076
        MOVE.W  (A1)+,(-16138).W                ; $00A07A
        MOVE.W  (A1)+,(-14130).W                ; $00A07E
        MOVE.W  (A1)+,(-14128).W                ; $00A082
        MOVE.W  (A1)+,(-14126).W                ; $00A086
        MOVE.W  (A1)+,(-16136).W                ; $00A08A
        MOVE.W  (A1)+,(-16134).W                ; $00A08E
        MOVE.L  #$0093925E,(-15748).W           ; $00A092
        MOVE.W  (-14176).W,D1                   ; $00A09A
        DC.W    $D241                           ; $00A09E
        MOVE.W  (-14136).W,D0                   ; $00A0A0
        MULS    #$0030,D0                       ; $00A0A4
        DC.W    $D240                           ; $00A0A8
        LEA     $00A0B4(PC,D1.W),A1             ; $00A0AA
        MOVE.L  A1,(-15744).W                   ; $00A0AE
        RTS                                     ; $00A0B2
