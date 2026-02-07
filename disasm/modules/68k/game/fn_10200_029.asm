; ============================================================================
; Name Entry Sprite Update 029 (auto-analyzed)
; ROM Range: $01188A-$0118D4 (74 bytes)
; ============================================================================
; Category: game
; Purpose: Accesses 32X registers: COMM0
;   RAM: $C87E (game_state)
;   Calls: sprite_update
;
; Uses: D0, A0
; RAM:
;   $C87E: game_state
; Calls:
;   $00B6DA: sprite_update
; Confidence: high
; ============================================================================

fn_10200_029:
        LEA     $00FF6E00,A0                    ; $01188A
        MOVE.W  #$007F,D0                       ; $011890
.loc_000A:
        CLR.L  (A0)+                            ; $011894
        DBRA    D0,.loc_000A                    ; $011896
        MOVE.B  #$01,(-14303).W                 ; $01189A
        DC.W    $4EBA,$9E38         ; JSR     $00B6DA(PC); $0118A0
        BTST    #7,(-14322).W                   ; $0118A4
        BNE.S  .loc_0048                        ; $0118AA
.loc_0022:
        TST.B  $00A15120                        ; $0118AC
        BNE.S  .loc_0022                        ; $0118B2
        CLR.B  $00A15123                        ; $0118B4
        MOVE.W  #$0000,(-14210).W               ; $0118BA
        MOVE.W  #$0020,$00FF0008                ; $0118C0
        MOVE.L  #$0088D4B8,$00FF0002            ; $0118C8
.loc_0048:
        RTS                                     ; $0118D2
