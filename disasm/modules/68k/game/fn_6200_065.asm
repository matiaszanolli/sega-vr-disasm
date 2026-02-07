; ============================================================================
; Obj 065 (auto-analyzed)
; ROM Range: $008004-$008032 (46 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A0): +$02 (flags/type), +$24, +$28, +$2C, +$2E
;
; Entry: A0 = object/entity pointer
; Uses: D0, A0
; Object fields:
;   +$02: flags/type
;   +$24: [unknown]
;   +$28: [unknown]
;   +$2C: [unknown]
;   +$2E: [unknown]
; Confidence: low
; ============================================================================

fn_6200_065:
        MOVE.W  $002C(A0),D0                    ; $008004
        CMP.W  $002E(A0),D0                     ; $008008
        BNE.S  .loc_002C                        ; $00800C
        MOVE.W  $0024(A0),D0                    ; $00800E
        CMP.W  $0028(A0),D0                     ; $008012
        BLE.S  .loc_002C                        ; $008016
        MOVE.W  $0024(A0),$0028(A0)             ; $008018
        TST.B  (-15591).W                       ; $00801E
        BPL.S  .loc_002C                        ; $008022
        ORI.W  #$4000,$0002(A0)                 ; $008024
        MOVE.W  #$0050,(-16306).W               ; $00802A
.loc_002C:
        RTS                                     ; $008030
