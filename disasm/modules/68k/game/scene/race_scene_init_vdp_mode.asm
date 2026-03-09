; ============================================================================
; race_scene_init_vdp_mode — Race Scene Init (VDP Mode Handler)
; ROM Range: $00C0F0-$00C1FE (272 bytes)
; ============================================================================
; Major scene initialization function for race/3D mode. Disables interrupts,
; configures VDP hardware, sets up COMM registers, calls multiple subsystems,
; loads ROM tables, and initializes state variables.
;
; Falls through to scene_init_orch at $C200 (no RTS in this block).
;
; Entry: Called as scene handler when VDP flag ($FEB7) bit 7 is set.
;        Pointer $0088C0F0 stored at $FF0002.
; Uses: D0-D1, A0, A2
; ============================================================================

race_scene_init_vdp_mode:
        dc.w    $46FC        ; $00C0F0  MOVE.W #$2700,SR (disable interrupts)
        dc.w    $2700        ; $00C0F2
        dc.w    $08B8        ; $00C0F4  BCLR #6,($C875).W
        dc.w    $0006        ; $00C0F6
        dc.w    $C875        ; $00C0F8
        dc.w    $3AB8        ; $00C0FA  MOVE.W ($C874).W,D5
        dc.w    $C874        ; $00C0FC
        dc.w    $33FC        ; $00C0FE  MOVE.W #$0083,($00A15100).L (MARS adapter ctrl)
        dc.w    $0083        ; $00C100
        dc.w    $00A1        ; $00C102
        dc.w    $5100        ; $00C104
        dc.w    $0239        ; $00C106  ANDI.B #$FC,($00A15181).L
        dc.w    $00FC        ; $00C108
        dc.w    $00A1        ; $00C10A
        dc.w    $5181        ; $00C10C
        dc.w    $4EB9        ; $00C10E  JSR $0088270A (hardware setup)
        dc.w    $0088        ; $00C110
        dc.w    $270A        ; $00C112
        dc.w    $11FC        ; $00C114  MOVE.B #$01,($C80D).W
        dc.w    $0001        ; $00C116
        dc.w    $C80D        ; $00C118
        dc.w    $0238        ; $00C11A  ANDI.B #$09,($C80E).W
        dc.w    $0009        ; $00C11C
        dc.w    $C80E        ; $00C11E
        dc.w    $08F8        ; $00C120  BSET #3,($C80E).W
        dc.w    $0003        ; $00C122
        dc.w    $C80E        ; $00C124
        dc.w    $7000        ; $00C126  MOVEQ #0,D0
        dc.w    $7200        ; $00C128  MOVEQ #0,D1
        dc.w    $103C        ; $00C12A  MOVE.B #$00,D0
        dc.w    $0000        ; $00C12C
        dc.w    $123C        ; $00C12E  MOVE.B #$00,D1
        dc.w    $0000        ; $00C130
        dc.w    $4EBA        ; $00C132  JSR $D19C(PC)
        dc.w    $1068        ; $00C134
        dc.w    $1038        ; $00C136  MOVE.B ($C8C9).W,D0
        dc.w    $C8C9        ; $00C138
        dc.w    $5200        ; $00C13A  ADDQ.B #1,D0
        dc.w    $13C0        ; $00C13C  MOVE.B D0,($00A15122).L (COMM1)
        dc.w    $00A1        ; $00C13E
        dc.w    $5122        ; $00C140
        dc.w    $31FC        ; $00C142  MOVE.W #$0103,($C8A8).W
        dc.w    $0103        ; $00C144
        dc.w    $C8A8        ; $00C146
        dc.w    $13F8        ; $00C148  MOVE.B ($C8A9).W,($00A15121).L (COMM0_LO)
        dc.w    $C8A9        ; $00C14A
        dc.w    $00A1        ; $00C14C
        dc.w    $5121        ; $00C14E
        dc.w    $13F8        ; $00C150  MOVE.B ($C8A8).W,($00A15120).L (COMM0_HI)
        dc.w    $C8A8        ; $00C152
        dc.w    $00A1        ; $00C154
        dc.w    $5120        ; $00C156
        dc.w    $11FC        ; $00C158  MOVE.B #$00,($C80F).W
        dc.w    $0000        ; $00C15A
        dc.w    $C80F        ; $00C15C
        dc.w    $31FC        ; $00C15E  MOVE.W #$0000,($C8BC).W
        dc.w    $0000        ; $00C160
        dc.w    $C8BC        ; $00C162
        dc.w    $4EB9        ; $00C164  JSR $0088D1D4
        dc.w    $0088        ; $00C166
        dc.w    $D1D4        ; $00C168
        dc.w    $4EB9        ; $00C16A  JSR $0088D42C
        dc.w    $0088        ; $00C16C
        dc.w    $D42C        ; $00C16E
        dc.w    $41F9        ; $00C170  LEA $008BA220,A0
        dc.w    $008B        ; $00C172
        dc.w    $A220        ; $00C174
        dc.w    $3038        ; $00C176  MOVE.W ($C8A0).W,D0
        dc.w    $C8A0        ; $00C178
        dc.w    $2470        ; $00C17A  MOVEA.L (A0,D0.W),A2
        dc.w    $0000        ; $00C17C
        dc.w    $4EB9        ; $00C17E  JSR $0088284C
        dc.w    $0088        ; $00C180
        dc.w    $284C        ; $00C182
        dc.w    $41F9        ; $00C184  LEA $008BAE38,A0
        dc.w    $008B        ; $00C186
        dc.w    $AE38        ; $00C188
        dc.w    $3038        ; $00C18A  MOVE.W ($C8CC).W,D0
        dc.w    $C8CC        ; $00C18C
        dc.w    $2470        ; $00C18E  MOVEA.L (A0,D0.W),A2
        dc.w    $0000        ; $00C190
        dc.w    $4EB9        ; $00C192  JSR $0088284C+$16=$00882862
        dc.w    $0088        ; $00C194
        dc.w    $2862        ; $00C196
        dc.w    $33FC        ; $00C198  MOVE.W #$0010,($00FF0008).L (display mode)
        dc.w    $0010        ; $00C19A
        dc.w    $00FF        ; $00C19C
        dc.w    $0008        ; $00C19E
        dc.w    $31FC        ; $00C1A0  MOVE.W #$0000,($C8AA).W
        dc.w    $0000        ; $00C1A2
        dc.w    $C8AA        ; $00C1A4
        dc.w    $4EB9        ; $00C1A6  JSR $008849AA
        dc.w    $0088        ; $00C1A8
        dc.w    $49AA        ; $00C1AA
        dc.w    $4EBA        ; $00C1AC  JSR $CD92(PC)
        dc.w    $0BE4        ; $00C1AE
        dc.w    $11FC        ; $00C1B0  MOVE.B #$00,($C314).W
        dc.w    $0000        ; $00C1B2
        dc.w    $C314        ; $00C1B4
        dc.w    $0838        ; $00C1B6  BTST #0,($C818).W
        dc.w    $0000        ; $00C1B8
        dc.w    $C818        ; $00C1BA
        dc.w    $6706        ; $00C1BC  BEQ.S +6
        dc.w    $11FC        ; $00C1BE  MOVE.B #$01,($C314).W
        dc.w    $0001        ; $00C1C0
        dc.w    $C314        ; $00C1C2
        dc.w    $7000        ; $00C1C4  MOVEQ #0,D0
        dc.w    $4EBA        ; $00C1C6  JSR $CC72(PC)
        dc.w    $0AAC        ; $00C1C8
        dc.w    $4EBA        ; $00C1CA  JSR $C870(PC)
        dc.w    $06A4        ; $00C1CC
        dc.w    $4EBA        ; $00C1CE  JSR $C9F0(PC)
        dc.w    $0820        ; $00C1D0
        dc.w    $4EBA        ; $00C1D2  JSR $D00C(PC)
        dc.w    $0E38        ; $00C1D4
        dc.w    $11FC        ; $00C1D6  MOVE.B #$05,($C310).W
        dc.w    $0005        ; $00C1D8
        dc.w    $C310        ; $00C1DA
        dc.w    $11FC        ; $00C1DC  MOVE.B #$00,($C30F).W
        dc.w    $0000        ; $00C1DE
        dc.w    $C30F        ; $00C1E0
        dc.w    $41F8        ; $00C1E2  LEA ($9000).W,A0
        dc.w    $9000        ; $00C1E4
        dc.w    $4EBA        ; $00C1E6  JSR $CC92(PC)
        dc.w    $0AAA        ; $00C1E8
        dc.w    $7200        ; $00C1EA  MOVEQ #0,D1
        dc.w    $4EBA        ; $00C1EC  JSR $CE56(PC)
        dc.w    $0C68        ; $00C1EE
        dc.w    $4EBA        ; $00C1F0  JSR $CD4C(PC)
        dc.w    $0B5A        ; $00C1F2
        dc.w    $4EB9        ; $00C1F4  JSR $0088A80A (entity_table_load_mode)
        dc.w    $0088        ; $00C1F6
        dc.w    $A80A        ; $00C1F8
        dc.w    $4EB9        ; $00C1FA  JSR $0088A144
        dc.w    $0088        ; $00C1FC
        dc.w    $A144        ; $00C1FE
; --- falls through to scene_init_orch at $C200 ---
