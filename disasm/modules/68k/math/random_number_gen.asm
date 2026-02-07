; ============================================================================
; Pseudo-Random Number Generator
; ROM Range: $00496E-$004998 (42 bytes)
; ============================================================================
; Linear congruential PRNG. State stored at ($EF00).W.
; Seed: $2A6D365A. Returns random value in D0.W.
;
; Entry: none
; Exit: D0.W = random value
; Uses: D0 (D1 preserved)
; ============================================================================

random_number_gen:
        move.l  d1,-(a7)              ; Save D1
        dc.w    $2238,$EF00           ; MOVE.L ($EF00).W,D1 - load state
        bne.s   .have_state           ; If non-zero, use it
        move.l  #$2A6D365A,d1         ; Seed value
.have_state:
        move.l  d1,d0                 ; D0 = state copy
        asl.l   #2,d1                 ; state <<= 2
        add.l   d0,d1                 ; state += original
        asl.l   #3,d1                 ; state <<= 3
        add.l   d0,d1                 ; state += original
        move.w  d1,d0                 ; D0.w = low word
        swap    d1                    ; D1 high <-> low
        add.w   d1,d0                 ; D0 += high word
        move.w  d0,d1                 ; D1.w = result
        swap    d1                    ; Restore word order
        dc.w    $21C1,$EF00           ; MOVE.L D1,($EF00).W - store state
        move.l  (a7)+,d1              ; Restore D1
        rts
