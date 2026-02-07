; ============================================================================
; Sh2 Comm Game 038 (auto-analyzed)
; ROM Range: $001DBE-$001E42 (132 bytes)
; ============================================================================
; Category: sh2
; Purpose: Accesses 32X registers: adapter_ctrl
;   RAM: $C87E (game_state)
;
; Uses: D0, D7, A5, A6
; RAM:
;   $C87E: game_state
; Confidence: high
; ============================================================================

fn_200_038:
        MOVE.W  (A5),D0                         ; $001DBE
        MOVE.W  #$0063,D7                       ; $001DC0
.loc_0006:
        NOP                                     ; $001DC4
        DBRA    D7,.loc_0006                    ; $001DC6
        MOVE.L  #$6C000003,(A5)                 ; $001DCA
        MOVE.W  (-32768).W,(A6)                 ; $001DD0
        MOVE.W  (-32766).W,(A6)                 ; $001DD4
        MOVE.L  #$40000010,(A5)                 ; $001DD8
        MOVE.W  (-14208).W,(A6)                 ; $001DDE
        MOVE.W  (-14206).W,(A6)                 ; $001DE2
        BTST    #0,$00A15123                    ; $001DE6
        BEQ.S  .loc_0082                        ; $001DEE
        BCLR    #0,$00A15123                    ; $001DF0
        CMPI.B  #$18,(-14139).W                 ; $001DF8
        BNE.S  .loc_0048                        ; $001DFE
        MOVE.W  #$0000,(-14210).W               ; $001E00
.loc_0048:
        MOVE.B  #$00,(-14140).W                 ; $001E06
        BCLR    #7,$00A15100                    ; $001E0C
.loc_0056:
        BTST    #7,$00A1518A                    ; $001E14
        BEQ.S  .loc_0056                        ; $001E1C
        BCHG    #0,(-14324).W                   ; $001E1E
        BNE.S  .loc_0072                        ; $001E24
        BSET    #0,$00A1518B                    ; $001E26
        BRA.S  .loc_007A                        ; $001E2E
.loc_0072:
        BCLR    #0,$00A1518B                    ; $001E30
.loc_007A:
        BSET    #7,$00A15100                    ; $001E38
.loc_0082:
        RTS                                     ; $001E40
