; ============================================================================
; Heading with Camera Rotation
; ROM Range: $0090A4-$0090CE (42 bytes)
; ============================================================================
; Heading calculation with camera rotation offset from $C0B0.
;
; Entry: none
; Uses: D0
; ============================================================================

heading_with_camera:
        move.w  ($FFFFC0B0).w,d0        ; $3038 $C0B0 — camera elevation
        asl.w   #3,d0                 ; Scale up
        add.w   ($FFFF903C).w,d0        ; $D078 $903C — base position
        add.w   ($FFFF9096).w,d0        ; $D078 $9096 — offset
        tst.w    ($FFFFC04C).w          ; $4A78 $C04C — camera flag
        beq.s   .no_cam
        sub.w   ($FFFF9046).w,d0        ; $9078 $9046
.no_cam:
        asr.w   #6,d0
        btst    #7,($FFFFFDA8).w        ; $0838 $0007 $FDA8
        beq.s   .store
        neg.w   d0
.store:
        move.w  d0,($FFFF8002).w        ; $31C0 $8002
        rts
