; ============================================================================
; entity_force_integration_and_speed_calc — Entity Force Integration and Speed Calculation
; ROM Range: $009300-$009458 (344 bytes)
; Integrates forces on entity: computes drag from speed tables, applies
; directional force from param $000E, subtracts friction/air resistance,
; handles speed overflow with sound trigger $B1/$B4. Computes final display
; speed at +$74 from gear table lookups. Multiple entry points — first
; 18 bytes serve as alternate entry with BRA to mid-function.
;
; Entry: A0 = entity pointer
; Uses: D0, D1, D2, D3, A0, A1, A2
; Object fields: +$04 speed, +$06 display speed, +$0C slope, +$0E force,
;   +$10 drag, +$16 calc speed, +$74 raw speed, +$78 grip, +$7A gear,
;   +$80 sound timer, +$82 brake timer
; Confidence: high
; ============================================================================

entity_force_integration_and_speed_calc:
        MOVE.W  #$FFCD,$000E(A0)                ; $009300
        MOVE.W  $0074(A0),D2                    ; $009306
        MOVE.W  $007A(A0),D1                    ; $00930A
        ADD.W   D1,D1                           ; $00930E
        DC.W    $609C               ; BRA.S  $0092AE; $009310
        MOVE.W  $0074(A0),D1                    ; $009312
        BGE.S  .clamp_speed_upper               ; $009316
        MOVEQ   #$00,D1                         ; $009318
        BRA.S  .speed_clamped                   ; $00931A
.clamp_speed_upper:
        CMPI.W  #$4268,D1                       ; $00931C
        BLE.S  .speed_clamped                   ; $009320
        MOVE.W  #$4268,D1                       ; $009322
.speed_clamped:
        ASR.W  #7,D1                            ; $009326
        LEA     $0093910E,A1                    ; $009328
        TST.B  (-15601).W                       ; $00932E
        BNE.S  .table_selected                  ; $009332
        LEA     $00938FCE,A1                    ; $009334
.table_selected:
        ADD.W   D1,D1                           ; $00933A
        MOVE.W  $00(A1,D1.W),D2                 ; $00933C
        MOVEA.L (-15752).W,A2                   ; $009340
        MOVE.W  $007A(A0),D3                    ; $009344
        ADD.W   D3,D3                           ; $009348
        MULU    $00(A2,D3.W),D2                 ; $00934A
        LSR.L  #5,D2                            ; $00934E
        MULS    $000E(A0),D2                    ; $009350
        ASR.L  #7,D2                            ; $009354
        BGT.S  .force_clamped                   ; $009356
        MOVE.L  #$FFFFFE00,D0                   ; $009358
        CMP.L  D0,D2                            ; $00935E
        BLT.S  .force_clamped                   ; $009360
        MOVE.L  D0,D2                           ; $009362
.force_clamped:
        jsr     speed_calc_multiplier_chain(pc); $4EBA $00F2
        MOVE.W  $0016(A0),D1                    ; $009368
        EXT.L   D1                              ; $00936C
        LSL.L  #4,D1                            ; $00936E
        SUB.L   D1,D2                           ; $009370
        MOVE.W  $0010(A0),D1                    ; $009372
        MULS    #$71C0,D1                       ; $009376
        ASR.L  #7,D1                            ; $00937A
        SUB.L   D1,D2                           ; $00937C
        BPL.S  .negative_force_doubled          ; $00937E
        ADD.L   D2,D2                           ; $009380
.negative_force_doubled:
        MOVE.W  #$0100,$0078(A0)                ; $009382
        MOVE.W  (-16148).W,D0                   ; $009388
        NEG.W  D0                               ; $00938C
        EXT.L   D0                              ; $00938E
        CMP.L  D0,D2                            ; $009390
        BGT.S  .check_overspeed                 ; $009392
        MOVE.L  D0,D1                           ; $009394
        ADD.L   D1,D1                           ; $009396
        CMP.L  D1,D2                            ; $009398
        BGT.S  .clamp_to_min                    ; $00939A
        MOVE.W  $0080(A0),D1                    ; $00939C
        OR.W   $008C(A0),D1                     ; $0093A0
        BNE.S  .clamp_to_min                    ; $0093A4
        CMPI.W  #$0014,$0004(A0)                ; $0093A6
        BLE.W  .clamp_to_min                    ; $0093AC
        MOVE.W  #$000F,$0080(A0)                ; $0093B0
        MOVE.B  #$B1,(-14172).W                 ; $0093B6
.clamp_to_min:
        MOVE.L  D0,D2                           ; $0093BC
        BRA.S  .integrate_speed                 ; $0093BE
.check_overspeed:
        MOVEQ   #$00,D0                         ; $0093C0
        MOVE.W  (-16150).W,D0                   ; $0093C2
        CMP.L  D0,D2                            ; $0093C6
        BLE.W  .integrate_speed                 ; $0093C8
        MOVE.L  D2,D1                           ; $0093CC
        SUB.L   D0,D1                           ; $0093CE
        ASL.L  #8,D1                            ; $0093D0
        DIVS    D0,D1                           ; $0093D2
        SUB.W  D1,$0078(A0)                     ; $0093D4
        CMPI.W  #$0080,D1                       ; $0093D8
        BLE.S  .check_tire_squeal               ; $0093DC
        MOVE.W  #$0080,$0078(A0)                ; $0093DE
.check_tire_squeal:
        TST.W  $007A(A0)                        ; $0093E4
        BNE.S  .integrate_speed                 ; $0093E8
        TST.W  $0082(A0)                        ; $0093EA
        BNE.S  .integrate_speed                 ; $0093EE
        MOVE.W  #$000F,$0082(A0)                ; $0093F0
        MOVE.B  #$B4,(-14172).W                 ; $0093F6
.integrate_speed:
        ASR.L  #1,D2                            ; $0093FC
        MULS    $0078(A0),D2                    ; $0093FE
        ASR.L  #7,D2                            ; $009402
        MOVE.W  D2,D1                           ; $009404
        ASR.W  #2,D1                            ; $009406
        EXT.L   D1                              ; $009408
        DIVS    #$0190,D1                       ; $00940A
        MOVE.W  D1,$000C(A0)                    ; $00940E
        ADD.W  D1,$0006(A0)                     ; $009412
        BPL.S  .display_speed_positive          ; $009416
        CLR.W  $0006(A0)                        ; $009418
.display_speed_positive:
        MOVEA.L (-15752).W,A1                   ; $00941C
        MOVE.W  $007A(A0),D1                    ; $009420
        ADD.W   D1,D1                           ; $009424
        MOVE.W  $00(A1,D1.W),D3                 ; $009426
        MULS    $0006(A0),D3                    ; $00942A
        ASL.L  #2,D3                            ; $00942E
        MOVE.L  D3,D1                           ; $009430
        ASL.L  #2,D3                            ; $009432
        ADD.L   D3,D1                           ; $009434
        ASL.L  #2,D3                            ; $009436
        ADD.L   D3,D1                           ; $009438
        ASL.L  #3,D3                            ; $00943A
        ADD.L   D1,D3                           ; $00943C
        MOVEQ   #$0C,D1                         ; $00943E
        LSR.L  D1,D3                            ; $009440
        BGE.S  .clamp_raw_upper                 ; $009442
        MOVEQ   #$00,D3                         ; $009444
.clamp_raw_upper:
        CMPI.L  #$00004268,D3                   ; $009446
        BLE.S  .store_raw_speed                 ; $00944C
        MOVE.W  #$4268,D3                       ; $00944E
.store_raw_speed:
        MOVE.W  D3,$0074(A0)                    ; $009452
        RTS                                     ; $009456
