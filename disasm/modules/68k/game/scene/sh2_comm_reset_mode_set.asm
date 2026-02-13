; ============================================================================
; SH2 Comm Reset and Mode Set
; ROM Range: $0105DE-$010606 (40 bytes)
; ============================================================================
; Waits for SH2 to become idle (COMM0 high byte = 0), clears COMM1,
; resets game state to 0, sets display mode $0020, and writes the SH2
; entry point address to the adapter jump vector.
;
; Memory:
;   $FFFFC87E = main game state index (word, cleared to 0)
;   $00A15120 = COMM0 high byte (polled until zero)
;   $00A15123 = COMM1 low byte (cleared)
;   $00FF0008 = display mode register (word, set to $0020)
;   $00FF0002 = SH2 entry point vector (long, set to $008909AE)
; Entry: none | Exit: SH2 idle, game state reset, mode configured
; Uses: none (beyond RAM/register writes)
; ============================================================================

sh2_comm_reset_mode_set:
.wait_sh2:
        tst.b   COMM0_HI                        ; $0105DE: $4A39 ... — SH2 busy?
        bne.s   .wait_sh2                       ; $0105E4: $66F8 — yes: keep waiting
        clr.b   COMM1_LO                        ; $0105E6: $4239 ... — clear COMM1
        move.w  #$0000,($FFFFC87E).w            ; $0105EC: $31FC $0000 $C87E — reset game state
        move.w  #$0020,$00FF0008                ; $0105F2: set display mode
        move.l  #$008909AE,$00FF0002            ; $0105FA: set SH2 entry point
        rts                                     ; $010604: $4E75
