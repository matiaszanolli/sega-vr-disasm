; ============================================================================
; Scene Setup / Game Mode Transition
; ROM Range: $00E00C-$00E117 (268 bytes)
; Source: code_c200
; ============================================================================
;
; PURPOSE
; -------
; Configures the game's scene handler function pointer ($FF0002) based on
; the current game sub-mode ($A024) and related flags. This is the central
; dispatch that selects which scene loop runs during gameplay.
;
; Also copies track selection parameters to per-mode RAM slots ($FEA5-$FEAC)
; and configures display control bits ($C80E) for split-screen modes.
;
; GAME SUB-MODES ($A024)
; ----------------------
;   0 = Default (single player / standard)
;   1 = Mode 1 (split-screen player 1 primary)
;   2 = Mode 2 (split-screen player 2 primary)
;
; SCENE HANDLERS SET (at $FF0002)
; -------------------------------
; The scene handler is called each frame by the main loop.
;
;   Mode 0 (default):      $0088E5CE
;   Mode 0 + mirror flag:  $0088E5E6  (bit 7 of $FDA8 set)
;   Mode 1:                $0088E5FE
;   Mode 2:                $0088F13C
;
; If not in demo mode ($A018 == 0), also sets a loading/init handler:
;   Mode 0 (default):  $00884A3E
;   Mode 1:            $00885100  (+ display bit 5 set, bit 4 clear)
;   Mode 2:            $00884D98  (+ display bit 4 set, bit 5 clear)
;   Fallback:          $00884D98
;
; MEMORY VARIABLES
; ----------------
;   $FFFFA018  Player 1 data pointer (non-zero = demo/replay mode)
;   $FFFFA019  Player 1 track selection (byte, 0-4)
;   $FFFFA024  Game sub-mode (byte: 0, 1, or 2)
;   $FFFFA025  Saved P1 selection (byte, persisted across calls)
;   $FFFFA026  Saved P2 selection (byte, persisted across calls)
;   $FFFFA027  Two-player flag (byte: 0=first call, non-zero=update)
;   $FFFFC80E  Display control flags (bits 4,5 = split-screen config)
;   $FFFFC87E  Game state (word, cleared to 0 by this function)
;   $FFFFFDA8  Mode flags (bit 7 = mirror/alternate track flag)
;   $FFFFFEA5  Track param: mode 0, primary slot
;   $FFFFFEA6  Track param: mode 0, mirror slot
;   $FFFFFEA7  Track param: mode 1, P1 slot
;   $FFFFFEA8  Track param: mode 1, P2 slot
;   $FFFFFEAB  Track param: mode 2, P1 slot
;   $FFFFFEAC  Track param: mode 2, P2 slot
;   $00FF0002  Scene handler function pointer (long)
;
; Entry: No register inputs (reads state from RAM)
; Exit:  $FF0002 set to appropriate scene handler
; Uses:  No registers modified (all operands are memory-to-memory)
; ============================================================================

scene_setup_game_mode_transition:
; --- Save current track selection to appropriate player slot ---
; On first call ($A027 == 0): save to P1 slot ($A025)
; On subsequent calls ($A027 != 0): save to P2 slot ($A026)
        tst.b   ($FFFFA027).w                   ; $00E00C: $4A38 $A027
        bne.w   .save_p2                        ; $00E010: $6600 $000A
        move.b  ($FFFFA019).w,($FFFFA025).w     ; $00E014: $11F8 $A019 $A025 — P1 selection → saved P1
        bra.s   .check_sub_mode                 ; $00E01A: $6006
.save_p2:
        move.b  ($FFFFA019).w,($FFFFA026).w     ; $00E01C: $11F8 $A019 $A026 — P1 selection → saved P2

; --- Copy track selections to per-mode parameter slots ---
.check_sub_mode:
        tst.b   ($FFFFA024).w                   ; $00E022: $4A38 $A024
        beq.s   .params_mode_0                  ; $00E026: $6718 — Mode 0
        cmpi.b  #$01,($FFFFA024).w              ; $00E028: $0C38 $0001 $A024
        beq.s   .params_mode_1                  ; $00E02E: $672A — Mode 1

; Mode 2: copy both saved selections to $FEAB/$FEAC
        move.b  ($FFFFA025).w,($FFFFFEAB).w     ; $00E030: $11F8 $A025 $FEAB
        move.b  ($FFFFA026).w,($FFFFFEAC).w     ; $00E036: $11F8 $A026 $FEAC
        bra.w   .set_game_state                 ; $00E03C: $6000 $0028

; Mode 0: copy current selection to $FEA5; if mirror flag set, also to $FEA6
.params_mode_0:
        move.b  ($FFFFA019).w,($FFFFFEA5).w     ; $00E040: $11F8 $A019 $FEA5 — primary slot
        btst    #7,($FFFFFDA8).w                ; $00E046: $0838 $0007 $FDA8 — mirror flag?
        beq.w   .set_game_state                 ; $00E04C: $6700 $0018 — no mirror, skip
        move.b  ($FFFFA019).w,($FFFFFEA6).w     ; $00E050: $11F8 $A019 $FEA6 — mirror slot
        bra.w   .set_game_state                 ; $00E056: $6000 $000E

; Mode 1: copy saved P1/P2 selections to $FEA7/$FEA8
.params_mode_1:
        move.b  ($FFFFA025).w,($FFFFFEA7).w     ; $00E05A: $11F8 $A025 $FEA7
        move.b  ($FFFFA026).w,($FFFFFEA8).w     ; $00E060: $11F8 $A026 $FEA8

; --- Clear game state and select scene handler ---
.set_game_state:
        move.w  #$0000,($FFFFC87E).w            ; $00E066: $31FC $0000 $C87E — game_state = 0

; Default scene handler (will be overridden below if mode 1 or 2)
        move.l  #$0088E5CE,$00FF0002            ; $00E06C: $23FC ... — default scene

; Select scene handler based on sub-mode
        cmpi.b  #$01,($FFFFA024).w              ; $00E076: $0C38 $0001 $A024
        beq.s   .scene_mode_1                   ; $00E07C: $671C
        cmpi.b  #$02,($FFFFA024).w              ; $00E07E: $0C38 $0002 $A024
        beq.s   .scene_mode_2                   ; $00E084: $6720

; Mode 0: check mirror flag for alternate scene variant
        btst    #7,($FFFFFDA8).w                ; $00E086: $0838 $0007 $FDA8
        beq.s   .check_demo                     ; $00E08C: $6722 — no mirror, keep default
        move.l  #$0088E5E6,$00FF0002            ; $00E08E: $23FC ... — mirror variant scene
        bra.s   .check_demo                     ; $00E098: $6016

.scene_mode_1:
        move.l  #$0088E5FE,$00FF0002            ; $00E09A: $23FC ... — mode 1 scene
        bra.s   .check_demo                     ; $00E0A4: $600A

.scene_mode_2:
        move.l  #$0088F13C,$00FF0002            ; $00E0A6: $23FC ... — mode 2 scene

; --- Demo mode check: if $A018 != 0, skip loading handler setup ---
.check_demo:
        tst.b   ($FFFFA018).w                   ; $00E0B0: $4A38 $A018
        bne.s   .done                           ; $00E0B4: $6660 — demo/replay: skip init

; --- Set loading/init handler (non-demo only) ---
; Default loading handler (overridden below per mode)
        move.l  #$00884D98,$00FF0002            ; $00E0B6: $23FC ... — default loading handler

        cmpi.b  #$01,($FFFFA024).w              ; $00E0C0: $0C38 $0001 $A024
        beq.w   .loading_mode_1                 ; $00E0C6: $6700 $001A
        cmpi.b  #$02,($FFFFA024).w              ; $00E0CA: $0C38 $0002 $A024
        beq.w   .loading_mode_2                 ; $00E0D0: $6700 $002A

; Mode 0 loading handler
        move.l  #$00884A3E,$00FF0002            ; $00E0D4: $23FC ... — mode 0 loading handler
        bra.w   .done                           ; $00E0DE: $6000 $0036

; Mode 1 loading: set split-screen bit 5 (P1 primary), clear bit 4
.loading_mode_1:
        bset    #5,($FFFFC80E).w                ; $00E0E2: $08F8 $0005 $C80E — enable P1 split
        bclr    #4,($FFFFC80E).w                ; $00E0E8: $08B8 $0004 $C80E — disable P2 split
        move.l  #$00885100,$00FF0002            ; $00E0EE: $23FC ... — mode 1 loading handler
        bra.w   .done                           ; $00E0F8: $6000 $001C

; Mode 2 loading: set split-screen bit 4 (P2 primary), clear bit 5
.loading_mode_2:
        bset    #4,($FFFFC80E).w                ; $00E0FC: $08F8 $0004 $C80E — enable P2 split
        bclr    #5,($FFFFC80E).w                ; $00E102: $08B8 $0005 $C80E — disable P1 split
        move.l  #$00884D98,$00FF0002            ; $00E108: $23FC ... — mode 2 loading handler
        bra.w   .done                           ; $00E112: $6000 $0002

.done:
        rts                                     ; $00E116: $4E75
