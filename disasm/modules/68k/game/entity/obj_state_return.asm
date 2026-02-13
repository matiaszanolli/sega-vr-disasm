; ============================================================================
; Object State Return
; ROM Range: $00A8F8-$00A970 (120 bytes)
; ============================================================================
; Computes or interpolates a position value for an entity.
; Two paths depending on whether A0+$04 (speed index) is nonzero:
;   Path 1 (speed-based): speed * lookup_table[index] * 596, scaled by >>12
;     Result clamped to 0-17000, stored at A0+$74
;   Path 2 (interpolation): delta toward target*64, clamped +-1024/768
;     Result clamped to 0-16000, stored at A0+$74 and A0+$7E
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, A1
; Fields accessed:
;   A0+$04: Speed index (0 = use interpolation path)
;   A0+$06: Speed value
;   A0+$0E: Interpolation target value
;   A0+$74: Current position value (read/write)
;   A0+$7A: Lookup table index
;   A0+$7E: Position mirror (written in path 2 only)
; RAM:
;   ($C278).W: Pointer to lookup table
; ============================================================================

obj_state_return:
        tst.w   $4(a0)                  ; Check speed index
        beq.s   .interpolate            ; If zero, use interpolation path

        ; --- Path 1: Speed-based calculation ---
        move.w  $6(a0),d0               ; Load speed
        dc.w    $2278,$C278             ; MOVEA.L ($C278).W,A1 - lookup table pointer
        move.w  $7A(a0),d1              ; Load table index
        add.w   d1,d1                   ; Word offset (index * 2)
        dc.w    $C1F1,$1000             ; MULS.W 0(A1,D1.W),D0 - speed * table value
        muls.w  #$0254,d0               ; Multiply by 596
        lsr.w   #8,d0                   ; >> 8
        lsr.w   #4,d0                   ; >> 4 (total >> 12 = divide by 4096)
        cmpi.w  #$4268,d0               ; Clamp to max 17000
        ble.s   .check_min1
        move.w  #$4268,d0
.check_min1:
        cmpi.w  #$0000,d0               ; Floor at 0
        bge.s   .store1
        move.w  #$0000,d0
.store1:
        move.w  d0,$74(a0)              ; Store result
        bra.s   .return

        ; --- Path 2: Interpolation toward target ---
.interpolate:
        move.w  $E(a0),d0               ; Load target value
        lsl.w   #6,d0                   ; Target * 64
        sub.w   $74(a0),d0              ; Delta = target*64 - current
        cmpi.w  #$0400,d0               ; Clamp delta to +1024
        ble.s   .check_delta_min
        move.w  #$0400,d0
.check_delta_min:
        cmpi.w  #$FD00,d0               ; Clamp delta to -768
        bge.s   .apply_delta
        move.w  #$FD00,d0
.apply_delta:
        add.w   $74(a0),d0              ; Apply delta to current
        cmpi.w  #$3E80,d0               ; Clamp to max 16000
        ble.s   .check_min2
        move.w  #$3E80,d0
.check_min2:
        cmpi.w  #$0000,d0               ; Floor at 0
        bge.s   .store2
        move.w  #$0000,d0
.store2:
        move.w  d0,$7E(a0)              ; Store to position mirror
        move.w  d0,$74(a0)              ; Store to current position
.return:
        rts
