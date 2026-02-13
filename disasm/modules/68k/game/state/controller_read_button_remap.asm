; ============================================================================
; Controller Read + Button Remap (Port 1)
; ROM Range: $00178E-$0017D6 (72 bytes)
; ============================================================================
; Category: input
; Purpose: Reads controller port 1 via Z80 bus, remaps buttons.
;   Data prefix: 16-byte controller remap table (2 × 8 bytes).
;   If $C810 != $0D → exits early (wrong mode).
;   Loads P1 controller state from ($C86C), calls zbus_request
;   and button_remap. If $C811 != $0D → clears $C86E (P2 byte A).
;
; Uses: D0, D2, A0, A1, A2, A3
; RAM:
;   $C810: controller mode P1 (byte, checked == $0D)
;   $C811: controller mode P2 (byte, checked == $0D)
;   $C86C: P1 controller state (long)
;   $C86E: P2 controller byte A (byte, cleared if P2 inactive)
;   $C970: controller work buffer (8 bytes)
; Calls:
;   $0017EE: button_remap
;   $00185E: zbus_request
; ============================================================================

controller_read_button_remap:
; --- controller remap table (16 bytes, 2 × 8 entries) ---
        dc.w    $0406                           ; $00178E  remap[0]: buttons 4,6
        dc.w    $0100                           ; $001790  remap[1]: buttons 1,0
        dc.w    $0500                           ; $001792  remap[2]: buttons 5,0
        dc.w    $0000                           ; $001794  remap[3]: 0,0
        dc.w    $0406                           ; $001796  remap[4]: buttons 4,6
        dc.w    $0100                           ; $001798  remap[5]: buttons 1,0
        dc.w    $050A                           ; $00179A  remap[6]: buttons 5,10
        dc.w    $0908                           ; $00179C  remap[7]: buttons 9,8
; --- code ---
        cmpi.b  #$0D,($FFFFC810).w             ; $00179E  P1 mode == $0D?
        dc.w    $6630                           ; $0017A4  bne.s $0017D6 → exit (past fn)
        lea     ($FFFFC86C).w,A0                ; $0017A6  A0 → P1 controller state
        move.l  (A0),$00FF60D0                  ; $0017AA  copy state to VDP work
        lea     $00A10003,A1                    ; $0017B0  A1 → genesis controller port 1
        lea     ($FFFFC970).w,A2                ; $0017B6  A2 → controller work buffer
        lea     ($FFFFFE82).w,A3                ; $0017BA  A3 → I/O register
        dc.w    $4EBA,$009E                     ; $0017BE  jsr $00185E(pc) — zbus_request
        dc.w    $4EBA,$002A                     ; $0017C2  jsr $0017EE(pc) — button_remap
        cmpi.b  #$0D,($FFFFC811).w             ; $0017C6  P2 mode == $0D?
        dc.w    $6716                           ; $0017CC  beq.s $0017E4 → exit (past fn, P2 active)
        move.b  #$00,($FFFFC86E).w             ; $0017CE  clear P2 byte A (no P2)
        rts                                     ; $0017D4
