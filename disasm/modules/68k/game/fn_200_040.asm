; ============================================================================
; Sh2 Comm Game 040 (auto-analyzed)
; ROM Range: $001E94-$001F4A (182 bytes)
; ============================================================================
; Category: sh2
; Purpose: Accesses 32X registers: adapter_ctrl
;   RAM: $C87E (game_state)
;
; Uses: D0, D4, A1, A2, A5
; RAM:
;   $C87E: game_state
; Confidence: high
; ============================================================================

fn_200_040:
        MOVE.W  (A5),D0                         ; $001E94
        MOVE.W  #$0100,$00A11100                ; $001E96
.loc_000A:
        BTST    #0,$00A11100                    ; $001E9E
        BNE.S  .loc_000A                        ; $001EA6
        MOVE.W  (-14220).W,D4                   ; $001EA8
        BSET    #4,D4                           ; $001EAC
        MOVE.W  D4,(A5)                         ; $001EB0
        MOVE.L  #$93209400,(A5)                 ; $001EB2
        MOVE.L  #$950096D8,(A5)                 ; $001EB8
        MOVE.W  #$977F,(A5)                     ; $001EBE
        MOVE.W  #$C000,(A5)                     ; $001EC2
        MOVE.W  #$0080,(-14218).W               ; $001EC6
        MOVE.W  (-14218).W,(A5)                 ; $001ECC
        MOVE.W  (-14220).W,(A5)                 ; $001ED0
        MOVE.W  #$0000,$00A11100                ; $001ED4
        BTST    #0,$00A15123                    ; $001EDC
        BEQ.S  .loc_00B4                        ; $001EE4
        BCLR    #0,$00A15123                    ; $001EE6
        CMPI.B  #$18,(-14139).W                 ; $001EEE
        BNE.S  .loc_0068                        ; $001EF4
        MOVE.W  #$0000,(-14210).W               ; $001EF6
.loc_0068:
        MOVE.B  #$00,(-14140).W                 ; $001EFC
        BCLR    #7,$00A15100                    ; $001F02
.loc_0076:
        BTST    #7,$00A1518A                    ; $001F0A
        BEQ.S  .loc_0076                        ; $001F12
        LEA     (-19456).W,A1                   ; $001F14
        LEA     $00A15200,A2                    ; $001F18
        DC.W    $4EBA,$29B6         ; JSR     $0048D6(PC); $001F1E
        DC.W    $4EBA,$29B6         ; JSR     $0048DA(PC); $001F22
        BCHG    #0,(-14324).W                   ; $001F26
        BNE.S  .loc_00A4                        ; $001F2C
        BSET    #0,$00A1518B                    ; $001F2E
        BRA.S  .loc_00AC                        ; $001F36
.loc_00A4:
        BCLR    #0,$00A1518B                    ; $001F38
.loc_00AC:
        BSET    #7,$00A15100                    ; $001F40
.loc_00B4:
        RTS                                     ; $001F48
