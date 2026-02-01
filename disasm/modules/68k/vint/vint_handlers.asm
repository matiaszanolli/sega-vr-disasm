; ============================================================================
; V-INT (Vertical Interrupt) Handler Helpers ($002010 - $002038)
; ============================================================================
;
; PURPOSE
; -------
; Helper functions called by the V-INT handler for cleanup and state
; management at the end of vertical blank processing.
;
; MEMORY MAP
; ----------
; | Address    | Name              | Purpose                       |
; |------------|-------------------|-------------------------------|
; | $FFFFC87E  | VINT_STATE_FLAG   | V-INT state flag (word)       |
; | $FFFFC8C4  | COMM_DONE_FLAG    | Communication done flag       |
; | $FFFFC8C5  | CURRENT_STATE     | Current V-INT state byte      |
;
; MARS REGISTERS
; --------------
; | Address    | Name              | Purpose                       |
; |------------|-------------------|-------------------------------|
; | $A15123    | MARS_COMM_CTRL    | COMM control (bit 0 = flag)   |
;
; Dependencies: V-INT handler, SH2 communication
; Related: frame_sync.asm, sh2_communication.asm
; ============================================================================
; Format: Proper mnemonics with original bytes in comments for verification
; ============================================================================

; Work RAM addresses (sign-extended for .w addressing)
VINT_STATE_FLAG equ     $FFFFC87E   ; V-INT state flag
COMM_DONE_FLAG  equ     $FFFFC8C4   ; Communication done flag
CURRENT_STATE   equ     $FFFFC8C5   ; Current V-INT state

; MARS registers
MARS_COMM_CTRL  equ     $A15123     ; COMM control register

; State constants
STATE_CLEANUP   equ     $18         ; State $18 requires extra cleanup

        org     $002010

; ============================================================================
; vint_state_cleanup ($002010) - V-INT State Cleanup Handler
; Purpose: Clears SH2 communication flags at end of V-INT processing
; Called by: V-INT handler (state 15)
; Parameters:
;   A5 = VDP status port
; Returns: Nothing
;
; Protocol:
;   1. Read VDP status (side effect: clears V-INT pending)
;   2. Check if COMM handshake bit is set
;   3. If set, clear it and perform cleanup
;   4. If state is $18, clear additional flag
;   5. Clear communication done flag
; ============================================================================

vint_state_cleanup:
        move.w  (a5),d0                         ; $002010: $3015       - Read VDP status
        btst    #0,MARS_COMM_CTRL               ; $002012: $0839 $0000 $00A1 $5123 - Check COMM bit
        beq.s   .done                           ; $00201A: $671C       - Skip if not set

; COMM bit was set - perform cleanup
        bclr    #0,MARS_COMM_CTRL               ; $00201C: $08B9 $0000 $00A1 $5123 - Clear COMM bit
        cmpi.b  #STATE_CLEANUP,CURRENT_STATE.w  ; $002024: $0C38 $0018 $C8C5 - Check state
        bne.s   .clear_done                     ; $00202A: $6606       - Skip if not $18

; State $18 requires extra cleanup
        move.w  #$0000,VINT_STATE_FLAG.w        ; $00202C: $31FC $0000 $C87E - Clear state flag

.clear_done:
        move.b  #$00,COMM_DONE_FLAG.w           ; $002032: $11FC $0000 $C8C4 - Clear done flag

.done:
        rts                                     ; $002038: $4E75

; ============================================================================
; SUMMARY
; ============================================================================
;
; Function           | Address | Size | Purpose
; -------------------+---------+------+------------------------------
; vint_state_cleanup | $002010 | 42B  | Clear COMM flags after V-INT
;
; This function is called at the end of V-INT processing to:
; - Acknowledge the V-INT by reading VDP status
; - Clear the SH2 communication handshake bit
; - Reset state flags for next frame
;
; The state $18 check suggests special cleanup for a specific game mode.
;
; ============================================================================
