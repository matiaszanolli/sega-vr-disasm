; ============================================================================
; Cascaded Frame Counter (Two Entry Points)
; ROM Range: $00B094-$00B0DE (74 bytes)
; ============================================================================
; Category: game
; Purpose: Two entry points (A0 selects counter block, D0 = flags byte):
;   Entry 1 ($B094): A0 = $C813, D0 = $B4EE
;   Entry 2 ($B09E): A0 = $C806, D0 = $C30E
;   If D0 bit 4 set AND (A0) < $3C:
;     Increments A0+2 (sub-tick). On rollover (→0): resets to $C4,
;     checks D0 bits 0,1,5 and $C30D — if all clear, decrements $C050.
;     Increments A0+1 (tick). On rollover: resets to $C4,
;     increments A0+0 (main counter).
;   Implements cascaded 3-byte timer with conditional $C050 decrement.
;
; Uses: D0, A0
; RAM:
;   $B4EE: input flags A (byte)
;   $C050: work counter (word, decremented)
;   $C30D: race sub-flag (byte)
;   $C30E: race_flags (byte)
; Counter blocks (3 bytes each):
;   $C806: counter B (+0=main, +1=tick, +2=sub-tick)
;   $C813: counter A (+0=main, +1=tick, +2=sub-tick)
; ============================================================================

fn_a200_003:
; --- entry 1: counter A ---
        lea     ($FFFFC813).w,A0                ; $00B094  A0 → counter A
        move.b  ($FFFFB4EE).w,D0                ; $00B098  D0 = input flags A
        bra.s   .compute                        ; $00B09C  → compute
; --- entry 2: counter B ---
        lea     ($FFFFC806).w,A0                ; $00B09E  A0 → counter B
        move.b  ($FFFFC30E).w,D0                ; $00B0A2  D0 = race_flags
.compute:
        btst    #4,D0                           ; $00B0A6  bit 4 set?
        beq.s   .done                           ; $00B0AA  no → done
        cmpi.b  #$3C,(A0)                       ; $00B0AC  main counter >= 60?
        bge.s   .done                           ; $00B0B0  yes → done (saturated)
        addq.b  #1,$0002(A0)                    ; $00B0B2  sub-tick++
        bne.s   .done                           ; $00B0B6  no rollover → done
        move.b  #$C4,$0002(A0)                  ; $00B0B8  reset sub-tick to $C4
        andi.b  #$23,D0                         ; $00B0BE  check bits 0,1,5
        bne.s   .inc_tick                       ; $00B0C2  any set → skip decrement
        tst.b   ($FFFFC30D).w                   ; $00B0C4  race sub-flag active?
        bne.s   .inc_tick                       ; $00B0C8  yes → skip decrement
        subq.w  #1,($FFFFC050).w                ; $00B0CA  decrement work counter
.inc_tick:
        addq.b  #1,$0001(A0)                    ; $00B0CE  tick++
        bne.s   .done                           ; $00B0D2  no rollover → done
        move.b  #$C4,$0001(A0)                  ; $00B0D4  reset tick to $C4
        addq.b  #1,(A0)                         ; $00B0DA  main counter++
.done:
        rts                                     ; $00B0DC

