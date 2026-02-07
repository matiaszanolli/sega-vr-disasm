; ============================================================================
; Display Camera 041 (auto-analyzed)
; ROM Range: $009B54-$009B82 (46 bytes)
; ============================================================================
; Category: display
; Purpose: RAM: $C048 (camera_state)
;
; Uses: D0
; RAM:
;   $C048: camera_state
; Confidence: medium
; ============================================================================

fn_8200_041:
        MOVEQ   #-$01,D0                        ; $009B54
        MOVE.W  D0,(-16372).W                   ; $009B56
        MOVE.W  D0,(-16360).W                   ; $009B5A
        MOVE.W  D0,(-16366).W                   ; $009B5E
        TST.W  $00FF6114                        ; $009B62
        BEQ.S  .loc_001C                        ; $009B68
        TST.W  (-16312).W                       ; $009B6A
        DC.W    $6612               ; BNE.S  $009B82; $009B6E
.loc_001C:
        MOVE.W  D0,(-16354).W                   ; $009B70
        MOVE.W  D0,(-16348).W                   ; $009B74
        MOVE.W  D0,(-16370).W                   ; $009B78
        MOVE.W  D0,(-16368).W                   ; $009B7C
        RTS                                     ; $009B80
