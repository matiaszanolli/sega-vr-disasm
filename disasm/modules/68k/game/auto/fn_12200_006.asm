; ============================================================================
; Camera 006 (auto-analyzed)
; ROM Range: $012F9C-$012FE4 (72 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A3): +$39
;
; Entry: A3 = object/entity pointer
; Uses: D0, D1, D2, D3, D4, D5, D6, A3
; Object fields:
;   +$39: [unknown]
; Confidence: low
; ============================================================================

fn_12200_006:
        DC.W    $0401                           ; $012F9C
        NEGX.B (A4)                             ; $012F9E
        DC.W    $0039                           ; $012FA0
        DC.W    $0401                           ; $012FA2
        DC.W    $404C                           ; $012FA4
        DC.W    $0038                           ; $012FA6
        DC.W    $0401                           ; $012FA8
        NEGX.L D3                               ; $012FAA
        DC.W    $0039                           ; $012FAC
        DC.W    $0401                           ; $012FAE
        DC.W    $40BB                           ; $012FB0
        DC.W    $0039                           ; $012FB2
        DC.W    $0401                           ; $012FB4
        MOVE    SR,$39(A3,D0.W)                 ; $012FB6
        DC.W    $0401                           ; $012FBA
        MOVE    SR,$39(A3,D0.W)                 ; $012FBC
        MOVE.W  #$0100,D4                       ; $012FC0
.loc_0028:
        MOVE.W  D0,D6                           ; $012FC4
        BCLR    #15,D6                          ; $012FC6
        BSET    #14,D6                          ; $012FCA
        MOVE.W  D6,(A5)                         ; $012FCE
        MOVE.W  #$0003,(A5)                     ; $012FD0
        MOVE.W  D1,D5                           ; $012FD4
.loc_003A:
        MOVE.W  D3,(A6)                         ; $012FD6
        DBRA    D5,.loc_003A                    ; $012FD8
        DC.W    $D084                           ; $012FDC
        DBRA    D2,.loc_0028                    ; $012FDE
        RTS                                     ; $012FE2
