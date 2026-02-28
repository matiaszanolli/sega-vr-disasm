; ============================================================================
; Sprite Config Setup 001
; ROM Range: $004200-$004280 (128 bytes)
; ============================================================================
; Category: input
; Purpose: Configures sprite display entries from racer data
;   Looks up sprite graphics pointers from ROM tables
;   Copies position data from work buffers via BSR to next function
;
; Uses: D0, D1, D5, D7, A0, A1, A2, A3
; RAM:
;   $C30C: racer_sprite_id
;   $C254: position_buf_b
;   $C25C: position_stride
;   $C260: position_buf_a
;   $C07C: input_state
; Confidence: medium
; ============================================================================

sprite_config_setup_001:
        and.b   -(A0),D5                        ; $004200  (entry from previous fn)
        moveq   #$07,D7                         ; $004202  D7 = 7 (sprite count)
        moveq   #$00,D0                         ; $004204  D0 = 0
        move.b  ($FFFFC30C).w,D0                ; $004206  D0 = racer_sprite_id
        move.w  D0,D1                           ; $00420A  D1 = D0 (save)
        cmpi.b  #$09,D0                         ; $00420C  D0 > 9?
        ble.s   .single_entry                   ; $004210  no → single table lookup
; --- dual entry: overflow sprite ---
        lea     $00FF6830,A2                    ; $004212  A2 → sprite slot 2
        move.b  D7,$0000(A2)                    ; $004218  slot.count = 7
        move.l  #$222EA436,$0008(A2)            ; $00421C  slot.gfx_ptr = ROM data
        subi.b  #$0A,D0                         ; $004224  D0 -= 10 (adjust index)
.single_entry:
        lea     $00FF6820,A2                    ; $004228  A2 → sprite slot 1
        move.b  D7,$0000(A2)                    ; $00422E  slot.count = 7
        lsl.w   #2,D0                           ; $004232  D0 *= 4 (longword stride)
        lea     $008997C4,A3                    ; $004234  A3 → sprite gfx table A
        move.l  $00(A3,D0.W),$0008(A2)          ; $00423A  slot.gfx_ptr = table[D0]
        lsl.w   #2,D1                           ; $004240  D1 *= 4
        lea     $00FF6810,A2                    ; $004242  A2 → sprite slot 0
        lea     $00899780,A3                    ; $004248  A3 → sprite gfx table B
        move.l  $00(A3,D1.W),$0008(A2)          ; $00424E  slot.gfx_ptr = table[D1]
; --- copy position data ---
        lea     ($FFFFC260).w,A1                ; $004254  A1 → position_buf_a
        lea     $00FF6860,A2                    ; $004258  A2 → sprite pos slot A
        bsr.s   data_unpack_nibbles              ; $00425E  copy position data
        lea     ($FFFFC254).w,A1                ; $004260  A1 → position_buf_b
        lea     $00FF6870,A2                    ; $004264  A2 → sprite pos slot B
        cmpi.l  #$61000000,(A1)                 ; $00426A  buf_b == sentinel?
        beq.s   .advance_state                  ; $004270  yes → skip copy
        bsr.s   data_unpack_nibbles              ; $004272  copy position data
.advance_state:
        move.w  #$0040,($FFFFC25C).w            ; $004274  position_stride = $40
        addq.w  #4,($FFFFC07C).w                ; $00427A  input_state += 4
        rts                                     ; $00427E
