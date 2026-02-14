; ============================================================================
; Animation Sequence Player (3-Word Data Prefix + Frame Loop)
; ROM Range: $00B722-$00B770 (78 bytes)
; ============================================================================
; Category: game
; Purpose: Data prefix: 3 words ($0102,$0304,$0506) — bit test masks.
;   Code: D7-count loop over animation channels. For each: decrements
;   tick counter (A1+1). On expire: reads sequence index (A1+0), loads
;   byte from A2 table[index], computes word offset (index×2), reads
;   value from A3[offset]. If negative: resets index to 1, uses A3+2.
;   Writes value to work buffer A0[byte_offset], increments index.
;
; Uses: D0, D1, D2, D3, D4, D6, D7, A0
; RAM:
;   $8480: work_buffer (word array indexed by byte)
; ============================================================================

animation_seq_player:
; --- data prefix: bit test masks (3 words) ---
        btst    d0,d2                   ; $0102
        btst    d1,d4                   ; $0304
        btst    d2,d6                   ; $0506
; --- code: animation frame loop ---
        dc.w    $0708                           ; $00B728  dc.w $0708 (data or padding)
        dc.w    $0800                           ; $00B72A  dc.w $0800 (data or padding)
        moveq   #$00,D0                         ; $00B72C  clear D0
        moveq   #$00,D1                         ; $00B72E  clear D1
        moveq   #$00,D2                         ; $00B730  clear D2
        lea     ($FFFF8480).w,A0                ; $00B732  A0 → work buffer
.loop_channel:
        subq.b  #1,$01(A1,D0.W)                 ; $00B736  tick_counter--
        bne.s   .next_channel                   ; $00B73A  not zero → next
        movea.l A2,A3                           ; $00B73C  A3 = sequence table base
        adda.w  $00(A2,D0.W),A3                 ; $00B73E  A3 += table[D0] (sequence offset)
        move.b  $00(A1,D0.W),D2                 ; $00B742  D2 = sequence index
        add.w   d2,d2                   ; $D442
        move.b  (A3),D1                         ; $00B748  D1 = byte offset (for A0)
        move.b  $0001(A3),$01(A1,D0.W)          ; $00B74A  reload tick counter
        move.w  $00(A3,D2.W),D3                 ; $00B750  D3 = sequence value
        bpl.s   .write_value                    ; $00B754  positive → write
        move.b  #$01,$00(A1,D0.W)               ; $00B756  reset index to 1
        move.w  $0002(A3),D3                    ; $00B75C  use fallback value
.write_value:
        move.w  D3,$00(A0,D1.W)                 ; $00B760  write to buffer[byte_offset]
        addq.b  #1,$00(A1,D0.W)                 ; $00B764  sequence index++
.next_channel:
        addq.b  #2,D0                           ; $00B768  D0 += 2 (next channel)
        dbra    D7,.loop_channel                ; $00B76A  loop D7+1 times
        rts                                     ; $00B76E

