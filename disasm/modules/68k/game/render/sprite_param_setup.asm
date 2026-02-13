; ============================================================================
; Sprite Parameter Setup (Two Sprite Blocks)
; ROM Range: $00397C-$0039EC (112 bytes)
; ============================================================================
; Category: game
; Purpose: Initializes sprite block A at $FF65D8: advances sprite_counter
;   ($C8E2) by $1E, masks to 13 bits, writes to +$20 (rotation angle).
;   Calls sprite_param_calc ($0038C0) with D1=$0C80, D3=$1400.
;   If block A enabled (nonzero): initializes sprite block B at $FF65C4
;   with parameters from data table at ROM $3A76 (position, size, tile
;   pattern $222A218E).
;
; Uses: D0, D1, D3, A1, A2
; RAM:
;   $C8E2: sprite_counter (word, +=$1E each call)
; Calls:
;   $0038C0: sprite_param_calc
; ============================================================================

sprite_param_setup:
        lea     $00883A80,A1                    ; $00397C  A1 → sprite data table A
        lea     $00FF65D8,A2                    ; $003982  A2 → sprite block A
        addi.w  #$001E,($FFFFC8E2).w            ; $003988  sprite_counter += 30
        move.w  #$0C80,D1                       ; $00398E  D1 = X param
        move.w  #$1400,D3                       ; $003992  D3 = Y param
        move.w  #$0000,$0000(A2)                ; $003996  clear enable flag
        move.w  #$0000,$0014(A2)                ; $00399C  clear field +$14
        move.w  ($FFFFC8E2).w,D0                ; $0039A2  D0 = sprite_counter
        andi.w  #$1FFF,D0                       ; $0039A6  mask to 13 bits
        move.w  D0,$0020(A2)                    ; $0039AA  set rotation angle
        dc.w    $4EBA,$FF10                     ; $0039AE  jsr $0038C0(pc) — sprite_param_calc
; --- sprite block B at $FF65C4 ---
        lea     $00FF65C4,A2                    ; $0039B2  A2 → sprite block B
        move.w  #$0000,$0000(A2)                ; $0039B8  clear enable flag
        tst.w   $00FF65D8                       ; $0039BE  block A enabled?
        beq.s   .done                           ; $0039C4  no → done
        lea     $00883A76,A1                    ; $0039C6  A1 → sprite data table B
        move.w  #$0001,$0000(A2)                ; $0039CC  enable block B
        move.l  (A1)+,$0002(A2)                 ; $0039D2  copy position (long)
        move.w  (A1)+,$0006(A2)                 ; $0039D6  copy size X
        move.w  (A1)+,$000A(A2)                 ; $0039DA  copy size Y
        move.w  (A1),$000E(A2)                  ; $0039DE  copy param
        move.l  #$222A218E,$0010(A2)            ; $0039E2  set tile pattern
.done:
        rts                                     ; $0039EA

