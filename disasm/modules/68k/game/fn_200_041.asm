; ============================================================================
; Sh2 Comm Game 041 (auto-analyzed)
; ROM Range: $001F4A-$002010 (198 bytes)
; ============================================================================
; Category: sh2
; Purpose: Accesses 32X registers: adapter_ctrl
;   RAM: $C87E (game_state)
;
; Uses: D0, D4, A1, A2, A5, A6
; RAM:
;   $C87E: game_state
; Confidence: high
; ============================================================================

fn_200_041:
        MOVE.W  (A5),D0                         ; $001F4A
        MOVE.L  #$6C000003,(A5)                 ; $001F4C
        MOVE.W  (-32768).W,(A6)                 ; $001F52
        MOVE.W  (-32766).W,(A6)                 ; $001F56
        MOVE.L  #$40000010,(A5)                 ; $001F5A
        MOVE.W  (-14208).W,(A6)                 ; $001F60
        MOVE.W  (-14206).W,(A6)                 ; $001F64
        MOVE.W  #$0100,$00A11100                ; $001F68
.loc_0026:
        BTST    #0,$00A11100                    ; $001F70
        BNE.S  .loc_0026                        ; $001F78
        MOVE.W  (-14220).W,D4                   ; $001F7A
        BSET    #4,D4                           ; $001F7E
        MOVE.W  D4,(A5)                         ; $001F82
        MOVE.L  #$93209400,(A5)                 ; $001F84
        MOVE.L  #$954096C2,(A5)                 ; $001F8A
        MOVE.W  #$977F,(A5)                     ; $001F90
        MOVE.W  #$C000,(A5)                     ; $001F94
        MOVE.W  #$0080,(-14218).W               ; $001F98
        MOVE.W  (-14218).W,(A5)                 ; $001F9E
        MOVE.W  (-14220).W,(A5)                 ; $001FA2
        MOVE.W  #$0000,$00A11100                ; $001FA6
        BTST    #0,$00A15123                    ; $001FAE
        BEQ.S  .loc_00C4                        ; $001FB6
        BCLR    #0,$00A15123                    ; $001FB8
        MOVE.W  #$0000,(-14210).W               ; $001FC0
        BCLR    #7,$00A15100                    ; $001FC6
.loc_0084:
        BTST    #7,$00A1518A                    ; $001FCE
        BEQ.S  .loc_0084                        ; $001FD6
        LEA     $00FF6E00,A1                    ; $001FD8
        LEA     $00A15200,A2                    ; $001FDE
        DC.W    $4EBA,$28F0         ; JSR     $0048D6(PC); $001FE4
        DC.W    $4EBA,$28F0         ; JSR     $0048DA(PC); $001FE8
        BCHG    #0,(-14324).W                   ; $001FEC
        BNE.S  .loc_00B4                        ; $001FF2
        BSET    #0,$00A1518B                    ; $001FF4
        BRA.S  .loc_00BC                        ; $001FFC
.loc_00B4:
        BCLR    #0,$00A1518B                    ; $001FFE
.loc_00BC:
        BSET    #7,$00A15100                    ; $002006
.loc_00C4:
        RTS                                     ; $00200E
