; ============================================================================
; Obj Dispatch 006 (auto-analyzed)
; ROM Range: $00677A-$006A3A (704 bytes)
; ============================================================================
; Category: object
; Purpose: State dispatcher using jump table
;   Calls: select_sprite_buffer, effect_timer_mgmt, object_frame_timer, load_object_params
;   Object (A0): +$06 (speed), +$18, +$44 (display_offset), +$46 (display_scale), +$4A, +$74
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, A0, A1, A4
; Calls:
;   $002984: palette_update
;   $0037B6: memory_copy
;   $003CC4: player_table_load
;   $003F86: clear_display_vars
;   $006F98: calc_steering
;   $007084: obj_position_update
; Object fields:
;   +$06: speed
;   +$18: [unknown]
;   +$44: display_offset
;   +$46: display_scale
;   +$4A: [unknown]
;   +$74: [unknown]
;   +$92: param_92
;   +$AC: [unknown]
; Confidence: high
; ============================================================================

fn_6200_006:
        MOVEQ   #$00,D0                         ; $00677A
        MOVE.W  D0,$0044(A0)                    ; $00677C
        MOVE.W  D0,$0046(A0)                    ; $006780
        MOVE.W  D0,$004A(A0)                    ; $006784
        MOVE.L  #$00100010,(-13968).W           ; $006788
        MOVE.B  #$00,(-15601).W                 ; $006790
        DC.W    $4EBA,$4FD8         ; JSR     $00B770(PC); $006796
        MOVE.W  #$0002,$0092(A0)                ; $00679A
        DC.W    $4EBA,$1DF8         ; JSR     $00859A(PC); $0067A0
        DC.W    $4EBA,$3BAA         ; JSR     $00A350(PC); $0067A4
        DC.W    $4EBA,$19C6         ; JSR     $008170(PC); $0067A8
        DC.W    $4EBA,$191E         ; JSR     $0080CC(PC); $0067AC
        DC.W    $4EBA,$1D96         ; JSR     $008548(PC); $0067B0
        DC.W    $4EBA,$2D44         ; JSR     $0094FA(PC); $0067B4
        DC.W    $4EBA,$2B58         ; JSR     $009312(PC); $0067B8
        DC.W    $4EBA,$3354         ; JSR     $009B12(PC); $0067BC
        DC.W    $4EBA,$29C0         ; JSR     $009182(PC); $0067C0
        DC.W    $4EBA,$2E58         ; JSR     $00961E(PC); $0067C4
        DC.W    $4EBA,$2EBE         ; JSR     $009688(PC); $0067C8
        DC.W    $4EBA,$3034         ; JSR     $009802(PC); $0067CC
        DC.W    $4EBA,$16A8         ; JSR     $007E7A(PC); $0067D0
        DC.W    $4EBA,$07C2         ; JSR     $006F98(PC); $0067D4
        DC.W    $4EBA,$14FE         ; JSR     $007CD8(PC); $0067D8
        DC.W    $4EBA,$3C56         ; JSR     $00A434(PC); $0067DC
        DC.W    $4EBA,$08C8         ; JSR     $0070AA(PC); $0067E0
        DC.W    $4EBA,$1468         ; JSR     $007C4E(PC); $0067E4
        DC.W    $4EBA,$0960         ; JSR     $00714A(PC); $0067E8
        DC.W    $4EBA,$0E60         ; JSR     $00764E(PC); $0067EC
        DC.W    $4EBA,$1840         ; JSR     $008032(PC); $0067F0
        DC.W    $4EBA,$335E         ; JSR     $009B54(PC); $0067F4
        DC.W    $4EBA,$DCEE         ; JSR     $0044E8(PC); $0067F8
        DC.W    $4EBA,$C918         ; JSR     $003116(PC); $0067FC
        DC.W    $4EFA,$DD1A         ; JMP     $00451C(PC); $006800
        DC.W    $4EBA,$4F6A         ; JSR     $00B770(PC); $006804
        DC.W    $4EBA,$3B46         ; JSR     $00A350(PC); $006808
        DC.W    $4EBA,$1962         ; JSR     $008170(PC); $00680C
        DC.W    $4EBA,$18BA         ; JSR     $0080CC(PC); $006810
        DC.W    $4EBA,$1D32         ; JSR     $008548(PC); $006814
        DC.W    $4EBA,$2E04         ; JSR     $00961E(PC); $006818
        DC.W    $4EBA,$0FF8         ; JSR     $007816(PC); $00681C
        DC.W    $4EBA,$0E2C         ; JSR     $00764E(PC); $006820
        DC.W    $4EBA,$0884         ; JSR     $0070AA(PC); $006824
        DC.W    $4EBA,$40B6         ; JSR     $00A8E0(PC); $006828
        DC.W    $4EBA,$3326         ; JSR     $009B54(PC); $00682C
        DC.W    $4EBA,$2950         ; JSR     $009182(PC); $006830
        DC.W    $4EBA,$2FCC         ; JSR     $009802(PC); $006834
        DC.W    $4EBA,$0910         ; JSR     $00714A(PC); $006838
        DC.W    $4EFA,$D486         ; JMP     $003CC4(PC); $00683C
        LEA     (-24576).W,A4                   ; $006840
        LEA     (-28672).W,A0                   ; $006844
        MOVE.W  #$0002,$00AC(A0)                ; $006848
        MOVE.B  (-342).W,(-15601).W             ; $00684E
        DC.W    $4EBA,$0368         ; JSR     $006BBE(PC); $006854
        MOVE.L  $00B2(A0),$0018(A0)             ; $006858
        MOVE.B  $00E5(A0),D1                    ; $00685E
        ANDI.B  #$06,D1                         ; $006862
        BEQ.S  .loc_00F4                        ; $006866
        MOVE.L  (-14580).W,$0018(A0)            ; $006868
.loc_00F4:
        MOVE.W  (-16262).W,D0                   ; $00686E
        MOVEA.L $0068A8(PC,D0.W),A1             ; $006872
        JSR     (A1)                            ; $006876
        DC.W    $4EBA,$168A         ; JSR     $007F04(PC); $006878
.loc_0102:
        DC.W    $4EBA,$27C2         ; JSR     $009040(PC); $00687C
        DC.W    $4EBA,$19DA         ; JSR     $00825C(PC); $006880
        DC.W    $4EBA,$363A         ; JSR     $009EC0(PC); $006884
.loc_010E:
        DC.W    $4EBA,$0D74         ; JSR     $0075FE(PC); $006888
        DC.W    $4EBA,$0918         ; JSR     $0071A6(PC); $00688C
        DC.W    $4EBA,$C0F2         ; JSR     $002984(PC); $006890
        DC.W    $4EBA,$CC52         ; JSR     $0034E8(PC); $006894
        DC.W    $4EBA,$CF1C         ; JSR     $0037B6(PC); $006898
        DC.W    $4EBA,$D6E8         ; JSR     $003F86(PC); $00689C
        DC.W    $4EBA,$D422         ; JSR     $003CC4(PC); $0068A0
        DC.W    $4EFA,$0344         ; JMP     $006BEA(PC); $0068A4
        DC.W    $0088                           ; $0068A8
        BVC.S  $006874                          ; $0068AA
        DC.W    $0088                           ; $0068AC
        BPL.S  .loc_0102                        ; $0068AE
        DC.W    $0088                           ; $0068B0
        BVS.S  .loc_0178                        ; $0068B2
        DC.W    $0088                           ; $0068B4
        BVS.S  .loc_010E                        ; $0068B6
        DC.W    $0088                           ; $0068B8
        BPL.S  .loc_017C                        ; $0068BA
        DC.W    $0088                           ; $0068BC
        BPL.S  $0068F8                          ; $0068BE
        DC.W    $0088                           ; $0068C0
        BMI.S  .loc_014E                        ; $0068C2
        DC.W    $0088                           ; $0068C4
        BVS.S  .loc_0198                        ; $0068C6
.loc_014E:
        DC.W    $4EBA,$4EA6         ; JSR     $00B770(PC); $0068C8
        MOVEQ   #$00,D0                         ; $0068CC
        MOVE.W  D0,$0044(A0)                    ; $0068CE
        MOVE.W  D0,$0046(A0)                    ; $0068D2
        MOVE.W  D0,$004A(A0)                    ; $0068D6
        DC.W    $4EBA,$1CE8         ; JSR     $0085C4(PC); $0068DA
        DC.W    $4EBA,$1CBA         ; JSR     $00859A(PC); $0068DE
        DC.W    $4EBA,$3A6C         ; JSR     $00A350(PC); $0068E2
        DC.W    $4EBA,$1888         ; JSR     $008170(PC); $0068E6
        DC.W    $4EBA,$17E0         ; JSR     $0080CC(PC); $0068EA
        DC.W    $4EBA,$1C58         ; JSR     $008548(PC); $0068EE
.loc_0178:
        DC.W    $4EBA,$2C06         ; JSR     $0094FA(PC); $0068F2
.loc_017C:
        DC.W    $4EBA,$2A1A         ; JSR     $009312(PC); $0068F6
        DC.W    $4EBA,$3216         ; JSR     $009B12(PC); $0068FA
        DC.W    $4EBA,$2882         ; JSR     $009182(PC); $0068FE
        DC.W    $4EBA,$2D1A         ; JSR     $00961E(PC); $006902
        DC.W    $4EBA,$2D80         ; JSR     $009688(PC); $006906
        DC.W    $4EBA,$2EF6         ; JSR     $009802(PC); $00690A
        DC.W    $4EBA,$156A         ; JSR     $007E7A(PC); $00690E
.loc_0198:
        DC.W    $4EBA,$0684         ; JSR     $006F98(PC); $006912
        DC.W    $4EBA,$13C0         ; JSR     $007CD8(PC); $006916
        DC.W    $4EBA,$3B18         ; JSR     $00A434(PC); $00691A
        DC.W    $4EBA,$078A         ; JSR     $0070AA(PC); $00691E
        DC.W    $4EBA,$354A         ; JSR     $009E6E(PC); $006922
        DC.W    $4EBA,$1326         ; JSR     $007C4E(PC); $006926
        DC.W    $4EBA,$081E         ; JSR     $00714A(PC); $00692A
        DC.W    $4EBA,$0D1E         ; JSR     $00764E(PC); $00692E
        DC.W    $4EBA,$161C         ; JSR     $007F50(PC); $006932
        DC.W    $4EBA,$4306         ; JSR     $00AC3E(PC); $006936
        DC.W    $4EFA,$3218         ; JMP     $009B54(PC); $00693A
        MOVE.W  #$0000,$0006(A0)                ; $00693E
        MOVE.W  #$0000,$0074(A0)                ; $006944
        DC.W    $4EBA,$4E24         ; JSR     $00B770(PC); $00694A
        MOVEQ   #$00,D0                         ; $00694E
        MOVE.W  D0,$0044(A0)                    ; $006950
        MOVE.W  D0,$0046(A0)                    ; $006954
        MOVE.W  D0,$004A(A0)                    ; $006958
        DC.W    $4EBA,$E0AE         ; JSR     $004A0C(PC); $00695C
        DC.W    $4EBA,$1C38         ; JSR     $00859A(PC); $006960
        DC.W    $4EBA,$39EA         ; JSR     $00A350(PC); $006964
        DC.W    $4EBA,$1806         ; JSR     $008170(PC); $006968
        DC.W    $4EBA,$175E         ; JSR     $0080CC(PC); $00696C
        DC.W    $4EBA,$1BD6         ; JSR     $008548(PC); $006970
        DC.W    $4EBA,$2B84         ; JSR     $0094FA(PC); $006974
        CMPI.W  #$0004,(-15764).W               ; $006978
        BEQ.S  .loc_020A                        ; $00697E
        DC.W    $4EBA,$2990         ; JSR     $009312(PC); $006980
.loc_020A:
        DC.W    $4EBA,$318C         ; JSR     $009B12(PC); $006984
        DC.W    $4EBA,$27F8         ; JSR     $009182(PC); $006988
        DC.W    $4EBA,$2E74         ; JSR     $009802(PC); $00698C
        DC.W    $4EBA,$06F2         ; JSR     $007084(PC); $006990
        DC.W    $4EBA,$0714         ; JSR     $0070AA(PC); $006994
        DC.W    $4EBA,$0E7C         ; JSR     $007816(PC); $006998
        SUBQ.W  #1,(-16340).W                   ; $00699C
        BGT.S  .loc_023A                        ; $0069A0
        MOVE.W  #$0000,(-16340).W               ; $0069A2
        MOVE.W  #$0000,$0074(A0)                ; $0069A8
        MOVE.W  (-16244).W,(-16262).W           ; $0069AE
.loc_023A:
        DC.W    $4EBA,$34B8         ; JSR     $009E6E(PC); $0069B4
        DC.W    $4EBA,$1294         ; JSR     $007C4E(PC); $0069B8
        DC.W    $4EBA,$078C         ; JSR     $00714A(PC); $0069BC
        DC.W    $4EBA,$0C8C         ; JSR     $00764E(PC); $0069C0
        DC.W    $4EBA,$158A         ; JSR     $007F50(PC); $0069C4
        DC.W    $4EBA,$4274         ; JSR     $00AC3E(PC); $0069C8
        DC.W    $4EFA,$3186         ; JMP     $009B54(PC); $0069CC
        DC.W    $4EBA,$4D9E         ; JSR     $00B770(PC); $0069D0
        MOVEQ   #$00,D0                         ; $0069D4
        MOVE.W  D0,$0044(A0)                    ; $0069D6
        MOVE.W  D0,$0046(A0)                    ; $0069DA
        MOVE.W  D0,$004A(A0)                    ; $0069DE
        DC.W    $4EBA,$1BB6         ; JSR     $00859A(PC); $0069E2
        DC.W    $4EBA,$3968         ; JSR     $00A350(PC); $0069E6
        DC.W    $4EBA,$1784         ; JSR     $008170(PC); $0069EA
        DC.W    $4EBA,$16DC         ; JSR     $0080CC(PC); $0069EE
        DC.W    $4EBA,$1B54         ; JSR     $008548(PC); $0069F2
        DC.W    $4EBA,$2E0A         ; JSR     $009802(PC); $0069F6
        DC.W    $4EBA,$147E         ; JSR     $007E7A(PC); $0069FA
        DC.W    $4EBA,$0598         ; JSR     $006F98(PC); $0069FE
        DC.W    $4EBA,$12D4         ; JSR     $007CD8(PC); $006A02
        DC.W    $4EBA,$3A2C         ; JSR     $00A434(PC); $006A06
        DC.W    $4EBA,$069E         ; JSR     $0070AA(PC); $006A0A
        DC.W    $4EBA,$345E         ; JSR     $009E6E(PC); $006A0E
        DC.W    $4EBA,$123A         ; JSR     $007C4E(PC); $006A12
        DC.W    $4EBA,$0732         ; JSR     $00714A(PC); $006A16
        DC.W    $4EBA,$0C32         ; JSR     $00764E(PC); $006A1A
        DC.W    $4EBA,$1530         ; JSR     $007F50(PC); $006A1E
        DC.W    $4EBA,$2BFA         ; JSR     $00961E(PC); $006A22
        DC.W    $4EBA,$3ED0         ; JSR     $00A8F8(PC); $006A26
        BTST    #4,(-15602).W                   ; $006A2A
        BEQ.S  .loc_02BE                        ; $006A30
        MOVE.W  (-16244).W,(-16262).W           ; $006A32
.loc_02BE:
        RTS                                     ; $006A38
