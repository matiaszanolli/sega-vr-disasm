; ============================================================================
; palette_data_loader_and_cycle_handler — Palette Data Loader and Cycle Handler
; ROM Range: $00D8CC-$00DA90 (452 bytes)
; Loads palette data from ROM tables $0088DAA8/$0088DA90 indexed by
; current palette selection. Copies 128 words to $FF6E00 framebuffer
; palette. Populates display object at $FF6100 with viewport and
; animation parameters. Sends SH2 DMA command via COMM0. Handles
; D-pad input for palette cycling: right/left advance/retreat through
; palette entries with wrapping and sound trigger ($A9).
;
; Uses: D0, D1, D7, A0, A1, A2
; Calls: $00E52C (dma_transfer)
; Confidence: high
; ============================================================================

palette_data_loader_and_cycle_handler:
        LEA     $00FF6E00,A0                    ; $00D8CC
        LEA     $0088DAA8,A1                    ; $00D8D2
        CLR.W  D0                               ; $00D8D8
        MOVE.B  (-24551).W,D0                   ; $00D8DA
        TST.B  (-24537).W                       ; $00D8DE
        BEQ.W  .loc_001E                        ; $00D8E2
        MOVE.B  (-24539).W,D0                   ; $00D8E6
.loc_001E:
        ADD.W   D0,D0                           ; $00D8EA
        ADD.W   D0,D0                           ; $00D8EC
        MOVEA.L $00(A1,D0.W),A1                 ; $00D8EE
        MOVE.W  #$007F,D0                       ; $00D8F2
.loc_002A:
        MOVE.W  (A1)+,(A0)+                     ; $00D8F6
        DBRA    D0,.loc_002A                    ; $00D8F8
        LEA     $00FF6100,A1                    ; $00D8FC
        MOVE.W  #$0001,$0000(A1)                ; $00D902
        MOVE.W  (-24550).W,$0002(A1)            ; $00D908
        MOVE.W  (-24548).W,$0004(A1)            ; $00D90E
        MOVE.W  (-24546).W,$0006(A1)            ; $00D914
        MOVE.L  (-24556).W,D0                   ; $00D91A
        MOVE.W  D0,$000A(A1)                    ; $00D91E
        MOVE.W  (-24544).W,$0008(A1)            ; $00D922
        MOVE.W  (-24542).W,$000C(A1)            ; $00D928
        MOVE.W  #$0000,$000E(A1)                ; $00D92E
        LEA     $0088DA90,A0                    ; $00D934
        CLR.W  D1                               ; $00D93A
        MOVE.B  (-24551).W,D1                   ; $00D93C
        TST.B  (-24537).W                       ; $00D940
        BEQ.S  .loc_007E                        ; $00D944
        MOVE.B  (-24539).W,D1                   ; $00D946
.loc_007E:
        ADD.W   D1,D1                           ; $00D94A
        ADD.W   D1,D1                           ; $00D94C
        MOVE.L  $00(A0,D1.W),$0010(A1)          ; $00D94E
        MOVE.W  #$0044,$00A15110                ; $00D954
        MOVE.B  #$04,$00A15107                  ; $00D95C
        CLR.B  COMM1_LO                        ; $00D964
        MOVE.B  #$2B,COMM0_LO                  ; $00D96A
        MOVE.B  #$01,COMM0_HI                  ; $00D972
.loc_00AE:
        BTST    #1,COMM1_LO                    ; $00D97A
        BEQ.S  .loc_00AE                        ; $00D982
        BCLR    #1,COMM1_LO                    ; $00D984
        LEA     $00FF60C8,A1                    ; $00D98C
        LEA     $00A15112,A2                    ; $00D992
        MOVE.W  #$0043,D7                       ; $00D998
.loc_00D0:
        BTST    #7,$00A15107                    ; $00D99C
        BNE.S  .loc_00D0                        ; $00D9A4
        MOVE.W  (A1)+,(A2)                      ; $00D9A6
        DBRA    D7,.loc_00D0                    ; $00D9A8
        MOVE.L  (-24556).W,D0                   ; $00D9AC
        ADDI.L  #$00000080,D0                   ; $00D9B0
        ANDI.L  #$0000FFFF,D0                   ; $00D9B6
        MOVE.L  D0,(-24556).W                   ; $00D9BC
        JSR     $0088179E                       ; $00D9C0
        TST.W  (-24532).W                       ; $00D9C6
        BNE.W  .loc_01B6                        ; $00D9CA
        CLR.W  D0                               ; $00D9CE
        MOVE.B  (-24537).W,D0                   ; $00D9D0
        DC.W    $6100,$0B56         ; BSR.W  $00E52C; $00D9D4
        MOVE.B  (-24551).W,D0                   ; $00D9D8
        MOVE.W  (-14228).W,D1                   ; $00D9DC
        BTST    #3,D1                           ; $00D9E0
        BEQ.S  .loc_013E                        ; $00D9E4
        MOVE.B  #$A9,(-14172).W                 ; $00D9E6
        TST.B  (-24537).W                       ; $00D9EC
        BNE.W  .loc_0130                        ; $00D9F0
        CMPI.B  #$04,D0                         ; $00D9F4
        BGE.S  .loc_013A                        ; $00D9F8
        BRA.S  .loc_0136                        ; $00D9FA
.loc_0130:
        CMPI.B  #$03,D0                         ; $00D9FC
        BGE.S  .loc_013A                        ; $00DA00
.loc_0136:
        ADDQ.B  #1,D0                           ; $00DA02
        BRA.S  .loc_01B2                        ; $00DA04
.loc_013A:
        CLR.B  D0                               ; $00DA06
        BRA.S  .loc_01B2                        ; $00DA08
.loc_013E:
        BTST    #2,D1                           ; $00DA0A
        BEQ.S  .loc_0166                        ; $00DA0E
        MOVE.B  #$A9,(-14172).W                 ; $00DA10
        TST.B  D0                               ; $00DA16
        BLE.S  .loc_0152                        ; $00DA18
        SUBQ.B  #1,D0                           ; $00DA1A
        BRA.S  .loc_01B2                        ; $00DA1C
.loc_0152:
        TST.B  (-24537).W                       ; $00DA1E
        BNE.W  .loc_0160                        ; $00DA22
        MOVE.B  #$04,D0                         ; $00DA26
        BRA.S  .loc_01B2                        ; $00DA2A
.loc_0160:
        MOVE.B  #$03,D0                         ; $00DA2C
        BRA.S  .loc_01B2                        ; $00DA30
.loc_0166:
        TST.B  (-24540).W                       ; $00DA32
        BEQ.S  .loc_01B2                        ; $00DA36
        BTST    #0,D1                           ; $00DA38
        BEQ.W  .loc_018E                        ; $00DA3C
        TST.B  (-24537).W                       ; $00DA40
        BEQ.S  .loc_01B2                        ; $00DA44
        MOVE.B  #$A9,(-14172).W                 ; $00DA46
        CLR.B  (-24537).W                       ; $00DA4C
        MOVE.B  D0,(-24538).W                   ; $00DA50
        MOVE.B  (-24539).W,D0                   ; $00DA54
        BRA.S  .loc_01B2                        ; $00DA58
.loc_018E:
        BTST    #1,D1                           ; $00DA5A
        BEQ.W  .loc_01B2                        ; $00DA5E
        CMPI.B  #$01,(-24537).W                 ; $00DA62
        BGE.S  .loc_01B2                        ; $00DA68
        MOVE.B  #$A9,(-14172).W                 ; $00DA6A
        MOVE.B  #$01,(-24537).W                 ; $00DA70
        MOVE.B  D0,(-24539).W                   ; $00DA76
        MOVE.B  (-24538).W,D0                   ; $00DA7A
.loc_01B2:
        MOVE.B  D0,(-24551).W                   ; $00DA7E
.loc_01B6:
        ADDQ.W  #4,(-14210).W                   ; $00DA82
        MOVE.W  #$0020,$00FF0008                ; $00DA86
        RTS                                     ; $00DA8E
