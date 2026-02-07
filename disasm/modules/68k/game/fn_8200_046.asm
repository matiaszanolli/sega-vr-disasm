; ============================================================================
; State Dispatch 046 (auto-analyzed)
; ROM Range: $009EC0-$00A050 (400 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   RAM: $C8AC (state_dispatch_idx), $C8AA (scene_state)
;   Object (A1, A2, A4, A6): +$14 (effect_duration), +$28, +$3C (heading_mirror), +$78, +$88
;
; Entry: A1 = object/entity pointer
; Entry: A2 = object/entity pointer
; Entry: A4 = object/entity pointer
; Entry: A6 = object/entity pointer
; Uses: D0, D6, D7, A0, A1, A2, A4, A6
; RAM:
;   $C8AA: scene_state
;   $C8AC: state_dispatch_idx
; Object fields:
;   +$14: effect_duration
;   +$28: [unknown]
;   +$3C: heading_mirror
;   +$78: [unknown]
;   +$88: [unknown]
; Confidence: high
; ============================================================================

fn_8200_046:
        MOVE.W  (-14164).W,D0                   ; $009EC0
        MOVEA.L $009ECA(PC,D0.W),A1             ; $009EC4
        JMP     (A1)                            ; $009EC8
        DC.W    $0088                           ; $009ECA
        DC.W    $A04E                           ; $009ECC
        DC.W    $0088                           ; $009ECE
        SUB.B  D7,(A6)                          ; $009ED0
        DC.W    $0088                           ; $009ED2
        SUB.B  D7,$0088(A2)                     ; $009ED4
        DC.W    $9F4A                           ; $009ED8
        DC.W    $0088                           ; $009EDA
        SUB.W  D7,$0088(A4)                     ; $009EDC
        DC.W    $9F8E                           ; $009EE0
        DC.W    $0088                           ; $009EE2
        DC.W    $9FBC                           ; $009EE4
        DC.W    $0088                           ; $009EE6
        DC.W    $A04E                           ; $009EE8
        DC.W    $0088                           ; $009EEA
        MOVE.W  (A2)+,-$78(A6,D0.W)             ; $009EEC
        MOVE.W  -(A6),-$78(A6,D0.W)             ; $009EF0
        DC.W    $3DD4                           ; $009EF4
        DC.W    $0088                           ; $009EF6
        MOVE.W  A0,D7                           ; $009EF8
        DC.W    $0088                           ; $009EFA
        MOVEA.W (A0)+,A7                        ; $009EFC
        DC.W    $0088                           ; $009EFE
        MOVEA.W -(A4),A7                        ; $009F00
        DC.W    $0088                           ; $009F02
        DC.W    $3E7E                           ; $009F04
        DC.W    $0088                           ; $009F06
        MOVE.W  -(A2),(A7)                      ; $009F08
        DC.W    $0088                           ; $009F0A
        MOVE.W  D6,(A7)+                        ; $009F0C
        DC.W    $0088                           ; $009F0E
        MOVE.W  -$78(A6,D0.W),(A7)+             ; $009F10
        MOVE.W  $4278(A4),-(A7)                 ; $009F14
        DC.W    $90B0                           ; $009F18
        CLR.W  (-14166).W                       ; $009F1A
        MOVE.B  #$01,$00FF6990                  ; $009F1E
        ADDQ.W  #4,(-14164).W                   ; $009F26
        CMPI.W  #$003C,(-14166).W               ; $009F2A
        BLT.W  .loc_0162                        ; $009F30
        ADDQ.W  #4,(-14164).W                   ; $009F34
        CLR.W  (-14166).W                       ; $009F38
        MOVE.B  #$09,$00FF6980                  ; $009F3C
        MOVE.B  #$C0,(-14172).W                 ; $009F44
        CMPI.W  #$0014,(-14166).W               ; $009F4A
        BLT.W  .loc_0162                        ; $009F50
        ADDQ.W  #4,(-14164).W                   ; $009F54
        CLR.W  (-14166).W                       ; $009F58
        MOVE.L  #$222F038A,$00FF6988            ; $009F5C
        MOVE.B  #$C1,(-14172).W                 ; $009F66
        CMPI.W  #$0014,(-14166).W               ; $009F6C
        BLT.W  .loc_0162                        ; $009F72
        ADDQ.W  #4,(-14164).W                   ; $009F76
        CLR.W  (-14166).W                       ; $009F7A
        MOVE.L  #$222F002C,$00FF6988            ; $009F7E
        MOVE.B  #$C2,(-14172).W                 ; $009F88
        CMPI.W  #$0014,(-14166).W               ; $009F8E
        BLT.W  .loc_0162                        ; $009F94
        ADDQ.W  #4,(-14164).W                   ; $009F98
        CLR.W  (-14166).W                       ; $009F9C
        CLR.B  $00FF6990                        ; $009FA0
        MOVE.L  #$222EEF3A,$00FF6988            ; $009FA6
        BSET    #4,(-15602).W                   ; $009FB0
        MOVE.B  #$C3,(-14172).W                 ; $009FB6
        CMPI.W  #$0005,(-14166).W               ; $009FBC
        BNE.S  .loc_0118                        ; $009FC2
        MOVE.B  #$82,(-14171).W                 ; $009FC4
        BTST    #5,(-14322).W                   ; $009FCA
        BEQ.S  .loc_0118                        ; $009FD0
        MOVE.B  #$93,(-14171).W                 ; $009FD2
.loc_0118:
        CLR.W  (-16346).W                       ; $009FD8
        TST.B  (-15598).W                       ; $009FDC
        BNE.S  .loc_013C                        ; $009FE0
        MOVEQ   #$00,D0                         ; $009FE2
        BTST    #2,(-14165).W                   ; $009FE4
        BNE.S  .loc_012E                        ; $009FEA
        MOVEQ   #$09,D0                         ; $009FEC
.loc_012E:
        MOVE.B  D0,$00FF6980                    ; $009FEE
        CMPI.W  #$003C,(-14166).W               ; $009FF4
        BLT.S  .loc_0174                        ; $009FFA
.loc_013C:
        ADDQ.W  #4,(-14164).W                   ; $009FFC
        LEA     $00FF66DC,A1                    ; $00A000
        CLR.W  (A1)                             ; $00A006
        CLR.W  $0014(A1)                        ; $00A008
        CLR.W  $0028(A1)                        ; $00A00C
        CLR.W  $003C(A1)                        ; $00A010
        MOVE.W  #$FFFF,(-16346).W               ; $00A014
        CLR.B  $00FF6980                        ; $00A01A
        BRA.S  .loc_018E                        ; $00A020
.loc_0162:
        MOVEQ   #$00,D0                         ; $00A022
        BTST    #2,(-14165).W                   ; $00A024
        BEQ.S  .loc_016E                        ; $00A02A
        MOVEQ   #$01,D0                         ; $00A02C
.loc_016E:
        MOVE.B  D0,$00FF6990                    ; $00A02E
.loc_0174:
        MOVE.W  (-28496).W,D0                   ; $00A034
        ADDQ.W  #1,(-28496).W                   ; $00A038
        MULU    #$3BBB,D0                       ; $00A03C
        SWAP    D0                              ; $00A040
        CMPI.W  #$001B,D0                       ; $00A042
        BLE.S  .loc_018A                        ; $00A046
        MOVEQ   #$1B,D0                         ; $00A048
.loc_018A:
        MOVE.W  D0,(-16346).W                   ; $00A04A
.loc_018E:
        RTS                                     ; $00A04E
