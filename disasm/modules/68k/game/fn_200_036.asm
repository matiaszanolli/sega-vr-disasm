; ============================================================================
; Sh2 Comm Paletteramcopy 036 (auto-analyzed)
; ROM Range: $001C66-$001D0C (166 bytes)
; ============================================================================
; Category: sh2
; Purpose: Accesses 32X registers: COMM0, adapter_ctrl
;   Calls: PaletteRAMCopy
;
; Uses: D0, D4, A5, A6
; Calls:
;   $002878: PaletteRAMCopy
; Confidence: high
; ============================================================================

fn_200_036:
        MOVE.W  (A5),D0                         ; $001C66
        MOVE.L  #$6C000003,(A5)                 ; $001C68
        MOVE.W  (-32768).W,(A6)                 ; $001C6E
        MOVE.W  (-32766).W,(A6)                 ; $001C72
        MOVE.L  #$40000010,(A5)                 ; $001C76
        MOVE.W  (-14208).W,(A6)                 ; $001C7C
        MOVE.W  (-14206).W,(A6)                 ; $001C80
        MOVE.W  #$0100,$00A11100                ; $001C84
.loc_0026:
        BTST    #0,$00A11100                    ; $001C8C
        BNE.S  .loc_0026                        ; $001C94
        MOVE.W  (-14220).W,D4                   ; $001C96
        BSET    #4,D4                           ; $001C9A
        MOVE.W  D4,(A5)                         ; $001C9E
        MOVE.L  #$93409400,(A5)                 ; $001CA0
        MOVE.L  #$954096C2,(A5)                 ; $001CA6
        MOVE.W  #$977F,(A5)                     ; $001CAC
        MOVE.W  #$C000,(A5)                     ; $001CB0
        MOVE.W  #$0080,(-14218).W               ; $001CB4
        MOVE.W  (-14218).W,(A5)                 ; $001CBA
        MOVE.W  (-14220).W,(A5)                 ; $001CBE
        MOVE.W  #$0000,$00A11100                ; $001CC2
        TST.B  $00A15120                        ; $001CCA
        BNE.S  .loc_00A4                        ; $001CD0
        BCLR    #7,$00A15100                    ; $001CD2
.loc_0074:
        BTST    #7,$00A1518A                    ; $001CDA
        BEQ.S  .loc_0074                        ; $001CE2
        DC.W    $4EBA,$0B92         ; JSR     $002878(PC); $001CE4
        BCHG    #0,(-14324).W                   ; $001CE8
        BNE.S  .loc_0094                        ; $001CEE
        BSET    #0,$00A1518B                    ; $001CF0
        BRA.S  .loc_009C                        ; $001CF8
.loc_0094:
        BCLR    #0,$00A1518B                    ; $001CFA
.loc_009C:
        BSET    #7,$00A15100                    ; $001D02
.loc_00A4:
        RTS                                     ; $001D0A
