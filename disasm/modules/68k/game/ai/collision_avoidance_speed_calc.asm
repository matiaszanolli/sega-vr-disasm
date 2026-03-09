; ============================================================================
; collision_avoidance_speed_calc — AI Collision Avoidance + Speed Calculation
; ROM Range: $00A470-$00A664 (502 bytes)
; ============================================================================
; AI/physics function that computes entity speed and performs proximity-based
; collision avoidance. Reads entity fields for speed, position, heading, and
; applies graduated steering/braking responses based on distance thresholds.
;
; Structure:
;   $A470-$A4AC: Speed calculation from entity field $24 + table lookup
;   $A4AE-$A4B6: Proximity gate (bit 1 of $55(A0))
;   $A4B8-$A4E8: Target entity lookup via $A4(A0) index
;   $A4EC-$A514: Manhattan distance computation (|dX|+|dY|, dZ)
;   $A514-$A580: Avoidance steering with threshold-based response
;   $A582-$A664: Secondary entity path with different thresholds
;
; Falls through to physics_integration at $A666 (no RTS in this block).
; Alternate no-target path at $A6F8 branches back to $A666.
;
; Entry: A0 = entity pointer, A1 = target entity pointer (from caller)
; Uses: D0-D3, D6-D7, A0-A3
; Called from: counter_guard ($006FFA) via BNE.W
; ============================================================================

collision_avoidance_speed_calc:
        dc.w    $2668        ; $00A470  MOVEA.L $0018(A3),A3
        dc.w    $0018        ; $00A472
        dc.w    $3028        ; $00A474  MOVE.W $0024(A0),D0
        dc.w    $0024        ; $00A476
        dc.w    $3200        ; $00A478  MOVE.W D0,D1
        dc.w    $D040        ; $00A47A  ADD.W D0,D0
        dc.w    $D240        ; $00A47C  ADD.W D0,D1
        dc.w    $D241        ; $00A47E  ADD.W D1,D1
        dc.w    $21F3        ; $00A480  MOVE.L ($0C,A3,D1.W),($A000).W
        dc.w    $100C        ; $00A482
        dc.w    $A000        ; $00A484
        dc.w    $303C        ; $00A486  MOVE.W #$0096,D0  (default speed = 150)
        dc.w    $0096        ; $00A488
        dc.w    $4A68        ; $00A48A  TST.W $006A(A0)
        dc.w    $006A        ; $00A48C
        dc.w    $661A        ; $00A48E  BNE.S +$1A
        dc.w    $3028        ; $00A490  MOVE.W $000A(A0),D0
        dc.w    $000A        ; $00A492
        dc.w    $2278        ; $00A494  MOVEA.L ($C280).W,A1
        dc.w    $C280        ; $00A496
        dc.w    $3428        ; $00A498  MOVE.W $00C2(A0),D2
        dc.w    $00C2        ; $00A49A
        dc.w    $E642        ; $00A49C  ASR.W #3,D2
        dc.w    $3431        ; $00A49E  MOVE.W (A1,D2.W),D2
        dc.w    $2000        ; $00A4A0
        dc.w    $C5F3        ; $00A4A2  MULS.W ($04,A3,D1.W),D2
        dc.w    $1004        ; $00A4A4
        dc.w    $E082        ; $00A4A6  ASR.L #8,D2
        dc.w    $D042        ; $00A4A8  ADD.W D2,D0
        dc.w    $3140        ; $00A4AA  MOVE.W D0,$0008(A0)
        dc.w    $0008        ; $00A4AC
; --- proximity gate ---
        dc.w    $0828        ; $00A4AE  BTST #1,$0055(A0)
        dc.w    $0001        ; $00A4B0
        dc.w    $0055        ; $00A4B2
        dc.w    $6700        ; $00A4B4  BEQ.W +$01B0 → $A666 (physics_integration)
        dc.w    $01B0        ; $00A4B6
; --- target entity lookup ---
        dc.w    $3028        ; $00A4B8  MOVE.W $00A4(A0),D0
        dc.w    $00A4        ; $00A4BA
        dc.w    $6700        ; $00A4BC  BEQ.W +$023A → $A6F8 (no-target path)
        dc.w    $023A        ; $00A4BE
        dc.w    $43F8        ; $00A4C0  LEA ($9000).W,A1
        dc.w    $9000        ; $00A4C2
        dc.w    $E140        ; $00A4C4  ASL.W #8,D0
        dc.w    $43F1        ; $00A4C6  LEA (A1,D0.W),A1
        dc.w    $0000        ; $00A4C8
        dc.w    $4A69        ; $00A4CA  TST.W $00A4(A1)
        dc.w    $00A4        ; $00A4CC
        dc.w    $6700        ; $00A4CE  BEQ.W +$0228 → $A6F8 (no-target path)
        dc.w    $0228        ; $00A4D0
        dc.w    $43F8        ; $00A4D2  LEA ($9000).W,A1
        dc.w    $9000        ; $00A4D4
        dc.w    $3028        ; $00A4D6  MOVE.W $00A6(A0),D0
        dc.w    $00A6        ; $00A4D8
        dc.w    $670A        ; $00A4DA  BEQ.S +$0A
        dc.w    $0C68        ; $00A4DC  CMPI.W #$0082,$0004(A0)
        dc.w    $0082        ; $00A4DE
        dc.w    $0004        ; $00A4E0
        dc.w    $6D00        ; $00A4E2  BLT.W +$0182 → $A666
        dc.w    $0182        ; $00A4E4
        dc.w    $E140        ; $00A4E6  ASL.W #8,D0
        dc.w    $43F1        ; $00A4E8  LEA (A1,D0.W),A1
        dc.w    $0000        ; $00A4EA
; --- distance computation ---
        dc.w    $3029        ; $00A4EC  MOVE.W $0030(A1),D0
        dc.w    $0030        ; $00A4EE
        dc.w    $9068        ; $00A4F0  SUB.W $0030(A0),D0
        dc.w    $0030        ; $00A4F2
        dc.w    $6A02        ; $00A4F4  BPL.S +2
        dc.w    $4440        ; $00A4F6  NEG.W D0
        dc.w    $3E29        ; $00A4F8  MOVE.W $0034(A1),D7
        dc.w    $0034        ; $00A4FA
        dc.w    $9E68        ; $00A4FC  SUB.W $0034(A0),D7
        dc.w    $0034        ; $00A4FE
        dc.w    $6A02        ; $00A500  BPL.S +2
        dc.w    $4447        ; $00A502  NEG.W D7
        dc.w    $DE40        ; $00A504  ADD.W D0,D7   (D7 = |dX| + |dY|)
        dc.w    $3629        ; $00A506  MOVE.W $0072(A1),D3
        dc.w    $0072        ; $00A508
        dc.w    $9668        ; $00A50A  SUB.W $0072(A0),D3
        dc.w    $0072        ; $00A50C
        dc.w    $3C03        ; $00A50E  MOVE.W D3,D6
        dc.w    $6A02        ; $00A510  BPL.S +2
        dc.w    $4446        ; $00A512  NEG.W D6
; --- avoidance steering (threshold-based) ---
        dc.w    $0C47        ; $00A514  CMPI.W #$0140,D7
        dc.w    $0140        ; $00A516
        dc.w    $6C00        ; $00A518  BGE.W +$0068 → $A582
        dc.w    $0068        ; $00A51A
        dc.w    $0C47        ; $00A51C  CMPI.W #$00A0,D7
        dc.w    $00A0        ; $00A51E
        dc.w    $6F0C        ; $00A520  BLE.S +$0C
        dc.w    $3028        ; $00A522  MOVE.W $0004(A0),D0
        dc.w    $0004        ; $00A524
        dc.w    $9069        ; $00A526  SUB.W $0004(A1),D0
        dc.w    $0004        ; $00A528
        dc.w    $6E00        ; $00A52A  BGT.W +$0030 → $A55C
        dc.w    $0030        ; $00A52C
        dc.w    $0C46        ; $00A52E  CMPI.W #$0040,D6
        dc.w    $0040        ; $00A530
        dc.w    $6C28        ; $00A532  BGE.S +$28
        dc.w    $7040        ; $00A534  MOVEQ #$40,D0
        dc.w    $9046        ; $00A536  SUB.W D6,D0
        dc.w    $4A43        ; $00A538  TST.W D3
        dc.w    $6A02        ; $00A53A  BPL.S +2
        dc.w    $4440        ; $00A53C  NEG.W D0
        dc.w    $0C78        ; $00A53E  CMPI.W #$001C,($C07A).W
        dc.w    $001C        ; $00A540
        dc.w    $C07A        ; $00A542
        dc.w    $670A        ; $00A544  BEQ.S +$0A
        dc.w    $D040        ; $00A546  ADD.W D0,D0
        dc.w    $3200        ; $00A548  MOVE.W D0,D1
        dc.w    $D040        ; $00A54A  ADD.W D0,D0
        dc.w    $D041        ; $00A54C  ADD.W D1,D0
        dc.w    $6008        ; $00A54E  BRA.S +8
        dc.w    $E540        ; $00A550  ASL.W #2,D0
        dc.w    $3200        ; $00A552  MOVE.W D0,D1
        dc.w    $E741        ; $00A554  ASL.W #3,D1
        dc.w    $D041        ; $00A556  ADD.W D1,D0
        dc.w    $D168        ; $00A558  ADD.W D0,$0040(A0)
        dc.w    $0040        ; $00A55A
; --- speed avoidance ---
        dc.w    $0C47        ; $00A55C  CMPI.W #$0070,D7
        dc.w    $0070        ; $00A55E
        dc.w    $6C20        ; $00A560  BGE.S +$20
        dc.w    $3029        ; $00A562  MOVE.W $0040(A1),D0
        dc.w    $0040        ; $00A564
        dc.w    $9068        ; $00A566  SUB.W $0040(A0),D0
        dc.w    $0040        ; $00A568
        dc.w    $3200        ; $00A56A  MOVE.W D0,D1
        dc.w    $4A43        ; $00A56C  TST.W D3
        dc.w    $6D02        ; $00A56E  BLT.S +2
        dc.w    $4441        ; $00A570  NEG.W D1
        dc.w    $4A41        ; $00A572  TST.W D1
        dc.w    $6D0C        ; $00A574  BLT.S +$0C
        dc.w    $0C41        ; $00A576  CMPI.W #$1800,D1
        dc.w    $1800        ; $00A578
        dc.w    $6C06        ; $00A57A  BGE.S +6
        dc.w    $E240        ; $00A57C  ASR.W #1,D0
        dc.w    $D168        ; $00A57E  ADD.W D0,$0040(A0)
        dc.w    $0040        ; $00A580
; --- secondary entity path ---
        dc.w    $45F8        ; $00A582  LEA ($9000).W,A2
        dc.w    $9000        ; $00A584
        dc.w    $3028        ; $00A586  MOVE.W $00A4(A0),D0
        dc.w    $00A4        ; $00A588
        dc.w    $E148        ; $00A58A  LSL.W #8,D0
        dc.w    $43F2        ; $00A58C  LEA (A2,D0.W),A1
        dc.w    $0000        ; $00A58E
        dc.w    $3029        ; $00A590  MOVE.W $00A4(A1),D0
        dc.w    $00A4        ; $00A592
        dc.w    $6616        ; $00A594  BNE.S +$16
        dc.w    $E148        ; $00A596  LSL.W #8,D0
        dc.w    $45F2        ; $00A598  LEA (A2,D0.W),A2
        dc.w    $0000        ; $00A59A
        dc.w    $302A        ; $00A59C  MOVE.W $0024(A2),D0
        dc.w    $0024        ; $00A59E
        dc.w    $9069        ; $00A5A0  SUB.W $0024(A1),D0
        dc.w    $0024        ; $00A5A2
        dc.w    $0C40        ; $00A5A4  CMPI.W #$0004,D0
        dc.w    $0004        ; $00A5A6
        dc.w    $6E02        ; $00A5A8  BGT.S +2
        dc.w    $43D2        ; $00A5AA  LEA (A2),A1
        dc.w    $3029        ; $00A5AC  MOVE.W $0030(A1),D0
        dc.w    $0030        ; $00A5AE
        dc.w    $9068        ; $00A5B0  SUB.W $0030(A0),D0
        dc.w    $0030        ; $00A5B2
        dc.w    $6A02        ; $00A5B4  BPL.S +2
        dc.w    $4440        ; $00A5B6  NEG.W D0
        dc.w    $3E29        ; $00A5B8  MOVE.W $0034(A1),D7
        dc.w    $0034        ; $00A5BA
        dc.w    $9E68        ; $00A5BC  SUB.W $0034(A0),D7
        dc.w    $0034        ; $00A5BE
        dc.w    $6A02        ; $00A5C0  BPL.S +2
        dc.w    $4447        ; $00A5C2  NEG.W D7
        dc.w    $DE40        ; $00A5C4  ADD.W D0,D7
        dc.w    $3629        ; $00A5C6  MOVE.W $0072(A1),D3
        dc.w    $0072        ; $00A5C8
        dc.w    $9668        ; $00A5CA  SUB.W $0072(A0),D3
        dc.w    $0072        ; $00A5CC
        dc.w    $3C03        ; $00A5CE  MOVE.W D3,D6
        dc.w    $6A02        ; $00A5D0  BPL.S +2
        dc.w    $4446        ; $00A5D2  NEG.W D6
        dc.w    $3029        ; $00A5D4  MOVE.W $0006(A1),D0
        dc.w    $0006        ; $00A5D6
        dc.w    $9068        ; $00A5D8  SUB.W $0006(A0),D0
        dc.w    $0006        ; $00A5DA
        dc.w    $6C28        ; $00A5DC  BGE.S +$28
        dc.w    $0C47        ; $00A5DE  CMPI.W #$01E0,D7
        dc.w    $01E0        ; $00A5E0
        dc.w    $6E22        ; $00A5E2  BGT.S +$22
        dc.w    $0C47        ; $00A5E4  CMPI.W #$0040,D7
        dc.w    $0040        ; $00A5E6
        dc.w    $6F1C        ; $00A5E8  BLE.S +$1C
        dc.w    $0C46        ; $00A5EA  CMPI.W #$0030,D6
        dc.w    $0030        ; $00A5EC
        dc.w    $6E16        ; $00A5EE  BGT.S +$16
        dc.w    $0C68        ; $00A5F0  CMPI.W #$0064,$0004(A0)
        dc.w    $0064        ; $00A5F2
        dc.w    $0004        ; $00A5F4
        dc.w    $6F0E        ; $00A5F6  BLE.S +$0E
        dc.w    $323C        ; $00A5F8  MOVE.W #$01E0,D1
        dc.w    $01E0        ; $00A5FA
        dc.w    $9247        ; $00A5FC  SUB.W D7,D1
        dc.w    $EC41        ; $00A5FE  ASR.W #6,D1
        dc.w    $E360        ; $00A600  ROL.W (missing dest - encoded as dc.w)
        dc.w    $D168        ; $00A602  ADD.W D0,$0008(A0)
        dc.w    $0008        ; $00A604
        dc.w    $0C46        ; $00A606  CMPI.W #$0070,D6
        dc.w    $0070        ; $00A608
        dc.w    $6C00        ; $00A60A  BGE.W +$0034 → $A640
        dc.w    $0034        ; $00A60C
        dc.w    $4A40        ; $00A60E  TST.W D0
        dc.w    $6F06        ; $00A610  BLE.S +6
        dc.w    $0C47        ; $00A612  CMPI.W #$00A0,D7
        dc.w    $00A0        ; $00A614
        dc.w    $6E28        ; $00A616  BGT.S +$28
        dc.w    $4440        ; $00A618  NEG.W D0
        dc.w    $E240        ; $00A61A  ASR.W #1,D0
        dc.w    $0640        ; $00A61C  ADDI.W #$0A00,D0
        dc.w    $0A00        ; $00A61E
        dc.w    $3207        ; $00A620  MOVE.W D7,D1
        dc.w    $E941        ; $00A622  ASL.W #4,D1
        dc.w    $B041        ; $00A624  CMP.W D1,D0
        dc.w    $6E18        ; $00A626  BGT.S +$18
        dc.w    $0C46        ; $00A628  CMPI.W #$0040,D6
        dc.w    $0040        ; $00A62A
        dc.w    $6C12        ; $00A62C  BGE.S +$12
        dc.w    $7040        ; $00A62E  MOVEQ #$40,D0
        dc.w    $9046        ; $00A630  SUB.W D6,D0
        dc.w    $4A43        ; $00A632  TST.W D3
        dc.w    $6A02        ; $00A634  BPL.S +2
        dc.w    $4440        ; $00A636  NEG.W D0
        dc.w    $D040        ; $00A638  ADD.W D0,D0
        dc.w    $D040        ; $00A63A  ADD.W D0,D0
        dc.w    $D168        ; $00A63C  ADD.W D0,$0040(A0)
        dc.w    $0040        ; $00A63E
; --- heading-based speed avoidance (secondary) ---
        dc.w    $0C47        ; $00A640  CMPI.W #$0070,D7
        dc.w    $0070        ; $00A642
        dc.w    $6C20        ; $00A644  BGE.S +$20
        dc.w    $3029        ; $00A646  MOVE.W $0040(A1),D0
        dc.w    $0040        ; $00A648
        dc.w    $9068        ; $00A64A  SUB.W $0040(A0),D0
        dc.w    $0040        ; $00A64C
        dc.w    $3200        ; $00A64E  MOVE.W D0,D1
        dc.w    $4A43        ; $00A650  TST.W D3
        dc.w    $6D02        ; $00A652  BLT.S +2
        dc.w    $4441        ; $00A654  NEG.W D1
        dc.w    $4A41        ; $00A656  TST.W D1
        dc.w    $6F0C        ; $00A658  BLE.S +$0C
        dc.w    $0C41        ; $00A65A  CMPI.W #$1800,D1
        dc.w    $1800        ; $00A65C
        dc.w    $6C06        ; $00A65E  BGE.S +6
        dc.w    $E240        ; $00A660  ASR.W #1,D0
        dc.w    $D168        ; $00A662  ADD.W D0,$0040(A0)
        dc.w    $0040        ; $00A664
