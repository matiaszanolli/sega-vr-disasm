; ============================================================================
; Obj Palette Update 041 (auto-analyzed)
; ROM Range: $005AB6-$005D08 (594 bytes)
; ============================================================================
; Category: object
; Purpose: Orchestrator calling 46 subroutines
;   RAM: $C89C (sh2_comm_state)
;   Calls: sprite_buffer_alt, effect_timer_mgmt, object_frame_timer, load_object_params
;   Object (A0): +$06 (speed), +$44 (display_offset), +$46 (display_scale), +$4A, +$74
;
; Entry: A0 = object/entity pointer
; Uses: D0, A0
; RAM:
;   $C89C: sh2_comm_state
; Calls:
;   $002984: palette_update
;   $0031A6: display_mode_dispatch
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

fn_4200_041:
        DC.W    $4EBA,$5CC4         ; JSR     $00B77C(PC); $005AB6
        MOVEQ   #$00,D0                         ; $005ABA
        MOVE.W  D0,$0044(A0)                    ; $005ABC
        MOVE.W  D0,$0046(A0)                    ; $005AC0
        MOVE.W  D0,$004A(A0)                    ; $005AC4
        DC.W    $4EBA,$2AFA         ; JSR     $0085C4(PC); $005AC8
        DC.W    $4EBA,$2ACC         ; JSR     $00859A(PC); $005ACC
        DC.W    $4EBA,$487E         ; JSR     $00A350(PC); $005AD0
        DC.W    $4EBA,$269A         ; JSR     $008170(PC); $005AD4
        DC.W    $4EBA,$25F2         ; JSR     $0080CC(PC); $005AD8
        DC.W    $4EBA,$2A6A         ; JSR     $008548(PC); $005ADC
        DC.W    $4EBA,$3A18         ; JSR     $0094FA(PC); $005AE0
        DC.W    $4EBA,$382C         ; JSR     $009312(PC); $005AE4
        DC.W    $4EBA,$4028         ; JSR     $009B12(PC); $005AE8
        DC.W    $4EBA,$3694         ; JSR     $009182(PC); $005AEC
        DC.W    $4EBA,$3B2C         ; JSR     $00961E(PC); $005AF0
        DC.W    $4EBA,$3B92         ; JSR     $009688(PC); $005AF4
        DC.W    $4EBA,$3D08         ; JSR     $009802(PC); $005AF8
        DC.W    $4EBA,$237C         ; JSR     $007E7A(PC); $005AFC
        DC.W    $4EBA,$1496         ; JSR     $006F98(PC); $005B00
        DC.W    $4EBA,$21D2         ; JSR     $007CD8(PC); $005B04
        DC.W    $4EBA,$492A         ; JSR     $00A434(PC); $005B08
        DC.W    $4EBA,$159C         ; JSR     $0070AA(PC); $005B0C
        DC.W    $4EBA,$23F2         ; JSR     $007F04(PC); $005B10
        DC.W    $4EBA,$4358         ; JSR     $009E6E(PC); $005B14
        DC.W    $4EBA,$2134         ; JSR     $007C4E(PC); $005B18
        DC.W    $4EBA,$162C         ; JSR     $00714A(PC); $005B1C
        DC.W    $4EBA,$1B2C         ; JSR     $00764E(PC); $005B20
        DC.W    $4EBA,$242A         ; JSR     $007F50(PC); $005B24
        DC.W    $4EBA,$41A4         ; JSR     $009CCE(PC); $005B28
        DC.W    $4EBA,$5110         ; JSR     $00AC3E(PC); $005B2C
        DC.W    $4EBA,$4022         ; JSR     $009B54(PC); $005B30
        DC.W    $4EBA,$2BC8         ; JSR     $0086FE(PC); $005B34
        DC.W    $4EBA,$3506         ; JSR     $009040(PC); $005B38
        DC.W    $4EBA,$5196         ; JSR     $00ACD4(PC); $005B3C
        DC.W    $4EBA,$2696         ; JSR     $0081D8(PC); $005B40
        DC.W    $4EBA,$437A         ; JSR     $009EC0(PC); $005B44
        DC.W    $4EBA,$1AB4         ; JSR     $0075FE(PC); $005B48
        DC.W    $4EBA,$1658         ; JSR     $0071A6(PC); $005B4C
        DC.W    $4EBA,$CE32         ; JSR     $002984(PC); $005B50
        DC.W    $4EBA,$D650         ; JSR     $0031A6(PC); $005B54
        DC.W    $4EBA,$DB84         ; JSR     $0036DE(PC); $005B58
        DC.W    $4EBA,$DC58         ; JSR     $0037B6(PC); $005B5C
        DC.W    $4EBA,$E424         ; JSR     $003F86(PC); $005B60
        MOVE.B  (-15612).W,(-15604).W           ; $005B64
        DC.W    $4EFA,$109C         ; JMP     $006C08(PC); $005B6A
        DC.W    $4EBA,$5C0C         ; JSR     $00B77C(PC); $005B6E
        DC.W    $4EBA,$47DC         ; JSR     $00A350(PC); $005B72
        DC.W    $4EBA,$25F8         ; JSR     $008170(PC); $005B76
        DC.W    $4EBA,$2550         ; JSR     $0080CC(PC); $005B7A
        DC.W    $4EBA,$29C8         ; JSR     $008548(PC); $005B7E
        DC.W    $4EBA,$3A9A         ; JSR     $00961E(PC); $005B82
        DC.W    $4EBA,$1C8E         ; JSR     $007816(PC); $005B86
        DC.W    $4EBA,$1AC2         ; JSR     $00764E(PC); $005B8A
        DC.W    $4EBA,$151A         ; JSR     $0070AA(PC); $005B8E
        DC.W    $4EBA,$4D4C         ; JSR     $00A8E0(PC); $005B92
        DC.W    $4EBA,$3FBC         ; JSR     $009B54(PC); $005B96
        DC.W    $4EBA,$35E6         ; JSR     $009182(PC); $005B9A
        DC.W    $4EBA,$3C62         ; JSR     $009802(PC); $005B9E
        DC.W    $4EBA,$15A6         ; JSR     $00714A(PC); $005BA2
        DC.W    $4EBA,$4126         ; JSR     $009CCE(PC); $005BA6
        DC.W    $4EBA,$2B52         ; JSR     $0086FE(PC); $005BAA
        DC.W    $4EBA,$3490         ; JSR     $009040(PC); $005BAE
        DC.W    $4EBA,$5120         ; JSR     $00ACD4(PC); $005BB2
        DC.W    $4EBA,$1A46         ; JSR     $0075FE(PC); $005BB6
        DC.W    $4EBA,$15EA         ; JSR     $0071A6(PC); $005BBA
        DC.W    $4EBA,$CDC4         ; JSR     $002984(PC); $005BBE
        DC.W    $4EBA,$D5E2         ; JSR     $0031A6(PC); $005BC2
        DC.W    $4EBA,$DB16         ; JSR     $0036DE(PC); $005BC6
        DC.W    $4EBA,$DBEA         ; JSR     $0037B6(PC); $005BCA
        DC.W    $4EBA,$E3B6         ; JSR     $003F86(PC); $005BCE
        DC.W    $4EBA,$E0F0         ; JSR     $003CC4(PC); $005BD2
        MOVE.B  (-15612).W,(-15604).W           ; $005BD6
        DC.W    $4EFA,$100C         ; JMP     $006BEA(PC); $005BDC
        MOVE.W  #$0000,$0006(A0)                ; $005BE0
        MOVE.W  #$0000,$0074(A0)                ; $005BE6
        DC.W    $4EBA,$5B8E         ; JSR     $00B77C(PC); $005BEC
        MOVEQ   #$00,D0                         ; $005BF0
        MOVE.W  D0,$0044(A0)                    ; $005BF2
        MOVE.W  D0,$0046(A0)                    ; $005BF6
        MOVE.W  D0,$004A(A0)                    ; $005BFA
        DC.W    $4EBA,$EDEE         ; JSR     $0049EE(PC); $005BFE
        DC.W    $4EBA,$2996         ; JSR     $00859A(PC); $005C02
        DC.W    $4EBA,$4748         ; JSR     $00A350(PC); $005C06
        DC.W    $4EBA,$2564         ; JSR     $008170(PC); $005C0A
        DC.W    $4EBA,$24BC         ; JSR     $0080CC(PC); $005C0E
        DC.W    $4EBA,$2934         ; JSR     $008548(PC); $005C12
        DC.W    $4EBA,$38E2         ; JSR     $0094FA(PC); $005C16
        CMPI.W  #$0004,(-15764).W               ; $005C1A
        BEQ.S  .loc_0170                        ; $005C20
        DC.W    $4EBA,$36EE         ; JSR     $009312(PC); $005C22
.loc_0170:
        DC.W    $4EBA,$3EEA         ; JSR     $009B12(PC); $005C26
        DC.W    $4EBA,$3556         ; JSR     $009182(PC); $005C2A
        DC.W    $4EBA,$3BD2         ; JSR     $009802(PC); $005C2E
        DC.W    $4EBA,$1450         ; JSR     $007084(PC); $005C32
        DC.W    $4EBA,$1472         ; JSR     $0070AA(PC); $005C36
        DC.W    $4EBA,$1BDA         ; JSR     $007816(PC); $005C3A
        SUBQ.W  #1,(-16340).W                   ; $005C3E
        BGT.S  .loc_01A0                        ; $005C42
        MOVE.W  #$0000,(-16340).W               ; $005C44
        MOVE.W  #$0000,$0074(A0)                ; $005C4A
        MOVE.W  (-16244).W,(-16262).W           ; $005C50
.loc_01A0:
        DC.W    $4EFA,$FEB8         ; JMP     $005B10(PC); $005C56
        DC.W    $4EBA,$5B20         ; JSR     $00B77C(PC); $005C5A
        MOVEQ   #$00,D0                         ; $005C5E
        MOVE.W  D0,$0044(A0)                    ; $005C60
        MOVE.W  D0,$0046(A0)                    ; $005C64
        MOVE.W  D0,$004A(A0)                    ; $005C68
        DC.W    $4EBA,$292C         ; JSR     $00859A(PC); $005C6C
        DC.W    $4EBA,$46DE         ; JSR     $00A350(PC); $005C70
        DC.W    $4EBA,$24FA         ; JSR     $008170(PC); $005C74
        DC.W    $4EBA,$2452         ; JSR     $0080CC(PC); $005C78
        DC.W    $4EBA,$28CA         ; JSR     $008548(PC); $005C7C
        DC.W    $4EBA,$3B80         ; JSR     $009802(PC); $005C80
        DC.W    $4EBA,$21F4         ; JSR     $007E7A(PC); $005C84
        DC.W    $4EBA,$130E         ; JSR     $006F98(PC); $005C88
        DC.W    $4EBA,$204A         ; JSR     $007CD8(PC); $005C8C
        DC.W    $4EBA,$47A2         ; JSR     $00A434(PC); $005C90
        DC.W    $4EBA,$1414         ; JSR     $0070AA(PC); $005C94
        DC.W    $4EBA,$226A         ; JSR     $007F04(PC); $005C98
        DC.W    $4EBA,$41D0         ; JSR     $009E6E(PC); $005C9C
        DC.W    $4EBA,$1FAC         ; JSR     $007C4E(PC); $005CA0
        DC.W    $4EBA,$14A4         ; JSR     $00714A(PC); $005CA4
        DC.W    $4EBA,$19A4         ; JSR     $00764E(PC); $005CA8
        DC.W    $4EBA,$22A2         ; JSR     $007F50(PC); $005CAC
        DC.W    $4EBA,$401C         ; JSR     $009CCE(PC); $005CB0
        DC.W    $4EBA,$4F88         ; JSR     $00AC3E(PC); $005CB4
        DC.W    $4EBA,$2A44         ; JSR     $0086FE(PC); $005CB8
        DC.W    $4EBA,$3382         ; JSR     $009040(PC); $005CBC
        DC.W    $4EBA,$2516         ; JSR     $0081D8(PC); $005CC0
        DC.W    $4EBA,$41FA         ; JSR     $009EC0(PC); $005CC4
        DC.W    $4EBA,$3954         ; JSR     $00961E(PC); $005CC8
        DC.W    $4EBA,$4C2A         ; JSR     $00A8F8(PC); $005CCC
        BTST    #4,(-15602).W                   ; $005CD0
        BEQ.S  .loc_0228                        ; $005CD6
        MOVE.W  (-16244).W,(-16262).W           ; $005CD8
.loc_0228:
        DC.W    $4EBA,$191E         ; JSR     $0075FE(PC); $005CDE
        DC.W    $4EBA,$14C2         ; JSR     $0071A6(PC); $005CE2
        DC.W    $4EBA,$CC9C         ; JSR     $002984(PC); $005CE6
        DC.W    $4EBA,$D4BA         ; JSR     $0031A6(PC); $005CEA
        DC.W    $4EBA,$D9EE         ; JSR     $0036DE(PC); $005CEE
        DC.W    $4EBA,$DAC2         ; JSR     $0037B6(PC); $005CF2
        TST.W  (-14180).W                       ; $005CF6
        BNE.S  .loc_024A                        ; $005CFA
        DC.W    $4EBA,$DFC6         ; JSR     $003CC4(PC); $005CFC
.loc_024A:
        MOVE.B  (-15612).W,(-15604).W           ; $005D00
        RTS                                     ; $005D06
