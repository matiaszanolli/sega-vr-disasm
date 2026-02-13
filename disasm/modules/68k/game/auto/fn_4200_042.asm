; ============================================================================
; Logic Dispatch 042 (auto-analyzed)
; ROM Range: $005D08-$005DC8 (192 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   RAM: $C8A0 (race_state), $C8AA (scene_state), $C8AC (state_dispatch_idx), $C89C (sh2_comm_state)
;   Calls: load_object_params, timer_countdown, game_update, obj_velocity_y
;   Object (A0): +$44 (display_offset), +$46 (display_scale), +$4A
;
; Entry: A0 = object/entity pointer
; Uses: D0, A0, A1
; RAM:
;   $C89C: sh2_comm_state
;   $C8A0: race_state
;   $C8AA: scene_state
;   $C8AC: state_dispatch_idx
; Calls:
;   $002984: palette_update
;   $0031A6: display_mode_dispatch
;   $0036DE: clear_buffer
;   $0037B6: memory_copy
;   $003F86: clear_display_vars
;   $006F98: calc_steering
; Object fields:
;   +$44: display_offset
;   +$46: display_scale
;   +$4A: [unknown]
; Confidence: high
; ============================================================================

fn_4200_042:
        MOVE.B  #$01,(-14336).W                 ; $005D08
        MOVEQ   #$00,D0                         ; $005D0E
        MOVE.W  D0,$0044(A0)                    ; $005D10
        MOVE.W  D0,$0046(A0)                    ; $005D14
        MOVE.W  D0,$004A(A0)                    ; $005D18
        DC.W    $4EBA,$23AE         ; JSR     $0080CC(PC); $005D1C
        DC.W    $4EBA,$2826         ; JSR     $008548(PC); $005D20
        DC.W    $4EBA,$3ADC         ; JSR     $009802(PC); $005D24
        DC.W    $4EBA,$2150         ; JSR     $007E7A(PC); $005D28
        DC.W    $4EBA,$126A         ; JSR     $006F98(PC); $005D2C
        DC.W    $4EBA,$1FA6         ; JSR     $007CD8(PC); $005D30
        DC.W    $4EBA,$1374         ; JSR     $0070AA(PC); $005D34
        DC.W    $4EBA,$1410         ; JSR     $00714A(PC); $005D38
        DC.W    $4EBA,$1910         ; JSR     $00764E(PC); $005D3C
        DC.W    $4EBA,$220E         ; JSR     $007F50(PC); $005D40
        DC.W    $4EBA,$3F88         ; JSR     $009CCE(PC); $005D44
        DC.W    $4EBA,$4EF4         ; JSR     $00AC3E(PC); $005D48
        DC.W    $4EBA,$3E06         ; JSR     $009B54(PC); $005D4C
        DC.W    $4EBA,$29AC         ; JSR     $0086FE(PC); $005D50
        DC.W    $4EBA,$32EA         ; JSR     $009040(PC); $005D54
        DC.W    $4EBA,$247E         ; JSR     $0081D8(PC); $005D58
        DC.W    $4EBA,$18A0         ; JSR     $0075FE(PC); $005D5C
        DC.W    $4EBA,$1444         ; JSR     $0071A6(PC); $005D60
        DC.W    $4EBA,$CC1E         ; JSR     $002984(PC); $005D64
        DC.W    $4EBA,$D43C         ; JSR     $0031A6(PC); $005D68
        DC.W    $4EBA,$D970         ; JSR     $0036DE(PC); $005D6C
        DC.W    $4EBA,$DA44         ; JSR     $0037B6(PC); $005D70
        DC.W    $4EBA,$E210         ; JSR     $003F86(PC); $005D74
        MOVE.B  (-15612).W,(-15604).W           ; $005D78
        MOVE.W  (-14176).W,D0                   ; $005D7E
        BTST    #7,(-14308).W                   ; $005D82
        BEQ.S  .loc_0084                        ; $005D88
        MOVEQ   #$04,D0                         ; $005D8A
.loc_0084:
        MOVEA.L $005DC8(PC,D0.W),A1             ; $005D8C
        JSR     (A1)                            ; $005D90
        CMPI.W  #$0014,(-14166).W               ; $005D92
        BNE.S  .loc_00BE                        ; $005D98
        MOVE.B  #$00,(-14336).W                 ; $005D9A
        MOVE.W  (-16238).W,(-16262).W           ; $005DA0
        MOVE.W  #$0004,(-14164).W               ; $005DA6
        TST.W  (-14180).W                       ; $005DAC
        BEQ.S  .loc_00B0                        ; $005DB0
        MOVE.W  #$0020,(-14164).W               ; $005DB2
.loc_00B0:
        BTST    #7,(-14308).W                   ; $005DB8
        BEQ.S  .loc_00BE                        ; $005DBE
        MOVE.W  #$0020,(-14164).W               ; $005DC0
.loc_00BE:
        RTS                                     ; $005DC6
