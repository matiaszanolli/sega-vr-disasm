; ============================================================================
; Effect Timer Management
; ROM Range: $00A350-$00A3B8 (106 bytes)
; ============================================================================
; Manages animation effect timers using sine table lookups.
; When timer is active: reads sine value, decrements timer, advances index.
; When timer expires: checks flag bits 13/12 in A0+$2 to reinitialize.
;
; Entry: A0 = object/entity pointer
; Uses: D0, A1
; Fields accessed:
;   A0+$02: Flag word (bits 13/12 = effect triggers)
;   A0+$0E: Effect state
;   A0+$14: Effect duration
;   A0+$6A: Timer countdown
;   A0+$6C: Sine table index
;   A0+$6E: Current sine value (animation output)
; ============================================================================

effect_timer_mgmt:
        tst.w   $6A(a0)                 ; Check timer
        ble.s   .timer_expired          ; If <= 0, handle expiry

; --- Active timer: look up sine value ---
        move.w  $6C(a0),d0              ; Load sine index
        add.w   d0,d0                   ; Word offset (index * 2)
        lea     sine_table(pc),a1       ; Point to sine table ($00A2D8)
        dc.w    $3171,$0000,$006E       ; MOVE.W 0(A1,D0.W),$6E(A0) - store sine value
        subq.w  #1,$6A(a0)              ; Decrement timer
        addq.w  #1,$6C(a0)              ; Advance sine index
        bra.s   .return

; --- Timer expired: check flag bits ---
.timer_expired:
        move.w  $2(a0),d0               ; Load flags
        andi.w  #$2000,d0               ; Test bit 13
        beq.s   .check_bit12            ; Not set, check bit 12

; --- Bit 13 set: initialize effect type A ---
        andi.w  #$DFFF,$2(a0)           ; Clear bit 13
        moveq   #$1E,d0                 ; D0 = 30
        move.w  d0,$6C(a0)              ; Set sine index to 30
        move.w  d0,$6A(a0)              ; Set timer to 30 frames
        move.w  d0,$14(a0)              ; Set effect duration
        clr.w   $E(a0)                  ; Clear effect state
        bra.s   .return

; --- Check bit 12: initialize effect type B ---
.check_bit12:
        move.w  $2(a0),d0               ; Load flags
        andi.w  #$1000,d0               ; Test bit 12
        beq.s   .return                 ; Not set, nothing to do

        andi.w  #$EFFF,$2(a0)           ; Clear bit 12
        moveq   #0,d0                   ; D0 = 0
        move.w  d0,$E(a0)               ; Clear effect state
        move.w  d0,$6C(a0)              ; Clear sine index
        moveq   #$1E,d0                 ; D0 = 30
        move.w  d0,$6A(a0)              ; Set timer to 30 frames
        move.w  d0,$14(a0)              ; Set effect duration

.return:
        rts
