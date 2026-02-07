; ============================================================================
; Util Menu State Check 046 (auto-analyzed)
; ROM Range: $0144F2-$014518 (38 bytes)
; ============================================================================
; Category: game
; Purpose: Short helper function
;   RAM: $C082 (menu_state)
;   Calls: menu_state_check
;
; Uses: D1, A1
; RAM:
;   $C082: menu_state
; Calls:
;   $0145F0: menu_state_check
; Confidence: medium
; ============================================================================

fn_14200_046:
        LEA     $00929CA6,A1                    ; $0144F2
        MOVE.L  #$00002000,D1                   ; $0144F8
        DC.W    $4EBA,$00F0         ; JSR     $0145F0(PC); $0144FE
        TST.W  (-24568).W                       ; $014502
        BNE.S  .loc_0024                        ; $014506
        CLR.W  (-24568).W                       ; $014508
        ADDQ.W  #4,(-16254).W                   ; $01450C
        MOVE.W  #$0014,(-24570).W               ; $014510
.loc_0024:
        RTS                                     ; $014516
