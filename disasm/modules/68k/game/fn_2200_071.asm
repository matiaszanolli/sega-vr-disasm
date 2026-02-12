; ============================================================================
; Scene Transition Check + VDP Clear
; ROM Range: $003E08-$003E52 (74 bytes)
; ============================================================================
; Category: game
; Purpose: At scene_state ($C8AA) == 10: loads SFX from table at $003E52
;   indexed by $C89C, writes to $C8A5. If $C80E bit 5 set → SFX = $93.
;   At scene_state > 40: resets scene_state and state_dispatch_idx ($C8AC),
;   clears 3 VDP registers ($FF6980/$FF6990/$FF69C0).
;
; Uses: D0
; RAM:
;   $C80E: display control (byte, bit 5)
;   $C89C: SH2 comm state (word)
;   $C8A5: sound effect (byte)
;   $C8AA: scene_state (word)
;   $C8AC: state_dispatch_idx (word, cleared)
; ============================================================================

fn_2200_071:
        cmpi.w  #$000A,($FFFFC8AA).w           ; $003E08  scene_state == 10?
        bne.s   .check_timeout                  ; $003E0E  no → check timeout
        move.w  ($FFFFC89C).w,D0               ; $003E10  D0 = SH2 comm state
        move.b  $003E52(PC,D0.W),($FFFFC8A5).w ; $003E14  SFX = table[D0]
        btst    #5,($FFFFC80E).w               ; $003E1A  display bit 5 set?
        beq.s   .check_timeout                  ; $003E20  no → check timeout
        move.b  #$93,($FFFFC8A5).w             ; $003E22  override SFX = $93
.check_timeout:
        cmpi.w  #$0028,($FFFFC8AA).w           ; $003E28  scene_state > 40?
        ble.s   .done                           ; $003E2E  no → done
        move.w  #$0000,($FFFFC8AA).w           ; $003E30  reset scene_state
        move.w  #$0000,($FFFFC8AC).w           ; $003E36  reset state_dispatch_idx
        moveq   #$00,D0                         ; $003E3C  D0 = 0
        move.b  D0,$00FF6980                   ; $003E3E  clear VDP reg A
        move.b  D0,$00FF6990                   ; $003E44  clear VDP reg B
        move.b  D0,$00FF69C0                   ; $003E4A  clear VDP reg C
.done:
        rts                                     ; $003E50
