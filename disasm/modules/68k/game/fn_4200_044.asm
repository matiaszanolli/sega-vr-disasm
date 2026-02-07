; ============================================================================
; Obj Palette Update 044 (auto-analyzed)
; ROM Range: $005E38-$005EEA (178 bytes)
; ============================================================================
; Category: object
; Purpose: Orchestrator calling 37 subroutines
;   Calls: sprite_buffer_alt, effect_timer_mgmt, object_frame_timer, load_object_params
;   Object (A0): +$44 (display_offset), +$46 (display_scale), +$4A, +$92 (param_92)
;
; Entry: A0 = object/entity pointer
; Uses: D0, A0
; Calls:
;   $002984: palette_update
;   $0031A6: display_mode_dispatch
;   $0036DE: clear_buffer
;   $0037B6: memory_copy
;   $003F86: clear_display_vars
;   $006F98: calc_steering
; Object fields:
;   +$44: display_offset
;   +$46: display_scale
;   +$4A: [unknown]
;   +$92: param_92
; Confidence: high
; ============================================================================

fn_4200_044:
        MOVEQ   #$00,D0                         ; $005E38
        MOVE.W  D0,$0044(A0)                    ; $005E3A
        MOVE.W  D0,$0046(A0)                    ; $005E3E
        MOVE.W  D0,$004A(A0)                    ; $005E42
        MOVE.L  #$00100010,(-13968).W           ; $005E46
        DC.W    $4EBA,$592C         ; JSR     $00B77C(PC); $005E4E
        MOVE.W  #$0002,$0092(A0)                ; $005E52
        DC.W    $4EBA,$2740         ; JSR     $00859A(PC); $005E58
        DC.W    $4EBA,$44F2         ; JSR     $00A350(PC); $005E5C
        DC.W    $4EBA,$230E         ; JSR     $008170(PC); $005E60
        DC.W    $4EBA,$2266         ; JSR     $0080CC(PC); $005E64
        DC.W    $4EBA,$26DE         ; JSR     $008548(PC); $005E68
        DC.W    $4EBA,$368C         ; JSR     $0094FA(PC); $005E6C
        DC.W    $4EBA,$34A0         ; JSR     $009312(PC); $005E70
        DC.W    $4EBA,$3C9C         ; JSR     $009B12(PC); $005E74
        DC.W    $4EBA,$3308         ; JSR     $009182(PC); $005E78
        DC.W    $4EBA,$37A0         ; JSR     $00961E(PC); $005E7C
        DC.W    $4EBA,$3806         ; JSR     $009688(PC); $005E80
        DC.W    $4EBA,$397C         ; JSR     $009802(PC); $005E84
        DC.W    $4EBA,$1FF0         ; JSR     $007E7A(PC); $005E88
        DC.W    $4EBA,$110A         ; JSR     $006F98(PC); $005E8C
        DC.W    $4EBA,$1E46         ; JSR     $007CD8(PC); $005E90
        DC.W    $4EBA,$459E         ; JSR     $00A434(PC); $005E94
        DC.W    $4EBA,$1210         ; JSR     $0070AA(PC); $005E98
        DC.W    $4EBA,$2066         ; JSR     $007F04(PC); $005E9C
        DC.W    $4EBA,$1DAC         ; JSR     $007C4E(PC); $005EA0
        DC.W    $4EBA,$12A4         ; JSR     $00714A(PC); $005EA4
        DC.W    $4EBA,$17A4         ; JSR     $00764E(PC); $005EA8
        DC.W    $4EBA,$20A2         ; JSR     $007F50(PC); $005EAC
        DC.W    $4EBA,$3E1C         ; JSR     $009CCE(PC); $005EB0
        DC.W    $4EBA,$3C9E         ; JSR     $009B54(PC); $005EB4
        DC.W    $4EBA,$2844         ; JSR     $0086FE(PC); $005EB8
        DC.W    $4EBA,$3182         ; JSR     $009040(PC); $005EBC
        DC.W    $4EBA,$4E12         ; JSR     $00ACD4(PC); $005EC0
        DC.W    $4EBA,$E1BE         ; JSR     $004084(PC); $005EC4
        DC.W    $4EBA,$1734         ; JSR     $0075FE(PC); $005EC8
        DC.W    $4EBA,$12D8         ; JSR     $0071A6(PC); $005ECC
        DC.W    $4EBA,$CAB2         ; JSR     $002984(PC); $005ED0
        DC.W    $4EBA,$D2D0         ; JSR     $0031A6(PC); $005ED4
        DC.W    $4EBA,$D804         ; JSR     $0036DE(PC); $005ED8
        DC.W    $4EBA,$D8D8         ; JSR     $0037B6(PC); $005EDC
        DC.W    $4EBA,$E0A4         ; JSR     $003F86(PC); $005EE0
        DC.W    $4EBA,$D1E0         ; JSR     $0030C6(PC); $005EE4
        RTS                                     ; $005EE8
