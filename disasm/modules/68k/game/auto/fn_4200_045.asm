; ============================================================================
; Obj Reg Write 045 (auto-analyzed)
; ROM Range: $005EEA-$00617A (656 bytes)
; ============================================================================
; Category: object
; Purpose: Orchestrator calling 44 subroutines
;   RAM: $C89C (sh2_comm_state)
;   Calls: effect_timer_mgmt, object_frame_timer, load_object_params, timer_countdown
;   Object (A0): +$06 (speed), +$44 (display_offset), +$46 (display_scale), +$4A, +$74
;
; Entry: A0 = object/entity pointer
; Uses: D0, A0
; RAM:
;   $C89C: sh2_comm_state
; Calls:
;   $003126: vdp_reg_write
;   $003160: vdp_dma_setup
;   $0036DE: clear_buffer
;   $0037B6: memory_copy
;   $003CC4: player_table_load
;   $003F86: clear_display_vars
; Object fields:
;   +$06: speed
;   +$44: display_offset
;   +$46: display_scale
;   +$4A: [unknown]
;   +$74: [unknown]
; Confidence: high
; ============================================================================

fn_4200_045:
        MOVEQ   #$00,D0                         ; $005EEA
        MOVE.W  D0,$0044(A0)                    ; $005EEC
        MOVE.W  D0,$0046(A0)                    ; $005EF0
        MOVE.W  D0,$004A(A0)                    ; $005EF4
        DC.W    $4EBA,$26CA         ; JSR     $0085C4(PC); $005EF8
        DC.W    $4EBA,$269C         ; JSR     $00859A(PC); $005EFC
        DC.W    $4EBA,$444E         ; JSR     $00A350(PC); $005F00
        DC.W    $4EBA,$226A         ; JSR     $008170(PC); $005F04
        DC.W    $4EBA,$21C2         ; JSR     $0080CC(PC); $005F08
        DC.W    $4EBA,$263A         ; JSR     $008548(PC); $005F0C
        DC.W    $4EBA,$35E8         ; JSR     $0094FA(PC); $005F10
        DC.W    $4EBA,$33FC         ; JSR     $009312(PC); $005F14
        DC.W    $4EBA,$3BF8         ; JSR     $009B12(PC); $005F18
        DC.W    $4EBA,$3264         ; JSR     $009182(PC); $005F1C
        DC.W    $4EBA,$36FC         ; JSR     $00961E(PC); $005F20
        DC.W    $4EBA,$3762         ; JSR     $009688(PC); $005F24
        DC.W    $4EBA,$38D8         ; JSR     $009802(PC); $005F28
        DC.W    $4EBA,$1F4C         ; JSR     $007E7A(PC); $005F2C
        DC.W    $4EBA,$1066         ; JSR     $006F98(PC); $005F30
        DC.W    $4EBA,$1DA2         ; JSR     $007CD8(PC); $005F34
        DC.W    $4EBA,$44FA         ; JSR     $00A434(PC); $005F38
        DC.W    $4EBA,$116C         ; JSR     $0070AA(PC); $005F3C
        DC.W    $4EBA,$1FC2         ; JSR     $007F04(PC); $005F40
        DC.W    $4EBA,$3F28         ; JSR     $009E6E(PC); $005F44
        DC.W    $4EBA,$1D04         ; JSR     $007C4E(PC); $005F48
        DC.W    $4EBA,$11FC         ; JSR     $00714A(PC); $005F4C
        DC.W    $4EBA,$16FC         ; JSR     $00764E(PC); $005F50
        DC.W    $4EBA,$1FFA         ; JSR     $007F50(PC); $005F54
        DC.W    $4EBA,$3D74         ; JSR     $009CCE(PC); $005F58
        DC.W    $4EBA,$4CE0         ; JSR     $00AC3E(PC); $005F5C
        DC.W    $4EBA,$3BF2         ; JSR     $009B54(PC); $005F60
        DC.W    $4EBA,$2762         ; JSR     $0086C8(PC); $005F64
        DC.W    $4EBA,$4D6A         ; JSR     $00ACD4(PC); $005F68
        DC.W    $4EBA,$3F52         ; JSR     $009EC0(PC); $005F6C
        DC.W    $4EBA,$D1B4         ; JSR     $003126(PC); $005F70
        DC.W    $4EBA,$D1EA         ; JSR     $003160(PC); $005F74
        DC.W    $4EBA,$16AA         ; JSR     $007624(PC); $005F78
        DC.W    $4EBA,$13D0         ; JSR     $00734E(PC); $005F7C
        DC.W    $4EBA,$D75C         ; JSR     $0036DE(PC); $005F80
        DC.W    $4EBA,$D830         ; JSR     $0037B6(PC); $005F84
        DC.W    $4EBA,$DFFC         ; JSR     $003F86(PC); $005F88
        DC.W    $4EBA,$30D6         ; JSR     $009064(PC); $005F8C
        MOVE.B  (-15612).W,(-15604).W           ; $005F90
        DC.W    $4EFA,$0C70         ; JMP     $006C08(PC); $005F96
        DC.W    $4EBA,$43B4         ; JSR     $00A350(PC); $005F9A
        DC.W    $4EBA,$21D0         ; JSR     $008170(PC); $005F9E
        DC.W    $4EBA,$2128         ; JSR     $0080CC(PC); $005FA2
        DC.W    $4EBA,$25A0         ; JSR     $008548(PC); $005FA6
        DC.W    $4EBA,$3672         ; JSR     $00961E(PC); $005FAA
        DC.W    $4EBA,$1866         ; JSR     $007816(PC); $005FAE
        DC.W    $4EBA,$169A         ; JSR     $00764E(PC); $005FB2
        DC.W    $4EBA,$10F2         ; JSR     $0070AA(PC); $005FB6
        DC.W    $4EBA,$4924         ; JSR     $00A8E0(PC); $005FBA
        DC.W    $4EBA,$3B94         ; JSR     $009B54(PC); $005FBE
        DC.W    $4EBA,$31BE         ; JSR     $009182(PC); $005FC2
        DC.W    $4EBA,$383A         ; JSR     $009802(PC); $005FC6
        DC.W    $4EBA,$117E         ; JSR     $00714A(PC); $005FCA
        DC.W    $4EBA,$3CFE         ; JSR     $009CCE(PC); $005FCE
        DC.W    $4EBA,$26F4         ; JSR     $0086C8(PC); $005FD2
        DC.W    $4EBA,$4CFC         ; JSR     $00ACD4(PC); $005FD6
        DC.W    $4EBA,$D14A         ; JSR     $003126(PC); $005FDA
        DC.W    $4EBA,$D180         ; JSR     $003160(PC); $005FDE
        DC.W    $4EBA,$1640         ; JSR     $007624(PC); $005FE2
        DC.W    $4EBA,$1366         ; JSR     $00734E(PC); $005FE6
        DC.W    $4EBA,$D6F2         ; JSR     $0036DE(PC); $005FEA
        DC.W    $4EBA,$D7C6         ; JSR     $0037B6(PC); $005FEE
        DC.W    $4EBA,$DF92         ; JSR     $003F86(PC); $005FF2
        DC.W    $4EBA,$DCCC         ; JSR     $003CC4(PC); $005FF6
        DC.W    $4EBA,$3068         ; JSR     $009064(PC); $005FFA
        MOVE.B  (-15612).W,(-15604).W           ; $005FFE
        DC.W    $4EFA,$0C02         ; JMP     $006C08(PC); $006004
        MOVE.W  #$0000,$0006(A0)                ; $006008
        MOVE.W  #$0000,$0074(A0)                ; $00600E
        MOVEQ   #$00,D0                         ; $006014
        MOVE.W  D0,$0044(A0)                    ; $006016
        MOVE.W  D0,$0046(A0)                    ; $00601A
        MOVE.W  D0,$004A(A0)                    ; $00601E
        DC.W    $4EBA,$E9CA         ; JSR     $0049EE(PC); $006022
        DC.W    $4EBA,$2572         ; JSR     $00859A(PC); $006026
        DC.W    $4EBA,$4324         ; JSR     $00A350(PC); $00602A
        DC.W    $4EBA,$2140         ; JSR     $008170(PC); $00602E
        DC.W    $4EBA,$2098         ; JSR     $0080CC(PC); $006032
        DC.W    $4EBA,$2510         ; JSR     $008548(PC); $006036
        DC.W    $4EBA,$34BE         ; JSR     $0094FA(PC); $00603A
        CMPI.W  #$0004,(-15764).W               ; $00603E
        BEQ.S  .loc_0160                        ; $006044
        DC.W    $4EBA,$32CA         ; JSR     $009312(PC); $006046
.loc_0160:
        DC.W    $4EBA,$3AC6         ; JSR     $009B12(PC); $00604A
        DC.W    $4EBA,$3132         ; JSR     $009182(PC); $00604E
        DC.W    $4EBA,$37AE         ; JSR     $009802(PC); $006052
        DC.W    $4EBA,$102C         ; JSR     $007084(PC); $006056
        DC.W    $4EBA,$104E         ; JSR     $0070AA(PC); $00605A
        DC.W    $4EBA,$17B6         ; JSR     $007816(PC); $00605E
        SUBQ.W  #1,(-16340).W                   ; $006062
        BGT.S  .loc_0190                        ; $006066
        MOVE.W  #$0000,(-16340).W               ; $006068
        MOVE.W  #$0000,$0074(A0)                ; $00606E
        MOVE.W  (-16244).W,(-16262).W           ; $006074
.loc_0190:
        DC.W    $4EBA,$1E88         ; JSR     $007F04(PC); $00607A
        DC.W    $4EBA,$3DEE         ; JSR     $009E6E(PC); $00607E
        DC.W    $4EBA,$1BCA         ; JSR     $007C4E(PC); $006082
        DC.W    $4EBA,$10C2         ; JSR     $00714A(PC); $006086
        DC.W    $4EBA,$15C2         ; JSR     $00764E(PC); $00608A
        DC.W    $4EBA,$1EC0         ; JSR     $007F50(PC); $00608E
        DC.W    $4EBA,$3C3A         ; JSR     $009CCE(PC); $006092
        DC.W    $4EBA,$4BA6         ; JSR     $00AC3E(PC); $006096
        DC.W    $4EBA,$3AB8         ; JSR     $009B54(PC); $00609A
        DC.W    $4EBA,$2628         ; JSR     $0086C8(PC); $00609E
        DC.W    $4EBA,$4C30         ; JSR     $00ACD4(PC); $0060A2
        DC.W    $4EBA,$3E18         ; JSR     $009EC0(PC); $0060A6
        DC.W    $4EBA,$D07A         ; JSR     $003126(PC); $0060AA
        DC.W    $4EBA,$D0B0         ; JSR     $003160(PC); $0060AE
        DC.W    $4EBA,$1570         ; JSR     $007624(PC); $0060B2
        DC.W    $4EBA,$1296         ; JSR     $00734E(PC); $0060B6
        DC.W    $4EBA,$D622         ; JSR     $0036DE(PC); $0060BA
        DC.W    $4EBA,$D6F6         ; JSR     $0037B6(PC); $0060BE
        DC.W    $4EBA,$DEC2         ; JSR     $003F86(PC); $0060C2
        DC.W    $4EBA,$2F9C         ; JSR     $009064(PC); $0060C6
        MOVE.B  (-15612).W,(-15604).W           ; $0060CA
        DC.W    $4EFA,$0B36         ; JMP     $006C08(PC); $0060D0
        MOVEQ   #$00,D0                         ; $0060D4
        MOVE.W  D0,$0044(A0)                    ; $0060D6
        MOVE.W  D0,$0046(A0)                    ; $0060DA
        MOVE.W  D0,$004A(A0)                    ; $0060DE
        DC.W    $4EBA,$24B6         ; JSR     $00859A(PC); $0060E2
        DC.W    $4EBA,$4268         ; JSR     $00A350(PC); $0060E6
        DC.W    $4EBA,$2084         ; JSR     $008170(PC); $0060EA
        DC.W    $4EBA,$1FDC         ; JSR     $0080CC(PC); $0060EE
        DC.W    $4EBA,$2454         ; JSR     $008548(PC); $0060F2
        DC.W    $4EBA,$370A         ; JSR     $009802(PC); $0060F6
        DC.W    $4EBA,$1D7E         ; JSR     $007E7A(PC); $0060FA
        DC.W    $4EBA,$0E98         ; JSR     $006F98(PC); $0060FE
        DC.W    $4EBA,$1BD4         ; JSR     $007CD8(PC); $006102
        DC.W    $4EBA,$432C         ; JSR     $00A434(PC); $006106
        DC.W    $4EBA,$0F9E         ; JSR     $0070AA(PC); $00610A
        DC.W    $4EBA,$1DF4         ; JSR     $007F04(PC); $00610E
        DC.W    $4EBA,$3D5A         ; JSR     $009E6E(PC); $006112
        DC.W    $4EBA,$1B36         ; JSR     $007C4E(PC); $006116
        DC.W    $4EBA,$102E         ; JSR     $00714A(PC); $00611A
        DC.W    $4EBA,$152E         ; JSR     $00764E(PC); $00611E
        DC.W    $4EBA,$1E2C         ; JSR     $007F50(PC); $006122
        DC.W    $4EBA,$3BA6         ; JSR     $009CCE(PC); $006126
        DC.W    $4EBA,$4B12         ; JSR     $00AC3E(PC); $00612A
        DC.W    $4EBA,$2598         ; JSR     $0086C8(PC); $00612E
        DC.W    $4EBA,$3D8C         ; JSR     $009EC0(PC); $006132
        DC.W    $4EBA,$34E6         ; JSR     $00961E(PC); $006136
        DC.W    $4EBA,$47BC         ; JSR     $00A8F8(PC); $00613A
        BTST    #4,(-15602).W                   ; $00613E
        BEQ.S  .loc_0262                        ; $006144
        MOVE.W  (-16244).W,(-16262).W           ; $006146
.loc_0262:
        DC.W    $4EBA,$CFD8         ; JSR     $003126(PC); $00614C
        DC.W    $4EBA,$D00E         ; JSR     $003160(PC); $006150
        DC.W    $4EBA,$14CE         ; JSR     $007624(PC); $006154
        DC.W    $4EBA,$11F4         ; JSR     $00734E(PC); $006158
        DC.W    $4EBA,$D580         ; JSR     $0036DE(PC); $00615C
        DC.W    $4EBA,$D654         ; JSR     $0037B6(PC); $006160
        TST.W  (-14180).W                       ; $006164
        BNE.S  .loc_0284                        ; $006168
        DC.W    $4EBA,$DB58         ; JSR     $003CC4(PC); $00616A
.loc_0284:
        DC.W    $4EBA,$2EF4         ; JSR     $009064(PC); $00616E
        MOVE.B  (-15612).W,(-15604).W           ; $006172
        RTS                                     ; $006178
