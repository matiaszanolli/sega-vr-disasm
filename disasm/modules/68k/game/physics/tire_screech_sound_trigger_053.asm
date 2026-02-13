; ============================================================================
; Tire Screech Sound Trigger 053
; ROM Range: $007C56-$007CD8 (130 bytes)
; ============================================================================
; Category: game
; Purpose: Checks 4 collision/contact channels and triggers screech sound
;   Each channel: tests cooldown timer, checks contact bit, sets 15-frame timer
;   Only queues sound $D2 if no other sound is pending
;
; Entry: A0 = object/entity pointer
; Uses: D2, A0
; RAM:
;   $C8A4: sound_command
; Object fields (A0):
;   +$58: contact_flags_a
;   +$59: contact_flags_b
;   +$98: screech_timer_a (bit 3 of +$58)
;   +$9A: screech_timer_b (bit 3 of +$59)
;   +$E6: screech_timer_c (bit 4 of +$58)
;   +$E8: screech_timer_d (bit 4 of +$59)
; Confidence: high
; ============================================================================

tire_screech_sound_trigger_053:
; --- channel A: contact_flags_a bit 3 ---
        tst.w   $0098(A0)                        ; $007C56  timer_a active?
        bne.s   .chan_b                          ; $007C5A  yes → skip
        btst    #3,$0058(A0)                     ; $007C5C  contact bit 3?
        beq.s   .chan_b                          ; $007C62  no → skip
        move.w  #$000F,$0098(A0)                 ; $007C64  timer_a = 15 frames
        tst.b   ($FFFFC8A4).w                    ; $007C6A  sound pending?
        bne.s   .chan_b                          ; $007C6E  yes → skip sound
        move.b  #$D2,($FFFFC8A4).w               ; $007C70  sound_command = $D2 (screech)
.chan_b:
; --- channel B: contact_flags_b bit 3 ---
        tst.w   $009A(A0)                        ; $007C76  timer_b active?
        bne.s   .chan_c                          ; $007C7A  yes → skip
        btst    #3,$0059(A0)                     ; $007C7C  contact bit 3?
        beq.s   .chan_c                          ; $007C82  no → skip
        move.w  #$000F,$009A(A0)                 ; $007C84  timer_b = 15 frames
        tst.b   ($FFFFC8A4).w                    ; $007C8A  sound pending?
        bne.s   .chan_c                          ; $007C8E  yes → skip sound
        move.b  #$D2,($FFFFC8A4).w               ; $007C90  sound_command = $D2
.chan_c:
; --- channel C: contact_flags_a bit 4 ---
        tst.w   $00E6(A0)                        ; $007C96  timer_c active?
        bne.s   .chan_d                          ; $007C9A  yes → skip
        btst    #4,$0058(A0)                     ; $007C9C  contact bit 4?
        beq.s   .chan_d                          ; $007CA2  no → skip
        move.w  #$000F,$00E6(A0)                 ; $007CA4  timer_c = 15 frames
        tst.b   ($FFFFC8A4).w                    ; $007CAA  sound pending?
        bne.s   .chan_d                          ; $007CAE  yes → skip sound
        move.b  #$D2,($FFFFC8A4).w               ; $007CB0  sound_command = $D2
.chan_d:
; --- channel D: contact_flags_b bit 4 ---
        tst.w   $00E8(A0)                        ; $007CB6  timer_d active?
        bne.s   .done                            ; $007CBA  yes → skip
        btst    #4,$0059(A0)                     ; $007CBC  contact bit 4?
        beq.s   .done                            ; $007CC2  no → skip
        move.w  #$000F,$00E8(A0)                 ; $007CC4  timer_d = 15 frames
        tst.b   ($FFFFC8A4).w                    ; $007CCA  sound pending?
        bne.s   .done                            ; $007CCE  yes → skip sound
        move.b  #$D2,($FFFFC8A4).w               ; $007CD0  sound_command = $D2
.done:
        rts                                     ; $007CD6
