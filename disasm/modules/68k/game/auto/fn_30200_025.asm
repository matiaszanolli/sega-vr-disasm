; ============================================================================
; Fm 025 (auto-analyzed)
; ROM Range: $030C8A-$030CA2 (24 bytes)
; ============================================================================
; Category: sound
; Purpose: Short helper function
;   Object (A5): +$01
;
; Entry: A5 = object/entity pointer
; Uses: D0, D1, A5
; Object fields:
;   +$01: [unknown]
; Confidence: low
; ============================================================================

fn_30200_025:
        BTST    #4,(A5)                         ; $030C8A
        BNE.S  .loc_0016                        ; $030C8E
        BTST    #2,(A5)                         ; $030C90
        BNE.S  .loc_0016                        ; $030C94
        MOVEQ   #$28,D0                         ; $030C96
        MOVE.B  $0001(A5),D1                    ; $030C98
        DC.W    $6000,$001C         ; BRA.W  $030CBA; $030C9C
.loc_0016:
        RTS                                     ; $030CA0
