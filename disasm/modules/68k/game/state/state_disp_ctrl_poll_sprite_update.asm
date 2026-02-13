; ============================================================================
; State Dispatcher + Controller Poll + Sprite Update
; ROM Range: $005780-$0057CA (74 bytes)
; ============================================================================
; Category: game
; Purpose: Calls poll_controllers, advances sub_state ($C8C4) by 4,
;   writes $44 to SH2 COMM. Dispatches via 6-entry longword jump table
;   indexed by $C8C5 (frame sub-counter). After dispatch: calls
;   sprite_update and tail-jumps to object_update ($00B684).
;   Second entry point at $0057BC: increments $C886, writes $44
;   to SH2 COMM.
;
; Uses: D0, D2, A0, A1, A2, A6
; RAM:
;   $C886: scene counter (byte, +1)
;   $C8C4: sub_state (byte, +4 per call)
;   $C8C5: frame sub-counter (byte, dispatch index)
; Calls:
;   $00179E: poll_controllers
;   $00B684: object_update (tail-jump)
;   $00B6DA: sprite_update
; ============================================================================

state_disp_ctrl_poll_sprite_update:
        dc.w    $4EBA,$C01C                     ; $005780  jsr $00179E(pc) — poll_controllers
        addq.b  #4,($FFFFC8C4).w               ; $005784  sub_state += 4
        move.w  #$0044,$00FF0008               ; $005788  SH2 COMM = $44
        moveq   #$00,D0                         ; $005790  clear high bits
        move.b  ($FFFFC8C5).w,D0               ; $005792  D0 = frame sub-counter
        movea.l $0057A4(PC,D0.W),A1            ; $005796  A1 = handler address
        jsr     (A1)                            ; $00579A  call handler
        dc.w    $4EBA,$5F3C                     ; $00579C  jsr $00B6DA(pc) — sprite_update
        dc.w    $4EFA,$5EE2                     ; $0057A0  jmp $00B684(pc) — object_update (tail)
; --- jump table (6 longword entries) ---
        dc.l    $008857CA                       ; $0057A4  [00] → $0057CA (past fn)
        dc.l    $008857D0                       ; $0057A8  [04] → $0057D0 (past fn)
        dc.l    $008857D8                       ; $0057AC  [08] → $0057D8 (past fn)
        dc.l    $0088584A                       ; $0057B0  [0C] → $00584A (past fn)
        dc.l    $00885866                       ; $0057B4  [10] → $005866 (past fn)
        dc.l    $008858B4                       ; $0057B8  [14] → $0058B4 (past fn)
; --- second entry: scene counter advance ---
        addq.b  #1,($FFFFC886).w               ; $0057BC  scene counter++
        move.w  #$0044,$00FF0008               ; $0057C0  SH2 COMM = $44
        rts                                     ; $0057C8
