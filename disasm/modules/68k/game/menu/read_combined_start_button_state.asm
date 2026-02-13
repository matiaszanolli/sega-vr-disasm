; ============================================================================
; Read Combined Start Button State
; ROM Range: $014566-$01457C (22 bytes)
; ============================================================================
; Reads the start button flag from $C86D. If the current mode ($C810)
; is $0D (2-player), ORs in the second player's flag from $C86F.
; Returns bit 7 (start pressed) in D0.
;
; Memory:
;   $FFFFC86D = player 1 input flags (byte, bit 7 = start)
;   $FFFFC810 = current game mode (byte, $0D = 2-player)
;   $FFFFC86F = player 2 input flags (byte, bit 7 = start)
; Entry: none | Exit: D0.B bit 7 = start pressed (either player)
; Uses: D0
; ============================================================================

read_combined_start_button_state:
        move.b  ($FFFFC86D).w,d0               ; $014566: $1038 $C86D — load P1 input flags
        cmpi.b  #$0D,($FFFFC810).w             ; $01456A: $0C38 $000D $C810 — 2-player mode?
        bne.s   .mask                           ; $014570: $6604 — no: skip P2
        or.b    ($FFFFC86F).w,d0               ; $014572: $8038 $C86F — OR in P2 input flags
.mask:
        andi.b  #$80,d0                         ; $014576: $0200 $0080 — isolate start button bit
        rts                                     ; $01457A: $4E75
