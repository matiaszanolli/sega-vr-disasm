; ============================================================================
; Input 066 (auto-analyzed)
; ROM Range: $008032-$008054 (34 bytes)
; ============================================================================
; Category: input
; Purpose: Short helper function
;   RAM: $C07C (input_state)
;   Object (A0): +$24, +$26, +$2C, +$2E
;
; Entry: A0 = object/entity pointer
; Uses: D0, A0
; RAM:
;   $C07C: input_state
; Object fields:
;   +$24: [unknown]
;   +$26: [unknown]
;   +$2C: [unknown]
;   +$2E: [unknown]
; Confidence: medium
; ============================================================================

fn_6200_066:
        TST.W  (-16260).W                       ; $008032
        BNE.S  .loc_0020                        ; $008036
        CMPI.W  #$0014,$002C(A0)                ; $008038
        BGE.S  .loc_0020                        ; $00803E
        MOVE.W  $0024(A0),D0                    ; $008040
        SUB.W  $0026(A0),D0                     ; $008044
        CMPI.W  #$0064,D0                       ; $008048
        DC.W    $6F06               ; BLE.S  $008054; $00804C
        SUBQ.W  #1,$002E(A0)                    ; $00804E
.loc_0020:
        RTS                                     ; $008052
