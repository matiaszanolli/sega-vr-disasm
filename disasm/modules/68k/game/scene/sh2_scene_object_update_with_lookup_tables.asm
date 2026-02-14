; ============================================================================
; sh2_scene_object_update_with_lookup_tables — SH2 Scene Object Update with Lookup Tables
; ROM Range: $00ECBE-$00EEF2 (564 bytes)
; Data prefix (~280 bytes: sine/cosine lookup tables for animation
; interpolation, palette color tables, and command parameters).
; Code section sends SH2 tile and geometry commands, calls
; object_update + sprite_update. Handles exit transition with
; palette save and fade-out ($A8 sound). Supports single-screen
; and split-screen palette configurations.
;
; Uses: D0, D1, D2, D3, D4, D5, D6, D7
; Calls: $00B684 (object_update), $00B6DA (sprite_update),
;        $00E35A (sh2_send_cmd), $00E52C (dma_transfer)
; Confidence: high
; ============================================================================

sh2_scene_object_update_with_lookup_tables:
        ORI.B  #$00,D0                          ; $00ECBE
        ORI.B  #$00,D0                          ; $00ECC2
        ORI.B  #$00,D0                          ; $00ECC6
        ORI.B  #$00,D0                          ; $00ECCA
        ORI.B  #$00,D0                          ; $00ECCE
        ORI.B  #$00,D0                          ; $00ECD2
        ORI.B  #$00,D0                          ; $00ECD6
        DC.W    $0000                           ; $00ECDA
        or.b    d0,d0                   ; $8000
        OR.B   -(A1),D2                         ; $00ECDE
        or.w    d2,d4                   ; $8842
        OR.W   -(A3),D6                         ; $00ECE2
        sub.l   d4,d0                   ; $9084
        SUB.L  -(A5),D2                         ; $00ECE6
        SUBA.W  D6,A4                           ; $00ECE8
        SUBA.W  -(A7),A6                        ; $00ECEA
        DC.W    $A108                           ; $00ECEC
        DC.W    $A529                           ; $00ECEE
        DC.W    $A94A                           ; $00ECF0
        DC.W    $AD6B                           ; $00ECF2
        cmpm.l  (a4)+,(a0)+             ; $B18C
        EOR.L  D2,-$4632(A5)                    ; $00ECF6
        CMPA.L  -$3DF0(A7),A6                   ; $00ECFA
        DC.W    $C631                           ; $00ECFE
        AND.W  (A2),D5                          ; $00ED00
        DC.W    $CE73                           ; $00ED02
        ADD.L  (A4),D1                          ; $00ED04
        DC.W    $D6B5                           ; $00ED06
        ADDA.W  (A6),A5                         ; $00ED08
        DC.W    $DEF7                           ; $00ED0A
        ROL.B  #1,D0                            ; $00ED0C
        ROL.B  D3,D1                            ; $00ED0E
        ROL.W  #5,D2                            ; $00ED10
        ROL.W  D7,D3                            ; $00ED12
        DC.W    $F39C                           ; $00ED14
        DC.W    $F7BD                           ; $00ED16
        DC.W    $FBDE                           ; $00ED18
        DC.W    $FFFF                           ; $00ED1A
        SUB.W  -(A0),D0                         ; $00ED1C
        sub.l   d1,d2                   ; $9481
        SUBA.W  D3,A6                           ; $00ED20
        DC.W    $A4E4                           ; $00ED22
        DC.W    $AD26                           ; $00ED24
        DC.W    $8009                           ; $00ED26
        DC.W    $800B                           ; $00ED28
        DC.W    $800D                           ; $00ED2A
        OR.B   (A0),D0                          ; $00ED2C
        OR.W   (A2),D4                          ; $00ED2E
        OR.W   -$2C(A3,A1.L),D6                 ; $00ED30
        DC.W    $A535                           ; $00ED34
        CMP.B  D0,D6                            ; $00ED36
        and.b   d0,d2                   ; $C400
        and.w   d0,d6                   ; $CC40
        add.l   d2,d2                   ; $D482
        ASR.W  -(A5)                            ; $00ED3E
        ASL.B  D4,D7                            ; $00ED40
        or.b    d0,d0                   ; $8000
        or.b    d0,d0                   ; $8000
        or.b    d0,d0                   ; $8000
        or.b    d0,d0                   ; $8000
        or.b    d0,d0                   ; $8000
        or.b    d0,d0                   ; $8000
        or.b    d0,d0                   ; $8000
        or.b    d0,d0                   ; $8000
        or.b    d0,d0                   ; $8000
        or.b    d0,d0                   ; $8000
        or.b    d0,d0                   ; $8000
        or.b    d0,d0                   ; $8000
        or.b    d0,d0                   ; $8000
        or.b    d0,d0                   ; $8000
        or.b    d0,d0                   ; $8000
        or.b    d0,d0                   ; $8000
        or.b    d0,d0                   ; $8000
        or.b    d0,d0                   ; $8000
        OR.W   -(A0),D6                         ; $00ED66
        or.w    d0,d4                   ; $8840
        or.b    d0,d0                   ; $8000
        or.w    d0,d4                   ; $8840
        sub.l   d0,d0                   ; $9080
        SUBA.W  D1,A4                           ; $00ED70
        DC.W    $A103                           ; $00ED72
        DC.W    $A945                           ; $00ED74
        ORI.B  #$00,D0                          ; $00ED76
        ORI.B  #$00,D0                          ; $00ED7A
        ORI.B  #$00,D0                          ; $00ED7E
        ORI.B  #$00,D0                          ; $00ED82
        ORI.B  #$00,D0                          ; $00ED86
        ORI.B  #$00,D0                          ; $00ED8A
        ORI.B  #$00,D0                          ; $00ED8E
        ORI.B  #$00,D0                          ; $00ED92
        ORI.B  #$00,D0                          ; $00ED96
        ORI.B  #$00,D0                          ; $00ED9A
        ORI.B  #$00,D0                          ; $00ED9E
        ORI.B  #$00,D0                          ; $00EDA2
        ORI.B  #$00,D0                          ; $00EDA6
        ORI.B  #$00,D0                          ; $00EDAA
        ORI.B  #$00,D0                          ; $00EDAE
        ORI.B  #$00,D0                          ; $00EDB2
        ORI.B  #$00,D0                          ; $00EDB6
        ORI.B  #$00,D0                          ; $00EDBA
        ORI.B  #$00,D0                          ; $00EDBE
        ORI.B  #$00,D0                          ; $00EDC2
        ORI.B  #$00,D0                          ; $00EDC6
        ORI.B  #$00,D0                          ; $00EDCA
        ORI.B  #$00,D0                          ; $00EDCE
        ORI.B  #$00,D0                          ; $00EDD2
        ORI.B  #$00,D0                          ; $00EDD6
        MOVEA.L #$0603D100,A0                   ; $00EDDA
        MOVEA.L #$04004C68,A1                   ; $00EDE0
        MOVE.W  #$0070,D0                       ; $00EDE6
        MOVE.W  #$0010,D1                       ; $00EDEA
        DC.W    $4EBA,$F56A         ; JSR     $00E35A(PC); $00EDEE
.loc_0134:
        TST.B  COMM0_HI                        ; $00EDF2
        BNE.S  .loc_0134                        ; $00EDF8
        bsr.w   table_dual_dispatch     ; $6100 $0136
        MOVEA.L #$0603D800,A0                   ; $00EDFE
        MOVEA.L #$0401985C,A1                   ; $00EE04
        MOVE.W  #$0088,D0                       ; $00EE0A
        MOVE.W  #$0010,D1                       ; $00EE0E
        DC.W    $4EBA,$F546         ; JSR     $00E35A(PC); $00EE12
        CLR.W  D0                               ; $00EE16
        MOVE.B  (-24550).W,D0                   ; $00EE18
        bsr.w   MemoryInit              ; $6100 $F70E
        jsr     object_update(pc)       ; $4EBA $C862
        jsr     animated_seq_player+10(pc); $4EBA $C8B4
        CMPI.W  #$0001,(-24544).W               ; $00EE28
        BEQ.W  .loc_01FC                        ; $00EE2E
        CMPI.W  #$0002,(-24544).W               ; $00EE32
        BEQ.W  .loc_020C                        ; $00EE38
        MOVE.W  (-14228).W,D1                   ; $00EE3C
        ANDI.B  #$E0,D1                         ; $00EE40
        BNE.S  .loc_019E                        ; $00EE44
        MOVE.W  (-14228).W,D1                   ; $00EE46
        ANDI.B  #$10,D1                         ; $00EE4A
        BNE.S  .loc_019A                        ; $00EE4E
        SUBQ.W  #4,(-14210).W                   ; $00EE50
        BRA.W  .loc_0224                        ; $00EE54
.loc_019A:
        ST      (-24552).W                      ; $00EE58
.loc_019E:
        MOVE.B  #$A8,(-14172).W                 ; $00EE5C
        TST.B  (-24550).W                       ; $00EE62
        BNE.S  .loc_01B4                        ; $00EE66
        MOVE.B  (-24551).W,(-24546).W           ; $00EE68
        BRA.W  .loc_01BA                        ; $00EE6E
.loc_01B4:
        MOVE.B  (-24551).W,(-24547).W           ; $00EE72
.loc_01BA:
        TST.B  (-24545).W                       ; $00EE78
        BNE.S  .loc_01CE                        ; $00EE7C
        MOVE.B  (-24546).W,(-335).W             ; $00EE7E
        MOVE.B  (-24547).W,(-343).W             ; $00EE84
        BRA.S  .loc_01DA                        ; $00EE8A
.loc_01CE:
        MOVE.B  (-24546).W,(-334).W             ; $00EE8C
        MOVE.B  (-24547).W,(-342).W             ; $00EE92
.loc_01DA:
        MOVE.B  #$01,(-14327).W                 ; $00EE98
        MOVE.B  #$01,(-14326).W                 ; $00EE9E
        BSET    #7,(-14322).W                   ; $00EEA4
        MOVE.B  #$01,(-14334).W                 ; $00EEAA
        MOVE.W  #$0002,(-24544).W               ; $00EEB0
        BRA.W  .loc_0220                        ; $00EEB6
.loc_01FC:
        BTST    #6,(-14322).W                   ; $00EEBA
        BNE.S  .loc_0220                        ; $00EEC0
        CLR.W  (-24544).W                       ; $00EEC2
        BRA.W  .loc_0220                        ; $00EEC6
.loc_020C:
        BTST    #7,(-14322).W                   ; $00EECA
        BNE.S  .loc_0220                        ; $00EED0
        CLR.W  (-24544).W                       ; $00EED2
        ADDQ.W  #4,(-14210).W                   ; $00EED6
        BRA.W  .loc_0224                        ; $00EEDA
.loc_0220:
        SUBQ.W  #4,(-14210).W                   ; $00EEDE
.loc_0224:
        MOVE.W  #$0018,$00FF0008                ; $00EEE2
        MOVE.B  #$01,(-14303).W                 ; $00EEEA
        RTS                                     ; $00EEF0
