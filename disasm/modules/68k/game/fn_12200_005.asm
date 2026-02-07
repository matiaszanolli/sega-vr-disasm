; ============================================================================
; Sh2 Comm Dispatch 005 (auto-analyzed)
; ROM Range: $012F0A-$012F56 (76 bytes)
; ============================================================================
; Category: sh2
; Purpose: State dispatcher using jump table
;   Accesses 32X registers: COMM0
;   RAM: $C87E (game_state)
;
; Uses: D1
; RAM:
;   $C87E: game_state
; Confidence: high
; ============================================================================

fn_12200_005:
.loc_0000:
        TST.B  $00A15120                        ; $012F0A
        BNE.S  .loc_0000                        ; $012F10
        CLR.B  $00A15123                        ; $012F12
        MOVE.W  #$0000,(-14210).W               ; $012F18
        MOVEQ   #$00,D1                         ; $012F1E
        MOVE.B  (-24551).W,D1                   ; $012F20
        MOVE.B  D1,(-14313).W                   ; $012F24
        CMPI.B  #$02,D1                         ; $012F28
        BNE.S  .loc_0030                        ; $012F2C
        BTST    #3,(-14312).W                   ; $012F2E
        BEQ.S  .loc_0030                        ; $012F34
        MOVE.W  #$0006,D1                       ; $012F36
.loc_0030:
        DC.W    $D241                           ; $012F3A
        DC.W    $D241                           ; $012F3C
        MOVE.W  #$0000,(-14210).W               ; $012F3E
        MOVE.L  $012F56(PC,D1.W),$00FF0002      ; $012F44
        MOVE.W  #$0020,$00FF0008                ; $012F4C
        RTS                                     ; $012F54
