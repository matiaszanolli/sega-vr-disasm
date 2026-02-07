; ============================================================================
; Obj Sprite Input Check 001 (auto-analyzed)
; ROM Range: $00C200-$00C30A (266 bytes)
; ============================================================================
; Category: object
; Purpose: Orchestrator calling 9 subroutines
;   Accesses 32X registers: adapter_ctrl
;   RAM: $C87E (game_state), $C8A0 (race_state)
;   Calls: race_state_read, object_array_init, sprite_input_check, sprite_update_check
;   Object (A0): +$00
;
; Entry: A0 = object/entity pointer
; Uses: D0, A0, A5
; RAM:
;   $C87E: game_state
;   $C8A0: race_state
; Calls:
;   $0058C8: sprite_input_check
;   $005908: sprite_update_check
;   $00593C: sprite_state_process
;   $00A1FC: race_state_read
;   $00CC06: object_array_init
; Object fields:
;   +$00: [unknown]
; Confidence: high
; ============================================================================

fn_c200_001:
        LEA     (-28672).W,A0                   ; $00C200
        DC.W    $4EBA,$DFF6         ; JSR     $00A1FC(PC); $00C204
        DC.W    $4EBA,$076A         ; JSR     $00C974(PC); $00C208
        DC.W    $4EBA,$0CFE         ; JSR     $00CF0C(PC); $00C20C
        DC.W    $4EBA,$09F4         ; JSR     $00CC06(PC); $00C210
        DC.W    $4EBA,$0D98         ; JSR     $00CFAE(PC); $00C214
        MOVE.W  #$0000,(-14210).W               ; $00C218
        MOVE.W  #$0000,(-14092).W               ; $00C21E
        BCLR    #7,(-329).W                     ; $00C224
        BCLR    #0,(-14308).W                   ; $00C22A
        MOVE.W  #$C9A0,(-14144).W               ; $00C230
        MOVE.B  #$02,(-14326).W                 ; $00C236
        DC.W    $4EBA,$049C         ; JSR     $00C6DA(PC); $00C23C
        DC.W    $4EBA,$9686         ; JSR     $0058C8(PC); $00C240
        DC.W    $4EBA,$96C2         ; JSR     $005908(PC); $00C244
        DC.W    $4EBA,$96F2         ; JSR     $00593C(PC); $00C248
        ANDI.B  #$FC,$00A15181                  ; $00C24C
        ORI.B  #$01,$00A15181                   ; $00C254
        MOVE.W  #$8083,$00A15100                ; $00C25C
        JSR     $0088204A                       ; $00C264
        JSR     $008820C6                       ; $00C26A
        BSET    #6,(-14219).W                   ; $00C270
        MOVE.W  (-14220).W,(A5)                 ; $00C276
        JSR     $00884998                       ; $00C27A
        MOVE.W  #$0080,(-24576).W               ; $00C280
        MOVE.B  #$C5,(-14172).W                 ; $00C286
.loc_008C:
        JSR     $00882080                       ; $00C28C
        JSR     $00884998                       ; $00C292
        SUBQ.W  #1,(-24576).W                   ; $00C298
        BNE.S  .loc_008C                        ; $00C29C
        MOVE.W  (-14176).W,D0                   ; $00C29E
        LEA     $008BB1C4,A0                    ; $00C2A2
        MOVE.L  $00(A0,D0.W),(-13972).W         ; $00C2A8
        MOVE.B  #$01,(-14327).W                 ; $00C2AE
        BSET    #6,(-14322).W                   ; $00C2B4
        MOVE.B  #$01,(-14334).W                 ; $00C2BA
.loc_00C0:
        BTST    #0,$00A15123                    ; $00C2C0
        BEQ.S  .loc_00C0                        ; $00C2C8
        BCLR    #0,$00A15123                    ; $00C2CA
        MOVE.W  #$0102,(-14168).W               ; $00C2D2
        MOVE.B  #$9C,(-14171).W                 ; $00C2D8
        JSR     $00882080                       ; $00C2DE
        JSR     $00884998                       ; $00C2E4
        MOVE.L  #$0088C30A,$00FF0002            ; $00C2EA
        MOVE.L  #$00000000,$00FF5FF8            ; $00C2F4
        MOVE.L  #$00000000,$00FF5FFC            ; $00C2FE
        RTS                                     ; $00C308
