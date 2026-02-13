; ============================================================================
; Scene State Timer + VDP Output
; ROM Range: $003EF6-$003F2C (54 bytes)
; ============================================================================
; Category: game
; Purpose: If scene_state ($C8AA) == 5 → plays SFX $98 via $C8A5.
;   Reads bit 2 of $C8AB: clear → D0=0, set → D0=9.
;   Writes D0 to VDP register $FF6980.
;   If scene_state > 60 ($3C) → clears VDP output, advances
;   state_dispatch_idx ($C8AC) by 4.
;
; Uses: D0
; RAM:
;   $C8AA: scene_state (word)
;   $C8AB: scene flags (byte, bit 2)
;   $C8A5: sound effect (byte)
;   $C8AC: state_dispatch_idx (word, advanced by 4)
; ============================================================================

scene_state_timer_vdp_output:
        cmpi.w  #$0005,($FFFFC8AA).w           ; $003EF6  scene_state == 5?
        bne.s   .skip_sfx                       ; $003EFC  no → skip
        move.b  #$98,($FFFFC8A5).w              ; $003EFE  play SFX $98
.skip_sfx:
        moveq   #$00,D0                         ; $003F04  D0 = 0 (default)
        btst    #2,($FFFFC8AB).w                ; $003F06  bit 2 set?
        bne.s   .write_vdp                      ; $003F0C  yes → use D0=0
        moveq   #$09,D0                         ; $003F0E  D0 = 9 (alternate)
.write_vdp:
        move.b  D0,$00FF6980                    ; $003F10  write to VDP register
        cmpi.w  #$003C,($FFFFC8AA).w           ; $003F16  scene_state > 60?
        ble.s   .done                           ; $003F1C  no → done
        move.b  #$00,$00FF6980                  ; $003F1E  clear VDP output
        addq.w  #4,($FFFFC8AC).w               ; $003F26  advance state_dispatch_idx
.done:
        rts                                     ; $003F2A
