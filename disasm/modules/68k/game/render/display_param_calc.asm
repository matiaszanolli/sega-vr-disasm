; ============================================================================
; Display Parameter Computation (Shift+Multiply, Word Table)
; ROM Range: $00BDFE-$00BE50 (82 bytes)
; ============================================================================
; Category: game
; Purpose: Computes display viewport parameters from word lookup table.
;   D1 (entry index) → table value + $10 → stored to $A0E6.
;   Computes complement ($E0 - value) for paired parameter.
;   Both values shifted left by 9, added to fixed-point base $04024140,
;   stored to A1+$04 and A1+$14. Writes viewport dimensions to
;   $FF60C8 block. Increments display_counter ($A0F0).
;
; Uses: D0, D1, D2, A1, A2
; RAM:
;   $A0E6: display_param (word)
;   $A0F0: display_counter (word)
; Data table (8 words at $BE50):
;   $0000,$0002,$0004,$0008,$000C,$0012,$001A,$0024
; ============================================================================

display_param_calc:
        dc.w    $D241                           ; $00BDFE  add.w d1,d1 — D1 × 2
        move.w  $00BE50(PC,D1.W),D0             ; $00BE00  D0 = table[D1]
        addi.w  #$0010,D0                       ; $00BE04  D0 += 16
        move.w  D0,($FFFFA0E6).w                ; $00BE08  store display_param
        move.w  D0,D2                           ; $00BE0C  D2 = D0
        subi.w  #$0010,D2                       ; $00BE0E  D2 = original table value
        move.w  D2,$0002(A1)                    ; $00BE12  A1+$02 = table value
        move.w  D2,$0012(A1)                    ; $00BE16  A1+$12 = table value
        move.w  #$00E0,D1                       ; $00BE1A  D1 = $E0 (224)
        dc.w    $9240                           ; $00BE1E  sub.w d0,d1 — D1 = $E0 - D0
        lea     $00FF60C8,A2                    ; $00BE20  A2 → viewport block
        move.w  D0,(A2)                         ; $00BE26  viewport width = D0
        move.w  D1,$0002(A2)                    ; $00BE28  viewport height = D1
        subq.w  #1,D0                           ; $00BE2C  D0 -= 1
        moveq   #$09,D2                         ; $00BE2E  D2 = shift count (9)
        ext.l   D0                              ; $00BE30  sign-extend D0
        asl.l   D2,D0                           ; $00BE32  D0 <<= 9 (×512)
        ext.l   D1                              ; $00BE34  sign-extend D1
        asl.l   D2,D1                           ; $00BE36  D1 <<= 9 (×512)
        move.l  #$04024140,D2                   ; $00BE38  D2 = fixed-point base
        dc.w    $D082                           ; $00BE3E  add.l d2,d0 — D0 += base
        dc.w    $D282                           ; $00BE40  add.l d2,d1 — D1 += base
        move.l  D0,$0004(A1)                    ; $00BE42  A1+$04 = scaled width
        move.l  D1,$0014(A1)                    ; $00BE46  A1+$14 = scaled height
        addq.w  #1,($FFFFA0F0).w                ; $00BE4A  display_counter++
        rts                                     ; $00BE4E

