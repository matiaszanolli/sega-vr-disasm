; ============================================================================
; Obj 064 (auto-analyzed)
; ROM Range: $007FEE-$008004 (22 bytes)
; ============================================================================
; Category: game
; Purpose: Short helper function
;   Object (A0): +$1C, +$2D
;
; Entry: A0 = object/entity pointer
; Uses: D0, A0
; Object fields:
;   +$1C: [unknown]
;   +$2D: [unknown]
; Confidence: low
; ============================================================================

fn_6200_064:
        CMP.B  $002D(A0),D0                     ; $007FEE
        BNE.S  .loc_0014                        ; $007FF2
        CMPI.W  #$0064,$001C(A0)                ; $007FF4
        BCC.S  .loc_0014                        ; $007FFA
        MOVE.B  #$BE,(-14172).W                 ; $007FFC
.loc_0014:
        RTS                                     ; $008002
