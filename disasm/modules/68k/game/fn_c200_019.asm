; ============================================================================
; Scene Dispatch 019 (auto-analyzed)
; ROM Range: $00D04C-$00D08A (62 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   RAM: $C8A0 (race_state)
;   Object (A1): +$00
;
; Entry: A1 = object/entity pointer
; Uses: D0, D1, A0, A1, A3
; RAM:
;   $C8A0: race_state
; Object fields:
;   +$00: [unknown]
; Confidence: medium
; ============================================================================

fn_c200_019:
        ADDQ.W  #8,D1                           ; $00D04C
        DC.W    $4100                           ; $00D04E
        ADDQ.W  #8,A3                           ; $00D050
        NOT.B  D0                               ; $00D052
        DC.W    $4EBA,$FFB6         ; JSR     $00D00C(PC); $00D054
        MOVE.W  (-14176).W,D0                   ; $00D058
        LEA     $00898C0C,A1                    ; $00D05C
        MOVE.L  $00(A1,D0.W),$00FF6868          ; $00D062
        MOVEA.L $00D070(PC,D0.W),A1             ; $00D06A
        JMP     (A1)                            ; $00D06E
        DC.W    $0088                           ; $00D070
        ADD.L  A0,D0                            ; $00D072
        DC.W    $0088                           ; $00D074
        ADD.L  A0,D0                            ; $00D076
        DC.W    $0088                           ; $00D078
        ADD.L  A0,D0                            ; $00D07A
        DC.W    $0088                           ; $00D07C
        ADD.L  A0,D0                            ; $00D07E
        DC.W    $0088                           ; $00D080
        ADD.L  A0,D0                            ; $00D082
        DC.W    $0088                           ; $00D084
        ADD.L  A0,D0                            ; $00D086
        RTS                                     ; $00D088
