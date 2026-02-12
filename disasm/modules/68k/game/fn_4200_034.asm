; ============================================================================
; Controller Input Check + Start Button Handler
; ROM Range: $0057D0-$00581A (74 bytes)
; ============================================================================
; Category: game
; Purpose: Two entry points:
;   Entry 1 ($0057D0): increments $C8C5 by 4, tail-jumps to $00246C.
;   Entry 2 ($0057D8): checks $A510 bit 5 → writes 0 or 1 to $FF69F0.
;     Reads P1 controller ($C86C byte), optionally ORs P2 ($C86E) if
;     $C80E bit 4 set (2-player mode). If == $70 → exits to $005822.
;     Then reads P1 byte 2 ($C86D), optionally ORs P2 byte 2 ($C86F).
;     If bit 7 set → exits to $00581A. Otherwise RTS.
;
; Uses: D0
; RAM:
;   $A510: mode flags (byte, bit 5)
;   $C80E: display control (byte, bit 4 = 2P mode)
;   $C86C: P1 controller byte A (byte)
;   $C86D: P1 controller byte B (byte)
;   $C86E: P2 controller byte A (byte)
;   $C86F: P2 controller byte B (byte)
;   $C8C5: frame sub-counter (byte, +4 per call)
; ============================================================================

fn_4200_034:
; --- entry 1: quick advance + tail jump ---
        addq.b  #4,($FFFFC8C5).w               ; $0057D0  sub-counter += 4
        dc.w    $4EFA,$CC96                     ; $0057D4  jmp $00246C(pc) — tail call
; --- entry 2: controller input check ---
        moveq   #$00,D0                         ; $0057D8  D0 = 0
        btst    #5,($FFFFA510).w               ; $0057DA  mode bit 5 set?
        bne.s   .write_mode                     ; $0057E0  yes → D0 stays 0
        move.w  #$0001,D0                       ; $0057E2  D0 = 1
.write_mode:
        move.b  D0,$00FF69F0                   ; $0057E6  write mode flag
        move.b  ($FFFFC86C).w,D0               ; $0057EC  D0 = P1 controller A
        btst    #4,($FFFFC80E).w               ; $0057F0  2-player mode?
        beq.s   .check_start                    ; $0057F6  no → check start
        or.b    ($FFFFC86E).w,D0               ; $0057F8  OR with P2 controller A
.check_start:
        cmpi.b  #$70,D0                         ; $0057FC  start combo ($70)?
        dc.w    $6720                           ; $005800  beq.s $005822 → exit (past fn)
        move.b  ($FFFFC86D).w,D0               ; $005802  D0 = P1 controller B
        btst    #4,($FFFFC80E).w               ; $005806  2-player mode?
        beq.s   .check_bit7                     ; $00580C  no → check bit 7
        or.b    ($FFFFC86F).w,D0               ; $00580E  OR with P2 controller B
.check_bit7:
        btst    #7,D0                           ; $005812  bit 7 (action)?
        dc.w    $6602                           ; $005816  bne.s $00581A → exit (past fn)
        rts                                     ; $005818
