; ============================================================================
; SH2 Comm Check + Conditional Guard
; ROM Range: $005908-$005926 (30 bytes)
; ============================================================================
; Loads base address $A000 into A4, reads $C26C into D0.
; Checks bit 7 of $C81C — if set, goes to mask check.
; Otherwise tests $C89C — if zero, falls through.
; Masks D0 with $0138 — if zero, falls through. Otherwise returns.
;
; Memory:
;   $FFFFA000 = base address (loaded into A4)
;   $FFFFC26C = comm data (word, loaded into D0)
;   $FFFFC81C = comm flag (byte, bit 7 tested)
;   $FFFFC89C = SH2 comm state (word, tested)
; Entry: none | Exit: conditional return or fall-through | Uses: D0, A4
; ============================================================================

sh2_comm_check_cond_guard:
        lea     ($FFFFA000).w,a4                ; $005908: $49F8 $A000 — load base address
        move.w  ($FFFFC26C).w,d0                ; $00590C: $3038 $C26C — load comm data
        btst    #7,($FFFFC81C).w                ; $005910: $0838 $0007 $C81C — check comm flag bit 7
        bne.s   .mask_check                     ; $005916: $6606 — set → mask check
        tst.w   ($FFFFC89C).w                   ; $005918: $4A78 $C89C — test SH2 comm state
        dc.w    $6708                           ; BEQ.S fn_4200_038_end ; $00591C: — zero → fall through
.mask_check:
        andi.w  #$0138,d0                       ; $00591E: $0240 $0138 — mask comm bits
        dc.w    $6708                           ; BEQ.S fn_4200_038_end ; $005922: — zero → fall through
        rts                                     ; $005924: $4E75

