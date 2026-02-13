; ============================================================================
; Display Digit Extract (Multi-Entry)
; ROM Range: $00B4CA-$00B55A (144 bytes)
; ============================================================================
; Multiple entry points for extracting BCD/display digits from
; various game values. Each path looks up a digit pair from a ROM
; table at $00899884 (indexed by value×2), then splits into high
; and low nibbles for display buffer output.
;
; Entry 1 ($00B4CA): copy scroll data + JMP to copy routine
; Entry 2 ($00B4DC): scroll_state → digit pair → display
; Entry 3a ($00B4F8): H-scroll value → digit pair → display
; Entry 3b ($00B504): V-scroll value → digit pair → display
; Entry 4 ($00B522): track sector → name + digit pair → display
;
; Uses: D0, D1, A0, A1, A2
; RAM:
;   $9004: vscroll_lookup
;   $9F04: hscroll_lookup
;   $C050: scroll_state
;   $C200: game_data (source for copy)
;   $C254: camera_scroll
;   $C30C: track_sector
;   $EEDC: display_buf_copy_dest
;   $EEFC: camera_scroll_display
; Calls:
;   $004920: data_copy (JMP PC-relative)
; ============================================================================

display_digit_extract:
; --- entry 1: copy scroll data ---
        move.l  ($FFFFC254).w,($FFFFEEFC).w     ; copy camera_scroll → display
        lea     ($FFFFC200).w,a1                ; game_data source
        lea     ($FFFFEEE0).w,a2                ; display buffer dest
        dc.w    $4EFA,$9446                      ; jmp data_copy(pc) → $004920
; --- entry 2: scroll_state → digit pair ---
        move.w  ($FFFFC050).w,d0                ; scroll_state
        bpl.s   .positive
        moveq   #$00,d0                         ; clamp negative to 0
.positive:
        add.w   d0,d0                            ; ×2 for word index
        lea     $00899884,a0                    ; digit lookup table (ROM)
        move.w  $00(a0,d0.w),d0                 ; read digit pair
        lea     $00FF68BA,a1                    ; display buffer
        bra.s   .split_digits
; --- entry 3a: H-scroll → digit pair ---
        lea     $00FF6908,a1                    ; H-display buffer
        move.w  ($FFFF9F04).w,d0                ; hscroll_lookup value
        bra.s   .lookup
; --- entry 3b: V-scroll → digit pair ---
        lea     $00FF68C8,a1                    ; V-display buffer
        move.w  ($FFFF9004).w,d0                ; vscroll_lookup value
.lookup:
        add.w   d0,d0                            ; ×2 for word index
        lea     $00899884,a0                    ; digit lookup table (ROM)
        move.w  $00(a0,d0.w),d0                 ; read digit pair
        move.w  d0,d1
        lsr.w   #8,d1                           ; high byte = tens digit
        move.w  d1,(a1)+                        ; store tens digit
        bra.s   .split_digits
; --- entry 4: track sector → name + digit pair ---
        moveq   #$00,d0
        move.b  ($FFFFC30C).w,d0                ; track_sector
        add.w   d0,d0                            ; ×2
        move.w  d0,d1                           ; save ×2
        add.w   d0,d0                            ; ×4 for longword index
        lea     $00898C24,a0                    ; sector name table (ROM)
        move.l  $00(a0,d0.w),$00FF68A8          ; copy sector name to display
        lea     $00899884,a0                    ; digit lookup table (ROM)
        move.w  $00(a0,d1.w),d0                 ; read digit pair (×2 index)
        lea     $00FF689A,a1                    ; sector display buffer
; --- shared: split digit pair into high/low nibble ---
.split_digits:
        move.b  d0,d1                           ; low byte
        lsr.b   #4,d1                           ; extract high nibble
        move.b  d1,(a1)+                        ; store high digit
        andi.b  #$0F,d0                         ; extract low nibble
        move.b  d0,(a1)                         ; store low digit
        rts
