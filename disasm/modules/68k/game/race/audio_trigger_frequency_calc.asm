; ============================================================================
; Audio Trigger + Frequency Calc
; ROM Range: $00232A-$0023C2 (152 bytes)
; ============================================================================
; Manages audio trigger state for channel B. Reads port B control
; bit 4 to detect trigger events, loads sound command from lookup
; table. Optionally copies audio level to channel B. Then calculates
; frequency via weighted shift average and copies result to channel A.
;
; Uses: D0, D1, A1
; RAM:
;   $8516: ch_b_update_flag
;   $8760: ch_a_frequency (receives copy)
;   $8789: ch_b_stored_level
;   $8790: ch_b_frequency
;   $9074: port_b_data
;   $90E5: port_b_control
;   $C805: sound_command_id
;   $C80B: audio_mode_flags
;   $C823: audio_trigger_flag
;   $C828: audio_level
;   $C8C8: vint_state (table index for sound lookup)
; ============================================================================

audio_trigger_frequency_calc:
; --- sound command lookup table (4 bytes, indexed by vint_state) ---
        dc.w    $AFAD,$AE00                      ; sound IDs: [$AF, $AD, $AE, $00]
; --- code start ---
        move.w  ($FFFF9074).w,d0                ; port B data
        lea     ($FFFF8790).w,a1                ; channel B frequency
        btst    #4,($FFFF90E5).w                ; port B control: trigger active?
        beq.s   .trigger_off
        cmpi.b  #$01,($FFFFC823).w              ; already triggered?
        beq.s   .check_audio_mode
        move.b  #$01,($FFFFC823).w              ; set trigger flag
        move.w  ($FFFFC8C8).w,d0                ; vint_state as index
        move.b  $00232A(pc,d0.w),($FFFFC8A5).w  ; load sound command from table
        bra.s   .check_audio_mode
.trigger_off:
        tst.b   ($FFFFC823).w                   ; trigger was active?
        beq.s   .check_audio_mode
        move.b  #$00,($FFFFC823).w              ; clear trigger flag
        move.b  #$AB,($FFFFC8A5).w              ; default sound command
.check_audio_mode:
        btst    #1,($FFFFC80B).w                ; audio mode bit 1?
        beq.s   .check_state
        move.b  ($FFFFC828).w,($FFFF8789).w     ; copy audio_level → ch B stored
        move.b  #$01,($FFFF8516).w              ; set ch B update flag
        bclr    #1,($FFFFC80B).w                ; clear mode bit
.check_state:
        cmpi.w  #$0000,($FFFFC8C8).w            ; vint_state = 0?
        dc.w    $6750                            ; beq.s $0023DC → external handler
        cmpi.w  #$0002,($FFFFC8C8).w            ; vint_state = 2?
        dc.w    $6700,$0092                      ; beq.w $002426 → external handler
; --- frequency calculation: weighted shift average ---
        lsr.w   #5,d0                           ; port_data >> 5
        move.w  d0,d1                           ; D1 = port_data >> 5
        lsr.w   #2,d0                           ; D0 = port_data >> 7
        add.w   d0,d1                            ; D1 += D0
        lsr.w   #1,d0                           ; D0 = port_data >> 8
        add.w   d0,d1                            ; D1 += D0
        addi.w  #$1A5E,d1                       ; add base frequency
        add.w   (a1),d1                         ; add current frequency
        lsr.w   #1,d1                           ; average (smooth)
        cmpi.w  #$1E00,d1                       ; above max?
        dc.w    $6E12                            ; bgt.s $0023C2 → external (clamp high)
        cmpi.w  #$1A5E,d1                       ; below min?
        dc.w    $6E10                            ; bgt.s $0023C6 → external (above min)
        move.w  #$1A5E,d1                       ; clamp to minimum
        move.w  d1,(a1)                         ; store ch B frequency
        move.w  (a1),($FFFF8760).w              ; copy ch B → ch A frequency
        rts
