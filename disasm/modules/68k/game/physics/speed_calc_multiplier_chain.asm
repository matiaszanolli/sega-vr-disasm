; ============================================================================
; Speed Calculation + Multiplier Chain
; ROM Range: $009458-$0094F4 (156 bytes)
; ============================================================================
; Category: game
; Purpose: Computes effective speed ($0016) from velocity index ($0004) via
;   ROM lookup table, applies MULS scaling by track_speed_factor, then
;   applies ×6 multiplier (high-speed) or ×1.5 (braking) boost depending
;   on state. Adds wind_resistance correction and boost_timer bonus.
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, A0, A1
; RAM:
;   $C27C: speed_table_ptr (longword → ROM speed lookup)
;   $C0E6: track_speed_factor (word, signed)
;   $C826: has_boost_flag (byte)
;   $C31B: wind_active (byte)
; Object fields:
;   +$04: velocity_index
;   +$06: base_speed
;   +$0A: min_speed_threshold
;   +$14: boost_timer (countdown)
;   +$16: calc_speed (output)
;   +$8A: boost_modifier
;   +$A8: speed_state
; Calls:
;   $009B32: wind_resistance_calc
; ============================================================================

speed_calc_multiplier_chain:
        movem.l D0/A1,-(A7)                    ; $009458  save regs
        movea.l ($FFFFC27C).w,A1                    ; $00945C  A1 = speed_table_ptr
        move.w  $0004(A0),D0                    ; $009460  D0 = velocity_index
        add.w   D0,D0                           ; $009464  word index
        move.w  $00(A1,D0.W),D0                 ; $009466  D0 = base_speed_lookup
        muls    ($FFFFC0E6).w,D0                    ; $00946A  scale by track_speed_factor
        asr.l   #8,D0                           ; $00946E  fixed-point >> 8
        move.w  D0,$0016(A0)                    ; $009470  calc_speed = scaled speed
; --- boost modifier ---
        tst.b   ($FFFFC826).w                       ; $009474  has_boost_flag?
        beq.s   .check_high_speed               ; $009478  no → skip
        moveq   #$10,D0                         ; $00947A
        add.w   $008A(A0),D0                    ; $00947C  D0 = 16 + boost_modifier
        muls    $0016(A0),D0                    ; $009480  D0 *= calc_speed
        asr.l   #4,D0                           ; $009484  >> 4
        move.w  D0,$0016(A0)                    ; $009486  update calc_speed
; --- high-speed ×6 multiplier ---
.check_high_speed:
        move.w  $0016(A0),D0                    ; $00948A
        cmpi.w  #$0004,$00A8(A0)                ; $00948E  speed_state > 4?
        ble.s   .check_braking                  ; $009494  no → check braking
        move.w  D0,D1                           ; $009496  D1 = speed
        add.w   D0,D0                           ; $009498  D0 = 2×speed
        add.w   D0,D0                           ; $00949A  D0 = 4×speed
        add.w   D1,D0                           ; $00949C  D0 = 5×speed
        add.w   D0,D0                           ; $00949E  D0 = 10s
        add.w   D1,D0                           ; $0094A0  D0 = 11s
        asr.w   #4,D0                           ; $0094A2  D0 = 11s/16 ≈ 0.69×speed
        bra.s   .store_speed                    ; $0094A4
; --- braking ×1.5 multiplier ---
.check_braking:
        tst.w   $00A8(A0)                       ; $0094A6  speed_state != 0?
        beq.s   .store_speed                    ; $0094AA  zero → skip
        move.w  $0006(A0),D1                    ; $0094AC  base_speed
        cmp.w   $000A(A0),D1                    ; $0094B0  above min_speed_threshold?
        ble.s   .store_speed                    ; $0094B4  no → skip
        move.w  D0,D1                           ; $0094B6  D1 = calc_speed
        asr.w   #1,D1                           ; $0094B8  D1 = speed/2
        add.w   D1,D0                           ; $0094BA  D0 = speed + speed/2 = 1.5×speed
; --- store + wind + boost ---
.store_speed:
        move.w  D0,$0016(A0)                    ; $0094BC
        jsr     speed_modifier(pc)      ; $4EBA $0670
        add.w   D0,$0016(A0)                    ; $0094C4  add wind correction
; --- wind active: ×1.5 extra ---
        tst.b   ($FFFFC31B).w                       ; $0094C8  wind_active?
        beq.s   .check_boost                    ; $0094CC  no → skip
        move.w  $0016(A0),D0                    ; $0094CE
        asr.w   #1,D0                           ; $0094D2  D0 = speed/2
        move.w  D0,D1                           ; $0094D4
        asr.w   #1,D1                           ; $0094D6  D1 = speed/4
        add.w   D1,D0                           ; $0094D8  D0 = speed/2 + speed/4 = 3/4
        add.w   D0,$0016(A0)                    ; $0094DA  calc_speed += 3/4 speed
; --- boost timer bonus ---
.check_boost:
        tst.w   $0014(A0)                       ; $0094DE  boost_timer > 0?
        ble.s   .exit                           ; $0094E2  no → exit
        subq.w  #1,$0014(A0)                    ; $0094E4  decrement timer
        addi.w  #$0738,$0016(A0)                ; $0094E8  calc_speed += $738 boost
.exit:
        movem.l (A7)+,D0/A1                     ; $0094EE  restore regs
        rts                                     ; $0094F2
