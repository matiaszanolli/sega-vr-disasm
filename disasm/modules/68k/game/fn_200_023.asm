; ============================================================================
; Init Dispatch 023 (auto-analyzed)
; ROM Range: $0014E0-$00154E (110 bytes)
; ============================================================================
; Category: boot
; Purpose: State dispatcher using jump table
;   Object (A5): +$00
;
; Entry: A5 = object/entity pointer
; Uses: D0, D1, D2, D6, A0, A2, A4, A5
; Object fields:
;   +$00: [unknown]
; Confidence: low
; ============================================================================

fn_200_023:
        NEGX.B D0                               ; $0014E0
        ORI.B  #$00,D0                          ; $0014E2
        DC.W    $0000                           ; $0014E6
        CLR.B  -(A0)                            ; $0014E8
        ORI.B  #$92,D0                          ; $0014EA
        DC.W    $AC0C                           ; $0014EE
        CLR.B  -(A0)                            ; $0014F0
        ORI.B  #$92,D0                          ; $0014F2
        DC.W    $ACCC                           ; $0014F6
        CLR.B  -(A0)                            ; $0014F8
        ORI.B  #$92,D0                          ; $0014FA
        DC.W    $AD78                           ; $0014FE
        NEGX.B D0                               ; $001500
        ORI.B  #$00,D0                          ; $001502
        DC.W    $0000                           ; $001506
        NEGX.B D0                               ; $001508
        ORI.B  #$00,D0                          ; $00150A
        DC.W    $0000                           ; $00150E
        NEGX.B -(A0)                            ; $001510
        ORI.B  #$8B,D0                          ; $001512
        DC.W    $F000                           ; $001516
        CLR.B  -(A0)                            ; $001518
        ORI.B  #$90,D0                          ; $00151A
        MOVE.W  A6,$00(A5,D6.W)                 ; $00151E
        ORI.B  #$90,D0                          ; $001522
        ROR.W  (A2)+                            ; $001526
        ADDQ.B  #7,D0                           ; $001528
        ORI.B  #$90,D1                          ; $00152A
        LSL.L  #2,D6                            ; $00152E
        MOVEQ   #$03,D2                         ; $001530
.loc_0052:
        MOVEQ   #$00,D1                         ; $001532
        MOVE.B  D0,D1                           ; $001534
        BEQ.S  .loc_0066                        ; $001536
        LSL.W  #3,D1                            ; $001538
        MOVEA.L $001546(PC,D1.W),A0             ; $00153A
        MOVEA.L $00154A(PC,D1.W),A4             ; $00153E
        DC.W    $4EBA,$FBC2         ; JSR     $001106(PC); $001542
.loc_0066:
        ROR.L  #8,D0                            ; $001546
        DBRA    D2,.loc_0052                    ; $001548
        RTS                                     ; $00154C
