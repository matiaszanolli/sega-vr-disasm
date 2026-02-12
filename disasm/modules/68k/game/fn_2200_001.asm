; ============================================================================
; Audio Frequency Update (Dual Channel)
; ROM Range: $00220C-$002294 (136 bytes)
; ============================================================================
; Updates audio frequency for two channels (A and B). Each channel
; reads port data, checks source select bit, compares stored audio
; level, and recalculates frequency via weighted shift average.
; Channel A is processed first via BSR.S, then channel B falls
; through to the same shared subroutine.
;
; Uses: D0, D1, A1, A2, A3
; RAM:
;   $8517: ch_b_update_flag
;   $8760: ch_a_frequency
;   $8759: ch_a_stored_level
;   $8790: ch_b_frequency
;   $8789: ch_b_stored_level
;   $9074: port_b_data
;   $9F74: port_a_data
;   $9FE5: port_a_control
;   $90E5: port_b_control
;   $C827: audio_level_raw
;   $C828: audio_level
;   $C8C8: vint_state
; ============================================================================

fn_2200_001:
; --- channel A setup ---
        move.w  ($FFFF9F74).w,d0                ; port A data
        move.b  ($FFFF9FE5).w,d1                ; port A control
        lea     ($FFFF8759).w,a3                ; channel A stored level
        lea     ($FFFF8517).w,a2                ; channel A update flag
        lea     ($FFFF8760).w,a1                ; channel A frequency
        bsr.s   .calc_freq
; --- channel B setup ---
        move.w  ($FFFF9074).w,d0                ; port B data
        move.b  ($FFFF90E5).w,d1                ; port B control
        lea     ($FFFF8789).w,a3                ; channel B stored level
        lea     ($FFFF8516).w,a2                ; channel B update flag
        lea     ($FFFF8790).w,a1                ; channel B frequency
; --- shared frequency calculation subroutine ---
.calc_freq:
        btst    #4,d1                           ; source select bit?
        beq.s   .alt_source
        move.b  ($FFFFC827).w,d1                ; audio_level_raw
        cmp.b   (a3),d1                         ; changed from stored?
        beq.s   .check_state
        move.b  d1,(a3)                         ; update stored level
        move.b  #$01,(a2)                       ; set update flag
        bra.s   .check_state
.alt_source:
        move.b  ($FFFFC828).w,d1                ; audio_level
        cmp.b   (a3),d1                         ; changed from stored?
        beq.s   .check_state
        move.b  d1,(a3)                         ; update stored level
        move.b  #$01,(a2)                       ; set update flag
.check_state:
        cmpi.w  #$0000,($FFFFC8C8).w            ; vint_state = 0?
        dc.w    $6748                            ; beq.s $0022AA → external handler (state 0)
        cmpi.w  #$0002,($FFFFC8C8).w            ; vint_state = 2?
        dc.w    $6700,$0082                      ; beq.w $0022EC → external handler (state 2)
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
        dc.w    $6E0E                            ; bgt.s $002294 → external (clamp high)
        cmpi.w  #$1A5E,d1                       ; below min?
        dc.w    $6E0C                            ; bgt.s $002298 → external (above min, store)
        move.w  #$1A5E,d1                       ; clamp to minimum
        move.w  d1,(a1)                         ; store frequency
        rts
