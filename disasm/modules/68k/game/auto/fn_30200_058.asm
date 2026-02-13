; ============================================================================
; Sequence Call/Return Stack — push/pop sequence pointer
; ROM Range: $031528-$03154E (38 bytes)
; ============================================================================
; Two entry points:
;   $031528 (call): Reads stack pointer from A5+$0D, decrements by 4,
;     pushes current A4 to stack at A5+offset. Updates stack pointer.
;     Branches to $031502 to continue with new sequence address.
;   $03153A (return): Reads stack pointer, pops A4 from stack, skips
;     2 bytes (past original call operand), increments stack pointer by 4.
; Stack grows downward in channel structure.
;
; Entry: A5 = channel structure pointer, A4 = sequence pointer
; Uses: D0, A4
; Confidence: medium
; ============================================================================

fn_30200_058:
        MOVEQ   #$00,D0                         ; $031528
        MOVE.B  $000D(A5),D0                    ; $03152A
        SUBQ.B  #4,D0                           ; $03152E
        MOVE.L  A4,$00(A5,D0.W)                 ; $031530
        MOVE.B  D0,$000D(A5)                    ; $031534
        DC.W    $60C8               ; BRA.S  $031502; $031538
        MOVEQ   #$00,D0                         ; $03153A
        MOVE.B  $000D(A5),D0                    ; $03153C
        MOVEA.L $00(A5,D0.W),A4                 ; $031540
        ADDQ.W  #2,A4                           ; $031544
        ADDQ.B  #4,D0                           ; $031546
        MOVE.B  D0,$000D(A5)                    ; $031548
        RTS                                     ; $03154C
