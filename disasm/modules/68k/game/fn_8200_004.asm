; ============================================================================
; State Dispatch 004 (auto-analyzed)
; ROM Range: $008280-$0082E0 (96 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   RAM: $C8AA (scene_state), $68F8 (time_display_buf)
;   Calls: num_to_decimal
;   Object (A0, A1): +$02 (flags/type), +$07
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, D1, D6, D7, A0, A1
; RAM:
;   $68F8: time_display_buf
;   $C8AA: scene_state
; Calls:
;   $00839A: num_to_decimal
; Object fields:
;   +$02: flags/type
;   +$07: [unknown]
; Confidence: medium
; ============================================================================

fn_8200_004:
        CLR.W  (-14166).W                       ; $008280
        MOVEQ   #$00,D6                         ; $008284
        MOVE.B  (-15591).W,D0                   ; $008286
        ANDI.W  #$00C0,D0                       ; $00828A
        LSR.B  #4,D0                            ; $00828E
        MOVEA.L $0082E8(PC,D0.W),A1             ; $008290
        JSR     (A1)                            ; $008294
        LEA     $00FF68F8,A1                    ; $008296
        MOVE.B  D0,-$0007(A1)                   ; $00829C
        MOVE.B  D1,(A1)+                        ; $0082A0
        DC.W    $4EBA,$00F6         ; JSR     $00839A(PC); $0082A2
        MOVE.W  (-16306).W,D0                   ; $0082A6
        DC.W    $673A               ; BEQ.S  $0082E6; $0082AA
        MOVEQ   #$00,D7                         ; $0082AC
        SUBQ.W  #1,(-16306).W                   ; $0082AE
        DC.W    $672C               ; BEQ.S  $0082E0; $0082B2
        BTST    #2,(-14165).W                   ; $0082B4
        BNE.S  .loc_003E                        ; $0082BA
        MOVEQ   #$03,D7                         ; $0082BC
.loc_003E:
        TST.B  (-15611).W                       ; $0082BE
        DC.W    $6622               ; BNE.S  $0082E6; $0082C2
        TST.W  D0                               ; $0082C4
        DC.W    $6B1E               ; BMI.S  $0082E6; $0082C6
        MOVE.W  $0002(A0),D1                    ; $0082C8
        ANDI.W  #$0200,D1                       ; $0082CC
        DC.W    $670E               ; BEQ.S  $0082E0; $0082D0
        ANDI.W  #$FDFF,$0002(A0)                ; $0082D2
        MOVE.W  #$0000,(-16306).W               ; $0082D8
        RTS                                     ; $0082DE
