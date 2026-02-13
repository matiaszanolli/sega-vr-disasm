; ============================================================================
; object_visibility_collector — Object Visibility Collector
; ROM Range: $0071A6-$007248 (162 bytes)
; ============================================================================
; Computes a camera direction key from an object's own x/y positions
; (+$30/+$34) and collects visible geometry entries into a buffer at
; $FF6000. Similar to object_geometry_visibility_collect but uses object-relative coordinates
; instead of 32X frame registers.
;
; Special case: when race_state == 4 and object+$1D is in range [$88,$98],
; uses alternate geometry table at $0089A434 instead of default $0089A0D4.
;
; Sentinel value $2207FFFE marks empty geometry slots.
;
; Entry: A0 = object pointer (+$30=x_pos, +$34=y_pos, +$CA=cam_key,
;            +$CC=table_index, +$1D=type_field)
; Uses: D0, D1, D2, D3, D4, D7, A0, A1, A2, A3, A4
; RAM: $C8A0 (race_state)
; ============================================================================

object_visibility_collector:
        move.l  A4,-(A7)                        ; $0071A6  save A4
        move.w  #$0400,D1                       ; $0071A8  direction key base
        move.w  $0030(A0),D2                    ; $0071AC  D2 = x_position
        asr.w   #4,D2                           ; $0071B0
        dc.w    $D441                ; add.w   D1,D2  ; D2 += base
        asr.w   #6,D2                           ; $0071B4
        move.w  $0034(A0),D3                    ; $0071B6  D3 = y_position
        asr.w   #4,D3                           ; $0071BA
        dc.w    $9243                ; sub.w   D3,D1  ; D1 -= D3
        andi.w  #$FFC0,D1                       ; $0071BE  align to 64-byte boundary
        asr.w   #1,D1                           ; $0071C2
        dc.w    $D242                ; add.w   D2,D1  ; merge x component
        dc.w    $D241                ; add.w   D1,D1  ; D1 *= 2
        dc.w    $D241                ; add.w   D1,D1  ; D1 *= 4 (longword index)
        move.w  D1,$00CA(A0)                    ; $0071CA  store camera direction key
        moveq   #$00,D0                         ; $0071CE
        move.w  $00CC(A0),D0                    ; $0071D0  geometry table selector
        asl.l   #6,D0                           ; $0071D4
        swap    D0                              ; $0071D6
        andi.w  #$003C,D0                       ; $0071D8  index into table (0-15 × 4)
        lea     $0089A0D4,A3                    ; $0071DC  default geometry table
        move.w  ($FFFFC8A0).w,D2                ; $0071E2  race_state
        cmpi.w  #$0004,D2                       ; $0071E6
        bne.s   .load_geometry                  ; $0071EA
        cmpi.b  #$88,$001D(A0)                  ; $0071EC  check object type field
        blt.s   .load_geometry                  ; $0071F2
        cmpi.b  #$98,$001D(A0)                  ; $0071F4
        bgt.s   .load_geometry                  ; $0071FA
        lea     $0089A434,A3                    ; $0071FC  alternate table for state 4
.load_geometry:
        movea.l $00(A3,D0.W),A3                 ; $007202  geometry data pointer
        move.l  #$2207FFFE,D3                   ; $007206  sentinel value
        dc.w    $43FA,$003A         ; lea     $007248(pc),A1  ; pointer table (after function)
        movea.l $00(A1,D2.W),A1                 ; $007210  table[race_state]
        lea     $00FF6000,A2                    ; $007214  output buffer
        moveq   #$00,D4                         ; $00721A  visible count = 0
        movea.l $00(A1,D1.W),A4                 ; $00721C  first geometry entry
        cmpa.l  D3,A4                           ; $007220  sentinel?
        beq.s   .scan_neighbors                 ; $007222
        move.l  A4,(A2)+                        ; $007224  store visible entry
        addq.w  #1,D4                           ; $007226  count++
.scan_neighbors:
        move.w  (A3)+,D7                        ; $007228  neighbor count
.neighbor_loop:
        move.w  D1,D0                           ; $00722A
        add.w   (A3)+,D0                        ; $00722C  key + neighbor offset
        movea.l $00(A1,D0.W),A4                 ; $00722E  geometry entry
        cmpa.l  D3,A4                           ; $007232  sentinel?
        beq.s   .skip_entry                     ; $007234
        move.l  A4,(A2)+                        ; $007236  store visible
        addq.w  #1,D4                           ; $007238  count++
.skip_entry:
        dbra    D7,.neighbor_loop               ; $00723A
        move.w  D4,$00FF610E                    ; $00723E  store visible count
        movea.l (A7)+,A4                        ; $007244  restore A4
        rts                                     ; $007246
