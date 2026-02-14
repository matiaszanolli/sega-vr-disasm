; ============================================================================
; VDP Buffer Transfer + Camera Offset Apply
; ROM Range: $003126-$003160 (58 bytes)
; ============================================================================
; Category: game
; Purpose: Copies camera parameters to VDP buffer at $FF6100.
;   Writes $C086 to buffer field +$02, calls $002996 (buffer init).
;   Adds 3 camera offset words ($C0AE/$C0B0/$C0B2) to buffer fields
;   +$08/+$0A/+$0C. If $C8C8 nonzero → adds $E0 to field +$06 (speed boost).
;
; Uses: D0, A0, A1
; RAM:
;   $9000: work buffer base (word)
;   $C086: camera parameter (word)
;   $C0AE: camera offset X (word)
;   $C0B0: camera offset Y (word)
;   $C0B2: camera offset Z (word)
;   $C8C8: boost flag (word)
; Calls:
;   $002996: VDP buffer init
; ============================================================================

vdp_buffer_xfer_camera_offset_apply:
        lea     ($FFFF9000).w,A0                ; $003126  A0 → work buffer base
        lea     $00FF6100,A1                    ; $00312A  A1 → VDP buffer
        move.w  ($FFFFC086).w,$0002(A1)         ; $003130  buffer+$02 = camera param
        jsr     camera_param_calc+18(pc); $4EBA $F85E
        move.w  ($FFFFC0AE).w,D0               ; $00313A  D0 = camera offset X
        add.w   D0,$0008(A1)                    ; $00313E  buffer+$08 += offset X
        move.w  ($FFFFC0B0).w,D0               ; $003142  D0 = camera offset Y
        add.w   D0,$000A(A1)                    ; $003146  buffer+$0A += offset Y
        move.w  ($FFFFC0B2).w,D0               ; $00314A  D0 = camera offset Z
        add.w   D0,$000C(A1)                    ; $00314E  buffer+$0C += offset Z
        tst.w   ($FFFFC8C8).w                  ; $003152  boost active?
        beq.s   .done                           ; $003156  no → done
        addi.w  #$00E0,$0006(A1)               ; $003158  buffer+$06 += $E0 (speed boost)
.done:
        rts                                     ; $00315E
