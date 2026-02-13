; ============================================================================
; Score/Stat Lookup and Accumulate — Dual Entry Point
; ROM Range: $00CEC2-$00CEEE (44 bytes)
; Source: code_c200
; ============================================================================
;
; PURPOSE
; -------
; Looks up a score or stat modifier from a PC-relative data table and adds
; it to an accumulator at $C0E8. Has two entry points for different object
; table bases (primary at $FFFF9000, alternate at $FFFF9F00).
;
; The lookup index is computed from:
;   - A byte from $FEAD (primary) or $FEAE (alternate), sign-extended × 2
;   - Track index: ($C8CC × 2) + $C8CA = track × 10
;   Combined: index = 2 × sign_ext(byte) + track × 10
;
; The data table is located at the start of entity_heading_and_turn_rate_calculator ($CEEE), accessed
; via PC-relative indexed read. The table words are interleaved with the
; code of entity_heading_and_turn_rate_calculator (a common compiled-code optimization).
;
; ENTRY POINTS
; ------------
;   score_stat_lookup_accum_dual   Primary:   A0=$FFFF9000, input from $FEAD
;   c200_func_020b  Alternate: A0=$FFFF9F00, input from $FEAE
;
; MEMORY VARIABLES
; ----------------
;   $FFFFFEAD  Input byte for primary entry (sign-extended)
;   $FFFFFEAE  Input byte for alternate entry (sign-extended)
;   $FFFFC8CA  Track × 2 (word, added to index)
;   $FFFFC8CC  Track × 4 (word, doubled to track × 8)
;   $FFFFC0E8  Accumulator (word, lookup value added to it)
;
; Entry: No register inputs (entry point selects configuration)
; Exit:  Accumulator updated with looked-up modifier
; Uses:  D0, D1, A0
; ============================================================================

; --- Primary entry: object table at $FFFF9000 ---
score_stat_lookup_accum_dual:
        lea     ($FFFF9000).w,a0                ; $00CEC2: $41F8 $9000 — primary base
        move.b  ($FFFFFEAD).w,d0                ; $00CEC6: $1038 $FEAD — load input byte
        bra.s   .shared                         ; $00CECA: $6008 — skip alternate entry

; --- Alternate entry: object table at $FFFF9F00 ---
.alt_entry:
        lea     ($FFFF9F00).w,a0                ; $00CECC: $41F8 $9F00 — alternate base
        move.b  ($FFFFFEAE).w,d0                ; $00CED0: $1038 $FEAE — load input byte

; --- Compute lookup index ---
.shared:
        move.w  ($FFFFC8CC).w,d1                ; $00CED4: $3238 $C8CC — track × 4
        add.w   d1,d1                           ; $00CED8: $D241 — track × 8
        add.w   ($FFFFC8CA).w,d1                ; $00CEDA: $D278 $C8CA — + track × 2 = track × 10
        ext.w   d0                              ; $00CEDE: $4880 — sign-extend byte to word
        add.w   d0,d0                           ; $00CEE0: $D040 — byte × 2
        add.w   d1,d0                           ; $00CEE2: $D041 — index = byte×2 + track×10

; --- Look up modifier and accumulate ---
        move.w  entity_heading_and_turn_rate_calculator(pc,d0.w),d0         ; $00CEE4: $303B $0008 — read from data table at $CEEE
        add.w   d0,($FFFFC0E8).w                ; $00CEE8: $D178 $C0E8 — add to accumulator
        rts                                     ; $00CEEC: $4E75
