; ============================================================================
; Fm 028 (auto-analyzed)
; ROM Range: $030CCC-$030CF4 (40 bytes)
; ============================================================================
; Category: sound
; Purpose: Short helper function
;   Object (A0, A5): +$01
;
; Entry: A0 = object/entity pointer
; Entry: A5 = object/entity pointer
; Uses: D0, D1, A0, A5
; Object fields:
;   +$01: [unknown]
; Confidence: low
; ============================================================================

fn_30200_028:
        BTST    #2,$0001(A5)                    ; $030CCC
        DC.W    $6620               ; BNE.S  $030CF4; $030CD2
        ADD.B  $0001(A5),D0                     ; $030CD4
        LEA     $00A04000,A0                    ; $030CD8
.loc_0012:
        BTST    #7,(A0)                         ; $030CDE
        BNE.S  .loc_0012                        ; $030CE2
        MOVE.B  D0,(A0)                         ; $030CE4
        NOP                                     ; $030CE6
.loc_001C:
        BTST    #7,(A0)                         ; $030CE8
        BNE.S  .loc_001C                        ; $030CEC
        MOVE.B  D1,$0001(A0)                    ; $030CEE
        RTS                                     ; $030CF2
