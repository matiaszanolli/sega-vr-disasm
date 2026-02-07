; ============================================================================
; Object Distance Calculation
; ROM Range: $0075FE-$007622 (38 bytes)
; ============================================================================
; Computes distance value and stores at A0+$CC.
; Two paths based on ($C04C).W flag:
;   If zero: result = A0+$3C + A0+$96
;   If non-zero: result = A0+$3C + A0+$96 - A0+$46
;
; Entry: A0 = object pointer
; Uses: D0
; Fields accessed:
;   A0+$3C: Base position
;   A0+$46: Subtraction offset (used in non-zero path)
;   A0+$96: Position offset
;   A0+$CC: Distance result (written)
; RAM:
;   ($C04C).W: Mode flag (zero = simple, non-zero = with offset)
; ============================================================================

obj_distance_calc:
        dc.w    $4A78,$C04C             ; TST.W ($C04C).W - check mode flag
        bne.s   .with_offset            ; If non-zero, subtract offset
        move.w  $3C(a0),d0             ; Load base position
        add.w   $96(a0),d0             ; Add position offset
        move.w  d0,$CC(a0)             ; Store distance
        rts
.with_offset:
        move.w  $3C(a0),d0             ; Load base position
        add.w   $96(a0),d0             ; Add position offset
        sub.w   $46(a0),d0             ; Subtract view offset
        move.w  d0,$CC(a0)             ; Store distance
        rts
