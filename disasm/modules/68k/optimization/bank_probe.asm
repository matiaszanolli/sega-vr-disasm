; ============================================================================
; Bank Register Probe — Identifies 68K access path to expansion ROM
; Location: Optimization area (code_1c200 section)
; ============================================================================
;
; PURPOSE
; -------
; The expansion ROM ($300000-$3FFFFF) contains 1MB of mostly-free space.
; This probe determines HOW the 68K can access it. Three paths tested:
;
;   D = DIRECT:  68K reads $300000 as a normal ROM address
;   A = BANK A:  $A130F1 (Genesis bank/SRAM register, byte write)
;   B = BANK B:  $A15104 (32X Bank Set Register, word write, bits 0-1)
;
; For bank registers, bank 3 maps ROM $300000-$3FFFFF → $900000-$9FFFFF.
;
; EXPECTED VALUES
; ---------------
; ROM $000000: $01000000 (Initial SP from header — known good baseline)
; ROM $300000: $FFFFFFFF (expansion padding — 40 bytes of $FF)
;
; RESULTS ($FFFFF080, 32 bytes)
; -----------------------------
; +$00: $50524F42 ("PROB") — probe ran
; +$04: Direct read from $300000
; +$08: Bank A, bank 0 → read $900000
; +$0C: Bank A, bank 3 → read $900000
; +$10: Bank B, bank 0 → read $900000
; +$14: Bank B, bank 3 → read $900000
; +$18: Winner byte: 'D'=$44, 'A'=$41, 'B'=$42, '?'=$3F
; +$19: Padding
; +$1A: $DEAD — probe completed without crash
;
; CALLING CONVENTION
; ------------------
; Called from: adapter_init (boot, interrupts disabled)
; Parameters: None
; Returns: Nothing
; Clobbers: D0-D1, A0
; ============================================================================

PROBE_BASE      equ     $00FFF080       ; Above game RAM ($FFC800-$FFEFFF), below FPS state ($FFFFF000)
PROBE_SIG_HI    equ     $5052           ; "PR"
PROBE_SIG_LO    equ     $4F42           ; "OB"
PROBE_DONE_SIG  equ     $DEAD

; Candidate registers
BANK_REG_A      equ     $A130F1         ; Genesis standard (byte write)
BANK_REG_B      equ     $A15104         ; 32X Bank Set (word write, bits 0-1)

; ROM addresses
BANK_WINDOW     equ     $900000         ; Bank-switched ROM window
DIRECT_EXP      equ     $300000         ; Direct expansion ROM address

bank_probe:
        ; --- Setup ---
        lea     PROBE_BASE,a0           ; A0 → result area ($FFFFF080)

        ; Write signature
        move.w  #PROBE_SIG_HI,(a0)
        move.w  #PROBE_SIG_LO,$0002(a0)

        ; --- Test 1: Direct read from $300000 ---
        ; If 32X passes through full 4MB at $000000-$3FFFFF, this works
        move.l  DIRECT_EXP,d0
        move.l  d0,$0004(a0)            ; +$04

        ; --- Test 2: Bank register A ($A130F1) ---
        move.b  #$00,BANK_REG_A         ; Bank 0
        nop                             ; Settle
        move.l  BANK_WINDOW,d0
        move.l  d0,$0008(a0)            ; +$08: bank A, val 0

        move.b  #$03,BANK_REG_A         ; Bank 3
        nop
        move.l  BANK_WINDOW,d0
        move.l  d0,$000C(a0)            ; +$0C: bank A, val 3

        move.b  #$00,BANK_REG_A         ; Restore

        ; --- Test 3: Bank register B ($A15104) ---
        move.w  #$0000,BANK_REG_B       ; Bank 0
        nop
        move.l  BANK_WINDOW,d0
        move.l  d0,$0010(a0)            ; +$10: bank B, val 0

        move.w  #$0003,BANK_REG_B       ; Bank 3
        nop
        move.l  BANK_WINDOW,d0
        move.l  d0,$0014(a0)            ; +$14: bank B, val 3

        move.w  #$0000,BANK_REG_B       ; Restore

        ; --- Determine winner ---
        ; Priority: A > B > D (bank registers preferred — explicit control)

        ; Check bank A: bank 0 vs bank 3 differ?
        move.l  $0008(a0),d0
        cmp.l   $000C(a0),d0
        bne.s   .winner_a

        ; Check bank B: bank 0 vs bank 3 differ?
        move.l  $0010(a0),d0
        cmp.l   $0014(a0),d0
        bne.s   .winner_b

        ; Check direct: got expansion padding ($FFFFFFFF)?
        move.l  $0004(a0),d0
        cmpi.l  #$FFFFFFFF,d0
        beq.s   .winner_direct

        ; Nothing worked
        move.b  #'?',$0018(a0)
        bra.s   .done

.winner_a:
        move.b  #'A',$0018(a0)
        bra.s   .done

.winner_b:
        move.b  #'B',$0018(a0)
        bra.s   .done

.winner_direct:
        move.b  #'D',$0018(a0)

.done:
        move.b  #$00,$0019(a0)          ; Padding byte
        move.w  #PROBE_DONE_SIG,$001A(a0) ; $DEAD = completed
        rts

; ============================================================================
; VERIFICATION (after boot in PicoDrive or profiler)
; ============================================================================
;
; Dump Work RAM at $FFFFF080:
;   $FFFFF080: 50524F42  = "PROB" (signature)
;   $FFFFF084: xxxxxxxx  = direct $300000 read
;   $FFFFF088: xxxxxxxx  = bank A, bank 0
;   $FFFFF08C: xxxxxxxx  = bank A, bank 3
;   $FFFFF090: xxxxxxxx  = bank B, bank 0
;   $FFFFF094: xxxxxxxx  = bank B, bank 3
;   $FFFFF098: xx        = winner ('D', 'A', 'B', or '?')
;   $FFFFF09A: DEAD      = completion marker
;
; Expected outcomes:
;   Winner 'D': $300000 directly readable → simplest path, no banking needed
;   Winner 'A': $A130F1 controls $900000 window → use bank switch trampoline
;   Winner 'B': $A15104 controls $900000 window → use bank switch trampoline
;   Winner '?': None worked → expansion ROM not 68K-accessible, abort plan
;
; Cross-validation:
;   bank X, bank 0 value should ≈ $01000000 (ROM $000000 = Initial SP)
;   bank X, bank 3 value should = $FFFFFFFF (ROM $300000 = expansion padding)
;   direct read should match one of the above
;
; ============================================================================
