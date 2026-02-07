; ============================================================================
; Position Velocity Update
; ROM Range: $007084-$0070A8 (38 bytes)
; ============================================================================
; Applies velocity components to object position fields.
; Updates both raw positions ($30, $34) and computed display position ($40).
;
; Entry: A0 = object pointer
; Uses: D0
; Fields accessed:
;   A0+$30: Position X (updated)
;   A0+$34: Position Y (updated)
;   A0+$3C: Intermediate position
;   A0+$40: Display position (written)
;   A0+$4E: Velocity Z component
;   A0+$50: Velocity Y component
;   A0+$52: Velocity X component
;   A0+$96: Position offset
; ============================================================================

position_velocity_update:
        move.w  $52(a0),d0              ; Load velocity X
        add.w   d0,$3C(a0)             ; Add to intermediate position
        move.w  $3C(a0),d0             ; Reload intermediate
        add.w   $96(a0),d0             ; Add position offset
        move.w  d0,$40(a0)             ; Store display position
        move.w  $4E(a0),d0             ; Load velocity Z
        add.w   d0,$30(a0)             ; Add to position X
        move.w  $50(a0),d0             ; Load velocity Y
        add.w   d0,$34(a0)             ; Add to position Y
        rts
