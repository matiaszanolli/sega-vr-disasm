; ============================================================================
; Obj 068 (auto-analyzed)
; ROM Range: $0080AE-$0080CC (30 bytes)
; ============================================================================
; Category: game
; Purpose: Short helper function
;   Object (A0): +$2D
;
; Entry: A0 = object/entity pointer
; Uses: D0, A0
; Object fields:
;   +$2D: [unknown]
; Confidence: low
; ============================================================================

fn_6200_068:
        CMP.B  $002D(A0),D0                     ; $0080AE
        BNE.S  .loc_001C                        ; $0080B2
        MOVE.W  (-16242).W,D0                   ; $0080B4
        CMP.W  (-16262).W,D0                    ; $0080B8
        BEQ.S  .loc_001C                        ; $0080BC
        TST.B  (-14311).W                       ; $0080BE
        BNE.S  .loc_001C                        ; $0080C2
        MOVE.B  #$BE,(-14172).W                 ; $0080C4
.loc_001C:
        RTS                                     ; $0080CA
