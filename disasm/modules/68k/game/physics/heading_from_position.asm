; ============================================================================
; Heading from Position
; ROM Range: $009040-$009064 (36 bytes)
; ============================================================================
; Computes heading from entity position data. Camera correction applied.
;
; Entry: none
; Uses: D0
; ============================================================================

heading_from_position:
        dc.w    $3038,$903C           ; MOVE.W ($903C).W,D0 - base position
        dc.w    $D078,$9096           ; ADD.W ($9096).W,D0 - add offset
        dc.w    $4A78,$C04C           ; TST.W ($C04C).W - camera flag
        beq.s   .no_cam
        dc.w    $9078,$9046           ; SUB.W ($9046).W,D0 - camera correction
.no_cam:
        asr.w   #6,d0                 ; Scale down
        dc.w    $0838,$0007,$FDA8     ; BTST #7,($FDA8).W - mirror flag
        beq.s   .store
        neg.w   d0                    ; Mirror heading
.store:
        dc.w    $31C0,$8002           ; MOVE.W D0,($8002).W - store heading
        rts
