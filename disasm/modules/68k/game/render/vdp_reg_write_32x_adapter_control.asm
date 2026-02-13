; ============================================================================
; VDP Register Write + 32X Adapter Control
; ROM Range: $001DBE-$001E42 (132 bytes)
; ============================================================================
; Category: game
; Purpose: Saves VDP status, waits 100 NOPs, writes VDP scroll data
;   from RAM $8000/$8002 to VRAM $6C00, writes game params $C880/$C882
;   to VDP CRAM $4000. If COMM1 bit 0 set: clears it, checks $C8C5
;   for state $18 (resets $C87E), clears $C8C4. Toggles adapter REN
;   bit via $A1518A/B (Z80 bus), then re-enables 32X interrupts.
;
; Uses: D0, D7, A5, A6
; RAM:
;   $8000: scroll_data_A (word)
;   $8002: scroll_data_B (word)
;   $C80C: frame_toggle (byte, bit 0)
;   $C87E: state_dispatch_idx (word, reset on state $18)
;   $C880: cram_data_A (word)
;   $C882: cram_data_B (word)
;   $C8C4: scene_sub_state (byte, cleared)
;   $C8C5: scene_main_state (byte, checked for $18)
; ============================================================================

vdp_reg_write_32x_adapter_control:
        move.w  (A5),D0                         ; $001DBE  save VDP status
        move.w  #$0063,D7                       ; $001DC0  D7 = 99 (loop count)
.wait_loop:
        nop                                     ; $001DC4  delay
        dbra    D7,.wait_loop                   ; $001DC6  100 iterations
        move.l  #$6C000003,(A5)                 ; $001DCA  VDP addr = VRAM $6C00
        move.w  ($FFFF8000).w,(A6)              ; $001DD0  write scroll_data_A
        move.w  ($FFFF8002).w,(A6)              ; $001DD4  write scroll_data_B
        move.l  #$40000010,(A5)                 ; $001DD8  VDP addr = CRAM $0000
        move.w  ($FFFFC880).w,(A6)              ; $001DDE  write cram_data_A
        move.w  ($FFFFC882).w,(A6)              ; $001DE2  write cram_data_B
        btst    #0,COMM1_LO                     ; $001DE6  COMM1 bit 0 set?
        beq.s   .done                           ; $001DEE  no → done
        bclr    #0,COMM1_LO                     ; $001DF0  clear COMM1 bit 0
        cmpi.b  #$18,($FFFFC8C5).w              ; $001DF8  main state == $18?
        bne.s   .clear_sub                      ; $001DFE  no → clear sub-state
        move.w  #$0000,($FFFFC87E).w            ; $001E00  reset dispatch idx
.clear_sub:
        move.b  #$00,($FFFFC8C4).w              ; $001E06  clear scene_sub_state
        bclr    #7,MARS_SYS_INTCTL              ; $001E0C  disable 32X interrupts
.wait_adapter:
        btst    #7,$00A1518A                    ; $001E14  adapter ready?
        beq.s   .wait_adapter                   ; $001E1C  no → wait
        bchg    #0,($FFFFC80C).w                ; $001E1E  toggle frame bit
        bne.s   .clear_ren                      ; $001E24  was set → clear REN
        bset    #0,$00A1518B                    ; $001E26  set REN bit
        bra.s   .reenable                       ; $001E2E  → re-enable
.clear_ren:
        bclr    #0,$00A1518B                    ; $001E30  clear REN bit
.reenable:
        bset    #7,MARS_SYS_INTCTL              ; $001E38  re-enable 32X interrupts
.done:
        rts                                     ; $001E40

