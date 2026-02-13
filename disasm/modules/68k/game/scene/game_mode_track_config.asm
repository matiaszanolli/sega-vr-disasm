; ============================================================================
; Game Mode and Track Configuration
; ROM Range: $00D19C-$00D1D4 (56 bytes)
; Source: code_c200
; ============================================================================
;
; PURPOSE
; -------
; Configures the game mode and track selection variables used by the entire
; game engine. Pre-computes scaled index values (×1, ×2, ×4) for each
; parameter to enable efficient ROM table lookups throughout the codebase.
;
; The multiplied values serve as pre-computed offsets:
;   ×1: byte/word index
;   ×2: word-array index
;   ×4: long/pointer-array index
;
; Also sets a multiplayer flag ($C826) to 1 if the game mode is 2 or 3
; (2-player modes), or 0 for single-player modes (0 and 1).
;
; INDEX VARIABLES (used by fn_c200_044, 045, 046, 048, 050, etc.)
; ----------------------------------------------------------------
;   $FFFFC89C  Game mode (word: 0-3)
;   $FFFFC89E  Game mode × 2 (word: 0-6)
;   $FFFFC8A0  Game mode × 4 (word: 0-12)
;   $FFFFC8C8  Track number (word: 0-N)
;   $FFFFC8CA  Track × 2 (word)
;   $FFFFC8CC  Track × 4 (word)
;   $FFFFC826  Multiplayer flag (byte: 0=single, 1=multi)
;
; Entry: D0 = game mode (0-3)
;        D1 = track number
; Exit:  All index variables configured
; Uses:  D0, D1, D2
; ============================================================================

game_mode_track_config:
; --- Determine multiplayer flag ---
        moveq   #0,d2                           ; $00D19C: $7400 — assume single-player
        cmpi.w  #$0002,d0                       ; $00D19E: $0C40 $0002 — mode 2?
        bne.s   .check_mode3                    ; $00D1A2: $6602
        moveq   #1,d2                           ; $00D1A4: $7401 — mode 2 = multiplayer
.check_mode3:
        cmpi.w  #$0003,d0                       ; $00D1A6: $0C40 $0003 — mode 3?
        bne.s   .store_config                   ; $00D1AA: $6602
        moveq   #1,d2                           ; $00D1AC: $7401 — mode 3 = multiplayer

; --- Store multiplayer flag and game mode indices ---
.store_config:
        move.b  d2,($FFFFC826).w                ; $00D1AE: $11C2 $C826 — multiplayer flag
        move.w  d0,($FFFFC89C).w                ; $00D1B2: $31C0 $C89C — game mode (×1)
        add.w   d0,d0                           ; $00D1B6: $D040 — ×2
        move.w  d0,($FFFFC89E).w                ; $00D1B8: $31C0 $C89E — game mode × 2
        add.w   d0,d0                           ; $00D1BC: $D040 — ×4
        move.w  d0,($FFFFC8A0).w                ; $00D1BE: $31C0 $C8A0 — game mode × 4

; --- Store track indices ---
        move.w  d1,($FFFFC8C8).w                ; $00D1C2: $31C1 $C8C8 — track (×1)
        add.w   d1,d1                           ; $00D1C6: $D241 — ×2
        move.w  d1,($FFFFC8CA).w                ; $00D1C8: $31C1 $C8CA — track × 2
        add.w   d1,d1                           ; $00D1CC: $D241 — ×4
        move.w  d1,($FFFFC8CC).w                ; $00D1CE: $31C1 $C8CC — track × 4
        rts                                     ; $00D1D2: $4E75
