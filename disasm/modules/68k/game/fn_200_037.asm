; ============================================================================
; Sh2 Comm Game 037 (auto-analyzed)
; ROM Range: $001D0C-$001DBE (178 bytes)
; ============================================================================
; Category: sh2
; Purpose: Accesses 32X registers: adapter_ctrl
;   RAM: $C87E (game_state)
;
; Uses: D0, D4, A5, A6
; RAM:
;   $C87E: game_state
; Confidence: high
; ============================================================================

fn_200_037:
        MOVE.W  (A5),D0                         ; $001D0C
        MOVE.L  #$6C000003,(A5)                 ; $001D0E
        MOVE.W  (-32768).W,(A6)                 ; $001D14
        MOVE.W  (-32766).W,(A6)                 ; $001D18
        MOVE.L  #$40000010,(A5)                 ; $001D1C
        MOVE.W  (-14208).W,(A6)                 ; $001D22
        MOVE.W  (-14206).W,(A6)                 ; $001D26
        MOVE.W  #$0100,$00A11100                ; $001D2A
.loc_0026:
        BTST    #0,$00A11100                    ; $001D32
        BNE.S  .loc_0026                        ; $001D3A
        MOVE.W  (-14220).W,D4                   ; $001D3C
        BSET    #4,D4                           ; $001D40
        MOVE.W  D4,(A5)                         ; $001D44
        MOVE.L  #$93409400,(A5)                 ; $001D46
        MOVE.L  #$954096C2,(A5)                 ; $001D4C
        MOVE.W  #$977F,(A5)                     ; $001D52
        MOVE.W  #$C000,(A5)                     ; $001D56
        MOVE.W  #$0080,(-14218).W               ; $001D5A
        MOVE.W  (-14218).W,(A5)                 ; $001D60
        MOVE.W  (-14220).W,(A5)                 ; $001D64
        MOVE.W  #$0000,$00A11100                ; $001D68
        BTST    #0,$00A15123                    ; $001D70
        BEQ.S  .loc_00B0                        ; $001D78
        BCLR    #0,$00A15123                    ; $001D7A
        MOVE.W  #$0000,(-14210).W               ; $001D82
        BCLR    #7,$00A15100                    ; $001D88
.loc_0084:
        BTST    #7,$00A1518A                    ; $001D90
        BEQ.S  .loc_0084                        ; $001D98
        BCHG    #0,(-14324).W                   ; $001D9A
        BNE.S  .loc_00A0                        ; $001DA0
        BSET    #0,$00A1518B                    ; $001DA2
        BRA.S  .loc_00A8                        ; $001DAA
.loc_00A0:
        BCLR    #0,$00A1518B                    ; $001DAC
.loc_00A8:
        BSET    #7,$00A15100                    ; $001DB4
.loc_00B0:
        RTS                                     ; $001DBC
