; ============================================================================
; Entity Directional Push
; ROM Range: $00AED8-$00AF16 (62 bytes)
; ============================================================================
; Applies a fixed directional offset ($18 = 24 units) to entity X/Y position
; based on 4 direction bits in A0+$88:
;   Bit 0: X += D1, Y -= D1  (push right-up)
;   Bit 1: X -= D1, Y -= D1  (push left-up)
;   Bit 2: X += D1, Y += D1  (push right-down)
;   Bit 3: X -= D1, Y += D1  (push left-down)
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1
; Fields accessed:
;   A0+$30: X position (modified)
;   A0+$34: Y position (modified)
;   A0+$88: Direction flags (bits 0-3)
; ============================================================================

entity_directional_push:
        move.w  $88(a0),d0              ; Load direction flags
        moveq   #$18,d1                 ; Push amount = 24
        btst    #0,d0                   ; Check bit 0 (right-up)
        beq.s   .check_bit1             ; Skip if not set
        add.w   d1,$30(a0)              ; X += 24
        sub.w   d1,$34(a0)              ; Y -= 24
.check_bit1:
        btst    #1,d0                   ; Check bit 1 (left-up)
        beq.s   .check_bit2             ; Skip if not set
        sub.w   d1,$30(a0)              ; X -= 24
        sub.w   d1,$34(a0)              ; Y -= 24
.check_bit2:
        btst    #2,d0                   ; Check bit 2 (right-down)
        beq.s   .check_bit3             ; Skip if not set
        add.w   d1,$30(a0)              ; X += 24
        add.w   d1,$34(a0)              ; Y += 24
.check_bit3:
        btst    #3,d0                   ; Check bit 3 (left-down)
        beq.s   .return                 ; Skip if not set
        sub.w   d1,$30(a0)              ; X -= 24
        add.w   d1,$34(a0)              ; Y += 24
.return:
        rts
