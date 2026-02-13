; ============================================================================
; Camera SH2 Command 27 Dispatch (Data Prefix)
; ROM Range: $012F56-$012F9C (70 bytes)
; ============================================================================
; Category: game
; Purpose: Data prefix (28 bytes, 7 longword pointers referenced elsewhere) +
;   SH2 command dispatch. Reads camera mode index from $A019,
;   computes ×6 table lookup into command table at $892F9C.
;   Loads source pointer and size param, calls sh2_cmd_27
;   with height=$48, width=$10.
;
; Uses: D0, D1, D2
; RAM:
;   $A019: camera mode index (byte)
; Calls:
;   $00E3B4: sh2_cmd_27
; ============================================================================

camera_sh2_command_27_dispatch:
; --- data prefix (28 bytes, 7 longword pointers) ---
        dc.w    $0088                           ; $012F56  ptr[0] high
        dc.w    $E5CE                           ; $012F58  ptr[0] low → $0088E5CE
        dc.w    $0088                           ; $012F5A  ptr[1] high
        dc.w    $E5FE                           ; $012F5C  ptr[1] low → $0088E5FE
        dc.w    $0088                           ; $012F5E  ptr[2] high
        dc.w    $F13C                           ; $012F60  ptr[2] low → $0088F13C
        dc.w    $0089                           ; $012F62  ptr[3] high
        dc.w    $1D0A                           ; $012F64  ptr[3] low → $00891D0A
        dc.w    $0089                           ; $012F66  ptr[4] high
        movea.w (A4),A0                         ; $012F68  ptr[4] low (raw: $3054 → $00893054)
        dc.w    $0088                           ; $012F6A  ptr[5] high
        roxl.w  -(A6)                           ; $012F6C  ptr[5] low (raw: $E5E6 → $0088E5E6)
        dc.w    $0089                           ; $012F6E  ptr[6] high
        move.l  (A2),(A3)+                      ; $012F70  ptr[6] low (raw: $26D2 → $008926D2)
; --- executable code ---
        moveq   #$00,D0                         ; $012F72  clear D0
        move.b  ($FFFFA019).w,D0                ; $012F74  D0 = camera mode index
        lea     $00892F9C,A1                    ; $012F78  A1 = command table base
        dc.w    $D040                           ; $012F7E  add.w d0,d0 — D0 × 2
        move.w  D0,D1                           ; $012F80  D1 = D0 × 2 (save)
        dc.w    $D040                           ; $012F82  add.w d0,d0 — D0 × 4
        dc.w    $D041                           ; $012F84  add.w d1,d0 — D0 × 6
        movea.l $00(A1,D0.W),A0                 ; $012F86  A0 = table[mode].source
        move.w  $04(A1,D0.W),D0                 ; $012F8A  D0 = table[mode].size
        move.w  #$0048,D1                       ; $012F8E  D1 = $48 (height)
        move.w  #$0010,D2                       ; $012F92  D2 = $10 (width)
        dc.w    $4EBA,$B41C                     ; $012F96  bsr.w sh2_cmd_27 ($00E3B4)
        rts                                     ; $012F9A
