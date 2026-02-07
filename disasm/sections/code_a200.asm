; ============================================================================
; Code Section ($00A200-$00C1FF)
; Generated from ROM bytes - guaranteed accurate
; ============================================================================

        org     $00A200

; ============================================================================
; Physics Lookup Tables ($00A200-$00A34F)
; Translated from dc.w format - see disasm/modules/68k/game/physics_lookup_tables.asm
; ============================================================================
        include "modules/68k/game/physics_lookup_tables.asm"

; ============================================================================
; Effect Timer Management ($00A350-$00A3B8)
; Translated from dc.w format - see disasm/modules/68k/game/effect_timer_mgmt.asm
; ============================================================================
        include "modules/68k/game/effect_timer_mgmt.asm"

; ============================================================================
; Speed Calculation ($00A3BA-$00A3E8)
; Translated from dc.w format - see disasm/modules/68k/game/speed_calculation.asm
; ============================================================================
        include "modules/68k/game/speed_calculation.asm"

; ============================================================================
; Speed Interpolation ($00A3EA-$00A432)
; Translated from dc.w format - see disasm/modules/68k/game/speed_interpolation.asm
; ============================================================================
        include "modules/68k/game/speed_interpolation.asm"

; ============================================================================
; AI Opponent Select ($00A434-$00A46E)
; Translated from dc.w format - see disasm/modules/68k/game/ai_opponent_select.asm
; ============================================================================
        include "modules/68k/game/ai_opponent_select.asm"

        dc.w    $2668        ; $00A470
        dc.w    $0018        ; $00A472
        dc.w    $3028        ; $00A474
        dc.w    $0024        ; $00A476
        dc.w    $3200        ; $00A478
        dc.w    $D040        ; $00A47A
        dc.w    $D240        ; $00A47C
        dc.w    $D241        ; $00A47E
        dc.w    $21F3        ; $00A480
        dc.w    $100C        ; $00A482
        dc.w    $A000        ; $00A484
        dc.w    $303C        ; $00A486
        dc.w    $0096        ; $00A488
        dc.w    $4A68        ; $00A48A
        dc.w    $006A        ; $00A48C
        dc.w    $661A        ; $00A48E
        dc.w    $3028        ; $00A490
        dc.w    $000A        ; $00A492
        dc.w    $2278        ; $00A494
        dc.w    $C280        ; $00A496
        dc.w    $3428        ; $00A498
        dc.w    $00C2        ; $00A49A
        dc.w    $E642        ; $00A49C
        dc.w    $3431        ; $00A49E
        dc.w    $2000        ; $00A4A0
        dc.w    $C5F3        ; $00A4A2
        dc.w    $1004        ; $00A4A4
        dc.w    $E082        ; $00A4A6
        dc.w    $D042        ; $00A4A8
        dc.w    $3140        ; $00A4AA
        dc.w    $0008        ; $00A4AC
        dc.w    $0828        ; $00A4AE
        dc.w    $0001        ; $00A4B0
        dc.w    $0055        ; $00A4B2
        dc.w    $6700        ; $00A4B4
        dc.w    $01B0        ; $00A4B6
        dc.w    $3028        ; $00A4B8
        dc.w    $00A4        ; $00A4BA
        dc.w    $6700        ; $00A4BC
        dc.w    $023A        ; $00A4BE
        dc.w    $43F8        ; $00A4C0
        dc.w    $9000        ; $00A4C2
        dc.w    $E140        ; $00A4C4
        dc.w    $43F1        ; $00A4C6
        dc.w    $0000        ; $00A4C8
        dc.w    $4A69        ; $00A4CA
        dc.w    $00A4        ; $00A4CC
        dc.w    $6700        ; $00A4CE
        dc.w    $0228        ; $00A4D0
        dc.w    $43F8        ; $00A4D2
        dc.w    $9000        ; $00A4D4
        dc.w    $3028        ; $00A4D6
        dc.w    $00A6        ; $00A4D8
        dc.w    $670A        ; $00A4DA
        dc.w    $0C68        ; $00A4DC
        dc.w    $0082        ; $00A4DE
        dc.w    $0004        ; $00A4E0
        dc.w    $6D00        ; $00A4E2
        dc.w    $0182        ; $00A4E4
        dc.w    $E140        ; $00A4E6
        dc.w    $43F1        ; $00A4E8
        dc.w    $0000        ; $00A4EA
        dc.w    $3029        ; $00A4EC
        dc.w    $0030        ; $00A4EE
        dc.w    $9068        ; $00A4F0
        dc.w    $0030        ; $00A4F2
        dc.w    $6A02        ; $00A4F4
        dc.w    $4440        ; $00A4F6
        dc.w    $3E29        ; $00A4F8
        dc.w    $0034        ; $00A4FA
        dc.w    $9E68        ; $00A4FC
        dc.w    $0034        ; $00A4FE
        dc.w    $6A02        ; $00A500
        dc.w    $4447        ; $00A502
        dc.w    $DE40        ; $00A504
        dc.w    $3629        ; $00A506
        dc.w    $0072        ; $00A508
        dc.w    $9668        ; $00A50A
        dc.w    $0072        ; $00A50C
        dc.w    $3C03        ; $00A50E
        dc.w    $6A02        ; $00A510
        dc.w    $4446        ; $00A512
        dc.w    $0C47        ; $00A514
        dc.w    $0140        ; $00A516
        dc.w    $6C00        ; $00A518
        dc.w    $0068        ; $00A51A
        dc.w    $0C47        ; $00A51C
        dc.w    $00A0        ; $00A51E
        dc.w    $6F0C        ; $00A520
        dc.w    $3028        ; $00A522
        dc.w    $0004        ; $00A524
        dc.w    $9069        ; $00A526
        dc.w    $0004        ; $00A528
        dc.w    $6E00        ; $00A52A
        dc.w    $0030        ; $00A52C
        dc.w    $0C46        ; $00A52E
        dc.w    $0040        ; $00A530
        dc.w    $6C28        ; $00A532
        dc.w    $7040        ; $00A534
        dc.w    $9046        ; $00A536
        dc.w    $4A43        ; $00A538
        dc.w    $6A02        ; $00A53A
        dc.w    $4440        ; $00A53C
        dc.w    $0C78        ; $00A53E
        dc.w    $001C        ; $00A540
        dc.w    $C07A        ; $00A542
        dc.w    $670A        ; $00A544
        dc.w    $D040        ; $00A546
        dc.w    $3200        ; $00A548
        dc.w    $D040        ; $00A54A
        dc.w    $D041        ; $00A54C
        dc.w    $6008        ; $00A54E
        dc.w    $E540        ; $00A550
        dc.w    $3200        ; $00A552
        dc.w    $E741        ; $00A554
        dc.w    $D041        ; $00A556
        dc.w    $D168        ; $00A558
        dc.w    $0040        ; $00A55A
        dc.w    $0C47        ; $00A55C
        dc.w    $0070        ; $00A55E
        dc.w    $6C20        ; $00A560
        dc.w    $3029        ; $00A562
        dc.w    $0040        ; $00A564
        dc.w    $9068        ; $00A566
        dc.w    $0040        ; $00A568
        dc.w    $3200        ; $00A56A
        dc.w    $4A43        ; $00A56C
        dc.w    $6D02        ; $00A56E
        dc.w    $4441        ; $00A570
        dc.w    $4A41        ; $00A572
        dc.w    $6D0C        ; $00A574
        dc.w    $0C41        ; $00A576
        dc.w    $1800        ; $00A578
        dc.w    $6C06        ; $00A57A
        dc.w    $E240        ; $00A57C
        dc.w    $D168        ; $00A57E
        dc.w    $0040        ; $00A580
        dc.w    $45F8        ; $00A582
        dc.w    $9000        ; $00A584
        dc.w    $3028        ; $00A586
        dc.w    $00A4        ; $00A588
        dc.w    $E148        ; $00A58A
        dc.w    $43F2        ; $00A58C
        dc.w    $0000        ; $00A58E
        dc.w    $3029        ; $00A590
        dc.w    $00A4        ; $00A592
        dc.w    $6616        ; $00A594
        dc.w    $E148        ; $00A596
        dc.w    $45F2        ; $00A598
        dc.w    $0000        ; $00A59A
        dc.w    $302A        ; $00A59C
        dc.w    $0024        ; $00A59E
        dc.w    $9069        ; $00A5A0
        dc.w    $0024        ; $00A5A2
        dc.w    $0C40        ; $00A5A4
        dc.w    $0004        ; $00A5A6
        dc.w    $6E02        ; $00A5A8
        dc.w    $43D2        ; $00A5AA
        dc.w    $3029        ; $00A5AC
        dc.w    $0030        ; $00A5AE
        dc.w    $9068        ; $00A5B0
        dc.w    $0030        ; $00A5B2
        dc.w    $6A02        ; $00A5B4
        dc.w    $4440        ; $00A5B6
        dc.w    $3E29        ; $00A5B8
        dc.w    $0034        ; $00A5BA
        dc.w    $9E68        ; $00A5BC
        dc.w    $0034        ; $00A5BE
        dc.w    $6A02        ; $00A5C0
        dc.w    $4447        ; $00A5C2
        dc.w    $DE40        ; $00A5C4
        dc.w    $3629        ; $00A5C6
        dc.w    $0072        ; $00A5C8
        dc.w    $9668        ; $00A5CA
        dc.w    $0072        ; $00A5CC
        dc.w    $3C03        ; $00A5CE
        dc.w    $6A02        ; $00A5D0
        dc.w    $4446        ; $00A5D2
        dc.w    $3029        ; $00A5D4
        dc.w    $0006        ; $00A5D6
        dc.w    $9068        ; $00A5D8
        dc.w    $0006        ; $00A5DA
        dc.w    $6C28        ; $00A5DC
        dc.w    $0C47        ; $00A5DE
        dc.w    $01E0        ; $00A5E0
        dc.w    $6E22        ; $00A5E2
        dc.w    $0C47        ; $00A5E4
        dc.w    $0040        ; $00A5E6
        dc.w    $6F1C        ; $00A5E8
        dc.w    $0C46        ; $00A5EA
        dc.w    $0030        ; $00A5EC
        dc.w    $6E16        ; $00A5EE
        dc.w    $0C68        ; $00A5F0
        dc.w    $0064        ; $00A5F2
        dc.w    $0004        ; $00A5F4
        dc.w    $6F0E        ; $00A5F6
        dc.w    $323C        ; $00A5F8
        dc.w    $01E0        ; $00A5FA
        dc.w    $9247        ; $00A5FC
        dc.w    $EC41        ; $00A5FE
        dc.w    $E360        ; $00A600
        dc.w    $D168        ; $00A602
        dc.w    $0008        ; $00A604
        dc.w    $0C46        ; $00A606
        dc.w    $0070        ; $00A608
        dc.w    $6C00        ; $00A60A
        dc.w    $0034        ; $00A60C
        dc.w    $4A40        ; $00A60E
        dc.w    $6F06        ; $00A610
        dc.w    $0C47        ; $00A612
        dc.w    $00A0        ; $00A614
        dc.w    $6E28        ; $00A616
        dc.w    $4440        ; $00A618
        dc.w    $E240        ; $00A61A
        dc.w    $0640        ; $00A61C
        dc.w    $0A00        ; $00A61E
        dc.w    $3207        ; $00A620
        dc.w    $E941        ; $00A622
        dc.w    $B041        ; $00A624
        dc.w    $6E18        ; $00A626
        dc.w    $0C46        ; $00A628
        dc.w    $0040        ; $00A62A
        dc.w    $6C12        ; $00A62C
        dc.w    $7040        ; $00A62E
        dc.w    $9046        ; $00A630
        dc.w    $4A43        ; $00A632
        dc.w    $6A02        ; $00A634
        dc.w    $4440        ; $00A636
        dc.w    $D040        ; $00A638
        dc.w    $D040        ; $00A63A
        dc.w    $D168        ; $00A63C
        dc.w    $0040        ; $00A63E
        dc.w    $0C47        ; $00A640
        dc.w    $0070        ; $00A642
        dc.w    $6C20        ; $00A644
        dc.w    $3029        ; $00A646
        dc.w    $0040        ; $00A648
        dc.w    $9068        ; $00A64A
        dc.w    $0040        ; $00A64C
        dc.w    $3200        ; $00A64E
        dc.w    $4A43        ; $00A650
        dc.w    $6D02        ; $00A652
        dc.w    $4441        ; $00A654
        dc.w    $4A41        ; $00A656
        dc.w    $6F0C        ; $00A658
        dc.w    $0C41        ; $00A65A
        dc.w    $1800        ; $00A65C
        dc.w    $6C06        ; $00A65E
        dc.w    $E240        ; $00A660
        dc.w    $D168        ; $00A662
        dc.w    $0040        ; $00A664
; ============================================================================
; Physics Integration ($00A666-$00A6F6)
; Translated from dc.w format - see disasm/modules/68k/game/physics_integration.asm
; ============================================================================
        include "modules/68k/game/physics_integration.asm"

        dc.w    $43F8        ; $00A6F8
        dc.w    $9000        ; $00A6FA
        dc.w    $3029        ; $00A6FC
        dc.w    $0030        ; $00A6FE
        dc.w    $9068        ; $00A700
        dc.w    $0030        ; $00A702
        dc.w    $6A02        ; $00A704
        dc.w    $4440        ; $00A706
        dc.w    $3E29        ; $00A708
        dc.w    $0034        ; $00A70A
        dc.w    $9E68        ; $00A70C
        dc.w    $0034        ; $00A70E
        dc.w    $6A02        ; $00A710
        dc.w    $4447        ; $00A712
        dc.w    $DE40        ; $00A714
        dc.w    $3629        ; $00A716
        dc.w    $0072        ; $00A718
        dc.w    $9668        ; $00A71A
        dc.w    $0072        ; $00A71C
        dc.w    $3C03        ; $00A71E
        dc.w    $6A02        ; $00A720
        dc.w    $4446        ; $00A722
        dc.w    $3029        ; $00A724
        dc.w    $0006        ; $00A726
        dc.w    $9068        ; $00A728
        dc.w    $0006        ; $00A72A
        dc.w    $6C00        ; $00A72C
        dc.w    $FF38        ; $00A72E
        dc.w    $0C47        ; $00A730
        dc.w    $0230        ; $00A732
        dc.w    $6E00        ; $00A734
        dc.w    $FF30        ; $00A736
        dc.w    $0C46        ; $00A738
        dc.w    $0040        ; $00A73A
        dc.w    $6E00        ; $00A73C
        dc.w    $FF28        ; $00A73E
        dc.w    $0C68        ; $00A740
        dc.w    $0064        ; $00A742
        dc.w    $0004        ; $00A744
        dc.w    $6F54        ; $00A746
        dc.w    $323C        ; $00A748
        dc.w    $0230        ; $00A74A
        dc.w    $9247        ; $00A74C
        dc.w    $EC41        ; $00A74E
        dc.w    $E360        ; $00A750
        dc.w    $D168        ; $00A752
        dc.w    $0008        ; $00A754
        dc.w    $6A04        ; $00A756
        dc.w    $4268        ; $00A758
        dc.w    $0008        ; $00A75A
        dc.w    $0C46        ; $00A75C
        dc.w    $0070        ; $00A75E
        dc.w    $6C00        ; $00A760
        dc.w    $003A        ; $00A762
        dc.w    $4A40        ; $00A764
        dc.w    $6F06        ; $00A766
        dc.w    $0C47        ; $00A768
        dc.w    $00F0        ; $00A76A
        dc.w    $6E2E        ; $00A76C
        dc.w    $4440        ; $00A76E
        dc.w    $E240        ; $00A770
        dc.w    $0640        ; $00A772
        dc.w    $0F00        ; $00A774
        dc.w    $3207        ; $00A776
        dc.w    $E941        ; $00A778
        dc.w    $B041        ; $00A77A
        dc.w    $6E1E        ; $00A77C
        dc.w    $0C46        ; $00A77E
        dc.w    $0060        ; $00A780
        dc.w    $6C00        ; $00A782
        dc.w    $0018        ; $00A784
        dc.w    $7060        ; $00A786
        dc.w    $9046        ; $00A788
        dc.w    $4A43        ; $00A78A
        dc.w    $6A02        ; $00A78C
        dc.w    $4440        ; $00A78E
        dc.w    $E740        ; $00A790
        dc.w    $3200        ; $00A792
        dc.w    $D241        ; $00A794
        dc.w    $D041        ; $00A796
        dc.w    $D168        ; $00A798
        dc.w    $0040        ; $00A79A
        dc.w    $6000        ; $00A79C
        dc.w    $FEC8        ; $00A79E
; ============================================================================
; AI Steering Calculation ($00A7A0-$00A7E0)
; Translated from dc.w format - see disasm/modules/68k/game/ai_steering_calc.asm
; ============================================================================
        include "modules/68k/game/ai_steering_calc.asm"

; ============================================================================
; Entity Table Load ($00A7E2-$00A808)
; Translated from dc.w format - see disasm/modules/68k/game/entity_table_load.asm
; ============================================================================
        include "modules/68k/game/entity_table_load.asm"

; ============================================================================
; Entity Table Load Mode ($00A80A-$00A83C)
; Translated from dc.w format - see disasm/modules/68k/game/entity_table_load_mode.asm
; ============================================================================
        include "modules/68k/game/entity_table_load_mode.asm"

; ============================================================================
; Bulk Table Copy ($00A83E-$00A866)
; Translated from dc.w format - see disasm/modules/68k/game/bulk_table_copy.asm
; ============================================================================
        include "modules/68k/game/bulk_table_copy.asm"

        dc.w    $F190        ; $00A868
        dc.w    $F1F0        ; $00A86A
        dc.w    $F128        ; $00A86C
        dc.w    $F060        ; $00A86E
        dc.w    $F128        ; $00A870
        dc.w    $EED0        ; $00A872
        dc.w    $F128        ; $00A874
        dc.w    $ED40        ; $00A876
        dc.w    $F128        ; $00A878
        dc.w    $F380        ; $00A87A
        dc.w    $F128        ; $00A87C
        dc.w    $F060        ; $00A87E
        dc.w    $F128        ; $00A880
        dc.w    $ED40        ; $00A882
        dc.w    $F128        ; $00A884
        dc.w    $EA20        ; $00A886
        dc.w    $EA70        ; $00A888
        dc.w    $FB50        ; $00A88A
        dc.w    $EA70        ; $00A88C
        dc.w    $FA88        ; $00A88E
        dc.w    $EA70        ; $00A890
        dc.w    $F9C0        ; $00A892
        dc.w    $EA70        ; $00A894
        dc.w    $F8F8        ; $00A896
        dc.w    $E900        ; $00A898
        dc.w    $0800        ; $00A89A
        dc.w    $F128        ; $00A89C
        dc.w    $F060        ; $00A89E
        dc.w    $F128        ; $00A8A0
        dc.w    $ED40        ; $00A8A2
        dc.w    $F128        ; $00A8A4
        dc.w    $EA20        ; $00A8A6
        dc.w    $F128        ; $00A8A8
        dc.w    $F380        ; $00A8AA
        dc.w    $F128        ; $00A8AC
        dc.w    $F060        ; $00A8AE
        dc.w    $F128        ; $00A8B0
        dc.w    $ED40        ; $00A8B2
        dc.w    $F128        ; $00A8B4
        dc.w    $EA20        ; $00A8B6
        dc.w    $F128        ; $00A8B8
        dc.w    $F380        ; $00A8BA
        dc.w    $F128        ; $00A8BC
        dc.w    $F060        ; $00A8BE
        dc.w    $F128        ; $00A8C0
        dc.w    $ED40        ; $00A8C2
        dc.w    $F128        ; $00A8C4
        dc.w    $EA20        ; $00A8C6
        dc.w    $0100        ; $00A8C8
        dc.w    $0080        ; $00A8CA
        dc.w    $0080        ; $00A8CC
        dc.w    $0080        ; $00A8CE
        dc.w    $0080        ; $00A8D0
        dc.w    $0080        ; $00A8D2
        dc.w    $0088        ; $00A8D4
        dc.w    $A972        ; $00A8D6
        dc.w    $0088        ; $00A8D8
        dc.w    $AB88        ; $00A8DA
        dc.w    $0088        ; $00A8DC
        dc.w    $ABCE        ; $00A8DE
        dc.w    $3028        ; $00A8E0
        dc.w    $00AE        ; $00A8E2
        dc.w    $D040        ; $00A8E4
        dc.w    $43F8        ; $00A8E6
        dc.w    $C05C        ; $00A8E8
        dc.w    $3031        ; $00A8EA
        dc.w    $0000        ; $00A8EC
        dc.w    $D040        ; $00A8EE
        dc.w    $D040        ; $00A8F0
        dc.w    $227B        ; $00A8F2
        dc.w    $00DC        ; $00A8F4
        dc.w    $4ED1        ; $00A8F6
; ============================================================================
; Object State Return ($00A8F8-$00A970)
; Translated from dc.w format - see disasm/modules/68k/game/obj_state_return.asm
; ============================================================================
        include "modules/68k/game/obj_state_return.asm"

        include "modules/68k/game/fn_a200_001.asm"
; ============================================================================
; Effect Countdown ($00AC3E-$00ACBE)
; Translated from dc.w format - see disasm/modules/68k/game/effect_countdown.asm
; ============================================================================
        include "modules/68k/game/effect_countdown.asm"
; ============================================================================
; Race Mode Flag Set ($00ACC0-$00ACD2)
; Translated from dc.w format - see disasm/modules/68k/game/race_mode_flag_set.asm
; ============================================================================
        include "modules/68k/game/race_mode_flag_set.asm"

; ============================================================================
; AI Target Check ($00ACD4-$00AD12)
; Translated from dc.w format - see disasm/modules/68k/game/ai_target_check.asm
; ============================================================================
        include "modules/68k/game/ai_target_check.asm"

; ============================================================================
; Entity Target Action ($00AD14-$00ADC2)
; Translated from dc.w format - see disasm/modules/68k/game/entity_target_action.asm
; ============================================================================
        include "modules/68k/game/entity_target_action.asm"
; ============================================================================
; Proximity Distance Check ($00ADC4-$00AE04)
; Translated from dc.w format - see disasm/modules/68k/game/proximity_distance_check.asm
; ============================================================================
        include "modules/68k/game/proximity_distance_check.asm"
; ============================================================================
; Zone Check Inner ($00AE06-$00AED6)
; Translated from dc.w format - see disasm/modules/68k/game/zone_check_inner.asm
; ============================================================================
        include "modules/68k/game/zone_check_inner.asm"
; ============================================================================
; Entity Directional Push ($00AED8-$00AF16)
; Translated from dc.w format - see disasm/modules/68k/game/entity_directional_push.asm
; ============================================================================
        include "modules/68k/game/entity_directional_push.asm"
        include "modules/68k/game/fn_a200_002.asm"
; ============================================================================
; Close Position Flags ($00AFC2-$00AFFC)
; Translated from dc.w format - see disasm/modules/68k/game/close_position_flags.asm
; ============================================================================
        include "modules/68k/game/close_position_flags.asm"
; ============================================================================
; Position Separation ($00AFFE-$00B02A)
; Translated from dc.w format - see disasm/modules/68k/game/position_separation.asm
; ============================================================================
        include "modules/68k/game/position_separation.asm"

; ============================================================================
; Speed Scale Simple ($00B02C-$00B03A)
; Translated from dc.w format - see disasm/modules/68k/game/speed_scale_simple.asm
; ============================================================================
        include "modules/68k/game/speed_scale_simple.asm"

; ============================================================================
; Speed Scale Conditional ($00B03C-$00B068)
; Translated from dc.w format - see disasm/modules/68k/game/speed_scale_conditional.asm
; ============================================================================
        include "modules/68k/game/speed_scale_conditional.asm"

; ============================================================================
; Speed Scale Calculation ($00B06A-$00B092)
; Translated from dc.w format - see disasm/modules/68k/game/speed_scale_calc.asm
; ============================================================================
        include "modules/68k/game/speed_scale_calc.asm"
        include "modules/68k/game/fn_a200_003.asm"
        include "modules/68k/game/fn_a200_004.asm"
        include "modules/68k/game/fn_a200_005.asm"
        include "modules/68k/game/fn_a200_006.asm"
        include "modules/68k/game/fn_a200_007.asm"
        include "modules/68k/game/fn_a200_008.asm"
        include "modules/68k/game/fn_a200_009.asm"
        include "modules/68k/game/fn_a200_010.asm"
        include "modules/68k/game/fn_a200_011.asm"
        include "modules/68k/game/fn_a200_012.asm"
        include "modules/68k/game/fn_a200_013.asm"
        include "modules/68k/game/fn_a200_014.asm"
        include "modules/68k/game/fn_a200_015.asm"
        include "modules/68k/game/fn_a200_016.asm"
        include "modules/68k/game/fn_a200_017.asm"
        include "modules/68k/game/fn_a200_018.asm"
; ============================================================================
; HUD Panel Config ($00B55A-$00B58E)
; Translated from dc.w format - see disasm/modules/68k/game/hud_panel_config.asm
; ============================================================================
        include "modules/68k/game/hud_panel_config.asm"
        include "modules/68k/game/fn_a200_019.asm"
        include "modules/68k/game/fn_a200_020.asm"
        include "modules/68k/game/fn_a200_021.asm"
        include "modules/68k/game/fn_a200_022.asm"
; ============================================================================
; Lap Value Store 1 ($00B632-$00B644)
; Translated from dc.w format - see disasm/modules/68k/game/lap_value_store_1.asm
; ============================================================================
        include "modules/68k/game/lap_value_store_1.asm"

; ============================================================================
; Lap Value Store 2 ($00B646-$00B658)
; Translated from dc.w format - see disasm/modules/68k/game/lap_value_store_2.asm
; ============================================================================
        include "modules/68k/game/lap_value_store_2.asm"
        include "modules/68k/game/fn_a200_023.asm"
        include "modules/68k/game/fn_a200_024.asm"
        include "modules/68k/game/fn_a200_025.asm"
        include "modules/68k/game/fn_a200_026.asm"
        include "modules/68k/game/fn_a200_027.asm"
        include "modules/68k/game/fn_a200_028.asm"
        include "modules/68k/game/fn_a200_029.asm"
        include "modules/68k/game/fn_a200_030.asm"
        include "modules/68k/game/fn_a200_031.asm"
        dc.w    $4E75        ; $00BA18
        include "modules/68k/game/fn_a200_032.asm"
        include "modules/68k/game/fn_a200_033.asm"
        include "modules/68k/game/fn_a200_034.asm"
        include "modules/68k/game/fn_a200_035.asm"
        include "modules/68k/game/fn_a200_036.asm"
        include "modules/68k/game/fn_a200_037.asm"
        include "modules/68k/game/fn_a200_038.asm"
; ============================================================================
; Abort With Flag ($00BD9E-$00BDA6)
; Translated from dc.w format - see disasm/modules/68k/game/abort_with_flag.asm
; ============================================================================
        include "modules/68k/game/abort_with_flag.asm"

; ============================================================================
; HUD Activate Check ($00BDA8-$00BDC6)
; Translated from dc.w format - see disasm/modules/68k/game/hud_activate_check.asm
; ============================================================================
        include "modules/68k/game/hud_activate_check.asm"

; ============================================================================
; Counter Init Check ($00BDC8-$00BDD4)
; Translated from dc.w format - see disasm/modules/68k/game/counter_init_check.asm
; ============================================================================
        include "modules/68k/game/counter_init_check.asm"
        include "modules/68k/game/fn_a200_039.asm"
        include "modules/68k/game/fn_a200_040.asm"
        include "modules/68k/game/fn_a200_041.asm"
        include "modules/68k/game/fn_a200_042.asm"
        include "modules/68k/game/fn_a200_043.asm"
        include "modules/68k/game/fn_a200_044.asm"
        include "modules/68k/game/fn_a200_045.asm"
        include "modules/68k/game/fn_a200_046.asm"
        include "modules/68k/game/fn_a200_047.asm"
; ============================================================================
; HUD Buffer Clear ($00C028-$00C05A)
; Translated from dc.w format - see disasm/modules/68k/game/hud_buffer_clear.asm
; ============================================================================
        include "modules/68k/game/hud_buffer_clear.asm"
        include "modules/68k/game/fn_a200_048.asm"
        dc.w    $46FC        ; $00C0F0
        dc.w    $2700        ; $00C0F2
        dc.w    $08B8        ; $00C0F4
        dc.w    $0006        ; $00C0F6
        dc.w    $C875        ; $00C0F8
        dc.w    $3AB8        ; $00C0FA
        dc.w    $C874        ; $00C0FC
        dc.w    $33FC        ; $00C0FE
        dc.w    $0083        ; $00C100
        dc.w    $00A1        ; $00C102
        dc.w    $5100        ; $00C104
        dc.w    $0239        ; $00C106
        dc.w    $00FC        ; $00C108
        dc.w    $00A1        ; $00C10A
        dc.w    $5181        ; $00C10C
        dc.w    $4EB9        ; $00C10E
        dc.w    $0088        ; $00C110
        dc.w    $270A        ; $00C112
        dc.w    $11FC        ; $00C114
        dc.w    $0001        ; $00C116
        dc.w    $C80D        ; $00C118
        dc.w    $0238        ; $00C11A
        dc.w    $0009        ; $00C11C
        dc.w    $C80E        ; $00C11E
        dc.w    $08F8        ; $00C120
        dc.w    $0003        ; $00C122
        dc.w    $C80E        ; $00C124
        dc.w    $7000        ; $00C126
        dc.w    $7200        ; $00C128
        dc.w    $103C        ; $00C12A
        dc.w    $0000        ; $00C12C
        dc.w    $123C        ; $00C12E
        dc.w    $0000        ; $00C130
        dc.w    $4EBA        ; $00C132
        dc.w    $1068        ; $00C134
        dc.w    $1038        ; $00C136
        dc.w    $C8C9        ; $00C138
        dc.w    $5200        ; $00C13A
        dc.w    $13C0        ; $00C13C
        dc.w    $00A1        ; $00C13E
        dc.w    $5122        ; $00C140
        dc.w    $31FC        ; $00C142
        dc.w    $0103        ; $00C144
        dc.w    $C8A8        ; $00C146
        dc.w    $13F8        ; $00C148
        dc.w    $C8A9        ; $00C14A
        dc.w    $00A1        ; $00C14C
        dc.w    $5121        ; $00C14E
        dc.w    $13F8        ; $00C150
        dc.w    $C8A8        ; $00C152
        dc.w    $00A1        ; $00C154
        dc.w    $5120        ; $00C156
        dc.w    $11FC        ; $00C158
        dc.w    $0000        ; $00C15A
        dc.w    $C80F        ; $00C15C
        dc.w    $31FC        ; $00C15E
        dc.w    $0000        ; $00C160
        dc.w    $C8BC        ; $00C162
        dc.w    $4EB9        ; $00C164
        dc.w    $0088        ; $00C166
        dc.w    $D1D4        ; $00C168
        dc.w    $4EB9        ; $00C16A
        dc.w    $0088        ; $00C16C
        dc.w    $D42C        ; $00C16E
        dc.w    $41F9        ; $00C170
        dc.w    $008B        ; $00C172
        dc.w    $A220        ; $00C174
        dc.w    $3038        ; $00C176
        dc.w    $C8A0        ; $00C178
        dc.w    $2470        ; $00C17A
        dc.w    $0000        ; $00C17C
        dc.w    $4EB9        ; $00C17E
        dc.w    $0088        ; $00C180
        dc.w    $284C        ; $00C182
        dc.w    $41F9        ; $00C184
        dc.w    $008B        ; $00C186
        dc.w    $AE38        ; $00C188
        dc.w    $3038        ; $00C18A
        dc.w    $C8CC        ; $00C18C
        dc.w    $2470        ; $00C18E
        dc.w    $0000        ; $00C190
        dc.w    $4EB9        ; $00C192
        dc.w    $0088        ; $00C194
        dc.w    $2862        ; $00C196
        dc.w    $33FC        ; $00C198
        dc.w    $0010        ; $00C19A
        dc.w    $00FF        ; $00C19C
        dc.w    $0008        ; $00C19E
        dc.w    $31FC        ; $00C1A0
        dc.w    $0000        ; $00C1A2
        dc.w    $C8AA        ; $00C1A4
        dc.w    $4EB9        ; $00C1A6
        dc.w    $0088        ; $00C1A8
        dc.w    $49AA        ; $00C1AA
        dc.w    $4EBA        ; $00C1AC
        dc.w    $0BE4        ; $00C1AE
        dc.w    $11FC        ; $00C1B0
        dc.w    $0000        ; $00C1B2
        dc.w    $C314        ; $00C1B4
        dc.w    $0838        ; $00C1B6
        dc.w    $0000        ; $00C1B8
        dc.w    $C818        ; $00C1BA
        dc.w    $6706        ; $00C1BC
        dc.w    $11FC        ; $00C1BE
        dc.w    $0001        ; $00C1C0
        dc.w    $C314        ; $00C1C2
        dc.w    $7000        ; $00C1C4
        dc.w    $4EBA        ; $00C1C6
        dc.w    $0AAC        ; $00C1C8
        dc.w    $4EBA        ; $00C1CA
        dc.w    $06A4        ; $00C1CC
        dc.w    $4EBA        ; $00C1CE
        dc.w    $0820        ; $00C1D0
        dc.w    $4EBA        ; $00C1D2
        dc.w    $0E38        ; $00C1D4
        dc.w    $11FC        ; $00C1D6
        dc.w    $0005        ; $00C1D8
        dc.w    $C310        ; $00C1DA
        dc.w    $11FC        ; $00C1DC
        dc.w    $0000        ; $00C1DE
        dc.w    $C30F        ; $00C1E0
        dc.w    $41F8        ; $00C1E2
        dc.w    $9000        ; $00C1E4
        dc.w    $4EBA        ; $00C1E6
        dc.w    $0AAA        ; $00C1E8
        dc.w    $7200        ; $00C1EA
        dc.w    $4EBA        ; $00C1EC
        dc.w    $0C68        ; $00C1EE
        dc.w    $4EBA        ; $00C1F0
        dc.w    $0B5A        ; $00C1F2
        dc.w    $4EB9        ; $00C1F4
        dc.w    $0088        ; $00C1F6
        dc.w    $A80A        ; $00C1F8
        dc.w    $4EB9        ; $00C1FA
        dc.w    $0088        ; $00C1FC
        dc.w    $A144        ; $00C1FE
