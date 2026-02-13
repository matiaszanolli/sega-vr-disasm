; ============================================================================
; Pause Menu Handler + Controller Check
; ROM Range: $0056E4-$00573C (88 bytes)
; ============================================================================
; Category: game
; Purpose: Three entry points:
;   Entry 1 ($0056E4): BCLR bit 7 of $FDA8, tail-jump to $00D48A.
;   Entry 2 ($0056EE): BSET bit 7 of $FDA8, tail-jump to $00D48A.
;   Entry 3 ($0056F8): Reads P1 controller ($C86D), optionally ORs
;     P2 ($C86F) if $C80E bit 4 set (2P mode). If bit 7 of result
;     set AND $C800 == 0: writes mode flag to $FF69F0, calls
;     SetDisplayParams, resets tick counter ($A510), sets sub_state
;     ($C8C4) = $0C00, state_dispatch_idx ($C87E) = $10,
;     writes $44 to SH2 COMM.
;
; Uses: D0
; RAM:
;   $A510: tick counter (byte, cleared)
;   $C800: scene flag (byte, checked == 0)
;   $C80E: control flags (byte, bit 4 = 2P mode)
;   $C86D: P1 controller byte B (byte)
;   $C86F: P2 controller byte B (byte)
;   $C87E: state_dispatch_idx (word, set to $10)
;   $C8C4: sub_state (word, set to $0C00)
;   $FDA8: pause flag (byte, bit 7)
; Calls:
;   $0049AA: SetDisplayParams
;   $00D48A: pause handler (tail-jump target)
; ============================================================================

pause_menu_handler_ctrl_check:
; --- entry 1: clear pause flag + tail jump ---
        bclr    #7,($FFFFFDA8).w               ; $0056E4  clear pause bit 7
        dc.w    $4EFA,$7D9E                     ; $0056EA  jmp $00D48A(pc) — pause handler
; --- entry 2: set pause flag + tail jump ---
        bset    #7,($FFFFFDA8).w               ; $0056EE  set pause bit 7
        dc.w    $4EFA,$7D94                     ; $0056F4  jmp $00D48A(pc) — pause handler
; --- entry 3: controller check ---
        move.b  ($FFFFC86D).w,D0               ; $0056F8  D0 = P1 controller B
        btst    #4,($FFFFC80E).w               ; $0056FC  2-player mode?
        beq.s   .check_bit7                     ; $005702  no → check bit 7
        or.b    ($FFFFC86F).w,D0               ; $005704  OR with P2 controller B
.check_bit7:
        btst    #7,D0                           ; $005708  start/action pressed?
        beq.s   .done                           ; $00570C  no → done
        tst.b   ($FFFFC800).w                  ; $00570E  scene flag set?
        bne.s   .done                           ; $005712  yes → done
        move.b  #$01,$00FF69F0                 ; $005714  write mode flag
        dc.w    $4EBA,$F28C                     ; $00571C  jsr $0049AA(pc) — SetDisplayParams
        move.b  #$00,($FFFFA510).w             ; $005720  clear tick counter
        move.w  #$0C00,($FFFFC8C4).w          ; $005726  sub_state = $0C00
        move.w  #$0010,($FFFFC87E).w          ; $00572C  state_dispatch = $10
        move.w  #$0044,$00FF0008               ; $005732  SH2 COMM = $44
.done:
        rts                                     ; $00573A
