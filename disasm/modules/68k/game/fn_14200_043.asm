; ============================================================================
; Util Menu State Check 043 (auto-analyzed)
; ROM Range: $01446C-$0144A8 (60 bytes)
; ============================================================================
; Category: game
; Purpose: RAM: $C084 (menu_substate), $C082 (menu_state)
;   Calls: menu_state_check
;   Object (A0): +$00
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, A0, A1
; RAM:
;   $C082: menu_state
;   $C084: menu_substate
; Calls:
;   $0145F0: menu_state_check
; Object fields:
;   +$00: [unknown]
; Confidence: high
; ============================================================================

fn_14200_043:
        DC.W    $4EBA,$00F8         ; JSR     $014566(PC); $01446C
        BEQ.S  .loc_000C                        ; $014470
        MOVE.W  #$000F,(-16252).W               ; $014472
.loc_000C:
        DC.W    $41FA,$01B0         ; LEA     $01462A(PC),A0; $014478
        MOVE.W  (-16252).W,D0                   ; $01447C
        ASL.W  #2,D0                            ; $014480
        MOVEA.L $00(A0,D0.W),A1                 ; $014482
        MOVE.L  #$00009A00,D1                   ; $014486
        DC.W    $4EBA,$0162         ; JSR     $0145F0(PC); $01448C
        ADDQ.W  #1,(-16252).W                   ; $014490
        CMPI.W  #$000F,(-16252).W               ; $014494
        BLE.S  .loc_003A                        ; $01449A
        ADDQ.W  #4,(-16254).W                   ; $01449C
        MOVE.W  #$0028,(-24570).W               ; $0144A0
.loc_003A:
        RTS                                     ; $0144A6
