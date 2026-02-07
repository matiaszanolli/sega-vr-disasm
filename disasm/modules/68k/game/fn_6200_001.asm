; ============================================================================
; Obj Dispatch 001 (auto-analyzed)
; ROM Range: $006200-$006240 (64 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   RAM: $C8AA (scene_state), $C8AC (state_dispatch_idx), $C89C (sh2_comm_state)
;
; Uses: D0, A1
; RAM:
;   $C89C: sh2_comm_state
;   $C8AA: scene_state
;   $C8AC: state_dispatch_idx
; Confidence: high
; ============================================================================

fn_6200_001:
        BEQ.S  .loc_0004                        ; $006200
        MOVEQ   #$04,D0                         ; $006202
.loc_0004:
        MOVEA.L $006240(PC,D0.W),A1             ; $006204
        JSR     (A1)                            ; $006208
        CMPI.W  #$0014,(-14166).W               ; $00620A
        BNE.S  .loc_003E                        ; $006210
        MOVE.B  #$00,(-14336).W                 ; $006212
        MOVE.W  (-16238).W,(-16262).W           ; $006218
        MOVE.W  #$0004,(-14164).W               ; $00621E
        TST.W  (-14180).W                       ; $006224
        BEQ.S  .loc_0030                        ; $006228
        MOVE.W  #$0020,(-14164).W               ; $00622A
.loc_0030:
        BTST    #7,(-14308).W                   ; $006230
        BEQ.S  .loc_003E                        ; $006236
        MOVE.W  #$0020,(-14164).W               ; $006238
.loc_003E:
        RTS                                     ; $00623E
