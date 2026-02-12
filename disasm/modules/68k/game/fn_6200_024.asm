; ============================================================================
; Object Link Copy + Table Lookup
; ROM Range: $00714A-$0071A6 (92 bytes)
; ============================================================================
; Category: game
; Purpose: Follows object link (A0+$CE → A1), copies type byte A1+$1B
;   to A0+$1D. Looks up byte from table_ptr_A ($C704)[type] → A0+$25.
;   Computes index D0×4 via table_ptr_B ($C700), copies word pair
;   to A0+$20/$22. Extracts heading high byte from A1+$1A → A0+$1E.
;   Copies A1+$19 → A0+$E5, sets A0+$E4 = 1 if A0+$E5 bit 0 set.
;
; Uses: D0, D1, A0, A1, A2
; RAM:
;   $C700: table_ptr_B (longword, word-pair table)
;   $C704: table_ptr_A (longword, byte table)
; Object (A0):
;   +$1D: type copy (byte)
;   +$1E: heading (word, from A1+$1A high byte)
;   +$20: position X (word, from table)
;   +$22: position Y (word, from table)
;   +$25: table value (byte)
;   +$27: prev table value (byte)
;   +$CE: link pointer (longword → A1)
;   +$E4: flip flag (byte, 0 or 1)
;   +$E5: type flags (byte, from A1+$19)
; ============================================================================

fn_6200_024:
        moveq   #$00,D0                         ; $00714A  clear D0
        movea.l $00CE(A0),A1                    ; $00714C  A1 = linked object
        move.b  $001B(A1),D0                    ; $007150  D0 = type index
        move.b  D0,$001D(A0)                    ; $007154  store type copy
        move.b  $0025(A0),$0027(A0)             ; $007158  save prev table value
        movea.l ($FFFFC704).w,A2                ; $00715E  A2 → byte table
        move.b  $00(A2,D0.W),D1                 ; $007162  D1 = table_A[type]
        move.b  D1,$0025(A0)                    ; $007166  store table value
        movea.l ($FFFFC700).w,A2                ; $00716A  A2 → word-pair table
        dc.w    $D040                           ; $00716E  add.w d0,d0 — D0 × 2
        dc.w    $D040                           ; $007170  add.w d0,d0 — D0 × 4
        move.w  $00(A2,D0.W),$0020(A0)          ; $007172  position X = table[D0]
        move.w  $02(A2,D0.W),$0022(A0)          ; $007178  position Y = table[D0+2]
        move.w  $001A(A1),D1                    ; $00717E  D1 = direction word
        andi.w  #$FF00,D1                       ; $007182  keep high byte only
        move.w  D1,$001E(A0)                    ; $007186  store heading
        move.b  $0019(A1),$00E5(A0)             ; $00718A  copy type flags
        move.b  #$00,$00E4(A0)                  ; $007190  clear flip flag
        btst    #0,$00E5(A0)                    ; $007196  bit 0 set?
        beq.s   .done                           ; $00719C  no → done
        move.b  #$01,$00E4(A0)                  ; $00719E  set flip flag
.done:
        rts                                     ; $0071A4

