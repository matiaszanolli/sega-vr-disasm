; ============================================================================
; race_result_recording_003272 — Race Result Recording
; ROM Range: $003272-$00337A (264 bytes)
; ============================================================================
; Records race completion result for single-player. Steps:
;   1. Sets race status flag ($C3B8) to $02
;   2. Selects result slot from entity +$2C (car index x 16)
;   3. Reads lap timing data from RAM ($C876-$C878): steering byte,
;      throttle byte (rebased from $C4), brake byte (rebased from $C4)
;   4. Looks up compressed time values via ROM tables ($00899884/$0089980C)
;   5. Appends to timing buffer, updates buffer pointer ($C07A)
;   6. Calls score calculation ($00B2E4) and ranking update ($00B422)
;   7. Compares with best time ($C298), updates if new record
;   8. Sets race complete flag ($FF6940) and computes result display code
;
; Entry: A0 = entity pointer (car)
; Uses: D0, A0, A1, A2, A3
; ============================================================================

race_result_recording_003272:
        MOVE.B  #$02,(-15608).W                 ; $003272
        MOVEQ   #$00,D0                         ; $003278
        LEA     $00FF68D0,A1                    ; $00327A
        MOVE.W  $002C(A0),D0                    ; $003280
        SUBQ.W  #1,D0                           ; $003284
        LSL.W  #4,D0                            ; $003286
        ADDA.L  D0,A1                           ; $003288
        MOVE.L  A1,(-15784).W                   ; $00328A
        MOVE.B  #$02,$0000(A1)                  ; $00328E
        MOVE.B  #$03,$00FF6950                  ; $003294
        MOVEA.W (-16266).W,A2                   ; $00329C
        MOVEQ   #$00,D0                         ; $0032A0
        MOVE.B  (-14330).W,D0                   ; $0032A2
        MOVE.B  #$00,(-14330).W                 ; $0032A6
        ADD.W   D0,D0                           ; $0032AC
        LEA     $00899884,A3                    ; $0032AE
        MOVE.W  $00(A3,D0.W),D0                 ; $0032B4
        MOVE.B  D0,(A2)+                        ; $0032B8
        MOVEQ   #$00,D0                         ; $0032BA
        MOVE.B  (-14329).W,D0                   ; $0032BC
        MOVE.B  #$C4,(-14329).W                 ; $0032C0
        SUBI.B  #$C4,D0                         ; $0032C6
        ADD.W   D0,D0                           ; $0032CA
        LEA     $00899884,A3                    ; $0032CC
        MOVE.W  $00(A3,D0.W),D0                 ; $0032D2
        MOVE.B  D0,(A2)+                        ; $0032D6
        MOVEQ   #$00,D0                         ; $0032D8
        MOVE.B  (-14328).W,D0                   ; $0032DA
        MOVE.B  #$C4,(-14328).W                 ; $0032DE
        SUBI.B  #$C4,D0                         ; $0032E4
        ADD.W   D0,D0                           ; $0032E8
        LEA     $0089980C,A3                    ; $0032EA
        MOVE.W  $00(A3,D0.W),D0                 ; $0032F0
        MOVE.W  D0,(A2)+                        ; $0032F4
        MOVE.W  A2,(-16266).W                   ; $0032F6
        JSR     $0088B2E4                       ; $0032FA
        JSR     $0088B422                       ; $003300
        SUBQ.L  #4,A2                           ; $003306
        MOVE.L  (A2),D0                         ; $003308
        MOVE.L  #$222E070C,$00FF6948            ; $00330A
        MOVE.B  #$00,(-15605).W                 ; $003314
        CMP.L  (-15788).W,D0                    ; $00331A
        BGE.S  .loc_00EA                        ; $00331E
        MOVE.L  D0,(-15788).W                   ; $003320
        MOVEQ   #$00,D0                         ; $003324
        LEA     $00FF68D1,A1                    ; $003326
        MOVE.B  (-15609).W,D0                   ; $00332C
        LEA     $00(A1,D0.W),A2                 ; $003330
        MOVE.B  #$00,(A2)                       ; $003334
        MOVE.W  $002C(A0),D0                    ; $003338
        SUBQ.W  #1,D0                           ; $00333C
        LSL.W  #4,D0                            ; $00333E
        MOVE.B  D0,(-15609).W                   ; $003340
        LEA     $00(A1,D0.W),A2                 ; $003344
        MOVE.B  #$01,(A2)                       ; $003348
        MOVE.L  #$222DFB7C,$00FF6948            ; $00334C
        MOVE.B  #$01,(-15605).W                 ; $003356
.loc_00EA:
        MOVE.B  #$01,$00FF6940                  ; $00335C
        MOVE.B  (-14165).W,D0                   ; $003364
        ANDI.B  #$03,D0                         ; $003368
        ADD.B   D0,D0                           ; $00336C
        ADD.B   D0,D0                           ; $00336E
        ADDI.B  #$0C,D0                         ; $003370
        MOVE.B  D0,(-15611).W                   ; $003374
        RTS                                     ; $003378
