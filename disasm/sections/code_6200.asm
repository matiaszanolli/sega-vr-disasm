; ============================================================================
; Code Section ($006200-$0081FF)
; Generated from ROM bytes - guaranteed accurate
; ============================================================================

        org     $006200

        include "modules/68k/game/fn_6200_001.asm"
        include "modules/68k/game/fn_6200_002.asm"
        include "modules/68k/game/fn_6200_003.asm"
        include "modules/68k/game/fn_6200_004.asm"
        include "modules/68k/game/fn_6200_005.asm"
        include "modules/68k/game/fn_6200_006.asm"
        include "modules/68k/game/fn_6200_007.asm"
        include "modules/68k/game/fn_6200_008.asm"
        include "modules/68k/game/fn_6200_009.asm"
        include "modules/68k/game/fn_6200_010.asm"
        include "modules/68k/game/fn_6200_011.asm"
        include "modules/68k/game/fn_6200_012.asm"
        include "modules/68k/game/fn_6200_013.asm"
        include "modules/68k/game/fn_6200_014.asm"
        include "modules/68k/game/fn_6200_015.asm"
        include "modules/68k/game/fn_6200_016.asm"
        include "modules/68k/game/fn_6200_017.asm"
        include "modules/68k/game/fn_6200_018.asm"
        dc.w    $7E00        ; $006D00
        dc.w    $0838        ; $006D02
        dc.w    $0002        ; $006D04
        dc.w    $C313        ; $006D06
        dc.w    $6702        ; $006D08
        dc.w    $7E04        ; $006D0A
        dc.w    $DE78        ; $006D0C
        dc.w    $C8A0        ; $006D0E
        dc.w    $DE78        ; $006D10
        dc.w    $C8A0        ; $006D12
        dc.w    $45F9        ; $006D14
        dc.w    $00FF        ; $006D16
        dc.w    $301A        ; $006D18
        dc.w    $2272        ; $006D1A
        dc.w    $7000        ; $006D1C
        dc.w    $3238        ; $006D1E
        dc.w    $C0BA        ; $006D20
        dc.w    $3E19        ; $006D22
        dc.w    $B251        ; $006D24
        dc.w    $670C        ; $006D26
        dc.w    $43E9        ; $006D28
        dc.w    $0010        ; $006D2A
        dc.w    $51CF        ; $006D2C
        dc.w    $FFF6        ; $006D2E
        include "modules/68k/object/position_adjust_helpers.asm"
        include "modules/68k/game/fn_6200_019.asm"
        include "modules/68k/game/fn_6200_020.asm"
        include "modules/68k/game/fn_6200_021.asm"
        include "modules/68k/game/fn_6200_022.asm"
        include "modules/68k/game/fn_6200_023.asm"
        include "modules/68k/object/counter_guard.asm"
        include "modules/68k/object/camera_position_smooth.asm"
        include "modules/68k/object/position_velocity_update.asm"
        include "modules/68k/math/trig_lookup.asm"
        include "modules/68k/game/fn_6200_024.asm"
        include "modules/68k/game/fn_6200_025.asm"
        include "modules/68k/game/fn_6200_026.asm"
        include "modules/68k/vdp/framebuffer_setup.asm"
        include "modules/68k/game/fn_6200_027.asm"
        include "modules/68k/game/fn_6200_028.asm"
        include "modules/68k/game/fn_6200_029.asm"
        dc.w    $0094        ; $00742C
        dc.w    $C000        ; $00742E
        dc.w    $0097        ; $007430
        dc.w    $0000        ; $007432
        dc.w    $0094        ; $007434
        dc.w    $E000        ; $007436
        dc.w    $0098        ; $007438
        dc.w    $8000        ; $00743A
        dc.w    $0095        ; $00743C
        dc.w    $0000        ; $00743E
        dc.w    $009A        ; $007440
        dc.w    $0000        ; $007442
        dc.w    $0095        ; $007444
        dc.w    $4000        ; $007446
        dc.w    $009B        ; $007448
        dc.w    $8000        ; $00744A
        dc.w    $0095        ; $00744C
        dc.w    $8000        ; $00744E
        dc.w    $009D        ; $007450
        dc.w    $0000        ; $007452
        dc.w    $0095        ; $007454
        dc.w    $2000        ; $007456
        dc.w    $009D        ; $007458
        dc.w    $0000        ; $00745A
        dc.w    $0000        ; $00745C
        dc.w    $0000        ; $00745E
        dc.w    $0000        ; $007460
        dc.w    $0000        ; $007462
        dc.w    $0000        ; $007464
        dc.w    $0000        ; $007466
        dc.w    $0000        ; $007468
        dc.w    $0000        ; $00746A
        dc.w    $0000        ; $00746C
        dc.w    $0000        ; $00746E
        dc.w    $0000        ; $007470
        dc.w    $0000        ; $007472
        dc.w    $0095        ; $007474
        dc.w    $6000        ; $007476
        dc.w    $009C        ; $007478
        dc.w    $4110        ; $00747A
        dc.w    $0000        ; $00747C
        dc.w    $0000        ; $00747E
        dc.w    $0000        ; $007480
        dc.w    $0000        ; $007482
        dc.w    $0000        ; $007484
        dc.w    $0000        ; $007486
        dc.w    $0000        ; $007488
        dc.w    $0000        ; $00748A
        include "modules/68k/math/angle_normalize_bsp.asm"
        include "modules/68k/math/plane_eval_pair.asm"
        include "modules/68k/object/obj_distance_calc.asm"
        include "modules/68k/game/fn_6200_030.asm"
        include "modules/68k/game/fn_6200_031.asm"
        include "modules/68k/game/fn_6200_032.asm"
        include "modules/68k/game/fn_6200_033.asm"
        include "modules/68k/game/fn_6200_034.asm"
        include "modules/68k/game/fn_6200_035.asm"
        include "modules/68k/game/fn_6200_036.asm"
        include "modules/68k/game/fn_6200_037.asm"
        include "modules/68k/game/fn_6200_038.asm"
        include "modules/68k/game/fn_6200_039.asm"
        include "modules/68k/game/fn_6200_040.asm"
        include "modules/68k/game/fn_6200_041.asm"
        include "modules/68k/game/fn_6200_042.asm"
        include "modules/68k/game/fn_6200_043.asm"
        include "modules/68k/game/fn_6200_044.asm"
        include "modules/68k/object/visibility_eval_caller.asm"
        include "modules/68k/game/fn_6200_045.asm"
        include "modules/68k/game/fn_6200_046.asm"
        include "modules/68k/game/fn_6200_047.asm"
        include "modules/68k/game/fn_6200_048.asm"
        include "modules/68k/game/fn_6200_049.asm"
        include "modules/68k/game/fn_6200_050.asm"
        include "modules/68k/game/fn_6200_051.asm"
        include "modules/68k/game/fn_6200_052.asm"
        include "modules/68k/game/fn_6200_053.asm"
        include "modules/68k/object/multi_flag_test.asm"
        include "modules/68k/game/fn_6200_054.asm"
        include "modules/68k/game/fn_6200_055.asm"
        include "modules/68k/game/fn_6200_056.asm"
        include "modules/68k/game/fn_6200_057.asm"
        include "modules/68k/game/fn_6200_058.asm"
        include "modules/68k/game/fn_6200_059.asm"
        include "modules/68k/game/fn_6200_060.asm"
        include "modules/68k/game/fn_6200_061.asm"
        include "modules/68k/object/position_threshold_check.asm"
        include "modules/68k/game/fn_6200_062.asm"
        include "modules/68k/game/fn_6200_063.asm"
        include "modules/68k/game/fn_6200_064.asm"
        include "modules/68k/game/fn_6200_065.asm"
        include "modules/68k/game/fn_6200_066.asm"
        include "modules/68k/game/fn_6200_067.asm"
        include "modules/68k/game/fn_6200_068.asm"
        include "modules/68k/object/field_check_guard.asm"
        include "modules/68k/game/fn_6200_069.asm"
        include "modules/68k/game/fn_6200_070.asm"
        dc.w    $0A0A        ; $0081C0
        dc.w    $0E0A        ; $0081C2
        dc.w    $120A        ; $0081C4
        dc.w    $0000        ; $0081C6
        dc.w    $0B0B        ; $0081C8
        dc.w    $100B        ; $0081CA
        dc.w    $140B        ; $0081CC
        dc.w    $0000        ; $0081CE
        dc.w    $0A0A        ; $0081D0
        dc.w    $0E0A        ; $0081D2
        dc.w    $120A        ; $0081D4
        dc.w    $0000        ; $0081D6
        dc.w    $0828        ; $0081D8
        dc.w    $0006        ; $0081DA
        dc.w    $0002        ; $0081DC
        dc.w    $672A        ; $0081DE
        dc.w    $0268        ; $0081E0
        dc.w    $BFFF        ; $0081E2
        dc.w    $0002        ; $0081E4
        dc.w    $3038        ; $0081E6
        dc.w    $C8CC        ; $0081E8
        dc.w    $D040        ; $0081EA
        dc.w    $D078        ; $0081EC
        dc.w    $C89C        ; $0081EE
        dc.w    $103B        ; $0081F0
        dc.w    $00CE        ; $0081F2
        dc.w    $D178        ; $0081F4
        dc.w    $C050        ; $0081F6
        dc.w    $4278        ; $0081F8
        dc.w    $C8AA        ; $0081FA
        dc.w    $0C38        ; $0081FC
        dc.w    $00BE        ; $0081FE
