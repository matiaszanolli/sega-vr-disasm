; ============================================================================
; Util Menu State Check 045 (auto-analyzed)
; ROM Range: $0144D0-$0144F2 (34 bytes)
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

fn_14200_045:
        LEA     $009286AE,A1                    ; $0144D0
        MOVE.L  #$00009A00,D1                   ; $0144D6
        DC.W    $4EBA,$0112         ; JSR     $0145F0(PC); $0144DC
        TST.W  (-24568).W                       ; $0144E0
        BNE.S  .loc_0020                        ; $0144E4
        ADDQ.W  #4,(-16254).W                   ; $0144E6
        MOVE.W  #$0801,(-24568).W               ; $0144EA
.loc_0020:
        RTS                                     ; $0144F0
