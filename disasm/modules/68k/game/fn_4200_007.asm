; ============================================================================
; Input Dispatch 007 (auto-analyzed)
; ROM Range: $00456C-$0045CE (98 bytes)
; ============================================================================
; Category: input
; Purpose: State dispatcher using jump table
;   RAM: $C07C (input_state)
;   Object (A2, A6): +$02 (flags/type), +$04 (speed_index/velocity), +$08, +$78
;
; Entry: A2 = object/entity pointer
; Entry: A6 = object/entity pointer
; Uses: D0, A0, A1, A2, A6
; RAM:
;   $C07C: input_state
; Object fields:
;   +$02: flags/type
;   +$04: speed_index/velocity
;   +$08: [unknown]
;   +$78: [unknown]
; Confidence: medium
; ============================================================================

fn_4200_007:
        MOVEQ   #$00,D0                         ; $00456C
        MOVE.B  (-14311).W,D0                   ; $00456E
        LSL.W  #2,D0                            ; $004572
        MOVEA.L $00457A(PC,D0.W),A1             ; $004574
        JMP     (A1)                            ; $004578
        DC.W    $0088                           ; $00457A
        NOT.B  -$78(A6,D0.W)                    ; $00457C
        DC.W    $458A                           ; $004580
        DC.W    $0088                           ; $004582
        DC.W    $45CE                           ; $004584
        DC.W    $0088                           ; $004586
        DC.W    $4630                           ; $004588
        LEA     $00FF69E0,A2                    ; $00458A
        MOVE.B  #$07,(A2)                       ; $004590
        MOVE.W  #$01AE,$0002(A2)                ; $004594
        MOVE.L  #$222EDB1A,$0008(A2)            ; $00459A
        MOVE.B  #$00,(-14314).W                 ; $0045A2
        MOVE.L  #$0402C000,$0004(A2)            ; $0045A8
        CMPA.W  #$9000,A0                       ; $0045B0
        BEQ.S  .loc_0058                        ; $0045B4
        MOVE.B  #$01,(-14314).W                 ; $0045B6
        MOVE.L  #$04038000,$0004(A2)            ; $0045BC
.loc_0058:
        ADDQ.B  #1,(-14311).W                   ; $0045C4
        ADDQ.W  #4,(-16260).W                   ; $0045C8
        RTS                                     ; $0045CC
