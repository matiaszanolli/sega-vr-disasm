; ============================================================================
; Ai Scene 038 (auto-analyzed)
; ROM Range: $00BD2A-$00BD9E (116 bytes)
; ============================================================================
; Category: game
; Purpose: RAM: $C8AA (scene_state)
;   Object (A0, A1): +$01, +$02 (flags/type), +$10
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, D1, D2, A0, A1, A2
; RAM:
;   $C8AA: scene_state
; Object fields:
;   +$01: [unknown]
;   +$02: flags/type
;   +$10: [unknown]
; Confidence: medium
; ============================================================================

fn_a200_038:
        MOVEQ   #$00,D2                         ; $00BD2A
        MOVE.B  $0001(A0),D2                    ; $00BD2C
        ADDQ.W  #1,D2                           ; $00BD30
        MOVE.W  (-14166).W,D0                   ; $00BD32
        LEA     $0002(A0),A2                    ; $00BD36
        LEA     (A2),A1                         ; $00BD3A
.loc_0012:
        LEA     -$0010(A1),A1                   ; $00BD3C
        CMPI.B  #$0C,-$0002(A1)                 ; $00BD40
        BEQ.S  .loc_0012                        ; $00BD46
        MOVE.W  (A2)+,D1                        ; $00BD48
        SUB.W  (A1),D1                          ; $00BD4A
        MULS    D0,D1                           ; $00BD4C
        DIVS    D2,D1                           ; $00BD4E
        ADD.W  (A1)+,D1                         ; $00BD50
        MOVE.W  D1,(-16250).W                   ; $00BD52
        MOVE.W  (A2)+,D1                        ; $00BD56
        SUB.W  (A1),D1                          ; $00BD58
        MULS    D0,D1                           ; $00BD5A
        DIVS    D2,D1                           ; $00BD5C
        ADD.W  (A1)+,D1                         ; $00BD5E
        MOVE.W  D1,(-16300).W                   ; $00BD60
        MOVE.W  (A2)+,D1                        ; $00BD64
        SUB.W  (A1),D1                          ; $00BD66
        MULS    D0,D1                           ; $00BD68
        DIVS    D2,D1                           ; $00BD6A
        ADD.W  (A1)+,D1                         ; $00BD6C
        MOVE.W  D1,(-16298).W                   ; $00BD6E
        MOVE.W  (A2)+,D1                        ; $00BD72
        SUB.W  (A1),D1                          ; $00BD74
        MULS    D0,D1                           ; $00BD76
        DIVS    D2,D1                           ; $00BD78
        ADD.W  (A1)+,D1                         ; $00BD7A
        MOVE.W  D1,(-16210).W                   ; $00BD7C
        MOVE.W  (A2)+,D1                        ; $00BD80
        SUB.W  (A1),D1                          ; $00BD82
        MULS    D0,D1                           ; $00BD84
        DIVS    D2,D1                           ; $00BD86
        ADD.W  (A1)+,D1                         ; $00BD88
        MOVE.W  D1,(-16208).W                   ; $00BD8A
        MOVE.W  (A2)+,D1                        ; $00BD8E
        SUB.W  (A1),D1                          ; $00BD90
        MULS    D0,D1                           ; $00BD92
        DIVS    D2,D1                           ; $00BD94
        ADD.W  (A1)+,D1                         ; $00BD96
        MOVE.W  D1,(-16206).W                   ; $00BD98
        RTS                                     ; $00BD9C
