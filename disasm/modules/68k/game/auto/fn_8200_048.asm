; ============================================================================
; Vdp Timer 048 (auto-analyzed)
; ROM Range: $00A0B4-$00A1CA (278 bytes)
; ============================================================================
; Category: vdp
; Purpose: Accesses VDP registers
;   RAM: $C8CC (race_substate), $C0FA (timer_state), $C8C8 (vint_state), $C89C (sh2_comm_state)
;   Object (A0, A1): +$00, +$50, +$70, +$88
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, D1, A0, A1
; RAM:
;   $C0FA: timer_state
;   $C89C: sh2_comm_state
;   $C8C8: vint_state
;   $C8CC: race_substate
; Object fields:
;   +$00: [unknown]
;   +$50: [unknown]
;   +$70: [unknown]
;   +$88: [unknown]
; Confidence: medium
; ============================================================================

fn_8200_048:
        ORI.W  #$0088,(A0)                      ; $00A0B4
        ORI.L  #$00980040,(A0)                  ; $00A0B8
        ORI.W  #$0080,$70(A0,D0.W)              ; $00A0BE
        ORI.W  #$0058,(A0)                      ; $00A0C4
        ORI.L  #$00980080,(A0)                  ; $00A0C8
        ORI.L  #$00C000C0,D0                    ; $00A0CE
        ORI.W  #$0068,(A0)                      ; $00A0D4
        ORI.L  #$00880050,D0                    ; $00A0D8
        ORI.W  #$0080,$0088(A0)                 ; $00A0DE
        ORI.W  #$0088,-(A0)                     ; $00A0E4
        ORI.L  #$00980098,(A0)                  ; $00A0E8
        ORI.L  #$00E000F0,-(A0)                 ; $00A0EE
        ORI.W  #$0088,(A0)                      ; $00A0F4
        ORI.L  #$00980050,(A0)                  ; $00A0F8
        ORI.W  #$0080,$0088(A0)                 ; $00A0FE
        ORI.W  #$0068,(A0)                      ; $00A104
        ORI.L  #$00880050,D0                    ; $00A108
        ORI.W  #$0080,$0088(A0)                 ; $00A10E
        ORI.W  #$0088,-(A0)                     ; $00A114
        ORI.L  #$009800B0,(A0)                  ; $00A118
        ORI.L  #$00C000C0,$50(A0,D0.W)          ; $00A11E
        DC.W    $0088                           ; $00A126
        ORI.L  #$00980060,(A0)                  ; $00A128
        ORI.W  #$00A0,-(A0)                     ; $00A12E
        DC.W    $00C0                           ; $00A132
        ORI.W  #$0068,(A0)                      ; $00A134
        ORI.L  #$00880050,D0                    ; $00A138
        ORI.W  #$0080,$0088(A0)                 ; $00A13E
        LEA     $00898818,A1                    ; $00A144
        MOVE.W  (-14132).W,D0                   ; $00A14A
        MOVEA.L $00(A1,D0.W),A1                 ; $00A14E
        MOVE.L  (A1)+,(-15752).W                ; $00A152
        MOVE.W  (A1)+,(-16154).W                ; $00A156
        MOVE.W  (A1)+,(-16152).W                ; $00A15A
        MOVE.W  (A1)+,(-16150).W                ; $00A15E
        MOVE.W  (A1)+,(-16148).W                ; $00A162
        MOVE.W  (A1)+,(-16146).W                ; $00A166
        MOVE.W  (A1)+,(-16144).W                ; $00A16A
        MOVE.W  (A1)+,(-16142).W                ; $00A16E
        MOVE.W  (A1)+,(-16140).W                ; $00A172
        MOVE.W  (A1)+,(-16138).W                ; $00A176
        MOVE.W  (A1)+,(-14130).W                ; $00A17A
        MOVE.W  (A1)+,(-14128).W                ; $00A17E
        MOVE.W  (A1)+,(-14126).W                ; $00A182
        MOVE.W  (A1)+,(-16136).W                ; $00A186
        MOVE.W  (A1)+,(-16134).W                ; $00A18A
        DC.W    $43FA,$003A         ; LEA     $00A1CA(PC),A1; $00A18E
        DC.W    $D040                           ; $00A192
        TST.B  (-15601).W                       ; $00A194
        BEQ.S  .loc_00E8                        ; $00A198
        ADDQ.W  #4,D0                           ; $00A19A
.loc_00E8:
        MOVE.L  $00(A1,D0.W),(-15748).W         ; $00A19C
        LEA     (-1032).W,A1                    ; $00A1A2
        MOVE.W  (-14136).W,D1                   ; $00A1A6
        MULS    #$0090,D1                       ; $00A1AA
        ADDA.W  D1,A1                           ; $00A1AE
        MOVE.W  (-14180).W,D1                   ; $00A1B0
        ASL.W  #3,D1                            ; $00A1B4
        ADDA.W  D1,A1                           ; $00A1B6
        MOVEQ   #$00,D1                         ; $00A1B8
        MOVE.B  (-599).W,D1                     ; $00A1BA
        MULS    #$0030,D1                       ; $00A1BE
        ADDA.W  D1,A1                           ; $00A1C2
        MOVE.L  A1,(-15744).W                   ; $00A1C4
        RTS                                     ; $00A1C8
