; ============================================================================
; Object State Dispatcher + Scene Transition
; ROM Range: $006200-$006240 (64 bytes)
; ============================================================================
; Category: game
; Purpose: Dispatches via 2-entry jump table at $006240 (BEQ selects D0=0
;   or D0=4 based on Z flag from caller). Calls handler via JSR (A1).
;   After handler: if scene_state ($C8AA) == 20:
;     clears $C800, copies $C092 → $C07A,
;     sets state_dispatch_idx ($C8AC) = 4.
;     If $C89C nonzero → state_dispatch_idx = $20.
;     If $C81C bit 7 set → state_dispatch_idx = $20.
;
; Uses: D0, A1
; RAM:
;   $C07A: bitmask table index (word, set from $C092)
;   $C092: source param (word)
;   $C800: scene flag (byte, cleared)
;   $C81C: control flags (byte, bit 7)
;   $C89C: SH2 comm state (word)
;   $C8AA: scene_state (word)
;   $C8AC: state_dispatch_idx (word, set to 4 or $20)
; ============================================================================

object_state_disp_scene_transition:
        beq.s   .dispatch                       ; $006200  Z set → D0=0 (default)
        moveq   #$04,D0                         ; $006202  Z clear → D0=4
.dispatch:
        movea.l $006240(PC,D0.W),A1            ; $006204  A1 = handler address
        jsr     (A1)                            ; $006208  call handler
        cmpi.w  #$0014,($FFFFC8AA).w           ; $00620A  scene_state == 20?
        bne.s   .done                           ; $006210  no → done
        move.b  #$00,($FFFFC800).w             ; $006212  clear scene flag
        move.w  ($FFFFC092).w,($FFFFC07A).w    ; $006218  copy param to index
        move.w  #$0004,($FFFFC8AC).w           ; $00621E  state_dispatch = 4
        tst.w   ($FFFFC89C).w                  ; $006224  SH2 comm active?
        beq.s   .check_flag                     ; $006228  no → check flag
        move.w  #$0020,($FFFFC8AC).w           ; $00622A  state_dispatch = $20
.check_flag:
        btst    #7,($FFFFC81C).w               ; $006230  bit 7 set?
        beq.s   .done                           ; $006236  no → done
        move.w  #$0020,($FFFFC8AC).w           ; $006238  state_dispatch = $20
.done:
        rts                                     ; $00623E
