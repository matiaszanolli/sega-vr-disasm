; ============================================================================
; Vint Dispatch 071 (auto-analyzed)
; ROM Range: $003E08-$003E52 (74 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   RAM: $C8AA (scene_state), $C89C (sh2_comm_state), $C8AC (state_dispatch_idx)
;
; Uses: D0
; RAM:
;   $C89C: sh2_comm_state
;   $C8AA: scene_state
;   $C8AC: state_dispatch_idx
; Confidence: high
; ============================================================================

fn_2200_071:
        CMPI.W  #$000A,(-14166).W               ; $003E08
        BNE.S  .loc_0020                        ; $003E0E
        MOVE.W  (-14180).W,D0                   ; $003E10
        MOVE.B  $003E52(PC,D0.W),(-14171).W     ; $003E14
        BTST    #5,(-14322).W                   ; $003E1A
        BEQ.S  .loc_0020                        ; $003E20
        MOVE.B  #$93,(-14171).W                 ; $003E22
.loc_0020:
        CMPI.W  #$0028,(-14166).W               ; $003E28
        BLE.S  .loc_0048                        ; $003E2E
        MOVE.W  #$0000,(-14166).W               ; $003E30
        MOVE.W  #$0000,(-14164).W               ; $003E36
        MOVEQ   #$00,D0                         ; $003E3C
        MOVE.B  D0,$00FF6980                    ; $003E3E
        MOVE.B  D0,$00FF6990                    ; $003E44
        MOVE.B  D0,$00FF69C0                    ; $003E4A
.loc_0048:
        RTS                                     ; $003E50
