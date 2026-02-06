; ============================================================================
; Speed Calculation (Table-Based)
; ROM Range: $00A3BA-$00A3E8 (46 bytes)
; ============================================================================
; Reads speed value from lookup table, optionally divides by 4 based on
; a RAM flag, then applies a speed boost if effect timer is active.
;
; Entry: A0 = object/entity pointer
; Uses: D0, A1
; Fields accessed:
;   A0+$04: Speed table index
;   A0+$14: Effect duration (from effect_timer_mgmt)
;   A0+$16: Calculated speed (output)
; RAM:
;   $C8C8: Mode flag (if == 2, speed is divided by 4)
; ============================================================================

speed_calculation:
        lea     $0093925E,a1            ; Speed table base address
        move.w  $4(a0),d0               ; Load speed index
        add.w   d0,d0                   ; Word offset (index * 2)
        dc.w    $3031,$0000             ; MOVE.W 0(A1,D0.W),D0 - read speed from table
        dc.w    $0C78,$0002,$C8C8       ; CMPI.W #$0002,($C8C8).W - check mode flag
        bne.s   .store_speed            ; If mode != 2, skip division
        asr.w   #2,d0                   ; Divide speed by 4
.store_speed:
        move.w  d0,$16(a0)              ; Store calculated speed
        tst.w   $14(a0)                 ; Check effect duration
        ble.s   .return                 ; If expired, done
        subq.w  #1,$14(a0)             ; Decrement effect duration
        addi.w  #$0738,$16(a0)          ; Add speed boost (+1848)
.return:
        rts
