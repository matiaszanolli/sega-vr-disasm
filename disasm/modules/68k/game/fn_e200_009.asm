; ============================================================================
; Sh2 Comm Cmd 27 009 (auto-analyzed)
; ROM Range: $00F8F6-$00FB24 (558 bytes)
; ============================================================================
; Category: sh2
; Purpose: Accesses 32X registers: COMM0
;   Calls: sh2_cmd_27
;   Object (A0, A1): +$00, +$04 (speed_index/velocity)
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, D1, D2, A0, A1
; Calls:
;   $00E3B4: sh2_cmd_27
; Object fields:
;   +$00: [unknown]
;   +$04: speed_index/velocity
; Confidence: high
; ============================================================================

fn_e200_009:
        DC.W    $0EEE                           ; $00F8F6
        DC.W    $0EEE                           ; $00F8F8
        DC.W    $0EEE                           ; $00F8FA
        DC.W    $0EEE                           ; $00F8FC
        ORI.B  #$00,D0                          ; $00F8FE
        ORI.B  #$00,D0                          ; $00F902
        DC.W    $0EEE                           ; $00F906
        DC.W    $0EEE                           ; $00F908
        DC.W    $0EEE                           ; $00F90A
        DC.W    $0EEE                           ; $00F90C
        ORI.B  #$00,D0                          ; $00F90E
        ORI.B  #$00,D0                          ; $00F912
        MOVEQ   #$00,D0                         ; $00F916
        TST.B  (-24549).W                       ; $00F918
        BNE.S  .loc_002E                        ; $00F91C
        MOVE.B  (-24551).W,D0                   ; $00F91E
        BRA.S  .loc_0032                        ; $00F922
.loc_002E:
        MOVE.B  (-24545).W,D0                   ; $00F924
.loc_0032:
        LEA     $0088FB24,A1                    ; $00F928
        DC.W    $D040                           ; $00F92E
        MOVE.W  D0,D1                           ; $00F930
        DC.W    $D040                           ; $00F932
        DC.W    $D041                           ; $00F934
        MOVEA.L $00(A1,D0.W),A0                 ; $00F936
        MOVE.W  $04(A1,D0.W),D0                 ; $00F93A
        MOVE.W  #$0030,D1                       ; $00F93E
        MOVE.W  #$0010,D2                       ; $00F942
        DC.W    $4EBA,$EA6C         ; JSR     $00E3B4(PC); $00F946
        MOVEQ   #$00,D0                         ; $00F94A
        CMPI.B  #$01,(-24549).W                 ; $00F94C
        BNE.S  .loc_0082                        ; $00F952
        MOVEA.L #$04012024,A0                   ; $00F954
        MOVE.W  #$0060,D0                       ; $00F95A
        MOVE.W  #$0010,D1                       ; $00F95E
        MOVE.W  #$0010,D2                       ; $00F962
.loc_0070:
        TST.B  $00A15120                        ; $00F966
        BNE.S  .loc_0070                        ; $00F96C
        DC.W    $4EBA,$EA44         ; JSR     $00E3B4(PC); $00F96E
        MOVE.B  (-24551).W,D0                   ; $00F972
        BRA.S  .loc_0086                        ; $00F976
.loc_0082:
        MOVE.B  (-24544).W,D0                   ; $00F978
.loc_0086:
        MOVEA.L #$04014014,A0                   ; $00F97C
        TST.B  D0                               ; $00F982
        BNE.S  .loc_0096                        ; $00F984
        MOVE.W  #$0048,D0                       ; $00F986
        BRA.S  .loc_00A0                        ; $00F98A
.loc_0096:
        ADDA.L  #$00000047,A0                   ; $00F98C
        MOVE.W  #$0039,D0                       ; $00F992
.loc_00A0:
        MOVE.W  #$0010,D1                       ; $00F996
        MOVE.W  #$0010,D2                       ; $00F99A
.loc_00A8:
        TST.B  $00A15120                        ; $00F99E
        BNE.S  .loc_00A8                        ; $00F9A4
        DC.W    $4EBA,$EA0C         ; JSR     $00E3B4(PC); $00F9A6
        MOVEQ   #$00,D0                         ; $00F9AA
        CMPI.B  #$02,(-24549).W                 ; $00F9AC
        BNE.S  .loc_0100                        ; $00F9B2
        MOVEA.L #$04017030,A0                   ; $00F9B4
        MOVE.W  #$0048,D0                       ; $00F9BA
        MOVE.W  #$0010,D1                       ; $00F9BE
        MOVE.W  #$0010,D2                       ; $00F9C2
.loc_00D0:
        TST.B  $00A15120                        ; $00F9C6
        BNE.S  .loc_00D0                        ; $00F9CC
        DC.W    $4EBA,$E9E4         ; JSR     $00E3B4(PC); $00F9CE
        MOVEA.L #$04019018,A0                   ; $00F9D2
        MOVE.W  #$0078,D0                       ; $00F9D8
        MOVE.W  #$0010,D1                       ; $00F9DC
        MOVE.W  #$0010,D2                       ; $00F9E0
.loc_00EE:
        TST.B  $00A15120                        ; $00F9E4
        BNE.S  .loc_00EE                        ; $00F9EA
        DC.W    $4EBA,$E9C6         ; JSR     $00E3B4(PC); $00F9EC
        MOVE.B  (-24551).W,D0                   ; $00F9F0
        BRA.S  .loc_0104                        ; $00F9F4
.loc_0100:
        MOVE.B  (-24543).W,D0                   ; $00F9F6
.loc_0104:
        MOVE.B  D0,D2                           ; $00F9FA
        MOVEA.L #$0401B018,A0                   ; $00F9FC
        DC.W    $D040                           ; $00FA02
        DC.W    $D040                           ; $00FA04
        DC.W    $D040                           ; $00FA06
        MOVE.W  D0,D1                           ; $00FA08
        DC.W    $D040                           ; $00FA0A
        DC.W    $D041                           ; $00FA0C
        LEA     $00(A0,D0.W),A0                 ; $00FA0E
        MOVE.W  #$0018,D0                       ; $00FA12
        TST.B  D2                               ; $00FA16
        BEQ.W  .loc_012C                        ; $00FA18
        SUBQ.L  #1,A0                           ; $00FA1C
        MOVE.W  #$0019,D0                       ; $00FA1E
.loc_012C:
        MOVE.W  #$0010,D1                       ; $00FA22
        MOVE.W  #$0010,D2                       ; $00FA26
.loc_0134:
        TST.B  $00A15120                        ; $00FA2A
        BNE.S  .loc_0134                        ; $00FA30
        DC.W    $4EBA,$E980         ; JSR     $00E3B4(PC); $00FA32
        MOVEQ   #$00,D0                         ; $00FA36
        CMPI.B  #$01,(-24548).W                 ; $00FA38
        BNE.S  .loc_016E                        ; $00FA3E
        MOVEA.L #$040120BC,A0                   ; $00FA40
        MOVE.W  #$0060,D0                       ; $00FA46
        MOVE.W  #$0010,D1                       ; $00FA4A
        MOVE.W  #$0010,D2                       ; $00FA4E
.loc_015C:
        TST.B  $00A15120                        ; $00FA52
        BNE.S  .loc_015C                        ; $00FA58
        DC.W    $4EBA,$E958         ; JSR     $00E3B4(PC); $00FA5A
        MOVE.B  (-24550).W,D0                   ; $00FA5E
        BRA.S  .loc_0172                        ; $00FA62
.loc_016E:
        MOVE.B  (-24542).W,D0                   ; $00FA64
.loc_0172:
        MOVEA.L #$040140AC,A0                   ; $00FA68
        TST.B  D0                               ; $00FA6E
        BNE.S  .loc_0182                        ; $00FA70
        MOVE.W  #$0048,D0                       ; $00FA72
        BRA.S  .loc_018C                        ; $00FA76
.loc_0182:
        ADDA.L  #$00000047,A0                   ; $00FA78
        MOVE.W  #$0039,D0                       ; $00FA7E
.loc_018C:
        MOVE.W  #$0010,D1                       ; $00FA82
        MOVE.W  #$0010,D2                       ; $00FA86
.loc_0194:
        TST.B  $00A15120                        ; $00FA8A
        BNE.S  .loc_0194                        ; $00FA90
        DC.W    $4EBA,$E920         ; JSR     $00E3B4(PC); $00FA92
        MOVEQ   #$00,D0                         ; $00FA96
        CMPI.B  #$02,(-24548).W                 ; $00FA98
        BNE.S  .loc_01EC                        ; $00FA9E
        MOVEA.L #$040170C8,A0                   ; $00FAA0
        MOVE.W  #$0048,D0                       ; $00FAA6
        MOVE.W  #$0010,D1                       ; $00FAAA
        MOVE.W  #$0010,D2                       ; $00FAAE
.loc_01BC:
        TST.B  $00A15120                        ; $00FAB2
        BNE.S  .loc_01BC                        ; $00FAB8
        DC.W    $4EBA,$E8F8         ; JSR     $00E3B4(PC); $00FABA
        MOVEA.L #$040190B0,A0                   ; $00FABE
        MOVE.W  #$0078,D0                       ; $00FAC4
        MOVE.W  #$0010,D1                       ; $00FAC8
        MOVE.W  #$0010,D2                       ; $00FACC
.loc_01DA:
        TST.B  $00A15120                        ; $00FAD0
        BNE.S  .loc_01DA                        ; $00FAD6
        DC.W    $4EBA,$E8DA         ; JSR     $00E3B4(PC); $00FAD8
        MOVE.B  (-24550).W,D0                   ; $00FADC
        BRA.S  .loc_01F0                        ; $00FAE0
.loc_01EC:
        MOVE.B  (-24541).W,D0                   ; $00FAE2
.loc_01F0:
        MOVE.B  D0,D2                           ; $00FAE6
        MOVEA.L #$0401B0B0,A0                   ; $00FAE8
        DC.W    $D040                           ; $00FAEE
        DC.W    $D040                           ; $00FAF0
        DC.W    $D040                           ; $00FAF2
        MOVE.W  D0,D1                           ; $00FAF4
        DC.W    $D040                           ; $00FAF6
        DC.W    $D041                           ; $00FAF8
        LEA     $00(A0,D0.W),A0                 ; $00FAFA
        MOVE.W  #$0018,D0                       ; $00FAFE
        TST.B  D2                               ; $00FB02
        BEQ.W  .loc_0218                        ; $00FB04
        SUBQ.L  #1,A0                           ; $00FB08
        MOVE.W  #$0019,D0                       ; $00FB0A
.loc_0218:
        MOVE.W  #$0010,D1                       ; $00FB0E
        MOVE.W  #$0010,D2                       ; $00FB12
.loc_0220:
        TST.B  $00A15120                        ; $00FB16
        BNE.S  .loc_0220                        ; $00FB1C
        DC.W    $4EBA,$E894         ; JSR     $00E3B4(PC); $00FB1E
        RTS                                     ; $00FB22
