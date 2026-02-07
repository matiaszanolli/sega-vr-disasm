; ============================================================================
; Name Entry 008 (auto-analyzed)
; ROM Range: $011B6A-$011C7E (276 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A0, A1): +$01, +$02 (flags/type), +$03
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, D1, D2, D3, D4, D5, D6, D7
; Object fields:
;   +$01: [unknown]
;   +$02: flags/type
;   +$03: [unknown]
; Confidence: low
; ============================================================================

fn_10200_008:
        MOVE.L  (-15776).W,D0                   ; $011B6A
        MOVE.L  D0,(-24488).W                   ; $011B6E
        LEA     (-19456).W,A1                   ; $011B72
        LEA     (-15360).W,A2                   ; $011B76
        MOVEQ   #$1F,D7                         ; $011B7A
.loc_0012:
        MOVEM.L (A1)+,D0/D1/D2/D3/D4/D5/D6/A3   ; $011B7C
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/A3,-(A2)   ; $011B80
        DBRA    D7,.loc_0012                    ; $011B84
        CLR.L  (-24502).W                       ; $011B88
        LEA     (-24502).W,A0                   ; $011B8C
        LEA     (-15872).W,A1                   ; $011B90
        MOVE.W  #$0013,D2                       ; $011B94
.loc_002E:
        ADDI.B  #$00,D0                         ; $011B98
        MOVE.B  $0003(A0),D0                    ; $011B9C
        MOVE.B  $0003(A1),D1                    ; $011BA0
        DC.W    $C101                           ; $011BA4
        MOVE.B  D0,$0003(A0)                    ; $011BA6
        MOVE.B  $0002(A0),D0                    ; $011BAA
        MOVE.B  $0002(A1),D1                    ; $011BAE
        DC.W    $C101                           ; $011BB2
        MOVE.B  D0,D1                           ; $011BB4
        ANDI.B  #$0F,D0                         ; $011BB6
        MOVE.B  D0,$0002(A0)                    ; $011BBA
        LSR.B  #4,D1                            ; $011BBE
        ADDI.B  #$00,D0                         ; $011BC0
        MOVE.B  $0001(A0),D0                    ; $011BC4
        DC.W    $C101                           ; $011BC8
        MOVE.B  $0001(A1),D1                    ; $011BCA
        DC.W    $C101                           ; $011BCE
        BCC.W  .loc_007A                        ; $011BD0
        ADDI.B  #$00,D0                         ; $011BD4
        MOVE.B  #$40,D1                         ; $011BD8
        DC.W    $C101                           ; $011BDC
        MOVE.B  #$01,D1                         ; $011BDE
        BRA.S  .loc_0092                        ; $011BE2
.loc_007A:
        CLR.B  D1                               ; $011BE4
        CMPI.B  #$60,D0                         ; $011BE6
        BCS.W  .loc_0092                        ; $011BEA
        ADDI.B  #$00,D0                         ; $011BEE
        MOVE.B  #$60,D1                         ; $011BF2
        DC.W    $8101                           ; $011BF6
        MOVE.B  #$01,D1                         ; $011BF8
.loc_0092:
        MOVE.B  D0,$0001(A0)                    ; $011BFC
        ADDI.B  #$00,D0                         ; $011C00
        MOVE.B  (A0),D0                         ; $011C04
        DC.W    $C101                           ; $011C06
        MOVE.B  (A1),D1                         ; $011C08
        DC.W    $C101                           ; $011C0A
        MOVE.B  D0,(A0)                         ; $011C0C
        ADDQ.L  #4,A1                           ; $011C0E
        DBRA    D2,.loc_002E                    ; $011C10
        TST.L  (-24502).W                       ; $011C14
        BNE.S  .loc_00B8                        ; $011C18
        MOVE.L  #$CCCC0CCC,(-24502).W           ; $011C1A
.loc_00B8:
        LEA     (-15872).W,A0                   ; $011C22
        MOVE.W  #$0013,D0                       ; $011C26
.loc_00C0:
        TST.L  (A0)                             ; $011C2A
        BEQ.W  .loc_00CE                        ; $011C2C
        ADDQ.L  #4,A0                           ; $011C30
        DBRA    D0,.loc_00C0                    ; $011C32
        BRA.S  .loc_00D8                        ; $011C36
.loc_00CE:
        MOVE.L  #$CCCC0CCC,(A0)+                ; $011C38
        DBRA    D0,.loc_00CE                    ; $011C3E
.loc_00D8:
        MOVE.W  #$0002,(-24498).W               ; $011C42
        MOVE.L  (-24488).W,D0                   ; $011C48
        MOVE.L  (-15776).W,D1                   ; $011C4C
        CMP.L  D0,D1                            ; $011C50
        BEQ.W  .loc_0112                        ; $011C52
        MOVE.W  #$0001,(-24498).W               ; $011C56
        CMPI.L  #$CCCC0CCC,D0                   ; $011C5C
        BEQ.S  .loc_0112                        ; $011C62
        CLR.W  (-24498).W                       ; $011C64
        CMPI.L  #$CCCC0CCC,D1                   ; $011C68
        BEQ.S  .loc_0112                        ; $011C6E
        CMP.L  D0,D1                            ; $011C70
        BHI.W  .loc_0112                        ; $011C72
        MOVE.W  #$0001,(-24498).W               ; $011C76
.loc_0112:
        RTS                                     ; $011C7C
