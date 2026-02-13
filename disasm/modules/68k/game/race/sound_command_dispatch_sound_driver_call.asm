; ============================================================================
; Sound Command Dispatch + Sound Driver Call
; ROM Range: $002080-$0020D6 (86 bytes)
; ============================================================================
; Category: game
; Purpose: Processes pending sound commands from 3 RAM slots:
;   Priority 1 ($C822): if nonzero, writes to Z80 command ($8509),
;     clears $C822 and $C8A4, then calls sound driver.
;   Priority 2 ($C8A5): if nonzero and different from $C8A7 (last sent),
;     writes to Z80 ($850A) and updates $C8A7.
;   Priority 3 ($C8A4): if nonzero, writes to Z80 ($850A) and
;     updates $C8A6.
;   Always calls sound driver at $008B0000 (preserves A5/A6).
;
; Uses: D0, A5, A6
; RAM:
;   $8509: Z80 sound command A (byte)
;   $850A: Z80 sound command B (byte)
;   $C822: high-priority sound command (byte)
;   $C8A4: low-priority sound command (byte/long, cleared)
;   $C8A5: SFX command (byte)
;   $C8A6: last sent SFX B (byte)
;   $C8A7: last sent SFX A (byte)
; ============================================================================

sound_command_dispatch_sound_driver_call:
; --- priority 1: high-priority command ($C822) ---
        move.b  ($FFFFC822).w,D0               ; $002080  D0 = high-priority cmd
        beq.s   .check_sfx                      ; $002084  zero → check SFX
        move.b  D0,($FFFF8509).w               ; $002086  send to Z80 command A
        moveq   #$00,D0                         ; $00208A  D0 = 0
        move.b  D0,($FFFFC822).w               ; $00208C  clear high-priority cmd
        move.l  D0,($FFFFC8A4).w               ; $002090  clear low-priority (long)
        bra.s   .call_driver                    ; $002094  → call sound driver
.check_sfx:
; --- priority 2: SFX command ($C8A5) ---
        move.b  ($FFFFC8A5).w,D0               ; $002096  D0 = SFX command
        beq.s   .check_low                      ; $00209A  zero → check low-priority
        cmp.b   ($FFFFC8A7).w,D0               ; $00209C  same as last sent?
        beq.s   .clear_sfx                      ; $0020A0  yes → just clear
        move.b  D0,($FFFF850A).w               ; $0020A2  send to Z80 command B
        move.b  D0,($FFFFC8A7).w               ; $0020A6  update last sent A
.clear_sfx:
        move.b  #$00,($FFFFC8A5).w             ; $0020AA  clear SFX command
        bra.s   .call_driver                    ; $0020B0  → call sound driver
.check_low:
; --- priority 3: low-priority command ($C8A4) ---
        move.b  ($FFFFC8A4).w,D0               ; $0020B2  D0 = low-priority cmd
        beq.s   .call_driver                    ; $0020B6  zero → call sound driver
        move.b  D0,($FFFF850A).w               ; $0020B8  send to Z80 command B
        move.b  D0,($FFFFC8A6).w               ; $0020BC  update last sent B
        move.b  #$00,($FFFFC8A4).w             ; $0020C0  clear low-priority cmd
.call_driver:
        movem.l A5/A6,-(A7)                    ; $0020C6  save registers
        jsr     $008B0000                       ; $0020CA  call sound driver
        movem.l (A7)+,A5/A6                    ; $0020D0  restore registers
        rts                                     ; $0020D4
