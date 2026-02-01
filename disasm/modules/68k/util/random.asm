; ============================================================================
; Random Number Generation ($00496E)
; ============================================================================
;
; PURPOSE
; -------
; Pseudo-random number generator using Linear Congruential Generator (LCG).
; The algorithm multiplies the seed by 41 using shifts and adds, then combines
; the high and low words for the output.
;
; ALGORITHM
; ---------
; new_seed = old_seed * 41
; output = (new_seed.low + new_seed.high) & $FFFF
;
; Multiplication by 41 is computed as:
;   ((seed << 2) + seed) << 3) + seed = (5 << 3 + 1) * seed = 41 * seed
;
; MEMORY
; ------
; | Address | Name        | Purpose                    |
; |---------|-------------|----------------------------|
; | $EF00   | RANDOM_SEED | 32-bit seed storage        |
;
; NOTES
; -----
; - Seed of 0 is replaced with default $2A6D365A
; - D0 returns random value, D1 preserved
; - Called 6 times per frame
;
; Dependencies: None (standalone utility)
; Related: game_logic.asm
; ============================================================================
; Format: Proper mnemonics with original bytes in comments for verification
; ============================================================================

; Work RAM for random seed (sign-extended for .w addressing)
RANDOM_SEED     equ     $FFFFEF00   ; Random seed at $EF00.w
DEFAULT_SEED    equ     $2A6D365A   ; Default seed if zero (prime-like)

        org     $00496E

; ============================================================================
; random_number_gen ($00496E) - Linear Congruential Generator PRNG
; Called by: 6 locations per frame
; Parameters: None
; Returns: D0 = pseudo-random 16-bit value (0-65535)
; Preserves: D1
;
; Uses LCG algorithm: seed = seed * 41, output = low + high words
; ============================================================================

random_number_gen:
        move.l  d1,-(a7)                        ; $00496E: $2F01       - Save D1
        move.l  RANDOM_SEED.w,d1                ; $004970: $2238 $EF00 - Load seed
        bne.s   .use_seed                       ; $004974: $6606       - Use if non-zero
        move.l  #DEFAULT_SEED,d1                ; $004976: $223C $2A6D $365A - Default
.use_seed:
; LCG algorithm: new = seed * 41 (via shifts and adds)
; 41 = ((1 << 2) + 1) << 3) + 1 = (5 << 3) + 1 = 40 + 1
        move.l  d1,d0                           ; $00497C: $2001       - Copy seed
        asl.l   #2,d1                           ; $00497E: $E581       - seed << 2
        add.l   d0,d1                           ; $004980: $D280       - + original = 5x
        asl.l   #3,d1                           ; $004982: $E781       - << 3 = 40x
        add.l   d0,d1                           ; $004984: $D280       - + original = 41x
; Combine high and low words for pseudo-random output
        move.w  d1,d0                           ; $004986: $3001       - Low word to D0
        swap    d1                              ; $004988: $4841       - High word to low
        add.w   d1,d0                           ; $00498A: $D041       - Add high to low
        move.w  d0,d1                           ; $00498C: $3200       - Copy result back
        swap    d1                              ; $00498E: $4841       - Restore D1 structure
        move.l  d1,RANDOM_SEED.w                ; $004990: $21C1 $EF00 - Store new seed
        move.l  (a7)+,d1                        ; $004994: $221F       - Restore D1
        rts                                     ; $004996: $4E75

; ============================================================================
; SUMMARY
; ============================================================================
;
; Function         | Address | Size | Purpose
; -----------------+---------+------+------------------
; random_number_gen| $00496E | 42B  | LCG pseudo-random
;
; PRNG quality: Adequate for gameplay (AI decisions, effects timing)
; Period: ~2^32 (full 32-bit cycle with proper seed)
; Distribution: Reasonably uniform for 16-bit output
;
; ============================================================================
