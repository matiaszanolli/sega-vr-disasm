; ============================================================================
; Fm 019 (auto-analyzed)
; ROM Range: $030A5C-$030A72 (22 bytes)
; ============================================================================
; Category: sound
; Purpose: Short helper function
;   Object (A6): +$04 (speed_index/velocity), +$06 (speed)
;
; Entry: A6 = object/entity pointer
; Uses: A6
; Object fields:
;   +$04: speed_index/velocity
;   +$06: speed
; Confidence: low
; ============================================================================

fn_30200_019:
        DC.W    $4EBA,$FEF0         ; JSR     $03094E(PC); $030A5C
        DC.W    $4EBA,$FF90         ; JSR     $0309F2(PC); $030A60
        MOVE.B  #$01,$0006(A6)                  ; $030A64
        MOVE.B  #$05,$0004(A6)                  ; $030A6A
        RTS                                     ; $030A70
