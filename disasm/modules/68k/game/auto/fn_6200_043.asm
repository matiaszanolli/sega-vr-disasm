; ============================================================================
; Obj Render 043 (auto-analyzed)
; ROM Range: $007AB2-$007AD6 (36 bytes)
; ============================================================================
; Category: game
; Purpose: Short helper function
;   Object (A0): +$32, +$C0 (render_flags), +$C6, +$C8
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, A0
; Object fields:
;   +$32: [unknown]
;   +$C0: render_flags
;   +$C6: [unknown]
;   +$C8: [unknown]
; Confidence: low
; ============================================================================

fn_6200_043:
        DIVU    #$0000,D0                       ; $007AB2
        BTST    #7,$00C0(A0)                    ; $007AB6
        DC.W    $6618               ; BNE.S  $007AD6; $007ABC
        DC.W    $4EBA,$00EC         ; JSR     $007BAC(PC); $007ABE
        MOVE.W  $0032(A0),D1                    ; $007AC2
        MOVE.W  D1,$00C6(A0)                    ; $007AC6
        MOVE.W  D1,$00C8(A0)                    ; $007ACA
        ADDQ.B  #1,$00FF5FFE                    ; $007ACE
        RTS                                     ; $007AD4
