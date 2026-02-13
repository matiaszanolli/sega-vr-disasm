; ============================================================================
; Write Panning + PSG Volume Adjust — two sequence command handlers
; ROM Range: $03120C-$031228 (28 bytes)
; ============================================================================
; Two entry points:
;   $03120C: Writes current panning value (A5+$27) to register $B4 via
;     fm_conditional_write ($030CA2).
;   $031218: Reads byte from sequence. If PSG (negative A5+$01): adds
;     value to volume (A5+$09), skips next byte. If FM: returns.
;
; Entry: A5 = channel structure pointer, A4 = sequence pointer
; Uses: D0, D1, A4
; Confidence: medium
; ============================================================================

fn_30200_046:
        MOVE.B  #$B4,D0                         ; $03120C
        MOVE.B  $0027(A5),D1                    ; $031210
        DC.W    $6000,$FA8C         ; BRA.W  $030CA2; $031214
        MOVE.B  (A4)+,D0                        ; $031218
        TST.B  $0001(A5)                        ; $03121A
        DC.W    $6A08               ; BPL.S  $031228; $03121E
        ADD.B  D0,$0009(A5)                     ; $031220
        ADDQ.W  #1,A4                           ; $031224
        RTS                                     ; $031226
