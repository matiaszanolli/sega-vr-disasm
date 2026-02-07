; ============================================================================
; Z80 Bus Vdp Init 010 (auto-analyzed)
; ROM Range: $000DD2-$000FEA (536 bytes)
; ============================================================================
; Category: vdp
; Purpose: Accesses VDP registers
;   RAM: $C87A (vint_dispatch_state)
;   Calls: z80_bus_vdp_init
;
; Uses: D0, D1, D4, D6, D7, A0, A1, A5
; RAM:
;   $C87A: vint_dispatch_state
; Calls:
;   $000FEA: z80_bus_vdp_init
; Confidence: medium
; ============================================================================

fn_200_010:
        MOVEQ   #$04,D0                         ; $000DD2
        JSR     $008814BE                       ; $000DD4
        MOVEQ   #$0A,D1                         ; $000DDA
        JSR     $0088155E                       ; $000DDC
        MOVE.W  #$0100,$00A11100                ; $000DE2
.loc_0018:
        BTST    #0,$00A11100                    ; $000DEA
        BNE.S  .loc_0018                        ; $000DF2
        MOVE.W  #$8C00,(A5)                     ; $000DF4
        MOVE.W  #$9010,(A5)                     ; $000DF8
        MOVE.W  (-14220).W,D4                   ; $000DFC
        BSET    #4,D4                           ; $000E00
        MOVE.W  D4,(A5)                         ; $000E04
        MOVE.L  #$93809403,(A5)                 ; $000E06
        MOVE.L  #$95009688,(A5)                 ; $000E0C
        MOVE.W  #$977F,(A5)                     ; $000E12
        MOVE.W  #$4000,(A5)                     ; $000E16
        MOVE.W  #$0083,(-14218).W               ; $000E1A
        MOVE.W  (-14218).W,(A5)                 ; $000E20
        MOVE.W  (-14220).W,(A5)                 ; $000E24
        MOVE.W  (-14220).W,D4                   ; $000E28
        BSET    #4,D4                           ; $000E2C
        MOVE.W  D4,(A5)                         ; $000E30
        MOVE.L  #$93409400,(A5)                 ; $000E32
        MOVE.L  #$954096C2,(A5)                 ; $000E38
        MOVE.W  #$977F,(A5)                     ; $000E3E
        MOVE.W  #$C000,(A5)                     ; $000E42
        MOVE.W  #$0080,(-14218).W               ; $000E46
        MOVE.W  (-14218).W,(A5)                 ; $000E4C
        MOVE.W  (-14220).W,(A5)                 ; $000E50
        BCLR    #6,(-14322).W                   ; $000E54
        MOVE.L  #$008BB4DC,(-13972).W           ; $000E5A
        MOVE.B  #$01,(-14327).W                 ; $000E62
        MOVE.B  #$01,(-14326).W                 ; $000E68
        BSET    #6,(-14322).W                   ; $000E6E
        MOVE.B  #$01,(-14334).W                 ; $000E74
        BSET    #6,(-14219).W                   ; $000E7A
        MOVE.W  (-14220).W,(A5)                 ; $000E80
.loc_00B2:
        JSR     $0088B684                       ; $000E84
        JSR     $00884998                       ; $000E8A
        BTST    #6,(-14322).W                   ; $000E90
        BNE.S  .loc_00B2                        ; $000E96
        NOP                                     ; $000E98
        NOP                                     ; $000E9A
        NOP                                     ; $000E9C
        DIVU    #$0000,D0                       ; $000E9E
        NOP                                     ; $000EA2
        NOP                                     ; $000EA4
        NOP                                     ; $000EA6
        MOVE    SR,-(A7)                        ; $000EA8
        MOVE    #$2700,SR                       ; $000EAA
        MOVE.W  #$0100,$00A11100                ; $000EAE
        MOVE.W  #$0100,$00A11200                ; $000EB6
.loc_00EC:
        BTST    #0,$00A11100                    ; $000EBE
        BNE.S  .loc_00EC                        ; $000EC6
        LEA     $00A00000,A1                    ; $000EC8
        MOVE.B  #$F3,(A1)+                      ; $000ECE
        MOVE.B  #$F3,(A1)+                      ; $000ED2
        MOVE.B  #$C3,(A1)+                      ; $000ED6
        MOVE.B  #$00,(A1)+                      ; $000EDA
        MOVE.B  #$00,(A1)+                      ; $000EDE
        MOVE.W  #$0000,$00A11200                ; $000EE2
        NOP                                     ; $000EEA
        NOP                                     ; $000EEC
        NOP                                     ; $000EEE
        NOP                                     ; $000EF0
        NOP                                     ; $000EF2
        NOP                                     ; $000EF4
        NOP                                     ; $000EF6
        NOP                                     ; $000EF8
        NOP                                     ; $000EFA
        NOP                                     ; $000EFC
        NOP                                     ; $000EFE
        NOP                                     ; $000F00
        NOP                                     ; $000F02
        NOP                                     ; $000F04
        MOVE.W  #$0000,$00A11100                ; $000F06
        MOVE.W  #$0100,$00A11200                ; $000F0E
        MOVE    (A7)+,SR                        ; $000F16
        MOVEQ   #-$01,D0                        ; $000F18
        MOVE.B  D0,$00C00011                    ; $000F1A
        NOP                                     ; $000F20
        NOP                                     ; $000F22
        SUBI.B  #$20,D0                         ; $000F24
        MOVE.B  D0,$00C00011                    ; $000F28
        NOP                                     ; $000F2E
        NOP                                     ; $000F30
        SUBI.B  #$20,D0                         ; $000F32
        MOVE.B  D0,$00C00011                    ; $000F36
        NOP                                     ; $000F3C
        NOP                                     ; $000F3E
        SUBI.B  #$20,D0                         ; $000F40
        MOVE.B  D0,$00C00011                    ; $000F44
        MOVE.W  #$0100,$00A11100                ; $000F4A
.loc_0180:
        BTST    #0,$00A11100                    ; $000F52
        BNE.S  .loc_0180                        ; $000F5A
        MOVE.L  D1,-(A7)                        ; $000F5C
        DC.W    $4EBA,$008A         ; JSR     $000FEA(PC); $000F5E
        MOVE.L  (A7)+,D1                        ; $000F62
        MOVE.L  #$C0000000,(A5)                 ; $000F64
        MOVEQ   #$3F,D7                         ; $000F6A
        MOVEQ   #$0E,D6                         ; $000F6C
.loc_019C:
        MOVE.W  D6,$00C00000                    ; $000F6E
        DBRA    D7,.loc_019C                    ; $000F74
        BSET    #6,(-14219).W                   ; $000F78
        MOVE.W  (-14220).W,(A5)                 ; $000F7E
        NOP                                     ; $000F82
        NOP                                     ; $000F84
        NOP                                     ; $000F86
        DIVU    #$0000,D0                       ; $000F88
        NOP                                     ; $000F8C
        NOP                                     ; $000F8E
        NOP                                     ; $000F90
.loc_01C0:
        JSR     $00894262                       ; $000F92
        MOVE.W  #$0004,(-14214).W               ; $000F98
        MOVE    #$2300,SR                       ; $000F9E
.loc_01D0:
        TST.W  (-14214).W                       ; $000FA2
        BNE.S  .loc_01D0                        ; $000FA6
        BRA.S  .loc_01C0                        ; $000FA8
.loc_01D8:
        JSR     $00884CBC                       ; $000FAA
        BSET    #0,(-14331).W                   ; $000FB0
.loc_01E4:
        TST.B  (-14331).W                       ; $000FB6
        BNE.S  .loc_01E4                        ; $000FBA
        BRA.S  .loc_01D8                        ; $000FBC
        MOVEQ   #$0B,D7                         ; $000FBE
        DC.W    $41FA,$FFD0         ; LEA     $000F92(PC),A0; $000FC0
        LEA     $00FF0000,A1                    ; $000FC4
        DC.W    $4EFA,$000E         ; JMP     $000FDA(PC); $000FCA
        MOVEQ   #$09,D7                         ; $000FCE
        DC.W    $41FA,$FFD8         ; LEA     $000FAA(PC),A0; $000FD0
        LEA     $00FF0000,A1                    ; $000FD4
        MOVE    #$2700,SR                       ; $000FDA
.loc_020C:
        MOVE.W  (A0)+,(A1)+                     ; $000FDE
        DBRA    D7,.loc_020C                    ; $000FE0
        MOVE    #$2300,SR                       ; $000FE4
        RTS                                     ; $000FE8
