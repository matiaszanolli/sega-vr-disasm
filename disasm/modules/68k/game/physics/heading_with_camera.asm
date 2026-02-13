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
        dc.w    $3038,$C0B0           ; MOVE.W ($C0B0).W,D0 - camera elevation
        asl.w   #3,d0                 ; Scale up
        dc.w    $D078,$903C           ; ADD.W ($903C).W,D0 - base position
        dc.w    $D078,$9096           ; ADD.W ($9096).W,D0 - offset
        dc.w    $4A78,$C04C           ; TST.W ($C04C).W - camera flag
        beq.s   .no_cam
        dc.w    $9078,$9046           ; SUB.W ($9046).W,D0
.no_cam:
        asr.w   #6,d0
        dc.w    $0838,$0007,$FDA8     ; BTST #7,($FDA8).W
        beq.s   .store
        neg.w   d0
.store:
        dc.w    $31C0,$8002           ; MOVE.W D0,($8002).W
        rts
