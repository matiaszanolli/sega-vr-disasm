; ============================================================================
; BCD Time Update 010
; ROM Range: $00B2FC-$00B36E (114 bytes)
; ============================================================================
; Category: game
; Purpose: Updates BCD time counter (MM:SS:FF format)
;   Reads speed factor from lookup table, scales by obj speed
;   Subtracts BCD delta from time digits using SBCD instructions
;   Clamps minutes to $59
;
; Entry: A0 = object/entity pointer
; Entry: A1 = BCD time buffer (4 bytes: [0]=min, [1]=sec_hi, [2]=sec_lo, [3]=frames)
; Uses: D0, D1, D2, A0, A1, A3
; RAM:
;   $C89E: speed_factor_index
; Data table (external, at ai_table_lookup_cond_fall_through):
;   Speed factor lookup at $00B2D8 (PC-relative)
; Object fields (A0):
;   +$06: obj_speed (divisor)
;   +$E2: speed_offset (added to factor)
; Confidence: high
; ============================================================================

bcd_time_update_010:
        move.w  ($FFFFC89E).w,D0                ; $00B2FC  D0 = speed_factor_index
        move.w  $00B2D8(PC,D0.W),D0             ; $00B300  D0 = speed_factor[index]
        add.w   $00E2(A0),D0                    ; $00B304  D0 += speed_offset
        bmi.s   .done                           ; $00B308  negative → skip
        muls    #$0320,D0                       ; $00B30A  D0 *= 800
        move.w  $0006(A0),D1                    ; $00B30E  D1 = obj_speed
        beq.s   .done                           ; $00B312  zero → skip (avoid /0)
        divs    D1,D0                           ; $00B314  D0 = (factor * 800) / speed
        cmpi.w  #$0032,D0                       ; $00B316  D0 < 50?
        blt.s   .clamp_ok                       ; $00B31A  yes → keep
        moveq   #$32,D0                         ; $00B31C  clamp to 50
.clamp_ok:
        add.w   d0,d0                   ; $D040
        lea     $00899884,A3                    ; $00B320  A3 → BCD delta table (ROM)
        andi.b  #$EF,ccr                        ; $023C $00EF — clear X flag
        move.w  $00(A3,D0.W),D0                 ; $00B32A  D0 = BCD delta[index]
; --- subtract BCD delta from time buffer ---
        move.b  $0003(A1),D1                    ; $00B32E  D1 = frames digit
        sbcd    d0,d1                           ; $8300 — subtract frames
        move.b  D1,$0003(A1)                    ; $00B334  store frames
        moveq   #$00,D2                         ; $00B338  D2 = 0
        move.b  $0002(A1),D1                    ; $00B33A  D1 = sec_lo digit
        sbcd    d2,d1                           ; $8302 — subtract borrow
        andi.b  #$0F,D1                         ; $00B340  mask to BCD digit
        move.b  D1,$0002(A1)                    ; $00B344  store sec_lo
        move.b  $0001(A1),D1                    ; $00B348  D1 = sec_hi digit
        sbcd    d2,d1                           ; $8302 — subtract borrow
        bcc.s   .no_borrow                      ; $00B34E  no borrow → skip
        subi.b  #$40,D1                         ; $00B350  adjust for BCD underflow
        ori.b   #$10,ccr                        ; $003C $0010 — set X flag
.no_borrow:
        move.b  D1,$0001(A1)                    ; $00B358  store sec_hi
        move.b  (A1),D1                         ; $00B35C  D1 = minutes digit
        sbcd    d2,d1                           ; $8302 — subtract borrow
        cmpi.b  #$59,D1                         ; $00B360  minutes > $59?
        ble.s   .store_min                      ; $00B364  no → store
        move.b  #$59,D1                         ; $00B366  clamp to 59 BCD
.store_min:
        move.b  D1,(A1)                         ; $00B36A  store minutes
.done:
        rts                                     ; $00B36C
