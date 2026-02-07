; ============================================================================
; Code Section ($008200-$00A1FF)
; Generated from ROM bytes - guaranteed accurate
; ============================================================================

        org     $008200

        include "modules/68k/game/fn_8200_001.asm"
        include "modules/68k/game/fn_8200_002.asm"
        include "modules/68k/game/fn_8200_003.asm"
        include "modules/68k/game/fn_8200_004.asm"
        include "modules/68k/game/fn_8200_005.asm"
        include "modules/68k/game/fn_8200_006.asm"
        include "modules/68k/game/fn_8200_007.asm"
        include "modules/68k/game/fn_8200_008.asm"
        include "modules/68k/game/fn_8200_009.asm"
        include "modules/68k/game/fn_8200_010.asm"
        include "modules/68k/util/nibble_unpack.asm"
        include "modules/68k/game/fn_8200_011.asm"
        include "modules/68k/game/fn_8200_012.asm"
        include "modules/68k/game/fn_8200_013.asm"
        include "modules/68k/game/fn_8200_014.asm"
        include "modules/68k/game/fn_8200_015.asm"
        include "modules/68k/game/fn_8200_016.asm"
        include "modules/68k/game/fn_8200_017.asm"
        include "modules/68k/game/fn_8200_018.asm"
        include "modules/68k/game/timer_decrement_multi.asm"
        include "modules/68k/game/speed_degrade_calc.asm"
        include "modules/68k/sound/tire_squeal_check.asm"
        include "modules/68k/sound/tire_squeal_check_2p.asm"
        include "modules/68k/game/proximity_zone_simple.asm"
        include "modules/68k/game/proximity_zone_multi.asm"
        include "modules/68k/game/proximity_zone_loop.asm"
        include "modules/68k/game/fn_8200_019.asm"
        include "modules/68k/game/fn_8200_020.asm"
        include "modules/68k/game/fn_8200_021.asm"
        include "modules/68k/game/fn_8200_022.asm"
        include "modules/68k/game/camera_direct_setup.asm"
        include "modules/68k/game/camera_buffer_setup.asm"
        include "modules/68k/game/camera_simple_setup.asm"
        include "modules/68k/game/camera_offset_setup.asm"
        include "modules/68k/game/fn_8200_023.asm"
        include "modules/68k/game/camera_scroll_update.asm"
        dc.w    $4E75        ; $008CCC
        include "modules/68k/game/fn_8200_024.asm"
        include "modules/68k/game/counter_check_flag_8200.asm"
        include "modules/68k/game/fn_8200_025.asm"
        include "modules/68k/game/camera_value_store_full.asm"
        include "modules/68k/game/camera_value_store.asm"
        include "modules/68k/game/fn_8200_026.asm"
        include "modules/68k/game/fn_8200_027.asm"
        include "modules/68k/game/fn_8200_028.asm"
        include "modules/68k/game/fn_8200_029.asm"
        include "modules/68k/game/clear_camera_override.asm"
        include "modules/68k/game/fn_8200_030.asm"
        include "modules/68k/game/fn_8200_031.asm"
        include "modules/68k/math/sin_lookup.asm"
        include "modules/68k/math/cos_lookup.asm"
        include "modules/68k/math/sin_neg_lookup.asm"
        dc.w    $4E75        ; $008FC6
        include "modules/68k/math/atan2_calc.asm"
        include "modules/68k/game/heading_from_position.asm"
        include "modules/68k/game/fn_8200_032.asm"
        include "modules/68k/game/clear_heading.asm"
        include "modules/68k/game/heading_with_camera.asm"
        include "modules/68k/game/heading_broadcast.asm"
        include "modules/68k/game/entity_position_init.asm"
        include "modules/68k/game/fn_8200_033.asm"
        include "modules/68k/game/fn_8200_034.asm"
        include "modules/68k/game/fn_8200_035.asm"
        include "modules/68k/game/fn_8200_036.asm"
        include "modules/68k/game/tilt_adjust.asm"
        include "modules/68k/game/fn_8200_037.asm"
        include "modules/68k/game/fn_8200_038.asm"
        include "modules/68k/game/fn_8200_039.asm"
        include "modules/68k/game/fn_8200_040.asm"
        include "modules/68k/game/entity_speed_clamp.asm"
        include "modules/68k/game/speed_modifier.asm"
        include "modules/68k/game/fn_8200_041.asm"
        include "modules/68k/game/fn_8200_042.asm"
        include "modules/68k/game/fn_8200_043.asm"
        include "modules/68k/game/fn_8200_044.asm"
        include "modules/68k/game/fn_8200_045.asm"
        include "modules/68k/game/proximity_trigger.asm"
        include "modules/68k/game/fn_8200_046.asm"
        include "modules/68k/game/fn_8200_047.asm"
        include "modules/68k/game/fn_8200_048.asm"
        dc.w    $0093        ; $00A1CA
        dc.w    $925E        ; $00A1CC
        dc.w    $0093        ; $00A1CE
        dc.w    $957E        ; $00A1D0
        dc.w    $0093        ; $00A1D2
        dc.w    $989E        ; $00A1D4
        dc.w    $0093        ; $00A1D6
        dc.w    $9BBE        ; $00A1D8
        dc.w    $0093        ; $00A1DA
        dc.w    $989E        ; $00A1DC
        dc.w    $0093        ; $00A1DE
        dc.w    $9BBE        ; $00A1E0
        dc.w    $3A98        ; $00A1E2
        dc.w    $3A98        ; $00A1E4
        dc.w    $3A98        ; $00A1E6
        dc.w    $3A98        ; $00A1E8
        dc.w    $3A98        ; $00A1EA
        dc.w    $3908        ; $00A1EC
        dc.w    $7D00        ; $00A1EE
        dc.w    $00AB        ; $00A1F0
        dc.w    $00C0        ; $00A1F2
        dc.w    $00CD        ; $00A1F4
        dc.w    $00D5        ; $00A1F6
        dc.w    $00DB        ; $00A1F8
        dc.w    $00E0        ; $00A1FA
        dc.w    $3038        ; $00A1FC
        dc.w    $C8CA        ; $00A1FE
