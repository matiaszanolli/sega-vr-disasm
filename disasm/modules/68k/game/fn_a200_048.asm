; ============================================================================
; Display List Builder
; ROM Range: $00C05C-$00C0F0 (148 bytes)
; ============================================================================
; Category: game
; Purpose: Clears 16 display slots ($FF6800, stride $10), then if
;   display_list_count ($C0FC) is nonzero, reads entries from a ROM offset
;   table and populates slots with sprite data. Scroll_offset ($C0FE)
;   is subtracted from each Y position; entries with negative Y are
;   skipped, positive clamped to $0050. Scroll_offset increments by 8
;   per frame, clamped to $7FFF.
;
; Data table (20 bytes, 5 entries × 4 bytes):
;   +$00: $0402,$C030  $0402,$E030  $0403,$0030  $0403,$2030  $0403,$4030
;
; Uses: D0, D1, D2, D3, A1, A2
; RAM:
;   $C0FC: display_list_count (word, signed; bit 15 = processed flag)
;   $C0FE: scroll_offset (word, clamped to $7FFF)
; ROM tables:
;   $0089ACF0: display_entry_ptr_table (longword pointers indexed by count×4)
; ============================================================================

fn_a200_048:
; --- data table (5 entries × 2 words) ---
        dc.w    $0402,$C030                     ; $00C05C  entry 0
        dc.w    $0402,$E030                     ; $00C060  entry 1
        dc.w    $0403,$0030                     ; $00C064  entry 2
        dc.w    $0403,$2030                     ; $00C068  entry 3
        dc.w    $0403,$4030                     ; $00C06C  entry 4
; --- clear 16 display slots ---
        lea     $00FF6800,A1                    ; $00C070
        moveq   #$10,D1                         ; $00C076  stride = 16
        moveq   #$0F,D0                         ; $00C078  count = 16
.clear_loop:
        clr.w   (A1)                            ; $00C07A  clear slot enable
        adda.w  D1,A1                           ; $00C07C
        dbra    D0,.clear_loop                  ; $00C07E
; --- check display_list_count ---
        move.w  ($FFFFC0FC).w,D2                    ; $00C082  display_list_count
        beq.w   .update_scroll                  ; $00C086  zero → skip to scroll
        bmi.s   .already_processed              ; $00C08A  negative → already done
        clr.w   ($FFFFC0FE).w                       ; $00C08C  reset scroll_offset
        bset    #7,($FFFFC0FC).w                    ; $00C090  set processed flag
.already_processed:
        subq.w  #1,D2                           ; $00C096
        andi.w  #$0007,D2                       ; $00C098  mask to 0-7
        add.w   D2,D2                           ; $00C09C  ×4 (longword index)
        add.w   D2,D2                           ; $00C09E
        lea     $0089ACF0,A2                    ; $00C0A0  display_entry_ptr_table
        movea.l $00(A2,D2.W),A2                 ; $00C0A6  A2 = entry data ptr
; --- populate display slots ---
        lea     $00FF6800,A1                    ; $00C0AA
        move.w  (A2)+,D1                        ; $00C0B0  entry count
.entry_loop:
        move.w  (A2)+,(A1)+                     ; $00C0B2  sprite ID
        move.w  (A2)+,D3                        ; $00C0B4  Y position
        clr.w   (A1)+                           ; $00C0B6  clear field
        move.l  (A2)+,(A1)+                     ; $00C0B8  X pos + params
        move.l  (A2)+,(A1)+                     ; $00C0BA  more params
        clr.l   (A1)+                           ; $00C0BC  clear padding
; --- adjust Y by scroll_offset ---
        sub.w   ($FFFFC0FE).w,D3                    ; $00C0BE
        bmi.s   .skip_entry                     ; $00C0C2  negative → skip
        cmpi.w  #$0050,D3                       ; $00C0C4  clamp to $50
        ble.s   .y_ok                           ; $00C0C8
        move.w  #$0050,D3                       ; $00C0CA
.y_ok:
        add.w   D3,D3                           ; $00C0CE  ×4 (pixel stride)
        add.w   D3,D3                           ; $00C0D0
        ext.l   D3                              ; $00C0D2
        add.l   D3,-$000C(A1)                   ; $00C0D4  add Y offset to slot
.skip_entry:
        dbra    D1,.entry_loop                  ; $00C0D8
; --- update scroll_offset ---
.update_scroll:
        addq.w  #8,($FFFFC0FE).w                   ; $00C0DC  scroll_offset += 8
        cmpi.w  #$7FFF,($FFFFC0FE).w               ; $00C0E0  clamp check
        ble.s   .done                           ; $00C0E6
        move.w  #$7FFF,($FFFFC0FE).w               ; $00C0E8  clamp to max
.done:
        rts                                     ; $00C0EE
