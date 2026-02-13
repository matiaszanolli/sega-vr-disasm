; ============================================================================
; Object State Dispatcher (12-Entry Jump Table)
; ROM Range: $0034E8-$003540 (88 bytes)
; ============================================================================
; Category: game
; Purpose: Dispatches via 12-entry longword jump table indexed by
;   dispatch_idx ($C305) as byte. Jump table covers states $00-$2C.
;   States $08-$14 share handler at $3524; states $18-$20 share $3580.
;   Inline handler at $3524: if timer ($C04E) nonzero, sets VDP flags
;   $6950=3 and $6940=1, advances state by 4.
;
; Uses: D0, A1, A2, A3, A4
; RAM:
;   $C04E: timer (word)
;   $C305: dispatch_idx (byte, ×4 for table index)
; ============================================================================

object_state_disp_0034e8:
        moveq   #$00,D0                         ; $0034E8  clear D0
        move.b  ($FFFFC305).w,D0                ; $0034EA  D0 = dispatch_idx
        movea.l $0034F4(PC,D0.W),A1             ; $0034EE  A1 = handler address
        jmp     (A1)                            ; $0034F2  dispatch
; --- jump table (12 longword entries) ---
        dc.l    $008836DC                       ; $0034F4  [00] → $0036DC (past fn)
        dc.l    $008835B4                       ; $0034F8  [04] → $0035B4 (past fn)
        dc.l    $00883524                       ; $0034FC  [08] → inline handler
        dc.l    $00883524                       ; $003500  [0C] → inline handler
        dc.l    $00883524                       ; $003504  [10] → inline handler
        dc.l    $00883524                       ; $003508  [14] → inline handler
        dc.l    $00883580                       ; $00350C  [18] → $003580 (past fn)
        dc.l    $00883580                       ; $003510  [1C] → $003580 (past fn)
        dc.l    $00883580                       ; $003514  [20] → $003580 (past fn)
        dc.l    $00883540                       ; $003518  [24] → $003540 (past fn)
        dc.l    $0088359C                       ; $00351C  [28] → $00359C (past fn)
        dc.l    $008836C0                       ; $003520  [2C] → $0036C0 (past fn)
; --- inline handler (states $08-$14) ---
        tst.w   ($FFFFC04E).w                   ; $003524  timer active?
        dc.w    $6772                           ; $003528  beq.s $00359C — no → exit
        move.b  #$03,$00FF6950                  ; $00352A  VDP flag = 3
        move.b  #$01,$00FF6940                  ; $003532  VDP flag = 1
        addq.b  #4,($FFFFC305).w                ; $00353A  advance state by 4
        rts                                     ; $00353E

