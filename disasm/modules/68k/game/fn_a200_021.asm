; ============================================================================
; Lap Display Update + VDP Tile Write
; ROM Range: $00B5AE-$00B604 (86 bytes)
; ============================================================================
; Category: game
; Purpose: Two entry points:
;   Entry 1 ($00B5AE): Sets A1 → $FF689A, reads $902C (lap count),
;     adds 1, doubles (×2), indexes table at $00899884 for display value,
;     tail-jumps to $00B54C (write routine).
;   Entry 2 ($00B5CA): Reads $902C, clamps to max 4, shifts left 4 (×16).
;     If $C305 nonzero: subtracts $10, computes VDP tile address at
;     $FF68D0 + offset. Writes $0201 (or $0200 if != current tile at $C960).
;     Clears $C305.
;
; Uses: D0, A0, A1
; RAM:
;   $902C: lap count / race position (word)
;   $C305: sub-counter (byte, cleared)
;   $C960: current tile pointer (long, compared with A1)
; ============================================================================

fn_a200_021:
; --- entry 1: lap display value lookup ---
        lea     $00FF689A,A1                    ; $00B5AE  A1 → VDP tile target
        move.w  ($FFFF902C).w,D0               ; $00B5B4  D0 = lap count
        addq.w  #1,D0                           ; $00B5B8  D0 += 1
        dc.w    $D040                           ; $00B5BA  add.w d0,d0 — D0 × 2
        lea     $00899884,A0                    ; $00B5BC  A0 → display value table
        move.w  $00(A0,D0.W),D0                ; $00B5C2  D0 = table[lap+1]
        dc.w    $4EFA,$FF84                     ; $00B5C6  jmp $00B54C(pc) — write routine (tail)
; --- entry 2: VDP tile update ---
        move.w  ($FFFF902C).w,D0               ; $00B5CA  D0 = lap count
        cmpi.w  #$0004,D0                       ; $00B5CE  lap > 4?
        ble.s   .shift                          ; $00B5D2  no → shift
        move.w  #$0004,D0                       ; $00B5D4  clamp to 4
.shift:
        lsl.w   #4,D0                           ; $00B5D8  D0 × 16
        tst.b   ($FFFFC305).w                  ; $00B5DA  sub-counter active?
        dc.w    $6724                           ; $00B5DE  beq.s $00B604 → exit (past fn)
        subi.w  #$0010,D0                       ; $00B5E0  D0 -= $10
        lea     $00FF68D0,A1                    ; $00B5E4  A1 → VDP tile base
        lea     $00(A1,D0.W),A1                ; $00B5EA  A1 += offset
        move.w  #$0201,(A1)                    ; $00B5EE  write tile $0201
        cmpa.l  ($FFFFC960).w,A1               ; $00B5F2  same as current?
        beq.s   .clear                          ; $00B5F6  yes → skip alternate
        move.w  #$0200,(A1)                    ; $00B5F8  write tile $0200
.clear:
        move.b  #$00,($FFFFC305).w             ; $00B5FC  clear sub-counter
        rts                                     ; $00B602
