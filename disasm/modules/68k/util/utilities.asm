; ============================================================================
; Utility Functions ($0049xx)
; ============================================================================
;
; PURPOSE
; -------
; General-purpose utility functions used throughout the game:
; - Random number generation
; - V-blank synchronization
; - Display parameter initialization
;
; RANDOM NUMBER GENERATOR
; -----------------------
; Uses a Linear Congruential Generator (LCG) stored at $EF00.W (4 bytes).
; Algorithm: seed = seed * 41 (via shifts and adds)
; Returns 16-bit random value in D0
;
; V-BLANK SYNCHRONIZATION
; -----------------------
; WaitForVBlank sets V-INT state to 4 and waits for the V-INT handler
; to process it, providing frame synchronization.
;
; Dependencies: V-INT handler
; Related: vint_handler.asm
; ============================================================================
; Format: Proper mnemonics with original bytes in comments for verification
; ============================================================================

; Memory locations
RNG_SEED        equ     $EF00   ; Random seed (long)
VINT_STATE      equ     $C87A   ; V-INT state flag (word)
CTRL_STATE_1    equ     $C86C   ; Controller state 1 (word)
CTRL_STATE_2    equ     $C86E   ; Controller state 2 (word)
INPUT_BUFFER    equ     $C970   ; Input buffer (long)
INPUT_BUFFER2   equ     $C974   ; Input buffer 2 (long)

; Constants
RNG_DEFAULT     equ     $2A6D365A   ; Default seed if zero
VINT_STATE_4    equ     4           ; VDP minimal state
SR_ENABLE_INT   equ     $2300       ; Enable V-INT (level 6)
CTRL_CLEAR      equ     $FF00       ; Controller clear value
INPUT_CLEAR     equ     $FFFF0000   ; Input buffer clear value

        org     $00496E

; ============================================================================
; random_number_gen ($00496E) - Pseudo-Random Number Generator
; Called by: 6 locations per frame
; Parameters: None
; Returns: D0.W = random 16-bit value
;
; Algorithm: LCG with multiplier 41
;   seed = seed * 41 (computed as seed*4 + seed, then *8 + seed)
;   return = low word + high word (mixed for better distribution)
; ============================================================================

random_number_gen:
        move.l  d1,-(sp)                        ; $00496E: $2F01       - Save D1
        move.l  RNG_SEED.w,d1                   ; $004970: $2238 $EF00 - Get current seed
        bne.s   .have_seed                      ; $004974: $6606       - Skip if non-zero
        move.l  #RNG_DEFAULT,d1                 ; $004976: $223C $2A6D $365A - Default seed
.have_seed:
        move.l  d1,d0                           ; $00497C: $2001       - Copy seed
        asl.l   #2,d1                           ; $00497E: $E581       - seed * 4
        add.l   d0,d1                           ; $004980: $D280       - seed * 5
        asl.l   #3,d1                           ; $004982: $E781       - seed * 40
        add.l   d0,d1                           ; $004984: $D280       - seed * 41
        move.w  d1,d0                           ; $004986: $3001       - Get low word
        swap    d1                              ; $004988: $4841       - Get high word
        add.w   d1,d0                           ; $00498A: $D041       - Mix high + low
        move.w  d0,d1                           ; $00498C: $3200       - Copy result
        swap    d1                              ; $00498E: $4841       - Restore seed format
        move.l  d1,RNG_SEED.w                   ; $004990: $21C1 $EF00 - Store new seed
        move.l  (sp)+,d1                        ; $004994: $221F       - Restore D1
        rts                                     ; $004996: $4E75       - Return random in D0

; ============================================================================
; WaitForVBlank ($004998) - Wait for Vertical Blank
; Called by: Various (frame sync)
; Parameters: None
; Returns: After next V-INT completes
;
; Sets V-INT state to 4 (minimal VDP read), enables interrupts,
; then busy-waits until V-INT handler clears the state.
; ============================================================================

WaitForVBlank:
        move.w  #VINT_STATE_4,VINT_STATE.w      ; $004998: $31FC $0004 $C87A - Request V-INT
        move.w  #SR_ENABLE_INT,sr               ; $00499E: $46FC $2300       - Enable interrupts
.wait_loop:
        tst.w   VINT_STATE.w                    ; $0049A2: $4A78 $C87A       - Check if done
        bne.s   .wait_loop                      ; $0049A6: $66FA             - Loop until cleared
        rts                                     ; $0049A8: $4E75

; ============================================================================
; SetDisplayParams ($0049AA) - Initialize Display/Controller Parameters
; Called by: Initialization routines
; Parameters: None
; Returns: Clears controller states and input buffers
; ============================================================================

SetDisplayParams:
        move.w  #CTRL_CLEAR,CTRL_STATE_1.w      ; $0049AA: $31FC $FF00 $C86C - Clear ctrl 1
        move.w  #CTRL_CLEAR,CTRL_STATE_2.w      ; $0049B0: $31FC $FF00 $C86E - Clear ctrl 2
        move.l  #INPUT_CLEAR,INPUT_BUFFER.w     ; $0049B6: $21FC $FFFF $0000 $C970 - Clear input 1
        move.l  #INPUT_CLEAR,INPUT_BUFFER2.w    ; $0049BE: $21FC $FFFF $0000 $C974 - Clear input 2
        rts                                     ; $0049C6: $4E75

; ============================================================================
; SetDisplayParams_Alt ($0049C8) - Alternate Display Parameter Init
; Similar to SetDisplayParams but different clear pattern
; ============================================================================

SetDisplayParams_Alt:
        move.w  #CTRL_CLEAR,CTRL_STATE_1.w      ; $0049C8: $31FC $FF00 $C86C - Clear ctrl 1
        move.w  #CTRL_CLEAR,CTRL_STATE_2.w      ; $0049CE: $31FC $FF00 $C86E - Clear ctrl 2
        move.l  #INPUT_CLEAR,INPUT_BUFFER.w     ; $0049D4: $21FC $FFFF $0000 $C970 - Clear input
        rts                                     ; $0049DC: $4E75

; ============================================================================
; SetDisplayParams_Minimal ($0049DE) - Minimal Display Parameter Init
; Only clears controller 2 state
; ============================================================================

SetDisplayParams_Minimal:
        move.w  #CTRL_CLEAR,CTRL_STATE_2.w      ; $0049DE: $31FC $FF00 $C86E - Clear ctrl 2
        rts                                     ; $0049E4: $4E75

; ============================================================================
; reset_scroll_vars ($0049EE) - Reset Scroll Variables
; Called by: 3 locations per frame
; Parameters: None
; Returns: Clears scroll-related variables
; ============================================================================

        org     $0049EE

reset_scroll_vars:
        clr.w   $C0A8.w                         ; $0049EE: $4278 $C0A8 - Clear scroll var 1
        clr.w   $C0AA.w                         ; $0049F2: $4278 $C0AA - Clear scroll var 2
        clr.w   $C0AC.w                         ; $0049F6: $4278 $C0AC - Clear scroll var 3
        clr.w   $C0AE.w                         ; $0049FA: $4278 $C0AE - Clear scroll var 4
        clr.w   $C0B0.w                         ; $0049FE: $4278 $C0B0 - Clear scroll var 5
        clr.w   $C0B2.w                         ; $004A02: $4278 $C0B2 - Clear scroll var 6
        rts                                     ; $004A06: $4E75

; ============================================================================
; SUMMARY
; ============================================================================
;
; Function           | Address | Calls/Frame | Purpose
; -------------------+---------+-------------+-----------------------
; random_number_gen  | $00496E | 6           | PRNG (LCG algorithm)
; WaitForVBlank      | $004998 | varies      | Frame sync via V-INT
; SetDisplayParams   | $0049AA | init        | Clear controller states
; reset_scroll_vars  | $0049EE | 3           | Clear scroll variables
;
; ============================================================================
