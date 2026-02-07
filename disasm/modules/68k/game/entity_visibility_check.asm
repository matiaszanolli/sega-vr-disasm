; ============================================================================
; Entity Visibility Check
; ROM Range: $002C9A-$002CDA (66 bytes)
; ============================================================================
; Determines entity visibility based on race mode, entity flags, and
; global state. Writes visibility (0 or 1) to four display slots.
;
; Entry: A0 = entity, A2 = display slot buffer
; Uses: D0
; ============================================================================

entity_visibility_check:
        moveq   #0,d0                 ; Default: invisible
        tst.w   $00C0(a0)             ; Check entity active flag
        beq.s   .write_slots          ; If inactive, write 0
        moveq   #1,d0                 ; Set visible
        dc.w    $4A38,$90E4           ; TST.B ($90E4).W - P1 race mode
        bne.s   .check_entity_flag    ; If P1 racing, check entity
        dc.w    $4A38,$B0FC           ; TST.B ($B0FC).W - P2 race mode
        beq.s   .alt_check            ; Neither racing, alternate path
.check_entity_flag:
        btst    #3,$00E5(a0)          ; Check entity flag bit 3
        beq.s   .write_slots          ; If not set, keep visible
.set_invisible:
        moveq   #0,d0                 ; Set invisible
        bra.s   .write_slots
.alt_check:
        dc.w    $0838,$0003,$90E5     ; BTST #3,($90E5).W - global flag
        beq.s   .write_slots          ; If not set, keep visible
        tst.b   $00E4(a0)             ; Check entity subtype
        bne.s   .set_invisible        ; If nonzero, hide
.write_slots:
        move.w  d0,$0118(a2)          ; Write to 4 display slots
        move.w  d0,$012C(a2)
        move.w  d0,$0140(a2)
        move.w  d0,$0154(a2)
        rts
