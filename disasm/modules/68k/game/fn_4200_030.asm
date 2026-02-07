; ============================================================================
; Logic Setdisplayparams 030 (auto-analyzed)
; ROM Range: $0056E4-$00573C (88 bytes)
; ============================================================================
; Category: game
; Purpose: RAM: $C87E (game_state)
;   Calls: SetDisplayParams
;
; Uses: D0
; RAM:
;   $C87E: game_state
; Calls:
;   $0049AA: SetDisplayParams
; Confidence: high
; ============================================================================

fn_4200_030:
        BCLR    #7,(-600).W                     ; $0056E4
        DC.W    $4EFA,$7D9E         ; JMP     $00D48A(PC); $0056EA
        BSET    #7,(-600).W                     ; $0056EE
        DC.W    $4EFA,$7D94         ; JMP     $00D48A(PC); $0056F4
        MOVE.B  (-14227).W,D0                   ; $0056F8
        BTST    #4,(-14322).W                   ; $0056FC
        BEQ.S  .loc_0024                        ; $005702
        OR.B   (-14225).W,D0                    ; $005704
.loc_0024:
        BTST    #7,D0                           ; $005708
        BEQ.S  .loc_0056                        ; $00570C
        TST.B  (-14336).W                       ; $00570E
        BNE.S  .loc_0056                        ; $005712
        MOVE.B  #$01,$00FF69F0                  ; $005714
        DC.W    $4EBA,$F28C         ; JSR     $0049AA(PC); $00571C
        MOVE.B  #$00,(-23280).W                 ; $005720
        MOVE.W  #$0C00,(-14140).W               ; $005726
        MOVE.W  #$0010,(-14210).W               ; $00572C
        MOVE.W  #$0044,$00FF0008                ; $005732
.loc_0056:
        RTS                                     ; $00573A
