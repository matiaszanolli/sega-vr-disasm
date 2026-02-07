; ============================================================================
; Init Dispatch 025 (auto-analyzed)
; ROM Range: $001586-$001610 (138 bytes)
; ============================================================================
; Category: boot
; Purpose: State dispatcher using jump table
;   Calls: bit_unpack_loop
;   Object (A1, A2, A4): +$01, +$FF
;
; Entry: A1 = object/entity pointer
; Entry: A2 = object/entity pointer
; Entry: A4 = object/entity pointer
; Uses: D0, D1, D2, A0, A1, A2, A4, A5
; Calls:
;   $0013B4: bit_unpack_loop
; Object fields:
;   +$01: [unknown]
;   +$FF: [unknown]
; Confidence: low
; ============================================================================

fn_200_025:
        ORI.L  #$000000FF,(A0)                  ; $001586
        MOVE.B  D0,D0                           ; $00158C
        ORI.B  #$00,(A1)                        ; $00158E
        ORI.B  #$00,D0                          ; $001592
        ORI.B  #$00,D0                          ; $001596
        ORI.B  #$00,D0                          ; $00159A
        ORI.B  #$00,D0                          ; $00159E
        ORI.B  #$90,D0                          ; $0015A2
        MOVE.L  -(A4),-$01(A1,D0.W)             ; $0015A6
        MOVE.B  D0,D0                           ; $0015AA
        ORI.B  #$90,(A1)                        ; $0015AC
        BCLR    D2,-$01(A2,D0.W)                ; $0015B0
        MOVE.B  D0,D0                           ; $0015B4
        ORI.B  #$90,(A1)                        ; $0015B6
        DC.W    $0A7C                           ; $0015BA
        DC.W    $00FF                           ; $0015BC
        MOVE.B  D0,D0                           ; $0015BE
        ORI.B  #$90,(A1)                        ; $0015C0
        MOVE.B  $00FF(A2),D0                    ; $0015C4
        MOVE.B  D0,D0                           ; $0015C8
        ORI.B  #$90,(A1)                        ; $0015CA
        MOVEA.W -$01(A4,D0.W),A5                ; $0015CE
        MOVE.B  D0,D0                           ; $0015D2
        ORI.B  #$90,(A1)                        ; $0015D4
        MOVE.W  (A6)+,(A5)+                     ; $0015D8
        DC.W    $00FF                           ; $0015DA
        MOVE.B  D0,D0                           ; $0015DC
        ORI.B  #$90,(A1)                        ; $0015DE
        MOVE.W  #$00FF,-(A5)                    ; $0015E2
        MOVE.B  D0,D0                           ; $0015E6
        DC.W    $0011                           ; $0015E8
        MOVEQ   #$03,D2                         ; $0015EA
.loc_0066:
        MOVEQ   #$00,D1                         ; $0015EC
        MOVE.B  D0,D1                           ; $0015EE
        BEQ.S  .loc_0082                        ; $0015F0
        LSL.W  #3,D1                            ; $0015F2
        MOVEA.L $001608(PC,D1.W),A0             ; $0015F4
        MOVEA.L $00160C(PC,D1.W),A1             ; $0015F8
        MOVEM.L D0/D2,-(A7)                     ; $0015FC
        DC.W    $4EBA,$FDB2         ; JSR     $0013B4(PC); $001600
        MOVEM.L (A7)+,D0/D2                     ; $001604
.loc_0082:
        ROR.L  #8,D0                            ; $001608
        DBRA    D2,.loc_0066                    ; $00160A
        RTS                                     ; $00160E
