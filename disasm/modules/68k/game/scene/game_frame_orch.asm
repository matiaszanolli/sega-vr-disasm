; ============================================================================
; Game Frame Orchestrator
; ROM Range: $005E38-$005EEA (178 bytes)
; ============================================================================
; Category: object
; Purpose: Master frame orchestrator — initializes display params then calls
;   37 subroutines covering physics, steering, rendering, AI, palette,
;   display mode, buffer management, and memory copy.
;
; Entry: A0 = object/entity pointer
; Uses: D0, A0
; RAM:
;   $C970: display_scale_pair (longword: X|Y = $0010|$0010)
; Calls (37 subroutines via PC-relative JSR):
;   $00B77C, $00859A, $00A350, $008170, $0080CC, $008548,
;   $0094FA, $009312, $009B12, $009182, $00961E, $009688,
;   $009802, $007E7A, $006F98 (calc_steering), $007CD8,
;   $00A434, $0070AA, $007F04, $007C4E, $00714A, $00764E,
;   $007F50, $009CCE, $009B54, $0086FE, $009040, $00ACD4,
;   $004084, $0075FE, $0071A6,
;   $002984 (palette_update), $0031A6 (display_mode_dispatch),
;   $0036DE (clear_buffer), $0037B6 (memory_copy),
;   $003F86 (clear_display_vars), $0030C6
; Object fields:
;   +$44: display_offset
;   +$46: display_scale
;   +$4A: display_param
;   +$92: param_92
; ============================================================================

game_frame_orch:
        moveq   #$00,D0                         ; $005E38
        move.w  D0,$0044(A0)                    ; $005E3A  display_offset = 0
        move.w  D0,$0046(A0)                    ; $005E3E  display_scale = 0
        move.w  D0,$004A(A0)                    ; $005E42  display_param = 0
        move.l  #$00100010,($FFFFC970).w            ; $005E46  display_scale_pair = 16|16
        dc.w    $4EBA,$592C         ; jsr     $00B77C(pc)         ; $005E4E
        move.w  #$0002,$0092(A0)                ; $005E52  param_92 = 2
        dc.w    $4EBA,$2740         ; jsr     $00859A(pc)         ; $005E58
        dc.w    $4EBA,$44F2         ; jsr     $00A350(pc)         ; $005E5C
        dc.w    $4EBA,$230E         ; jsr     $008170(pc)         ; $005E60
        dc.w    $4EBA,$2266         ; jsr     $0080CC(pc)         ; $005E64
        dc.w    $4EBA,$26DE         ; jsr     $008548(pc)         ; $005E68
        dc.w    $4EBA,$368C         ; jsr     $0094FA(pc)         ; $005E6C
        dc.w    $4EBA,$34A0         ; jsr     $009312(pc)         ; $005E70
        dc.w    $4EBA,$3C9C         ; jsr     $009B12(pc)         ; $005E74
        dc.w    $4EBA,$3308         ; jsr     $009182(pc)         ; $005E78
        dc.w    $4EBA,$37A0         ; jsr     $00961E(pc)         ; $005E7C
        dc.w    $4EBA,$3806         ; jsr     $009688(pc)         ; $005E80
        dc.w    $4EBA,$397C         ; jsr     $009802(pc)         ; $005E84
        dc.w    $4EBA,$1FF0         ; jsr     $007E7A(pc)         ; $005E88
        dc.w    $4EBA,$110A         ; jsr     $006F98(pc)         ; $005E8C  calc_steering
        dc.w    $4EBA,$1E46         ; jsr     $007CD8(pc)         ; $005E90
        dc.w    $4EBA,$459E         ; jsr     $00A434(pc)         ; $005E94
        dc.w    $4EBA,$1210         ; jsr     $0070AA(pc)         ; $005E98
        dc.w    $4EBA,$2066         ; jsr     $007F04(pc)         ; $005E9C
        dc.w    $4EBA,$1DAC         ; jsr     $007C4E(pc)         ; $005EA0
        dc.w    $4EBA,$12A4         ; jsr     $00714A(pc)         ; $005EA4
        dc.w    $4EBA,$17A4         ; jsr     $00764E(pc)         ; $005EA8
        dc.w    $4EBA,$20A2         ; jsr     $007F50(pc)         ; $005EAC
        dc.w    $4EBA,$3E1C         ; jsr     $009CCE(pc)         ; $005EB0
        dc.w    $4EBA,$3C9E         ; jsr     $009B54(pc)         ; $005EB4
        dc.w    $4EBA,$2844         ; jsr     $0086FE(pc)         ; $005EB8
        dc.w    $4EBA,$3182         ; jsr     $009040(pc)         ; $005EBC
        dc.w    $4EBA,$4E12         ; jsr     $00ACD4(pc)         ; $005EC0
        dc.w    $4EBA,$E1BE         ; jsr     $004084(pc)         ; $005EC4
        dc.w    $4EBA,$1734         ; jsr     $0075FE(pc)         ; $005EC8
        dc.w    $4EBA,$12D8         ; jsr     $0071A6(pc)         ; $005ECC
        dc.w    $4EBA,$CAB2         ; jsr     $002984(pc)         ; $005ED0  palette_update
        dc.w    $4EBA,$D2D0         ; jsr     $0031A6(pc)         ; $005ED4  display_mode_dispatch
        dc.w    $4EBA,$D804         ; jsr     $0036DE(pc)         ; $005ED8  clear_buffer
        dc.w    $4EBA,$D8D8         ; jsr     $0037B6(pc)         ; $005EDC  memory_copy
        dc.w    $4EBA,$E0A4         ; jsr     $003F86(pc)         ; $005EE0  clear_display_vars
        dc.w    $4EBA,$D1E0         ; jsr     $0030C6(pc)         ; $005EE4
        rts                                     ; $005EE8
