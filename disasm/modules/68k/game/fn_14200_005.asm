; ============================================================================
; Menu Item Address Table + VDP Register Clear
; ROM Range: $01462A-$014696 (108 bytes)
; ============================================================================
; Category: game
; Purpose: Data prefix: 16-entry longword table of menu item data
;   addresses ($0090E732..$009286AE in ROM data segment).
;   Code: sets D0 = 0, writes to $C80D and 6 VDP tile registers
;   at $FF6870/$FF68A0/$FF6820/$FF6850/$FF6830/$FF68B0 (clear all).
;
; Uses: D0
; RAM:
;   $C80D: menu state flag (byte, cleared)
; ============================================================================

fn_14200_005:
; --- data prefix: 16-entry longword jump table (menu item addresses) ---
        dc.l    $0090E732                       ; $01462A  [0] menu item 0
        dc.l    $0090FD28                       ; $01462E  [1] menu item 1
        dc.l    $00911BCA                       ; $014632  [2] menu item 2
        dc.l    $00913DA6                       ; $014636  [3] menu item 3
        dc.l    $00915FE0                       ; $01463A  [4] menu item 4
        dc.l    $00918190                       ; $01463E  [5] menu item 5
        dc.l    $0091A1D8                       ; $014642  [6] menu item 6
        dc.l    $0091C2FE                       ; $014646  [7] menu item 7
        dc.l    $0091E21A                       ; $01464A  [8] menu item 8
        dc.l    $0091FD76                       ; $01464E  [9] menu item 9
        dc.l    $00921662                       ; $014652  [A] menu item 10
        dc.l    $00922DD4                       ; $014656  [B] menu item 11
        dc.l    $009244C0                       ; $01465A  [C] menu item 12
        dc.l    $00925AEA                       ; $01465E  [D] menu item 13
        dc.l    $009270C6                       ; $014662  [E] menu item 14
        dc.l    $009286AE                       ; $014666  [F] menu item 15
; --- code ---
        moveq   #$00,D0                         ; $01466A  D0 = 0
        move.b  D0,($FFFFC80D).w               ; $01466C  clear menu state flag
        move.b  D0,$00FF6870                   ; $014670  clear VDP tile reg A
        move.b  D0,$00FF68A0                   ; $014676  clear VDP tile reg B
        move.b  D0,$00FF6820                   ; $01467C  clear VDP tile reg C
        move.b  D0,$00FF6850                   ; $014682  clear VDP tile reg D
        move.b  D0,$00FF6830                   ; $014688  clear VDP tile reg E
        move.b  D0,$00FF68B0                   ; $01468E  clear VDP tile reg F
        rts                                     ; $014694
