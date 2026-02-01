; ============================================================================
; Scroll Variables & Display Parameters ($004998 - $004A30)
; ============================================================================
;
; PURPOSE
; -------
; Functions for managing scroll position variables, display limits, and
; V-blank synchronization. Used to reset/initialize viewport parameters
; between screens or race restarts.
;
; MEMORY
; ------
; | Address | Name         | Purpose                      |
; |---------|--------------|------------------------------|
; | $C86C   | SCROLL_VAR1  | Scroll variable 1 (word)     |
; | $C86E   | SCROLL_VAR2  | Scroll variable 2 (word)     |
; | $C87A   | VBLANK_FLAG  | V-blank wait flag (word)     |
; | $C970   | SCROLL_LIMIT1| Scroll limit 1 (long)        |
; | $C974   | SCROLL_LIMIT2| Scroll limit 2 (long)        |
;
; Dependencies: V-INT handler clears VBLANK_FLAG
; Related: camera.asm, vdp_operations.asm, vint_handler.asm
; ============================================================================
; Format: Proper mnemonics with original bytes in comments for verification
; ============================================================================

; Work RAM (sign-extended for .w addressing)
SCROLL_VAR1     equ     $FFFFC86C   ; Scroll variable 1
SCROLL_VAR2     equ     $FFFFC86E   ; Scroll variable 2
VBLANK_FLAG     equ     $FFFFC87A   ; V-blank wait flag
SCROLL_LIMIT1   equ     $FFFFC970   ; Scroll limit 1
SCROLL_LIMIT2   equ     $FFFFC974   ; Scroll limit 2

; Constants
SCROLL_MASK     equ     $FF80       ; Mask (clear low 7 bits, keep high 9)
SCROLL_DEFAULT  equ     $FFFF0000   ; Default limit value (-65536)
SCROLL_INIT     equ     $FF00       ; Initial scroll value
VBLANK_REQUEST  equ     $0004       ; V-blank request value
ENABLE_INTS     equ     $2300       ; Enable interrupts (SR value)

        org     $004998

; ============================================================================
; WaitForVBlank ($004998) - Wait for V-Blank Interrupt
; Called by: Various display routines
; Parameters: None
; Returns: Nothing (blocks until V-INT fires)
;
; Sets VBLANK_FLAG to request value, enables interrupts, then spins until
; the V-INT handler clears the flag. Used for display synchronization.
; ============================================================================

WaitForVBlank:
        move.w  #VBLANK_REQUEST,VBLANK_FLAG.w   ; $004998: $31FC $0004 $C87A - Request wait
        move.w  #ENABLE_INTS,sr                 ; $00499E: $46FC $2300       - Enable ints
.wait:
        tst.w   VBLANK_FLAG.w                   ; $0049A2: $4A78 $C87A       - Check flag
        bne.s   .wait                           ; $0049A6: $66FA             - Loop until clear
        rts                                     ; $0049A8: $4E75

; ============================================================================
; init_scroll_full ($0049AA) - Initialize All Scroll Variables
; Called by: Game initialization, mode transitions
; Parameters: None
; Returns: Nothing
;
; Sets scroll variables to $FF00 and limits to $FFFF0000.
; Full initialization for fresh screen setup.
; ============================================================================

        org     $0049AA

init_scroll_full:
        move.w  #SCROLL_INIT,SCROLL_VAR1.w      ; $0049AA: $31FC $FF00 $C86C - Init var 1
        move.w  #SCROLL_INIT,SCROLL_VAR2.w      ; $0049B0: $31FC $FF00 $C86E - Init var 2
        move.l  #SCROLL_DEFAULT,SCROLL_LIMIT1.w ; $0049B6: $21FC $FFFF $0000 $C970 - Set limit 1
        move.l  #SCROLL_DEFAULT,SCROLL_LIMIT2.w ; $0049BE: $21FC $FFFF $0000 $C974 - Set limit 2
        rts                                     ; $0049C6: $4E75

        org     $0049EE

; ============================================================================
; reset_scroll_vars ($0049EE) - Reset All Scroll Variables
; Called by: 3 locations (state transitions, race restart)
; Parameters: None
; Returns: Nothing
;
; Clears low 7 bits of scroll vars and sets limits to $FFFF0000.
; Used when transitioning between menus/race or on race restart.
; ============================================================================

reset_scroll_vars:
        andi.w  #SCROLL_MASK,SCROLL_VAR1.w      ; $0049EE: $0278 $FF80 $C86C - Mask var 1
        andi.w  #SCROLL_MASK,SCROLL_VAR2.w      ; $0049F4: $0278 $FF80 $C86E - Mask var 2
        move.l  #SCROLL_DEFAULT,SCROLL_LIMIT1.w ; $0049FA: $21FC $FFFF $0000 $C970 - Set limit 1
        move.l  #SCROLL_DEFAULT,SCROLL_LIMIT2.w ; $004A02: $21FC $FFFF $0000 $C974 - Set limit 2
        rts                                     ; $004A0A: $4E75

; ============================================================================
; reset_scroll_vars_partial ($004A0C) - Reset Partial Scroll Variables
; Called by: Various state handlers
; Parameters: None
; Returns: Nothing
;
; Similar to reset_scroll_vars but only sets SCROLL_LIMIT1.
; ============================================================================

        org     $004A0C

reset_scroll_vars_partial:
        andi.w  #SCROLL_MASK,SCROLL_VAR1.w      ; $004A0C: $0278 $FF80 $C86C - Mask var 1
        andi.w  #SCROLL_MASK,SCROLL_VAR2.w      ; $004A12: $0278 $FF80 $C86E - Mask var 2
        move.l  #SCROLL_DEFAULT,SCROLL_LIMIT1.w ; $004A18: $21FC $FFFF $0000 $C970 - Set limit 1
        rts                                     ; $004A20: $4E75

; ============================================================================
; reset_scroll_vars_single ($004A22) - Reset Single Scroll Variable
; Called by: Minor state handlers
; Parameters: None
; Returns: Nothing
;
; Resets only SCROLL_VAR2 and SCROLL_LIMIT2.
; ============================================================================

        org     $004A22

reset_scroll_vars_single:
        andi.w  #SCROLL_MASK,SCROLL_VAR2.w      ; $004A22: $0278 $FF80 $C86E - Mask var 2
        move.l  #SCROLL_DEFAULT,SCROLL_LIMIT2.w ; $004A28: $21FC $FFFF $0000 $C974 - Set limit 2
        rts                                     ; $004A30: $4E75

; ============================================================================
; SUMMARY
; ============================================================================
;
; Function                 | Address | Size | Purpose
; -------------------------+---------+------+-------------------------
; WaitForVBlank            | $004998 | 18B  | Wait for V-INT to fire
; init_scroll_full         | $0049AA | 30B  | Full scroll initialization
; reset_scroll_vars        | $0049EE | 30B  | Reset all scroll vars
; reset_scroll_vars_partial| $004A0C | 22B  | Reset partial (limit 1)
; reset_scroll_vars_single | $004A22 | 16B  | Reset single (var2/limit2)
;
; These functions manage display synchronization and scroll state:
; - WaitForVBlank provides frame-sync for display operations
; - init_scroll_full sets up fresh scroll state for new screens
; - reset_scroll_* functions clear scroll state during transitions
;
; ============================================================================
