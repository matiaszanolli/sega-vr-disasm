; ============================================================================
; AI Buffer Setup (4 Entry Points)
; ROM Range: $00B11A-$00B15E (68 bytes)
; ============================================================================
; Category: game
; Purpose: Four entry points that set up A1 (buffer), A2 (RAM pointer),
;   and D3 (parameter), then branch to shared handler at $00B15E.
;   Entry 1 ($00B11A): A1→$FF68D9, A2→$C806, D3=0
;   Entry 2 ($00B128): A1→$FF68D9, A2→$C806, D3=0
;   Entry 3 ($00B136): A1→$FF6959, A2→$C813, D3=0
;   Entry 4 ($00B144): A1→$FF68D9, A2→$C806, D3=($902C).w,
;     but checks $C30E bits 0+5 first — if clear → continue, else RTS.
;
; Uses: D0, D3, A1, A2
; RAM:
;   $C806: AI control block A (via LEA)
;   $C813: AI control block B (via LEA)
;   $C30E: button/control flags (byte, bits 0/5)
;   $902C: AI parameter (word)
; ============================================================================

fn_a200_005:
; --- entry 1: standard setup A ---
        lea     $00FF68D9,A1                    ; $00B11A  A1 → buffer A
        lea     ($FFFFC806).w,A2                ; $00B120  A2 → AI control A
        moveq   #$00,D3                         ; $00B124  D3 = 0
        dc.w    $6036                           ; $00B126  bra.s $00B15E → shared handler
; --- entry 2: standard setup A (duplicate) ---
        lea     $00FF68D9,A1                    ; $00B128  A1 → buffer A
        lea     ($FFFFC806).w,A2                ; $00B12E  A2 → AI control A
        moveq   #$00,D3                         ; $00B132  D3 = 0
        dc.w    $6028                           ; $00B134  bra.s $00B15E → shared handler
; --- entry 3: alternate setup B ---
        lea     $00FF6959,A1                    ; $00B136  A1 → buffer B
        lea     ($FFFFC813).w,A2                ; $00B13C  A2 → AI control B
        moveq   #$00,D3                         ; $00B140  D3 = 0
        dc.w    $601A                           ; $00B142  bra.s $00B15E → shared handler
; --- entry 4: conditional setup with param ---
        lea     $00FF68D9,A1                    ; $00B144  A1 → buffer A
        lea     ($FFFFC806).w,A2                ; $00B14A  A2 → AI control A
        move.w  ($FFFF902C).w,D3               ; $00B14E  D3 = AI parameter
        move.b  ($FFFFC30E).w,D0               ; $00B152  D0 = control flags
        andi.b  #$21,D0                         ; $00B156  mask bits 0 + 5
        dc.w    $6702                           ; $00B15A  beq.s $00B15E → shared handler
        rts                                     ; $00B15C  flags set → early exit
