; ============================================================================
; AI Timer Increment (Dual Counter with Carry)
; ROM Range: $00B0DE-$00B11A (60 bytes)
; ============================================================================
; Category: game
; Purpose: Two entry points that share increment logic at $00B0F2:
;   Entry 1 ($00B0DE): A0→$A9E7, D0 from $B4EE → BSR to shared, then
;     falls into entry 2.
;   Entry 2 ($00B0EA): A0→$A9E3, D0 from $C30E → falls into shared.
;   Shared logic: if D0 bit 4 set and (A0) < $3C:
;     increments 3-byte counter at (A0)+2, +1, +0 with carry chain.
;     Each byte overflows at $00 → resets to $C4 and carries to next.
;
; Uses: D0, A0
; RAM:
;   $A9E3: timer block B (3 bytes)
;   $A9E7: timer block A (3 bytes)
;   $B4EE: input flags A (byte)
;   $C30E: input flags B (byte, bit 4)
; ============================================================================

ai_timer_inc:
; --- entry 1: timer A ---
        lea     ($FFFFA9E7).w,A0               ; $00B0DE  A0 → timer block A
        move.b  ($FFFFB4EE).w,D0               ; $00B0E2  D0 = input flags A
        dc.w    $4EBA,$000A                     ; $00B0E6  bsr.w .shared ($00B0F2)
; --- entry 2: timer B (also reached via fall-through from entry 1) ---
        lea     ($FFFFA9E3).w,A0               ; $00B0EA  A0 → timer block B
        move.b  ($FFFFC30E).w,D0               ; $00B0EE  D0 = input flags B
; --- shared: increment with carry ---
.shared:
        btst    #4,D0                           ; $00B0F2  bit 4 set?
        beq.s   .done                           ; $00B0F6  no → done
        cmpi.b  #$3C,(A0)                       ; $00B0F8  counter >= $3C?
        bge.s   .done                           ; $00B0FC  yes → done (maxed)
        addq.b  #1,$0002(A0)                    ; $00B0FE  byte[2]++
        bne.s   .done                           ; $00B102  no overflow → done
        move.b  #$C4,$0002(A0)                  ; $00B104  byte[2] = $C4 (carry)
        addq.b  #1,$0001(A0)                    ; $00B10A  byte[1]++
        bne.s   .done                           ; $00B10E  no overflow → done
        move.b  #$C4,$0001(A0)                  ; $00B110  byte[1] = $C4 (carry)
        addq.b  #1,(A0)                         ; $00B116  byte[0]++
.done:
        rts                                     ; $00B118
