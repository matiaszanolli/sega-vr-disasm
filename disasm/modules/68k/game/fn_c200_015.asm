; ============================================================================
; Scene 015 (auto-analyzed)
; ROM Range: $00CD92-$00CDD2 (64 bytes)
; ============================================================================
; Category: game
; Purpose: RAM: $C8AA (scene_state), $C8AC (state_dispatch_idx), $C8AE (effect_timer)
;
; Uses: D1, D7, A1
; RAM:
;   $C8AA: scene_state
;   $C8AC: state_dispatch_idx
;   $C8AE: effect_timer
; Confidence: high
; ============================================================================

fn_c200_015:
        MOVE.L  (-15776).W,-(A7)                ; $00CD92
        LEA     (-16384).W,A1                   ; $00CD96
        MOVEQ   #$00,D1                         ; $00CD9A
        JSR     $0088483A                       ; $00CD9C
        MOVE.L  (A7)+,(-15776).W                ; $00CDA2
        LEA     (-28672).W,A1                   ; $00CDA6
        MOVEQ   #$00,D1                         ; $00CDAA
        MOVEQ   #$0F,D7                         ; $00CDAC
.loc_001C:
        JSR     $00884842                       ; $00CDAE
        DBRA    D7,.loc_001C                    ; $00CDB4
        MOVEQ   #$00,D1                         ; $00CDB8
        MOVE.B  D1,(-15602).W                   ; $00CDBA
        MOVE.W  D1,(-14166).W                   ; $00CDBE
        MOVE.W  D1,(-14164).W                   ; $00CDC2
        MOVE.W  D1,(-14162).W                   ; $00CDC6
        MOVE.W  #$FFFF,(-16346).W               ; $00CDCA
        RTS                                     ; $00CDD0
