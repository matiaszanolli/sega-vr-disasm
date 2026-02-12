; ============================================================================
; Lap Check Dispatcher (15-Entry Jump Table + Lap Advance)
; ROM Range: $00337A-$0033E3 (105 bytes)
; ============================================================================
; Category: game
; Purpose: Dispatches via 15-entry longword jump table indexed by
;   dispatch_idx ($C305). Jump table covers states $00-$38. States
;   $08-$2C share handler at $33C2. Inline handler: compares camera_state
;   ($C08E) with camera_target ($C07A). If equal: branches to set_state_0x34
;   (external function). Otherwise advances state by 4, checks lap count
;   (A0+$2C) vs total_laps ($C310). If race complete: sets state=$30.
;
; Uses: D0, D2, D4, A0, A1, A2, A4, A6
; RAM:
;   $C07A: camera_target (word)
;   $C08E: camera_state (word)
;   $C305: dispatch_idx (byte)
;   $C310: total_laps (byte)
; Object (A0):
;   +$2C: current_lap (word)
; ============================================================================

fn_2200_047:
        moveq   #$00,D0                         ; $00337A  clear D0
        move.b  ($FFFFC305).w,D0                ; $00337C  D0 = dispatch_idx
        movea.l $003386(PC,D0.W),A1             ; $003380  A1 = handler address
        jmp     (A1)                            ; $003384  dispatch
; --- jump table (15 longword entries) ---
        dc.l    $008834E6                       ; $003386  [00] → $0034E6 (past fn)
        dc.l    $00883404                       ; $00338A  [04] → $003404 (past fn)
        dc.l    $008833C2                       ; $00338E  [08] → handler at $33C2
        dc.l    $008833C2                       ; $003392  [0C] → handler at $33C2
        dc.l    $008833C2                       ; $003396  [10] → handler at $33C2
        dc.l    $008833C2                       ; $00339A  [14] → handler at $33C2
        dc.l    $008833C2                       ; $00339E  [18] → handler at $33C2
        dc.l    $008833C2                       ; $0033A2  [1C] → handler at $33C2
        dc.l    $008833C2                       ; $0033A6  [20] → handler at $33C2
        dc.l    $008833C2                       ; $0033AA  [24] → handler at $33C2
        dc.l    $008833C2                       ; $0033AE  [28] → handler at $33C2
        dc.l    $008833C2                       ; $0033B2  [2C] → handler at $33C2
        dc.l    $008833EC                       ; $0033B6  [30] → $0033EC (past fn)
        dc.l    $008833FC                       ; $0033BA  [34] → $0033FC (past fn)
        dc.l    $008834CA                       ; $0033BE  [38] → $0034CA (past fn)
; --- inline handler: lap check ---
        move.w  ($FFFFC08E).w,D0                ; $0033C2  D0 = camera_state
        cmp.w   ($FFFFC07A).w,D0                ; $0033C6  == camera_target?
        beq.s   set_state_0x34                  ; $0033CA  yes → external fn
        addq.b  #4,($FFFFC305).w                ; $0033CC  advance state by 4
        move.w  $002C(A0),D0                    ; $0033D0  D0 = current_lap
        subq.w  #1,D0                           ; $0033D4  D0-- (adjust for 0-based)
        cmp.b   ($FFFFC310).w,D0                ; $0033D6  D0 >= total_laps?
        bne.s   .done                           ; $0033DA  no → done
        move.b  #$30,($FFFFC305).w              ; $0033DC  set state to $30 (race complete)
.done:
        rts                                     ; $0033E2

