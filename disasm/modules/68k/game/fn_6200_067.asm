; ============================================================================
; Obj Scene 067 (auto-analyzed)
; ROM Range: $008054-$0080AE (90 bytes)
; ============================================================================
; Category: game
; Purpose: RAM: $C8AA (scene_state)
;   Object (A0): +$02 (flags/type), +$08, +$28, +$2C, +$2D, +$2E
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, A0
; RAM:
;   $C8AA: scene_state
; Object fields:
;   +$02: flags/type
;   +$08: [unknown]
;   +$28: [unknown]
;   +$2C: [unknown]
;   +$2D: [unknown]
;   +$2E: [unknown]
; Confidence: medium
; ============================================================================

fn_6200_067:
        CMPI.W  #$FF9C,D0                       ; $008054
        DC.W    $6CAA               ; BGE.S  $008004; $008058
        ADDQ.W  #1,$002E(A0)                    ; $00805A
        MOVE.W  #$0497,$0008(A0)                ; $00805E
        MOVE.W  $002C(A0),D1                    ; $008064
        ADDQ.W  #1,D1                           ; $008068
        CMP.W  $002E(A0),D1                     ; $00806A
        BNE.S  .loc_0058                        ; $00806E
        MOVE.B  #$04,(-15611).W                 ; $008070
        ADDQ.W  #1,$002C(A0)                    ; $008076
        CLR.W  $0028(A0)                        ; $00807A
        ORI.W  #$4000,$0002(A0)                 ; $00807E
        MOVE.W  #$0050,(-16306).W               ; $008084
        CLR.W  (-14166).W                       ; $00808A
        MOVE.B  (-15600).W,D0                   ; $00808E
        SUBQ.B  #1,D0                           ; $008092
        CMP.B  $002D(A0),D0                     ; $008094
        DC.W    $6C14               ; BGE.S  $0080AE; $008098
        ANDI.W  #$BFFF,$0002(A0)                ; $00809A
        MOVE.W  #$0000,(-16306).W               ; $0080A0
        BSET    #5,(-15602).W                   ; $0080A6
.loc_0058:
        RTS                                     ; $0080AC
