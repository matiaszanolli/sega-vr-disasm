; ============================================================================
; Race Parameter Block Load + Table Pointer Setup
; ROM Range: $00A050-$00A0B4 (100 bytes)
; ============================================================================
; Category: game
; Purpose: Loads 15 parameter words + 1 longword from data table at
;   $00898824 into RAM block $C278..$C0FA. Sets work pointer $C27C
;   = $0093925E. Computes per-race table pointer:
;   D1 = $C8A0 (race_state) × 2, D0 = $C8C8 × $30 (48-byte stride),
;   $C280 = address of $00A0B4 + D1 + D0.
;
; Uses: D0, D1, A1
; RAM:
;   $C0E6-$C0FA: parameter block (14 words: $C0E6..$C0FA)
;   $C278: work param (long, from table)
;   $C27C: work pointer (long, set to $0093925E)
;   $C280: per-race table pointer (long)
;   $C8A0: race_state (word)
;   $C8C8: boost flag (word, used as multiplier)
;   $C8CE-$C8D2: work params (3 words, from table)
; ============================================================================

race_param_block_load_table_pointer_setup:
        lea     $00898824,A1                    ; $00A050  A1 → parameter table
        move.l  (A1)+,($FFFFC278).w           ; $00A056  work param (long)
        move.w  (A1)+,($FFFFC0E6).w           ; $00A05A  param[0]
        move.w  (A1)+,($FFFFC0E8).w           ; $00A05E  param[1]
        move.w  (A1)+,($FFFFC0EA).w           ; $00A062  param[2]
        move.w  (A1)+,($FFFFC0EC).w           ; $00A066  param[3]
        move.w  (A1)+,($FFFFC0EE).w           ; $00A06A  param[4]
        move.w  (A1)+,($FFFFC0F0).w           ; $00A06E  param[5]
        move.w  (A1)+,($FFFFC0F2).w           ; $00A072  param[6]
        move.w  (A1)+,($FFFFC0F4).w           ; $00A076  param[7]
        move.w  (A1)+,($FFFFC0F6).w           ; $00A07A  param[8]
        move.w  (A1)+,($FFFFC8CE).w           ; $00A07E  work param A
        move.w  (A1)+,($FFFFC8D0).w           ; $00A082  work param B
        move.w  (A1)+,($FFFFC8D2).w           ; $00A086  work param C
        move.w  (A1)+,($FFFFC0F8).w           ; $00A08A  param[9]
        move.w  (A1)+,($FFFFC0FA).w           ; $00A08E  param[10]
        move.l  #$0093925E,($FFFFC27C).w      ; $00A092  work pointer = $0093925E
        move.w  ($FFFFC8A0).w,D1              ; $00A09A  D1 = race_state
        dc.w    $D241                           ; $00A09E  add.w d1,d1 — D1 × 2
        move.w  ($FFFFC8C8).w,D0              ; $00A0A0  D0 = boost flag
        muls    #$0030,D0                       ; $00A0A4  D0 × 48 (stride)
        dc.w    $D240                           ; $00A0A8  add.w d0,d0 — D0 × 2 (??? or add.w d0,d1)
        lea     $00A0B4(PC,D1.W),A1           ; $00A0AA  A1 = base + race offset
        move.l  A1,($FFFFC280).w              ; $00A0AE  store table pointer
        rts                                     ; $00A0B2
