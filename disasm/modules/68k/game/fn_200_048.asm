; ============================================================================
; Init 048 (auto-analyzed)
; ROM Range: $0020D6-$0021EE (280 bytes)
; ============================================================================
; Category: boot
; Purpose: Function in 200 section (280 bytes)
;
; Uses: D0, A5, A6
; Confidence: low
; ============================================================================

fn_200_048:
        TST.B  (-31478).W                       ; $0020D6
        BNE.S  .loc_0022                        ; $0020DA
        BTST    #5,(-15602).W                   ; $0020DC
        BNE.S  .loc_0022                        ; $0020E2
        MOVE.B  (-14172).W,(-31478).W           ; $0020E4
        BEQ.S  .loc_0022                        ; $0020EA
        MOVE.B  (-14172).W,(-14170).W           ; $0020EC
        MOVE.B  #$00,(-14172).W                 ; $0020F2
.loc_0022:
        MOVEM.L A5/A6,-(A7)                     ; $0020F8
        JSR     $008B0000                       ; $0020FC
        MOVEM.L (A7)+,A5/A6                     ; $002102
        DC.W    $4EFA,$0226         ; JMP     $00232E(PC); $002106
        TST.B  (-31478).W                       ; $00210A
        BNE.S  .loc_0046                        ; $00210E
        MOVE.B  (-14171).W,(-31478).W           ; $002110
        MOVE.B  #$00,(-14171).W                 ; $002116
.loc_0046:
        MOVEM.L A5/A6,-(A7)                     ; $00211C
        JSR     $008B0000                       ; $002120
        MOVEM.L (A7)+,A5/A6                     ; $002126
        DC.W    $4EFA,$0202         ; JMP     $00232E(PC); $00212A
        MOVE.B  (-14302).W,D0                   ; $00212E
        BEQ.S  .loc_006C                        ; $002132
        MOVE.B  D0,(-31479).W                   ; $002134
        MOVEQ   #$00,D0                         ; $002138
        MOVE.B  D0,(-14302).W                   ; $00213A
        MOVE.L  D0,(-14172).W                   ; $00213E
.loc_006C:
        MOVEM.L A5/A6,-(A7)                     ; $002142
        JSR     $008B0000                       ; $002146
        MOVEM.L (A7)+,A5/A6                     ; $00214C
        DC.W    $4EFA,$01DC         ; JMP     $00232E(PC); $002150
        TST.B  (-31478).W                       ; $002154
        BNE.S  .loc_0098                        ; $002158
        MOVE.B  (-14172).W,(-31478).W           ; $00215A
        BEQ.S  .loc_0098                        ; $002160
        MOVE.B  (-14172).W,(-14170).W           ; $002162
        MOVE.B  #$00,(-14172).W                 ; $002168
.loc_0098:
        MOVEM.L A5/A6,-(A7)                     ; $00216E
        JSR     $008B0000                       ; $002172
        MOVEM.L (A7)+,A5/A6                     ; $002178
        DC.W    $4EFA,$008E         ; JMP     $00220C(PC); $00217C
        TST.B  (-31478).W                       ; $002180
        BNE.S  .loc_00BC                        ; $002184
        MOVE.B  (-14171).W,(-31478).W           ; $002186
        MOVE.B  #$00,(-14171).W                 ; $00218C
.loc_00BC:
        MOVEM.L A5/A6,-(A7)                     ; $002192
        JSR     $008B0000                       ; $002196
        MOVEM.L (A7)+,A5/A6                     ; $00219C
        DC.W    $4EFA,$006A         ; JMP     $00220C(PC); $0021A0
        MOVE.B  (-14302).W,D0                   ; $0021A4
        BEQ.S  .loc_00E2                        ; $0021A8
        MOVE.B  D0,(-31479).W                   ; $0021AA
        MOVEQ   #$00,D0                         ; $0021AE
        MOVE.B  D0,(-14302).W                   ; $0021B0
        MOVE.L  D0,(-14172).W                   ; $0021B4
.loc_00E2:
        MOVEM.L A5/A6,-(A7)                     ; $0021B8
        JSR     $008B0000                       ; $0021BC
        MOVEM.L (A7)+,A5/A6                     ; $0021C2
        DC.W    $4EFA,$0044         ; JMP     $00220C(PC); $0021C6
        MOVE.B  (-14302).W,D0                   ; $0021CA
        BEQ.S  .loc_0108                        ; $0021CE
        MOVE.B  D0,(-31479).W                   ; $0021D0
        MOVEQ   #$00,D0                         ; $0021D4
        MOVE.B  D0,(-14302).W                   ; $0021D6
        MOVE.L  D0,(-14172).W                   ; $0021DA
.loc_0108:
        MOVEM.L A5/A6,-(A7)                     ; $0021DE
        JSR     $008B0000                       ; $0021E2
        MOVEM.L (A7)+,A5/A6                     ; $0021E8
        RTS                                     ; $0021EC
