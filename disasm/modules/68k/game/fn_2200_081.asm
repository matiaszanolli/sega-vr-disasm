; ============================================================================
; Vint Input 081 (auto-analyzed)
; ROM Range: $00417C-$0041E4 (104 bytes)
; ============================================================================
; Category: game
; Purpose: RAM: $C8AA (scene_state), $C07C (input_state), $C89C (sh2_comm_state)
;
; Uses: D0
; RAM:
;   $C07C: input_state
;   $C89C: sh2_comm_state
;   $C8AA: scene_state
; Confidence: medium
; ============================================================================

fn_2200_081:
        CMPI.W  #$0015,(-14166).W               ; $00417C
        BNE.S  .loc_0066                        ; $004182
        MOVE.W  (-16234).W,(-16262).W           ; $004184
        ADDQ.W  #4,(-16260).W                   ; $00418A
        MOVE.W  #$0000,$00FF6754                ; $00418E
        TST.B  (-599).W                         ; $004196
        BEQ.S  .loc_0066                        ; $00419A
        CMPI.B  #$01,(-15604).W                 ; $00419C
        BNE.S  .loc_0066                        ; $0041A2
        BTST    #7,(-600).W                     ; $0041A4
        BNE.S  .loc_0066                        ; $0041AA
        MOVE.W  (-14180).W,D0                   ; $0041AC
        BSET    D0,(-4345).W                    ; $0041B0
        CMPI.B  #$02,(-599).W                   ; $0041B4
        BNE.S  .loc_0044                        ; $0041BA
        BSET    D0,(-329).W                     ; $0041BC
.loc_0044:
        CMPI.B  #$1F,(-329).W                   ; $0041C0
        BNE.S  .loc_0058                        ; $0041C6
        BSET    #6,(-329).W                     ; $0041C8
        BSET    #7,(-329).W                     ; $0041CE
.loc_0058:
        CMPI.B  #$1F,(-4345).W                  ; $0041D4
        BNE.S  .loc_0066                        ; $0041DA
        BSET    #0,(-600).W                     ; $0041DC
.loc_0066:
        RTS                                     ; $0041E2
