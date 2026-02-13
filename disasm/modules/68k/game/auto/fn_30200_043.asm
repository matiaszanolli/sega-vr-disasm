; ============================================================================
; FM Set Panning — write panning register from sequence byte
; ROM Range: $0311B8-$0311D8 (32 bytes)
; ============================================================================
; Reads panning value from sequence (A4). If FM channel (positive A5+$01):
; merges with existing panning (A5+$27 AND $37, OR new value), stores
; result, writes register $B4 via fm_conditional_write ($030CA2).
; If PSG channel (negative): returns without action.
;
; Entry: A5 = channel structure pointer, A4 = sequence pointer
; Uses: D0, D1, A4
; Confidence: high
; ============================================================================

fn_30200_043:
        MOVE.B  (A4)+,D1                        ; $0311B8
        TST.B  $0001(A5)                        ; $0311BA
        BMI.S  .loc_001E                        ; $0311BE
        MOVE.B  $0027(A5),D0                    ; $0311C0
        ANDI.B  #$37,D0                         ; $0311C4
        OR.B    D0,D1                           ; $0311C8
        MOVE.B  D1,$0027(A5)                    ; $0311CA
        MOVE.B  #$B4,D0                         ; $0311CE
        DC.W    $6000,$FACE         ; BRA.W  $030CA2; $0311D2
.loc_001E:
        RTS                                     ; $0311D6
