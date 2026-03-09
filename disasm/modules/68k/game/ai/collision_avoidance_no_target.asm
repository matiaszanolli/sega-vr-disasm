; ============================================================================
; collision_avoidance_no_target — AI Collision Avoidance (No-Target Path)
; ROM Range: $00A6F8-$00A79E (168 bytes)
; ============================================================================
; Alternate path of collision_avoidance_speed_calc when entity has no target
; ($A4(A0) == 0 or target invalid). Computes Manhattan distance to nearest
; entity, applies braking and lateral steering if within thresholds.
;
; Reached via BEQ.W from collision_avoidance_speed_calc at $A4BC/$A4CE.
; Ends with BRA.W $A666 (back to physics_integration).
;
; Entry: A0 = entity pointer (from collision_avoidance_speed_calc)
; Uses: D0-D3, D6-D7, A1
; ============================================================================

collision_avoidance_no_target:
        dc.w    $43F8        ; $00A6F8  LEA ($9000).W,A1
        dc.w    $9000        ; $00A6FA
        dc.w    $3029        ; $00A6FC  MOVE.W $0030(A1),D0
        dc.w    $0030        ; $00A6FE
        dc.w    $9068        ; $00A700  SUB.W $0030(A0),D0
        dc.w    $0030        ; $00A702
        dc.w    $6A02        ; $00A704  BPL.S +2
        dc.w    $4440        ; $00A706  NEG.W D0
        dc.w    $3E29        ; $00A708  MOVE.W $0034(A1),D7
        dc.w    $0034        ; $00A70A
        dc.w    $9E68        ; $00A70C  SUB.W $0034(A0),D7
        dc.w    $0034        ; $00A70E
        dc.w    $6A02        ; $00A710  BPL.S +2
        dc.w    $4447        ; $00A712  NEG.W D7
        dc.w    $DE40        ; $00A714  ADD.W D0,D7
        dc.w    $3629        ; $00A716  MOVE.W $0072(A1),D3
        dc.w    $0072        ; $00A718
        dc.w    $9668        ; $00A71A  SUB.W $0072(A0),D3
        dc.w    $0072        ; $00A71C
        dc.w    $3C03        ; $00A71E  MOVE.W D3,D6
        dc.w    $6A02        ; $00A720  BPL.S +2
        dc.w    $4446        ; $00A722  NEG.W D6
; --- threshold checks → skip to physics_integration if far away ---
        dc.w    $3029        ; $00A724  MOVE.W $0006(A1),D0
        dc.w    $0006        ; $00A726
        dc.w    $9068        ; $00A728  SUB.W $0006(A0),D0
        dc.w    $0006        ; $00A72A
        dc.w    $6C00        ; $00A72C  BGE.W -$00C8 → $A666
        dc.w    $FF38        ; $00A72E
        dc.w    $0C47        ; $00A730  CMPI.W #$0230,D7
        dc.w    $0230        ; $00A732
        dc.w    $6E00        ; $00A734  BGT.W -$00D0 → $A666
        dc.w    $FF30        ; $00A736
        dc.w    $0C46        ; $00A738  CMPI.W #$0040,D6
        dc.w    $0040        ; $00A73A
        dc.w    $6E00        ; $00A73C  BGT.W -$00D8 → $A666
        dc.w    $FF28        ; $00A73E
; --- braking when close ---
        dc.w    $0C68        ; $00A740  CMPI.W #$0064,$0004(A0)
        dc.w    $0064        ; $00A742
        dc.w    $0004        ; $00A744
        dc.w    $6F54        ; $00A746  BLE.S +$54 → $A79C
        dc.w    $323C        ; $00A748  MOVE.W #$0230,D1
        dc.w    $0230        ; $00A74A
        dc.w    $9247        ; $00A74C  SUB.W D7,D1
        dc.w    $EC41        ; $00A74E  ASR.W #6,D1
        dc.w    $E360        ; $00A750  ROL (see collision_avoidance_speed_calc)
        dc.w    $D168        ; $00A752  ADD.W D0,$0008(A0)
        dc.w    $0008        ; $00A754
        dc.w    $6A04        ; $00A756  BPL.S +4
        dc.w    $4268        ; $00A758  CLR.W $0008(A0)
        dc.w    $0008        ; $00A75A
; --- lateral steering ---
        dc.w    $0C46        ; $00A75C  CMPI.W #$0070,D6
        dc.w    $0070        ; $00A75E
        dc.w    $6C00        ; $00A760  BGE.W +$003A → $A79C
        dc.w    $003A        ; $00A762
        dc.w    $4A40        ; $00A764  TST.W D0
        dc.w    $6F06        ; $00A766  BLE.S +6
        dc.w    $0C47        ; $00A768  CMPI.W #$00F0,D7
        dc.w    $00F0        ; $00A76A
        dc.w    $6E2E        ; $00A76C  BGT.S +$2E → $A79C
        dc.w    $4440        ; $00A76E  NEG.W D0
        dc.w    $E240        ; $00A770  ASR.W #1,D0
        dc.w    $0640        ; $00A772  ADDI.W #$0F00,D0
        dc.w    $0F00        ; $00A774
        dc.w    $3207        ; $00A776  MOVE.W D7,D1
        dc.w    $E941        ; $00A778  ASL.W #4,D1
        dc.w    $B041        ; $00A77A  CMP.W D1,D0
        dc.w    $6E1E        ; $00A77C  BGT.S +$1E → $A79C
        dc.w    $0C46        ; $00A77E  CMPI.W #$0060,D6
        dc.w    $0060        ; $00A780
        dc.w    $6C00        ; $00A782  BGE.W +$0018 → $A79C
        dc.w    $0018        ; $00A784
        dc.w    $7060        ; $00A786  MOVEQ #$60,D0
        dc.w    $9046        ; $00A788  SUB.W D6,D0
        dc.w    $4A43        ; $00A78A  TST.W D3
        dc.w    $6A02        ; $00A78C  BPL.S +2
        dc.w    $4440        ; $00A78E  NEG.W D0
        dc.w    $E740        ; $00A790  ASL.W #3,D0
        dc.w    $3200        ; $00A792  MOVE.W D0,D1
        dc.w    $D241        ; $00A794  ADD.W D1,D1
        dc.w    $D041        ; $00A796  ADD.W D1,D0
        dc.w    $D168        ; $00A798  ADD.W D0,$0040(A0)
        dc.w    $0040        ; $00A79A
; --- return to physics_integration ---
        dc.w    $6000        ; $00A79C  BRA.W -$0138 → $A666
        dc.w    $FEC8        ; $00A79E
