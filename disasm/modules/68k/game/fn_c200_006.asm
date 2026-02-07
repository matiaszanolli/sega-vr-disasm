; ============================================================================
; Scene Dispatch 006 (auto-analyzed)
; ROM Range: $00C44C-$00C4A4 (88 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;
; Uses: D0, D2, A1, A2, A4, A6
; Confidence: low
; ============================================================================

fn_c200_006:
        DC.W    $0089                           ; $00C44C
        BTST    D0,(A7)                         ; $00C44E
        BCHG    D0,$01E0(A2)                    ; $00C450
        ANDI.W  #$02E2,(A6)+                    ; $00C454
        DC.W    $034D                           ; $00C458
        MOVE.B  D0,D0                           ; $00C45A
        MOVE.B  D0,D0                           ; $00C45C
        JSR     $008821CA                       ; $00C45E
        MOVEQ   #$00,D0                         ; $00C464
        MOVE.B  (-14140).W,D0                   ; $00C466
        MOVEA.L $00C470(PC,D0.W),A1             ; $00C46A
        JMP     (A1)                            ; $00C46E
        DC.W    $0088                           ; $00C470
        DC.W    $C480                           ; $00C472
        DC.W    $0088                           ; $00C474
        AND.L  -(A4),D2                         ; $00C476
        DC.W    $0088                           ; $00C478
        MULU    D2,D2                           ; $00C47A
        DC.W    $0088                           ; $00C47C
        DC.W    $C53C                           ; $00C47E
        JSR     $008828C2                       ; $00C480
        JSR     $008825B0                       ; $00C486
        JSR     $00886D9C                       ; $00C48C
        ADDQ.B  #1,(-14202).W                   ; $00C492
        ADDQ.B  #4,(-14140).W                   ; $00C496
        MOVE.W  #$0010,$00FF0008                ; $00C49A
        RTS                                     ; $00C4A2
