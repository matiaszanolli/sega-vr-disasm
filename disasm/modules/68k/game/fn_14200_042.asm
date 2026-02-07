; ============================================================================
; Util Dispatch 042 (auto-analyzed)
; ROM Range: $01440E-$01446C (94 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   RAM: $C082 (menu_state), $C084 (menu_substate)
;   Calls: menu_state_check
;   Object (A0, A2, A4): +$77, +$89
;
; Entry: A0 = object/entity pointer
; Entry: A2 = object/entity pointer
; Entry: A4 = object/entity pointer
; Uses: D0, D1, A0, A1, A2, A4
; RAM:
;   $C082: menu_state
;   $C084: menu_substate
; Calls:
;   $0145F0: menu_state_check
; Object fields:
;   +$77: [unknown]
;   +$89: [unknown]
; Confidence: high
; ============================================================================

fn_14200_042:
        MOVE.W  (-16254).W,D0                   ; $01440E
        MOVEA.L $014418(PC,D0.W),A1             ; $014412
        JMP     (A1)                            ; $014416
        DC.W    $0089                           ; $014418
        NEG.B  ($0089).W                        ; $01441A
        NEG.W  (A0)                             ; $01441E
        DC.W    $0089                           ; $014420
        NEG.W  $0089(A4)                        ; $014422
        NEG.L  $0089(A0)                        ; $014426
        MOVE    (A0),CCR                        ; $01442A
        DC.W    $0089                           ; $01442C
        MOVE    -$77(A2,D0.W),CCR               ; $01442E
        DC.W    $4518                           ; $014432
        DC.W    $0089                           ; $014434
        DC.W    $4540                           ; $014436
        CLR.W  (-16252).W                       ; $014438
        CLR.W  (-24568).W                       ; $01443C
        ADDQ.W  #4,(-16254).W                   ; $014440
        MOVE.W  #$001E,(-24570).W               ; $014444
        MOVE.W  #$0801,(-24568).W               ; $01444A
        LEA     $0090E732,A1                    ; $014450
        MOVE.L  #$00009A00,D1                   ; $014456
        DC.W    $4EBA,$0192         ; JSR     $0145F0(PC); $01445C
        SUBQ.W  #1,(-24570).W                   ; $014460
        BGT.S  .loc_005C                        ; $014464
        ADDQ.W  #4,(-16254).W                   ; $014466
.loc_005C:
        RTS                                     ; $01446A
