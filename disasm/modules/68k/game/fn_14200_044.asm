; ============================================================================
; Util Menu State Check 044 (auto-analyzed)
; ROM Range: $0144A8-$0144D0 (40 bytes)
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

fn_14200_044:
        LEA     $009286AE,A1                    ; $0144A8
        MOVE.L  #$00009A00,D1                   ; $0144AE
        DC.W    $4EBA,$013A         ; JSR     $0145F0(PC); $0144B4
        SUBQ.W  #1,(-24570).W                   ; $0144B8
        BGT.S  .loc_0026                        ; $0144BC
        ADDQ.W  #4,(-16254).W                   ; $0144BE
        MOVE.B  #$F0,(-14302).W                 ; $0144C2
        MOVE.W  #$0802,(-24568).W               ; $0144C8
.loc_0026:
        RTS                                     ; $0144CE
