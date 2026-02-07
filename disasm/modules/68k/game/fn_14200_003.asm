; ============================================================================
; Util 003 (auto-analyzed)
; ROM Range: $01457C-$0145F0 (116 bytes)
; ============================================================================
; Category: game
; Purpose: Function in 14200 section (116 bytes)
;
; Uses: D0, D1, D2, D3, D4, D5, A1
; Confidence: low
; ============================================================================

fn_14200_003:
        NOP                                     ; $01457C
        NOP                                     ; $01457E
        NOP                                     ; $014580
        TST.W  (-24568).W                       ; $014582
        BEQ.W  .loc_006C                        ; $014586
        LEA     (-24320).W,A1                   ; $01458A
        MOVEQ   #$00,D2                         ; $01458E
        MOVE.B  (-24568).W,D2                   ; $014590
        CMPI.B  #$02,(-24567).W                 ; $014594
        BEQ.S  .loc_0028                        ; $01459A
        MOVE.W  #$0008,D2                       ; $01459C
        SUB.B  (-24568).W,D2                    ; $0145A0
.loc_0028:
        MOVE.W  #$00FF,D1                       ; $0145A4
.loc_002C:
        MOVE.W  (A1),D0                         ; $0145A8
        MOVE.W  D0,D3                           ; $0145AA
        ANDI.W  #$001F,D3                       ; $0145AC
        MULU    D2,D3                           ; $0145B0
        LSR.W  #3,D3                            ; $0145B2
        ANDI.W  #$001F,D3                       ; $0145B4
        MOVE.W  D0,D4                           ; $0145B8
        ANDI.W  #$03E0,D4                       ; $0145BA
        MULU    D2,D4                           ; $0145BE
        LSR.W  #3,D4                            ; $0145C0
        ANDI.W  #$03E0,D4                       ; $0145C2
        MOVE.W  D0,D5                           ; $0145C6
        ANDI.W  #$7C00,D5                       ; $0145C8
        MULU    D2,D5                           ; $0145CC
        LSR.L  #3,D5                            ; $0145CE
        ANDI.W  #$7C00,D5                       ; $0145D0
        DC.W    $8644                           ; $0145D4
        DC.W    $8645                           ; $0145D6
        MOVE.W  D3,(A1)+                        ; $0145D8
        DBRA    D1,.loc_002C                    ; $0145DA
        SUBQ.B  #1,(-24568).W                   ; $0145DE
        BNE.S  .loc_006C                        ; $0145E2
        CLR.W  (-24568).W                       ; $0145E4
.loc_006C:
        NOP                                     ; $0145E8
        NOP                                     ; $0145EA
        NOP                                     ; $0145EC
        RTS                                     ; $0145EE
