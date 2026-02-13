; ============================================================================
; State Velocity 033 (auto-analyzed)
; ROM Range: $009182-$009300 (382 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A0, A1): +$00, +$02 (flags/type), +$04 (speed_index/velocity), +$10, +$6A, +$74
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, D1, D2, A0, A1
; Object fields:
;   +$00: [unknown]
;   +$02: flags/type
;   +$04: speed_index/velocity
;   +$10: [unknown]
;   +$6A: [unknown]
;   +$74: [unknown]
;   +$7A: param_7a
;   +$7E: [unknown]
; Confidence: medium
; ============================================================================

fn_8200_033:
        MOVE.W  $008C(A0),D1                    ; $009182
        ADD.W  $006A(A0),D1                     ; $009186
        DC.W    $6600,$0174         ; BNE.W  $009300; $00918A
        TST.B  (-15601).W                       ; $00918E
        BEQ.W  .loc_00D2                        ; $009192
        MOVE.W  $00AE(A0),D0                    ; $009196
        DC.W    $D040                           ; $00919A
        LEA     (-16292).W,A1                   ; $00919C
        CMPI.W  #$0001,$00(A1,D0.W)             ; $0091A0
        BEQ.W  .loc_00D2                        ; $0091A6
        BTST    #1,(-13965).W                   ; $0091AA
        BEQ.S  .loc_007C                        ; $0091B0
        MOVE.W  $007A(A0),D2                    ; $0091B2
        CMPI.W  #$0006,D2                       ; $0091B6
        BGE.W  .loc_015C                        ; $0091BA
        MOVE.W  $0074(A0),D1                    ; $0091BE
        LEA     $0088A1F0,A1                    ; $0091C2
        DC.W    $D442                           ; $0091C8
        MULS    $00(A1,D2.W),D1                 ; $0091CA
        LSR.L  #8,D1                            ; $0091CE
        MOVE.W  D1,$0074(A0)                    ; $0091D0
        ADDQ.W  #1,$007A(A0)                    ; $0091D4
        CMPI.W  #$1F40,$0074(A0)                ; $0091D8
        BLT.S  .loc_0078                        ; $0091DE
        CMPI.W  #$0004,$007A(A0)                ; $0091E0
        BGE.S  .loc_0078                        ; $0091E6
        TST.W  $0082(A0)                        ; $0091E8
        BNE.S  .loc_0078                        ; $0091EC
        MOVE.W  #$000F,$0082(A0)                ; $0091EE
        MOVE.B  #$B4,(-14172).W                 ; $0091F4
.loc_0078:
        BRA.W  .loc_015C                        ; $0091FA
.loc_007C:
        BTST    #0,(-13965).W                   ; $0091FE
        BEQ.W  .loc_015C                        ; $009204
        TST.W  $007A(A0)                        ; $009208
        BLE.W  .loc_015C                        ; $00920C
        SUBQ.W  #1,$007A(A0)                    ; $009210
        MOVE.W  $0074(A0),D1                    ; $009214
        EXT.L   D1                              ; $009218
        LSL.L  #8,D1                            ; $00921A
        LEA     $0088A1F0,A1                    ; $00921C
        MOVE.W  $007A(A0),D2                    ; $009222
        DC.W    $D442                           ; $009226
        DIVU    $00(A1,D2.W),D1                 ; $009228
        MOVE.W  D1,$0074(A0)                    ; $00922C
        CMPI.W  #$4268,D1                       ; $009230
        BLE.W  .loc_015C                        ; $009234
        MOVE.W  #$4268,$0074(A0)                ; $009238
        TST.W  $0084(A0)                        ; $00923E
        BNE.S  .loc_00C8                        ; $009242
        MOVE.W  #$000A,$0084(A0)                ; $009244
.loc_00C8:
        MOVE.W  #$00FF,$0010(A0)                ; $00924A
        BRA.W  .loc_015C                        ; $009250
.loc_00D2:
        MOVE.W  $0074(A0),D2                    ; $009254
        MOVE.W  $007A(A0),D1                    ; $009258
        DC.W    $D241                           ; $00925C
        TST.W  $0004(A0)                        ; $00925E
        BEQ.W  .loc_012C                        ; $009262
        LEA     $0088A1E2,A1                    ; $009266
        CMP.W  $00(A1,D1.W),D2                  ; $00926C
        BLE.W  .loc_012C                        ; $009270
        LEA     $0088A1F0,A1                    ; $009274
        MULS    $00(A1,D1.W),D2                 ; $00927A
        LSR.L  #8,D2                            ; $00927E
        MOVE.W  D2,$0074(A0)                    ; $009280
        ADDQ.W  #1,$007A(A0)                    ; $009284
        CMPI.W  #$1F40,$0074(A0)                ; $009288
        BLT.S  .loc_0128                        ; $00928E
        CMPI.W  #$0004,$007A(A0)                ; $009290
        BGE.S  .loc_0128                        ; $009296
        TST.W  $0082(A0)                        ; $009298
        BNE.S  .loc_0128                        ; $00929C
        MOVE.W  #$000F,$0082(A0)                ; $00929E
        MOVE.B  #$B4,(-14172).W                 ; $0092A4
.loc_0128:
        BRA.W  .loc_015C                        ; $0092AA
.loc_012C:
        LEA     $00939EDE,A1                    ; $0092AE
        CMP.W  $00(A1,D1.W),D2                  ; $0092B4
        BGE.W  .loc_015C                        ; $0092B8
        SUBQ.W  #1,$007A(A0)                    ; $0092BC
        EXT.L   D2                              ; $0092C0
        LSL.L  #8,D2                            ; $0092C2
        LEA     $0088A1F0,A1                    ; $0092C4
        DIVS    -$02(A1,D1.W),D2                ; $0092CA
        MOVE.W  D2,$0074(A0)                    ; $0092CE
        TST.W  $0084(A0)                        ; $0092D2
        BNE.S  .loc_015C                        ; $0092D6
        MOVE.W  #$000A,$0084(A0)                ; $0092D8
.loc_015C:
        MOVE.W  $0074(A0),D1                    ; $0092DE
        SUB.W  $007E(A0),D1                     ; $0092E2
        CMPI.W  #$0400,D1                       ; $0092E6
        BLE.S  .loc_016E                        ; $0092EA
        MOVE.W  #$0400,D1                       ; $0092EC
.loc_016E:
        CMPI.W  #$FC00,D1                       ; $0092F0
        BGE.S  .loc_0178                        ; $0092F4
        MOVE.W  #$FC00,D1                       ; $0092F6
.loc_0178:
        ADD.W  D1,$007E(A0)                     ; $0092FA
        RTS                                     ; $0092FE
