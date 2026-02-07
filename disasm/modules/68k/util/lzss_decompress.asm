; ============================================================================
; LZSS Decompressor
; ROM Range: $0013B4-$001452 (160 bytes)
; ============================================================================
; LZSS/LZ77-variant decompression algorithm.
; Uses a 16-bit flag word to distinguish literal bytes from back-references.
; Supports 8-bit offsets (1-byte header) and 13-bit offsets (2-byte header)
; with variable-length match encoding via bitstream flags.
;
; Entry: A0 = compressed source, A1 = decompression destination
; Uses: D0-D6, A0, A1 (A7 for 2-byte flag buffer)
; Preserves: A2-A6 (except A7 modified then restored)
; ============================================================================

lzss_decompress:
        subq.l  #2,a7                   ; Allocate 2 bytes on stack
        move.b  (a0)+,$0001(a7)         ; Load flag byte (high)
        move.b  (a0)+,(a7)              ; Load flag byte (low)
        move.w  (a7),d5                 ; Read 16-bit flag word
        moveq   #$0F,d4                 ; 16 flags to process
; --- Main flag processing loop ---
.flag_loop:
        lsr.w   #1,d5                   ; Shift out flag bit to carry
        move    sr,d6                   ; Save carry in status register
        dbra    d4,.test_flag            ; Decrement flag counter
        move.b  (a0)+,$0001(a7)         ; Reload flag high byte
        move.b  (a0)+,(a7)              ; Reload flag low byte
        move.w  (a7),d5                 ; Read new flag word
        moveq   #$0F,d4                 ; Reset counter
.test_flag:
        move    d6,ccr                  ; Restore carry flag
        bcc.s   .match_ref              ; Carry clear = back-reference
        move.b  (a0)+,(a1)+             ; Copy literal byte
        bra.s   .flag_loop              ; Next flag
; --- Match reference handler ---
.match_ref:
        moveq   #0,d3                   ; Clear match length
        lsr.w   #1,d5                   ; Shift out length bit 0
        move    sr,d6                   ; Save carry
        dbra    d4,.test_header          ; Check flag count
        move.b  (a0)+,$0001(a7)         ; Reload flags
        move.b  (a0)+,(a7)
        move.w  (a7),d5
        moveq   #$0F,d4
.test_header:
        move    d6,ccr                  ; Restore carry
        bcs.s   .two_byte_header        ; Carry set = 2-byte header
; --- 1-byte match header: read 2 more flag bits for length ---
        lsr.w   #1,d5                   ; Shift out length bit 1
        dbra    d4,.got_bit1
        move.b  (a0)+,$0001(a7)
        move.b  (a0)+,(a7)
        move.w  (a7),d5
        moveq   #$0F,d4
.got_bit1:
        roxl.w  #1,d3                   ; Rotate carry into D3
        lsr.w   #1,d5                   ; Shift out length bit 2
        dbra    d4,.got_bit2
        move.b  (a0)+,$0001(a7)
        move.b  (a0)+,(a7)
        move.w  (a7),d5
        moveq   #$0F,d4
.got_bit2:
        roxl.w  #1,d3                   ; Rotate carry into D3
        addq.w  #1,d3                   ; Match length + 1
        moveq   #-1,d2                  ; Init offset high bits ($FF)
        move.b  (a0)+,d2                ; Read 8-bit back-reference offset
        bra.s   .copy_match             ; Copy match bytes
; --- 2-byte match header ---
.two_byte_header:
        move.b  (a0)+,d0                ; Read byte 1 (offset low)
        move.b  (a0)+,d1                ; Read byte 2 (offset high + length)
        moveq   #-1,d2                  ; Init offset high bits ($FF)
        move.b  d1,d2                   ; Copy length/offset byte
        lsl.w   #5,d2                   ; Shift offset bits to position
        move.b  d0,d2                   ; Merge low offset byte
        andi.w  #$0007,d1               ; Extract 3-bit match length
        beq.s   .extended_length         ; Zero = extended length follows
        move.b  d1,d3                   ; Set match length
        addq.w  #1,d3                   ; Length + 1
; --- Copy match bytes from back-reference ---
.copy_match:
        move.b  0(a1,d2.w),d0           ; Read from back-reference
        move.b  d0,(a1)+                ; Write to output
        dbra    d3,.copy_match           ; Copy loop
        bra.s   .flag_loop              ; Next flag
; --- Extended match length ---
.extended_length:
        move.b  (a0)+,d1                ; Read extended length byte
        beq.s   .done                   ; Zero = end of compressed data
        cmpi.b  #$01,d1                 ; Check for reset marker
        beq.w   .flag_loop              ; 1 = reset (no copy, continue)
        move.b  d1,d3                   ; Set extended length
        bra.s   .copy_match             ; Copy match
; --- End of compressed data ---
.done:
        addq.l  #2,a7                   ; Free stack space
        rts
