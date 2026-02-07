; ============================================================================
; Vint Scene 077 (auto-analyzed)
; ROM Range: $003EF6-$003F2C (54 bytes)
; ============================================================================
; Category: game
; Purpose: RAM: $C8AA (scene_state), $C8AC (state_dispatch_idx)
;
; Uses: D0
; RAM:
;   $C8AA: scene_state
;   $C8AC: state_dispatch_idx
; Confidence: high
; ============================================================================

fn_2200_077:
        CMPI.W  #$0005,(-14166).W               ; $003EF6
        BNE.S  .loc_000E                        ; $003EFC
        MOVE.B  #$98,(-14171).W                 ; $003EFE
.loc_000E:
        MOVEQ   #$00,D0                         ; $003F04
        BTST    #2,(-14165).W                   ; $003F06
        BNE.S  .loc_001A                        ; $003F0C
        MOVEQ   #$09,D0                         ; $003F0E
.loc_001A:
        MOVE.B  D0,$00FF6980                    ; $003F10
        CMPI.W  #$003C,(-14166).W               ; $003F16
        BLE.S  .loc_0034                        ; $003F1C
        MOVE.B  #$00,$00FF6980                  ; $003F1E
        ADDQ.W  #4,(-14164).W                   ; $003F26
.loc_0034:
        RTS                                     ; $003F2A
