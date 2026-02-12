; ============================================================================
; Object Movement Velocity Computation
; ROM Range: $007EB2-$007EFC (74 bytes)
; ============================================================================
; Category: game
; Purpose: Computes per-frame velocity for position interpolation.
;   Copies $C090 → $C07A, stores D1 → $C02C. Indexes table via
;   table_ptr ($C700) at D0×4, computes X/Y/heading velocity as
;   (target - current) / frames_remaining (D1). Stores results
;   in A0+$4E (X vel), A0+$50 (Y vel), A0+$52 (heading vel).
;
; Uses: D0, D1, D2, D3, A0, A1
; RAM:
;   $C02C: frame_count (word)
;   $C07A: source copy (word, from $C090)
;   $C090: source param (word)
;   $C700: table_ptr (longword, word-pair table)
; Object (A0):
;   +$1E: heading (word)
;   +$30: x_position (word)
;   +$34: y_position (word)
;   +$3C: heading_mirror (word)
;   +$4E: x_velocity (word)
;   +$50: y_velocity (word)
;   +$52: heading_velocity (word)
; ============================================================================

fn_6200_060:
        move.w  ($FFFFC090).w,($FFFFC07A).w     ; $007EB2  copy source → index
        move.w  D1,($FFFFC02C).w                ; $007EB8  store frame count
        dc.w    $D040                           ; $007EBC  add.w d0,d0 — D0 × 2
        move.w  D0,D2                           ; $007EBE  D2 = D0
        dc.w    $D442                           ; $007EC0  add.w d2,d2 — D2 × 4 (D0 × 4)
        movea.l ($FFFFC700).w,A1                ; $007EC2  A1 → position table
        move.w  $00(A1,D2.W),D3                 ; $007EC6  D3 = target X
        sub.w   $0030(A0),D3                    ; $007ECA  D3 -= current X
        ext.l   D3                              ; $007ECE  sign-extend
        divs    D1,D3                           ; $007ED0  D3 /= frames
        addq.w  #1,D3                           ; $007ED2  round up
        move.w  D3,$004E(A0)                    ; $007ED4  store X velocity
        move.w  $02(A1,D2.W),D3                 ; $007ED8  D3 = target Y
        sub.w   $0034(A0),D3                    ; $007EDC  D3 -= current Y
        ext.l   D3                              ; $007EE0  sign-extend
        divs    D1,D3                           ; $007EE2  D3 /= frames
        addq.w  #1,D3                           ; $007EE4  round up
        move.w  D3,$0050(A0)                    ; $007EE6  store Y velocity
        move.w  $001E(A0),D0                    ; $007EEA  D0 = heading
        sub.w   $003C(A0),D0                    ; $007EEE  D0 -= heading_mirror
        ext.l   D0                              ; $007EF2  sign-extend
        divs    D1,D0                           ; $007EF4  D0 /= frames
        move.w  D0,$0052(A0)                    ; $007EF6  store heading velocity
        rts                                     ; $007EFA

