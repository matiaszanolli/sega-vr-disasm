; ============================================================================
; VDP Sprite Pointer Setup + Conditional Display Clear
; ROM Range: $003CCE-$003D22 (84 bytes)
; ============================================================================
; Category: game
; Purpose: Sets up 4 sprite block pointers at $FF66EC (stride $14)
;   from ROM pointer table at $00895B7E, indexed by D0 × 16.
;   If race_phase ($C026) is in range [7,19): clears enable fields
;   at $FF6128 (+$00, +$14, and conditionally +$28, +$3C) based on
;   $C04C and boost_flag ($C8C8).
;
; Uses: D0, D1, A1, A2, A3
; RAM:
;   $C026: race_phase (word)
;   $C04C: display_enable (word)
;   $C8C8: boost_flag (word)
; ============================================================================

fn_2200_066:
        lea     $00FF66EC,A1                    ; $003CCE  A1 → sprite block ptrs
        lea     $00895B7E,A2                    ; $003CD4  A2 → ROM pointer table
        asl.w   #4,D0                           ; $003CDA  D0 × 16
        moveq   #$03,D1                         ; $003CDC  D1 = 3 (4 iterations)
.copy_ptrs:
        movea.l (A2)+,A3                        ; $003CDE  A3 = table[i]
        adda.l  D0,A3                           ; $003CE0  A3 += offset
        move.l  A3,(A1)                         ; $003CE2  store ptr
        lea     $0014(A1),A1                    ; $003CE4  A1 += $14 (next block)
        dbra    D1,.copy_ptrs                   ; $003CE8  loop
        move.w  ($FFFFC026).w,D1                ; $003CEC  D1 = race_phase
        cmpi.w  #$0007,D1                       ; $003CF0  phase < 7?
        dc.w    $6D2C                           ; $003CF4  blt.s $003D22 — yes → done
        cmpi.w  #$0013,D1                       ; $003CF6  phase >= 19?
        dc.w    $6C26                           ; $003CFA  bge.s $003D22 — yes → done
; --- clear display enable fields ---
        moveq   #$00,D0                         ; $003CFC  D0 = 0
        lea     $00FF6128,A1                    ; $003CFE  A1 → display block
        move.w  D0,$0000(A1)                    ; $003D04  clear +$00
        move.w  D0,$0014(A1)                    ; $003D08  clear +$14
        tst.w   ($FFFFC04C).w                   ; $003D0C  display_enable set?
        bne.s   .done                           ; $003D10  yes → keep remaining
        move.w  D0,$0028(A1)                    ; $003D12  clear +$28
        tst.w   ($FFFFC8C8).w                   ; $003D16  boost active?
        bne.s   .done                           ; $003D1A  yes → keep +$3C
        move.w  D0,$003C(A1)                    ; $003D1C  clear +$3C
.done:
        rts                                     ; $003D20

