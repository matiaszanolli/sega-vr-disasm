; ============================================================================
; Ai Player Table Setup 001 (auto-analyzed)
; ROM Range: $00A972-$00AC3E (716 bytes)
; ============================================================================
; Category: game
; Purpose: Orchestrator calling 6 subroutines
;   RAM: $C89E (sh2_comm_sub), $C8A0 (race_state), $6970 (race_mode_flag), $C8AE (effect_timer)
;   Calls: race_mode_flag_set, player_table_setup, ai_steering_calc, movement_calc
;   Object (A0, A1): +$00, +$02 (flags/type), +$04 (speed_index/velocity), +$06 (speed), +$14 (effect_duration), +$30 (x_position)
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, D1, D2, D3, D4, D5, A0, A1
; RAM:
;   $6970: race_mode_flag
;   $C89E: sh2_comm_sub
;   $C8A0: race_state
;   $C8AE: effect_timer
; Calls:
;   $003C7E: player_table_setup
;   $006FDE: position_update_sub
;   $009B12: movement_calc
;   $00A1FC: race_state_read
;   $00A7A0: ai_steering_calc
;   $00ACC0: race_mode_flag_set
; Object fields:
;   +$00: [unknown]
;   +$02: flags/type
;   +$04: speed_index/velocity
;   +$06: speed
;   +$14: effect_duration
;   +$30: x_position
;   +$34: y_position
;   +$3C: heading_mirror
; Confidence: high
; ============================================================================

fn_a200_001:
        DC.W    $4EBA,$034C         ; JSR     $00ACC0(PC); $00A972
        TST.W  (-16306).W                       ; $00A976
        BNE.S  .loc_000E                        ; $00A97A
        SUBQ.W  #1,(-16306).W                   ; $00A97C
.loc_000E:
        CLR.W  (-16346).W                       ; $00A980
        CLR.B  (-15610).W                       ; $00A984
        DC.W    $4EBA,$92F4         ; JSR     $003C7E(PC); $00A988
        DC.W    $43FA,$FF3A         ; LEA     $00A8C8(PC),A1; $00A98C
        MOVE.W  (-14178).W,D0                   ; $00A990
        MOVE.W  $00(A1,D0.W),D5                 ; $00A994
        DC.W    $43FA,$FECE         ; LEA     $00A868(PC),A1; $00A998
        MOVE.W  (-14176).W,D1                   ; $00A99C
        DC.W    $D241                           ; $00A9A0
        DC.W    $D241                           ; $00A9A2
        MOVE.W  $00AE(A0),D0                    ; $00A9A4
        DC.W    $D040                           ; $00A9A8
        DC.W    $D040                           ; $00A9AA
        DC.W    $D041                           ; $00A9AC
        MOVE.W  $00(A1,D0.W),D1                 ; $00A9AE
        MOVE.W  $02(A1,D0.W),D2                 ; $00A9B2
        MOVE.W  D2,D4                           ; $00A9B6
        SUB.W  $0034(A0),D4                     ; $00A9B8
        CMPI.W  #$0002,D4                       ; $00A9BC
        BGE.S  .loc_00A8                        ; $00A9C0
        MOVE.W  D1,$0030(A0)                    ; $00A9C2
        MOVE.W  D2,$0034(A0)                    ; $00A9C6
        MOVEQ   #$00,D0                         ; $00A9CA
        MOVE.W  D0,$003C(A0)                    ; $00A9CC
        MOVE.W  D0,$0040(A0)                    ; $00A9D0
        MOVE.W  D0,$008E(A0)                    ; $00A9D4
        MOVE.W  D0,$0090(A0)                    ; $00A9D8
        MOVE.W  D0,$0006(A0)                    ; $00A9DC
        MOVE.W  D0,$0004(A0)                    ; $00A9E0
        MOVE.W  D0,$007A(A0)                    ; $00A9E4
        MOVE.W  D0,$0092(A0)                    ; $00A9E8
        MOVE.W  D0,$0014(A0)                    ; $00A9EC
        MOVE.W  D0,$008C(A0)                    ; $00A9F0
        MOVE.W  D0,$00B8(A0)                    ; $00A9F4
        CLR.W  (-16340).W                       ; $00A9F8
        LEA     (-16292).W,A1                   ; $00A9FC
        MOVE.W  $00AE(A0),D0                    ; $00AA00
        DC.W    $D040                           ; $00AA04
        MOVE.W  #$0002,$00(A1,D0.W)             ; $00AA06
        MOVE.W  #$0078,$00B0(A0)                ; $00AA0C
        CLR.W  (-16306).W                       ; $00AA12
        DC.W    $4EFA,$E8FA         ; JMP     $009312(PC); $00AA16
.loc_00A8:
        CMPI.W  #$0080,D4                       ; $00AA1A
        BGT.S  .loc_00C0                        ; $00AA1E
        MOVE.W  D1,(-24574).W                   ; $00AA20
        MOVE.W  D2,(-24572).W                   ; $00AA24
        MOVE.W  #$0020,(-24570).W               ; $00AA28
        BRA.W  .loc_0136                        ; $00AA2E
.loc_00C0:
        CMPI.W  #$0180,D4                       ; $00AA32
        BGT.S  .loc_00E6                        ; $00AA36
        MOVE.W  D1,(-24574).W                   ; $00AA38
        MOVE.W  D2,(-24572).W                   ; $00AA3C
        SUBI.W  #$0040,(-24572).W               ; $00AA40
        MOVE.W  D4,D0                           ; $00AA46
        ASR.W  #4,D0                            ; $00AA48
        MOVE.W  D0,D3                           ; $00AA4A
        DC.W    $D040                           ; $00AA4C
        DC.W    $D043                           ; $00AA4E
        ADDQ.W  #8,D0                           ; $00AA50
        MOVE.W  D0,(-24570).W                   ; $00AA52
        BRA.S  .loc_0136                        ; $00AA56
.loc_00E6:
        CMPI.W  #$0400,D4                       ; $00AA58
        BGT.S  .loc_010E                        ; $00AA5C
        MOVE.W  D1,(-24574).W                   ; $00AA5E
        ADD.W  D5,(-24574).W                    ; $00AA62
        MOVE.W  D2,(-24572).W                   ; $00AA66
        SUBI.W  #$0080,(-24572).W               ; $00AA6A
        MOVE.W  D4,D0                           ; $00AA70
        ASR.W  #4,D0                            ; $00AA72
        DC.W    $D040                           ; $00AA74
        ADDI.W  #$0020,D0                       ; $00AA76
        MOVE.W  D0,(-24570).W                   ; $00AA7A
        BRA.S  .loc_0136                        ; $00AA7E
.loc_010E:
        MOVE.W  D1,(-24574).W                   ; $00AA80
        ADD.W  D5,(-24574).W                    ; $00AA84
        MOVE.W  D2,(-24572).W                   ; $00AA88
        SUBI.W  #$0080,(-24572).W               ; $00AA8C
        MOVE.W  D4,D0                           ; $00AA92
        ASR.W  #4,D0                            ; $00AA94
        ADDI.W  #$0064,D0                       ; $00AA96
        CMPI.W  #$00C8,D0                       ; $00AA9A
        BLE.S  .loc_0132                        ; $00AA9E
        MOVE.W  #$00C8,D0                       ; $00AAA0
.loc_0132:
        MOVE.W  D0,(-24570).W                   ; $00AAA4
.loc_0136:
        MOVE.W  $0034(A0),D0                    ; $00AAA8
        MOVE.W  $0030(A0),D1                    ; $00AAAC
        NEG.W  D1                               ; $00AAB0
        MOVE.W  (-24572).W,D2                   ; $00AAB2
        MOVE.W  (-24574).W,D3                   ; $00AAB6
        NEG.W  D3                               ; $00AABA
        DC.W    $4EBA,$FCE2         ; JSR     $00A7A0(PC); $00AABC
        MOVE.W  D0,(-24568).W                   ; $00AAC0
        SUB.W  $003C(A0),D0                     ; $00AAC4
        CMPI.W  #$0140,D0                       ; $00AAC8
        BLE.S  .loc_0160                        ; $00AACC
        MOVE.W  #$0140,D0                       ; $00AACE
.loc_0160:
        CMPI.W  #$FEC0,D0                       ; $00AAD2
        BGE.S  .loc_016A                        ; $00AAD6
        MOVE.W  #$FEC0,D0                       ; $00AAD8
.loc_016A:
        ADD.W  D0,$003C(A0)                     ; $00AADC
        MOVE.W  $003C(A0),D3                    ; $00AAE0
        BPL.S  .loc_0176                        ; $00AAE4
        NEG.W  D3                               ; $00AAE6
.loc_0176:
        CMPI.W  #$0100,D3                       ; $00AAE8
        BGE.S  .loc_0180                        ; $00AAEC
        CLR.W  $003C(A0)                        ; $00AAEE
.loc_0180:
        MOVE.W  D0,$008E(A0)                    ; $00AAF2
        MOVE.W  D0,$0090(A0)                    ; $00AAF6
        DC.W    $D040                           ; $00AAFA
        NEG.W  D0                               ; $00AAFC
        MOVE.W  D0,$0046(A0)                    ; $00AAFE
        MOVE.W  (-24568).W,D0                   ; $00AB02
        SUB.W  $0040(A0),D0                     ; $00AB06
        ASR.W  #2,D0                            ; $00AB0A
        ADD.W  D0,$0040(A0)                     ; $00AB0C
        MOVE.W  (-24570).W,D0                   ; $00AB10
        MULS    #$03E8,D0                       ; $00AB14
        LSL.L  #8,D0                            ; $00AB18
        DIVS    #$0E10,D0                       ; $00AB1A
        EXT.L   D0                              ; $00AB1E
        DIVS    #$0014,D0                       ; $00AB20
        MOVE.W  D0,(-24570).W                   ; $00AB24
        SUB.W  $0006(A0),D0                     ; $00AB28
        CMPI.W  #$002F,D0                       ; $00AB2C
        BLE.S  .loc_01C4                        ; $00AB30
        MOVE.W  #$002F,D0                       ; $00AB32
.loc_01C4:
        CMPI.W  #$FFB0,D0                       ; $00AB36
        BGE.S  .loc_01CE                        ; $00AB3A
        MOVE.W  #$FFB0,D0                       ; $00AB3C
.loc_01CE:
        ADD.W  D0,$0006(A0)                     ; $00AB40
        DC.W    $4EBA,$EFCC         ; JSR     $009B12(PC); $00AB44
        MOVE.W  $0004(A0),D0                    ; $00AB48
        ASL.W  #5,D0                            ; $00AB4C
        CMPI.W  #$11F8,D0                       ; $00AB4E
        BLE.S  .loc_01E6                        ; $00AB52
        MOVE.W  #$11F8,D0                       ; $00AB54
.loc_01E6:
        CMPI.W  #$0000,D0                       ; $00AB58
        BGE.S  .loc_01F0                        ; $00AB5C
        MOVE.W  #$0000,D0                       ; $00AB5E
.loc_01F0:
        SUB.W  D0,$00BC(A0)                     ; $00AB62
        MOVE.W  $0040(A0),D0                    ; $00AB66
        NEG.W  D0                               ; $00AB6A
        MOVE.W  $0006(A0),D2                    ; $00AB6C
        MOVE.W  $0030(A0),D3                    ; $00AB70
        MOVE.W  $0034(A0),D4                    ; $00AB74
        DC.W    $4EBA,$C464         ; JSR     $006FDE(PC); $00AB78
        MOVE.W  D3,$0030(A0)                    ; $00AB7C
        MOVE.W  D4,$0034(A0)                    ; $00AB80
        DC.W    $4EFA,$E78C         ; JMP     $009312(PC); $00AB84
        DC.W    $4EBA,$0136         ; JSR     $00ACC0(PC); $00AB88
        MOVEQ   #$78,D0                         ; $00AB8C
        SUB.W  $00B0(A0),D0                     ; $00AB8E
        MULU    #$3BBB,D0                       ; $00AB92
        SWAP    D0                              ; $00AB96
        MOVE.W  D0,(-16346).W                   ; $00AB98
        CMPI.W  #$0014,(-16346).W               ; $00AB9C
        BNE.S  .loc_023C                        ; $00ABA2
        MOVE.W  #$0000,$008A(A0)                ; $00ABA4
        DC.W    $4EBA,$F650         ; JSR     $00A1FC(PC); $00ABAA
.loc_023C:
        SUBQ.W  #1,$00B0(A0)                    ; $00ABAE
        BNE.S  .loc_0258                        ; $00ABB2
        CLR.B  $00FF6970                        ; $00ABB4
        LEA     (-16292).W,A1                   ; $00ABBA
        MOVE.W  $00AE(A0),D0                    ; $00ABBE
        DC.W    $D040                           ; $00ABC2
        MOVE.W  #$0003,$00(A1,D0.W)             ; $00ABC4
.loc_0258:
        DC.W    $4EFA,$FD2C         ; JMP     $00A8F8(PC); $00ABCA
        LEA     (-16292).W,A1                   ; $00ABCE
        MOVEQ   #$00,D0                         ; $00ABD2
        MOVE.W  $00AE(A0),D1                    ; $00ABD4
        DC.W    $D241                           ; $00ABD8
.loc_0268:
        CMP.W  D1,D0                            ; $00ABDA
        BGE.S  .loc_027A                        ; $00ABDC
        CMPI.W  #$0001,$00(A1,D1.W)             ; $00ABDE
        DC.W    $6700,$FD12         ; BEQ.W  $00A8F8; $00ABE4
        ADDQ.W  #2,D0                           ; $00ABE8
        BRA.S  .loc_0268                        ; $00ABEA
.loc_027A:
        MOVE.W  $00AE(A0),D0                    ; $00ABEC
        ADDQ.W  #1,D0                           ; $00ABF0
        DC.W    $D040                           ; $00ABF2
.loc_0282:
        CMPI.W  #$0008,D0                       ; $00ABF4
        BGE.S  .loc_0296                        ; $00ABF8
        CMPI.W  #$0004,$00(A1,D0.W)             ; $00ABFA
        DC.W    $6700,$FCF6         ; BEQ.W  $00A8F8; $00AC00
        ADDQ.W  #2,D0                           ; $00AC04
        BRA.S  .loc_0282                        ; $00AC06
.loc_0296:
        ORI.W  #$4000,$0002(A0)                 ; $00AC08
        MOVE.W  #$0050,(-16306).W               ; $00AC0E
        LEA     (-16292).W,A1                   ; $00AC14
        MOVE.W  $00AE(A0),D0                    ; $00AC18
        DC.W    $D040                           ; $00AC1C
        MOVE.W  #$0000,$00(A1,D0.W)             ; $00AC1E
        MOVE.W  #$003C,(-14162).W               ; $00AC24
        MOVE.W  (-16244).W,(-16262).W           ; $00AC2A
        BCLR    #1,(-15602).W                   ; $00AC30
        MOVE.B  #$91,(-14171).W                 ; $00AC36
        RTS                                     ; $00AC3C
