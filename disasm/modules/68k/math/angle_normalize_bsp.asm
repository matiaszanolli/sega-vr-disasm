; ============================================================================
; Angle Normalize and BSP Visibility Test
; ROM Range: $00748C-$0075C6 (316 bytes)
; ============================================================================
; Normalizes viewing angles to a 512-step rotation system and performs
; BSP-style visibility testing for polygon culling.
;
; Two entry points:
;   angle_normalize: checks visibility flag first, has outer D7 loop
;   angle_normalize_alt: skips flag check, single-pass BSP test
;
; Angle system: 512 steps per full rotation, +$4000 offset,
; $01FF mask, x2 for word indexing, sign-extended to long.
;
; BSP traversal: reads plane selector words, tests 4 bits per word
; to determine comparison path (coefficient multiply vs direct compare),
; then branches based on signed comparison result.
;
; Entry: D1 = viewing angle 1, D2 = viewing angle 2, A1 = BSP data ptr
; Returns: D0 = 1 if visible, 0 if culled
; Uses: D0-D7, A1-A2
; Dependencies: None (pure math, no external calls)
; ============================================================================

; ---------------------------------------------------------------------------
; angle_normalize ($748C): Full visibility test with flag check
; ---------------------------------------------------------------------------
angle_normalize:
        addi.w  #$4000,d1               ; Normalize D1: add quarter rotation
        andi.w  #$01FF,d1               ; Mask to 0-511
        asl.w   #1,d1                   ; D1 *= 2 (word index)
        ext.l   d1                      ; Sign extend to long
        addi.w  #$4000,d2               ; Normalize D2: add quarter rotation
        andi.w  #$01FF,d2               ; Mask to 0-511
        asl.w   #1,d2                   ; D2 *= 2 (word index)
        ext.l   d2                      ; Sign extend to long
        move.w  (a1)+,d7                ; Read visibility flag word
        bpl.s   .bsp_test               ; If positive, do BSP test
        moveq   #0,d0                   ; Return 0 (not visible)
        rts
.bsp_test:
        movea.l a1,a2                   ; Save data pointer in A2
        moveq   #9,d5                   ; D5 = 9 (shift count for plane eval)
.read_plane:
        move.w  (a1)+,d3                ; Read plane selector word
        moveq   #3,d6                   ; D6 = 3 (bit counter, 4 bits per plane)
.bit_test:
        asl.w   #1,d3                   ; Shift bit 15 into carry
        bcs.s   .d2_coef                ; If set, use D2 as coefficient
        asl.w   #1,d3                   ; Shift bit 14 into carry
        bcs.s   .d1_direct              ; If set, direct compare path
        ; --- D1 coefficient path: result = (D1*coef + const<<9) >> 9 ---
        move.w  d1,d0                   ; D0 = D1
        muls.w  (a1)+,d0               ; D0 *= coefficient
        move.w  (a1)+,d4               ; D4 = constant
        ext.l   d4                      ; Sign extend
        asl.l   d5,d4                   ; D4 <<= 9 (D5=9)
        add.l   d4,d0                   ; D0 += shifted constant
        asr.l   d5,d0                   ; D0 >>= 9 (D5=9)
        cmp.l   d0,d2                   ; Compare D2 with result
        blt.s   .d1_neg                 ; If D2 < result, take negative side
        asl.w   #1,d3                   ; Next selector bit
        bcs.s   .found                  ; If set, found visible boundary
        bra.s   .next_bit               ; Continue testing
.d1_neg:
        asl.w   #1,d3                   ; Next selector bit
        bcc.s   .found                  ; If clear, found visible boundary
        bra.s   .next_bit               ; Continue testing
        ; --- D1 direct compare path ---
.d1_direct:
        cmp.w   (a1),d1                 ; Compare D1 with plane value
        blt.s   .d1_dir_neg             ; If D1 < value, negative side
        asl.w   #1,d3                   ; Next selector bit
        bcc.s   .found                  ; If clear, found
        bra.s   .next_plane_skip        ; Skip unread data, continue
.d1_dir_neg:
        asl.w   #1,d3                   ; Next selector bit
        bcs.s   .found                  ; If set, found
        bra.s   .next_plane_skip        ; Skip unread data, continue
        ; --- D2 coefficient path ---
.d2_coef:
        asl.w   #1,d3                   ; Shift bit 14 into carry
        bcs.s   .d2_direct              ; If set, direct compare with D2
        move.w  d2,d0                   ; D0 = D2
        muls.w  (a1)+,d0               ; D0 *= coefficient
        move.w  (a1)+,d4               ; D4 = constant
        ext.l   d4                      ; Sign extend
        asl.l   d5,d4                   ; D4 <<= 9
        add.l   d4,d0                   ; D0 += shifted constant
        asr.l   d5,d0                   ; D0 >>= 9
        cmp.l   d0,d1                   ; Compare D1 with result
        blt.s   .d2_neg                 ; If D1 < result, negative side
        asl.w   #1,d3                   ; Next selector bit
        bcc.s   .found                  ; If clear, found
        bra.s   .next_bit               ; Continue testing
.d2_neg:
        asl.w   #1,d3                   ; Next selector bit
        bcs.s   .found                  ; If set, found
        bra.s   .next_bit               ; Continue testing
        ; --- D2 direct compare path ---
.d2_direct:
        cmp.w   (a1),d2                 ; Compare D2 with plane value
        blt.s   .d2_dir_neg             ; If D2 < value, negative side
        asl.w   #1,d3                   ; Next selector bit
        bcs.s   .found                  ; If set, found
        bra.s   .next_plane_skip        ; Skip data, next plane entry
.d2_dir_neg:
        asl.w   #1,d3                   ; Next selector bit
        bcc.s   .found                  ; If clear, found
.next_plane_skip:
        addq.l  #4,a1                   ; Skip 4 bytes of unread plane data
.next_bit:
        dbra    d6,.bit_test            ; Loop through 4 bits per plane
        ; All bits tested, polygon visible
        moveq   #1,d0                   ; Return 1 (visible)
        bra.s   .return                 ; Jump to return
.found:
        adda.l  #$0000001C,a2           ; Advance A2 past plane group (28 bytes)
        movea.l a2,a1                   ; Restore A1 from advanced A2
        dbra    d7,.read_plane          ; Continue outer loop
        ; Outer loop exhausted
        moveq   #0,d0                   ; Return 0 (culled)
.return:
        rts

; ---------------------------------------------------------------------------
; angle_normalize_alt ($7534): BSP test without flag check, no outer loop
; ---------------------------------------------------------------------------
angle_normalize_alt:
        addi.w  #$4000,d1               ; Normalize D1: add quarter rotation
        andi.w  #$01FF,d1               ; Mask to 0-511
        asl.w   #1,d1                   ; D1 *= 2 (word index)
        ext.l   d1                      ; Sign extend to long
        addi.w  #$4000,d2               ; Normalize D2: add quarter rotation
        andi.w  #$01FF,d2               ; Mask to 0-511
        asl.w   #1,d2                   ; D2 *= 2 (word index)
        ext.l   d2                      ; Sign extend to long
        movea.l a1,a2                   ; Save data pointer in A2
        moveq   #9,d5                   ; D5 = 9 (shift count)
.alt_read_plane:
        move.w  (a1)+,d3                ; Read plane selector word
        moveq   #3,d6                   ; D6 = 3 (bit counter)
.alt_bit_test:
        asl.w   #1,d3                   ; Shift bit 15 into carry
        bcs.s   .alt_d2_coef            ; If set, use D2 as coefficient
        asl.w   #1,d3                   ; Shift bit 14 into carry
        bcs.s   .alt_d1_direct          ; If set, direct compare
        ; --- D1 coefficient path ---
        move.w  d1,d0                   ; D0 = D1
        muls.w  (a1)+,d0               ; D0 *= coefficient
        move.w  (a1)+,d4               ; D4 = constant
        ext.l   d4                      ; Sign extend
        asl.l   d5,d4                   ; D4 <<= 9
        add.l   d4,d0                   ; D0 += shifted constant
        asr.l   d5,d0                   ; D0 >>= 9
        cmp.l   d0,d2                   ; Compare D2 with result
        blt.s   .alt_d1_neg             ; If D2 < result
        asl.w   #1,d3                   ; Next selector bit
        bcs.s   .alt_found              ; If set, found
        bra.s   .alt_next_bit           ; Continue
.alt_d1_neg:
        asl.w   #1,d3                   ; Next selector bit
        bcc.s   .alt_found              ; If clear, found
        bra.s   .alt_next_bit           ; Continue
        ; --- D1 direct compare ---
.alt_d1_direct:
        cmp.w   (a1),d1                 ; Compare D1 with value
        blt.s   .alt_d1_dir_neg         ; If less
        asl.w   #1,d3                   ; Next bit
        bcc.s   .alt_found              ; If clear, found
        bra.s   .alt_next_plane_skip    ; Skip, continue
.alt_d1_dir_neg:
        asl.w   #1,d3                   ; Next bit
        bcs.s   .alt_found              ; If set, found
        bra.s   .alt_next_plane_skip    ; Skip, continue
        ; --- D2 coefficient path ---
.alt_d2_coef:
        asl.w   #1,d3                   ; Shift bit 14 into carry
        bcs.s   .alt_d2_direct          ; If set, direct compare
        move.w  d2,d0                   ; D0 = D2
        muls.w  (a1)+,d0               ; D0 *= coefficient
        move.w  (a1)+,d4               ; D4 = constant
        ext.l   d4                      ; Sign extend
        asl.l   d5,d4                   ; D4 <<= 9
        add.l   d4,d0                   ; D0 += shifted constant
        asr.l   d5,d0                   ; D0 >>= 9
        cmp.l   d0,d1                   ; Compare D1 with result
        blt.s   .alt_d2_neg             ; If D1 < result
        asl.w   #1,d3                   ; Next selector bit
        bcc.s   .alt_found              ; If clear, found
        bra.s   .alt_next_bit           ; Continue
.alt_d2_neg:
        asl.w   #1,d3                   ; Next selector bit
        bcs.s   .alt_found              ; If set, found
        bra.s   .alt_next_bit           ; Continue
        ; --- D2 direct compare ---
.alt_d2_direct:
        cmp.w   (a1),d2                 ; Compare D2 with value
        blt.s   .alt_d2_dir_neg         ; If less
        asl.w   #1,d3                   ; Next bit
        bcs.s   .alt_found              ; If set, found
        bra.s   .alt_next_plane_skip    ; Skip, next
.alt_d2_dir_neg:
        asl.w   #1,d3                   ; Next bit
        bcc.s   .alt_found              ; If clear, found
.alt_next_plane_skip:
        addq.l  #4,a1                   ; Skip 4 bytes unread data
.alt_next_bit:
        dbra    d6,.alt_bit_test        ; Loop 4 bits per plane
        ; All bits tested, visible
        moveq   #1,d0                   ; Return 1 (visible)
        bra.s   .alt_return             ; Skip to return
.alt_found:
        moveq   #0,d0                   ; Return 0 (culled)
.alt_return:
        rts
