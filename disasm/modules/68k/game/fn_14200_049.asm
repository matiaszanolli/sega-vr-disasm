; ============================================================================
; SH2 Call with Interrupt Mask
; ROM Range: $014696-$0146B4 (30 bytes)
; ============================================================================
; Sets VDP update flag ($C80D), saves all registers, raises interrupt
; priority mask to level 7 (disable all), calls SH2 routine at
; $0088D1D4, restores mask to level 3, and restores registers.
;
; Memory:
;   $FFFFC80D = VDP update flag (byte, set to $01)
; Entry: none | Exit: SH2 routine called | Uses: all (saved/restored)
; ============================================================================

fn_14200_049:
        move.b  #$01,($FFFFC80D).w              ; $014696: $11FC $0001 $C80D — set VDP update flag
        movem.l d0-d7/a0-a6,-(a7)              ; $01469C: $48E7 $FFFE — save all registers
        move    #$2700,sr                       ; $0146A0: $46FC $2700 — mask all interrupts
        jsr     $0088D1D4                       ; $0146A4: $4EB9 $0088 $D1D4 — call SH2 routine
        move    #$2300,sr                       ; $0146AA: $46FC $2300 — restore interrupt level 3
        movem.l (a7)+,d0-d7/a0-a6              ; $0146AE: $4CDF $7FFF — restore all registers
        rts                                     ; $0146B2: $4E75

