; ============================================================================
; Util Menu State Check 047 (auto-analyzed)
; ROM Range: $014518-$014540 (40 bytes)
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

fn_14200_047:
        LEA     $00929CA6,A1                    ; $014518
        MOVE.L  #$00002000,D1                   ; $01451E
        DC.W    $4EBA,$00CA         ; JSR     $0145F0(PC); $014524
        SUBQ.W  #1,(-24570).W                   ; $014528
        BGT.S  .loc_0026                        ; $01452C
        ADDQ.W  #4,(-16254).W                   ; $01452E
        MOVE.B  #$F0,(-14302).W                 ; $014532
        MOVE.W  #$0802,(-24568).W               ; $014538
.loc_0026:
        RTS                                     ; $01453E
