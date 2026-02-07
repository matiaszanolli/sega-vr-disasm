; ============================================================================
; Fm 029 (auto-analyzed)
; ROM Range: $030CF4-$030D1C (40 bytes)
; ============================================================================
; Category: sound
; Purpose: Short helper function
;   Object (A0, A5): +$01, +$02 (flags/type), +$03
;
; Entry: A0 = object/entity pointer
; Entry: A5 = object/entity pointer
; Uses: D0, D1, D2, A0, A5
; Object fields:
;   +$01: [unknown]
;   +$02: flags/type
;   +$03: [unknown]
; Confidence: low
; ============================================================================

fn_30200_029:
        MOVE.B  $0001(A5),D2                    ; $030CF4
        BCLR    #2,D2                           ; $030CF8
        DC.W    $D002                           ; $030CFC
        LEA     $00A04000,A0                    ; $030CFE
.loc_0010:
        BTST    #7,(A0)                         ; $030D04
        BNE.S  .loc_0010                        ; $030D08
        MOVE.B  D0,$0002(A0)                    ; $030D0A
        NOP                                     ; $030D0E
.loc_001C:
        BTST    #7,(A0)                         ; $030D10
        BNE.S  .loc_001C                        ; $030D14
        MOVE.B  D1,$0003(A0)                    ; $030D16
        RTS                                     ; $030D1A
